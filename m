Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] SBC Decoder with /dev/dsp
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <4275CBF6.9070300@xmission.com>
References: <20050501124348.24307.qmail@web8310.mail.in.yahoo.com>
	 <1114952271.21785.13.camel@pegasus> <1114965624.21785.71.camel@pegasus>
	 <4275CBF6.9070300@xmission.com>
Content-Type: text/plain
Message-Id: <1115027766.21785.97.camel@pegasus>
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
Date: Mon, 02 May 2005 11:56:06 +0200

Hi Brad,

> Thanks for also cleaning up the stuff I did to make libao optional.

you are welcome.

> Is a2snk working now then? Can I factor out the common stuff in 
> a2snk/a2play without messing up changes anyone is holding onto?

The sbcdec does not accept input from standard input at the moment and I
think we should implement the soundcard access over /dev/dsp directly
into a2snk. And for a2play we may wanna add support to read its input
from the soundcard.

And btw we should rename a2snk to a2recv.

> Any suggestions for the name of the new header file that a2snk/a2play 
> will include? avdtp.h seems like a poor choice...

Simply name the common code a2dp.c and a2dp.h.

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
