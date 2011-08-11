Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1312981596-7291-19-git-send-email-lucas.demarchi@profusion.mobi>
References: <1312981596-7291-1-git-send-email-lucas.demarchi@profusion.mobi>
	<1312981596-7291-19-git-send-email-lucas.demarchi@profusion.mobi>
Date: Thu, 11 Aug 2011 11:15:53 +0300
Message-ID: <CABBYNZLPYQKtiSTfD-H1svLrSgOTmMuHyFhb0t673FgFEkYnmQ@mail.gmail.com>
Subject: Re: [PATCH v3 18/22] avrcp: send response for registered events
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Wed, Aug 10, 2011 at 4:06 PM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
>  static void mp_get_playback_status(struct media_player *mp, uint8_t *status,
>                                        uint32_t *elapsed, uint32_t *track_len)
>  {
> @@ -754,6 +823,13 @@ static void mp_set_playback_status(struct control *control, uint8_t status,
>                return;
>
>        mp->status = status;
> +
> +       if (control->state == AVCTP_STATE_CONNECTED &&  !control->target &&
> +                       (control->registered_events &
> +                               (1 << AVRCP_EVENT_PLAYBACK_STATUS_CHANGED))) {
> +               avctp_send_event(control, AVRCP_EVENT_PLAYBACK_STATUS_CHANGED,
> +                                                               &status);
> +       }

Are you sure it would be valid to call mp_set_playback_status when
acting as a controller? Im afraid we should not cache anything, or
perhaps not even register MediaPlayer interface in case the device is
a target.

>
>  /*
> @@ -901,6 +977,12 @@ static void mp_set_media_attributes(struct control *control,
>                           "\tTrack number: %u\n\tTrack duration: %u",
>                           mi->title, mi->artist, mi->album, mi->genre,
>                           mi->ntracks, mi->track, mi->track_len);
> +
> +       if (control->state == AVCTP_STATE_CONNECTED && !control->target &&
> +                                       (control->registered_events &
> +                                        (1 << AVRCP_EVENT_TRACK_CHANGED))) {
> +               avctp_send_event(control, AVRCP_EVENT_TRACK_CHANGED, NULL);
> +       }

Same here.


-- 
Luiz Augusto von Dentz
