Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] IBM Thinkpad A31p and Bluetooth
From: Marcel Holtmann <marcel@holtmann.org>
To: jvp@lateapex.net
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200309122202.h8CM2X905779@localhost.lateapex.net>
References: <200309122202.h8CM2X905779@localhost.lateapex.net>
Content-Type: text/plain
Message-Id: <1063405430.28891.334.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: 13 Sep 2003 00:23:41 +0200

Hi Jason,

> > the Bluetooth adapter in this notebook is a USB based from CSR and it
> > should work perfect with the hci_usb driver. Have you switched the
> > Bluetooth device on?
> 
> When you say "switched the Bluetooth device on" do you mean like my Palm? 
> My goal is to get the laptop and the Palm chatting with one another via
> Bluetooth.

as I know the IBM notebook's have a switch near the keyboard to switch
the Bluetooth device on and off. Or maybe there is a BIOS option. What
do /proc/bus/usb/devices say? I know that the IBM Ultraport module don't
set the Bluetooth class in the USB descriptor, so maybe we have another
one.

Regards

Marcel




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
