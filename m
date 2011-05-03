Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1304379171.13362.41.camel@novo.hadess.net>
References: <1302455477-27664-1-git-send-email-dh.herrmann@googlemail.com>
	<1304379171.13362.41.camel@novo.hadess.net>
Date: Tue, 3 May 2011 13:51:31 +0200
Message-ID: <BANLkTimkpKpGTuTmFdYyjm4Ok_+pwho-aA@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/4] Allow hexadecimal encoded pins
From: David Herrmann <dh.herrmann@googlemail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org, johan.hedberg@gmail.com,
	dforsi@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, May 3, 2011 at 1:32 AM, Bastien Nocera <hadess@hadess.net> wrote:
> What are the necessary changes to be made in gnome-bluetooth?
>
> I'm guessing that we should add a "WIIMOTE" type of special casing in
> the pin database, and pass the adapter address as per the above when a
> PIN is requested.

Exactly. If I click on PIN-type in gnome-bluetooth applet, then there
are already several choices I can make. I'd recommend adding a new one
with "use source address as PIN" and one with "use destination address
as PIN".
Then at least all functionalities to pair with a device are
implemented. Additional auto-detection may be added...

> Is there any way to detect which "type" of pairing is made with the
> Wiimote, eg. you say that button 1+2 will only work for temporary
> connections. Can we detect this? Would pairing anyway work?

I guess you mean that you wanna predict which PIN to use? No, I
currently know no way to detect this. However, one may try the first
pin and if that fails the second pin. As far as I know, the wiimote
does not turn off when a wrong PIN is passed so you can try other
PINs. I am still working on reverse-engineering the protocol and maybe
I will find a way, though.

> Cheers

Regards
David
