Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <20050503130325.36986.qmail@web8306.mail.in.yahoo.com>
From: Mayank Batra <mayankbatra@yahoo.co.in>
Subject: Re: [Bluez-devel] SBC Decoder with /dev/dsp
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
Date: Tue, 3 May 2005 14:03:25 +0100 (BST)

Brad,

> Is a2snk working now then? Can I factor out the
> common stuff in 
> a2snk/a2play without messing up changes anyone is
> holding onto?

Thanks for creating a2dp.h file

And yes, now it is final that a2snk (now a2recv) is
functioning.

I have tested it by using a2play as well as BlueSoleil
as the source. And it is working perfectly alright.

But the problem is again the sequential nature of
a2recv as Marcel pointed out.

But one thing:
a2recv functions in the following scenario:

1) I use a PCM file (.snd), encoded in little-endian
format.

2) I use a2play, which encodes it into sbc.

3) I decode the sbc stream with a2recv, open my
soundcard in little-endian format (My soundcard does
not support big-endian format). But for this I have to
patch the sbc.c to produce output in little endian
format.

After the above steps output is crystal clear.
And when I say clear, it means absolutely clear.
 
> Any suggestions for the name of the new header file
> that a2snk/a2play 
> will include? avdtp.h seems like a poor choice...

a2dp.h is great.
 

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
