Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] HCI not working after using usb_storage
From: Marcel Holtmann <marcel@holtmann.org>
To: Forever Again <erics_trip@hotmail.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <Law12-F76bdkSmLAztx0004f857@hotmail.com>
References: <Law12-F76bdkSmLAztx0004f857@hotmail.com>
Content-Type: text/plain
Message-Id: <1076715751.18588.106.camel@pegasus>
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
Date: Sat, 14 Feb 2004 00:42:31 +0100

Hi Evan,

> I have a logitech mx900 mouse, which was working fine before. I'm running 
> the 2.6.2 kernel on Fedora. Using the bthid daemon it was working. Then I 
> tried to use a usb memory stick, and after using the usb_storage driver, my 
> mouse stopped working. I check to see what was up and I noticed that my hci 
> device was gone. When I try running hciconfig hci0 up, I get this:
> 
> Can't open HCI socket.: Address family not supported by protocol.
> 
> What do I need to do to get the mouse working again, and is it possible to 
> use the usb_storage as well. I'm more concerned about using the mouse, but 
> both would be nice.

check your log files for a kernel oops or other specific messages from
the USB bus. If you really think that this only happen in conjunction
with the USB storage driver then you should post this to the USB mailing
list.

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
