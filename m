Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <20050505123708.92329.qmail@web8307.mail.in.yahoo.com>
From: Mayank Batra <mayankbatra@yahoo.co.in>
Subject: Re: [Bluez-devel] What endian type is supported by audio device ?
To: bluez-devel@lists.sourceforge.net
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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
Date: Thu, 5 May 2005 13:37:08 +0100 (BST)

Marcel,


> I think that if you use ALSA it can change the
> endian format on demand
> inside the library, but for the a2play and a2recv
> with OSS support we
> can do that inside our own code. It is only byte
> swapping. And from my
> understand it should be done inside the SBC codec.
> We simpy tell it what
> input or output endian format we expect and then it
> should obey to it.

But this means that we will have to add a flag bit to
indicate the endian type.

This is ok between a2play and a2recv. But do you mean
that we are gonna be limited to these two applications
only?

For instance, I tested a2recv with BlueSoleil and it
was working perfectly alright, i.e. if I opened the
audio device in little-endian format, did the byte
swapping in sbc.c file.

But we can't reprogram a third party s/w to incoporate
a bit for endian type.

Mayank

________________________________________________________________________
Yahoo! India Matrimony: Find your life partner online
Go to: http://yahoo.shaadi.com/india-matrimony


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
