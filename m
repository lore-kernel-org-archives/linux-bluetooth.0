Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hid2hci and Logitech Hub
From: Marcel Holtmann <marcel@holtmann.org>
To: Alexander Holler <holler@ahsoftware.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <19230000.1072404120@[192.168.207.2]>
References: <8430000.1072356496@[192.168.207.2]>
	 <1072363056.2876.75.camel@pegasus>  <30700000.1072366993@[192.168.207.2]>
	 <1072369721.2876.90.camel@pegasus>  <19230000.1072404120@[192.168.207.2]>
Content-Type: text/plain
Message-Id: <1072406653.2876.98.camel@pegasus>
Mime-Version: 1.0
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
Date: Fri, 26 Dec 2003 03:44:13 +0100

Hi Alexander,

> I though that's nothing from interrest for the mailing list. ;)

you start this thread on the mailing list, so keep it there ;)

> As the report info for 0x10 shows 1 field and the maxusage from that field 
> is 1, it seems there is no way sending 6 bytes (usages?) with one report 
> 0x10 using hiddev (if I have understood that part of hiddev correct ;) ).

I can't tell you how it is with hiddev, but the report ID 16 has six
bytes and the report ID 17 has 19 bytes. Count for yourself.

	Usage Page (Undefined)
	Usage (0x01)
	Collection (Application)
	  Report ID (16)
	  Report Size (8)
	  Report Count (6)
	  Logical Minimum (0)
	  Logical Maximum (65535)
	  Usage (0x01)
	  Input (0x0000)
	  Usage (0x01)
	  Output (0x0000)
	End Collection

	Usage Page (Undefined)
	Usage (0x02)
	Collection (Application)
	  Report ID (17)
	  Report Size (8)
	  Report Count (19)
	  Logical Minimum (0)
	  Logical Maximum (65535)
	  Usage (0x02)
	  Input (0x0000)
	  Usage (0x02)
	  Output (0x0000)
	End Collection

> I've tried sending 6 reports (0x10) with the values 0xff ... 0x00. That 
> hasn't worked (allways remember, I've just started collecting some 
> knowledge of usb, bluetooth and hid ;) ).

With what kind of code?

> Just remove or comment out the release of the isoc_iface. The release isn't 
> needed and that avoids the oops. ;)

Trust me that it is better to check it in detail. You always have to
know why you are doing some things this way and I don't know it right
now.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
