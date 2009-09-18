Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] PS3Remote unpairing and power-saving
From: Bastien Nocera <hadess@hadess.net>
To: "Ruslan N. Marchenko" <rufferson@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <a70b8cd30908280742k6cdcaa2l3a267661fe1da17d@mail.gmail.com>
References: <a70b8cd30908280742k6cdcaa2l3a267661fe1da17d@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 18 Sep 2009 12:10:22 +0100
Message-Id: <1253272222.18963.4109.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2009-08-28 at 16:42 +0200, Ruslan N. Marchenko wrote:
> PS3 BD Remote driver in fakehid is not able to detect remote unpairing, thus
> not handling it properly.
> Also it keeps permanent BT link with remote controller, which drains batteries.
> With these changes it now utilize IdleTimeout to implicitly unpair device,
> forcing it to enter low power sleep mode.
> IdleTimeout is treated in seconds, in contrast with default - minutes.
> HID device is created on first pairing, and then kept cached till the end of
> daemon life, allowing pairing key-presses to be sent to application with minimum
> delays.
> HID is distinguished by vendor/product codes, which restricts it to only single
> HID for all registered and active PS3 BD Remote controllers.

Please split your patch into 2:
- one part for the disconnect timeout
- one for the PS button disconnecting the remote

Also, don't call it "unpair", it's not paired in the first place, and it
doesn't unpair it, it disconnects it.

<snip>
> +		fake_hid->timeout = iconn->timeout/60;

Have the timeout be either in seconds, or minutes, don't mix them up.
<snip>
> +static gboolean ps3remote_sendkey(int uinput, unsigned int key,
> +				  unsigned int value)
> +{
> +	struct uinput_event event;
> +	memset(&event, 0, sizeof(event));

Add a linefeed after declarations.

<snip>
>  static gboolean ps3remote_event(GIOChannel *chan, GIOCondition cond,
>  				gpointer data)
>  {
> +	static unsigned int lastkey = 0;
> +	static unsigned int lastval = 0;

Don't use statics, add those to a ps3 specific struct.
<snip>
> +	g_timer_start(((struct fake_hid *)fake->priv)->timer);

Why do you start the timer unconditionally, instead of just when using
the HOME key?

<snip>
> -failed:
> +failed: /*
>  	ioctl(fake->uinput, UI_DEV_DESTROY);
>  	close(fake->uinput);
> -	fake->uinput = -1;
> +	fake->uinput = -1;*/

That looks very wrong to me.

Cheers

