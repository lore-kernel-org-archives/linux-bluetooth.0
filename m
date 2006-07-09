Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Sun, 9 Jul 2006 19:15:23 +0200 (CEST)
From: Andreas Fehr <andreas@mrs.ch>
To: bluez-users@lists.sourceforge.net
Message-ID: <Pine.LNX.4.64.0607091841010.20657@ybpnyubfg.ybpnyqbznva>
MIME-Version: 1.0
Subject: [Bluez-users] Installing / get running bluez-3.1
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


Hi

I run into a problem to install or get running bluez-3.1

Up to now, I used some version 2.x (can't remember what version as I 
uninstalled it to early). Compiling and installing the files was no 
problem, but I can't get it running.

I use:
- Kernel 2.6.17.4
- bluez-libs-3.1
- bluez-utils-3.1
- dbus-0.62

dmesg |grep blue -i -a1 shows:

 PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
 Bluetooth: Core ver 2.8
 NET: Registered protocol family 31
 Bluetooth: HCI device and connection manager initialized
 Bluetooth: HCI socket layer initialized
 PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
 --
 NET: Registered protocol family 17
 Bluetooth: L2CAP ver 2.8
 Bluetooth: L2CAP socket layer initialized
 Bluetooth: RFCOMM socket layer initialized
 Bluetooth: RFCOMM TTY layer initialized
 Bluetooth: RFCOMM ver 1.7
 Using IPI Shortcut mode
 --
 usb 2-1: configuration #1 chosen from 1 choice
 Bluetooth: HCI USB driver ver 2.9
 usbcore: registered new driver hci_usb

I have a Blue Fritz V2.0 USB dongle and lsmod tells me, that the usb 
module has been loaded:
 Module                  Size  Used by
 hci_usb                 9236  0 

With vmware and it's USB driver, I'm able to use the Bluetooth dongle, 
so the USB driver, the dongle and my hardware seem to be ok. So much for 
the good part.

Now, if I run rfcomm bind 0, the file /dev/rfcomm gets created:
 crw-rw-rw-  1 root dialout 216, 0 Jul  9 19:02 /dev/rfcomm0

rfcomm: (1)
 rfcomm0: 00:18:xx:xx:xx:xx channel 3 clean

But the old software that I used to use does not work.

minicom comes up with the message:
 minicom: cannot open /dev/rfcomm0: No route to host

hcitool scan prints:
 Device is not available: No such device


What might be the cause of this?


I suspect, it's the dbus subsystem, but I don't get any help there. Is 
there a way to have some verbose messages that tell me where I'm wrong?

dbus-daemon is running:
 /usr/bin/dbus-daemon --config-file=/etc/dbus-1/system.conf

and I started a session daemon:
 dbus-daemon --fork --print-pid 8 --print-address 6 --session


Now I'm stuck...

Any help out there?
Thanks, Andreas


(1)
the ID is my valid phone ID. I copied hcid.conf and rfcomm.conf to save 
my configuration from /etc/bluetooth. This might be an enhancement. Each 
time I install a new version of bluez, the get removed (with the 
uninstall of the old version). Just keep the config data on the system, 
it's easier to remove a configuration directory than to go to the 
server, dig up the backup drive, attach it to the system, search the 
correct backup version, copy the config files, and restore the backup 
drive in the server room... :-)


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
