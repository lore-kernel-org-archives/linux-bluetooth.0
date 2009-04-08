Return-Path: <cyrus@holtmann.org>
From: Gene Heskett <gene.heskett@verizon.net>
To: Zygo Blaxell <zblaxell@feedme.hungrycats.org>
Subject: Re: The link I had working quit.  Help
Date: Wed, 08 Apr 2009 15:35:04 -0400
Cc: Bastien Nocera <hadess@hadess.net>,
	Zygo Blaxell <zblaxell@dactyl.vpn7.hungrycats.org>,
	jayjwa <jayjwa@atr2.ath.cx>, linux-bluetooth@vger.kernel.org
References: <200904041636.25409.gene.heskett@verizon.net>
 <200904081450.37424.gene.heskett@verizon.net>
 <20090408193008.GE18671@hungrycats.org>
In-reply-to: <20090408193008.GE18671@hungrycats.org>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-15
Message-id: <200904081535.05157.gene.heskett@verizon.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wednesday 08 April 2009, Zygo Blaxell wrote:
>On Wed, Apr 08, 2009 at 02:50:37PM -0400, Gene Heskett wrote:
>> >gnome-bluetooth is a fork of bluez-gnome.  You'd probably have to build
>> > it out of svn at svn://svn.gnome.org/svn/gnome-bluetooth unless
>> > someone's making binary packages somewhere.
>>
>> I see.  Since I've built and installed bluezx-4.34, am I new enough?
>
>bluez is the user-space part of the bluetooth stack.  gnome-bluetooth is the
> UI.
>
>> Got it, cu doesn't know the port(s) I named with the -p option.  And the
>> manpage doesn't seem to describe that part either. :(
>
>	cu -l /dev/ttyS0 -s 9600
>
>or for rfcomm most likely just
>
>	cu -l /dev/rfcomm0
>
>though with a real RS-232 port on the remote device I don't
>know if you have to match baud rates or not.

This is slightly different:
[root@coyote test]# cu -l /dev/rfcomm0 -s 9600
cu: open (/dev/rfcomm0): No route to host
cu: /dev/rfcomm0: Line in use

Line in use?

Thanks.


-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Genius, n.:
	A chemist who discovers a laundry additive that rhymes with "bright."

