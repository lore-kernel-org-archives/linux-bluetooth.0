Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] No hci-Device available
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <6.2.0.14.0.20051101102405.027aa348@mail.bawue.de>
References: <6.2.0.14.0.20051101102405.027aa348@mail.bawue.de>
Content-Type: text/plain
Message-Id: <1130840329.31561.48.camel@blade>
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
Date: Tue, 01 Nov 2005 11:18:49 +0100

Hi Albert,

> I tried to use a spare bluetooth stick at my older PC with
> Suse 7.3. I checked the kernel config to have USD and Bluetooth
> kernel modules available and compiled. Then I downloaded
> bluez-libs and bluez-utils software packages and compiled both
> successfully. I installed the libs and the utils on my machine
> and they seem to work so far (I got help messages,...).
> 
> After than I tried the hcitool dev command, but no device is
> available. I used modprobe to start hci_usb.o module and I don't
> get any error message at the terminal. The lsmod command lists
> the modules of the kernel:
> 
> Module                  Size  Used by
> ...
> hci_usb                 5120   0
> hci                    17344   0  [hci_usb]
> bluetooth              17296   1
> ...
> usb-ohci               17680   0  (unused)
> usbcore                47264   1  [hci_usb bluetooth usb-ohci]
> ...
> 
> 
> (Ireduced the list)
> 
> It seems the bluetooth kernel support is available...
> 
> Then I checked my syslog entries and found:
> 
> Nov  1 10:53:33 bob kernel: hub.c: 2 ports detected
> Nov  1 10:53:33 bob kernel: hub.c: USB new device connect on bus1/2, 
> assigned device number 2
> Nov  1 10:53:33 bob kernel: usb.c: USB device 2 (vend/prod 0xa12/0x1) is 
> not claimed by any active driver.
> Nov  1 10:53:33 bob kernel: IPv6 v0.8 for NET4.0
> Nov  1 10:53:33 bob kernel: IPv6 over IPv4 tunneling driver
> Nov  1 10:53:33 bob kernel: bluetooth.c: USB Bluetooth support registered
> Nov  1 10:53:33 bob kernel: usb.c: registered new driver bluetooth
> Nov  1 10:53:33 bob kernel: bluetooth.c: found interrupt in
> Nov  1 10:53:33 bob kernel: bluetooth.c: found bulk out
> Nov  1 10:53:33 bob kernel: bluetooth.c: found bulk in
> Nov  1 10:53:33 bob kernel: bluetooth.c: USB Bluetooth converter detected
> Nov  1 10:53:33 bob kernel: bluetooth.c: Bluetooth converter now attached 
> to ttyUB0 (or usb/ttub/0 for devfs)
> Nov  1 10:53:33 bob kernel: bluetooth.c: usb_bluetooth_probe - improper 
> number of endpoints. Bluetooth driver not bound.
> Nov  1 10:53:33 bob last message repeated 6 times
> Nov  1 10:53:33 bob kernel: bluetooth.c: USB Bluetooth tty driver v0.12
> Nov  1 10:53:33 bob kernel: BlueZ HCI Core ver 1.1 Copyright (C) 2000,2001 
> Qualcomm Inc
> Nov  1 10:53:33 bob kernel: Written 2000,2001 by Maxim Krasnyansky 
> <maxk@qualcomm.com>
> Nov  1 10:53:33 bob kernel: BlueZ HCI USB driver ver 1.0 Copyright (C) 
> 2000,2001 Qualcomm Inc
> Nov  1 10:53:33 bob kernel: Written 2000,2001 by Maxim Krasnyansky 
> <maxk@qualcomm.com>
> Nov  1 10:53:33 bob kernel: usb.c: registered new driver hci_usb
> Nov  1 10:53:33 bob kernel: bluetooth.c: usb_bluetooth_probe - improper 
> number of endpoints. Bluetooth driver not bound.
> 
> 
> It seems that there is still something wrong with the driver.
> 
> Can anybody help me with the correct/missing /etc/modules.conf
> entries?
> 
> If the hci_usb-Driver is registered correctly, why do I haven't
> found any hci-device-file ind the /dev directory?
> 
> Do I really need to download 37MB for an newer 2.4.31 kernel to
> access the bloototh stick? - I use 2.4.10 compiled by Suse.

blame SuSE that they compiled the wrong driver for that kernel and yes,
you need to recompile your kernel and you should move to latest kernel
(a 2.6 kernel preferred).

> I searched the mail-list*s archive but I haven't found any
> appropriete to my problem.

Sorry, but you don't. The bluetooth versus hci_usb driver problem is as
old as BlueZ itself ;)

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
