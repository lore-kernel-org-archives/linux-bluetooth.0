Return-Path: <cyrus@holtmann.org>
Subject: Re: [RFC][PATCH 0/4] Allow hexadecimal encoded pins
From: Bastien Nocera <hadess@hadess.net>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org, johan.hedberg@gmail.com,
	dforsi@gmail.com
Date: Tue, 03 May 2011 00:32:48 +0100
In-Reply-To: <1302455477-27664-1-git-send-email-dh.herrmann@googlemail.com>
References: <1302455477-27664-1-git-send-email-dh.herrmann@googlemail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Message-ID: <1304379171.13362.41.camel@novo.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, 2011-04-10 at 19:11 +0200, David Herrmann wrote:
<snip>
> Binary pin support is inspired by getting Nintendo Wiimote pairing support.
> To test wiimote pairing with this patch series, do the following:
>  - assume the local bdaddr is: 01:23:45:67:89:ab
>    and the wiimote bdaddr is: ba:98:76:54:32:10
>  - Pairing with red-sync button, use pin: $ab8967452301 (host addr. backwards)
>  - Pairing with 1+2 buttons, use pin: $1032547698ba (wiimote addr backwards)
> Automatic reconnection is only enabled in the wiimote when synced with the
> red-sync button. The 1+2 button method is only for temporary connections.

What are the necessary changes to be made in gnome-bluetooth?

I'm guessing that we should add a "WIIMOTE" type of special casing in
the pin database, and pass the adapter address as per the above when a
PIN is requested.

Is there any way to detect which "type" of pairing is made with the
Wiimote, eg. you say that button 1+2 will only work for temporary
connections. Can we detect this? Would pairing anyway work?

Cheers

