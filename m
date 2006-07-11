Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.64.0607091841010.20657@ybpnyubfg.ybpnyqbznva>
References: <Pine.LNX.4.64.0607091841010.20657@ybpnyubfg.ybpnyqbznva>
Date: Tue, 11 Jul 2006 13:33:13 +0200
Message-Id: <1152617593.15028.25.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Installing / get running bluez-3.1
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Andreas,

> I run into a problem to install or get running bluez-3.1
> 
> Up to now, I used some version 2.x (can't remember what version as I 
> uninstalled it to early). Compiling and installing the files was no 
> problem, but I can't get it running.
> 
> I use:
> - Kernel 2.6.17.4
> - bluez-libs-3.1
> - bluez-utils-3.1
> - dbus-0.62
> 
> dmesg |grep blue -i -a1 shows:
> 
>  PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
>  Bluetooth: Core ver 2.8
>  NET: Registered protocol family 31
>  Bluetooth: HCI device and connection manager initialized
>  Bluetooth: HCI socket layer initialized
>  PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
>  --
>  NET: Registered protocol family 17
>  Bluetooth: L2CAP ver 2.8
>  Bluetooth: L2CAP socket layer initialized
>  Bluetooth: RFCOMM socket layer initialized
>  Bluetooth: RFCOMM TTY layer initialized
>  Bluetooth: RFCOMM ver 1.7
>  Using IPI Shortcut mode
>  --
>  usb 2-1: configuration #1 chosen from 1 choice
>  Bluetooth: HCI USB driver ver 2.9
>  usbcore: registered new driver hci_usb
> 
> I have a Blue Fritz V2.0 USB dongle and lsmod tells me, that the usb 
> module has been loaded:
>  Module                  Size  Used by
>  hci_usb                 9236  0 
> 
> With vmware and it's USB driver, I'm able to use the Bluetooth dongle, 
> so the USB driver, the dongle and my hardware seem to be ok. So much for 
> the good part.
> 
> Now, if I run rfcomm bind 0, the file /dev/rfcomm gets created:
>  crw-rw-rw-  1 root dialout 216, 0 Jul  9 19:02 /dev/rfcomm0
> 
> rfcomm: (1)
>  rfcomm0: 00:18:xx:xx:xx:xx channel 3 clean
> 
> But the old software that I used to use does not work.
> 
> minicom comes up with the message:
>  minicom: cannot open /dev/rfcomm0: No route to host
> 
> hcitool scan prints:
>  Device is not available: No such device

call "hciconfig -a" and make sure "hcidump -X -V" is running in another
terminal to catch the setup.

You might also kill hcid and then start it with "hcid -n" to catch the
initialization of the adapter via hcidump.

Regards

Marcel




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
