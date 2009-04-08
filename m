Return-Path: <cyrus@holtmann.org>
From: Gene Heskett <gene.heskett@verizon.net>
To: Zygo Blaxell <zblaxell@feedme.hungrycats.org>
Subject: Re: The link I had working quit.  Help
Date: Wed, 08 Apr 2009 15:03:20 -0400
Cc: Bastien Nocera <hadess@hadess.net>,
	Zygo Blaxell <zblaxell@dactyl.vpn7.hungrycats.org>,
	jayjwa <jayjwa@atr2.ath.cx>, linux-bluetooth@vger.kernel.org
References: <200904041636.25409.gene.heskett@verizon.net>
 <200904081106.11442.gene.heskett@verizon.net>
 <20090408161729.GD18671@hungrycats.org>
In-reply-to: <20090408161729.GD18671@hungrycats.org>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-15
Message-id: <200904081503.20419.gene.heskett@verizon.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wednesday 08 April 2009, Zygo Blaxell wrote:
>
>If you run 'screen /dev/rfcomm0' it will open a window on /dev/rfcomm0.
>For a real serial port you may need something like
>'screen /dev/ttyS0 9600 cs8 -parenb'.

This works in  place of minicom for the wired port above if I give the screen 
a linefeed it returns the shell string
 "{t2|04}/DD/NITROS9/6309L2/MODULES/SCF:"

And otherwise appears to work except it thinks the mouse is keys on the 
keyboard, rolling the wheel to scroll back up just gets me garbage on the 
shell's command line.

but 'screen /dev/rfcomm0 9600 -parenb' exits in 5 seconds or so.

Thanks all.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Sysadmins busy fighting SPAM.

