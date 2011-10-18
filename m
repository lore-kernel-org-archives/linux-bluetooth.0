Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1318883671-10932-2-git-send-email-lucas.demarchi@profusion.mobi>
References: <1318883671-10932-1-git-send-email-lucas.demarchi@profusion.mobi>
	<1318883671-10932-2-git-send-email-lucas.demarchi@profusion.mobi>
Date: Tue, 18 Oct 2011 10:24:17 +0300
Message-ID: <CABBYNZ+X7ydH4-WNKyCNH12n1KhSFaE=cC3SpmbwPhSAEOMB4w@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] AVRCP: Use track's UID in event notification
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Mon, Oct 17, 2011 at 11:34 PM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> When registering for TRACK_CHANGED event, CT expects the track's UID in
> the INTERIM and CHANGED responses. According to AVRCP 1.3 spec, there
> are only 2 possible values:
>        1) 0: there's a track selected
>        2) UINT32_MAX: there's no track selected
>
> AVRCP 1.4 reserves the value UINT64_MAX for the second case. Since this
> later value is the one used in certification process for best IOP
> we return UINT64_MAX instead of the former.
>
> This implementation allows to pass PTS test TP/NFY/BV-05-C.
> ---
>  audio/avrcp.c |   16 +++++-----------
>  audio/avrcp.h |    1 +
>  audio/media.c |   17 ++++++++++++++++-
>  3 files changed, 22 insertions(+), 12 deletions(-)
>
> diff --git a/audio/avrcp.c b/audio/avrcp.c
> index ac7c8d4..076fdf4 100644
> --- a/audio/avrcp.c
> +++ b/audio/avrcp.c
> @@ -363,18 +363,11 @@ int avrcp_player_event(struct avrcp_player *player, uint8_t id, void *data)
>                pdu->params[1] = *((uint8_t *)data);
>
>                break;
> -       case AVRCP_EVENT_TRACK_CHANGED: {
> +       case AVRCP_EVENT_TRACK_CHANGED:
>                size = 9;
> -
> -               /*
> -                * AVRCP 1.3 supports only one track identifier: PLAYING
> -                * (0x0). When 1.4 version is added, this shall be changed to
> -                * contain the identifier of the track.
> -                */
> -               memset(&pdu->params[1], 0, 8);
> +               memcpy(&pdu->params[1], data, sizeof(uint64_t));
>
>                break;
> -       }
>        default:
>                error("Unknown event %u", id);
>                return -EINVAL;
> @@ -828,6 +821,7 @@ static uint8_t avrcp_handle_register_notification(struct avrcp_player *player,
>                                                uint8_t transaction)
>  {
>        uint16_t len = ntohs(pdu->params_len);
> +       uint64_t uid;
>
>        /*
>         * 1 byte for EventID, 4 bytes for Playback interval but the latest
> @@ -845,8 +839,8 @@ static uint8_t avrcp_handle_register_notification(struct avrcp_player *player,
>                break;
>        case AVRCP_EVENT_TRACK_CHANGED:
>                len = 9;
> -
> -               memset(&pdu->params[1], 0, 8);
> +               uid = player->cb->get_uid(player->user_data);
> +               memcpy(&pdu->params[1], &uid, sizeof(uint64_t));
>
>                break;
>        default:
> diff --git a/audio/avrcp.h b/audio/avrcp.h
> index 360a80a..8cf95a4 100644
> --- a/audio/avrcp.h
> +++ b/audio/avrcp.h
> @@ -75,6 +75,7 @@
>  struct avrcp_player_cb {
>        int (*get_setting) (uint8_t attr, void *user_data);
>        int (*set_setting) (uint8_t attr, uint8_t value, void *user_data);
> +       uint64_t (*get_uid) (void *user_data);
>        void *(*get_metadata) (uint32_t id, void *user_data);
>        GList *(*list_metadata) (void *user_data);
>        uint8_t (*get_status) (void *user_data);
> diff --git a/audio/media.c b/audio/media.c
> index 519cafe..9ef393b 100644
> --- a/audio/media.c
> +++ b/audio/media.c
> @@ -1168,6 +1168,18 @@ static GList *list_metadata(void *user_data)
>        return g_hash_table_get_keys(mp->track);
>  }
>
> +static uint64_t get_uid(void *user_data)
> +{
> +       struct media_player *mp = user_data;
> +
> +       DBG("%p", mp->track);
> +
> +       if (mp->track == NULL)
> +               return UINT64_MAX;
> +
> +       return 0;
> +}
> +
>  static void *get_metadata(uint32_t id, void *user_data)
>  {
>        struct media_player *mp = user_data;
> @@ -1220,6 +1232,7 @@ static struct avrcp_player_cb player_cb = {
>        .get_setting = get_setting,
>        .set_setting = set_setting,
>        .list_metadata = list_metadata,
> +       .get_uid = get_uid,
>        .get_metadata = get_metadata,
>        .get_position = get_position,
>        .get_status = get_status
> @@ -1369,6 +1382,7 @@ static gboolean parse_player_metadata(struct media_player *mp,
>        GHashTable *track;
>        int ctype;
>        gboolean title = FALSE;
> +       uint64_t uid;
>
>        ctype = dbus_message_iter_get_arg_type(iter);
>        if (ctype != DBUS_TYPE_ARRAY)
> @@ -1466,8 +1480,9 @@ static gboolean parse_player_metadata(struct media_player *mp,
>        mp->track = track;
>        mp->position = 0;
>        g_timer_start(mp->timer);
> +       uid = get_uid(mp);
>
> -       avrcp_player_event(mp->player, AVRCP_EVENT_TRACK_CHANGED, NULL);
> +       avrcp_player_event(mp->player, AVRCP_EVENT_TRACK_CHANGED, &uid);
>
>        return TRUE;
>
> --
> 1.7.7
>
> --

Ack.

-- 
Luiz Augusto von Dentz
