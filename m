Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Many hci devices (?)
From: Marcel Holtmann <marcel@holtmann.org>
To: George Billios <gb3080@bristol.ac.uk>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <40337B23.9070207@bris.ac.uk>
References: <40335E98.9070405@bris.ac.uk> <1077111647.2676.2.camel@pegasus>
	 <40337B23.9070207@bris.ac.uk>
Content-Type: text/plain
Message-Id: <1077119550.2676.19.camel@pegasus>
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
Date: Wed, 18 Feb 2004 16:52:30 +0100

Hi George,

> Ok, thanks, I just renamed the module and it is working now. I think 
> those virtual devices also caused some problem with kde-bluetooth 
> causing a warning before, cause now everything is working fine.

my /dev/vhci looks like this

	crw-rw-rw- 1 root  root  10, 250 2003-05-16 09:12 /dev/vhci

and you see it is the misc major number and minor number 250. The
problem is that 250 is also choosen by the sonypi driver and of course
maybe some others. I had a similiar problem on my VAIO notebook, but
completely forgot about it.

However if the hci_vhci is bound to 10:250 and any program opens a
character device with the same major and minor number the Bluetooth
subsystem creates a new HCI device.

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
