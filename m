Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] how to program to use hci1 instead of hci0?
From: Marcel Holtmann <marcel@holtmann.org>
To: Zhiwei <eng00787@nus.edu.sg>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <001401c3f201$df7b3a70$eb3812ac@stu.nus.edu.sg>
References: <001401c3f201$df7b3a70$eb3812ac@stu.nus.edu.sg>
Content-Type: text/plain
Message-Id: <1076663374.2671.23.camel@pegasus>
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
Date: Fri, 13 Feb 2004 10:09:34 +0100

Hi Zhiwei,

> I have 2 USB dongles connected to my laptop running Redhat 9.0, and
> 'hcitool dev' shows correctly both devices with distinct user-friendly
> names.  It seems that whenever I run a program, it always utilises
> hci0.  How can I get control over that?  Basically I want to run a
> program each that uses different device, so I can simulate 2 Bluetooth
> devices communicating using the same laptop.

I think it is time to read the man pages. In most cases you have a -i or
-S option to specifiy the source interface.

	hcitool -i hci1 scan

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
