Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1390057034-7983-3-git-send-email-szymon.janc@gmail.com>
References: <1390057034-7983-1-git-send-email-szymon.janc@gmail.com>
	<1390057034-7983-3-git-send-email-szymon.janc@gmail.com>
Date: Sat, 18 Jan 2014 16:05:26 +0100
Message-ID: <CANq1E4Tm2na1zVCdeDK5ihS0fQKCpJ10P0a+pTVUmcURTqCV9A@mail.gmail.com>
Subject: Re: [PATCH 3/3] input: Add DualShock 4 detection
From: David Herrmann <dh.herrmann@gmail.com>
To: Szymon Janc <szymon.janc@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Simon Wood <simon@mungewell.org>,
	Frank Praznik <frank.praznik@oh.rr.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi

@Simon and Frank:
This patch might help fix your DS4 issues.

Cheers
David

On Sat, Jan 18, 2014 at 3:57 PM, Szymon Janc <szymon.janc@gmail.com> wrote:
> DS4 tries to connect right after pairing before SDP search completed
> and no idev is present yet.
> ---
>  profiles/input/server.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/profiles/input/server.c b/profiles/input/server.c
> index 3814eaf..21c589c 100644
> --- a/profiles/input/server.c
> +++ b/profiles/input/server.c
> @@ -118,18 +118,24 @@ static void sixaxis_browse_sdp(const bdaddr_t *src, const bdaddr_t *dst,
>  static bool dev_is_sixaxis(const bdaddr_t *src, const bdaddr_t *dst)
>  {
>         struct btd_device *device;
> +       uint16_t vid, pid;
>
>         device = btd_adapter_find_device(adapter_find(src), dst);
>         if (!device)
>                 return false;
>
> -       if (btd_device_get_vendor(device) != 0x054c)
> -               return false;
> +       vid = btd_device_get_vendor(device);
> +       pid = btd_device_get_product(device);
>
> -       if (btd_device_get_product(device) != 0x0268)
> -               return false;
> +       /* DualShock 3 */
> +       if (vid == 0x054c && pid == 0x0268)
> +               return true;
> +
> +       /* DualShock 4 */
> +       if (vid == 0x054c && pid == 0x05c4)
> +               return true;
>
> -       return true;
> +       return false;
>  }
>
>  static void connect_event_cb(GIOChannel *chan, GError *err, gpointer data)
> --
> 1.8.5.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
