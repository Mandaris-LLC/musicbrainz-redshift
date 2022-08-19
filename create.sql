BEGIN;

CREATE SCHEMA musicbrainz;

CREATE TABLE musicbrainz.alternative_release ( -- replicate
    id                      BIGINT NOT NULL, -- PK
    gid                     CHAR(36) NOT NULL,
    release                 INTEGER NOT NULL, -- references release.id
    name                    VARCHAR,
    artist_credit           INTEGER, -- references artist_credit.id
    type                    INTEGER NOT NULL, -- references alternative_release_type.id
    language                INTEGER NOT NULL, -- references language.id
    script                  INTEGER NOT NULL, -- references script.id
    comment                 VARCHAR(255) NOT NULL DEFAULT ''
    
);

CREATE TABLE musicbrainz.alternative_release_type ( -- replicate
    id                  BIGINT NOT NULL, -- PK
    name                TEXT NOT NULL,
    parent              INTEGER, -- references alternative_release_type.id
    child_order         INTEGER NOT NULL DEFAULT 0,
    description         TEXT,
    gid                 CHAR(36) NOT NULL
);

CREATE TABLE musicbrainz.alternative_medium ( -- replicate
    id                      BIGINT NOT NULL, -- PK
    medium                  INTEGER NOT NULL, -- FK, references medium.id
    alternative_release     INTEGER NOT NULL, -- references alternative_release.id
    name                    VARCHAR
    
);

CREATE TABLE musicbrainz.alternative_track ( -- replicate
    id                      BIGINT NOT NULL, -- PK
    name                    VARCHAR,
    artist_credit           INTEGER, -- references artist_credit.id
    ref_count               INTEGER NOT NULL DEFAULT 0
    
);

CREATE TABLE musicbrainz.alternative_medium_track ( -- replicate
    alternative_medium      INTEGER NOT NULL, -- PK, references alternative_medium.id
    track                   INTEGER NOT NULL, -- PK, references track.id
    alternative_track       INTEGER NOT NULL -- references alternative_track.id
);

CREATE TABLE musicbrainz.annotation ( -- replicate (verbose)
    id                  BIGINT NOT NULL,
    editor              INTEGER NOT NULL, -- references editor.id
    text                TEXT,
    changelog           VARCHAR(255),
    created             TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE musicbrainz.application
(
    id                  BIGINT NOT NULL,
    owner               INTEGER NOT NULL, -- references editor.id
    name                TEXT NOT NULL,
    oauth_id            TEXT NOT NULL,
    oauth_secret        TEXT NOT NULL,
    oauth_redirect_uri  TEXT
);

CREATE TABLE musicbrainz.area_type ( -- replicate
    id                  BIGINT NOT NULL, -- PK
    name                VARCHAR(255) NOT NULL,
    parent              INTEGER, -- references area_type.id
    child_order         INTEGER NOT NULL DEFAULT 0,
    description         TEXT,
    gid                 CHAR(36) NOT NULL
);

CREATE TABLE musicbrainz.area ( -- replicate (verbose)
    id                  BIGINT NOT NULL, -- PK
    gid                 CHAR(36) NOT NULL,
    name                VARCHAR(10000) NOT NULL,
    type                INTEGER, -- references area_type.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    begin_date_year     INTEGER,
    begin_date_month    INTEGER,
    begin_date_day      INTEGER,
    end_date_year       INTEGER,
    end_date_month      INTEGER,
    end_date_day        INTEGER,
    ended               BOOLEAN NOT NULL DEFAULT FALSE,
    comment             VARCHAR(2550) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.area_gid_redirect ( -- replicate (verbose)
    gid                 CHAR(36) NOT NULL, -- PK
    new_id              INTEGER NOT NULL, -- references area.id
    created             TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE musicbrainz.area_alias_type ( -- replicate
    id                  BIGINT NOT NULL, -- PK,
    name                TEXT NOT NULL,
    parent              INTEGER, -- references area_alias_type.id
    child_order         INTEGER NOT NULL DEFAULT 0,
    description         TEXT,
    gid                 CHAR(36) NOT NULL
);

CREATE TABLE musicbrainz.area_alias ( -- replicate (verbose)
    id                  BIGINT NOT NULL, --PK
    area                INTEGER NOT NULL, -- references area.id
    name                VARCHAR(10000) NOT NULL,
    locale              TEXT,
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    type                INTEGER, -- references area_alias_type.id
    sort_name           VARCHAR(10000) NOT NULL,
    begin_date_year     INTEGER,
    begin_date_month    INTEGER,
    begin_date_day      INTEGER,
    end_date_year       INTEGER,
    end_date_month      INTEGER,
    end_date_day        INTEGER,
    primary_for_locale  BOOLEAN NOT NULL DEFAULT false,
    ended               BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE musicbrainz.area_annotation ( -- replicate (verbose)
    area        INTEGER NOT NULL, -- PK, references area.id
    annotation  INTEGER NOT NULL -- PK, references annotation.id
);

CREATE TABLE musicbrainz.area_attribute_type ( -- replicate (verbose)
    id                  BIGINT NOT NULL,  -- PK
    name                VARCHAR(255) NOT NULL,
    comment             VARCHAR(2550) NOT NULL DEFAULT '',
    free_text           BOOLEAN NOT NULL,
    parent              INTEGER, -- references area_attribute_type.id
    child_order         INTEGER NOT NULL DEFAULT 0,
    description         TEXT,
    gid                 CHAR(36) NOT NULL
);

CREATE TABLE musicbrainz.area_attribute_type_allowed_value ( -- replicate (verbose)
    id                  BIGINT NOT NULL,  -- PK
    area_attribute_type INTEGER NOT NULL, -- references area_attribute_type.id
    value               TEXT,
    parent              INTEGER, -- references area_attribute_type_allowed_value.id
    child_order         INTEGER NOT NULL DEFAULT 0,
    description         TEXT,
    gid                 CHAR(36) NOT NULL
);

CREATE TABLE musicbrainz.area_attribute ( -- replicate (verbose)
    id                                  BIGINT NOT NULL,  -- PK
    area                                INTEGER NOT NULL, -- references area.id
    area_attribute_type                 INTEGER NOT NULL, -- references area_attribute_type.id
    area_attribute_type_allowed_value   INTEGER, -- references area_attribute_type_allowed_value.id
    area_attribute_text                 TEXT
);

CREATE TABLE musicbrainz.area_containment (
    descendant          INTEGER NOT NULL, -- PK, references area.id
    parent              INTEGER NOT NULL, -- PK, references area.id
    depth               INTEGER NOT NULL
);

CREATE TABLE musicbrainz.area_tag ( -- replicate (verbose)
    area                INTEGER NOT NULL, -- PK, references area.id
    "tag"                 INTEGER NOT NULL, -- PK, references "tag".id
    count               INTEGER NOT NULL,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE musicbrainz.area_tag_raw (
    area                INTEGER NOT NULL, -- PK, references area.id
    editor              INTEGER NOT NULL, -- PK, references editor.id
    "tag"                 INTEGER NOT NULL, -- PK, references "tag".id
    is_upvote           BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE musicbrainz.artist ( -- replicate (verbose)
    id                  BIGINT NOT NULL,
    gid                 CHAR(36) NOT NULL,
    name                VARCHAR(10000) NOT NULL,
    sort_name           VARCHAR(10000) NOT NULL,
    begin_date_year     INTEGER,
    begin_date_month    INTEGER,
    begin_date_day      INTEGER,
    end_date_year       INTEGER,
    end_date_month      INTEGER,
    end_date_day        INTEGER,
    type                INTEGER, -- references artist_type.id
    area                INTEGER, -- references area.id
    gender              INTEGER, -- references gender.id
    comment             VARCHAR(2550) NOT NULL DEFAULT '',
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    ended               BOOLEAN NOT NULL DEFAULT FALSE,
    begin_area          INTEGER, -- references area.id
    end_area            INTEGER -- references area.id
);

CREATE TABLE musicbrainz.artist_alias_type ( -- replicate
    id                  BIGINT NOT NULL,
    name                TEXT NOT NULL,
    parent              INTEGER, -- references artist_alias_type.id
    child_order         INTEGER NOT NULL DEFAULT 0,
    description         TEXT,
    gid                 CHAR(36) NOT NULL
);

CREATE TABLE musicbrainz.artist_alias ( -- replicate (verbose)
    id                  BIGINT NOT NULL,
    artist              INTEGER NOT NULL, -- references artist.id
    name                VARCHAR(10000) NOT NULL,
    locale              TEXT,
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    type                INTEGER, -- references artist_alias_type.id
    sort_name           VARCHAR(10000) NOT NULL,
    begin_date_year     INTEGER,
    begin_date_month    INTEGER,
    begin_date_day      INTEGER,
    end_date_year       INTEGER,
    end_date_month      INTEGER,
    end_date_day        INTEGER,
    primary_for_locale  BOOLEAN NOT NULL DEFAULT false,
    ended               BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE musicbrainz.artist_annotation ( -- replicate (verbose)
    artist              INTEGER NOT NULL, -- PK, references artist.id
    annotation          INTEGER NOT NULL -- PK, references annotation.id
);

CREATE TABLE musicbrainz.artist_attribute_type ( -- replicate (verbose)
    id                  BIGINT NOT NULL,  -- PK
    name                VARCHAR(255) NOT NULL,
    comment             VARCHAR(2550) NOT NULL DEFAULT '',
    free_text           BOOLEAN NOT NULL,
    parent              INTEGER, -- references artist_attribute_type.id
    child_order         INTEGER NOT NULL DEFAULT 0,
    description         TEXT,
    gid                 CHAR(36) NOT NULL
);

CREATE TABLE musicbrainz.artist_attribute_type_allowed_value ( -- replicate (verbose)
    id                          BIGINT NOT NULL,  -- PK
    artist_attribute_type       INTEGER NOT NULL, -- references artist_attribute_type.id
    value                       TEXT,
    parent                      INTEGER, -- references artist_attribute_type_allowed_value.id
    child_order                 INTEGER NOT NULL DEFAULT 0,
    description                 TEXT,
    gid                         CHAR(36) NOT NULL
);

CREATE TABLE musicbrainz.artist_attribute ( -- replicate (verbose)
    id                                  BIGINT NOT NULL,  -- PK
    artist                              INTEGER NOT NULL, -- references artist.id
    artist_attribute_type               INTEGER NOT NULL, -- references artist_attribute_type.id
    artist_attribute_type_allowed_value INTEGER, -- references artist_attribute_type_allowed_value.id
    artist_attribute_text               TEXT
);

CREATE TABLE musicbrainz.artist_ipi ( -- replicate (verbose)
    artist              INTEGER NOT NULL, -- PK, references artist.id
    ipi                 CHAR(11) NOT NULL , -- PK
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    created             TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE musicbrainz.artist_isni ( -- replicate (verbose)
    artist              INTEGER NOT NULL, -- PK, references artist.id
    isni                CHAR(16) NOT NULL , -- PK
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    created             TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE musicbrainz.artist_meta ( -- replicate
    id                  INTEGER NOT NULL, -- PK, references artist.id CASCADE
    rating              INTEGER ,
    rating_count        INTEGER
);

CREATE TABLE musicbrainz.artist_tag ( -- replicate (verbose)
    artist              INTEGER NOT NULL, -- PK, references artist.id
    "tag"                 INTEGER NOT NULL, -- PK, references "tag".id
    count               INTEGER NOT NULL,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE musicbrainz.artist_rating_raw
(
    artist              INTEGER NOT NULL, -- PK, references artist.id
    editor              INTEGER NOT NULL, -- PK, references editor.id
    rating              INTEGER NOT NULL 
);

CREATE TABLE musicbrainz.artist_tag_raw
(
    artist              INTEGER NOT NULL, -- PK, references artist.id
    editor              INTEGER NOT NULL, -- PK, references editor.id
    "tag"                 INTEGER NOT NULL, -- PK, references "tag".id
    is_upvote           BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE musicbrainz.artist_credit ( -- replicate
    id                  BIGINT NOT NULL,
    name                VARCHAR(10000) NOT NULL,
    artist_count        INTEGER NOT NULL,
    ref_count           INTEGER DEFAULT 0,
    created             TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    gid                 CHAR(36) NOT NULL
);

CREATE TABLE musicbrainz.artist_credit_gid_redirect ( -- replicate (verbose)
    gid                 CHAR(36) NOT NULL, -- PK
    new_id              INTEGER NOT NULL, -- references artist_credit.id
    created             TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE musicbrainz.artist_credit_name ( -- replicate (verbose)
    artist_credit       INTEGER NOT NULL, -- PK, references artist_credit.id CASCADE
    position            INTEGER NOT NULL, -- PK
    artist              INTEGER NOT NULL, -- references artist.id CASCADE
    name                VARCHAR(10000) NOT NULL,
    join_phrase         TEXT NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.artist_gid_redirect ( -- replicate (verbose)
    gid                 CHAR(36) NOT NULL, -- PK
    new_id              INTEGER NOT NULL, -- references artist.id
    created             TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE musicbrainz.artist_type ( -- replicate
    id                  BIGINT NOT NULL,
    name                VARCHAR(255) NOT NULL,
    parent              INTEGER, -- references artist_type.id
    child_order         INTEGER NOT NULL DEFAULT 0,
    description         TEXT,
    gid                 CHAR(36) NOT NULL
);

CREATE TABLE musicbrainz.artist_release (
    -- `is_track_artist` is TRUE only if the artist came from a track
    -- AC and does not also appear in the release AC. Track artists
    -- that appear in the release AC are not stored.
    is_track_artist                     BOOLEAN NOT NULL,
    artist                              INTEGER NOT NULL, -- references artist.id, CASCADE
    first_release_date                  INTEGER,
    catalog_numbers                     VARCHAR(500),
    country_code                        CHAR(2),
    barcode                             BIGINT,
    -- Prior to adding these materialized tables, we'd order releases
    -- by name only if all other attributes where equal. It's not too
    -- common that an artist will have tons of releases with no dates,
    -- catalog numbers, countries, or barcodes (though it can be seen
    -- on some big composers). As a compromise between dropping the
    -- name sorting and having to store the entire name here (which,
    -- as a reminder, is duplicated for every artist on the release),
    -- we only store the first character of the name for sorting.
    sort_character                      CHAR(1) COLLATE musicbrainz NOT NULL,
    release                             INTEGER NOT NULL -- references release.id, CASCADE
);


-- The set of triggers keeping the `artist_release` table up-to-date
-- don't update the table directly. The query to do that for a particular
-- release can be moderately heavy if there are a lot of tracks, so it
-- would degrade performance if identical updates to the same release
-- were triggered many times in the same transaction (which is very
-- easy to trigger when adding, editing, or removing tracks). The
-- strategy we use is to instead push release IDs that need updating
-- to the `artist_release_pending_update` table, and perform the
-- actual updates in a DEFERRED trigger at the end of the transaction.
-- (For where this happens, see the apply_*_pending_updates functions.)
CREATE TABLE musicbrainz.artist_release_pending_update (
    release INTEGER NOT NULL
);

CREATE TABLE musicbrainz.artist_release_group (
    -- See comment for `artist_release.is_track_artist`.
    is_track_artist                     BOOLEAN NOT NULL,
    artist                              INTEGER NOT NULL, -- references artist.id, CASCADE
    unofficial                          BOOLEAN NOT NULL,
    primary_type                        INTEGER,
    secondary_types                     VARCHAR(20),
    first_release_date                  INTEGER,
    -- See comment for `artist_release.sort_character`.
    sort_character                      CHAR(1) COLLATE musicbrainz NOT NULL,
    release_group                       INTEGER NOT NULL -- references release_group.id, CASCADE
);

-- Please see the comment above `artist_release_pending_update`
-- (the same idea applies).
CREATE TABLE musicbrainz.artist_release_group_pending_update (
    release_group INTEGER NOT NULL
);

CREATE TABLE musicbrainz.autoeditor_election
(
    id                  BIGINT NOT NULL,
    candidate           INTEGER NOT NULL, -- references editor.id
    proposer            INTEGER NOT NULL, -- references editor.id
    seconder_1          INTEGER, -- references editor.id
    seconder_2          INTEGER, -- references editor.id
    status              INTEGER NOT NULL DEFAULT 1
                            ,
                            -- 1 : has proposer
                            -- 2 : has seconder_1
                            -- 3 : has seconder_2 (voting open)
                            -- 4 : accepted!
                            -- 5 : rejected
                            -- 6 : cancelled (by proposer)
    yes_votes           INTEGER NOT NULL DEFAULT 0,
    no_votes            INTEGER NOT NULL DEFAULT 0,
    propose_time        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    open_time           TIMESTAMP WITH TIME ZONE,
    close_time          TIMESTAMP WITH TIME ZONE
);

CREATE TABLE musicbrainz.autoeditor_election_vote
(
    id                  BIGINT NOT NULL,
    autoeditor_election INTEGER NOT NULL, -- references autoeditor_election.id
    voter               INTEGER NOT NULL, -- references editor.id
    vote                INTEGER NOT NULL ,
    vote_time           TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
);

CREATE TABLE musicbrainz.cdtoc ( -- replicate
    id                  BIGINT NOT NULL,
    discid              CHAR(28) NOT NULL,
    freedb_id           CHAR(8) NOT NULL,
    track_count         INTEGER NOT NULL,
    leadout_offset      INTEGER NOT NULL,
    track_offset        VARCHAR(20000) NOT NULL,
    degraded            BOOLEAN NOT NULL DEFAULT FALSE,
    created             TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE musicbrainz.cdtoc_raw ( -- replicate
    id                  BIGINT NOT NULL, -- PK
    release             INTEGER NOT NULL, -- references release_raw.id
    discid              CHAR(28) NOT NULL,
    track_count          INTEGER NOT NULL,
    leadout_offset       INTEGER NOT NULL,
    track_offset         VARCHAR(20000) NOT NULL
);

CREATE TABLE musicbrainz.country_area ( -- replicate (verbose)
    area                INTEGER -- PK, references area.id
);

CREATE TABLE musicbrainz.deleted_entity (
    gid CHAR(36) NOT NULL, -- PK
    data VARCHAR(1000) NOT NULL,
    deleted_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE musicbrainz.edit
(
    id                  BIGINT NOT NULL,
    editor              INTEGER NOT NULL, -- references editor.id
    type                INTEGER NOT NULL,
    status              INTEGER NOT NULL,
    autoedit            INTEGER NOT NULL DEFAULT 0,
    open_time            TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    close_time           TIMESTAMP WITH TIME ZONE,
    expire_time          TIMESTAMP WITH TIME ZONE NOT NULL,
    language            INTEGER, -- references language.id
    quality             INTEGER NOT NULL DEFAULT 1
);

CREATE TABLE musicbrainz.edit_data
(
    edit                INTEGER NOT NULL, -- PK, references edit.id
    data                 VARCHAR(1000) NOT NULL
);

CREATE TABLE musicbrainz.edit_note
(
    id                  BIGINT NOT NULL,
    editor              INTEGER NOT NULL, -- references editor.id
    edit                INTEGER NOT NULL, -- references edit.id
    text                TEXT NOT NULL,
    post_time            TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE musicbrainz.edit_note_recipient (
    recipient           INTEGER NOT NULL, -- PK, references editor.id
    edit_note           INTEGER NOT NULL  -- PK, references edit_note.id
);

CREATE TABLE musicbrainz.edit_area
(
    edit                INTEGER NOT NULL, -- PK, references edit.id
    area                INTEGER NOT NULL  -- PK, references area.id CASCADE
);

CREATE TABLE musicbrainz.edit_artist
(
    edit                INTEGER NOT NULL, -- PK, references edit.id
    artist              INTEGER NOT NULL, -- PK, references artist.id CASCADE
    status              INTEGER NOT NULL -- materialized from edit.status
);

CREATE TABLE musicbrainz.edit_event
(
    edit                INTEGER NOT NULL, -- PK, references edit.id
    event               INTEGER NOT NULL  -- PK, references event.id CASCADE
);

CREATE TABLE musicbrainz.edit_genre
(
    edit                INTEGER NOT NULL, -- PK, references edit.id
    genre               INTEGER NOT NULL  -- PK, references genre.id CASCADE
);

CREATE TABLE musicbrainz.edit_instrument
(
    edit                INTEGER NOT NULL, -- PK, references edit.id
    instrument          INTEGER NOT NULL  -- PK, references instrument.id CASCADE
);

CREATE TABLE musicbrainz.edit_label
(
    edit                INTEGER NOT NULL, -- PK, references edit.id
    label               INTEGER NOT NULL, -- PK, references label.id CASCADE
    status              INTEGER NOT NULL -- materialized from edit.status
);

CREATE TABLE musicbrainz.edit_mood
(
    edit                INTEGER NOT NULL, -- PK, references edit.id
    mood                INTEGER NOT NULL  -- PK, references mood.id CASCADE
);

CREATE TABLE musicbrainz.edit_place
(
    edit                INTEGER NOT NULL, -- PK, references edit.id
    place               INTEGER NOT NULL  -- PK, references place.id CASCADE
);

CREATE TABLE musicbrainz.edit_release
(
    edit                INTEGER NOT NULL, -- PK, references edit.id
    release             INTEGER NOT NULL  -- PK, references release.id CASCADE
);

CREATE TABLE musicbrainz.edit_release_group
(
    edit                INTEGER NOT NULL, -- PK, references edit.id
    release_group       INTEGER NOT NULL  -- PK, references release_group.id CASCADE
);

CREATE TABLE musicbrainz.edit_recording
(
    edit                INTEGER NOT NULL, -- PK, references edit.id
    recording           INTEGER NOT NULL  -- PK, references recording.id CASCADE
);

CREATE TABLE musicbrainz.edit_series
(
    edit                INTEGER NOT NULL, -- PK, references edit.id
    series              INTEGER NOT NULL  -- PK, references series.id CASCADE
);

CREATE TABLE musicbrainz.edit_work
(
    edit                INTEGER NOT NULL, -- PK, references edit.id
    work                INTEGER NOT NULL  -- PK, references work.id CASCADE
);

CREATE TABLE musicbrainz.edit_url
(
    edit                INTEGER NOT NULL, -- PK, references edit.id
    url                 INTEGER NOT NULL  -- PK, references url.id CASCADE
);

CREATE TABLE musicbrainz.editor
(
    id                  BIGINT NOT NULL,
    name                VARCHAR(64) NOT NULL,
    privs               INTEGER DEFAULT 0,
    email               VARCHAR(64) DEFAULT NULL,
    website             VARCHAR(255) DEFAULT NULL,
    bio                 TEXT DEFAULT NULL,
    member_since        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    email_confirm_date  TIMESTAMP WITH TIME ZONE,
    last_login_date     TIMESTAMP WITH TIME ZONE DEFAULT now(),
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    birth_date          DATE,
    gender              INTEGER, -- references gender.id
    area                INTEGER, -- references area.id
    password            VARCHAR(128) NOT NULL,
    ha1                 CHAR(32) NOT NULL,
    deleted             BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE musicbrainz.old_editor_name (
    name    VARCHAR(64) NOT NULL
);

CREATE TABLE musicbrainz.editor_language (
    editor   INTEGER NOT NULL,  -- PK, references editor.id
    language INTEGER NOT NULL,  -- PK, references language.id
    fluency  VARCHAR(100) NOT NULL
);

CREATE TABLE musicbrainz.editor_preference
(
    id                  BIGINT NOT NULL,
    editor              INTEGER NOT NULL, -- references editor.id
    name                VARCHAR(50) NOT NULL,
    value               VARCHAR(100) NOT NULL
);

CREATE TABLE musicbrainz.editor_subscribe_artist
(
    id                  BIGINT NOT NULL,
    editor              INTEGER NOT NULL, -- references editor.id
    artist              INTEGER NOT NULL, -- references artist.id
    last_edit_sent      INTEGER NOT NULL -- references edit.id
);

CREATE TABLE musicbrainz.editor_subscribe_artist_deleted
(
    editor INTEGER NOT NULL, -- PK, references editor.id
    gid CHAR(36) NOT NULL, -- PK, references deleted_entity.gid
    deleted_by INTEGER NOT NULL -- references edit.id
);

CREATE TABLE musicbrainz.editor_subscribe_collection
(
    id                  BIGINT NOT NULL,
    editor              INTEGER NOT NULL,              -- references editor.id
    collection          INTEGER NOT NULL,              -- weakly references editor_collection.id
    last_edit_sent      INTEGER NOT NULL,              -- weakly references edit.id
    available           BOOLEAN NOT NULL DEFAULT TRUE,
    last_seen_name      VARCHAR(255)
);

CREATE TABLE musicbrainz.editor_subscribe_label
(
    id                  BIGINT NOT NULL,
    editor              INTEGER NOT NULL, -- references editor.id
    label               INTEGER NOT NULL, -- references label.id
    last_edit_sent      INTEGER NOT NULL -- references edit.id
);

CREATE TABLE musicbrainz.editor_subscribe_label_deleted
(
    editor INTEGER NOT NULL, -- PK, references editor.id
    gid CHAR(36) NOT NULL, -- PK, references deleted_entity.gid
    deleted_by INTEGER NOT NULL -- references edit.id
);

CREATE TABLE musicbrainz.editor_subscribe_editor
(
    id                  BIGINT NOT NULL,
    editor              INTEGER NOT NULL, -- references editor.id (the one who has subscribed)
    subscribed_editor   INTEGER NOT NULL, -- references editor.id (the one being subscribed)
    last_edit_sent      INTEGER NOT NULL  -- weakly references edit.id
);

CREATE TABLE musicbrainz.editor_subscribe_series
(
    id                  BIGINT NOT NULL,
    editor              INTEGER NOT NULL, -- references editor.id
    series              INTEGER NOT NULL, -- references series.id
    last_edit_sent      INTEGER NOT NULL -- references edit.id
);

CREATE TABLE musicbrainz.editor_subscribe_series_deleted
(
    editor              INTEGER NOT NULL, -- PK, references editor.id
    gid                 CHAR(36) NOT NULL, -- PK, references deleted_entity.gid
    deleted_by          INTEGER NOT NULL -- references edit.id
);

CREATE TABLE musicbrainz.event ( -- replicate (verbose)
    id                  BIGINT NOT NULL,
    gid                 CHAR(36) NOT NULL,
    name                VARCHAR(10000) NOT NULL,
    begin_date_year     INTEGER,
    begin_date_month    INTEGER,
    begin_date_day      INTEGER,
    end_date_year       INTEGER,
    end_date_month      INTEGER,
    end_date_day        INTEGER,
    time                TIME WITHOUT TIME ZONE,
    type                INTEGER, -- references event_type.id
    cancelled           BOOLEAN NOT NULL DEFAULT FALSE,
    setlist             VARCHAR(25500),
    comment             VARCHAR(2550) NOT NULL DEFAULT '',
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    ended               BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE musicbrainz.event_meta ( -- replicate
    id                  INTEGER NOT NULL, -- PK, references event.id CASCADE
    rating              INTEGER ,
    rating_count        INTEGER,
    event_art_presence  VARCHAR(1000) NOT NULL DEFAULT 'absent'
);

CREATE TABLE musicbrainz.event_rating_raw (
    event               INTEGER NOT NULL, -- PK, references event.id
    editor              INTEGER NOT NULL, -- PK, references editor.id
    rating              INTEGER NOT NULL 
);

CREATE TABLE musicbrainz.event_tag_raw (
    event               INTEGER NOT NULL, -- PK, references event.id
    editor              INTEGER NOT NULL, -- PK, references editor.id
    "tag"                 INTEGER NOT NULL, -- PK, references "tag".id
    is_upvote           BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE musicbrainz.event_alias_type ( -- replicate
    id                  BIGINT NOT NULL,
    name                TEXT NOT NULL,
    parent              INTEGER, -- references event_alias_type.id
    child_order         INTEGER NOT NULL DEFAULT 0,
    description         TEXT,
    gid                 CHAR(36) NOT NULL
);

CREATE TABLE musicbrainz.event_alias ( -- replicate (verbose)
    id                  BIGINT NOT NULL,
    event               INTEGER NOT NULL, -- references event.id
    name                VARCHAR(10000) NOT NULL,
    locale              TEXT,
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    type                INTEGER, -- references event_alias_type.id
    sort_name           VARCHAR(10000) NOT NULL,
    begin_date_year     INTEGER,
    begin_date_month    INTEGER,
    begin_date_day      INTEGER,
    end_date_year       INTEGER,
    end_date_month      INTEGER,
    end_date_day        INTEGER,
    primary_for_locale  BOOLEAN NOT NULL DEFAULT false,
    ended               BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE musicbrainz.event_annotation ( -- replicate (verbose)
    event               INTEGER NOT NULL, -- PK, references event.id
    annotation          INTEGER NOT NULL -- PK, references annotation.id
);

CREATE TABLE musicbrainz.event_attribute_type ( -- replicate (verbose)
    id                  BIGINT NOT NULL,  -- PK
    name                VARCHAR(255) NOT NULL,
    comment             VARCHAR(2550) NOT NULL DEFAULT '',
    free_text           BOOLEAN NOT NULL,
    parent              INTEGER, -- references event_attribute_type.id
    child_order         INTEGER NOT NULL DEFAULT 0,
    description         TEXT,
    gid                 CHAR(36) NOT NULL
);

CREATE TABLE musicbrainz.event_attribute_type_allowed_value ( -- replicate (verbose)
    id                          BIGINT NOT NULL,  -- PK
    event_attribute_type        INTEGER NOT NULL, -- references event_attribute_type.id
    value                       TEXT,
    parent                      INTEGER, -- references event_attribute_type_allowed_value.id
    child_order                 INTEGER NOT NULL DEFAULT 0,
    description                 TEXT,
    gid                         CHAR(36) NOT NULL
);

CREATE TABLE musicbrainz.event_attribute ( -- replicate (verbose)
    id                                  BIGINT NOT NULL,  -- PK
    event                               INTEGER NOT NULL, -- references event.id
    event_attribute_type                INTEGER NOT NULL, -- references event_attribute_type.id
    event_attribute_type_allowed_value  INTEGER, -- references event_attribute_type_allowed_value.id
    event_attribute_text                TEXT
);

CREATE TABLE musicbrainz.event_gid_redirect ( -- replicate (verbose)
    gid                 CHAR(36) NOT NULL, -- PK
    new_id              INTEGER NOT NULL, -- references event.id
    created             TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE musicbrainz.event_tag ( -- replicate (verbose)
    event               INTEGER NOT NULL, -- PK, references event.id
    "tag"                 INTEGER NOT NULL, -- PK, references "tag".id
    count               INTEGER NOT NULL,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE musicbrainz.event_type ( -- replicate
    id                  BIGINT NOT NULL,
    name                VARCHAR(255) NOT NULL,
    parent              INTEGER, -- references event_type.id
    child_order         INTEGER NOT NULL DEFAULT 0,
    description         TEXT,
    gid                 CHAR(36) NOT NULL
);

CREATE TABLE musicbrainz.release_first_release_date (
    release     INTEGER NOT NULL, -- PK, references release.id CASCADE
    year        INTEGER,
    month       INTEGER,
    day         INTEGER
);

CREATE TABLE musicbrainz.recording_first_release_date (
    recording   INTEGER NOT NULL, -- PK, references recording.id CASCADE
    year        INTEGER,
    month       INTEGER,
    day         INTEGER
);

CREATE TABLE musicbrainz.gender ( -- replicate
    id                  BIGINT NOT NULL,
    name                VARCHAR(255) NOT NULL,
    parent              INTEGER, -- references gender.id
    child_order         INTEGER NOT NULL DEFAULT 0,
    description         TEXT,
    gid                 CHAR(36) NOT NULL
);

CREATE TABLE musicbrainz.genre ( -- replicate (verbose)
    id                  BIGINT NOT NULL, -- PK
    gid                 CHAR(36) NOT NULL,
    name                VARCHAR(10000) NOT NULL,
    comment             VARCHAR(2550) NOT NULL DEFAULT '',
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE musicbrainz.genre_alias_type ( -- replicate
    id                  BIGINT NOT NULL, -- PK,
    name                TEXT NOT NULL,
    parent              INTEGER, -- references genre_alias_type.id
    child_order         INTEGER NOT NULL DEFAULT 0,
    description         TEXT,
    gid                 CHAR(36) NOT NULL
);

CREATE TABLE musicbrainz.genre_alias ( -- replicate (verbose)
    id                  BIGINT NOT NULL, --PK
    genre               INTEGER NOT NULL, -- references genre.id
    name                VARCHAR(10000) NOT NULL,
    locale              TEXT,
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    type                INTEGER, -- references genre_alias_type.id
    sort_name           VARCHAR(10000) NOT NULL,
    begin_date_year     INTEGER,
    begin_date_month    INTEGER,
    begin_date_day      INTEGER,
    end_date_year       INTEGER,
    end_date_month      INTEGER,
    end_date_day        INTEGER,
    primary_for_locale  BOOLEAN NOT NULL DEFAULT false,
    ended               BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE musicbrainz.genre_annotation ( -- replicate (verbose)
    genre       INTEGER NOT NULL, -- PK, references genre.id
    annotation  INTEGER NOT NULL -- PK, references annotation.id
);

CREATE TABLE musicbrainz.instrument_type ( -- replicate
    id                  BIGINT NOT NULL, -- PK
    name                VARCHAR(255) NOT NULL,
    parent              INTEGER, -- references instrument_type.id
    child_order         INTEGER NOT NULL DEFAULT 0,
    description         TEXT,
    gid                 CHAR(36) NOT NULL
);

CREATE TABLE musicbrainz.instrument ( -- replicate (verbose)
    id                  BIGINT NOT NULL, -- PK
    gid                 CHAR(36) NOT NULL,
    name                VARCHAR(10000) NOT NULL,
    type                INTEGER, -- references instrument_type.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    comment             VARCHAR(2550) NOT NULL DEFAULT '',
    description         VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.instrument_gid_redirect ( -- replicate (verbose)
    gid                 CHAR(36) NOT NULL, -- PK
    new_id              INTEGER NOT NULL, -- references instrument.id
    created             TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE musicbrainz.instrument_alias_type ( -- replicate
    id                  BIGINT NOT NULL, -- PK,
    name                TEXT NOT NULL,
    parent              INTEGER, -- references instrument_alias_type.id
    child_order         INTEGER NOT NULL DEFAULT 0,
    description         TEXT,
    gid                 CHAR(36) NOT NULL
);

CREATE TABLE musicbrainz.instrument_alias ( -- replicate (verbose)
    id                  BIGINT NOT NULL, --PK
    instrument          INTEGER NOT NULL, -- references instrument.id
    name                VARCHAR(10000) NOT NULL,
    locale              TEXT,
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    type                INTEGER, -- references instrument_alias_type.id
    sort_name           VARCHAR(10000) NOT NULL,
    begin_date_year     INTEGER,
    begin_date_month    INTEGER,
    begin_date_day      INTEGER,
    end_date_year       INTEGER,
    end_date_month      INTEGER,
    end_date_day        INTEGER,
    primary_for_locale  BOOLEAN NOT NULL DEFAULT false,
    ended               BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE musicbrainz.instrument_annotation ( -- replicate (verbose)
    instrument  INTEGER NOT NULL, -- PK, references instrument.id
    annotation  INTEGER NOT NULL -- PK, references annotation.id
);

CREATE TABLE musicbrainz.instrument_attribute_type ( -- replicate (verbose)
    id                  BIGINT NOT NULL,  -- PK
    name                VARCHAR(255) NOT NULL,
    comment             VARCHAR(2550) NOT NULL DEFAULT '',
    free_text           BOOLEAN NOT NULL,
    parent              INTEGER, -- references instrument_attribute_type.id
    child_order         INTEGER NOT NULL DEFAULT 0,
    description         TEXT,
    gid                 CHAR(36) NOT NULL
);

CREATE TABLE musicbrainz.instrument_attribute_type_allowed_value ( -- replicate (verbose)
    id                          BIGINT NOT NULL,  -- PK
    instrument_attribute_type   INTEGER NOT NULL, -- references instrument_attribute_type.id
    value                       TEXT,
    parent                      INTEGER, -- references instrument_attribute_type_allowed_value.id
    child_order                 INTEGER NOT NULL DEFAULT 0,
    description                 TEXT,
    gid                         CHAR(36) NOT NULL
);

CREATE TABLE musicbrainz.instrument_attribute ( -- replicate (verbose)
    id                                          BIGINT NOT NULL,  -- PK
    instrument                                  INTEGER NOT NULL, -- references instrument.id
    instrument_attribute_type                   INTEGER NOT NULL, -- references instrument_attribute_type.id
    instrument_attribute_type_allowed_value     INTEGER, -- references instrument_attribute_type_allowed_value.id
    instrument_attribute_text                   TEXT
);

CREATE TABLE musicbrainz.instrument_tag ( -- replicate (verbose)
    instrument          INTEGER NOT NULL, -- PK, references instrument.id
    "tag"                 INTEGER NOT NULL, -- PK, references "tag".id
    count               INTEGER NOT NULL,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE musicbrainz.instrument_tag_raw (
    instrument          INTEGER NOT NULL, -- PK, references instrument.id
    editor              INTEGER NOT NULL, -- PK, references editor.id
    "tag"                 INTEGER NOT NULL, -- PK, references "tag".id
    is_upvote           BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE musicbrainz.iso_3166_1 ( -- replicate
    area      INTEGER NOT NULL, -- references area.id
    code      CHAR(2) -- PK
);
CREATE TABLE musicbrainz.iso_3166_2 ( -- replicate
    area      INTEGER NOT NULL, -- references area.id
    code      VARCHAR(10) -- PK
);
CREATE TABLE musicbrainz.iso_3166_3 ( -- replicate
    area      INTEGER NOT NULL, -- references area.id
    code      CHAR(4) -- PK
);

CREATE TABLE musicbrainz.isrc ( -- replicate (verbose)
    id                  BIGINT NOT NULL,
    recording           INTEGER NOT NULL, -- references recording.id
    isrc                CHAR(12) NOT NULL ,
    source              INTEGER,
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    created             TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE musicbrainz.iswc ( -- replicate (verbose)
    id BIGINT NOT NULL NOT NULL,
    work INTEGER NOT NULL, -- references work.id
    iswc CHARACTER(15) ,
    source INTEGER,
    edits_pending INTEGER NOT NULL DEFAULT 0,
    created TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

CREATE TABLE musicbrainz.l_area_area ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references area.id
    entity1             INTEGER NOT NULL, -- references area.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_area_artist ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references area.id
    entity1             INTEGER NOT NULL, -- references artist.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_area_event ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references area.id
    entity1             INTEGER NOT NULL, -- references event.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_area_genre ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references area.id
    entity1             INTEGER NOT NULL, -- references genre.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_area_instrument ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references area.id
    entity1             INTEGER NOT NULL, -- references instrument.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_area_label ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references area.id
    entity1             INTEGER NOT NULL, -- references label.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_area_mood ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references area.id
    entity1             INTEGER NOT NULL, -- references mood.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_area_place ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references area.id
    entity1             INTEGER NOT NULL, -- references place.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_area_recording ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references area.id
    entity1             INTEGER NOT NULL, -- references recording.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_area_release ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references area.id
    entity1             INTEGER NOT NULL, -- references release.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_area_release_group ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references area.id
    entity1             INTEGER NOT NULL, -- references release_group.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_area_series ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references area.id
    entity1             INTEGER NOT NULL, -- references series.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_area_url ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references area.id
    entity1             INTEGER NOT NULL, -- references url.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_area_work ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references area.id
    entity1             INTEGER NOT NULL, -- references work.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_artist_artist ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references artist.id
    entity1             INTEGER NOT NULL, -- references artist.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_artist_event ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references artist.id
    entity1             INTEGER NOT NULL, -- references event.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_artist_genre ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references artist.id
    entity1             INTEGER NOT NULL, -- references genre.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_artist_instrument ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references artist.id
    entity1             INTEGER NOT NULL, -- references instrument.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_artist_label ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references artist.id
    entity1             INTEGER NOT NULL, -- references label.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_artist_mood ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references artist.id
    entity1             INTEGER NOT NULL, -- references mood.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_artist_place ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references artist.id
    entity1             INTEGER NOT NULL, -- references place.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_artist_recording ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references artist.id
    entity1             INTEGER NOT NULL, -- references recording.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_artist_release ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references artist.id
    entity1             INTEGER NOT NULL, -- references release.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_artist_release_group ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references artist.id
    entity1             INTEGER NOT NULL, -- references release_group.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_artist_series ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references artist.id
    entity1             INTEGER NOT NULL, -- references series.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_artist_url ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references artist.id
    entity1             INTEGER NOT NULL, -- references url.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_artist_work ( -- replicate (verbose)
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references artist.id
    entity1             INTEGER NOT NULL, -- references work.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_event_event ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references event.id
    entity1             INTEGER NOT NULL, -- references event.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_event_genre ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references event.id
    entity1             INTEGER NOT NULL, -- references genre.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_event_instrument ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references event.id
    entity1             INTEGER NOT NULL, -- references instrument.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_event_label ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references event.id
    entity1             INTEGER NOT NULL, -- references label.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_event_mood ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references event.id
    entity1             INTEGER NOT NULL, -- references mood.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_event_place ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references event.id
    entity1             INTEGER NOT NULL, -- references place.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_event_recording ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references event.id
    entity1             INTEGER NOT NULL, -- references recording.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_event_release ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references event.id
    entity1             INTEGER NOT NULL, -- references release.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_event_release_group ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references event.id
    entity1             INTEGER NOT NULL, -- references release_group.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_event_series ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references event.id
    entity1             INTEGER NOT NULL, -- references series.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_event_url ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references event.id
    entity1             INTEGER NOT NULL, -- references url.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_event_work ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references event.id
    entity1             INTEGER NOT NULL, -- references work.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_label_label ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references label.id
    entity1             INTEGER NOT NULL, -- references label.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_genre_genre ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references genre.id
    entity1             INTEGER NOT NULL, -- references genre.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_genre_instrument ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references genre.id
    entity1             INTEGER NOT NULL, -- references instrument.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_genre_label ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references genre.id
    entity1             INTEGER NOT NULL, -- references label.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_genre_mood ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references genre.id
    entity1             INTEGER NOT NULL, -- references mood.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_genre_place ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references genre.id
    entity1             INTEGER NOT NULL, -- references place.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_genre_recording ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references genre.id
    entity1             INTEGER NOT NULL, -- references recording.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_genre_release ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references genre.id
    entity1             INTEGER NOT NULL, -- references release.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_genre_release_group ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references genre.id
    entity1             INTEGER NOT NULL, -- references release_group.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_genre_series ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references genre.id
    entity1             INTEGER NOT NULL, -- references series.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_genre_url ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references genre.id
    entity1             INTEGER NOT NULL, -- references url.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_genre_work ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references genre.id
    entity1             INTEGER NOT NULL, -- references work.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_instrument_instrument ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references instrument.id
    entity1             INTEGER NOT NULL, -- references instrument.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_instrument_label ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references instrument.id
    entity1             INTEGER NOT NULL, -- references label.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_instrument_mood ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references instrument.id
    entity1             INTEGER NOT NULL, -- references mood.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_instrument_place ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references instrument.id
    entity1             INTEGER NOT NULL, -- references place.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_instrument_recording ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references instrument.id
    entity1             INTEGER NOT NULL, -- references recording.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_instrument_release ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references instrument.id
    entity1             INTEGER NOT NULL, -- references release.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_instrument_release_group ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references instrument.id
    entity1             INTEGER NOT NULL, -- references release_group.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_instrument_series ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references instrument.id
    entity1             INTEGER NOT NULL, -- references series.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_instrument_url ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references instrument.id
    entity1             INTEGER NOT NULL, -- references url.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_instrument_work ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references instrument.id
    entity1             INTEGER NOT NULL, -- references work.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_label_mood ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references label.id
    entity1             INTEGER NOT NULL, -- references mood.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_label_place ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references label.id
    entity1             INTEGER NOT NULL, -- references place.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_label_recording ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references label.id
    entity1             INTEGER NOT NULL, -- references recording.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_label_release ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references label.id
    entity1             INTEGER NOT NULL, -- references release.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_label_release_group ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references label.id
    entity1             INTEGER NOT NULL, -- references release_group.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_label_series ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references label.id
    entity1             INTEGER NOT NULL, -- references series.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_label_url ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references label.id
    entity1             INTEGER NOT NULL, -- references url.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_label_work ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references label.id
    entity1             INTEGER NOT NULL, -- references work.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_mood_mood ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references mood.id
    entity1             INTEGER NOT NULL, -- references mood.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_mood_place ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references mood.id
    entity1             INTEGER NOT NULL, -- references place.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_mood_recording ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references mood.id
    entity1             INTEGER NOT NULL, -- references recording.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_mood_release ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references mood.id
    entity1             INTEGER NOT NULL, -- references release.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_mood_release_group ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references mood.id
    entity1             INTEGER NOT NULL, -- references release_group.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_mood_series ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references mood.id
    entity1             INTEGER NOT NULL, -- references series.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_mood_url ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references mood.id
    entity1             INTEGER NOT NULL, -- references url.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_mood_work ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references mood.id
    entity1             INTEGER NOT NULL, -- references work.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_place_place ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references place.id
    entity1             INTEGER NOT NULL, -- references place.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_place_recording ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references place.id
    entity1             INTEGER NOT NULL, -- references recording.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_place_release ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references place.id
    entity1             INTEGER NOT NULL, -- references release.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_place_release_group ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references place.id
    entity1             INTEGER NOT NULL, -- references release_group.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_place_series ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references place.id
    entity1             INTEGER NOT NULL, -- references series.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_place_url ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references place.id
    entity1             INTEGER NOT NULL, -- references url.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_place_work ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references place.id
    entity1             INTEGER NOT NULL, -- references work.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_recording_recording ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references recording.id
    entity1             INTEGER NOT NULL, -- references recording.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_recording_release ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references recording.id
    entity1             INTEGER NOT NULL, -- references release.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_recording_release_group ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references recording.id
    entity1             INTEGER NOT NULL, -- references release_group.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_recording_series ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references recording.id
    entity1             INTEGER NOT NULL, -- references series.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_recording_url ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references recording.id
    entity1             INTEGER NOT NULL, -- references url.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_recording_work ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references recording.id
    entity1             INTEGER NOT NULL, -- references work.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_release_release ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references release.id
    entity1             INTEGER NOT NULL, -- references release.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_release_release_group ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references release.id
    entity1             INTEGER NOT NULL, -- references release_group.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_release_series ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references release.id
    entity1             INTEGER NOT NULL, -- references series.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_release_url ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references release.id
    entity1             INTEGER NOT NULL, -- references url.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_release_work ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references release.id
    entity1             INTEGER NOT NULL, -- references work.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_release_group_release_group ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references release_group.id
    entity1             INTEGER NOT NULL, -- references release_group.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_release_group_series ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references release_group.id
    entity1             INTEGER NOT NULL, -- references series.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_release_group_url ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references release_group.id
    entity1             INTEGER NOT NULL, -- references url.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_release_group_work ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references release_group.id
    entity1             INTEGER NOT NULL, -- references work.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_series_series ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references series.id
    entity1             INTEGER NOT NULL, -- references series.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_series_url ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references series.id
    entity1             INTEGER NOT NULL, -- references url.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_series_work ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references series.id
    entity1             INTEGER NOT NULL, -- references work.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_url_url ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references url.id
    entity1             INTEGER NOT NULL, -- references url.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_url_work ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references url.id
    entity1             INTEGER NOT NULL, -- references work.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.l_work_work ( -- replicate
    id                  BIGINT NOT NULL,
    link                INTEGER NOT NULL, -- references link.id
    entity0             INTEGER NOT NULL, -- references work.id
    entity1             INTEGER NOT NULL, -- references work.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    link_order          INTEGER NOT NULL DEFAULT 0 ,
    entity0_credit      VARCHAR(10000) NOT NULL DEFAULT '',
    entity1_credit      VARCHAR(10000) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.label ( -- replicate (verbose)
    id                  BIGINT NOT NULL,
    gid                 CHAR(36) NOT NULL,
    name                VARCHAR(10000) NOT NULL,
    begin_date_year     INTEGER,
    begin_date_month    INTEGER,
    begin_date_day      INTEGER,
    end_date_year       INTEGER,
    end_date_month      INTEGER,
    end_date_day        INTEGER,
    label_code          INTEGER ,
    type                INTEGER, -- references label_type.id
    area                INTEGER, -- references area.id
    comment             VARCHAR(2550) NOT NULL DEFAULT '',
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    ended               BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE musicbrainz.label_rating_raw
(
    label               INTEGER NOT NULL, -- PK, references label.id
    editor              INTEGER NOT NULL, -- PK, references editor.id
    rating              INTEGER NOT NULL 
);

CREATE TABLE musicbrainz.label_tag_raw
(
    label               INTEGER NOT NULL, -- PK, references label.id
    editor              INTEGER NOT NULL, -- PK, references editor.id
    "tag"                 INTEGER NOT NULL, -- PK, references "tag".id
    is_upvote           BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE musicbrainz.label_alias_type ( -- replicate
    id                  BIGINT NOT NULL,
    name                TEXT NOT NULL,
    parent              INTEGER, -- references label_alias_type.id
    child_order         INTEGER NOT NULL DEFAULT 0,
    description         TEXT,
    gid                 CHAR(36) NOT NULL
);

CREATE TABLE musicbrainz.label_alias ( -- replicate (verbose)
    id                  BIGINT NOT NULL,
    label               INTEGER NOT NULL, -- references label.id
    name                VARCHAR(10000) NOT NULL,
    locale              TEXT,
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    type                INTEGER, -- references label_alias_type.id
    sort_name           VARCHAR(10000) NOT NULL,
    begin_date_year     INTEGER,
    begin_date_month    INTEGER,
    begin_date_day      INTEGER,
    end_date_year       INTEGER,
    end_date_month      INTEGER,
    end_date_day        INTEGER,
    primary_for_locale  BOOLEAN NOT NULL DEFAULT false,
    ended               BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE musicbrainz.label_annotation ( -- replicate (verbose)
    label               INTEGER NOT NULL, -- PK, references label.id
    annotation          INTEGER NOT NULL -- PK, references annotation.id
);

CREATE TABLE musicbrainz.label_attribute_type ( -- replicate (verbose)
    id                  BIGINT NOT NULL,  -- PK
    name                VARCHAR(255) NOT NULL,
    comment             VARCHAR(2550) NOT NULL DEFAULT '',
    free_text           BOOLEAN NOT NULL,
    parent              INTEGER, -- references label_attribute_type.id
    child_order         INTEGER NOT NULL DEFAULT 0,
    description         TEXT,
    gid                 CHAR(36) NOT NULL
);

CREATE TABLE musicbrainz.label_attribute_type_allowed_value ( -- replicate (verbose)
    id                          BIGINT NOT NULL,  -- PK
    label_attribute_type        INTEGER NOT NULL, -- references label_attribute_type.id
    value                       TEXT,
    parent                      INTEGER, -- references label_attribute_type_allowed_value.id
    child_order                 INTEGER NOT NULL DEFAULT 0,
    description                 TEXT,
    gid                         CHAR(36) NOT NULL
);

CREATE TABLE musicbrainz.label_attribute ( -- replicate (verbose)
    id                                  BIGINT NOT NULL,  -- PK
    label                               INTEGER NOT NULL, -- references label.id
    label_attribute_type                INTEGER NOT NULL, -- references label_attribute_type.id
    label_attribute_type_allowed_value  INTEGER, -- references label_attribute_type_allowed_value.id
    label_attribute_text                TEXT
);

CREATE TABLE musicbrainz.label_ipi ( -- replicate (verbose)
    label               INTEGER NOT NULL, -- PK, references label.id
    ipi                 CHAR(11) NOT NULL , -- PK
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    created             TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE musicbrainz.label_isni ( -- replicate (verbose)
    label               INTEGER NOT NULL, -- PK, references label.id
    isni                CHAR(16) NOT NULL , -- PK
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    created             TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE musicbrainz.label_meta ( -- replicate
    id                  INTEGER NOT NULL, -- PK, references label.id CASCADE
    rating              INTEGER ,
    rating_count        INTEGER
);

CREATE TABLE musicbrainz.label_gid_redirect ( -- replicate (verbose)
    gid                 CHAR(36) NOT NULL, -- PK
    new_id              INTEGER NOT NULL, -- references label.id
    created             TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE musicbrainz.label_tag ( -- replicate (verbose)
    label               INTEGER NOT NULL, -- PK, references label.id
    "tag"                 INTEGER NOT NULL, -- PK, references "tag".id
    count               INTEGER NOT NULL,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE musicbrainz.label_type ( -- replicate
    id                  BIGINT NOT NULL,
    name                VARCHAR(255) NOT NULL,
    parent              INTEGER, -- references label_type.id
    child_order         INTEGER NOT NULL DEFAULT 0,
    description         TEXT,
    gid                 CHAR(36) NOT NULL
);

CREATE TABLE musicbrainz.language ( -- replicate
    id                  BIGINT NOT NULL,
    iso_code_2t         CHAR(3), -- ISO 639-2 (T)
    iso_code_2b         CHAR(3), -- ISO 639-2 (B)
    iso_code_1          CHAR(2), -- ISO 639
    name                VARCHAR(100) NOT NULL,
    frequency           INTEGER NOT NULL DEFAULT 0,
    iso_code_3          CHAR(3)  -- ISO 639-3
);

CREATE TABLE musicbrainz.link ( -- replicate
    id                  BIGINT NOT NULL,
    link_type           INTEGER NOT NULL, -- references link_type.id
    begin_date_year     INTEGER,
    begin_date_month    INTEGER,
    begin_date_day      INTEGER,
    end_date_year       INTEGER,
    end_date_month      INTEGER,
    end_date_day        INTEGER,
    attribute_count     INTEGER NOT NULL DEFAULT 0,
    created             TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    ended               BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE musicbrainz.link_attribute ( -- replicate
    link                INTEGER NOT NULL, -- PK, references link.id
    attribute_type      INTEGER NOT NULL, -- PK, references link_attribute_type.id
    created             TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE musicbrainz.link_attribute_type ( -- replicate
    id                  BIGINT NOT NULL,
    parent              INTEGER, -- references link_attribute_type.id
    root                INTEGER NOT NULL, -- references link_attribute_type.id
    child_order         INTEGER NOT NULL DEFAULT 0,
    gid                 CHAR(36) NOT NULL,
    name                VARCHAR(10000) NOT NULL,
    description         VARCHAR(10000),
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE musicbrainz.link_creditable_attribute_type ( -- replicate
  attribute_type INT NOT NULL -- PK, references link_attribute_type.id CASCADE
);

CREATE TABLE musicbrainz.link_attribute_credit ( -- replicate
  link INT NOT NULL, -- PK, references link.id
  attribute_type INT NOT NULL, -- PK, references link_creditable_attribute_type.attribute_type
  credited_as VARCHAR(10000) NOT NULL
);

CREATE TABLE musicbrainz.link_text_attribute_type ( -- replicate
    attribute_type      INT NOT NULL -- PK, references link_attribute_type.id CASCADE
);

CREATE TABLE musicbrainz.link_attribute_text_value ( -- replicate
    link                INT NOT NULL, -- PK, references link.id
    attribute_type      INT NOT NULL, -- PK, references link_text_attribute_type.attribute_type
    text_value          TEXT NOT NULL
);

CREATE TABLE musicbrainz.link_type ( -- replicate
    id                  BIGINT NOT NULL,
    parent              INTEGER, -- references link_type.id
    child_order         INTEGER NOT NULL DEFAULT 0,
    gid                 CHAR(36) NOT NULL,
    entity_type0        VARCHAR(50) NOT NULL,
    entity_type1        VARCHAR(50) NOT NULL,
    name                VARCHAR(10000) NOT NULL,
    description         VARCHAR(10000),
    link_phrase         VARCHAR(10000) NOT NULL,
    reverse_link_phrase VARCHAR(10000) NOT NULL,
    long_link_phrase    VARCHAR(10000) NOT NULL,
    priority            INTEGER NOT NULL DEFAULT 0,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    is_deprecated       BOOLEAN NOT NULL DEFAULT false,
    has_dates           BOOLEAN NOT NULL DEFAULT true,
    entity0_cardinality INTEGER NOT NULL DEFAULT 0,
    entity1_cardinality INTEGER NOT NULL DEFAULT 0
);

CREATE TABLE musicbrainz.link_type_attribute_type ( -- replicate
    link_type           INTEGER NOT NULL, -- PK, references link_type.id
    attribute_type      INTEGER NOT NULL, -- PK, references link_attribute_type.id
    min                 INTEGER,
    max                 INTEGER,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE musicbrainz.editor_collection
(
    id                  BIGINT NOT NULL,
    gid                 CHAR(36) NOT NULL,
    editor              INTEGER NOT NULL, -- references editor.id
    name                VARCHAR(10000) NOT NULL,
    public              BOOLEAN NOT NULL DEFAULT FALSE,
    description         TEXT DEFAULT '' NOT NULL,
    type                INTEGER NOT NULL -- references editor_collection_type.id
);

CREATE TABLE musicbrainz.editor_collection_gid_redirect (
    gid                 CHAR(36) NOT NULL, -- PK
    new_id              INTEGER NOT NULL, -- references editor_collection.id
    created             TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE musicbrainz.editor_collection_type ( -- replicate
    id                  BIGINT NOT NULL,
    name                VARCHAR(255) NOT NULL,
    entity_type         VARCHAR(50) NOT NULL,
    parent              INTEGER, -- references editor_collection_type.id
    child_order         INTEGER NOT NULL DEFAULT 0,
    description         TEXT,
    gid                 CHAR(36) NOT NULL
);

CREATE TABLE musicbrainz.editor_collection_collaborator (
    collection INTEGER NOT NULL, -- PK, references editor_collection.id
    editor INTEGER NOT NULL -- PK, references editor.id
);

CREATE TABLE musicbrainz.editor_collection_area (
    collection INTEGER NOT NULL, -- PK, references editor_collection.id
    area INTEGER NOT NULL, -- PK, references area.id
    added TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    position INTEGER NOT NULL DEFAULT 0 ,
    comment TEXT DEFAULT '' NOT NULL
);

CREATE TABLE musicbrainz.editor_collection_artist (
    collection INTEGER NOT NULL, -- PK, references editor_collection.id
    artist INTEGER NOT NULL, -- PK, references artist.id
    added TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    position INTEGER NOT NULL DEFAULT 0 ,
    comment TEXT DEFAULT '' NOT NULL
);

CREATE TABLE musicbrainz.editor_collection_event (
    collection INTEGER NOT NULL, -- PK, references editor_collection.id
    event INTEGER NOT NULL, -- PK, references event.id
    added TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    position INTEGER NOT NULL DEFAULT 0 ,
    comment TEXT DEFAULT '' NOT NULL
);

CREATE TABLE musicbrainz.editor_collection_instrument (
    collection INTEGER NOT NULL, -- PK, references editor_collection.id
    instrument INTEGER NOT NULL, -- PK, references instrument.id
    added TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    position INTEGER NOT NULL DEFAULT 0 ,
    comment TEXT DEFAULT '' NOT NULL
);

CREATE TABLE musicbrainz.editor_collection_label (
    collection INTEGER NOT NULL, -- PK, references editor_collection.id
    label INTEGER NOT NULL, -- PK, references label.id
    added TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    position INTEGER NOT NULL DEFAULT 0 ,
    comment TEXT DEFAULT '' NOT NULL
);

CREATE TABLE musicbrainz.editor_collection_place (
    collection INTEGER NOT NULL, -- PK, references editor_collection.id
    place INTEGER NOT NULL, -- PK, references place.id
    added TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    position INTEGER NOT NULL DEFAULT 0 ,
    comment TEXT DEFAULT '' NOT NULL
);

CREATE TABLE musicbrainz.editor_collection_recording (
    collection INTEGER NOT NULL, -- PK, references editor_collection.id
    recording INTEGER NOT NULL, -- PK, references recording.id
    added TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    position INTEGER NOT NULL DEFAULT 0 ,
    comment TEXT DEFAULT '' NOT NULL
);

CREATE TABLE musicbrainz.editor_collection_release (
    collection INTEGER NOT NULL, -- PK, references editor_collection.id
    release INTEGER NOT NULL, -- PK, references release.id
    added TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    position INTEGER NOT NULL DEFAULT 0 ,
    comment TEXT DEFAULT '' NOT NULL
);

CREATE TABLE musicbrainz.editor_collection_release_group (
    collection INTEGER NOT NULL, -- PK, references editor_collection.id
    release_group INTEGER NOT NULL, -- PK, references release_group.id
    added TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    position INTEGER NOT NULL DEFAULT 0 ,
    comment TEXT DEFAULT '' NOT NULL
);

CREATE TABLE musicbrainz.editor_collection_series (
    collection INTEGER NOT NULL, -- PK, references editor_collection.id
    series INTEGER NOT NULL, -- PK, references series.id
    added TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    position INTEGER NOT NULL DEFAULT 0 ,
    comment TEXT DEFAULT '' NOT NULL
);

CREATE TABLE musicbrainz.editor_collection_work (
    collection INTEGER NOT NULL, -- PK, references editor_collection.id
    work INTEGER NOT NULL, -- PK, references work.id
    added TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    position INTEGER NOT NULL DEFAULT 0 ,
    comment TEXT DEFAULT '' NOT NULL
);

CREATE TABLE musicbrainz.editor_collection_deleted_entity (
    collection INTEGER NOT NULL, -- PK, references editor_collection.id
    gid CHAR(36) NOT NULL, -- PK, references deleted_entity.gid
    added TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    position INTEGER NOT NULL DEFAULT 0 ,
    comment TEXT DEFAULT '' NOT NULL
);

CREATE TABLE musicbrainz.editor_oauth_token
(
    id                      BIGINT NOT NULL,
    editor                  INTEGER NOT NULL, -- references editor.id
    application             INTEGER NOT NULL, -- references application.id
    authorization_code      TEXT,
    refresh_token           TEXT,
    access_token            TEXT,
    expire_time             TIMESTAMP WITH TIME ZONE NOT NULL,
    scope                   INTEGER NOT NULL DEFAULT 0,
    granted                 TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    code_challenge          TEXT,
    code_challenge_method   VARCHAR(1000)
);

CREATE TABLE musicbrainz.editor_watch_preferences
(
    editor INTEGER NOT NULL, -- PK, references editor.id CASCADE
    notify_via_email BOOLEAN NOT NULL DEFAULT TRUE,
    notification_timeframe VARCHAR(100) NOT NULL DEFAULT '1 week',
    last_checked TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
);

CREATE TABLE musicbrainz.editor_watch_artist
(
    artist INTEGER NOT NULL, -- PK, references artist.id CASCADE
    editor INTEGER NOT NULL  -- PK, references editor.id CASCADE
);

CREATE TABLE musicbrainz.editor_watch_release_group_type
(
    editor INTEGER NOT NULL, -- PK, references editor.id CASCADE
    release_group_type INTEGER NOT NULL -- PK, references release_group_primary_type.id
);

CREATE TABLE musicbrainz.editor_watch_release_status
(
    editor INTEGER NOT NULL, -- PK, references editor.id CASCADE
    release_status INTEGER NOT NULL -- PK, references release_status.id
);

CREATE TABLE musicbrainz.medium ( -- replicate (verbose)
    id                  BIGINT NOT NULL,
    release             INTEGER NOT NULL, -- references release.id
    position            INTEGER NOT NULL,
    format              INTEGER, -- references medium_format.id
    name                VARCHAR(10000) NOT NULL DEFAULT '',
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    track_count         INTEGER NOT NULL DEFAULT 0
);

CREATE TABLE musicbrainz.medium_attribute_type ( -- replicate (verbose)
    id                  BIGINT NOT NULL,  -- PK
    name                VARCHAR(255) NOT NULL,
    comment             VARCHAR(2550) NOT NULL DEFAULT '',
    free_text           BOOLEAN NOT NULL,
    parent              INTEGER, -- references medium_attribute_type.id
    child_order         INTEGER NOT NULL DEFAULT 0,
    description         TEXT,
    gid                 CHAR(36) NOT NULL
);

CREATE TABLE musicbrainz.medium_attribute_type_allowed_format ( -- replicate (verbose)
    medium_format INTEGER NOT NULL, -- PK, references medium_format.id,
    medium_attribute_type INTEGER NOT NULL -- PK, references medium_attribute_type.id
);

CREATE TABLE musicbrainz.medium_attribute_type_allowed_value ( -- replicate (verbose)
    id                          BIGINT NOT NULL,  -- PK
    medium_attribute_type       INTEGER NOT NULL, -- references medium_attribute_type.id
    value                       TEXT,
    parent                      INTEGER, -- references medium_attribute_type_allowed_value.id
    child_order                 INTEGER NOT NULL DEFAULT 0,
    description                 TEXT,
    gid                         CHAR(36) NOT NULL
);

CREATE TABLE musicbrainz.medium_attribute_type_allowed_value_allowed_format ( -- replicate (verbose)
    medium_format INTEGER NOT NULL, -- PK, references medium_format.id,
    medium_attribute_type_allowed_value INTEGER NOT NULL -- PK, references medium_attribute_type_allowed_value.id
);

CREATE TABLE musicbrainz.medium_attribute ( -- replicate (verbose)
    id                                  BIGINT NOT NULL,  -- PK
    medium                              INTEGER NOT NULL, -- references medium.id
    medium_attribute_type               INTEGER NOT NULL, -- references medium_attribute_type.id
    medium_attribute_type_allowed_value INTEGER, -- references medium_attribute_type_allowed_value.id
    medium_attribute_text               TEXT
);

CREATE TABLE musicbrainz.medium_cdtoc ( -- replicate (verbose)
    id                  BIGINT NOT NULL,
    medium              INTEGER NOT NULL, -- references medium.id
    cdtoc               INTEGER NOT NULL, -- references cdtoc.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE musicbrainz.medium_format ( -- replicate
    id                  BIGINT NOT NULL,
    name                VARCHAR(1000) NOT NULL,
    parent              INTEGER, -- references medium_format.id
    child_order         INTEGER NOT NULL DEFAULT 0,
    year                INTEGER,
    has_discids         BOOLEAN NOT NULL DEFAULT FALSE,
    description         VARCHAR(10000),
    gid                 CHAR(36) NOT NULL
);

CREATE TABLE musicbrainz.mood ( -- replicate (verbose)
    id                  BIGINT NOT NULL, -- PK
    gid                 CHAR(36) NOT NULL,
    name                VARCHAR(10000) NOT NULL,
    comment             VARCHAR(2550) NOT NULL DEFAULT '',
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE musicbrainz.mood_alias_type ( -- replicate
    id                  BIGINT NOT NULL, -- PK,
    name                TEXT NOT NULL,
    parent              INTEGER, -- references mood_alias_type.id
    child_order         INTEGER NOT NULL DEFAULT 0,
    description         TEXT,
    gid                 CHAR(36) NOT NULL
);

CREATE TABLE musicbrainz.mood_alias ( -- replicate (verbose)
    id                  BIGINT NOT NULL, --PK
    mood                INTEGER NOT NULL, -- references mood.id
    name                VARCHAR(10000) NOT NULL,
    locale              TEXT,
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    type                INTEGER, -- references mood_alias_type.id
    sort_name           VARCHAR(10000) NOT NULL,
    begin_date_year     INTEGER,
    begin_date_month    INTEGER,
    begin_date_day      INTEGER,
    end_date_year       INTEGER,
    end_date_month      INTEGER,
    end_date_day        INTEGER,
    primary_for_locale  BOOLEAN NOT NULL DEFAULT false,
    ended               BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE musicbrainz.mood_annotation ( -- replicate (verbose)
    mood        INTEGER NOT NULL, -- PK, references mood.id
    annotation  INTEGER NOT NULL -- PK, references annotation.id
);

CREATE TABLE musicbrainz.orderable_link_type ( -- replicate
    link_type           INTEGER NOT NULL, -- PK, references link_type.id
    direction           INTEGER NOT NULL DEFAULT 1 
);

CREATE TABLE musicbrainz.place ( -- replicate (verbose)
    id                  BIGINT NOT NULL, -- PK
    gid                 CHAR(36) NOT NULL,
    name                VARCHAR(10000) NOT NULL,
    type                INTEGER, -- references place_type.id
    address             VARCHAR NOT NULL DEFAULT '',
    area                INTEGER, -- references area.id
    coordinates         VARCHAR(100),
    comment             VARCHAR(2550) NOT NULL DEFAULT '',
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    begin_date_year     INTEGER,
    begin_date_month    INTEGER,
    begin_date_day      INTEGER,
    end_date_year       INTEGER,
    end_date_month      INTEGER,
    end_date_day        INTEGER,
    ended               BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE musicbrainz.place_alias ( -- replicate (verbose)
    id                  BIGINT NOT NULL,
    place               INTEGER NOT NULL, -- references place.id
    name                VARCHAR(10000) NOT NULL,
    locale              TEXT,
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    type                INTEGER, -- references place_alias_type.id
    sort_name           VARCHAR(10000) NOT NULL,
    begin_date_year     INTEGER,
    begin_date_month    INTEGER,
    begin_date_day      INTEGER,
    end_date_year       INTEGER,
    end_date_month      INTEGER,
    end_date_day        INTEGER,
    primary_for_locale  BOOLEAN NOT NULL DEFAULT false,
    ended               BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE musicbrainz.place_alias_type ( -- replicate
    id                  BIGINT NOT NULL,
    name                TEXT NOT NULL,
    parent              INTEGER, -- references place_alias_type.id
    child_order         INTEGER NOT NULL DEFAULT 0,
    description         TEXT,
    gid                 CHAR(36) NOT NULL
);

CREATE TABLE musicbrainz.place_annotation ( -- replicate (verbose)
    place               INTEGER NOT NULL, -- PK, references place.id
    annotation          INTEGER NOT NULL -- PK, references annotation.id
);

CREATE TABLE musicbrainz.place_attribute_type ( -- replicate (verbose)
    id                  BIGINT NOT NULL,  -- PK
    name                VARCHAR(255) NOT NULL,
    comment             VARCHAR(2550) NOT NULL DEFAULT '',
    free_text           BOOLEAN NOT NULL,
    parent              INTEGER, -- references place_attribute_type.id
    child_order         INTEGER NOT NULL DEFAULT 0,
    description         TEXT,
    gid                 CHAR(36) NOT NULL
);

CREATE TABLE musicbrainz.place_attribute_type_allowed_value ( -- replicate (verbose)
    id                          BIGINT NOT NULL,  -- PK
    place_attribute_type        INTEGER NOT NULL, -- references place_attribute_type.id
    value                       TEXT,
    parent                      INTEGER, -- references place_attribute_type_allowed_value.id
    child_order                 INTEGER NOT NULL DEFAULT 0,
    description                 TEXT,
    gid                         CHAR(36) NOT NULL
);

CREATE TABLE musicbrainz.place_attribute ( -- replicate (verbose)
    id                                  BIGINT NOT NULL,  -- PK
    place                               INTEGER NOT NULL, -- references place.id
    place_attribute_type                INTEGER NOT NULL, -- references place_attribute_type.id
    place_attribute_type_allowed_value  INTEGER, -- references place_attribute_type_allowed_value.id
    place_attribute_text                TEXT
);

CREATE TABLE musicbrainz.place_gid_redirect ( -- replicate (verbose)
    gid                 CHAR(36) NOT NULL, -- PK
    new_id              INTEGER NOT NULL, -- references place.id
    created             TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE musicbrainz.place_meta ( -- replicate
    id                  INTEGER NOT NULL, -- PK, references place.id CASCADE
    rating              INTEGER ,
    rating_count        INTEGER
);

CREATE TABLE musicbrainz.place_rating_raw
(
    place               INTEGER NOT NULL, -- PK, references place.id
    editor              INTEGER NOT NULL, -- PK, references editor.id
    rating              INTEGER NOT NULL 
);

CREATE TABLE musicbrainz.place_tag ( -- replicate (verbose)
    place               INTEGER NOT NULL, -- PK, references place.id
    "tag"                 INTEGER NOT NULL, -- PK, references "tag".id
    count               INTEGER NOT NULL,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE musicbrainz.place_tag_raw
(
    place               INTEGER NOT NULL, -- PK, references place.id
    editor              INTEGER NOT NULL, -- PK, references editor.id
    "tag"                 INTEGER NOT NULL, -- PK, references "tag".id
    is_upvote           BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE musicbrainz.place_type ( -- replicate
    id                  BIGINT NOT NULL, -- PK
    name                VARCHAR(255) NOT NULL,
    parent              INTEGER, -- references place_type.id
    child_order         INTEGER NOT NULL DEFAULT 0,
    description         TEXT,
    gid                 CHAR(36) NOT NULL
);

CREATE TABLE musicbrainz.replication_control ( -- replicate
    id                              BIGINT NOT NULL,
    current_schema_sequence         INTEGER NOT NULL,
    current_replication_sequence    INTEGER,
    last_replication_date           TIMESTAMP WITH TIME ZONE
);

CREATE TABLE musicbrainz.recording ( -- replicate (verbose)
    id                  BIGINT NOT NULL,
    gid                 CHAR(36) NOT NULL,
    name                VARCHAR(20000) NOT NULL DEFAULT '',
    artist_credit       INTEGER NOT NULL, -- references artist_credit.id
    length              INTEGER ,
    comment             VARCHAR(1000) NOT NULL DEFAULT '',
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    video               BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE musicbrainz.recording_alias_type ( -- replicate
    id                  BIGINT NOT NULL, -- PK,
    name                TEXT NOT NULL,
    parent              INTEGER, -- references recording_alias_type.id
    child_order         INTEGER NOT NULL DEFAULT 0,
    description         TEXT,
    gid                 CHAR(36) NOT NULL
);

CREATE TABLE musicbrainz.recording_alias ( -- replicate (verbose)
    id                  BIGINT NOT NULL, --PK
    recording           INTEGER NOT NULL, -- references recording.id
    name                VARCHAR(10000) NOT NULL,
    locale              TEXT,
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    type                INTEGER, -- references recording_alias_type.id
    sort_name           VARCHAR(10000) NOT NULL,
    begin_date_year     INTEGER,
    begin_date_month    INTEGER,
    begin_date_day      INTEGER,
    end_date_year       INTEGER,
    end_date_month      INTEGER,
    end_date_day        INTEGER,
    primary_for_locale  BOOLEAN NOT NULL DEFAULT false,
    ended               BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE musicbrainz.recording_rating_raw
(
    recording           INTEGER NOT NULL, -- PK, references recording.id
    editor              INTEGER NOT NULL, -- PK, references editor.id
    rating              INTEGER NOT NULL 
);

CREATE TABLE musicbrainz.recording_tag_raw
(
    recording           INTEGER NOT NULL, -- PK, references recording.id
    editor              INTEGER NOT NULL, -- PK, references editor.id
    "tag"                 INTEGER NOT NULL, -- PK, references "tag".id
    is_upvote           BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE musicbrainz.recording_annotation ( -- replicate (verbose)
    recording           INTEGER NOT NULL, -- PK, references recording.id
    annotation          INTEGER NOT NULL -- PK, references annotation.id
);

CREATE TABLE musicbrainz.recording_attribute_type ( -- replicate (verbose)
    id                  BIGINT NOT NULL,  -- PK
    name                VARCHAR(255) NOT NULL,
    comment             VARCHAR(2550) NOT NULL DEFAULT '',
    free_text           BOOLEAN NOT NULL,
    parent              INTEGER, -- references recording_attribute_type.id
    child_order         INTEGER NOT NULL DEFAULT 0,
    description         TEXT,
    gid                 CHAR(36) NOT NULL
);

CREATE TABLE musicbrainz.recording_attribute_type_allowed_value ( -- replicate (verbose)
    id                          BIGINT NOT NULL,  -- PK
    recording_attribute_type    INTEGER NOT NULL, -- references recording_attribute_type.id
    value                       TEXT,
    parent                      INTEGER, -- references recording_attribute_type_allowed_value.id
    child_order                 INTEGER NOT NULL DEFAULT 0,
    description                 TEXT,
    gid                         CHAR(36) NOT NULL
);

CREATE TABLE musicbrainz.recording_attribute ( -- replicate (verbose)
    id                                          BIGINT NOT NULL,  -- PK
    recording                                   INTEGER NOT NULL, -- references recording.id
    recording_attribute_type                    INTEGER NOT NULL, -- references recording_attribute_type.id
    recording_attribute_type_allowed_value      INTEGER, -- references recording_attribute_type_allowed_value.id
    recording_attribute_text                    TEXT
);

CREATE TABLE musicbrainz.recording_meta ( -- replicate
    id                  INTEGER NOT NULL, -- PK, references recording.id CASCADE
    rating              INTEGER ,
    rating_count        INTEGER
);

CREATE TABLE musicbrainz.recording_gid_redirect ( -- replicate (verbose)
    gid                 CHAR(36) NOT NULL, -- PK
    new_id              INTEGER NOT NULL, -- references recording.id
    created             TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE musicbrainz.recording_tag ( -- replicate (verbose)
    recording           INTEGER NOT NULL, -- PK, references recording.id
    "tag"                 INTEGER NOT NULL, -- PK, references "tag".id
    count               INTEGER NOT NULL,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE musicbrainz.release ( -- replicate (verbose)
    id                  BIGINT NOT NULL,
    gid                 CHAR(36) NOT NULL,
    name                VARCHAR(10000) NOT NULL,
    artist_credit       INTEGER NOT NULL, -- references artist_credit.id
    release_group       INTEGER NOT NULL, -- references release_group.id
    status              INTEGER, -- references release_status.id
    packaging           INTEGER, -- references release_packaging.id
    language            INTEGER, -- references language.id
    script              INTEGER, -- references script.id
    barcode             VARCHAR(255),
    comment             VARCHAR(2550) NOT NULL DEFAULT '',
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    quality             INTEGER NOT NULL DEFAULT -1,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE musicbrainz.release_alias_type ( -- replicate
    id                  BIGINT NOT NULL, -- PK,
    name                TEXT NOT NULL,
    parent              INTEGER, -- references release_alias_type.id
    child_order         INTEGER NOT NULL DEFAULT 0,
    description         TEXT,
    gid                 CHAR(36) NOT NULL
);

CREATE TABLE musicbrainz.release_alias ( -- replicate (verbose)
    id                  BIGINT NOT NULL, --PK
    release             INTEGER NOT NULL, -- references release.id
    name                VARCHAR(10000) NOT NULL,
    locale              TEXT,
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    type                INTEGER, -- references release_alias_type.id
    sort_name           VARCHAR(10000) NOT NULL,
    begin_date_year     INTEGER,
    begin_date_month    INTEGER,
    begin_date_day      INTEGER,
    end_date_year       INTEGER,
    end_date_month      INTEGER,
    end_date_day        INTEGER,
    primary_for_locale  BOOLEAN NOT NULL DEFAULT false,
    ended               BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE musicbrainz.release_country ( -- replicate (verbose)
  release INTEGER NOT NULL,  -- PK, references release.id
  country INTEGER NOT NULL,  -- PK, references country_area.area
  date_year INTEGER,
  date_month INTEGER,
  date_day INTEGER
);

CREATE TABLE musicbrainz.release_unknown_country ( -- replicate (verbose)
  release INTEGER NOT NULL,  -- PK, references release.id
  date_year INTEGER,
  date_month INTEGER,
  date_day INTEGER
);

CREATE TABLE musicbrainz.release_raw ( -- replicate
    id                  BIGINT NOT NULL, -- PK
    title               VARCHAR(255) NOT NULL,
    artist              VARCHAR(255),
    added               TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    last_modified        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    lookup_count         INTEGER DEFAULT 0,
    modify_count         INTEGER DEFAULT 0,
    source              INTEGER DEFAULT 0,
    barcode             VARCHAR(255),
    comment             VARCHAR(2550) NOT NULL DEFAULT ''
);

CREATE TABLE musicbrainz.release_tag_raw
(
    release             INTEGER NOT NULL, -- PK, references release.id
    editor              INTEGER NOT NULL, -- PK, references editor.id
    "tag"                 INTEGER NOT NULL, -- PK, references "tag".id
    is_upvote           BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE musicbrainz.release_annotation ( -- replicate (verbose)
    release             INTEGER NOT NULL, -- PK, references release.id
    annotation          INTEGER NOT NULL -- PK, references annotation.id
);

CREATE TABLE musicbrainz.release_attribute_type ( -- replicate (verbose)
    id                  BIGINT NOT NULL,  -- PK
    name                VARCHAR(255) NOT NULL,
    comment             VARCHAR(2550) NOT NULL DEFAULT '',
    free_text           BOOLEAN NOT NULL,
    parent              INTEGER, -- references release_attribute_type.id
    child_order         INTEGER NOT NULL DEFAULT 0,
    description         TEXT,
    gid                 CHAR(36) NOT NULL
);

CREATE TABLE musicbrainz.release_attribute_type_allowed_value ( -- replicate (verbose)
    id                          BIGINT NOT NULL,  -- PK
    release_attribute_type      INTEGER NOT NULL, -- references release_attribute_type.id
    value                       TEXT,
    parent                      INTEGER, -- references release_attribute_type_allowed_value.id
    child_order                 INTEGER NOT NULL DEFAULT 0,
    description                 TEXT,
    gid                         CHAR(36) NOT NULL
);

CREATE TABLE musicbrainz.release_attribute ( -- replicate (verbose)
    id                                          BIGINT NOT NULL,  -- PK
    release                                     INTEGER NOT NULL, -- references release.id
    release_attribute_type                      INTEGER NOT NULL, -- references release_attribute_type.id
    release_attribute_type_allowed_value        INTEGER, -- references release_attribute_type_allowed_value.id
    release_attribute_text                      TEXT
);

CREATE TABLE musicbrainz.release_gid_redirect ( -- replicate (verbose)
    gid                 CHAR(36) NOT NULL, -- PK
    new_id              INTEGER NOT NULL, -- references release.id
    created             TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE musicbrainz.release_meta ( -- replicate (verbose)
    id                  INTEGER NOT NULL, -- PK, references release.id CASCADE
    date_added          TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    info_url            VARCHAR(255),
    amazon_asin         VARCHAR(10),
    cover_art_presence  VARCHAR(100) NOT NULL DEFAULT 'absent'
);

CREATE TABLE musicbrainz.release_label ( -- replicate (verbose)
    id                  BIGINT NOT NULL,
    release             INTEGER NOT NULL, -- references release.id
    label               INTEGER, -- references label.id
    catalog_number      VARCHAR(255),
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE musicbrainz.release_packaging ( -- replicate
    id                  BIGINT NOT NULL,
    name                VARCHAR(255) NOT NULL,
    parent              INTEGER, -- references release_packaging.id
    child_order         INTEGER NOT NULL DEFAULT 0,
    description         TEXT,
    gid                 CHAR(36) NOT NULL
);

CREATE TABLE musicbrainz.release_status ( -- replicate
    id                  BIGINT NOT NULL,
    name                VARCHAR(450) NOT NULL,
    parent              INTEGER, -- references release_status.id
    child_order         INTEGER NOT NULL DEFAULT 0,
    description         VARCHAR(2505),
    gid                 CHAR(36) NOT NULL
);

CREATE TABLE musicbrainz.release_tag ( -- replicate (verbose)
    release             INTEGER NOT NULL, -- PK, references release.id
    "tag"                 INTEGER NOT NULL, -- PK, references "tag".id
    count               INTEGER NOT NULL,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE musicbrainz.release_group ( -- replicate (verbose)
    id                  BIGINT NOT NULL,
    gid                 CHAR(36) NOT NULL,
    name                VARCHAR(10000) NOT NULL,
    artist_credit       INTEGER NOT NULL, -- references artist_credit.id
    type                INTEGER, -- references release_group_primary_type.id
    comment             VARCHAR(2550) NOT NULL DEFAULT '',
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE musicbrainz.release_group_alias_type ( -- replicate
    id                  BIGINT NOT NULL, -- PK,
    name                TEXT NOT NULL,
    parent              INTEGER, -- references release_group_alias_type.id
    child_order         INTEGER NOT NULL DEFAULT 0,
    description         TEXT,
    gid                 CHAR(36) NOT NULL
);

CREATE TABLE musicbrainz.release_group_alias ( -- replicate (verbose)
    id                  BIGINT NOT NULL, --PK
    release_group       INTEGER NOT NULL, -- references release_group.id
    name                VARCHAR(10000) NOT NULL,
    locale              TEXT,
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    type                INTEGER, -- references release_group_alias_type.id
    sort_name           VARCHAR(10000) NOT NULL,
    begin_date_year     INTEGER,
    begin_date_month    INTEGER,
    begin_date_day      INTEGER,
    end_date_year       INTEGER,
    end_date_month      INTEGER,
    end_date_day        INTEGER,
    primary_for_locale  BOOLEAN NOT NULL DEFAULT false,
    ended               BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE musicbrainz.release_group_rating_raw
(
    release_group       INTEGER NOT NULL, -- PK, references release_group.id
    editor              INTEGER NOT NULL, -- PK, references editor.id
    rating              INTEGER NOT NULL 
);

CREATE TABLE musicbrainz.release_group_tag_raw
(
    release_group       INTEGER NOT NULL, -- PK, references release_group.id
    editor              INTEGER NOT NULL, -- PK, references editor.id
    "tag"                 INTEGER NOT NULL, -- PK, references "tag".id
    is_upvote           BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE musicbrainz.release_group_annotation ( -- replicate (verbose)
    release_group       INTEGER NOT NULL, -- PK, references release_group.id
    annotation          INTEGER NOT NULL -- PK, references annotation.id
);

CREATE TABLE musicbrainz.release_group_attribute_type ( -- replicate (verbose)
    id                  BIGINT NOT NULL,  -- PK
    name                VARCHAR(255) NOT NULL,
    comment             VARCHAR(2550) NOT NULL DEFAULT '',
    free_text           BOOLEAN NOT NULL,
    parent              INTEGER, -- references release_group_attribute_type.id
    child_order         INTEGER NOT NULL DEFAULT 0,
    description         TEXT,
    gid                 CHAR(36) NOT NULL
);

CREATE TABLE musicbrainz.release_group_attribute_type_allowed_value ( -- replicate (verbose)
    id                                  BIGINT NOT NULL,  -- PK
    release_group_attribute_type        INTEGER NOT NULL, -- references release_group_attribute_type.id
    value                               TEXT,
    parent                              INTEGER, -- references release_group_attribute_type_allowed_value.id
    child_order                         INTEGER NOT NULL DEFAULT 0,
    description                         TEXT,
    gid                                 CHAR(36) NOT NULL
);

CREATE TABLE musicbrainz.release_group_attribute ( -- replicate (verbose)
    id                                          BIGINT NOT NULL,  -- PK
    release_group                               INTEGER NOT NULL, -- references release_group.id
    release_group_attribute_type                INTEGER NOT NULL, -- references release_group_attribute_type.id
    release_group_attribute_type_allowed_value  INTEGER, -- references release_group_attribute_type_allowed_value.id
    release_group_attribute_text                TEXT
);

CREATE TABLE musicbrainz.release_group_gid_redirect ( -- replicate (verbose)
    gid                 CHAR(36) NOT NULL, -- PK
    new_id              INTEGER NOT NULL, -- references release_group.id
    created             TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE musicbrainz.release_group_meta ( -- replicate
    id                  INTEGER NOT NULL, -- PK, references release_group.id CASCADE
    release_count       INTEGER NOT NULL DEFAULT 0,
    first_release_date_year   INTEGER,
    first_release_date_month  INTEGER,
    first_release_date_day    INTEGER,
    rating              INTEGER ,
    rating_count        INTEGER
);

CREATE TABLE musicbrainz.release_group_tag ( -- replicate (verbose)
    release_group       INTEGER NOT NULL, -- PK, references release_group.id
    "tag"                 INTEGER NOT NULL, -- PK, references "tag".id
    count               INTEGER NOT NULL,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE musicbrainz.release_group_primary_type ( -- replicate
    id                  BIGINT NOT NULL,
    name                VARCHAR(2550) NOT NULL,
    parent              INTEGER, -- references release_group_primary_type.id
    child_order         INTEGER NOT NULL DEFAULT 0,
    description         VARCHAR(2550),
    gid                 CHAR(36) NOT NULL
);

CREATE TABLE musicbrainz.release_group_secondary_type ( -- replicate
    id                  BIGINT NOT NULL NOT NULL, -- PK
    name                VARCHAR(2550) NOT NULL,
    parent              INTEGER, -- references release_group_secondary_type.id
    child_order         INTEGER NOT NULL DEFAULT 0,
    description         VARCHAR(2550),
    gid                 CHAR(36) NOT NULL
);

CREATE TABLE musicbrainz.release_group_secondary_type_join ( -- replicate (verbose)
    release_group INTEGER NOT NULL, -- PK, references release_group.id,
    secondary_type INTEGER NOT NULL, -- PK, references release_group_secondary_type.id
    created TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

CREATE TABLE musicbrainz.script ( -- replicate
    id                  BIGINT NOT NULL,
    iso_code            CHAR(4) NOT NULL, -- ISO 15924
    iso_number          CHAR(3) NOT NULL, -- ISO 15924
    name                VARCHAR(100) NOT NULL,
    frequency           INTEGER NOT NULL DEFAULT 0
);

CREATE TABLE musicbrainz.series ( -- replicate (verbose)
    id                  BIGINT NOT NULL,
    gid                 CHAR(36) NOT NULL,
    name                VARCHAR(10000) NOT NULL,
    comment             VARCHAR(2550) NOT NULL DEFAULT '',
    type                INTEGER NOT NULL, -- references series_type.id
    ordering_type       INTEGER NOT NULL, -- references series_ordering_type.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE musicbrainz.series_type ( -- replicate (verbose)
    id                  BIGINT NOT NULL,
    name                VARCHAR(255) NOT NULL,
    entity_type         VARCHAR(50) NOT NULL,
    parent              INTEGER, -- references series_type.id
    child_order         INTEGER NOT NULL DEFAULT 0,
    description         TEXT,
    gid                 CHAR(36) NOT NULL
);

CREATE TABLE musicbrainz.series_ordering_type ( -- replicate (verbose)
    id                  BIGINT NOT NULL,
    name                VARCHAR(255) NOT NULL,
    parent              INTEGER, -- references series_ordering_type.id
    child_order         INTEGER NOT NULL DEFAULT 0,
    description         TEXT,
    gid                 CHAR(36) NOT NULL
);

CREATE TABLE musicbrainz.series_gid_redirect ( -- replicate (verbose)
    gid                 CHAR(36) NOT NULL, -- PK
    new_id              INTEGER NOT NULL, -- references series.id
    created             TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE musicbrainz.series_alias_type ( -- replicate (verbose)
    id                  BIGINT NOT NULL, -- PK
    name                TEXT NOT NULL,
    parent              INTEGER, -- references series_alias_type.id
    child_order         INTEGER NOT NULL DEFAULT 0,
    description         TEXT,
    gid                 CHAR(36) NOT NULL
);

CREATE TABLE musicbrainz.series_alias ( -- replicate (verbose)
    id                  BIGINT NOT NULL, -- PK
    series              INTEGER NOT NULL, -- references series.id
    name                VARCHAR(10000) NOT NULL,
    locale              TEXT,
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    type                INTEGER, -- references series_alias_type.id
    sort_name           VARCHAR(10000) NOT NULL,
    begin_date_year     INTEGER,
    begin_date_month    INTEGER,
    begin_date_day      INTEGER,
    end_date_year       INTEGER,
    end_date_month      INTEGER,
    end_date_day        INTEGER,
    primary_for_locale  BOOLEAN NOT NULL DEFAULT FALSE,
    ended               BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE musicbrainz.series_annotation ( -- replicate (verbose)
    series              INTEGER NOT NULL, -- PK, references series.id
    annotation          INTEGER NOT NULL -- PK, references annotation.id
);

CREATE TABLE musicbrainz.series_attribute_type ( -- replicate (verbose)
    id                  BIGINT NOT NULL,  -- PK
    name                VARCHAR(255) NOT NULL,
    comment             VARCHAR(2550) NOT NULL DEFAULT '',
    free_text           BOOLEAN NOT NULL,
    parent              INTEGER, -- references series_attribute_type.id
    child_order         INTEGER NOT NULL DEFAULT 0,
    description         TEXT,
    gid                 CHAR(36) NOT NULL
);

CREATE TABLE musicbrainz.series_attribute_type_allowed_value ( -- replicate (verbose)
    id                          BIGINT NOT NULL,  -- PK
    series_attribute_type       INTEGER NOT NULL, -- references series_attribute_type.id
    value                       TEXT,
    parent                      INTEGER, -- references series_attribute_type_allowed_value.id
    child_order                 INTEGER NOT NULL DEFAULT 0,
    description                 TEXT,
    gid                         CHAR(36) NOT NULL
);

CREATE TABLE musicbrainz.series_attribute ( -- replicate (verbose)
    id                                  BIGINT NOT NULL,  -- PK
    series                              INTEGER NOT NULL, -- references series.id
    series_attribute_type               INTEGER NOT NULL, -- references series_attribute_type.id
    series_attribute_type_allowed_value INTEGER, -- references series_attribute_type_allowed_value.id
    series_attribute_text               TEXT
);

CREATE TABLE musicbrainz.series_tag ( -- replicate (verbose)
    series              INTEGER NOT NULL, -- PK, references series.id
    "tag"                 INTEGER NOT NULL, -- PK, references "tag".id
    count               INTEGER NOT NULL,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE musicbrainz.series_tag_raw (
    series              INTEGER NOT NULL, -- PK, references series.id
    editor              INTEGER NOT NULL, -- PK, references editor.id
    "tag"                 INTEGER NOT NULL, -- PK, references "tag".id
    is_upvote           BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE musicbrainz."tag" ( -- replicate (verbose)
    id                  BIGINT NOT NULL,
    name                VARCHAR(255) NOT NULL,
    ref_count           INTEGER NOT NULL DEFAULT 0
);

CREATE TABLE musicbrainz.tag_relation
(
    tag1                INTEGER NOT NULL, -- PK, references "tag".id
    tag2                INTEGER NOT NULL, -- PK, references "tag".id
    weight              INTEGER NOT NULL,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE musicbrainz.track ( -- replicate (verbose)
    id                  BIGINT NOT NULL,
    gid                 CHAR(36) NOT NULL,
    recording           INTEGER NOT NULL, -- references recording.id
    medium              INTEGER NOT NULL, -- references medium.id
    position            INTEGER NOT NULL,
    number              TEXT NOT NULL,
    name                VARCHAR(10000) NOT NULL,
    artist_credit       INTEGER NOT NULL, -- references artist_credit.id
    length              INTEGER ,
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    is_data_track       BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE musicbrainz.track_gid_redirect ( -- replicate (verbose)
    gid                 CHAR(36) NOT NULL, -- PK
    new_id              INTEGER NOT NULL, -- references track.id
    created             TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE musicbrainz.track_raw ( -- replicate
    id                  BIGINT NOT NULL, -- PK
    release             INTEGER NOT NULL,   -- references release_raw.id
    title               VARCHAR(255) NOT NULL,
    artist              VARCHAR(255),   -- For VA albums, otherwise empty
    sequence            INTEGER NOT NULL
);

CREATE TABLE musicbrainz.medium_index ( -- replicate
    medium              INTEGER, -- PK, references medium.id CASCADE
    toc                 SUPER
);

CREATE TABLE musicbrainz.url ( -- replicate
    id                  BIGINT NOT NULL,
    gid                 CHAR(36) NOT NULL,
    url                 VARCHAR(10455) NOT NULL,
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE musicbrainz.url_gid_redirect ( -- replicate
    gid                 CHAR(36) NOT NULL, -- PK
    new_id              INTEGER NOT NULL, -- references url.id
    created             TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE musicbrainz.vote
(
    id                  BIGINT NOT NULL,
    editor              INTEGER NOT NULL, -- references editor.id
    edit                INTEGER NOT NULL, -- references edit.id
    vote                INTEGER NOT NULL,
    vote_time            TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    superseded          BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE musicbrainz.work ( -- replicate (verbose)
    id                  BIGINT NOT NULL,
    gid                 CHAR(36) NOT NULL,
    name                VARCHAR(10000) NOT NULL,
    type                INTEGER, -- references work_type.id
    comment             VARCHAR(2550) NOT NULL DEFAULT '',
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE musicbrainz.work_language ( -- replicate (verbose)
    work                INTEGER NOT NULL, -- PK, references work.id
    language            INTEGER NOT NULL, -- PK, references language.id
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    created             TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE musicbrainz.work_rating_raw
(
    work                INTEGER NOT NULL, -- PK, references work.id
    editor              INTEGER NOT NULL, -- PK, references editor.id
    rating              INTEGER NOT NULL 
);

CREATE TABLE musicbrainz.work_tag_raw
(
    work                INTEGER NOT NULL, -- PK, references work.id
    editor              INTEGER NOT NULL, -- PK, references editor.id
    "tag"                 INTEGER NOT NULL, -- PK, references "tag".id
    is_upvote           BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE musicbrainz.work_alias_type ( -- replicate
    id                  BIGINT NOT NULL,
    name                TEXT NOT NULL,
    parent              INTEGER, -- references work_alias_type.id
    child_order         INTEGER NOT NULL DEFAULT 0,
    description         TEXT,
    gid                 CHAR(36) NOT NULL
);

CREATE TABLE musicbrainz.work_alias ( -- replicate (verbose)
    id                  BIGINT NOT NULL,
    work                INTEGER NOT NULL, -- references work.id
    name                VARCHAR(10000) NOT NULL,
    locale              TEXT,
    edits_pending       INTEGER NOT NULL DEFAULT 0 ,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    type                INTEGER, -- references work_alias_type.id
    sort_name           VARCHAR(10000) NOT NULL,
    begin_date_year     INTEGER,
    begin_date_month    INTEGER,
    begin_date_day      INTEGER,
    end_date_year       INTEGER,
    end_date_month      INTEGER,
    end_date_day        INTEGER,
    primary_for_locale  BOOLEAN NOT NULL DEFAULT false,
    ended               BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE musicbrainz.work_annotation ( -- replicate (verbose)
    work                INTEGER NOT NULL, -- PK, references work.id
    annotation          INTEGER NOT NULL -- PK, references annotation.id
);

CREATE TABLE musicbrainz.work_gid_redirect ( -- replicate (verbose)
    gid                 CHAR(36) NOT NULL, -- PK
    new_id              INTEGER NOT NULL, -- references work.id
    created             TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE musicbrainz.work_meta ( -- replicate
    id                  INTEGER NOT NULL, -- PK, references work.id CASCADE
    rating              INTEGER ,
    rating_count        INTEGER
);

CREATE TABLE musicbrainz.work_tag ( -- replicate (verbose)
    work                INTEGER NOT NULL, -- PK, references work.id
    "tag"                 INTEGER NOT NULL, -- PK, references "tag".id
    count               INTEGER NOT NULL,
    last_updated        TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE musicbrainz.work_type ( -- replicate
    id                  BIGINT NOT NULL,
    name                VARCHAR(255) NOT NULL,
    parent              INTEGER, -- references work_type.id
    child_order         INTEGER NOT NULL DEFAULT 0,
    description         TEXT,
    gid                 CHAR(36) NOT NULL
);

CREATE TABLE musicbrainz.work_attribute_type ( -- replicate (verbose)
    id                  BIGINT NOT NULL,  -- PK
    name                VARCHAR(255) NOT NULL,
    comment             VARCHAR(2550) NOT NULL DEFAULT '',
    free_text           BOOLEAN NOT NULL,
    parent              INTEGER, -- references work_attribute_type.id
    child_order         INTEGER NOT NULL DEFAULT 0,
    description         TEXT,
    gid                 CHAR(36) NOT NULL
);

CREATE TABLE musicbrainz.work_attribute_type_allowed_value ( -- replicate (verbose)
    id                  BIGINT NOT NULL,  -- PK
    work_attribute_type INTEGER NOT NULL, -- references work_attribute_type.id
    value               TEXT,
    parent              INTEGER, -- references work_attribute_type_allowed_value.id
    child_order         INTEGER NOT NULL DEFAULT 0,
    description         TEXT,
    gid                 CHAR(36) NOT NULL
);

CREATE TABLE musicbrainz.work_attribute ( -- replicate (verbose)
    id                                  BIGINT NOT NULL,  -- PK
    work                                INTEGER NOT NULL, -- references work.id
    work_attribute_type                 INTEGER NOT NULL, -- references work_attribute_type.id
    work_attribute_type_allowed_value   INTEGER, -- references work_attribute_type_allowed_value.id
    work_attribute_text                 TEXT
);

COMMIT;

-- vi: set ts=4 sw=4 et :