Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1361898668-16959-2-git-send-email-alexandros.antonopoulos@oss.bmw-carit.de>
References: <1361898668-16959-1-git-send-email-alexandros.antonopoulos@oss.bmw-carit.de>
	<1361898668-16959-2-git-send-email-alexandros.antonopoulos@oss.bmw-carit.de>
Date: Tue, 26 Feb 2013 22:34:43 +0200
Message-ID: <CABBYNZKsey2ryhzL9e8hk+NEaMv5+t6Jfazx-2QkTSBi5X0KvA@mail.gmail.com>
Subject: Re: [RFC 1/1] avrcp: Add support for multiple players on the CT side
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Alexandros Antonopoulos <alexandros.antonopoulos@oss.bmw-carit.de>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alexandros,

On Tue, Feb 26, 2013 at 7:11 PM, Alexandros Antonopoulos
<alexandros.antonopoulos@oss.bmw-carit.de> wrote:
> AVRCP 1.4+ introduces the concept of multiple players on the target
> side. The CT session is extended to create all the players found on
> the target. For every player a separate dbus path is created.
>
> ---
>  profiles/audio/avrcp.c  | 267 +++++++++++++++++++++++++++++++++++++-----------
>  profiles/audio/avrcp.h  |   2 +
>  profiles/audio/player.c |   5 +-
>  profiles/audio/player.h |   3 +-
>  4 files changed, 213 insertions(+), 64 deletions(-)
>
> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> index 9be977e..f337646 100644
> --- a/profiles/audio/avrcp.c
> +++ b/profiles/audio/avrcp.c
> @@ -99,9 +99,15 @@
>  #define AVRCP_REQUEST_CONTINUING       0x40
>  #define AVRCP_ABORT_CONTINUING         0x41
>  #define AVRCP_SET_ABSOLUTE_VOLUME      0x50
> +#define AVRCP_SET_ADDRESSED_PLAYER     0x60
>  #define AVRCP_SET_BROWSED_PLAYER       0x70
>  #define AVRCP_GET_ITEM_ATTRIBUTES      0x73
>  #define AVRCP_GET_FOLDER_ITEMS         0x71
> +#define AVRCP_CHANGE_PATH              0x72
> +#define AVRCP_GET_ITEM_ATTRIBUTES      0x73
> +#define AVRCP_PLAY_ITEM                0x74
> +#define AVRCP_SEARCH                   0x80
> +#define AVRCP_ADD_TO_NOW_PLAYING       0x90
>  #define AVRCP_GENERAL_REJECT           0xA0

Please only add defines that you actually use.

>  /* Capabilities for AVRCP_GET_CAPABILITIES pdu */
> @@ -124,6 +130,17 @@
>  #define AVRCP_BATTERY_STATUS_EXTERNAL          3
>  #define AVRCP_BATTERY_STATUS_FULL_CHARGE       4
>
> +/* Scopes for AVRCP_GET_FOLDER_ITEMS */
> +#define AVRCP_GET_FOLDER_ITEMS_SCOPE_MEDIAPLAYERLIST   0x00
> +#define AVRCP_GET_FOLDER_ITEMS_SCOPE_MEDIAPLAYERVFS    0x01
> +#define AVRCP_GET_FOLDER_ITEMS_SCOPE_SEARCH            0x02
> +#define AVRCP_GET_FOLDER_ITEMS_SCOPE_NOWPLAYING                0x03

We can deal with the defines latter, the defines should probably be
shorter though.

> +/* Get Folder Items types */
> +#define AVRCP_GET_FOLDER_ITEMTYPE_PLAYER       0x01
> +#define AVRCP_GET_FOLDER_ITEMTYPE_FOLDER       0x02
> +#define AVRCP_GET_FOLDER_ITEMTYPE_ELEMENT      0x03

Same as above.

>  #if __BYTE_ORDER == __LITTLE_ENDIAN
>
>  struct avrcp_header {
> @@ -162,6 +179,40 @@ struct avrcp_browsing_header {
>  } __attribute__ ((packed));
>  #define AVRCP_BROWSING_HEADER_LENGTH 3
>
> +/* UID size. AVRCP 1.5 spec section 6.10.3 page 72 */
> +#define AVRCP_BROWSING_UID_SIZE 8
> +
> +struct avrcp_get_folder_items_req {
> +       uint8_t scope;
> +       uint32_t start_item;
> +       uint32_t end_item;
> +       uint8_t count;
> +       uint8_t attributes[0];
> +}__attribute__ ((packed));
> +#define AVRCP_GET_FOLDER_ITEMS_LENGTH 10
> +
> +struct avrcp_folder_items {
> +       uint8_t status;
> +       uint16_t uid_counter;
> +       uint16_t num_of_items;
> +       uint8_t params[0];
> +}__attribute__((packed));
> +
> +/* Browsable items. AVRCP 1.5 spec, section 6.10.2 page 66 */
> +struct avrcp_media_player_item {
> +       uint16_t id;
> +       uint8_t type;
> +       uint32_t subtype;
> +       uint8_t status;
> +       uint8_t feature_mask[16];
> +       uint16_t char_set;
> +       uint16_t name_length;
> +       char    name[0];
> +}__attribute__((packed));

Using structs is probably a good idea, but I would do this in a separate patch.

> +/* Media player name size limit */
> +#define AVRCP_PLAYER_NAME_LEN 512
> +
>  struct avrcp_server {
>         struct btd_adapter *adapter;
>         uint32_t tg_record_id;
> @@ -192,7 +243,11 @@ struct avrcp {
>         struct avrcp_server *server;
>         struct avctp *conn;
>         struct audio_device *dev;
> -       struct avrcp_player *player;
> +
> +       struct avrcp_player     *player;
> +       struct avrcp_player     *browsed_player;
> +       GHashTable              *players;
> +
>         gboolean target;
>         uint16_t version;
>         int features;
> @@ -228,6 +283,8 @@ static uint32_t company_ids[] = {
>  };
>
>  static void avrcp_register_notification(struct avrcp *session, uint8_t event);
> +static struct avrcp_player *avrcp_ct_create_player(struct avrcp *session,
> +                                                       uint16_t player_id);

Do you really need to have a forward declaration for
avrcp_ct_create_player, can we just move it before the first use?

>  static sdp_record_t *avrcp_ct_record(void)
>  {
> @@ -2046,45 +2103,48 @@ static void avrcp_player_parse_features(struct avrcp_player *player,
>  }
>
>  static void avrcp_parse_media_player_item(struct avrcp *session,
> -                                       uint8_t *operands, uint16_t len)
> +                               struct avrcp_media_player_item *item)
>  {
> -       struct avrcp_player *player = session->player;
> -       struct media_player *mp = player->user_data;
> -       uint16_t id;
> -       uint32_t subtype;
> +       struct avrcp_player *player = NULL;
> +       struct media_player *mp;
>         const char *curval, *strval;
> -       char name[255];
> +       char name[AVRCP_PLAYER_NAME_LEN];
> +       uint16_t name_len = AVRCP_PLAYER_NAME_LEN;
> +       uint16_t id;
>
> -       if (len < 28)
> -               return;
> +       id = ntohs(item->id);
> +
> +       item->char_set = ntohs(item->char_set);
>
> -       id = bt_get_be16(&operands[0]);
> +       player = avrcp_ct_create_player(session, id);
>
> -       if (player->id != id)
> +       if (player == NULL)
>                 return;
>
> -       media_player_set_type(mp, type_to_string(operands[2]));
> +       name_len = ntohs(item->name_length);
> +       if (name_len >= AVRCP_PLAYER_NAME_LEN)
> +               name_len = AVRCP_PLAYER_NAME_LEN - 1;
> +
> +       memcpy(name, item->name, name_len);
> +       name[name_len] = '\0';
>
> -       subtype = bt_get_be32(&operands[3]);
> +       mp = player->user_data;
> +       media_player_set_type(mp, type_to_string(item->type));
>
> -       media_player_set_subtype(mp, subtype_to_string(subtype));
> +       media_player_set_subtype(mp, subtype_to_string(item->subtype));
>
>         curval = media_player_get_status(mp);
> -       strval = status_to_string(operands[7]);
> +       strval = status_to_string(item->status);
>
>         if (g_strcmp0(curval, strval) != 0) {
>                 media_player_set_status(mp, strval);
>                 avrcp_get_play_status(session);
>         }
>
> -       avrcp_player_parse_features(player, &operands[8]);
> +       avrcp_player_parse_features(player, item->feature_mask);
>
> -       if (operands[26] != 0) {
> -               memcpy(name, &operands[27], operands[26]);
> -               media_player_set_name(mp, name);
> -       }
> +       media_player_set_name(mp, name);
>
> -       avrcp_set_browsed_player(session, player);
>  }
>
>  static gboolean avrcp_get_media_player_list_rsp(struct avctp *conn,
> @@ -2093,28 +2153,37 @@ static gboolean avrcp_get_media_player_list_rsp(struct avctp *conn,
>                                                 void *user_data)
>  {
>         struct avrcp *session = user_data;
> -       uint16_t count;
> -       int i;
> +       struct avrcp_browsing_header *pdu = (void *) operands;
> +       struct avrcp_folder_items *items = (void *) pdu->params;
> +       int idx = 0;
>
>         if (operands[3] != AVRCP_STATUS_SUCCESS || operand_count < 5)
>                 return FALSE;
>
> -       count = bt_get_be16(&operands[6]);
> +       items->uid_counter = ntohs(items->uid_counter);
> +       items->num_of_items = ntohs(items->num_of_items);
>
> -       for (i = 8; count; count--) {
> +       DBG("items: %d", items->num_of_items);
> +       while (items->num_of_items--) {
>                 uint8_t type;
>                 uint16_t len;
>
> -               type = operands[i++];
> -               len = bt_get_be16(&operands[i]);
> -               i += 2;
> +               type = items->params[idx];
> +               DBG("Type: %02x", type);
> +               idx += 1;
>
> -               if (type != 0x01) {
> -                       i += len;
> -                       continue;
> +               len = bt_get_be16(&items->params[idx]);
> +               idx += sizeof(uint16_t);
> +
> +               DBG("len: %d", len);
> +               switch(type) {
> +               case AVRCP_GET_FOLDER_ITEMTYPE_PLAYER:
> +                       avrcp_parse_media_player_item(session,
> +                                               (void *)&items->params[idx]);
> +                       break;
>                 }
>
> -               avrcp_parse_media_player_item(session, &operands[i], len);
> +               idx += len;
>         }

Way too much debug, lets try to avoid to output whatever we already
get from hcidump.

>         return FALSE;
> @@ -2122,13 +2191,21 @@ static gboolean avrcp_get_media_player_list_rsp(struct avctp *conn,
>
>  static void avrcp_get_media_player_list(struct avrcp *session)
>  {
> -       uint8_t buf[AVRCP_BROWSING_HEADER_LENGTH + 10];
> +       uint8_t buf[AVRCP_BROWSING_HEADER_LENGTH +
> +                       AVRCP_GET_FOLDER_ITEMS_LENGTH];
>         struct avrcp_browsing_header *pdu = (void *) buf;
> +       struct avrcp_get_folder_items_req *req;
>
> +       DBG("");
>         memset(buf, 0, sizeof(buf));
>
>         pdu->pdu_id = AVRCP_GET_FOLDER_ITEMS;
> -       pdu->param_len = htons(10);
> +       pdu->param_len = htons(AVRCP_GET_FOLDER_ITEMS_LENGTH);
> +
> +       req = (void *)pdu->params;
> +       req->scope = AVRCP_GET_FOLDER_ITEMS_SCOPE_MEDIAPLAYERLIST;
> +
> +       req->end_item = htonl(0xFF);
>
>         avctp_send_browsing_req(session->conn, buf, sizeof(buf),
>                                 avrcp_get_media_player_list_rsp, session);
> @@ -2151,11 +2228,17 @@ static void avrcp_volume_changed(struct avrcp *session,
>  static void avrcp_status_changed(struct avrcp *session,
>                                                 struct avrcp_header *pdu)
>  {
> -       struct avrcp_player *player = session->player;
> -       struct media_player *mp = player->user_data;
> +       struct avrcp_player *player;
> +       struct media_player *mp;
>         uint8_t value;
>         const char *curval, *strval;
>
> +       player = session->player;
> +       if (player == NULL)
> +               return;
> +
> +       mp = player->user_data;
> +
>         value = pdu->params[1];
>
>         curval = media_player_get_status(mp);
> @@ -2173,6 +2256,9 @@ static void avrcp_track_changed(struct avrcp *session,
>  {
>         uint64_t uid;
>
> +       if (session->player == NULL)
> +               return;
> +
>         if (session->browsing_id) {
>                 uid = bt_get_be64(&pdu->params[1]);
>                 avrcp_get_item_attributes(session, uid);
> @@ -2185,11 +2271,17 @@ static void avrcp_track_changed(struct avrcp *session,
>  static void avrcp_setting_changed(struct avrcp *session,
>                                                 struct avrcp_header *pdu)
>  {
> -       struct avrcp_player *player = session->player;
> -       struct media_player *mp = player->user_data;
> +       struct avrcp_player *player;
> +       struct media_player *mp;
>         uint8_t count = pdu->params[1];
>         int i;
>
> +       player = session->player;
> +       if (player == NULL)
> +               return;
> +
> +       mp = player->user_data;
> +
>         for (i = 2; count > 0; count--, i += 2) {
>                 const char *key;
>                 const char *value;
> @@ -2209,15 +2301,24 @@ static void avrcp_setting_changed(struct avrcp *session,
>  static void avrcp_addressed_player_changed(struct avrcp *session,
>                                                 struct avrcp_header *pdu)
>  {
> -       struct avrcp_player *player = session->player;
> +       struct avrcp_player *player;
> +       struct media_player *mp;
>         uint16_t id = bt_get_be16(&pdu->params[1]);
>
> -       if (player->id == id)
> +       DBG("id: %d", id);
> +       player = avrcp_ct_create_player(session, id);
> +
> +       if (player == NULL)
>                 return;
>
> -       player->id = id;
> +       session->player = player;
>         player->uid_counter = bt_get_le16(&pdu->params[3]);
> -       avrcp_get_media_player_list(session);
> +
> +       mp = player->user_data;
> +       media_player_set_setting(mp, "Addressed", "True");
> +
> +       if (session->browsed_player == NULL)
> +               avrcp_set_browsed_player(session, player);
>  }
>
>  static gboolean avrcp_handle_event(struct avctp *conn,
> @@ -2412,6 +2513,43 @@ static const struct media_player_callback ct_cbs = {
>         .rewind         = ct_rewind,
>  };
>
> +static struct avrcp_player * avrcp_ct_create_player(struct avrcp *session,
> +                                                       uint16_t id)
> +{
> +       struct avrcp_player *player = NULL;
> +       struct media_player *mp;
> +       const char *path;
> +
> +       player = g_hash_table_lookup(session->players, GINT_TO_POINTER(id));
> +
> +       if (player != NULL)
> +               return player;
> +
> +       player = g_new0(struct avrcp_player, 1);
> +       path = device_get_path(session->dev->btd_dev);
> +
> +       mp = media_player_controller_create(path, id);
> +
> +       if (mp == NULL) {
> +               g_free(player);
> +               return NULL;
> +       }

Usually we have no space between assigning and the if statement
checking for the return.

> +       DBG("%p", session);
> +       player->sessions = g_slist_prepend(player->sessions, session);
> +
> +       media_player_set_callbacks(mp, &ct_cbs, player);
> +       player->user_data = mp;
> +       player->destroy = (GDestroyNotify) media_player_destroy;
> +       player->id = id;
> +
> +       media_player_set_setting(mp, "Addressed", "False");

Don't reuse media_player_set_setting just create  media_player_set_active.

> +
> +       g_hash_table_replace(session->players, GINT_TO_POINTER(id), player);
> +
> +       return player;
> +}
> +
>  static gboolean avrcp_get_capabilities_resp(struct avctp *conn,
>                                         uint8_t code, uint8_t subunit,
>                                         uint8_t *operands, size_t operand_count,
> @@ -2502,6 +2640,7 @@ static void session_tg_init_browsing(struct avrcp *session)
>                                                         handle_browsing_pdu,
>                                                         session,
>                                                         destroy_browsing);
> +
>  }
>
>  static void session_tg_init_control(struct avrcp *session)
> @@ -2543,13 +2682,13 @@ static void session_ct_init_browsing(struct avrcp *session)
>                                                         handle_browsing_pdu,
>                                                         session,
>                                                         destroy_browsing);
> +
> +       avrcp_get_media_player_list(session);

Are you sure this is the correct order, I would do either as result of
available player event or addressed player in case the former is not
supported otherwise we would not be able to keep the list in sync.
Actually if the TG stack is implemented correctly it will hide all the
player behind the addressed if the CT is not registered to available
players.

>  }
>
>  static void session_ct_init_control(struct avrcp *session)
>  {
>         struct avrcp_player *player;
> -       struct media_player *mp;
> -       const char *path;
>
>         DBG("%p version 0x%04x", session, session->version);
>
> @@ -2561,23 +2700,18 @@ static void session_ct_init_control(struct avrcp *session)
>         if (session->version >= 0x0104)
>                 session->supported_events = (1 << AVRCP_EVENT_VOLUME_CHANGED);
>
> -       player = g_new0(struct avrcp_player, 1);
> -       player->sessions = g_slist_prepend(player->sessions, session);
> -       session->player = player;
> -
> -       path = device_get_path(session->dev->btd_dev);
> -
> -       mp = media_player_controller_create(path);
> -       if (mp == NULL)
> -               return;
> -
> -       media_player_set_callbacks(mp, &ct_cbs, player);
> -       player->user_data = mp;
> -       player->destroy = (GDestroyNotify) media_player_destroy;
> +       session->players = g_hash_table_new_full(g_direct_hash, g_direct_equal,
> +                                                       NULL, g_free);
>
>         if (session->version < 0x0103)
>                 return;
>
> +       if (session->version <= 0x0103) {
> +               player = avrcp_ct_create_player(session, 1);
> +               session->player = player;
> +               session->browsed_player = NULL;
> +       }
> +
>         avrcp_get_capabilities(session);
>  }
>
> @@ -2620,14 +2754,25 @@ static void player_destroy(gpointer data)
>         g_free(player);
>  }
>
> -static void session_ct_destroy(struct avrcp *session)
> +static gboolean ct_player_destroy(gpointer key, gpointer value, gpointer user_data)
>  {
> -       struct avrcp_player *player = session->player;
> +       /* As this is WIP for the CT side we need to keep the TG side
> +        * from breaking. Until then keep the player_destroy method which
> +        * is used from the tg side session destroy */
> +       player_destroy(value);
> +       return true;
> +}
>
> +static void session_ct_destroy(struct avrcp *session)
> +{
>         DBG("%p", session);
> +       if (session->players) {
> +               g_hash_table_foreach_steal(session->players,
> +                               ct_player_destroy, session);
>
> -       if (player != NULL)
> -               player_destroy(player);
> +               g_hash_table_unref(session->players);
> +               session->players = NULL;
> +       }
>
>         session_destroy(session);
>  }
> diff --git a/profiles/audio/avrcp.h b/profiles/audio/avrcp.h
> index 3799da1..0406588 100644
> --- a/profiles/audio/avrcp.h
> +++ b/profiles/audio/avrcp.h
> @@ -74,7 +74,9 @@
>  #define AVRCP_EVENT_TRACK_REACHED_END          0x03
>  #define AVRCP_EVENT_TRACK_REACHED_START                0x04
>  #define AVRCP_EVENT_SETTINGS_CHANGED           0x08
> +#define AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED  0x0a
>  #define AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED   0x0b
> +#define AVRCP_EVENT_UIDS_CHANGED               0x0c
>  #define AVRCP_EVENT_VOLUME_CHANGED             0x0d
>  #define AVRCP_EVENT_LAST                       AVRCP_EVENT_VOLUME_CHANGED

Don't define if you are not going to use.

> diff --git a/profiles/audio/player.c b/profiles/audio/player.c
> index 466b44a..0e0fee9 100644
> --- a/profiles/audio/player.c
> +++ b/profiles/audio/player.c
> @@ -730,13 +730,14 @@ void media_player_destroy(struct media_player *mp)
>         g_free(mp);
>  }
>
> -struct media_player *media_player_controller_create(const char *path)
> +struct media_player *media_player_controller_create(const char *path,
> +                                               uint16_t player_id)
>  {
>         struct media_player *mp;
>
>         mp = g_new0(struct media_player, 1);
>         mp->device = g_strdup(path);
> -       mp->path = g_strdup_printf("%s/player1", path);
> +       mp->path = g_strdup_printf("%s/player%d", path, player_id);

Use %u above

>         mp->settings = g_hash_table_new_full(g_str_hash, g_str_equal,
>                                                         g_free, g_free);
>         mp->track = g_hash_table_new_full(g_str_hash, g_str_equal,
> diff --git a/profiles/audio/player.h b/profiles/audio/player.h
> index a59cc66..8d06cf3 100644
> --- a/profiles/audio/player.h
> +++ b/profiles/audio/player.h
> @@ -37,7 +37,8 @@ struct media_player_callback {
>         int (*rewind) (struct media_player *mp, void *user_data);
>  };
>
> -struct media_player *media_player_controller_create(const char *path);
> +struct media_player *media_player_controller_create(const char *path,
> +                                               uint16_t player_id);
>  void media_player_destroy(struct media_player *mp);
>  void media_player_set_duration(struct media_player *mp, uint32_t duration);
>  void media_player_set_position(struct media_player *mp, uint32_t position);
> --
> 1.8.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--
Luiz Augusto von Dentz
