Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] SBC Decoder with /dev/dsp
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <4276469B.5050401@xmission.com>
References: <20050501124348.24307.qmail@web8310.mail.in.yahoo.com>
	 <1114952271.21785.13.camel@pegasus> <1114965624.21785.71.camel@pegasus>
	 <4275CBF6.9070300@xmission.com> <1115027766.21785.97.camel@pegasus>
	 <4276469B.5050401@xmission.com>
Content-Type: text/plain
Message-Id: <1115059379.21785.147.camel@pegasus>
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
Date: Mon, 02 May 2005 20:42:59 +0200

Hi Brad,

> FYI, I factored out a2dp.h and renamed a2snk to a2recv. I'm going to 
> wait to create an a2dp.c with common code since there isn't much currently.

I think that we should move the complete AVDTP handling into a2dp.c and
make a2play and a2recv only contain the soundcard/file setup and the
main event loop.

This sounds a little sketchy, but the current problem with a2play is
that it is not fully event driven. It is more a sequential approach and
we should really change it.

First question is if we ever wanna allow a2play and a2recv to output SBC
files or should it always be a soundcard or a PCM file? If we skip that
SBC part, we can integrate the SBC processing directly into the a2dp.c
file and hide it. This will makes things a lot easier.

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
