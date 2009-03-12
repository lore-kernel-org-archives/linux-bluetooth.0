Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20090312094106.4a95d26e@symphony>
References: <6edf6b480903100602x6b84b8f3o8e2f3266e6b69c47@mail.gmail.com>
	 <6edf6b480903100618k15f77f25p6c2ef1ab42b7b269@mail.gmail.com>
	 <6edf6b480903120218i6066199bx2f0dd6cad564f59f@mail.gmail.com>
	 <20090312094106.4a95d26e@symphony>
Date: Thu, 12 Mar 2009 18:10:09 +0800
Message-ID: <6edf6b480903120310y3b1d23e9v2569e00c65c8aa74@mail.gmail.com>
Subject: Re: dund: how to config for handset platform
From: yesir yao <yesiryao@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>> after I run "dund --listen --dialup --msdun --nodetach"
>
> I'm afraid dund is obsolete in Bluez 4. I think the right way to do it
> is to use rfcomm to create a serial device like /dev/rfcomm0 and use
> pppd to dial-up through that.


I think, It is on the Data terminal side, not for the Gateway side.
the profile looks like:
pc (Data terminal : run pppd and dial to /dev/rfcomm0 )
--> handset (Gateway : with bluetooth chip and modem on tty)
--> gsm (gprs) --> net

now, i want to run "dund --dialup --msdun" on handset,
and receive ppp packet from pc, then send those to modem(ttyS1).

maybe, I must implement it by myself. :-)
