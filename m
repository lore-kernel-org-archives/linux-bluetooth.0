Return-Path: <cyrus@holtmann.org>
Message-ID: <1356194171.29264.14.camel@aeonflux>
Subject: Re: [PATCH BlueZ 4/4] hog: Remove pre-existing suspend FIFO
From: Marcel Holtmann <marcel@holtmann.org>
To: =?ISO-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Sat, 22 Dec 2012 08:36:11 -0800
In-Reply-To: <1356189162-11584-4-git-send-email-jprvita@openbossa.org>
References: <1356189162-11584-1-git-send-email-jprvita@openbossa.org>
	 <1356189162-11584-4-git-send-email-jprvita@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Joao Paulo,

> If bluetoothd crashes the exit routine of the suspend plugin will not be
> executed, leaving the suspend FIFO behind and preventing the plugin load
> on subsequent executions. This commit checks for pre-existence of the
> suspend FIFO and tries to remove and re-create it.
> ---
>  profiles/input/suspend-dummy.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/profiles/input/suspend-dummy.c b/profiles/input/suspend-dummy.c
> index 33b790a..43384c0 100644
> --- a/profiles/input/suspend-dummy.c
> +++ b/profiles/input/suspend-dummy.c
> @@ -119,6 +119,22 @@ int suspend_init(suspend_event suspend, resume_event resume)
>  
>  	if (mkfifo(HOG_SUSPEND_FIFO, S_IRWXU) < 0) {
>  		int err = -errno;
> +
> +		if (err == -EEXIST) {
> +			DBG("FIFO (%s) already exists, trying to remove",
> +							HOG_SUSPEND_FIFO);
> +
> +			/* remove pre-existing FIFO and retry */
> +			if (remove(HOG_SUSPEND_FIFO) < 0) {

you are looking for unlink() to use here.

> +				err = -errno;
> +				error("Failed to remove FIFO (%s): %s (%d)",
> +					HOG_SUSPEND_FIFO, strerror(-err), -err);
> +				return err;
> +			}
> +
> +			return suspend_init(suspend, resume);
> +		}
> +
>  		error("Can't create FIFO (%s): %s (%d)", HOG_SUSPEND_FIFO,
>  							strerror(-err), -err);
>  		return err;

Regards

Marcel


