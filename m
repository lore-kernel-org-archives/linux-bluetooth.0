Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Epox BT-DG02A crashes kernel 2.6.3
From: Marcel Holtmann <marcel@holtmann.org>
To: Ivars Strazdins <ivars.strazdins@sets.lv>
Cc: bluez-users@lists.sourceforge.net
In-Reply-To: <405022B6.7010504@sets.lv>
References: <405022B6.7010504@sets.lv>
Content-Type: text/plain
Message-Id: <1079088059.738.21.camel@merlin>
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
Date: Fri, 12 Mar 2004 11:41:00 +0100

Hi Ivars,

> I'm trying to use Epox BT-DG02A USB dongle on HP Omnibook 6000 with 
> gentoo linux and kernel 2.6.3, but the dongle crashes kernel 
> intermittently. It happens almost every time I remove the dongle or try 
> to remove uhci-hcd module after Bluetooth has been in use. In every 
> other sense the installation is pretty stable and is working under heavy 
> load and with various external devices including USB storage.
> Yep, I saw that this dongle has NOT been reported as working in hardware 
> list, but two other very similar devices (DG03 and DG02) were there.

this is a known problem with the current USB subsystem of 2.6.x. Use
"hciconfig hci0 down" before you unplug the device.

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
