Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1438084995-17990-1-git-send-email-bharat.panda@samsung.com>
References: <1438084995-17990-1-git-send-email-bharat.panda@samsung.com>
Date: Wed, 29 Jul 2015 14:49:06 +0300
Message-ID: <CABBYNZL26X+-bjxYsZpdjkUjg_aokcTHOGZ+0B++ZZAx+zMSCg@mail.gmail.com>
Subject: Re: [PATCH v4] audio/avrcp: Add support for GetTotalNumberOfItems
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Bharat Panda <bharat.panda@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bharat,

On Tue, Jul 28, 2015 at 3:03 PM, Bharat Panda <bharat.panda@samsung.com> wrote:
> Added support for AVRCP GetTotalNumberOfItems command to get
> total num of items in a folder(with a given scope) prior calling
> GetFolderItems to retrieve the content of the folder.
>
> On response, emit PropertyChanged for "NumberOfItems" property on
> MediaPlayer1 interface.
>
> HCI Trace:
>
>       Channel: 66 len 17 ctrl 0x070c [PSM 27 mode 3] {chan 2}
>       I-frame: Unsegmented TxSeq 6 ReqSeq 7
>       AVCTP Browsing: Response: type 0x00 label 6 PID 0x110e
>         AVRCP: GetTotalNumOfItems: len 0x0007
>           Status: 0x04 (Success)
>           UIDCounter: 0x3330 (13104)
>           Number of Items: 0x0001 (1)
> ---
>  profiles/audio/avrcp.c  | 76 ++++++++++++++++++++++++++++++++++++++++++++++++-
>  profiles/audio/player.c | 33 +++++++++++++++++++--
>  profiles/audio/player.h |  4 +++
>  3 files changed, 110 insertions(+), 3 deletions(-)
>
> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> index 5e25cd3..d66f670 100644
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
> @@ -273,7 +274,7 @@ static sdp_record_t *avrcp_ct_record(void)
>         sdp_record_t *record;
>         sdp_data_t *psm[2], *version, *features;
>         uint16_t lp = AVCTP_CONTROL_PSM, ap = AVCTP_BROWSING_PSM;
> -       uint16_t avrcp_ver = 0x0105, avctp_ver = 0x0103;
> +       uint16_t avrcp_ver = 0x0106, avctp_ver = 0x0103;
>         uint16_t feat = ( AVRCP_FEATURE_CATEGORY_1 |
>                                                 AVRCP_FEATURE_CATEGORY_2 |
>                                                 AVRCP_FEATURE_CATEGORY_3 |
> @@ -2827,6 +2828,78 @@ static int ct_add_to_nowplaying(struct media_player *mp, const char *name,
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
> +       uint32_t num_of_items;
> +
> +       if (pdu == NULL)
> +               return -ETIMEDOUT;
> +
> +       if (pdu->params[0] != AVRCP_STATUS_SUCCESS || operand_count < 7)
> +               return -EINVAL;
> +
> +       if (pdu->params[0] == AVRCP_STATUS_OUT_OF_BOUNDS)
> +               goto done;
> +
> +       player->uid_counter = get_be16(&pdu->params[1]);
> +       num_of_items = get_be32(&pdu->params[3]);
> +
> +       if (!num_of_items)
> +               return -EINVAL;
> +
> +done:
> +       media_player_total_items_complete(mp, num_of_items);
> +       return FALSE;
> +}
> +
> +static void avrcp_get_total_numberofitems(struct avrcp *session)
> +{
> +       uint8_t buf[AVRCP_BROWSING_HEADER_LENGTH + 7];
> +       struct avrcp_player *player = session->controller->player;
> +       struct avrcp_browsing_header *pdu = (void *) buf;
> +
> +       memset(buf, 0, sizeof(buf));
> +
> +       pdu->pdu_id = AVRCP_GET_TOTAL_NUMBER_OF_ITEMS;
> +       pdu->param_len = htons(7 + sizeof(uint32_t));
> +
> +       pdu->params[0] = player->scope;
> +
> +       avctp_send_browsing_req(session->conn, buf, sizeof(buf),
> +                               avrcp_get_total_numberofitems_rsp, session);
> +}
> +
> +static int ct_get_total_numberofitems(struct media_player *mp, const char *name,
> +                                               void *user_data)
> +{
> +       struct avrcp_player *player = user_data;
> +       struct avrcp *session;
> +
> +       session = player->sessions->data;
> +
> +       if (session->controller->version != 0x0106) {
> +               error("version not supported");
> +               return -1;
> +       }
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
> @@ -2841,6 +2914,7 @@ static const struct media_player_callback ct_cbs = {
>         .search         = ct_search,
>         .play_item      = ct_play_item,
>         .add_to_nowplaying = ct_add_to_nowplaying,
> +       .total_items = ct_get_total_numberofitems,
>  };
>
>  static struct avrcp_player *create_ct_player(struct avrcp *session,
> diff --git a/profiles/audio/player.c b/profiles/audio/player.c
> index 94eb2eb..147bcbf 100644
> --- a/profiles/audio/player.c
> +++ b/profiles/audio/player.c
> @@ -702,6 +702,23 @@ done:
>         folder->msg = NULL;
>  }
>
> +void media_player_total_items_complete(struct media_player *mp,
> +                                                       uint32_t num_of_items)
> +{
> +       struct media_folder *folder = mp->scope;
> +
> +       if (folder == NULL || folder->msg == NULL)
> +               return;
> +
> +       if (folder->number_of_items != num_of_items) {
> +               folder->number_of_items = num_of_items;
> +
> +               g_dbus_emit_property_changed(btd_get_dbus_connection(),
> +                               mp->path, MEDIA_FOLDER_INTERFACE,
> +                               "NumberOfItems");
> +       }
> +}
> +
>  static const GDBusMethodTable media_player_methods[] = {
>         { GDBUS_METHOD("Play", NULL, NULL, media_player_play) },
>         { GDBUS_METHOD("Pause", NULL, NULL, media_player_pause) },
> @@ -891,6 +908,9 @@ static void media_folder_destroy(void *data)
>  static void media_player_change_scope(struct media_player *mp,
>                                                 struct media_folder *folder)
>  {
> +       struct player_callback *cb = mp->cb;
> +       int err;
> +
>         if (mp->scope == folder)
>                 return;
>
> @@ -920,10 +940,19 @@ cleanup:
>  done:
>         mp->scope = folder;
>
> +       if (cb->cbs->total_items) {
> +               err = cb->cbs->total_items(mp, folder->item->name,
> +                                                       cb->user_data);
> +               if (err < 0)
> +                       DBG("Failed to get total num of items");
> +       } else {
> +               g_dbus_emit_property_changed(btd_get_dbus_connection(),
> +                               mp->path, MEDIA_FOLDER_INTERFACE,
> +                               "NumberOfItems");
> +       }
> +
>         g_dbus_emit_property_changed(btd_get_dbus_connection(), mp->path,
>                                 MEDIA_FOLDER_INTERFACE, "Name");
> -       g_dbus_emit_property_changed(btd_get_dbus_connection(), mp->path,
> -                               MEDIA_FOLDER_INTERFACE, "NumberOfItems");
>  }
>
>  static struct media_folder *find_folder(GSList *folders, const char *pattern)
> diff --git a/profiles/audio/player.h b/profiles/audio/player.h
> index ac2a3da..0871904 100644
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
> +void media_player_total_items_complete(struct media_player *mp,
> +                                               uint32_t num_of_items);
>
>  void media_player_set_callbacks(struct media_player *mp,
>                                 const struct media_player_callback *cbs,
> --
> 1.9.1

Pushed, thanks.


-- 
Luiz Augusto von Dentz
