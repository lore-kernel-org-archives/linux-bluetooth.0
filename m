Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] RE: Rfcomm qualification
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: Daryl Van Vorst <daryl@wideray.com>, BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <5.1.0.14.2.20030805095818.0c229058@unixmail.qualcomm.com>
References: <5.1.0.14.2.20030730162942.053ff898@unixmail.qualcomm.com>
	<000501c356b7$2887faf0$1a01010a@baked>
	<000501c356b7$2887faf0$1a01010a@baked>
	<5.1.0.14.2.20030730162942.053ff898@unixmail.qualcomm.com>
	<5.1.0.14.2.20030805095818.0c229058@unixmail.qualcomm.com>
Content-Type: text/plain
Message-Id: <1060121068.962.15.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 06 Aug 2003 00:04:21 +0200

Hi Max,

> >The attached patch sets the default values for session and dlc credits
> >to zero and put in RFCOMM_MAX_CREDITS only if we receive a PN with 1.1
> >flow control.
> >
> >What do you think?
> 
> I don't like this:
> 
> @@ -746,7 +746,7 @@
>         pn->ack_timer   = 0;
>         pn->max_retrans = 0;
>  
> -       if (d->credits) {
> +       if (cr || d->credits) {
> 
> 
> This basically means that we'll always request CFC even if the other side
> explicitly told us that they don't support it. Which is kinda dumb :).

I know exactly what you mean and I don't like it either. But my general
purpose of this patch was not to introduce another "state" of credits.
And btw. credits is a uint at the moment.

What do you thing about using session->flags and once we received a
positive CFC acknowledgment we set a session wide flag?

> Here is what I would do (no time for the patch sory).
> When session is created set s->credits to -1. Replace above if() statement 
> with
>         if (s->credits < 0) {

I think only

	if (s->credits != 0) {

will work in this case ;)

> Also rfcomm_apply_pn() needs to set d->credits only once at the end of the function.

This depends on how strict we want to go with the RFCOMM spec. It says
that if one dlc requests CFC all other dlc's should go with CFC, too. I
like to give the dlc the chance to deactivate or activate CFC even if
session default CFC setting says otherwise. But maybe this feature is
non-sense - I have to think about it in more detail.

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
