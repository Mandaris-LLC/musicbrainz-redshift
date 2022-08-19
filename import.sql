copy musicbrainz."alternative_release_type"
from 's3://your-s3-bucket/alternative_release_type.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."area"
from 's3://your-s3-bucket/area.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."area_alias"
from 's3://your-s3-bucket/area_alias.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."area_alias_type"
from 's3://your-s3-bucket/area_alias_type.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."area_gid_redirect"
from 's3://your-s3-bucket/area_gid_redirect.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."area_type"
from 's3://your-s3-bucket/area_type.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."artist"
from 's3://your-s3-bucket/artist.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."artist_alias"
from 's3://your-s3-bucket/artist_alias.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."artist_alias_type"
from 's3://your-s3-bucket/artist_alias_type.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."artist_credit"
from 's3://your-s3-bucket/artist_credit.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."artist_credit_gid_redirect"
from 's3://your-s3-bucket/artist_credit_gid_redirect.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."artist_credit_name"
from 's3://your-s3-bucket/artist_credit_name.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."artist_gid_redirect"
from 's3://your-s3-bucket/artist_gid_redirect.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."artist_ipi"
from 's3://your-s3-bucket/artist_ipi.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."artist_isni"
from 's3://your-s3-bucket/artist_isni.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."artist_type"
from 's3://your-s3-bucket/artist_type.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."cdtoc"
from 's3://your-s3-bucket/cdtoc.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."country_area"
from 's3://your-s3-bucket/country_area.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."editor_collection_type"
from 's3://your-s3-bucket/editor_collection_type.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."event"
from 's3://your-s3-bucket/event.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."event_alias"
from 's3://your-s3-bucket/event_alias.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."event_alias_type"
from 's3://your-s3-bucket/event_alias_type.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."event_gid_redirect"
from 's3://your-s3-bucket/event_gid_redirect.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."event_type"
from 's3://your-s3-bucket/event_type.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."gender"
from 's3://your-s3-bucket/gender.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."genre"
from 's3://your-s3-bucket/genre.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."genre_alias"
from 's3://your-s3-bucket/genre_alias.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."genre_alias_type"
from 's3://your-s3-bucket/genre_alias_type.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."instrument"
from 's3://your-s3-bucket/instrument.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."instrument_alias"
from 's3://your-s3-bucket/instrument_alias.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."instrument_alias_type"
from 's3://your-s3-bucket/instrument_alias_type.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."instrument_gid_redirect"
from 's3://your-s3-bucket/instrument_gid_redirect.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."instrument_type"
from 's3://your-s3-bucket/instrument_type.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."iso_3166_1"
from 's3://your-s3-bucket/iso_3166_1.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."iso_3166_2"
from 's3://your-s3-bucket/iso_3166_2.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."iso_3166_3"
from 's3://your-s3-bucket/iso_3166_3.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."isrc"
from 's3://your-s3-bucket/isrc.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."iswc"
from 's3://your-s3-bucket/iswc.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."l_area_area"
from 's3://your-s3-bucket/l_area_area.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."l_area_event"
from 's3://your-s3-bucket/l_area_event.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."l_area_instrument"
from 's3://your-s3-bucket/l_area_instrument.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."l_area_recording"
from 's3://your-s3-bucket/l_area_recording.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."l_area_release"
from 's3://your-s3-bucket/l_area_release.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."l_area_series"
from 's3://your-s3-bucket/l_area_series.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."l_area_url"
from 's3://your-s3-bucket/l_area_url.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."l_area_work"
from 's3://your-s3-bucket/l_area_work.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."l_artist_artist"
from 's3://your-s3-bucket/l_artist_artist.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."l_artist_event"
from 's3://your-s3-bucket/l_artist_event.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."l_artist_instrument"
from 's3://your-s3-bucket/l_artist_instrument.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."l_artist_label"
from 's3://your-s3-bucket/l_artist_label.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."l_artist_place"
from 's3://your-s3-bucket/l_artist_place.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."l_artist_recording"
from 's3://your-s3-bucket/l_artist_recording.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."l_artist_release"
from 's3://your-s3-bucket/l_artist_release.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."l_artist_release_group"
from 's3://your-s3-bucket/l_artist_release_group.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."l_artist_series"
from 's3://your-s3-bucket/l_artist_series.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."l_artist_url"
from 's3://your-s3-bucket/l_artist_url.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."l_artist_work"
from 's3://your-s3-bucket/l_artist_work.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."l_event_event"
from 's3://your-s3-bucket/l_event_event.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."l_event_place"
from 's3://your-s3-bucket/l_event_place.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."l_event_recording"
from 's3://your-s3-bucket/l_event_recording.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."l_event_release"
from 's3://your-s3-bucket/l_event_release.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."l_event_release_group"
from 's3://your-s3-bucket/l_event_release_group.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."l_event_series"
from 's3://your-s3-bucket/l_event_series.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."l_event_url"
from 's3://your-s3-bucket/l_event_url.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."l_event_work"
from 's3://your-s3-bucket/l_event_work.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."l_instrument_instrument"
from 's3://your-s3-bucket/l_instrument_instrument.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."l_instrument_label"
from 's3://your-s3-bucket/l_instrument_label.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."l_instrument_url"
from 's3://your-s3-bucket/l_instrument_url.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."l_label_label"
from 's3://your-s3-bucket/l_label_label.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."l_label_place"
from 's3://your-s3-bucket/l_label_place.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."l_label_recording"
from 's3://your-s3-bucket/l_label_recording.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."l_label_release"
from 's3://your-s3-bucket/l_label_release.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."l_label_release_group"
from 's3://your-s3-bucket/l_label_release_group.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."l_label_series"
from 's3://your-s3-bucket/l_label_series.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."l_label_url"
from 's3://your-s3-bucket/l_label_url.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."l_label_work"
from 's3://your-s3-bucket/l_label_work.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."l_place_place"
from 's3://your-s3-bucket/l_place_place.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."l_place_recording"
from 's3://your-s3-bucket/l_place_recording.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."l_place_release"
from 's3://your-s3-bucket/l_place_release.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."l_place_series"
from 's3://your-s3-bucket/l_place_series.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."l_place_url"
from 's3://your-s3-bucket/l_place_url.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."l_place_work"
from 's3://your-s3-bucket/l_place_work.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."l_recording_recording"
from 's3://your-s3-bucket/l_recording_recording.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."l_recording_release"
from 's3://your-s3-bucket/l_recording_release.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."l_recording_series"
from 's3://your-s3-bucket/l_recording_series.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."l_recording_url"
from 's3://your-s3-bucket/l_recording_url.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."l_recording_work"
from 's3://your-s3-bucket/l_recording_work.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."l_release_group_release_group"
from 's3://your-s3-bucket/l_release_group_release_group.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."l_release_group_series"
from 's3://your-s3-bucket/l_release_group_series.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."l_release_group_url"
from 's3://your-s3-bucket/l_release_group_url.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."l_release_release"
from 's3://your-s3-bucket/l_release_release.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."l_release_series"
from 's3://your-s3-bucket/l_release_series.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."l_release_url"
from 's3://your-s3-bucket/l_release_url.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."l_series_series"
from 's3://your-s3-bucket/l_series_series.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."l_series_url"
from 's3://your-s3-bucket/l_series_url.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."l_series_work"
from 's3://your-s3-bucket/l_series_work.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."l_url_work"
from 's3://your-s3-bucket/l_url_work.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."l_work_work"
from 's3://your-s3-bucket/l_work_work.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."label"
from 's3://your-s3-bucket/label.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."label_alias"
from 's3://your-s3-bucket/label_alias.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."label_alias_type"
from 's3://your-s3-bucket/label_alias_type.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."label_gid_redirect"
from 's3://your-s3-bucket/label_gid_redirect.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."label_ipi"
from 's3://your-s3-bucket/label_ipi.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."label_isni"
from 's3://your-s3-bucket/label_isni.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."label_type"
from 's3://your-s3-bucket/label_type.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."language"
from 's3://your-s3-bucket/language.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."link"
from 's3://your-s3-bucket/link.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."link_attribute"
from 's3://your-s3-bucket/link_attribute.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."link_attribute_credit"
from 's3://your-s3-bucket/link_attribute_credit.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."link_attribute_text_value"
from 's3://your-s3-bucket/link_attribute_text_value.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."link_attribute_type"
from 's3://your-s3-bucket/link_attribute_type.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."link_creditable_attribute_type"
from 's3://your-s3-bucket/link_creditable_attribute_type.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."link_text_attribute_type"
from 's3://your-s3-bucket/link_text_attribute_type.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."link_type"
from 's3://your-s3-bucket/link_type.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."link_type_attribute_type"
from 's3://your-s3-bucket/link_type_attribute_type.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."medium"
from 's3://your-s3-bucket/medium.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."medium_cdtoc"
from 's3://your-s3-bucket/medium_cdtoc.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."medium_format"
from 's3://your-s3-bucket/medium_format.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."orderable_link_type"
from 's3://your-s3-bucket/orderable_link_type.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."place"
from 's3://your-s3-bucket/place.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."place_alias"
from 's3://your-s3-bucket/place_alias.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."place_alias_type"
from 's3://your-s3-bucket/place_alias_type.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."place_gid_redirect"
from 's3://your-s3-bucket/place_gid_redirect.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."place_type"
from 's3://your-s3-bucket/place_type.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."recording"
from 's3://your-s3-bucket/recording.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."recording_alias"
from 's3://your-s3-bucket/recording_alias.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."recording_alias_type"
from 's3://your-s3-bucket/recording_alias_type.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."recording_gid_redirect"
from 's3://your-s3-bucket/recording_gid_redirect.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."release"
from 's3://your-s3-bucket/release.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."release_alias"
from 's3://your-s3-bucket/release_alias.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."release_alias_type"
from 's3://your-s3-bucket/release_alias_type.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."release_country"
from 's3://your-s3-bucket/release_country.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."release_gid_redirect"
from 's3://your-s3-bucket/release_gid_redirect.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."release_group"
from 's3://your-s3-bucket/release_group.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."release_group_alias"
from 's3://your-s3-bucket/release_group_alias.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."release_group_alias_type"
from 's3://your-s3-bucket/release_group_alias_type.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."release_group_gid_redirect"
from 's3://your-s3-bucket/release_group_gid_redirect.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."release_group_primary_type"
from 's3://your-s3-bucket/release_group_primary_type.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."release_group_secondary_type"
from 's3://your-s3-bucket/release_group_secondary_type.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."release_group_secondary_type_join"
from 's3://your-s3-bucket/release_group_secondary_type_join.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."release_label"
from 's3://your-s3-bucket/release_label.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."release_packaging"
from 's3://your-s3-bucket/release_packaging.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."release_status"
from 's3://your-s3-bucket/release_status.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."release_unknown_country"
from 's3://your-s3-bucket/release_unknown_country.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."replication_control"
from 's3://your-s3-bucket/replication_control.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."script"
from 's3://your-s3-bucket/script.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."series"
from 's3://your-s3-bucket/series.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."series_alias"
from 's3://your-s3-bucket/series_alias.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."series_alias_type"
from 's3://your-s3-bucket/series_alias_type.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."series_gid_redirect"
from 's3://your-s3-bucket/series_gid_redirect.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."series_ordering_type"
from 's3://your-s3-bucket/series_ordering_type.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."series_type"
from 's3://your-s3-bucket/series_type.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."track"
from 's3://your-s3-bucket/track.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."track_gid_redirect"
from 's3://your-s3-bucket/track_gid_redirect.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."url"
from 's3://your-s3-bucket/url.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."url_gid_redirect"
from 's3://your-s3-bucket/url_gid_redirect.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."work"
from 's3://your-s3-bucket/work.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."work_alias"
from 's3://your-s3-bucket/work_alias.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."work_alias_type"
from 's3://your-s3-bucket/work_alias_type.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."work_attribute"
from 's3://your-s3-bucket/work_attribute.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."work_attribute_type"
from 's3://your-s3-bucket/work_attribute_type.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."work_attribute_type_allowed_value"
from 's3://your-s3-bucket/work_attribute_type_allowed_value.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."work_gid_redirect"
from 's3://your-s3-bucket/work_gid_redirect.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."work_language"
from 's3://your-s3-bucket/work_language.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';

copy musicbrainz."work_type"
from 's3://your-s3-bucket/work_type.csv'
iam_role 'arn:aws:iam::${Account}:role/service-role/${RedshiftServiceRole}'
DELIMITER '\t';
