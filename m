Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1445346988-12782-3-git-send-email-bharat.panda@samsung.com>
References: <1445346988-12782-1-git-send-email-bharat.panda@samsung.com>
	<1445346988-12782-3-git-send-email-bharat.panda@samsung.com>
Date: Wed, 2 Dec 2015 15:41:04 +0200
Message-ID: <CABBYNZL2muG5XsJokwNfWEukBfmq86vUEZsd=JZWOCPSoEGrAw@mail.gmail.com>
Subject: Re: [PATCH 3/3] audio/avrcp: Add support for SetBrowsedPlayer
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Bharat Panda <bharat.panda@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bharat,

On Tue, Oct 20, 2015 at 4:16 PM, Bharat Panda <bharat.panda@samsung.com> wrote:
> Support added to handle SetBrowsedPlayer command for TG role.
>
>     AVCTP Browsing: Response: type 0x00 label 13 PID 0x110e
>       AVRCP: SetBrowsedPlayer: len 0x000a
>        Status: 0x04 (Success)
>        UIDCounter: 0x0000 (0)
>        Number of Items: 0x00000007 (7)
>        CharsetID: 0x006a (UTF-8)
>        Folder Depth: 0x00 (0)
> ---

That patch seems good, but now looking at the decoding it seems we got
AVCTP to do the opposite of what other protocols are doing, so it
should be decode value (raw value) not the other way around. If you
have some time could you please try to fix the this?

>  profiles/audio/avrcp.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  profiles/audio/avrcp.h |  1 +
>  profiles/audio/media.c |  8 +++++++
>  3 files changed, 72 insertions(+)
>
> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> index 7b60012..c20fbcb 100644
> --- a/profiles/audio/avrcp.c
> +++ b/profiles/audio/avrcp.c
> @@ -207,6 +207,15 @@ struct player_item {
>         char name[0];
>  } __attribute__ ((packed));
>
> +struct avrcp_set_browsed_player_rsp {
> +       uint8_t status;
> +       uint16_t uid_counter;
> +       uint32_t num_of_items;
> +       uint16_t charset_id;
> +       uint8_t folder_depth;
> +       uint8_t data[0];
> +} __attribute__ ((packed));
> +
>  struct avrcp_server {
>         struct btd_adapter *adapter;
>         uint32_t tg_record_id;
> @@ -1873,6 +1882,59 @@ err_metadata:
>         return AVRCP_HEADER_LENGTH + 1;
>  }
>
> +static void avrcp_handle_set_browsed_player(struct avrcp *session,
> +                               struct avrcp_browsing_header *pdu,
> +                               uint8_t transaction)
> +{
> +       struct avrcp_player *player;
> +       struct media_player *mp;
> +       struct avrcp_set_browsed_player_rsp *resp;
> +       uint16_t len = ntohs(pdu->param_len);
> +       uint16_t player_id = 0;
> +       uint8_t status;
> +
> +       if (len < 1) {
> +               status = AVRCP_STATUS_INVALID_PARAM;
> +               goto failed;
> +       }
> +
> +       player_id = bt_get_be16(&pdu->params[0]);
> +       player = find_tg_player(session, player_id);
> +
> +       if (!player) {
> +               status = AVRCP_STATUS_NO_AVAILABLE_PLAYERS;
> +               goto failed;
> +       }
> +
> +       if (!(features[7] & 0x08)) {
> +               status = AVRCP_STATUS_PLAYER_NOT_BROWSABLE;
> +               goto failed;
> +       }
> +
> +       mp = player->user_data;
> +       player->browsed = true;
> +
> +       resp = (struct avrcp_set_browsed_player_rsp *) pdu->params;
> +
> +       resp->status = AVRCP_STATUS_SUCCESS;
> +       resp->uid_counter = htons(player_get_uid_counter(player));
> +       resp->num_of_items = htonl(player->cb->get_total_items(mp));
> +
> +       /*
> +        * MPRIS player returns a flat hierarchy playlist structure,
> +        * where the folder depth will always considered to be 0.
> +        */
> +       resp->folder_depth = 0;
> +       resp->charset_id = htons(AVRCP_CHARSET_UTF8);
> +       pdu->param_len = htons(sizeof(*resp));
> +
> +       return;
> +
> +failed:
> +       pdu->params[0] = status;
> +       pdu->param_len = htons(1);
> +}
> +
>  static void avrcp_handle_media_player_list(struct avrcp *session,
>                                 struct avrcp_browsing_header *pdu,
>                                 uint32_t start_item, uint32_t end_item)
> @@ -1989,6 +2051,7 @@ static struct browsing_pdu_handler {
>                                                         uint8_t transaction);
>  } browsing_handlers[] = {
>                 { AVRCP_GET_FOLDER_ITEMS, avrcp_handle_get_folder_items },
> +               { AVRCP_SET_BROWSED_PLAYER, avrcp_handle_set_browsed_player},
>                 { },
>  };
>
> diff --git a/profiles/audio/avrcp.h b/profiles/audio/avrcp.h
> index 86d310c..c09b910 100644
> --- a/profiles/audio/avrcp.h
> +++ b/profiles/audio/avrcp.h
> @@ -101,6 +101,7 @@ struct avrcp_player_cb {
>         bool (*pause) (void *user_data);
>         bool (*next) (void *user_data);
>         bool (*previous) (void *user_data);
> +       uint32_t (*get_total_items) (void *user_data);
>  };
>
>  int avrcp_set_volume(struct btd_device *dev, uint8_t volume, bool notify);
> diff --git a/profiles/audio/media.c b/profiles/audio/media.c
> index 94fce79..a4ff4cc 100644
> --- a/profiles/audio/media.c
> +++ b/profiles/audio/media.c
> @@ -1293,6 +1293,13 @@ static bool previous(void *user_data)
>         return media_player_send(mp, "Previous");
>  }
>
> +static uint32_t get_total_items(void *user_data)
> +{
> +       struct media_player *mp = user_data;
> +
> +       return mp->total_items;
> +}
> +
>  static void playlist_reply(DBusPendingCall *call, void *user_data)
>  {
>         struct player_request *request = user_data;
> @@ -1451,6 +1458,7 @@ static struct avrcp_player_cb player_cb = {
>         .pause = pause,
>         .next = next,
>         .previous = previous,
> +       .get_total_items = get_total_items,
>  };
>
>  static void media_player_exit(DBusConnection *connection, void *user_data)
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
