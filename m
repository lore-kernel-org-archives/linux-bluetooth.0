Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] USB Died
From: Marcel Holtmann <marcel@holtmann.org>
To: Alexandre Ghisoli <alexandre.ghisoli@ycom.ch>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1089366625.6730.7.camel@pc-04.ycom.ch>
References: <1089366625.6730.7.camel@pc-04.ycom.ch>
Content-Type: text/plain
Message-Id: <1089368028.4857.75.camel@pegasus>
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
Date: Fri, 09 Jul 2004 12:13:48 +0200

Hi Alexandre,

> I'm using diNovo keyb/mice, and I always have this problem, from
> 2.6.2-mhx to 6.7.1-mh1 and the new hipd kernel module.
> 
> Let me list my hardware (only the USB port I'm using for BT hub) :
> 0000:00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 80)
> 
> The problem is that the USB bus (?) died after some time to work (couple
> of days), not depend what I'm doing (use keyboard, mice, or nothing).
> 
> There is the dmesg related :
> uhci_hcd 0000:00:10.1: host system error, PCI problems?
> uhci_hcd 0000:00:10.1: host controller halted, very bad!

this VIA UHCI host controllers seem to be buggy in some cases. Try to
compile your kernel without CONFIG_BT_HCIUSB_SCO.

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
