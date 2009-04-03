Return-Path: <cyrus@holtmann.org>
From: Gene Heskett <gene.heskett@verizon.net>
To: jayjwa <jayjwa@atr2.ath.cx>
Subject: Re: Newbie, can't find device
Date: Thu, 02 Apr 2009 23:20:42 -0400
Cc: "linux-bluetooth" <linux-bluetooth@vger.kernel.org>
References: <200903252037.03024.gene.heskett@verizon.net>
 <200903300928.02545.gene.heskett@verizon.net>
 <alpine.LNX.2.00.0903312308510.7564@nge2.ngu.pk>
In-reply-to: <alpine.LNX.2.00.0903312308510.7564@nge2.ngu.pk>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Message-id: <200904022320.42302.gene.heskett@verizon.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tuesday 31 March 2009, jayjwa wrote:
>
>That depends on what you want to do exactly. You should be able to follow
> the commands from my first post, to bind an rfcomm device (assuming you're
> trying to connect to something like a bluetooth modem, since you mentioned
> Minicom). You should be able to view the services available on the remote
> system now:
>
>
>sdptool browse <address>

sdptool browse local returns a lot of stuff that means little to me until I 
'learn the lingo'

Specifying anything but 'local' times out eventually.

>Find the one you want, and note the channel it's on. You can then use
> rfcomm, which should make your /dev/rfcomm0 device that's giving access to
> the remote device at the specified channel. See 'rfcomm --help' for rfcomm
> commands (it doesn't have a "--help" parameter, but doing that will cause
> the same output as if it did.)
>
I have made some small progress in that there are some hcitool commands that 
do not return the error screen.  For instance:
[root@coyote blueman-1.02]# hcitool dev
Devices:
        hci0    11:11:11:11:11:11

This after using "rfcomm bind HCI0 11:11:11:11:11:11 1" and then doing a 
listen on channel 1 through 30, but I have NDI how many channels are actually 
allocated in the rules for bt devices.

The other end is running a program that outputs the string "CoCo3 at 
coyote.den" through that device at 9600 baud about 2x/second till I kill it.  
Nothing is heard by hci0 here.

So walk me through setting this up from scratch on the linux end, to connect 
to a bt device on the other and about 20 feet away, that if its beacon is 
running, and I have no clue how to ascertain that, with an 'eb101' string and 
I presume its bdaddr in addition to the string I'm sending.  That end is set 
for 9600 baud, and I've not stumbled over how to set this end for that speed 
yet, so take that into consideration please.

Thank you very much.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Break into jail and claim police brutality.

