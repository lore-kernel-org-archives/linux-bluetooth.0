Return-Path: <cyrus@holtmann.org>
Message-ID: <1346870088.2680.30.camel@novo.hadess.net>
Subject: Re: [PATCH] Add support for Logitech Harmony Adapter for PS3
From: Bastien Nocera <hadess@hadess.net>
To: David Dillow <dave@thedillows.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 05 Sep 2012 19:34:48 +0100
In-Reply-To: <1346378760.7976.2.camel@obelisk.thedillows.org>
References: <1346378760.7976.2.camel@obelisk.thedillows.org>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 2012-08-30 at 22:06 -0400, David Dillow wrote:
> This emulates a Sony BD Remote for the Logitech Harmony series of
> universal remotes.

Can't test this, but looks good to me.

>  profiles/input/fakehid.c |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/profiles/input/fakehid.c b/profiles/input/fakehid.c
> index 3be1489..dd47287 100644
> --- a/profiles/input/fakehid.c
> +++ b/profiles/input/fakehid.c
> @@ -342,6 +342,16 @@ static struct fake_hid fake_hid_table[] = {
>  		.setup_uinput	= ps3remote_setup_uinput,
>  		.devices	= NULL,
>  	},
> +	/* Logitech Harmony Adapter for PS3 */
> +	{
> +		.vendor		= 0x046d,
> +		.product	= 0x0306,
> +		.connect	= fake_hid_common_connect,
> +		.disconnect	= fake_hid_common_disconnect,
> +		.event		= ps3remote_event,
> +		.setup_uinput	= ps3remote_setup_uinput,
> +		.devices	= NULL,
> +	},
>  
>  	{ },
>  };
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


