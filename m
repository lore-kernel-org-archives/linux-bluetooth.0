Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] What endian type is supported by audio device ?
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20050503132801.13142.qmail@web8312.mail.in.yahoo.com>
References: <20050503132801.13142.qmail@web8312.mail.in.yahoo.com>
Content-Type: text/plain
Message-Id: <1115134416.8206.22.camel@notepaq>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 03 May 2005 17:33:36 +0200

Hi Mayank,

> > actually this has nothing to do with the machine
> > type. It depends on the
> > endian format of the input PCM stream. So we should
> > add a flags that
> > tells us about the endian format of the input.
> 
> But what do i do if the stream was earlier on in big
> endian format and my audio device does not support big
> endian format?
> 
> That is why, we should check what endian type is
> supported and decide accordingly.

I think that if you use ALSA it can change the endian format on demand
inside the library, but for the a2play and a2recv with OSS support we
can do that inside our own code. It is only byte swapping. And from my
understand it should be done inside the SBC codec. We simpy tell it what
input or output endian format we expect and then it should obey to it.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
