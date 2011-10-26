Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1319634146-1643-2-git-send-email-lucas.demarchi@profusion.mobi>
References: <1319634146-1643-1-git-send-email-lucas.demarchi@profusion.mobi>
	<1319634146-1643-2-git-send-email-lucas.demarchi@profusion.mobi>
Date: Wed, 26 Oct 2011 16:38:47 +0300
Message-ID: <CABBYNZKJxM7_FBCHHmn_VKMKvDyui=kJJMyCh45bm=sCmuZd8g@mail.gmail.com>
Subject: Re: [PATCH] AVRCP: implement TRACK-REACHED-END event
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Wed, Oct 26, 2011 at 4:02 PM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> ---
>
> I had this originally implemented using timeouts, setting them up once the
> track started, the status or the position changed. It works, but IMO it's ugly
> since it relies on having the track duration and we can't handle it properly
> when we are in fast-forward/backward state. Thus I think it's better to rely on
> user setting the position as we do for "track reached start" event.
>
>  audio/avrcp.c     |    2 ++
>  audio/avrcp.h     |    1 +
>  audio/media.c     |   11 +++++++++++
>  doc/media-api.txt |    6 +++++-
>  4 files changed, 19 insertions(+), 1 deletions(-)
>
> diff --git a/audio/avrcp.c b/audio/avrcp.c
> index 879e959..c9ec314 100644
> --- a/audio/avrcp.c
> +++ b/audio/avrcp.c
> @@ -383,6 +383,7 @@ int avrcp_player_event(struct avrcp_player *player, uint8_t id, void *data)
>                memcpy(&pdu->params[1], data, sizeof(uint64_t));
>
>                break;
> +       case AVRCP_EVENT_TRACK_REACHED_END:
>        case AVRCP_EVENT_TRACK_REACHED_START:
>                size = 1;
>                break;
> @@ -904,6 +905,7 @@ static uint8_t avrcp_handle_register_notification(struct avrcp_player *player,
>                memcpy(&pdu->params[1], &uid, sizeof(uint64_t));
>
>                break;
> +       case AVRCP_EVENT_TRACK_REACHED_END:
>        case AVRCP_EVENT_TRACK_REACHED_START:
>                len = 1;
>                break;
> diff --git a/audio/avrcp.h b/audio/avrcp.h
> index c798658..fb64f3b 100644
> --- a/audio/avrcp.h
> +++ b/audio/avrcp.h
> @@ -71,6 +71,7 @@
>  /* Notification events */
>  #define AVRCP_EVENT_STATUS_CHANGED     0x01
>  #define AVRCP_EVENT_TRACK_CHANGED      0x02
> +#define AVRCP_EVENT_TRACK_REACHED_END  0x03
>  #define AVRCP_EVENT_TRACK_REACHED_START        0x04
>  #define AVRCP_EVENT_LAST               AVRCP_EVENT_TRACK_REACHED_START
>
> diff --git a/audio/media.c b/audio/media.c
> index 5528ada..587544d 100644
> --- a/audio/media.c
> +++ b/audio/media.c
> @@ -1293,6 +1293,17 @@ static gboolean set_position(struct media_player *mp, DBusMessageIter *iter)
>        if (!mp->position) {
>                avrcp_player_event(mp->player,
>                                        AVRCP_EVENT_TRACK_REACHED_START, NULL);
> +       } else {
> +               struct metadata_value *value;
> +
> +               value = g_hash_table_lookup(mp->track, GUINT_TO_POINTER(
> +                                       AVRCP_MEDIA_ATTRIBUTE_DURATION));
> +
> +               if ((value == NULL && mp->position == UINT32_MAX) ||
> +                               (value && value->value.num == mp->position)) {
> +                       avrcp_player_event(mp->player,
> +                                       AVRCP_EVENT_TRACK_REACHED_END, NULL);
> +               }

I would suggest you to check value/duration against NULL, 0 and
UINT32_MAX, in those cases we probably cannot say when the track has
ended because either duration is not supported or over 32 bits so you
should just bail out then after that you can check if position and
duration matches.

Also in this case I would name the variable duration instead of value
to better indicate what it represents.

-- 
Luiz Augusto von Dentz
