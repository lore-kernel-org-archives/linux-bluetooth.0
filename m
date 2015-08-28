Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1440745212-30777-2-git-send-email-bharat.panda@samsung.com>
References: <1440745212-30777-1-git-send-email-bharat.panda@samsung.com>
	<1440745212-30777-2-git-send-email-bharat.panda@samsung.com>
Date: Fri, 28 Aug 2015 11:28:54 +0300
Message-ID: <CABBYNZKqTrXRM2G6s2dnO9ToyJMYvtbRhsMMJUu-LLjCt6oP_g@mail.gmail.com>
Subject: Re: [PATCH 2/2] audio/avrcp: Add GetFolderItems support
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Bharat Panda <bharat.panda@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bharat,

On Fri, Aug 28, 2015 at 10:00 AM, Bharat Panda <bharat.panda@samsung.com> wrote:
> Support added to handle Get Folder Items browsing PDU
> for media player scope in TG role.
>
> e.g.
>       AVCTP Browsing: Response: type 0x00 label 0 PID 0x110e
>         AVRCP: GetFolderItems: len 0x0030
>           Status: 0x04 (Success)
>           UIDCounter: 0x0000 (0)
>           NumOfItems: 0x0001 (1)
>           Item: 0x01 (Media Player)
>           Length: 0x0028 (40)
>           PlayerID: 0x0000 (0)
>           PlayerType: 0x0001 (Audio)
>           PlayerSubType: 0x00000001 (Audio Book)
>           PlayStatus: 0x01 (PLAYING)
>           Features: 0x0000000000b701ef0200000000000000
>           CharsetID: 0x006a (UTF-8)
>           NameLength: 0x000c (12)
>           Name: SimplePlayer
> ---
>  profiles/audio/avrcp.c | 175 +++++++++++++++++++++++++++++++++++++++++++++++++
>  profiles/audio/avrcp.h |   4 ++
>  profiles/audio/media.c |  32 +++++++++
>  3 files changed, 211 insertions(+)
>
> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> index 76e89af..d319989 100644
> --- a/profiles/audio/avrcp.c
> +++ b/profiles/audio/avrcp.c
> @@ -1821,11 +1821,186 @@ err_metadata:
>         return AVRCP_HEADER_LENGTH + 1;
>  }
>
> +static uint8_t string_to_type(const char *str)
> +{
> +       if (!strcmp(str, "Audio"))
> +               return 0x01;
> +       else if (!strcmp(str, "Video"))
> +               return 0x02;
> +       else if (!strcmp(str, "A/V"))
> +               return 0x03;
> +       else if (!strcmp(str, "Broadcasting Audio"))
> +               return 0x04;
> +       else
> +               return -EINVAL;
> +}
> +
> +static uint32_t string_to_subtype(const char *str)
> +{
> +       if (!strcmp(str, "Audio Book"))
> +               return 0x01;
> +       else if (!strcmp(str, "Podcast"))
> +               return 0x02;
> +       else if (!strcmp(str, "Audio Book/Podcast"))
> +               return 0x03;
> +       else
> +               return -EINVAL;
> +}
> +
> +static void avrcp_handle_get_folder_items(struct avrcp *session,
> +                               struct avrcp_browsing_header *pdu,
> +                               uint8_t transaction)
> +{
> +       struct avrcp_server *server = session->server;
> +       struct avrcp_player *player = NULL;
> +       uint32_t start_item = 0;
> +       uint32_t end_item = 0;
> +       uint16_t uid_counter = 0;
> +       uint16_t num_of_items = 0;
> +       uint16_t index = 0;
> +       uint8_t status;
> +       GSList *l;
> +
> +       if (ntohs(pdu->param_len) < 1)
> +               goto failed;
> +
> +       start_item = bt_get_be32(&pdu->params[1]);
> +       end_item = bt_get_be32(&pdu->params[5]);
> +
> +       if (end_item < start_item) {
> +               pdu->param_len = htons(1);
> +               pdu->params[0] = AVRCP_STATUS_PARAM_NOT_FOUND;

I have the impression for this case we should return AVRCP_STATUS_INVALID_PARAM.

> +               return;
> +       }
> +
> +       index = sizeof(status) + sizeof(uid_counter) + sizeof(num_of_items);
> +
> +       switch (pdu->params[0]) {
> +       case 0x00: {

This is way too big/complex, lets define the data struct like we are
doing in android, so use something like this:

http://fpaste.org/260553/07498921/

Note: Im already checking the item range but Im hardcoding the player
name and features which is something you will have to fix.

> +               uint8_t item_type = 0x01;
> +               uint16_t item_len;
> +               uint16_t player_id;
> +               uint8_t type;
> +               uint32_t subtype;
> +               unsigned int *features;
> +               uint16_t charset;
> +               uint16_t display_len;
> +               uint16_t player_count = 0;
> +               const char *display_name = NULL;
> +               uint8_t temp_index = 0;
> +
> +               for (l = server->players; l; l = l->next) {
> +                       uint8_t feat_size, i;
> +
> +                       player = l->data;
> +
> +                       if (!player)
> +                               continue;
> +
> +                       if ((start_item != end_item) &&
> +                                               (player_count >= end_item))
> +                               break;
> +
> +                       num_of_items = ++player_count;
> +                       player_id = htons(player->id);
> +
> +                       pdu->params[0] = AVRCP_STATUS_SUCCESS;
> +
> +                       uid_counter = htons(player->uid_counter);
> +                       memcpy(&pdu->params[1],
> +                                       &uid_counter, sizeof(uint16_t));
> +
> +                       num_of_items = htons(num_of_items);
> +                       memcpy(&pdu->params[3],
> +                                       &num_of_items, sizeof(uint16_t));
> +
> +                       pdu->params[index] = item_type;
> +                       index += sizeof(uint8_t);
> +
> +                       temp_index = index;
> +                       index += sizeof(uint16_t);
> +
> +                       memcpy(&pdu->params[index], &player_id,
> +                                                       sizeof(uint16_t));
> +                       index += sizeof(uint16_t);
> +
> +                       type = string_to_type(player->cb->get_type(
> +                                                       player->user_data));
> +                       pdu->params[index] = type;
> +
> +                       subtype = string_to_subtype(player->cb->get_subtype(
> +                                                       player->user_data));
> +                       subtype = htonl(subtype);
> +                       index += sizeof(uint8_t);
> +
> +                       memcpy(&pdu->params[index], &subtype, sizeof(uint32_t));
> +                       index += sizeof(uint32_t);
> +
> +                       pdu->params[index] = player_get_status(player);;
> +                       index += sizeof(uint8_t);
> +
> +                       feat_size = 16 * (sizeof(uint8_t));
> +                       features = player->cb->get_features(player->user_data);
> +
> +                       for (i = 0; i < feat_size; i++)
> +                               memcpy(&pdu->params[index+i],
> +                                               &features[i], sizeof(uint8_t));
> +
> +                       index += feat_size;
> +
> +                       charset = htons(AVRCP_CHARSET_UTF8);
> +                       memcpy(&pdu->params[index], &charset, sizeof(uint16_t));
> +                       index += sizeof(uint16_t);
> +
> +                       display_name = player->cb->get_player_name(
> +                                                       player->user_data);
> +
> +                       display_len = htons(strlen(display_name));
> +                       memcpy(&pdu->params[index], &display_len,
> +                                                       sizeof(uint16_t));
> +                       index += sizeof(uint16_t);
> +
> +                       memcpy(&pdu->params[index], display_name,
> +                                       sizeof(uint8_t)*strlen(display_name));
> +                       index += strlen(display_name);
> +
> +                       item_len = index - temp_index - sizeof(uint16_t);
> +                       item_len = htons(item_len);
> +                       memcpy(&pdu->params[temp_index], &item_len,
> +                                                       sizeof(uint16_t));
> +
> +                       pdu->param_len = htons(index);
> +               }
> +
> +               if (player == NULL) {
> +                       pdu->param_len = htons(1);
> +                       pdu->params[0] = AVRCP_STATUS_NO_AVAILABLE_PLAYERS;

Im not sure AVRCP_STATUS_NO_AVAILABLE_PLAYERS shall be used that way,
I guess we can check before the for loop in case the player list is
empty but otherwise it should return AVRCP_STATUS_OUT_OF_BOUNDS in
case there is no player for the given range.

> +                       return;
> +               }
> +
> +               break;
> +       }
> +
> +       case 0x01:
> +       case 0x02:
> +       case 0x03:
> +       default:
> +               goto failed;
> +       }
> +
> +       return;
> +
> +failed:
> +       pdu->param_len = htons(1);
> +       pdu->params[0] = 0x0a;
> +}
> +
>  static struct browsing_pdu_handler {
>         uint8_t pdu_id;
>         void (*func) (struct avrcp *session, struct avrcp_browsing_header *pdu,
>                                                         uint8_t transaction);
>  } browsing_handlers[] = {
> +               { AVRCP_GET_FOLDER_ITEMS, avrcp_handle_get_folder_items },
>                 { },
>  };
>
> diff --git a/profiles/audio/avrcp.h b/profiles/audio/avrcp.h
> index a9aeb1a..b51030a 100644
> --- a/profiles/audio/avrcp.h
> +++ b/profiles/audio/avrcp.h
> @@ -93,6 +93,10 @@ struct avrcp_player_cb {
>         const char *(*get_status) (void *user_data);
>         uint32_t (*get_position) (void *user_data);
>         uint32_t (*get_duration) (void *user_data);
> +       const char *(*get_player_name) (void *user_data);
> +       const char *(*get_type) (void *user_data);
> +       const char *(*get_subtype) (void *user_data);
> +       unsigned int *(*get_features) (void *user_data);
>         void (*set_volume) (uint8_t volume, struct btd_device *dev,
>                                                         void *user_data);
>         bool (*play) (void *user_data);
> diff --git a/profiles/audio/media.c b/profiles/audio/media.c
> index df364c0..7496f88 100644
> --- a/profiles/audio/media.c
> +++ b/profiles/audio/media.c
> @@ -1019,6 +1019,34 @@ static const char *get_setting(const char *key, void *user_data)
>         return g_hash_table_lookup(mp->settings, key);
>  }
>
> +static const char *get_player_name(void *user_data)
> +{
> +       struct media_player *mp = user_data;
> +
> +       return mp->name;
> +}
> +
> +static const char *get_type(void *user_data)
> +{
> +       struct media_player *mp = user_data;
> +
> +       return mp->type;
> +}
> +
> +static const char *get_subtype(void *user_data)
> +{
> +       struct media_player *mp = user_data;
> +
> +       return mp->subtype;
> +}
> +
> +static unsigned int *get_features(void *user_data)
> +{
> +       struct media_player *mp = user_data;
> +
> +       return mp->features;
> +}
> +
>  static void set_shuffle_setting(DBusMessageIter *iter, const char *value)
>  {
>         const char *key = "Shuffle";
> @@ -1279,6 +1307,10 @@ static struct avrcp_player_cb player_cb = {
>         .get_position = get_position,
>         .get_duration = get_duration,
>         .get_status = get_status,
> +       .get_player_name = get_player_name,
> +       .get_type = get_type,
> +       .get_subtype = get_subtype,

I would leave type and subtype out since it would probably always
hardcode those values, perhaps even features shall be left in avrcp.c
since we are hardcoding it anyway.

> +       .get_features = get_features,
>         .set_volume = set_volume,
>         .play = play,
>         .stop = stop,
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
