Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1435137092-19300-2-git-send-email-bharat.panda@samsung.com>
References: <1435137092-19300-1-git-send-email-bharat.panda@samsung.com>
	<1435137092-19300-2-git-send-email-bharat.panda@samsung.com>
Date: Thu, 2 Jul 2015 11:13:18 +0300
Message-ID: <CABBYNZKzhxJJgZX_OWCyeKhwz+mzzhcsjSOEB+4Do9e8BRZTiQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] audio/avrcp: Add AVRCP GetTotalNumOfItems support
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Bharat Panda <bharat.panda@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bharat,

On Wed, Jun 24, 2015 at 12:11 PM, Bharat Panda <bharat.panda@samsung.com> wrote:
> Added support for AVRCP GetTotalNumOfItems browsing command
> to retrieve the number of items in a folder(with given scope)
> prior to calling GetFolderItems to retrieve a listing of the
> contents of the folder.
> ---
>  profiles/audio/avrcp.c  | 77 +++++++++++++++++++++++++++++++++++++++++++++++++
>  profiles/audio/player.c | 25 ++++++++++++++++
>  profiles/audio/player.h |  4 +++
>  3 files changed, 106 insertions(+)
>
> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> index 60f8cbf..ebb3af9 100644
> --- a/profiles/audio/avrcp.c
> +++ b/profiles/audio/avrcp.c
> @@ -108,6 +108,7 @@
>  #define AVRCP_CHANGE_PATH              0x72
>  #define AVRCP_GET_ITEM_ATTRIBUTES      0x73
>  #define AVRCP_PLAY_ITEM                        0x74
> +#define AVRCP_GET_TOTAL_NUMBER_OF_ITEMS        0x75
>  #define AVRCP_SEARCH                   0x80
>  #define AVRCP_ADD_TO_NOW_PLAYING       0x90
>  #define AVRCP_GENERAL_REJECT           0xA0
> @@ -2821,6 +2822,81 @@ static int ct_add_to_nowplaying(struct media_player *mp, const char *name,
>         return 0;
>  }
>
> +static gboolean avrcp_get_total_numberofitems_rsp(struct avctp *conn,
> +                                       uint8_t *operands, size_t operand_count,
> +                                       void *user_data)
> +{
> +       struct avrcp_browsing_header *pdu = (void *) operands;
> +       struct avrcp *session = user_data;
> +       struct avrcp_player *player = session->controller->player;
> +       struct media_player *mp = player->user_data;
> +       int ret = 0;
> +
> +       if (pdu == NULL) {
> +               ret = -ETIMEDOUT;
> +               goto done;
> +       }
> +
> +       if (pdu->params[0] != AVRCP_STATUS_SUCCESS || operand_count < 7) {
> +               ret = -EINVAL;
> +               goto done;
> +       }
> +
> +       if (pdu->params[0] == AVRCP_STATUS_OUT_OF_BOUNDS)
> +               goto done;
> +
> +       player->uid_counter = get_be16(&pdu->params[1]);
> +       ret = get_be32(&pdu->params[3]);
> +
> +done:
> +       media_player_get_number_of_items_complete(mp, ret);
> +
> +       return FALSE;
> +}
> +
> +static void avrcp_get_total_numberofitems(struct avrcp *session)
> +{
> +       uint8_t buf[AVRCP_BROWSING_HEADER_LENGTH + 7];
> +       struct avrcp_player *player = session->controller->player;
> +       struct avrcp_browsing_header *pdu = (void *) buf;
> +       uint16_t length = AVRCP_BROWSING_HEADER_LENGTH + 7;
> +
> +       memset(buf, 0, sizeof(buf));
> +
> +       pdu->pdu_id = AVRCP_GET_TOTAL_NUMBER_OF_ITEMS;
> +       pdu->param_len = htons(7 + sizeof(uint32_t));
> +
> +       pdu->params[0] = player->scope;
> +
> +       length += sizeof(uint32_t);
> +
> +       avctp_send_browsing_req(session->conn, buf, length,
> +                               avrcp_get_total_numberofitems_rsp, session);
> +}
> +
> +static int ct_get_total_numberofitems(struct media_player *mp, const char *name,
> +                                               void *user_data)
> +{
> +       struct avrcp_player *player = user_data;
> +       struct avrcp *session;
> +
> +       if (player->p != NULL)
> +               return -EBUSY;
> +
> +       session = player->sessions->data;
> +
> +       if (g_str_has_prefix(name, "/NowPlaying"))
> +               player->scope = 0x03;
> +       else if (g_str_has_suffix(name, "/search"))
> +               player->scope = 0x02;
> +       else
> +               player->scope = 0x01;
> +
> +       avrcp_get_total_numberofitems(session);
> +
> +       return 0;
> +}
> +
>  static const struct media_player_callback ct_cbs = {
>         .set_setting    = ct_set_setting,
>         .play           = ct_play,
> @@ -2835,6 +2911,7 @@ static const struct media_player_callback ct_cbs = {
>         .search         = ct_search,
>         .play_item      = ct_play_item,
>         .add_to_nowplaying = ct_add_to_nowplaying,
> +       .total_items = ct_get_total_numberofitems,
>  };
>
>  static struct avrcp_player *create_ct_player(struct avrcp *session,
> diff --git a/profiles/audio/player.c b/profiles/audio/player.c
> index 94eb2eb..b7f7b60 100644
> --- a/profiles/audio/player.c
> +++ b/profiles/audio/player.c
> @@ -702,6 +702,31 @@ done:
>         folder->msg = NULL;
>  }
>
> +void media_player_get_number_of_items_complete(struct media_player *mp, int ret)
> +{
> +       struct media_folder *folder = mp->scope;
> +       DBusMessage *reply;
> +
> +       if (folder == NULL || folder->msg == NULL)
> +               return;
> +
> +       if (ret < 0) {
> +               reply = btd_error_failed(folder->msg, strerror(-ret));
> +               goto done;
> +       }
> +
> +       folder->number_of_items = ret;
> +
> +       reply = g_dbus_create_reply(folder->msg,
> +                               DBUS_TYPE_INT32, &folder->number_of_items,
> +                               DBUS_TYPE_INVALID);

Im not quite sure what you are responding here? NumberOfItems is a
property you should emit a signal instead.

> +
> +done:
> +       g_dbus_send_message(btd_get_dbus_connection(), reply);
> +       dbus_message_unref(folder->msg);
> +       folder->msg = NULL;
> +}
> +
>  static const GDBusMethodTable media_player_methods[] = {
>         { GDBUS_METHOD("Play", NULL, NULL, media_player_play) },
>         { GDBUS_METHOD("Pause", NULL, NULL, media_player_pause) },
> diff --git a/profiles/audio/player.h b/profiles/audio/player.h
> index ac2a3da..bc9fa57 100644
> --- a/profiles/audio/player.h
> +++ b/profiles/audio/player.h
> @@ -64,6 +64,8 @@ struct media_player_callback {
>                                         uint64_t uid, void *user_data);
>         int (*add_to_nowplaying) (struct media_player *mp, const char *name,
>                                         uint64_t uid, void *user_data);
> +       int (*total_items) (struct media_player *mp, const char *name,
> +                                               void *user_data);
>  };
>
>  struct media_player *media_player_controller_create(const char *path,
> @@ -104,6 +106,8 @@ void media_player_list_complete(struct media_player *mp, GSList *items,
>  void media_player_change_folder_complete(struct media_player *player,
>                                                 const char *path, int ret);
>  void media_player_search_complete(struct media_player *mp, int ret);
> +void media_player_get_number_of_items_complete(struct media_player *mp,
> +                                               int ret);
>
>  void media_player_set_callbacks(struct media_player *mp,
>                                 const struct media_player_callback *cbs,
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
