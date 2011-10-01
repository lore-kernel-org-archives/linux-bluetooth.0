Return-Path: <cyrus@holtmann.org>
Message-ID: <5971ECDF3C444062AE63B0DAE7A10EDC@freqoneremote>
From: "David Stockwell" <dstockwell@frequency-one.com>
To: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>,
	<linux-bluetooth@vger.kernel.org>
References: <1317388243-26240-1-git-send-email-luiz.dentz@gmail.com> <1317388243-26240-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1317388243-26240-2-git-send-email-luiz.dentz@gmail.com>
Subject: Re: [PATCH BlueZ 1/4] AVRCP: move MediaPlayer to adapter object
Date: Fri, 30 Sep 2011 19:51:58 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi guys,

-----Original Message----- 
From: Luiz Augusto von Dentz
Sent: Friday, September 30, 2011 8:10 AM
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/4] AVRCP: move MediaPlayer to adapter object

+++++
I like this approach, and would like to try things out, but cannot seem to 
access git.kernel.org.  Do you have another git tree somewhere?

Also, any idea on when the next BlueZ release will come out?

Thanks in advance
DS
+++++

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This move the MediaPlayer registration to adapter object on Media
interface so we can track players properly.
---
audio/avrcp.c     |  824 
++++++++++-------------------------------------------
audio/avrcp.h     |   67 ++++-
audio/device.c    |    3 -
audio/device.h    |    2 -
audio/manager.c   |    7 -
audio/media.c     |  800 +++++++++++++++++++++++++++++++++++++++++++++++++++
doc/media-api.txt |  163 +++++++++++
7 files changed, 1181 insertions(+), 685 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index ba04a12..872f7a8 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -78,54 +78,10 @@
#define AVRCP_GET_PLAY_STATUS 0x30
#define AVRCP_REGISTER_NOTIFICATION 0x31

-/* Notification events */
-#define AVRCP_EVENT_PLAYBACK_STATUS_CHANGED 0x01
-#define AVRCP_EVENT_TRACK_CHANGED 0x02
-
/* Capabilities for AVRCP_GET_CAPABILITIES pdu */
#define CAP_COMPANY_ID 0x02
#define CAP_EVENTS_SUPPORTED 0x03

-enum player_setting {
- PLAYER_SETTING_EQUALIZER = 1,
- PLAYER_SETTING_REPEAT = 2,
- PLAYER_SETTING_SHUFFLE = 3,
- PLAYER_SETTING_SCAN = 4,
-};
-
-enum equalizer_mode {
- EQUALIZER_MODE_OFF = 1,
- EQUALIZER_MODE_ON = 2,
-};
-
-enum repeat_mode {
- REPEAT_MODE_OFF = 1,
- REPEAT_MODE_SINGLE = 2,
- REPEAT_MODE_ALL = 3,
- REPEAT_MODE_GROUP = 4,
-};
-
-enum shuffle_mode {
- SHUFFLE_MODE_OFF = 1,
- SHUFFLE_MODE_ALL = 2,
- SHUFFLE_MODE_GROUP = 3,
-};
-
-enum scan_mode {
- SCAN_MODE_OFF = 1,
- SCAN_MODE_ALL = 2,
- SCAN_MODE_GROUP = 3,
-};
-
-enum play_status {
- PLAY_STATUS_STOPPED = 0x00,
- PLAY_STATUS_PLAYING = 0x01,
- PLAY_STATUS_PAUSED = 0x02,
- PLAY_STATUS_FWD_SEEK = 0x03,
- PLAY_STATUS_REV_SEEK = 0x04,
- PLAY_STATUS_ERROR = 0xFF
-};
-
enum battery_status {
  BATTERY_STATUS_NORMAL = 0,
  BATTERY_STATUS_WARNING = 1,
@@ -134,17 +90,6 @@ enum battery_status {
  BATTERY_STATUS_FULL_CHARGE = 4,
};

-enum media_info_id {
- MEDIA_INFO_TITLE = 1,
- MEDIA_INFO_ARTIST = 2,
- MEDIA_INFO_ALBUM = 3,
- MEDIA_INFO_TRACK = 4,
- MEDIA_INFO_N_TRACKS = 5,
- MEDIA_INFO_GENRE = 6,
- MEDIA_INFO_PLAYING_TIME = 7,
- MEDIA_INFO_LAST
-};
-
#if __BYTE_ORDER == __LITTLE_ENDIAN

struct avrcp_header {
@@ -180,33 +125,26 @@ struct avrcp_server {
  bdaddr_t src;
  uint32_t tg_record_id;
  uint32_t ct_record_id;
+ GSList *players;
+ struct avrcp_player *active_player;
};

-struct media_info {
- char *title;
- char *artist;
- char *album;
- char *genre;
- uint32_t ntracks;
- uint32_t track;
- uint32_t track_len;
- uint32_t elapsed;
-};
-
-struct media_player {
+struct avrcp_player {
+ struct avrcp_server *server;
  struct avctp *session;
  struct audio_device *dev;
- uint8_t settings[PLAYER_SETTING_SCAN + 1];
- enum play_status status;

- struct media_info mi;
- GTimer *timer;
  unsigned int handler;
  uint16_t registered_events;
  uint8_t transaction_events[AVRCP_EVENT_TRACK_CHANGED + 1];
+
+ struct avrcp_player_cb *cb;
+ void *user_data;
+ GDestroyNotify destroy;
};

static GSList *servers = NULL;
+static unsigned int avctp_id = 0;

/* Company IDs supported by this device */
static uint32_t company_ids[] = {
@@ -344,164 +282,19 @@ static sdp_record_t *avrcp_tg_record(void)
static unsigned int attr_get_max_val(uint8_t attr)
{
  switch (attr) {
- case PLAYER_SETTING_EQUALIZER:
- return EQUALIZER_MODE_ON;
- case PLAYER_SETTING_REPEAT:
- return REPEAT_MODE_GROUP;
- case PLAYER_SETTING_SHUFFLE:
- return SHUFFLE_MODE_GROUP;
- case PLAYER_SETTING_SCAN:
- return SCAN_MODE_GROUP;
+ case AVRCP_ATTRIBUTE_EQUALIZER:
+ return AVRCP_EQUALIZER_ON;
+ case AVRCP_ATTRIBUTE_REPEAT_MODE:
+ return AVRCP_REPEAT_MODE_GROUP;
+ case AVRCP_ATTRIBUTE_SHUFFLE:
+ return AVRCP_SHUFFLE_GROUP;
+ case AVRCP_ATTRIBUTE_SCAN:
+ return AVRCP_SCAN_GROUP;
  }

  return 0;
}

-static const char *attrval_to_str(uint8_t attr, uint8_t value)
-{
- switch (attr) {
- case PLAYER_SETTING_EQUALIZER:
- switch (value) {
- case EQUALIZER_MODE_ON:
- return "on";
- case EQUALIZER_MODE_OFF:
- return "off";
- }
-
- break;
- case PLAYER_SETTING_REPEAT:
- switch (value) {
- case REPEAT_MODE_OFF:
- return "off";
- case REPEAT_MODE_SINGLE:
- return "singletrack";
- case REPEAT_MODE_ALL:
- return "alltracks";
- case REPEAT_MODE_GROUP:
- return "group";
- }
-
- break;
- /* Shuffle and scan have the same values */
- case PLAYER_SETTING_SHUFFLE:
- case PLAYER_SETTING_SCAN:
- switch (value) {
- case SCAN_MODE_OFF:
- return "off";
- case SCAN_MODE_ALL:
- return "alltracks";
- case SCAN_MODE_GROUP:
- return "group";
- }
-
- break;
- }
-
- return NULL;
-}
-
-static int attrval_to_val(uint8_t attr, const char *value)
-{
- int ret;
-
- switch (attr) {
- case PLAYER_SETTING_EQUALIZER:
- if (!strcmp(value, "off"))
- ret = EQUALIZER_MODE_OFF;
- else if (!strcmp(value, "on"))
- ret = EQUALIZER_MODE_ON;
- else
- ret = -EINVAL;
-
- return ret;
- case PLAYER_SETTING_REPEAT:
- if (!strcmp(value, "off"))
- ret = REPEAT_MODE_OFF;
- else if (!strcmp(value, "singletrack"))
- ret = REPEAT_MODE_SINGLE;
- else if (!strcmp(value, "alltracks"))
- ret = REPEAT_MODE_ALL;
- else if (!strcmp(value, "group"))
- ret = REPEAT_MODE_GROUP;
- else
- ret = -EINVAL;
-
- return ret;
- case PLAYER_SETTING_SHUFFLE:
- if (!strcmp(value, "off"))
- ret = SHUFFLE_MODE_OFF;
- else if (!strcmp(value, "alltracks"))
- ret = SHUFFLE_MODE_ALL;
- else if (!strcmp(value, "group"))
- ret = SHUFFLE_MODE_GROUP;
- else
- ret = -EINVAL;
-
- return ret;
- case PLAYER_SETTING_SCAN:
- if (!strcmp(value, "off"))
- ret = SCAN_MODE_OFF;
- else if (!strcmp(value, "alltracks"))
- ret = SCAN_MODE_ALL;
- else if (!strcmp(value, "group"))
- ret = SCAN_MODE_GROUP;
- else
- ret = -EINVAL;
-
- return ret;
- }
-
- return -EINVAL;
-}
-
-static const char *attr_to_str(uint8_t attr)
-{
- switch (attr) {
- case PLAYER_SETTING_EQUALIZER:
- return "Equalizer";
- case PLAYER_SETTING_REPEAT:
- return "Repeat";
- case PLAYER_SETTING_SHUFFLE:
- return "Shuffle";
- case PLAYER_SETTING_SCAN:
- return "Scan";
- }
-
- return NULL;
-}
-
-static int attr_to_val(const char *str)
-{
- if (!strcmp(str, "Equalizer"))
- return PLAYER_SETTING_EQUALIZER;
- else if (!strcmp(str, "Repeat"))
- return PLAYER_SETTING_REPEAT;
- else if (!strcmp(str, "Shuffle"))
- return PLAYER_SETTING_SHUFFLE;
- else if (!strcmp(str, "Scan"))
- return PLAYER_SETTING_SCAN;
-
- return -EINVAL;
-}
-
-static int play_status_to_val(const char *status)
-{
- if (!strcmp(status, "stopped"))
- return PLAY_STATUS_STOPPED;
- else if (!strcmp(status, "playing"))
- return PLAY_STATUS_PLAYING;
- else if (!strcmp(status, "paused"))
- return PLAY_STATUS_PAUSED;
- else if (!strcmp(status, "forward-seek"))
- return PLAY_STATUS_FWD_SEEK;
- else if (!strcmp(status, "reverse-seek"))
- return PLAY_STATUS_REV_SEEK;
- else if (!strcmp(status, "error"))
- return PLAY_STATUS_ERROR;
-
- return -EINVAL;
-}
-
static const char *battery_status_to_str(enum battery_status status)
{
  switch (status) {
@@ -542,17 +335,17 @@ static void set_company_id(uint8_t cid[3], const 
uint32_t cid_in)
  cid[2] = cid_in;
}

-static int avrcp_send_event(struct media_player *mp, uint8_t id, void 
*data)
+int avrcp_player_event(struct avrcp_player *player, uint8_t id, void *data)
{
  uint8_t buf[AVRCP_HEADER_LENGTH + 9];
  struct avrcp_header *pdu = (void *) buf;
  uint16_t size;
  int err;

- if (mp->session)
+ if (player->session)
  return -ENOTCONN;

- if (!(mp->registered_events & (1 << id)))
+ if (!(player->registered_events & (1 << id)))
  return 0;

  memset(buf, 0, sizeof(buf));
@@ -565,7 +358,7 @@ static int avrcp_send_event(struct media_player *mp, 
uint8_t id, void *data)
  DBG("id=%u", id);

  switch (id) {
- case AVRCP_EVENT_PLAYBACK_STATUS_CHANGED:
+ case AVRCP_EVENT_STATUS_CHANGED:
  size = 2;
  pdu->params[1] = *((uint8_t *)data);

@@ -589,58 +382,18 @@ static int avrcp_send_event(struct media_player *mp, 
uint8_t id, void *data)

  pdu->params_len = htons(size);

- err = avctp_send_vendordep(mp->session, mp->transaction_events[id],
+ err = avctp_send_vendordep(player->session, 
player->transaction_events[id],
  AVC_CTYPE_CHANGED, AVC_SUBUNIT_PANEL,
  buf, size);
  if (err < 0)
  return err;

  /* Unregister event as per AVRCP 1.3 spec, section 5.4.2 */
- mp->registered_events ^= 1 << id;
+ player->registered_events ^= 1 << id;

  return 0;
}

-static void mp_get_playback_status(struct media_player *mp, uint8_t 
*status,
- uint32_t *elapsed, uint32_t *track_len)
-{
- if (status)
- *status = mp->status;
- if (track_len)
- *track_len = mp->mi.track_len;
-
- if (!elapsed)
- return;
-
- *elapsed = mp->mi.elapsed;
-
- if (mp->status == PLAY_STATUS_PLAYING) {
- double timedelta = g_timer_elapsed(mp->timer, NULL);
- uint32_t sec, msec;
-
- sec = (uint32_t) timedelta;
- msec = (uint32_t)((timedelta - sec) * 1000);
-
- *elapsed += sec * 1000 + msec;
- }
-}
-
-static void mp_set_playback_status(struct media_player *mp, uint8_t status,
- uint32_t elapsed)
-{
- DBG("Change playback: %u %u", status, elapsed);
-
- mp->mi.elapsed = elapsed;
- g_timer_start(mp->timer);
-
- if (status == mp->status)
- return;
-
- mp->status = status;
-
- avrcp_send_event(mp, AVRCP_EVENT_PLAYBACK_STATUS_CHANGED, &status);
-}
-
/*
  * Copy media_info field to a buffer, intended to be used in a response to
  * GetElementAttributes message.
@@ -651,7 +404,7 @@ static void mp_set_playback_status(struct media_player 
*mp, uint8_t status,
  * If @param id is not valid, -EINVAL is returned. If there's no such media
  * attribute, -ENOENT is returned.
  */
-static int mp_get_media_attribute(struct media_player *mp,
+static int player_get_media_attribute(struct avrcp_player *player,
  uint32_t id, uint8_t *buf,
  uint16_t maxlen)
{
@@ -661,11 +414,10 @@ static int mp_get_media_attribute(struct media_player 
*mp,
  uint16_t len;
  uint8_t val[];
  };
- const struct media_info *mi = &mp->mi;
  struct media_info_elem *elem = (void *)buf;
  uint16_t len;
  char valstr[20];
- char *valp;
+ void *value;

  if (maxlen < sizeof(struct media_info_elem))
  return -ENOBUFS;
@@ -673,64 +425,35 @@ static int mp_get_media_attribute(struct media_player 
*mp,
  /* Subtract the size of elem header from the available space */
  maxlen -= sizeof(struct media_info_elem);

- switch (id) {
- case MEDIA_INFO_TITLE:
- valp = mi->title;
- break;
- case MEDIA_INFO_ARTIST:
- if (mi->artist == NULL)
- return -ENOENT;
-
- valp = mi->artist;
- break;
- case MEDIA_INFO_ALBUM:
- if (mi->album == NULL)
- return -ENOENT;
-
- valp = mi->album;
- break;
- case MEDIA_INFO_GENRE:
- if (mi->genre == NULL)
- return -ENOENT;
+ DBG("Get media attribute: %u", id);

- valp = mi->genre;
- break;
- case MEDIA_INFO_TRACK:
- if (!mi->track)
- return -ENOENT;
-
- snprintf(valstr, 20, "%u", mi->track);
- valp = valstr;
- break;
- case MEDIA_INFO_N_TRACKS:
- if (!mi->ntracks)
- return -ENOENT;
+ value = player->cb->get_metadata(id, player->user_data);
+ if (value == NULL)
+ return -ENOENT;

- snprintf(valstr, 20, "%u", mi->ntracks);
- valp = valstr;
+ switch (id) {
+ case AVRCP_MEDIA_ATTRIBUTE_TITLE:
+ case AVRCP_MEDIA_ATTRIBUTE_ARTIST:
+ case AVRCP_MEDIA_ATTRIBUTE_ALBUM:
+ case AVRCP_MEDIA_ATTRIBUTE_GENRE:
+ len = strlen((char *) value);
+ if (len > maxlen)
+ return -ENOBUFS;
+ memcpy(elem->val, value, len);
  break;
- case MEDIA_INFO_PLAYING_TIME:
- if (mi->track_len == 0xFFFFFFFF)
- return -ENOENT;
-
- snprintf(valstr, 20, "%u", mi->track_len);
- valp = valstr;
+ case AVRCP_MEDIA_ATTRIBUTE_TRACK:
+ case AVRCP_MEDIA_ATTRIBUTE_N_TRACKS:
+ case AVRCP_MEDIA_ATTRIBUTE_DURATION:
+ snprintf(valstr, 20, "%u", GPOINTER_TO_UINT(value));
+ len = strlen(valstr);
+ if (len > maxlen)
+ return -ENOBUFS;
+ memcpy(elem->val, valstr, len);
  break;
  default:
  return -EINVAL;
  }

- if (valp) {
- len = strlen(valp);
-
- if (len > maxlen)
- return -ENOBUFS;
-
- memcpy(elem->val, valp, len);
- } else {
- len = 0;
- }
-
  elem->id = htonl(id);
  elem->charset = htons(0x6A); /* Always use UTF-8 */
  elem->len = htons(len);
@@ -738,57 +461,22 @@ static int mp_get_media_attribute(struct media_player 
*mp,
  return sizeof(struct media_info_elem) + len;
}

-static void mp_set_attribute(struct media_player *mp,
+static void player_set_attribute(struct avrcp_player *player,
  uint8_t attr, uint8_t val)
{
  DBG("Change attribute: %u %u", attr, val);

- mp->settings[attr] = val;
+ player->cb->set_setting(attr, val, player->user_data);
}

-static int mp_get_attribute(struct media_player *mp, uint8_t attr)
+static int player_get_attribute(struct avrcp_player *player, uint8_t attr)
{
  DBG("Get attribute: %u", attr);

- return mp->settings[attr];
-}
-
-static void mp_set_media_attributes(struct media_player *mp,
- struct media_info *mi)
-{
- g_free(mp->mi.title);
- mp->mi.title = g_strdup(mi->title);
-
- g_free(mp->mi.artist);
- mp->mi.artist = g_strdup(mi->artist);
-
- g_free(mp->mi.album);
- mp->mi.album = g_strdup(mi->album);
-
- g_free(mp->mi.genre);
- mp->mi.genre = g_strdup(mi->genre);
-
- mp->mi.ntracks = mi->ntracks;
- mp->mi.track = mi->track;
- mp->mi.track_len = mi->track_len;
-
- /*
- * elapsed is special. Whenever the track changes, we reset it to 0,
- * so client doesn't have to make another call to change_playback
- */
- mp->mi.elapsed = 0;
- g_timer_start(mp->timer);
-
- DBG("Track changed:\n\ttitle: %s\n\tartist: %s\n\talbum: %s\n"
- "\tgenre: %s\n\tNumber of tracks: %u\n"
- "\tTrack number: %u\n\tTrack duration: %u",
- mi->title, mi->artist, mi->album, mi->genre,
- mi->ntracks, mi->track, mi->track_len);
-
- avrcp_send_event(mp, AVRCP_EVENT_TRACK_CHANGED, NULL);
+ return player->cb->get_setting(attr, player->user_data);
}

-static uint8_t avrcp_handle_get_capabilities(struct media_player *mp,
+static uint8_t avrcp_handle_get_capabilities(struct avrcp_player *player,
  struct avrcp_header *pdu,
  uint8_t transaction)
{
@@ -814,7 +502,7 @@ static uint8_t avrcp_handle_get_capabilities(struct 
media_player *mp,
  case CAP_EVENTS_SUPPORTED:
  pdu->params_len = htons(4);
  pdu->params[1] = 2;
- pdu->params[2] = AVRCP_EVENT_PLAYBACK_STATUS_CHANGED;
+ pdu->params[2] = AVRCP_EVENT_STATUS_CHANGED;
  pdu->params[3] = AVRCP_EVENT_TRACK_CHANGED;

  return AVC_CTYPE_STABLE;
@@ -827,7 +515,7 @@ err:
  return AVC_CTYPE_REJECTED;
}

-static uint8_t avrcp_handle_list_player_attributes(struct media_player *mp,
+static uint8_t avrcp_handle_list_player_attributes(struct avrcp_player 
*player,
  struct avrcp_header *pdu,
  uint8_t transaction)
{
@@ -840,11 +528,11 @@ static uint8_t 
avrcp_handle_list_player_attributes(struct media_player *mp,
  return AVC_CTYPE_REJECTED;
  }

- if (!mp)
+ if (!player)
  goto done;

- for (i = 1; i <= PLAYER_SETTING_SCAN; i++) {
- if (!mp_get_attribute(mp, i)) {
+ for (i = 1; i <= AVRCP_ATTRIBUTE_SCAN; i++) {
+ if (!player_get_attribute(player, i)) {
  DBG("Ignoring setting %u: not supported by player", i);
  continue;
  }
@@ -860,14 +548,14 @@ done:
  return AVC_CTYPE_STABLE;
}

-static uint8_t avrcp_handle_list_player_values(struct media_player *mp,
+static uint8_t avrcp_handle_list_player_values(struct avrcp_player *player,
  struct avrcp_header *pdu,
  uint8_t transaction)
{
  uint16_t len = ntohs(pdu->params_len);
  unsigned int i;

- if (len != 1 || !mp)
+ if (len != 1 || !player)
  goto err;

  len = attr_get_max_val(pdu->params[0]);
@@ -890,7 +578,7 @@ err:
  return AVC_CTYPE_REJECTED;
}

-static uint8_t avrcp_handle_get_element_attributes(struct media_player *mp,
+static uint8_t avrcp_handle_get_element_attributes(struct avrcp_player 
*player,
  struct avrcp_header *pdu,
  uint8_t transaction)
{
@@ -913,8 +601,9 @@ static uint8_t 
avrcp_handle_get_element_attributes(struct media_player *mp,
  * Return all available information, at least
  * title must be returned.
  */
- for (i = 1; i < MEDIA_INFO_LAST; i++) {
- size = mp_get_media_attribute(mp, i, &pdu->params[pos],
+ for (i = 1; i < AVRCP_MEDIA_ATTRIBUTE_LAST; i++) {
+ size = player_get_media_attribute(player, i,
+ &pdu->params[pos],
  AVRCP_PDU_MTU - pos);

  if (size > 0) {
@@ -930,7 +619,7 @@ static uint8_t 
avrcp_handle_get_element_attributes(struct media_player *mp,
  for (i = 0; i < nattr; i++) {
  uint32_t attr = ntohl(attr_ids[i]);

- size = mp_get_media_attribute(mp, attr,
+ size = player_get_media_attribute(player, attr,
  &pdu->params[pos],
  AVRCP_PDU_MTU - pos);

@@ -956,7 +645,7 @@ err:
  return AVC_CTYPE_REJECTED;
}

-static uint8_t avrcp_handle_get_current_player_value(struct media_player 
*mp,
+static uint8_t avrcp_handle_get_current_player_value(struct avrcp_player 
*player,
  struct avrcp_header *pdu,
  uint8_t transaction)
{
@@ -964,7 +653,7 @@ static uint8_t 
avrcp_handle_get_current_player_value(struct media_player *mp,
  uint8_t *settings;
  unsigned int i;

- if (mp == NULL || len <= 1 || pdu->params[0] != len - 1)
+ if (player == NULL || len <= 1 || pdu->params[0] != len - 1)
  goto err;

  /*
@@ -982,13 +671,13 @@ static uint8_t 
avrcp_handle_get_current_player_value(struct media_player *mp,
  for (i = 0; i < pdu->params[0]; i++) {
  uint8_t val;

- if (settings[i] < PLAYER_SETTING_EQUALIZER ||
- settings[i] > PLAYER_SETTING_SCAN) {
+ if (settings[i] < AVRCP_ATTRIBUTE_EQUALIZER ||
+ settings[i] > AVRCP_ATTRIBUTE_SCAN) {
  DBG("Ignoring %u", settings[i]);
  continue;
  }

- val = mp_get_attribute(mp, settings[i]);
+ val = player_get_attribute(player, settings[i]);
  if (!val) {
  DBG("Ignoring %u: not supported by player",
  settings[i]);
@@ -1017,7 +706,7 @@ err:
  return AVC_CTYPE_REJECTED;
}

-static uint8_t avrcp_handle_set_player_value(struct media_player *mp,
+static uint8_t avrcp_handle_set_player_value(struct avrcp_player *player,
  struct avrcp_header *pdu,
  uint8_t transaction)
{
@@ -1039,23 +728,10 @@ static uint8_t avrcp_handle_set_player_value(struct 
media_player *mp,
  for (i = 1; i < pdu->params[0]; i += 2) {
  uint8_t attr = pdu->params[i];
  uint8_t val = pdu->params[i + 1];
- const char *attrstr;
- const char *valstr;
-
- attrstr = attr_to_str(attr);
- if (!attrstr)
- continue;
-
- valstr = attrval_to_str(attr, val);
- if (!valstr)
- continue;

  len++;

- mp_set_attribute(mp, attr, val);
- emit_property_changed(mp->dev->conn, mp->dev->path,
- MEDIA_PLAYER_INTERFACE, attrstr,
- DBUS_TYPE_STRING, &valstr);
+ player_set_attribute(player, attr, val);
  }

  if (len) {
@@ -1070,7 +746,7 @@ err:
  return AVC_CTYPE_REJECTED;
}

-static uint8_t avrcp_handle_displayable_charset(struct media_player *mp,
+static uint8_t avrcp_handle_displayable_charset(struct avrcp_player 
*player,
  struct avrcp_header *pdu,
  uint8_t transaction)
{
@@ -1090,7 +766,7 @@ static uint8_t avrcp_handle_displayable_charset(struct 
media_player *mp,
  return AVC_CTYPE_STABLE;
}

-static uint8_t avrcp_handle_ct_battery_status(struct media_player *mp,
+static uint8_t avrcp_handle_ct_battery_status(struct avrcp_player *player,
  struct avrcp_header *pdu,
  uint8_t transaction)
{
@@ -1104,9 +780,6 @@ static uint8_t avrcp_handle_ct_battery_status(struct 
media_player *mp,
  if (valstr == NULL)
  goto err;

- emit_property_changed(mp->dev->conn, mp->dev->path,
- MEDIA_PLAYER_INTERFACE, "Battery",
- DBUS_TYPE_STRING, &valstr);
  pdu->params_len = 0;

  return AVC_CTYPE_STABLE;
@@ -1117,14 +790,13 @@ err:
  return AVC_CTYPE_REJECTED;
}

-static uint8_t avrcp_handle_get_play_status(struct media_player *mp,
+static uint8_t avrcp_handle_get_play_status(struct avrcp_player *player,
  struct avrcp_header *pdu,
  uint8_t transaction)
{
  uint16_t len = ntohs(pdu->params_len);
- uint32_t elapsed;
- uint32_t track_len;
- uint8_t status;
+ uint32_t position;
+ uint32_t duration;

  if (len != 0) {
  pdu->params_len = htons(1);
@@ -1132,25 +804,28 @@ static uint8_t avrcp_handle_get_play_status(struct 
media_player *mp,
  return AVC_CTYPE_REJECTED;
  }

- mp_get_playback_status(mp, &status, &elapsed, &track_len);
- track_len = htonl(track_len);
- elapsed = htonl(elapsed);
+ position = player->cb->get_position(player->user_data);
+ duration = GPOINTER_TO_UINT(player->cb->get_metadata(
+ AVRCP_MEDIA_ATTRIBUTE_DURATION,
+ player->user_data));
+
+ duration = htonl(duration);
+ position = htonl(position);

- memcpy(&pdu->params[0], &track_len, 4);
- memcpy(&pdu->params[4], &elapsed, 4);
- pdu->params[8] = status;
+ memcpy(&pdu->params[0], &duration, 4);
+ memcpy(&pdu->params[4], &position, 4);
+ pdu->params[8] = player->cb->get_status(player->user_data);;

  pdu->params_len = htons(9);

  return AVC_CTYPE_STABLE;
}

-static uint8_t avrcp_handle_register_notification(struct media_player *mp,
+static uint8_t avrcp_handle_register_notification(struct avrcp_player 
*player,
  struct avrcp_header *pdu,
  uint8_t transaction)
{
  uint16_t len = ntohs(pdu->params_len);
- uint8_t status;

  /*
  * 1 byte for EventID, 4 bytes for Playback interval but the latest
@@ -1161,10 +836,9 @@ static uint8_t 
avrcp_handle_register_notification(struct media_player *mp,
  goto err;

  switch (pdu->params[0]) {
- case AVRCP_EVENT_PLAYBACK_STATUS_CHANGED:
+ case AVRCP_EVENT_STATUS_CHANGED:
  len = 2;
- mp_get_playback_status(mp, &status, NULL, NULL);
- pdu->params[1] = status;
+ pdu->params[1] = player->cb->get_status(player->user_data);

  break;
  case AVRCP_EVENT_TRACK_CHANGED:
@@ -1179,8 +853,8 @@ static uint8_t 
avrcp_handle_register_notification(struct media_player *mp,
  }

  /* Register event and save the transaction used */
- mp->registered_events |= (1 << pdu->params[0]);
- mp->transaction_events[pdu->params[0]] = transaction;
+ player->registered_events |= (1 << pdu->params[0]);
+ player->transaction_events[pdu->params[0]] = transaction;

  pdu->params_len = htons(len);

@@ -1195,7 +869,7 @@ err:
static struct pdu_handler {
  uint8_t pdu_id;
  uint8_t code;
- uint8_t (*func) (struct media_player *mp,
+ uint8_t (*func) (struct avrcp_player *player,
  struct avrcp_header *pdu,
  uint8_t transaction);
} handlers[] = {
@@ -1232,7 +906,7 @@ static size_t handle_vendordep_pdu(struct avctp 
*session, uint8_t transaction,
  uint8_t *operands, size_t operand_count,
  void *user_data)
{
- struct media_player *mp = user_data;
+ struct avrcp_player *player = user_data;
  struct pdu_handler *handler;
  struct avrcp_header *pdu = (void *) operands;
  uint32_t company_id = get_company_id(pdu->company_id);
@@ -1268,7 +942,7 @@ static size_t handle_vendordep_pdu(struct avctp 
*session, uint8_t transaction,
  goto err_metadata;
  }

- *code = handler->func(mp, pdu, transaction);
+ *code = handler->func(player, pdu, transaction);

  return AVRCP_HEADER_LENGTH + ntohs(pdu->params_len);

@@ -1279,52 +953,56 @@ err_metadata:
  return AVRCP_HEADER_LENGTH + 1;
}

+static struct avrcp_server *find_server(GSList *list, const bdaddr_t *src)
+{
+ for (; list; list = list->next) {
+ struct avrcp_server *server = list->data;
+
+ if (bacmp(&server->src, src) == 0)
+ return server;
+ }
+
+ return NULL;
+}
+
static void state_changed(struct audio_device *dev, avctp_state_t old_state,
  avctp_state_t new_state, void *user_data)
{
- struct media_player *mp = dev->media_player;
+ struct avrcp_server *server;
+ struct avrcp_player *player;

+ server = find_server(servers, &dev->src);
+ if (!server)
+ return;

- if (!mp)
+ player = server->active_player;
+ if (!player)
  return;

  switch (new_state) {
  case AVCTP_STATE_DISCONNECTED:
- mp->session = NULL;
+ player->session = NULL;

- if (mp->handler) {
- avctp_unregister_pdu_handler(mp->handler);
- mp->handler = 0;
+ if (player->handler) {
+ avctp_unregister_pdu_handler(player->handler);
+ player->handler = 0;
  }

  break;
  case AVCTP_STATE_CONNECTING:
- mp->session = avctp_connect(&dev->src, &dev->dst);
+ player->session = avctp_connect(&dev->src, &dev->dst);

- if (!mp->handler)
- mp->handler = avctp_register_pdu_handler(
+ if (!player->handler)
+ player->handler = avctp_register_pdu_handler(
  AVC_OP_VENDORDEP,
  handle_vendordep_pdu,
- mp);
+ player);
  break;
  default:
  return;
  }
}

-static void media_info_init(struct media_info *mi)
-{
- memset(mi, 0, sizeof(*mi));
-
- /*
- * As per section 5.4.1 of AVRCP 1.3 spec, return 0xFFFFFFFF if TG
- * does not support these attributes (i.e. they were never set via
- * D-Bus)
- */
- mi->track_len = 0xFFFFFFFF;
- mi->elapsed = 0xFFFFFFFF;
-}
-
gboolean avrcp_connect(struct audio_device *dev)
{
  struct avctp *session;
@@ -1347,8 +1025,6 @@ void avrcp_disconnect(struct audio_device *dev)
  avctp_disconnect(session);
}

-static unsigned int avctp_id = 0;
-
int avrcp_register(DBusConnection *conn, const bdaddr_t *src, GKeyFile 
*config)
{
  sdp_record_t *record;
@@ -1393,7 +1069,7 @@ int avrcp_register(DBusConnection *conn, const 
bdaddr_t *src, GKeyFile *config)
  }

  if (add_record_to_server(src, record) < 0) {
- error("Unable to register AVRCP mpler service record");
+ error("Unable to register AVRCP service record");
  sdp_record_free(record);
  g_free(server);
  return -1;
@@ -1414,16 +1090,14 @@ int avrcp_register(DBusConnection *conn, const 
bdaddr_t *src, GKeyFile *config)
  return 0;
}

-static struct avrcp_server *find_server(GSList *list, const bdaddr_t *src)
+static void player_destroy(gpointer data)
{
- for (; list; list = list->next) {
- struct avrcp_server *server = list->data;
+ struct avrcp_player *player = data;

- if (bacmp(&server->src, src) == 0)
- return server;
- }
+ if (player->destroy)
+ player->destroy(player->user_data);

- return NULL;
+ g_free(player);
}

void avrcp_unregister(const bdaddr_t *src)
@@ -1434,6 +1108,8 @@ void avrcp_unregister(const bdaddr_t *src)
  if (!server)
  return;

+ g_slist_free_full(server->players, player_destroy);
+
  servers = g_slist_remove(servers, server);

  remove_record_from_server(server->ct_record_id);
@@ -1449,235 +1125,43 @@ void avrcp_unregister(const bdaddr_t *src)
  avctp_remove_state_cb(avctp_id);
}

-static DBusMessage *mp_set_property(DBusConnection *conn,
- DBusMessage *msg, void *data)
+struct avrcp_player *avrcp_register_player(const bdaddr_t *src,
+ struct avrcp_player_cb *cb,
+ void *user_data,
+ GDestroyNotify destroy)
{
- struct audio_device *device = data;
- struct media_player *mp = device->media_player;
- DBusMessageIter iter;
- DBusMessageIter var;
- const char *attrstr, *valstr;
- int attr, val;
-
- if (!dbus_message_iter_init(msg, &iter))
- return btd_error_invalid_args(msg);
-
- if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
- return btd_error_invalid_args(msg);
-
- dbus_message_iter_get_basic(&iter, &attrstr);
-
- attr = attr_to_val(attrstr);
- if (attr < 0)
- return btd_error_not_supported(msg);
-
- dbus_message_iter_next(&iter);
-
- if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_VARIANT)
- return btd_error_invalid_args(msg);
-
- dbus_message_iter_recurse(&iter, &var);
-
- /* Only string arguments are supported for now */
- if (dbus_message_iter_get_arg_type(&var) != DBUS_TYPE_STRING)
- return btd_error_invalid_args(msg);
-
- dbus_message_iter_get_basic(&var, &valstr);
-
- val = attrval_to_val(attr, valstr);
- if (val < 0)
- return btd_error_not_supported(msg);
-
- mp_set_attribute(mp, attr, val);
-
- return dbus_message_new_method_return(msg);
-}
-
-static DBusMessage *mp_change_playback(DBusConnection *conn,
- DBusMessage *msg, void *data)
-{
- struct audio_device *device = data;
- struct media_player *mp = device->media_player;
- const char *statusstr;
- int status;
- uint32_t elapsed;
-
- if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &statusstr,
- DBUS_TYPE_UINT32, &elapsed,
- DBUS_TYPE_INVALID))
- return btd_error_invalid_args(msg);
-
- status = play_status_to_val(statusstr);
- if (status < 0)
- return btd_error_invalid_args(msg);
-
- mp_set_playback_status(mp, status, elapsed);
-
- return dbus_message_new_method_return(msg);
-}
-
-static gboolean media_info_parse(DBusMessageIter *iter, struct media_info 
*mi)
-{
- DBusMessageIter dict;
- DBusMessageIter var;
- int ctype;
-
- ctype = dbus_message_iter_get_arg_type(iter);
- if (ctype != DBUS_TYPE_ARRAY)
- return FALSE;
-
- media_info_init(mi);
- dbus_message_iter_recurse(iter, &dict);
-
- while ((ctype = dbus_message_iter_get_arg_type(&dict)) !=
- DBUS_TYPE_INVALID) {
- DBusMessageIter entry;
- const char *key;
-
- if (ctype != DBUS_TYPE_DICT_ENTRY)
- return FALSE;
-
- dbus_message_iter_recurse(&dict, &entry);
- if (dbus_message_iter_get_arg_type(&entry) != DBUS_TYPE_STRING)
- return FALSE;
-
- dbus_message_iter_get_basic(&entry, &key);
- dbus_message_iter_next(&entry);
-
- if (dbus_message_iter_get_arg_type(&entry) != DBUS_TYPE_VARIANT)
- return FALSE;
-
- dbus_message_iter_recurse(&entry, &var);
-
- if (!strcmp(key, "Title")) {
- if (dbus_message_iter_get_arg_type(&var) !=
- DBUS_TYPE_STRING)
- return FALSE;
-
- dbus_message_iter_get_basic(&var, &mi->title);
- } else if (!strcmp(key, "Artist")) {
- if (dbus_message_iter_get_arg_type(&var) !=
- DBUS_TYPE_STRING)
- return FALSE;
-
- dbus_message_iter_get_basic(&var, &mi->artist);
- } else if (!strcmp(key, "Album")) {
- if (dbus_message_iter_get_arg_type(&var) !=
- DBUS_TYPE_STRING)
- return FALSE;
-
- dbus_message_iter_get_basic(&var, &mi->album);
- } else if (!strcmp(key, "Genre")) {
- if (dbus_message_iter_get_arg_type(&var) !=
- DBUS_TYPE_STRING)
- return FALSE;
-
- dbus_message_iter_get_basic(&var, &mi->genre);
- } else if (!strcmp(key, "NumberOfTracks")) {
- if (dbus_message_iter_get_arg_type(&var) !=
- DBUS_TYPE_UINT32)
- return FALSE;
-
- dbus_message_iter_get_basic(&var, &mi->ntracks);
- } else if (!strcmp(key, "TrackNumber")) {
- if (dbus_message_iter_get_arg_type(&var) !=
- DBUS_TYPE_UINT32)
- return FALSE;
-
- dbus_message_iter_get_basic(&var, &mi->track);
- } else if (!strcmp(key, "TrackDuration")) {
- if (dbus_message_iter_get_arg_type(&var) !=
- DBUS_TYPE_UINT32)
- return FALSE;
-
- dbus_message_iter_get_basic(&var, &mi->track_len);
- } else {
- return FALSE;
- }
-
- dbus_message_iter_next(&dict);
- }
-
- if (mi->title == NULL)
- return FALSE;
-
- return TRUE;
-}
-
-static DBusMessage *mp_change_track(DBusConnection *conn,
- DBusMessage *msg, void *data)
-{
- struct audio_device *device = data;
- struct media_player *mp = device->media_player;
- DBusMessageIter iter;
- struct media_info mi;
-
-
- dbus_message_iter_init(msg, &iter);
- if (!media_info_parse(&iter, &mi))
- return btd_error_invalid_args(msg);
-
- mp_set_media_attributes(mp, &mi);
-
- return dbus_message_new_method_return(msg);
-}
-
-static GDBusMethodTable mp_methods[] = {
- { "SetProperty", "sv", "", mp_set_property },
- { "ChangePlayback", "su", "", mp_change_playback },
- { "ChangeTrack", "a{sv}", "", mp_change_track },
- { }
-};
+ struct avrcp_server *server;
+ struct avrcp_player *player;

-static GDBusSignalTable mp_signals[] = {
- { "PropertyChanged", "sv" },
- { }
-};
+ server = find_server(servers, src);
+ if (!server)
+ return NULL;

-static void mp_path_unregister(void *data)
-{
- struct audio_device *dev = data;
- struct media_player *mp = dev->media_player;
+ player = g_new0(struct avrcp_player, 1);
+ player->server = server;
+ player->cb = cb;
+ player->user_data = user_data;
+ player->destroy = destroy;

- DBG("Unregistered interface %s on path %s",
- MEDIA_PLAYER_INTERFACE, dev->path);
+ if (!server->players)
+ server->active_player = player;

- if (mp->handler)
- avctp_unregister_pdu_handler(mp->handler);
+ if (!avctp_id)
+ avctp_id = avctp_add_state_cb(state_changed, NULL);

- g_timer_destroy(mp->timer);
- g_free(mp);
-}
+ server->players = g_slist_append(server->players, player);

-void media_player_unregister(struct audio_device *dev)
-{
- g_dbus_unregister_interface(dev->conn, dev->path,
- MEDIA_PLAYER_INTERFACE);
+ return player;
}

-struct media_player *media_player_init(struct audio_device *dev)
+void avrcp_unregister_player(struct avrcp_player *player)
{
- struct media_player *mp;
-
- if (!g_dbus_register_interface(dev->conn, dev->path,
- MEDIA_PLAYER_INTERFACE,
- mp_methods, mp_signals, NULL,
- dev, mp_path_unregister)) {
- error("D-Bus failed do register %s on path %s",
- MEDIA_PLAYER_INTERFACE, dev->path);
- return NULL;
- }
+ struct avrcp_server *server = player->server;

- DBG("Registered interface %s on path %s",
- MEDIA_PLAYER_INTERFACE, dev->path);
+ server->players = g_slist_remove(server->players, player);

- mp = g_new0(struct media_player, 1);
- mp->timer = g_timer_new();
- mp->dev = dev;
- media_info_init(&mp->mi);
-
- if (!avctp_id)
- avctp_id = avctp_add_state_cb(state_changed, NULL);
+ if (server->active_player == player)
+ server->active_player = g_slist_nth_data(server->players, 0);

- return mp;
+ player_destroy(player);
}
diff --git a/audio/avrcp.h b/audio/avrcp.h
index 1fd912d..f47fefe 100644
--- a/audio/avrcp.h
+++ b/audio/avrcp.h
@@ -22,7 +22,63 @@
  *
  */

-#define MEDIA_PLAYER_INTERFACE "org.bluez.MediaPlayer"
+/* player attributes */
+#define AVRCP_ATTRIBUTE_ILEGAL 0x00
+#define AVRCP_ATTRIBUTE_EQUALIZER 0x01
+#define AVRCP_ATTRIBUTE_REPEAT_MODE 0x02
+#define AVRCP_ATTRIBUTE_SHUFFLE 0x03
+#define AVRCP_ATTRIBUTE_SCAN 0x04
+
+/* equalizer values */
+#define AVRCP_EQUALIZER_ON 0x01
+#define AVRCP_EQUALIZER_OFF 0x02
+
+/* repeat mode values */
+#define AVRCP_REPEAT_MODE_OFF 0x01
+#define AVRCP_REPEAT_MODE_SINGLE 0x02
+#define AVRCP_REPEAT_MODE_ALL 0x03
+#define AVRCP_REPEAT_MODE_GROUP 0x04
+
+/* shuffle values */
+#define AVRCP_SHUFFLE_OFF 0x01
+#define AVRCP_SHUFFLE_ALL 0x02
+#define AVRCP_SHUFFLE_GROUP 0x03
+
+/* scan values */
+#define AVRCP_SCAN_OFF 0x01
+#define AVRCP_SCAN_ALL 0x02
+#define AVRCP_SCAN_GROUP 0x03
+
+/* media attributes */
+#define AVRCP_MEDIA_ATTRIBUTE_ILLEGAL 0x00
+#define AVRCP_MEDIA_ATTRIBUTE_TITLE 0x01
+#define AVRCP_MEDIA_ATTRIBUTE_ARTIST 0x02
+#define AVRCP_MEDIA_ATTRIBUTE_ALBUM 0x03
+#define AVRCP_MEDIA_ATTRIBUTE_TRACK 0x04
+#define AVRCP_MEDIA_ATTRIBUTE_N_TRACKS 0x05
+#define AVRCP_MEDIA_ATTRIBUTE_GENRE 0x06
+#define AVRCP_MEDIA_ATTRIBUTE_DURATION 0x07
+#define AVRCP_MEDIA_ATTRIBUTE_LAST AVRCP_MEDIA_ATTRIBUTE_DURATION
+
+/* play status */
+#define AVRCP_PLAY_STATUS_STOPPED 0x00
+#define AVRCP_PLAY_STATUS_PLAYING 0x01
+#define AVRCP_PLAY_STATUS_PAUSED 0x02
+#define AVRCP_PLAY_STATUS_FWD_SEEK 0x03
+#define AVRCP_PLAY_STATUS_REV_SEEK 0x04
+#define AVRCP_PLAY_STATUS_ERROR 0xFF
+
+/* Notification events */
+#define AVRCP_EVENT_STATUS_CHANGED 0x01
+#define AVRCP_EVENT_TRACK_CHANGED 0x02
+
+struct avrcp_player_cb {
+ int (*get_setting) (uint8_t attr, void *user_data);
+ void (*set_setting) (uint8_t attr, uint8_t value, void *user_data);
+ void *(*get_metadata) (uint32_t id, void *user_data);
+ uint8_t (*get_status) (void *user_data);
+ uint32_t (*get_position) (void *user_data);
+};

int avrcp_register(DBusConnection *conn, const bdaddr_t *src, GKeyFile 
*config);
void avrcp_unregister(const bdaddr_t *src);
@@ -30,5 +86,10 @@ void avrcp_unregister(const bdaddr_t *src);
gboolean avrcp_connect(struct audio_device *dev);
void avrcp_disconnect(struct audio_device *dev);

-struct media_player *media_player_init(struct audio_device *dev);
-void media_player_unregister(struct audio_device *dev);
+struct avrcp_player *avrcp_register_player(const bdaddr_t *src,
+ struct avrcp_player_cb *cb,
+ void *user_data,
+ GDestroyNotify destroy);
+void avrcp_unregister_player(struct avrcp_player *player);
+
+int avrcp_player_event(struct avrcp_player *player, uint8_t id, void 
*data);
diff --git a/audio/device.c b/audio/device.c
index f455bcf..a9d35f9 100644
--- a/audio/device.c
+++ b/audio/device.c
@@ -731,9 +731,6 @@ void audio_device_unregister(struct audio_device 
*device)
  if (device->control)
  control_unregister(device);

- if (device->media_player)
- media_player_unregister(device);
-
  g_dbus_unregister_interface(device->conn, device->path,
  AUDIO_INTERFACE);

diff --git a/audio/device.h b/audio/device.h
index 9645d93..5117fca 100644
--- a/audio/device.h
+++ b/audio/device.h
@@ -44,7 +44,6 @@ struct target;
struct sink;
struct headset;
struct gateway;
-struct media_player;
struct dev_priv;

struct audio_device {
@@ -63,7 +62,6 @@ struct audio_device {
  struct source *source;
  struct control *control;
  struct target *target;
- struct media_player *media_player;

  guint hs_preauth_id;

diff --git a/audio/manager.c b/audio/manager.c
index 06d3f0e..7ec0311 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -119,7 +119,6 @@ static struct enabled_interfaces enabled = {
  .control = TRUE,
  .socket = TRUE,
  .media = FALSE,
- .media_player = FALSE,
};

static struct audio_adapter *find_adapter(GSList *list,
@@ -224,8 +223,6 @@ static void handle_uuid(const char *uuidstr, struct 
audio_device *device)
  else
  device->control = control_init(device, uuid16);

- if (enabled.media_player && !device->media_player)
- device->media_player = media_player_init(device);
  if (device->sink && sink_is_active(device))
  avrcp_connect(device);
  break;
@@ -1177,8 +1174,6 @@ int audio_manager_init(DBusConnection *conn, GKeyFile 
*conf,
  enabled.socket = TRUE;
  else if (g_str_equal(list[i], "Media"))
  enabled.media = TRUE;
- else if (g_str_equal(list[i], "MediaPlayer"))
- enabled.media_player = TRUE;

  }
  g_strfreev(list);
@@ -1200,8 +1195,6 @@ int audio_manager_init(DBusConnection *conn, GKeyFile 
*conf,
  enabled.socket = FALSE;
  else if (g_str_equal(list[i], "Media"))
  enabled.media = FALSE;
- else if (g_str_equal(list[i], "MediaPlayer"))
- enabled.media_player = FALSE;
  }
  g_strfreev(list);

diff --git a/audio/media.c b/audio/media.c
index 5ab3eab..6f7d9d7 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -42,6 +42,7 @@
#include "media.h"
#include "transport.h"
#include "a2dp.h"
+#include "avrcp.h"
#include "headset.h"
#include "gateway.h"
#include "manager.h"
@@ -52,6 +53,7 @@

#define MEDIA_INTERFACE "org.bluez.Media"
#define MEDIA_ENDPOINT_INTERFACE "org.bluez.MediaEndpoint"
+#define MEDIA_PLAYER_INTERFACE "org.bluez.MediaPlayer"

#define REQUEST_TIMEOUT (3 * 1000) /* 3 seconds */

@@ -60,6 +62,7 @@ struct media_adapter {
  char *path; /* Adapter path */
  DBusConnection *conn; /* Adapter connection */
  GSList *endpoints; /* Endpoints list */
+ GSList *players; /* Players list */
};

struct endpoint_request {
@@ -86,6 +89,29 @@ struct media_endpoint {
  struct media_adapter *adapter;
};

+struct media_player {
+ struct media_adapter *adapter;
+ struct avrcp_player *player;
+ char *sender; /* Player DBus bus id */
+ char *path; /* Player object path */
+ GHashTable *settings; /* Player settings */
+ GHashTable *track; /* Player current track */
+ guint watch;
+ guint property_watch;
+ guint track_watch;
+ uint8_t status;
+ uint32_t position;
+ GTimer *timer;
+};
+
+struct metadata_value {
+ int type;
+ union {
+ char *str;
+ uint32_t num;
+ } value;
+};
+
static GSList *adapters = NULL;

static void endpoint_request_free(struct endpoint_request *request)
@@ -822,9 +848,783 @@ static DBusMessage *unregister_endpoint(DBusConnection 
*conn, DBusMessage *msg,
  return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
}

+static struct media_player *media_adapter_find_player(
+ struct media_adapter *adapter,
+ const char *sender,
+ const char *path)
+{
+ GSList *l;
+
+ for (l = adapter->endpoints; l; l = l->next) {
+ struct media_player *mp = l->data;
+
+ if (sender && g_strcmp0(mp->sender, sender) != 0)
+ continue;
+
+ if (path && g_strcmp0(mp->path, path) != 0)
+ continue;
+
+ return mp;
+ }
+
+ return NULL;
+}
+
+static void media_player_free(gpointer data)
+{
+ struct media_player *mp = data;
+ struct media_adapter *adapter = mp->adapter;
+
+ g_dbus_remove_watch(adapter->conn, mp->watch);
+ g_dbus_remove_watch(adapter->conn, mp->property_watch);
+ g_dbus_remove_watch(adapter->conn, mp->track_watch);
+
+ if (mp->track)
+ g_hash_table_unref(mp->track);
+
+ if (mp->settings)
+ g_hash_table_unref(mp->settings);
+
+ g_free(mp->sender);
+ g_free(mp->path);
+ g_free(mp);
+}
+
+static void media_player_destroy(struct media_player *mp)
+{
+ DBG("sender=%s path=%s", mp->sender, mp->path);
+
+ if (mp->player) {
+ avrcp_unregister_player(mp->player);
+ return;
+ }
+
+ media_player_free(mp);
+}
+
+static void media_player_remove(struct media_player *mp)
+{
+ info("Player unregistered: sender=%s path=%s", mp->sender, mp->path);
+
+ media_player_destroy(mp);
+}
+
+static const char *attrval_to_str(uint8_t attr, uint8_t value)
+{
+ switch (attr) {
+ case AVRCP_ATTRIBUTE_EQUALIZER:
+ switch (value) {
+ case AVRCP_EQUALIZER_ON:
+ return "on";
+ case AVRCP_EQUALIZER_OFF:
+ return "off";
+ }
+
+ break;
+ case AVRCP_ATTRIBUTE_REPEAT_MODE:
+ switch (value) {
+ case AVRCP_REPEAT_MODE_OFF:
+ return "off";
+ case AVRCP_REPEAT_MODE_SINGLE:
+ return "singletrack";
+ case AVRCP_REPEAT_MODE_ALL:
+ return "alltracks";
+ case AVRCP_REPEAT_MODE_GROUP:
+ return "group";
+ }
+
+ break;
+ /* Shuffle and scan have the same values */
+ case AVRCP_ATTRIBUTE_SHUFFLE:
+ case AVRCP_ATTRIBUTE_SCAN:
+ switch (value) {
+ case AVRCP_SCAN_OFF:
+ return "off";
+ case AVRCP_SCAN_ALL:
+ return "alltracks";
+ case AVRCP_SCAN_GROUP:
+ return "group";
+ }
+
+ break;
+ }
+
+ return NULL;
+}
+
+static int attrval_to_val(uint8_t attr, const char *value)
+{
+ int ret;
+
+ switch (attr) {
+ case AVRCP_ATTRIBUTE_EQUALIZER:
+ if (!strcmp(value, "off"))
+ ret = AVRCP_EQUALIZER_OFF;
+ else if (!strcmp(value, "on"))
+ ret = AVRCP_EQUALIZER_ON;
+ else
+ ret = -EINVAL;
+
+ return ret;
+ case AVRCP_ATTRIBUTE_REPEAT_MODE:
+ if (!strcmp(value, "off"))
+ ret = AVRCP_REPEAT_MODE_OFF;
+ else if (!strcmp(value, "singletrack"))
+ ret = AVRCP_REPEAT_MODE_SINGLE;
+ else if (!strcmp(value, "alltracks"))
+ ret = AVRCP_REPEAT_MODE_ALL;
+ else if (!strcmp(value, "group"))
+ ret = AVRCP_REPEAT_MODE_GROUP;
+ else
+ ret = -EINVAL;
+
+ return ret;
+ case AVRCP_ATTRIBUTE_SHUFFLE:
+ if (!strcmp(value, "off"))
+ ret = AVRCP_SHUFFLE_OFF;
+ else if (!strcmp(value, "alltracks"))
+ ret = AVRCP_SHUFFLE_ALL;
+ else if (!strcmp(value, "group"))
+ ret = AVRCP_SHUFFLE_GROUP;
+ else
+ ret = -EINVAL;
+
+ return ret;
+ case AVRCP_ATTRIBUTE_SCAN:
+ if (!strcmp(value, "off"))
+ ret = AVRCP_SCAN_OFF;
+ else if (!strcmp(value, "alltracks"))
+ ret = AVRCP_SCAN_ALL;
+ else if (!strcmp(value, "group"))
+ ret = AVRCP_SCAN_GROUP;
+ else
+ ret = -EINVAL;
+
+ return ret;
+ }
+
+ return -EINVAL;
+}
+
+static const char *attr_to_str(uint8_t attr)
+{
+ switch (attr) {
+ case AVRCP_ATTRIBUTE_EQUALIZER:
+ return "Equalizer";
+ case AVRCP_ATTRIBUTE_REPEAT_MODE:
+ return "Repeat";
+ case AVRCP_ATTRIBUTE_SHUFFLE:
+ return "Shuffle";
+ case AVRCP_ATTRIBUTE_SCAN:
+ return "Scan";
+ }
+
+ return NULL;
+}
+
+static int attr_to_val(const char *str)
+{
+ if (!strcasecmp(str, "Equalizer"))
+ return AVRCP_ATTRIBUTE_EQUALIZER;
+ else if (!strcasecmp(str, "Repeat"))
+ return AVRCP_ATTRIBUTE_REPEAT_MODE;
+ else if (!strcasecmp(str, "Shuffle"))
+ return AVRCP_ATTRIBUTE_SHUFFLE;
+ else if (!strcasecmp(str, "Scan"))
+ return AVRCP_ATTRIBUTE_SCAN;
+
+ return -EINVAL;
+}
+
+static int play_status_to_val(const char *status)
+{
+ if (!strcasecmp(status, "stopped"))
+ return AVRCP_PLAY_STATUS_STOPPED;
+ else if (!strcasecmp(status, "playing"))
+ return AVRCP_PLAY_STATUS_PLAYING;
+ else if (!strcasecmp(status, "paused"))
+ return AVRCP_PLAY_STATUS_PAUSED;
+ else if (!strcasecmp(status, "forward-seek"))
+ return AVRCP_PLAY_STATUS_FWD_SEEK;
+ else if (!strcasecmp(status, "reverse-seek"))
+ return AVRCP_PLAY_STATUS_REV_SEEK;
+ else if (!strcasecmp(status, "error"))
+ return AVRCP_PLAY_STATUS_ERROR;
+
+ return -EINVAL;
+}
+
+static int metadata_to_val(const char *str)
+{
+ if (!strcasecmp(str, "Title"))
+ return AVRCP_MEDIA_ATTRIBUTE_TITLE;
+ else if (!strcasecmp(str, "Artist"))
+ return AVRCP_MEDIA_ATTRIBUTE_ARTIST;
+ else if (!strcasecmp(str, "Album"))
+ return AVRCP_MEDIA_ATTRIBUTE_ALBUM;
+ else if (!strcasecmp(str, "Genre"))
+ return AVRCP_MEDIA_ATTRIBUTE_GENRE;
+ else if (!strcasecmp(str, "NumberOfTracks"))
+ return AVRCP_MEDIA_ATTRIBUTE_N_TRACKS;
+ else if (!strcasecmp(str, "Number"))
+ return AVRCP_MEDIA_ATTRIBUTE_TRACK;
+ else if (!strcasecmp(str, "Duration"))
+ return AVRCP_MEDIA_ATTRIBUTE_DURATION;
+
+ return -EINVAL;
+}
+
+static const char *metadata_to_str(uint32_t id)
+{
+ switch (id) {
+ case AVRCP_MEDIA_ATTRIBUTE_TITLE:
+ return "Title";
+ case AVRCP_MEDIA_ATTRIBUTE_ARTIST:
+ return "Artist";
+ case AVRCP_MEDIA_ATTRIBUTE_ALBUM:
+ return "Album";
+ case AVRCP_MEDIA_ATTRIBUTE_GENRE:
+ return "Genre";
+ case AVRCP_MEDIA_ATTRIBUTE_TRACK:
+ return "Track";
+ case AVRCP_MEDIA_ATTRIBUTE_N_TRACKS:
+ return "NumberOfTracks";
+ case AVRCP_MEDIA_ATTRIBUTE_DURATION:
+ return "Duration";
+ }
+
+ return NULL;
+}
+
+static int get_setting(uint8_t attr, void *user_data)
+{
+ struct media_player *mp = user_data;
+ void *value;
+
+ DBG("%s", attr_to_str(attr));
+
+ value = g_hash_table_lookup(mp->settings, GUINT_TO_POINTER(attr));
+ if (!value)
+ return -EINVAL;
+
+ return GPOINTER_TO_UINT(value);
+}
+
+static void set_setting(uint8_t attr, uint8_t val, void *user_data)
+{
+ struct media_player *mp = user_data;
+ struct media_adapter *adapter = mp->adapter;
+ const char *property, *value;
+ DBusMessage *msg;
+ DBusMessageIter iter, var;
+
+ property = attr_to_str(attr);
+ value = attrval_to_str(attr, val);
+
+ DBG("%s = %s", property, value);
+
+ if (property == NULL || value == NULL)
+ return;
+
+ msg = dbus_message_new_method_call(mp->sender, mp->path,
+ MEDIA_PLAYER_INTERFACE,
+ "SetProperty");
+ if (msg == NULL) {
+ error("Couldn't allocate D-Bus message");
+ return;
+ }
+
+ dbus_message_iter_init_append(msg, &iter);
+ dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &property);
+
+ dbus_message_iter_open_container(&iter, DBUS_TYPE_VARIANT,
+ DBUS_TYPE_STRING_AS_STRING,
+ &var);
+ dbus_message_iter_append_basic(&var, DBUS_TYPE_STRING, &value);
+ dbus_message_iter_close_container(&iter, &var);
+
+ g_dbus_send_message(adapter->conn, msg);
+}
+
+static void *get_metadata(uint32_t id, void *user_data)
+{
+ struct media_player *mp = user_data;
+ struct metadata_value *value;
+
+ DBG("%s", metadata_to_str(id));
+
+ value = g_hash_table_lookup(mp->track, GUINT_TO_POINTER(id));
+ if (!value) {
+ if (id == AVRCP_MEDIA_ATTRIBUTE_TITLE)
+ return "";
+ return NULL;
+ }
+
+ switch (value->type) {
+ case DBUS_TYPE_STRING:
+ return value->value.str;
+ case DBUS_TYPE_UINT32:
+ return GUINT_TO_POINTER(value->value.num);
+ }
+
+ return NULL;
+}
+
+static uint8_t get_status(void *user_data)
+{
+ struct media_player *mp = user_data;
+
+ return mp->status;
+}
+
+static uint32_t get_position(void *user_data)
+{
+ struct media_player *mp = user_data;
+ double timedelta;
+ uint32_t sec;
+
+ if (mp->status != AVRCP_PLAY_STATUS_PLAYING)
+ return mp->position;
+
+ timedelta = g_timer_elapsed(mp->timer, NULL);
+ sec = (uint32_t) timedelta;
+
+ return (uint32_t) ((timedelta - sec) * 1000);
+}
+
+static struct avrcp_player_cb player_cb = {
+ .get_setting = get_setting,
+ .set_setting = set_setting,
+ .get_metadata = get_metadata,
+ .get_position = get_position,
+ .get_status = get_status
+};
+
+static void media_player_exit(DBusConnection *connection, void *user_data)
+{
+ struct media_player *mp = user_data;
+
+ mp->watch = 0;
+ media_player_remove(mp);
+}
+
+static gboolean set_status(struct media_player *mp, DBusMessageIter *iter)
+{
+ const char *value;
+ int val;
+
+ if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_STRING)
+ return FALSE;
+
+ dbus_message_iter_get_basic(iter, &value);
+ DBG("Status=%s", value);
+
+ val = play_status_to_val(value);
+ if (val < 0) {
+ error("Invalid status");
+ return FALSE; }
+
+ mp->status = val;
+ if (mp->status == val)
+ return TRUE;
+
+ avrcp_player_event(mp->player, AVRCP_EVENT_STATUS_CHANGED, &val);
+
+ return TRUE;
+}
+
+static gboolean set_position(struct media_player *mp, DBusMessageIter 
*iter)
+{
+ uint32_t value;
+
+ if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_UINT32)
+ return FALSE;
+
+ dbus_message_iter_get_basic(iter, &value);
+ DBG("Position=%u", value);
+
+ mp->position = value;
+ g_timer_start(mp->timer);
+
+ return TRUE;
+}
+
+static gboolean set_property(struct media_player *mp, const char *key,
+ DBusMessageIter *entry)
+{
+ DBusMessageIter var;
+ const char *value;
+ int attr, val;
+
+ if (dbus_message_iter_get_arg_type(entry) != DBUS_TYPE_VARIANT)
+ return FALSE;
+
+ dbus_message_iter_recurse(entry, &var);
+
+ if (strcasecmp(key, "Status") == 0)
+ return set_status(mp, &var);
+
+ if (strcasecmp(key, "Position") == 0)
+ return set_position(mp, &var);
+
+ attr = attr_to_val(key);
+ if (attr < 0)
+ return FALSE;
+
+ if (dbus_message_iter_get_arg_type(&var) != DBUS_TYPE_STRING)
+ return FALSE;
+
+ dbus_message_iter_get_basic(&var, &value);
+
+ val = attrval_to_val(attr, value);
+ if (val < 0)
+ return FALSE;
+
+ DBG("%s=%s", key, value);
+
+ if (!mp->settings)
+ mp->settings = g_hash_table_new(g_direct_hash, g_direct_equal);
+
+ g_hash_table_replace(mp->settings, GUINT_TO_POINTER(attr),
+ GUINT_TO_POINTER(val));
+
+ return TRUE;
+}
+
+static gboolean property_changed(DBusConnection *connection, DBusMessage 
*msg,
+ void *user_data)
+{
+ struct media_player *mp = user_data;
+ DBusMessageIter iter, entry;
+ const char *property;
+
+ DBG("sender=%s path=%s", mp->sender, mp->path);
+
+ dbus_message_iter_init(msg, &iter);
+
+ if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING) {
+ error("Unexpected signature in %s.%s signal",
+ dbus_message_get_interface(msg),
+ dbus_message_get_member(msg));
+ return TRUE;
+ }
+
+ dbus_message_iter_get_basic(&iter, &property);
+
+ dbus_message_iter_next(&iter);
+ dbus_message_iter_recurse(&iter, &entry);
+
+ set_property(mp, property, &entry);
+
+ return TRUE;
+}
+
+static void metadata_value_free(gpointer data)
+{
+ struct metadata_value *value = data;
+
+ switch (value->type) {
+ case DBUS_TYPE_STRING:
+ g_free(value->value.str);
+ break;
+ }
+
+ g_free(value);
+}
+
+static gboolean parse_player_metadata(struct media_player *mp,
+ DBusMessageIter *iter)
+{
+ DBusMessageIter dict;
+ DBusMessageIter var;
+ int ctype;
+ gboolean title = FALSE;
+
+ ctype = dbus_message_iter_get_arg_type(iter);
+ if (ctype != DBUS_TYPE_ARRAY)
+ return FALSE;
+
+ dbus_message_iter_recurse(iter, &dict);
+
+ while ((ctype = dbus_message_iter_get_arg_type(&dict)) !=
+ DBUS_TYPE_INVALID) {
+ DBusMessageIter entry;
+ const char *key;
+ struct metadata_value *value;
+ int id;
+
+ if (ctype != DBUS_TYPE_DICT_ENTRY)
+ return FALSE;
+
+ dbus_message_iter_recurse(&dict, &entry);
+ if (dbus_message_iter_get_arg_type(&entry) != DBUS_TYPE_STRING)
+ return FALSE;
+
+ dbus_message_iter_get_basic(&entry, &key);
+ dbus_message_iter_next(&entry);
+
+ id = metadata_to_val(key);
+ if (id < 0)
+ return FALSE;
+
+ if (dbus_message_iter_get_arg_type(&entry) != DBUS_TYPE_VARIANT)
+ return FALSE;
+
+ dbus_message_iter_recurse(&entry, &var);
+
+ value = g_new0(struct metadata_value, 1);
+ value->type = dbus_message_iter_get_arg_type(&var);
+
+ if (!strcmp(key, "Title")) {
+ if (value->type != DBUS_TYPE_STRING) {
+ g_free(value);
+ return FALSE;
+ }
+
+ dbus_message_iter_get_basic(&var, &value->value.str);
+ title = TRUE;
+ } else if (!strcmp(key, "Artist")) {
+ if (value->type != DBUS_TYPE_STRING) {
+ g_free(value);
+ return FALSE;
+ }
+
+ dbus_message_iter_get_basic(&var, &value->value.str);
+ } else if (!strcmp(key, "Album")) {
+ if (value->type != DBUS_TYPE_STRING) {
+ g_free(value);
+ return FALSE;
+ }
+
+ dbus_message_iter_get_basic(&var, &value->value.str);
+ } else if (!strcmp(key, "Genre")) {
+ if (value->type != DBUS_TYPE_STRING) {
+ g_free(value);
+ return FALSE;
+ }
+
+ dbus_message_iter_get_basic(&var, &value->value.str);
+ } else if (!strcmp(key, "NumberOfTracks")) {
+ if (value->type != DBUS_TYPE_UINT32) {
+ g_free(value);
+ return FALSE;
+ }
+
+ dbus_message_iter_get_basic(&var, &value->value.num);
+ } else if (!strcmp(key, "Number")) {
+ if (value->type != DBUS_TYPE_UINT32) {
+ g_free(value);
+ return FALSE;
+ }
+
+ dbus_message_iter_get_basic(&var, &value->value.num);
+ } else if (!strcmp(key, "Duration")) {
+ if (value->type != DBUS_TYPE_UINT32) {
+ g_free(value);
+ return FALSE;
+ }
+
+ dbus_message_iter_get_basic(&var, &value->value.num);
+ } else {
+ return FALSE;
+ }
+
+ switch (value->type) {
+ case DBUS_TYPE_STRING:
+ value->value.str = g_strdup(value->value.str);
+ DBG("%s=%s", key, value->value.str);
+ break;
+ default:
+ DBG("%s=%u", key, value->value.num);
+ }
+
+ if (!mp->track)
+ mp->track = g_hash_table_new_full(g_direct_hash,
+ g_direct_equal, NULL,
+ metadata_value_free);
+
+ g_hash_table_replace(mp->track, GUINT_TO_POINTER(id), value);
+ dbus_message_iter_next(&dict);
+ }
+
+ mp->position = 0;
+ g_timer_start(mp->timer);
+
+ avrcp_player_event(mp->player, AVRCP_EVENT_TRACK_CHANGED, NULL);
+
+ return title;
+}
+
+static gboolean track_changed(DBusConnection *connection, DBusMessage *msg,
+ void *user_data)
+{
+ struct media_player *mp = user_data;
+ DBusMessageIter iter;
+
+ DBG("sender=%s path=%s", mp->sender, mp->path);
+
+ dbus_message_iter_init(msg, &iter);
+
+ if (parse_player_metadata(mp, &iter) == FALSE) {
+ error("Unexpected signature in %s.%s signal",
+ dbus_message_get_interface(msg),
+ dbus_message_get_member(msg));
+ }
+
+ return TRUE;
+}
+
+static struct media_player *media_player_create(struct media_adapter 
*adapter,
+ const char *sender,
+ const char *path,
+ int *err)
+{
+ struct media_player *mp;
+
+ mp = g_new0(struct media_player, 1);
+ mp->adapter = adapter;
+ mp->sender = g_strdup(sender);
+ mp->path = g_strdup(path);
+ mp->timer = g_timer_new();
+
+ mp->watch = g_dbus_add_disconnect_watch(adapter->conn, sender,
+ media_player_exit, mp,
+ NULL);
+ mp->property_watch = g_dbus_add_signal_watch(adapter->conn, sender,
+ path, MEDIA_PLAYER_INTERFACE,
+ "PropertyChanged",
+ property_changed,
+ mp, NULL);
+ mp->track_watch = g_dbus_add_signal_watch(adapter->conn, sender,
+ path, MEDIA_PLAYER_INTERFACE,
+ "TrackChanged",
+ track_changed,
+ mp, NULL);
+ mp->player = avrcp_register_player(&adapter->src, &player_cb, mp,
+ media_player_free);
+ if (!mp->player) {
+ if (err)
+ *err = -EPROTONOSUPPORT;
+ media_player_destroy(mp);
+ return NULL;
+ }
+
+ adapter->players = g_slist_append(adapter->players, mp);
+
+ info("Player registered: sender=%s path=%s", sender, path);
+
+ if (err)
+ *err = 0;
+
+ return mp;
+}
+
+static gboolean parse_player_properties(struct media_player *mp,
+ DBusMessageIter *iter)
+{
+ DBusMessageIter dict;
+ int ctype;
+
+ ctype = dbus_message_iter_get_arg_type(iter);
+ if (ctype != DBUS_TYPE_ARRAY)
+ return FALSE;
+
+ dbus_message_iter_recurse(iter, &dict);
+
+ while ((ctype = dbus_message_iter_get_arg_type(&dict)) !=
+ DBUS_TYPE_INVALID) {
+ DBusMessageIter entry;
+ const char *key;
+
+ if (ctype != DBUS_TYPE_DICT_ENTRY)
+ return FALSE;
+
+ dbus_message_iter_recurse(&dict, &entry);
+ if (dbus_message_iter_get_arg_type(&entry) != DBUS_TYPE_STRING)
+ return FALSE;
+
+ dbus_message_iter_get_basic(&entry, &key);
+ dbus_message_iter_next(&entry);
+
+ if (set_property(mp, key, &entry) == FALSE)
+ return FALSE;
+
+ dbus_message_iter_next(&dict);
+ }
+
+ return TRUE;
+}
+
+static DBusMessage *register_player(DBusConnection *conn, DBusMessage *msg,
+ void *data)
+{
+ struct media_adapter *adapter = data;
+ struct media_player *mp;
+ DBusMessageIter args;
+ const char *sender, *path;
+ int err;
+
+ sender = dbus_message_get_sender(msg);
+
+ dbus_message_iter_init(msg, &args);
+
+ dbus_message_iter_get_basic(&args, &path);
+ dbus_message_iter_next(&args);
+
+ if (media_adapter_find_player(adapter, sender, path) != NULL)
+ return btd_error_already_exists(msg);
+
+ mp = media_player_create(adapter, sender, path, &err);
+ if (mp == NULL) {
+ if (err == -EPROTONOSUPPORT)
+ return btd_error_not_supported(msg);
+ else
+ return btd_error_invalid_args(msg);
+ }
+
+ if (parse_player_properties(mp, &args) == FALSE) {
+ media_player_destroy(mp);
+ return btd_error_invalid_args(msg);
+ }
+
+ dbus_message_iter_next(&args);
+
+ if (parse_player_metadata(mp, &args) == FALSE) {
+ media_player_destroy(mp);
+ return btd_error_invalid_args(msg);
+ }
+
+ return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+}
+
+static DBusMessage *unregister_player(DBusConnection *conn, DBusMessage 
*msg,
+ void *data)
+{
+ struct media_adapter *adapter = data;
+ struct media_player *player;
+ const char *sender, *path;
+
+ if (!dbus_message_get_args(msg, NULL,
+ DBUS_TYPE_OBJECT_PATH, &path,
+ DBUS_TYPE_INVALID))
+ return NULL;
+
+ sender = dbus_message_get_sender(msg);
+
+ player = media_adapter_find_player(adapter, sender, path);
+ if (player == NULL)
+ return btd_error_does_not_exist(msg);
+
+ media_player_remove(player);
+
+ return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+}
+
static GDBusMethodTable media_methods[] = {
  { "RegisterEndpoint", "oa{sv}", "", register_endpoint },
  { "UnregisterEndpoint", "o", "", unregister_endpoint },
+ { "RegisterPlayer", "oa{sv}a{sv}","", register_player },
+ { "UnregisterPlayer", "o", "", unregister_player },
  { },
};

diff --git a/doc/media-api.txt b/doc/media-api.txt
index b2f239a..7834e38 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -44,6 +44,169 @@ Methods void RegisterEndpoint(object endpoint, dict 
properties)

  Unregister sender end point.

+ void RegisterPlayer(object player, dict properties,
+ dict metadata)
+
+ Register a media player object to sender, the sender
+ can register as many objets as it likes.
+
+ Note: If the sender disconnects its objects are
+ automatically unregistered.
+
+ Properties:
+
+ string Equalizer:
+
+ Possible values: "off" or "on"
+
+ string Repeat:
+
+ Possible values: "off", "singletrack",
+ "alltrack" or "group"
+
+ string Shuffle:
+
+ Possible values: "off", "alltracks" or
+ "group"
+
+ string Scan:
+
+ Possible values: "off", "alltracks" or
+ "group"
+
+ string Status:
+
+ Possible values: "playing", "stopped",
+ "paused",
+ "forward-seek",
+ "reverse-seek" or
+ "error"
+
+ uint32 Position
+
+ Playback position in milliseconds
+
+ Metadata:
+
+ string Title:
+
+ Track title name
+
+ string Artist:
+
+ Track artist name
+
+ string Album:
+
+ Track album name
+
+ string Genre:
+
+ Track genre name
+
+ uint32 NumberOfTracks:
+
+ Number of tracks in total
+
+ uint32 Number:
+
+ Track number
+
+ uint32 Duration:
+
+ Track duration in milliseconds
+
+ Possible Errors: org.bluez.Error.InvalidArguments
+ org.bluez.Error.NotSupported
+
+ void UnregisterPlayer(object player)
+
+ Unregister sender media player.
+
+MediaPlayer hierarchy
+=====================
+
+Service unique name
+Interface org.bluez.MediaPlayer
+Object path freely definable
+
+Methods void SetProperty(string property, variant value)
+
+ Changes the value of the specified property. Only
+ properties that are listed a read-write can be changed.
+
+ On success this will emit a PropertyChanged signal.
+
+Signals PropertyChanged(string setting, variant value)
+
+ This signal indicates a changed value of the given
+ property.
+
+ TrackChanged(dict metadata)
+
+ Possible values:
+
+ string Title:
+
+ Track title name
+
+ string Artist:
+
+ Track artist name
+
+ string Album:
+
+ Track album name
+
+ string Genre:
+
+ Track genre name
+
+ uint32 NumberOfTracks:
+
+ Number of tracks in total
+
+ uint32 Number:
+
+ Track number
+
+ uint32 Duration:
+
+ Track duration in milliseconds
+
+ StatusChanged(string status, uint32 position)
+
+ Possible status: "playing", "stopped", "paused",
+ "forward-seek", "reverse-seek" or
+ "error"
+
+Properies string Equalizer [readwrite]
+
+ Possible values: "off" or "on"
+
+ string Repeat [readwrite]
+
+ Possible values: "off", "singletrack", "alltrack" or
+ "group"
+
+ string Shuffle [readwrite]
+
+ Possible values: "off", "alltracks" or "group"
+
+ string Scan [readwrite]
+
+ Possible values: "off", "alltracks" or "group"
+
+ string Status [readonly]
+
+ Possible status: "playing", "stopped", "paused",
+ "forward-seek", "reverse-seek" or
+ "error"
+
+ uint32 Position [readonly]
+
+ Playback position in milliseconds
+
MediaEndpoint hierarchy
=======================

-- 
1.7.6.2

--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" 
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html 

