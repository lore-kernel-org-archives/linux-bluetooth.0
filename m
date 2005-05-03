Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <20050503132023.39036.qmail@web8306.mail.in.yahoo.com>
From: Mayank Batra <mayankbatra@yahoo.co.in>
Subject: Re: [Bluez-devel] SBC Decoder with /dev/dsp
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20050501172156.0ab4ad2a.henryk@ploetzli.ch>
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
Date: Tue, 3 May 2005 14:20:23 +0100 (BST)

Henryk,

> 
> > The output is pretty well if we incorporate the
> proper
> > endian type.
> 
> Ahh, so it works for you now? (I was not able to
> test it yet ...)

It is working PERFECTLY alright. There is absolutely
no difference b/w .snd file and .sbc file qualities.

> I hadn't thought of endianess all the way long. I
> was using big endian
> for the .au file input (don't remember why) in the
> encoder and then
> mostly consequently everywhere from there on.

OK, now one question to u and Marcel,

If the source is sending me sbc file encoded from pcm
file that was in big endian format, and i have an
audio device that supports only little-endian format,
then don't u think that i need to patch the sbc.c file
when the data field is being filled ?????

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
