Return-Path: <cyrus@holtmann.org>
Date: Wed, 30 Oct 2013 16:06:51 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] android/hid: Fix not cleanup properly after
 disconnect
Message-ID: <20131030140651.GA1092@x220.p-661hnu-f1>
References: <1383141026-19961-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383141026-19961-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Oct 30, 2013, Luiz Augusto von Dentz wrote:
> If the device is disconnected it should be removed from the list of
> connected devices and free its data.
> ---
>  android/hid.c | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/android/hid.c b/android/hid.c
> index d6ca4b9..b198713 100644
> --- a/android/hid.c
> +++ b/android/hid.c
> @@ -149,15 +149,7 @@ static gboolean ctrl_watch_cb(GIOChannel *chan, GIOCondition cond,
>  	if ((cond & (G_IO_HUP | G_IO_ERR)) && hdev->intr_watch)
>  		g_io_channel_shutdown(chan, TRUE, NULL);
>  
> -	hdev->ctrl_watch = 0;
> -
> -	if (hdev->ctrl_io) {
> -		g_io_channel_unref(hdev->ctrl_io);
> -		hdev->ctrl_io = NULL;
> -	}
> -
> -	if (hdev->intr_io && !(cond & G_IO_NVAL))
> -		g_io_channel_shutdown(hdev->intr_io, TRUE, NULL);
> +	hid_device_free(hdev);

This change looses the shutdown call so it probably needs to stay in
this function.

Johan
