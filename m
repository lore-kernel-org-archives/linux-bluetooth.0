Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <201108201749.05948.dstockwell@frequency-one.com>
References: <201108201749.05948.dstockwell@frequency-one.com>
Date: Sun, 21 Aug 2011 12:06:47 +0300
Message-ID: <CABBYNZ+KgsT6h0w27dQ6k+n=+uhqxz3HMkVaL29BWQASxpAukg@mail.gmail.com>
Subject: Re: [PATCH 1/3] AVRCP: Eliminate dependency on sink for connect.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: David Stockwell <dstockwell@frequency-one.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

On Sun, Aug 21, 2011 at 1:49 AM, David Stockwell
<dstockwell@frequency-one.com> wrote:
> AVRCP: Eliminate dependency on sink for avrcp-connect.
>
> Required for case where device connecting is an AVRCP-only
> remote, without audio (sink) capability.
>
> Signed-off-by: David Stockwell <dstockwell@frequency-one.com>
> ---
>  audio/manager.c |   17 +++++++++++++++--
>  1 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/audio/manager.c b/audio/manager.c
> index 6e583cf..0c69736 100644
> --- a/audio/manager.c
> +++ b/audio/manager.c
> @@ -224,8 +224,21 @@ static void handle_uuid(const char *uuidstr, struct
> audio_device *device)
>                else
>                        device->control = control_init(device, uuid16,
>                                                        enabled.media_player);
> -               if (device->sink && sink_is_active(device))
> -                       avrcp_connect(device);
> +
> +               /* Eliminate dependency on sink if plain remote (without Sink). */
> +
> +               if (device->sink) {
> +                       if (sink_is_active(device)) {
> +                               DBG("Connecting to AVRCP with active sink");
> +                               avrcp_connect(device);
> +                       } else {
> +                               DBG("Connecting to AVRCP with inactive sink");
> +                               avrcp_connect(device);
> +                       }
> +               } else {
> +                       DBG("Connecting to AVRCP without sink");
> +                       avrcp_connect(device);
> +               }
>                break;
>        default:
>                DBG("Unrecognized UUID: 0x%04X", uuid16);
> --
> 1.7.3.4

IMO we should only auto connect avrcp if AutoConnect is set in
audio.conf, but note that there is a specific sequence recommended
simultaneous audio profiles white paper. In fact I would suggest not
changing this at all but instead implement Control.Connect which would
be used to manually trigger AVRCP connection.

-- 
Luiz Augusto von Dentz
