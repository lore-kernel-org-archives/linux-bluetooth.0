Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Sebastian Roth <sebiroth@web.de>
Message-ID: <cvg3ls$t62$1@sea.gmane.org>
References: <20050222164005.71253.qmail@web26409.mail.ukl.yahoo.com> <20050222172313.48745.qmail@web26410.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
In-Reply-To: <20050222172313.48745.qmail@web26410.mail.ukl.yahoo.com>
Subject: [Bluez-users] Re: Driver version problems..hci_usb & bluetooth parser
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 22 Feb 2005 21:15:39 +0100

Hi!

> hci_usb: no version for "struct_module" found: kernel
> tainted.
> hci_usb: no version magic, tainting kernel.
Try google or some other great magic tool ;-)
Seems to me that the kernel image was not compiled from
exactly the same sources.
IMHO it's better to compile a complete new kernel and not
only some modules and try to load them into the
distribution kernel (this is just my guess about what might
be the problem so please complain if I'm wrong)

Best regards,
Sebastian



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
