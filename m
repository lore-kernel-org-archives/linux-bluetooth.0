Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Fred =?utf-8?q?Sch=C3=A4ttgen?= <bluez-devel@schaettgen.de>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] sco link help needed
References: <4034CA08.50500@soft.uni-linz.ac.at>
In-Reply-To: <4034CA08.50500@soft.uni-linz.ac.at>
Cc: Simon Vogl <vogl@soft.uni-linz.ac.at>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200402191629.38846.bluez-devel@schaettgen.de>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 19 Feb 2004 16:29:38 +0100

On Thursday 19 February 2004 15:36, Simon Vogl wrote:
> Hi,
> I desparately need some help with audio links:
> I have written two small programs that use my pc to emulate a headset
> and a handsfree device. Both work quite nicely, the rfcomm-based
> initialization takes place, and I get an SCO connection, but mysteriously,
> I don't get a single byte of audio data (I don't see it with hcidump
> neither).
>
> my setup:
> * Acer usb bluetooth dongle
> * test phones used: p800 (headset), p6600/ngage/3650 (handsfree) with no
> luck... * kernel 2.4.23
> * bluez utils&lib from cvs
> * and yes, i did register hset profile via sdptool....
>
> I had the program running perfectly already with a T68i....
> Any help appreciated heavily (for example a traace of a successful
> connection...), Simon

I wrote a small handsfree application as a part of the KDE Bluetooth 
Framework. It basically worked, even though it had problems with an ever 
increasing lag, which has probably nothing to do with bluez. But at the 
moment it's broken and it's not very high priority, since my microphone is 
also broken ;)
But you might take a look at it.. it's in kdeextragear-3:
http://webcvs.kde.org/cgi-bin/cvsweb.cgi/kdeextragear-3/kdebluetooth/handsfree/
I'll try to fix it during the next days.

Btw. I'm not sure if the sound doesn't work currently because of a kernel 
problem. Maybe I should try with an older kernel.. It used to work with 
2.4.24 if I remember correctly.

greetings
Fred


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
