Return-Path: <bluez@thomae-privat.de>
Message-ID: <40E024AD.1000101@thomae-privat.de>
Date: Mon, 28 Jun 2004 16:01:17 +0200
From: Matthias Thomae <bluez@thomae-privat.de>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Epox Barton keyboard: HID create error 53
References: <40CDE18C.70703@thomae-privat.de>	 <1087255678.13792.51.camel@pegasus>  <40CE96A8.3020407@thomae-privat.de>	 <1087284859.13792.67.camel@pegasus>  <40CEC020.6050107@thomae-privat.de>	 <1087292887.13792.81.camel@pegasus>  <40CF4B17.2010806@thomae-privat.de>	 <1087339715.13792.104.camel@pegasus>  <40D7DDAD.2040908@thomae-privat.de> <1087897207.4328.89.camel@pegasus> <40D8D39E.3070301@thomae-privat.de>
In-Reply-To: <40D8D39E.3070301@thomae-privat.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-users.lists.sourceforge.net>

Hi Marcel and list,

Matthias Thomae wrote:
> I did, attached is how far I got in decoding the descriptor, using the 
> HID Specifications and the Descriptor Tool.
> There are some values (marked with '?') which I can't find in 
> Hut1_11.pdf, but the basic structure should be there.
> 
> Next I would have a closer look at the hid parser, but I'm not sure when 
> I get to do this...

Well, I looked a little closer, and it seems that the debugging message

net/bluetooth/hidp/hid.c: usage index exceeded
net/bluetooth/hidp/hid.c: hid_add_usage failed
net/bluetooth/hidp/hid.c: item 0 2 2 2 parsing failed

is caused by the item USAGE_MAXIMUM(65280) which corresponds to "2A 00 
FF", the 18th item of the descriptor (see below). The maximum number of 
usages is set in net/bluetooth/hidp/hid.h

#define HID_MAX_USAGES                  1024

I tried to increase this to 65535 (FFFF), the theoretical max according 
to HUT 1.11, but it didn't help, because then the max page size is exceeded.

But this doesn't seem reasonable anyway, since the codes E8-FFFF are not 
defined yet (and which keyboard has several tens of thousand keys? ;).

So, can we assume the HID descriptor is "broken"? If yes, what would be 
the way to deal with this? Can we re-set the USAGE_MAXIMUM to a 
reasonable value?

Regards.
Matthias


> ------------------------------------------------------------------------
> 
> USAGE_PAGE (Generic Desktop)			05 01
> USAGE (Keyboard)				09 06
> COLLECTION (Application)			A1 01 
>   USAGE_PAGE (Keyboard)				05 07
>   REPORT_ID (1)					85 01 
>   USAGE_MINIMUM (Keyboard LeftControl)		19 E0
>   USAGE_MAXIMUM (Keyboard Right GUI)		29 E7
>   LOGICAL_MINIMUM (0)				15 00 
>   LOGICAL_MAXIMUM (1)				25 01 
>   REPORT_SIZE (1)				75 01 
>   REPORT_COUNT (8)				95 08 
>   INPUT (Data,Var,Abs)				81 02 
>   REPORT_SIZE (8)				75 08 
>   REPORT_COUNT (1)				95 01 
>   INPUT (Cnst,Ary,Abs)				81 01 
>   USAGE_PAGE (Keyboard)				05 07
>   USAGE_MINIMUM (Reserved (no event indicated))	19 00
>   USAGE_MAXIMUM (65280)				2A 00 FF

this seems to be the problem

>   LOGICAL_MINIMUM (0)				15 00 
>   LOGICAL_MAXIMUM (65280)			26 00 FF
>   REPORT_SIZE (8)				75 08 
>   REPORT_COUNT (6)				95 06 
>   INPUT (Data,Ary,Abs)				81 00 
>   USAGE_PAGE (LEDs)				05 08
>   REPORT_ID (1)					85 01 
>   USAGE_MINIMUM (Num Lock)			19 01
>   USAGE_MAXIMUM (Kana)				29 05
>   REPORT_SIZE (1)				75 01 
>   REPORT_COUNT (5)				95 05 
>   OUTPUT (Data,Var,Abs)				91 02 
>   REPORT_SIZE (3)				75 03 
>   REPORT_COUNT (1)				95 01 
>   OUTPUT (Cnst,Ary,Abs)				91 01 
> END_COLLECTION					C0
> USAGE_PAGE (Consumer Devices)			05 0C
> USAGE (Consumer Control)			09 01
> COLLECTION (Application)			A1 01 
>   REPORT_ID (2)					85 02 
>   USAGE_PAGE (Consumer Devices)			05 0C
>   LOGICAL_MINIMUM (0)				15 00 
>   LOGICAL_MAXIMUM (1)				25 01 
>   REPORT_SIZE (1)				75 01 
>   REPORT_COUNT (18)				95 12 
>   USAGE (Stop)					09 B7
>   USAGE (Play/Pause)				09 CD
>   USAGE (Scan Next Track)			09 B5
>   USAGE (Scan Previous Track)			09 B6
>   USAGE (AL Consumer Control Configuration)	0A 83 01
>   USAGE (Volume Down)				09 EA
>   USAGE (Volume Up)				09 E9
>   USAGE (Mute)					09 E2
>   USAGE (AC Bookmarks )				0A 2A 02
>   USAGE (AL Email Reader)			0A 8A 01
>   USAGE (AC Home )				0A 23 02
>   USAGE (AL Local Machine Browser )		0A 94 01
>   USAGE (AL Calculator)				0A 92 01
>   USAGE (AC Refresh )				0A 27 02
>   USAGE (AC Stop )				0A 26 02
>   USAGE (AC Search )				0A 21 02
>   USAGE (AC Forward )				0A 25 02
>   USAGE (AC Back )				0A 24 02
>   INPUT (Data,Var,Abs)				81 02 
>   REPORT_SIZE (1)				75 01 
>   REPORT_COUNT (6)				95 06 
>   INPUT (Cnst,Ary,Abs)				81 01 
> END_COLLECTION					C0
> USAGE_PAGE (Generic Desktop)			05 01
> USAGE (System Control)				09 80
> COLLECTION (Application)			A1 01 
>   REPORT_ID (3)					85 03 
>   LOGICAL_MINIMUM (0)				15 00 
>   LOGICAL_MAXIMUM (1)				25 01 
>   USAGE (Keyboard Volume Down)			09 81
>   USAGE (Keyboard Locking Caps Lock)		09 82
>   USAGE (Keyboard Locking Num Lock)		09 83
>   REPORT_SIZE (3)				75 03 
>   REPORT_COUNT (1)				95 01 
>   INPUT (Data,Var,Abs)				81 02 
>   REPORT_COUNT (5)				95 05 
>   REPORT_SIZE (1)				75 01 
>   INPUT (Cnst,Ary,Abs)				81 01 
> END_COLLECTION					C0
> USAGE_PAGE (Generic Device Controls)		05 06
> USAGE (?)					09 01
> COLLECTION (Application)			A1 01 
>   REPORT_ID (255)				85 FF 
>   REPORT_COUNT (1)				95 01 
>   REPORT_SIZE (2)				75 02 
>   USAGE (?)					09 24
>   USAGE (?)					09 26
>   INPUT (Data,Var,Abs)				81 02 
>   REPORT_SIZE (6)				75 06 
>   INPUT (Cnst,Ary,Abs)				81 01 
> END_COLLECTION					C0
