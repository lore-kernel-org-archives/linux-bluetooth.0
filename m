Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] network quits working with x
From: Marcel Holtmann <marcel@holtmann.org>
To: dwillis@stx.rr.com
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <6605513.1079531506650.JavaMail.teamon@b112.teamon.com>
References: <6605513.1079531506650.JavaMail.teamon@b112.teamon.com>
Content-Type: text/plain
Message-Id: <1079623759.3301.44.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 18 Mar 2004 16:29:19 +0100

Hi Dave,

> can anyone help me?  i sent this saturday and haven't had any 
> responses.  thanks.
> 
> i have a sony ericsson t610 phone from t-mobile (usa) and the 
> internet works just fine, but only as long as i'm at the console.
> when i use netscape, mozilla, konquerer, or anything else i soon loose 
> the ability to transmit and receive any data, even though the 
> connection is still there.  anyone have any clues?
> 
> facts about my system:
> 
> Linux version 2.4.20-highmem-ll-pe-mh14-xp (root@tiburon) (gcc version 
> 3.2.3 20030422 (Gentoo Linux 1.4 3.2.3-r1, propolice)) #2 Sat Feb 14 
> 14:25:30 CST 2004

you can of course try the latest 2.4.25 and check if there were some
kernel bugs, but I think that you have some stupid PPP/GPRS settings.

> XFree86 Version 4.3.0
> 
> d-link dbt-120 bluetooth usb dongle.

What do "hciconfig -a" say and what Bluetooth specific kernel options do
you selected?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
