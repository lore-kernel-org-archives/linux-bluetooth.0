Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Microsoft Optical Desktop for Bluetooth - Help!
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <4324344D.1030401@gmail.com>
References: <4324344D.1030401@gmail.com>
Content-Type: text/plain
Message-Id: <1126447038.31313.11.camel@blade>
Mime-Version: 1.0
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
Date: Sun, 11 Sep 2005 15:57:18 +0200

Hi,

> I've recently bought a new PC which came with Microsoft Optical Desktop
> for Bluetooth set. During setup (both Windows and Linux) I've used a
> normal PS/2 keyboard and everything went OK. The installation of the
> bluetooth devices in Windows was also OK.
> 
> But with Linux, I came up with lots of problems. By trial and error, I
> have managed to use it, but I still have problems. The mouse has no
> problems at all, since no PIN is used for it, but for the bluetooth
> keyboard I had to setup a PIN (using the default pin-helper) which has
> to be the same with the one in Windows.
> 
> Although it works for a while, if you don't press any buttons for some
> time, the connection between keyboard and PC is lost.In addition to
> that, when I exit from Linux, the connection is most of times also lost,
> so I cannot control the boot loader or the BIOS and even worse, I have
> to go into Windows to re-install the keyboard so that I can finally use it.
> 
> Thanks god the mouse always works and therefore, I don't have to connect
> a PS/2 keyboard every time I use Linux.

use a HID proxy dongle (CSR or Broadcom) and write the link key for the
keyboard to the Bluetooth chip itself. See the mailing list archive for
some details, because such a question was raised before.

Regards

Marcel




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
