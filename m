Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1319671207-3023-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <CABBYNZKJxM7_FBCHHmn_VKMKvDyui=kJJMyCh45bm=sCmuZd8g@mail.gmail.com>
	<1319671207-3023-1-git-send-email-lucas.demarchi@profusion.mobi>
Date: Fri, 28 Oct 2011 10:46:56 +0300
Message-ID: <CABBYNZ+bn6UAqDLayPfShBZXSO5YBCRmdx2u64+8rq_JBGxoWw@mail.gmail.com>
Subject: Re: [PATCH] AVRCP: implement TRACK-REACHED-END event
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Thu, Oct 27, 2011 at 2:20 AM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> ---
>  audio/avrcp.c     |    2 ++
>  audio/avrcp.h     |    1 +
>  audio/media.c     |   18 ++++++++++++++++++
>  doc/media-api.txt |    6 +++++-
>  4 files changed, 26 insertions(+), 1 deletions(-)
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
> index 5528ada..dd8ed6b 100644
> --- a/audio/media.c
> +++ b/audio/media.c
> @@ -1280,6 +1280,7 @@ static gboolean set_status(struct media_player *mp, DBusMessageIter *iter)
>  static gboolean set_position(struct media_player *mp, DBusMessageIter *iter)
>  {
>        uint32_t value;
> +       struct metadata_value *duration;
>
>        if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_UINT32)
>                        return FALSE;
> @@ -1293,6 +1294,23 @@ static gboolean set_position(struct media_player *mp, DBusMessageIter *iter)
>        if (!mp->position) {
>                avrcp_player_event(mp->player,
>                                        AVRCP_EVENT_TRACK_REACHED_START, NULL);
> +               return TRUE;
> +       }
> +
> +       duration = g_hash_table_lookup(mp->track, GUINT_TO_POINTER(
> +                                       AVRCP_MEDIA_ATTRIBUTE_DURATION));
> +
> +       /*
> +        * If either there's no duration available in metadata and the user
> +        * set 'position' to the maximum value allowed or the position matches
> +        * the duration, send a track-reached-end event.
> +        */
> +       if (duration == NULL && mp->position == UINT32_MAX) {
> +               avrcp_player_event(mp->player, AVRCP_EVENT_TRACK_REACHED_END,
> +                                                                       NULL);

Does the duration really matter if the position is UINT32_MAX? I
thought the idea was that the player could for end of track by setting
it to maximum possible and IMO that should work regardless of the
duration being supported or not.

> +       } else if (duration != NULL && mp->position == duration->value.num) {
> +               avrcp_player_event(mp->player, AVRCP_EVENT_TRACK_REACHED_END,
> +                                                                       NULL);
>        }
>
>        return TRUE;
> diff --git a/doc/media-api.txt b/doc/media-api.txt
> index c748e50..01eb11a 100644
> --- a/doc/media-api.txt
> +++ b/doc/media-api.txt
> @@ -84,7 +84,11 @@ Methods              void RegisterEndpoint(object endpoint, dict properties)
>
>                                uint32 Position
>
> -                                       Playback position in milliseconds
> +                                       Playback position in milliseconds.
> +                                       "Track reached start" and "track
> +                                       reached end" event will be sent once 0
> +                                       or track's duration are set
> +                                       respectively.

I would extend the documentation saying the UINT32_MAX can be used to
say the track has ended or something else went wrong and the position
is no longer valid.


-- 
Luiz Augusto von Dentz
