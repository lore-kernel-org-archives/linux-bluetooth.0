Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Sigrid Kronenberger <skronenberger@web.de>
To: bluez-users@lists.sourceforge.net
Message-Id: <20040811231204.18574a27@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [Bluez-users] AVM BlueFritz with Linux Kernel 2.6.3-15mdk
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
Date: Wed, 11 Aug 2004 23:12:04 +0200

Hello there :)

I'm using Mandrake 10.0 Official with the updated Kernel 2.6.3-15mdk. I
have an USB Bluetooth dongle from AVM (BlueFritz) which don't work... :(

I've copied the firmware to the /usr/lib/hotplug/firmware directory.
hotplugd starts at boot time. I've changed to an older version of the
AVM-firmware, because Marcel told me, that this Kernel won't work with
the newest firmware. 

I've downloaded and installed the newest version of bluez-libs,
bluez-utils, bluezs-pin, bluez-firmware, bluez-hcidump and bluez-hciemu.
(I've compiled myself, no rpm-packages) Source for the software: 
http://www.bluez.org/download.html. 

When I'm typing "hciconfig" in a console, nothing happens... 

Looks like this: 

[root@localhost sigrid]# hciconfig
[root@localhost sigrid]#

Nothing happens :( 

In my /var/log/syslog, I found this entries:
[root@localhost sigrid]# grep Blue /var/log/syslog
Aug 11 19:51:49 localhost kernel: Bluetooth: Core ver 2.3
Aug 11 19:51:49 localhost kernel: Bluetooth: HCI device and connection
manager initialized
Aug 11 19:51:49 localhost kernel: Bluetooth: HCI socket layer
initialized
Aug 11 19:51:49 localhost kernel: Bluetooth: BlueFRITZ! USB driver ver
1.1
Aug 11 19:51:56 localhost kernel: Bluetooth: L2CAP ver 2.1
Aug 11 19:51:56 localhost kernel: Bluetooth: L2CAP socket layer
initialized
Aug 11 19:51:57 localhost kernel: Bluetooth: RFCOMM ver 1.1
Aug 11 19:51:57 localhost kernel: Bluetooth: RFCOMM socket layer
initialized
Aug 11 19:52:01 localhost kernel: Bluetooth: RFCOMM TTY layer
initialized
Aug 11 22:42:04 localhost kernel: Bluetooth: CMTP (CAPI Emulation) ver
1.0
[root@localhost sigrid]#


I've deinstalled my older packages an installed the new packages from
the above mentioned site. 

This are the entries from my /var/log/messages: 

Aug 11 19:51:56 localhost bluetooth: hcid Start succeeded
Aug 11 19:51:56 localhost bluetooth: sdpd Start succeeded
Aug 11 20:01:01 localhost msec: changed mode of
/etc/rc.d/init.d/bluetooth from 755 to 744
Aug 11 20:06:39 localhost rpmdrake-remove[4721]: Removing package
bluez-bluefw-0.9-2mdk.i586
Aug 11 20:06:39 localhost rpmdrake-remove[4721]: Removing package
bluez-hcidump-1.5-2mdk.i586
Aug 11 20:06:39 localhost rpmdrake-remove[4721]: Removing package
bluez-hciemu-1.0-2mdk.i586
Aug 11 20:06:39 localhost rpmdrake-remove[4721]: Removing package
bluez-pan-1.1-2mdk.i586
Aug 11 20:06:39 localhost rpmdrake-remove[4721]: Removing package
bluez-sdp-1.5-1mdk.i586
Aug 11 20:06:39 localhost rpmdrake-remove[4721]: Removing package
bluez-utils-2.4-4mdk.i586
Aug 11 20:06:39 localhost rpmdrake-remove[4721]: Removing package
gnome-bluetooth-0.4.1-4mdk.i586
Aug 11 20:06:39 localhost rpmdrake-remove[4721]: Removing package
kdebluetooth-0.0.cvs20040302-3mdk.i586
Aug 11 20:06:39 localhost rpmdrake-remove[4721]: Removing package
kdebluetooth-devel-0.0.cvs20040302-3mdk.i586
Aug 11 20:06:39 localhost rpmdrake-remove[4721]: Removing package
libbluez1-2.5-1mdk.i586
Aug 11 20:06:39 localhost rpmdrake-remove[4721]: Removing package
libbluez1-devel-2.5-1mdk.i586
Aug 11 20:06:39 localhost rpmdrake-remove[4721]: Removing package
libbluez-sdp2-1.5-1mdk.i586
Aug 11 20:06:39 localhost rpmdrake-remove[4721]: Removing package
libbluez-sdp2-devel-1.5-1mdk.i586
Aug 11 20:06:44 localhost rpmdrake-remove[4721]: [RPM]
bluez-pan-1.1-2mdk removed
Aug 11 20:06:44 localhost bluetooth: hcid heruntergefahren succeeded
Aug 11 20:06:44 localhost bluetooth: sdpd heruntergefahren succeeded
Aug 11 20:06:44 localhost bluetooth: hciattach heruntergefahren failed
Aug 11 20:06:45 localhost rpmdrake-remove[4721]: [RPM]
bluez-utils-2.4-4mdk removed
Aug 11 20:06:54 localhost rpmdrake-remove[4721]: [RPM]
kdebluetooth-0.0.cvs20040302-3mdk removed
Aug 11 20:06:56 localhost rpmdrake-remove[4721]: [RPM]
gnome-bluetooth-0.4.1-4mdk removed
Aug 11 20:06:56 localhost rpmdrake-remove[4721]: [RPM]
bluez-hcidump-1.5-2mdk removed
Aug 11 20:06:57 localhost rpmdrake-remove[4721]: [RPM]
libbluez1-2.5-1mdk removed
Aug 11 20:06:57 localhost rpmdrake-remove[4721]: [RPM]
bluez-sdp-1.5-1mdk removed
Aug 11 20:06:58 localhost rpmdrake-remove[4721]: [RPM]
kdebluetooth-devel-0.0.cvs20040302-3mdk removed
Aug 11 20:06:58 localhost rpmdrake-remove[4721]: [RPM]
bluez-bluefw-0.9-2mdk removed
Aug 11 20:06:59 localhost rpmdrake-remove[4721]: [RPM]
bluez-hciemu-1.0-2mdk removed
Aug 11 20:07:00 localhost rpmdrake-remove[4721]: [RPM]
libbluez-sdp2-1.5-1mdk removed
Aug 11 20:07:00 localhost rpmdrake-remove[4721]: [RPM]
libbluez1-devel-2.5-1mdk removed
Aug 11 20:07:00 localhost rpmdrake-remove[4721]: [RPM]
libbluez-sdp2-devel-1.5-1mdk removed
Aug 11 20:52:41 localhost rpmdrake[12577]: Extracting header of
kdebluetooth-devel-0.0.cvs20040302-3mdk.i586 from
/var/lib/urpmi/hdlist.contrib.cz
Aug 11 20:52:58 localhost rpmdrake[12577]: Extracting header of
libbluez1-devel-2.5-1mdk.i586 from /var/lib/urpmi/hdlist.main.cz
Aug 11 20:53:07 localhost rpmdrake[12577]: Extracting header of
libbluez-sdp2-devel-1.5-1mdk.i586 from /var/lib/urpmi/hdlist.main.cz
Aug 11 20:53:18 localhost rpmdrake[12577]: Installing package
removable://mnt/cdrom/Mandrake/RPMS3/libbluez1-2.5-1mdk.i586.rpm
Aug 11 20:53:18 localhost rpmdrake[12577]: Installing package
removable://mnt/cdrom/Mandrake/RPMS3/libbluez1-devel-2.5-1mdk.i586.rpm
Aug 11 20:53:18 localhost rpmdrake[12577]: Installing package
removable://mnt/cdrom/Mandrake/RPMS3/libbluez-sdp2-1.5-1mdk.i586.rpm
Aug 11 20:53:18 localhost rpmdrake[12577]: Installing package
removable://mnt/cdrom/Mandrake/RPMS3/libbluez-sdp2-devel-1.5-1mdk.i586.
rpm
Aug 11 20:53:18 localhost rpmdrake[12577]: Installing package
ftp://ftp.proxad.net/pub/Distributions_Linux/Mandrakelinux/official/10.0/i586/Mandrake/RPMS/libbluez1-2.5-1mdk.i586.rpm
Aug 11 20:53:18 localhost rpmdrake[12577]: Installing package
ftp://ftp.proxad.net/pub/Distributions_Linux/Mandrakelinux/official/10.0/i586/Mandrake/RPMS/libbluez1-devel-2.5-1mdk.i586.rpm
Aug 11 20:53:18 localhost rpmdrake[12577]: Installing package
ftp://ftp.proxad.net/pub/Distributions_Linux/Mandrakelinux/official/10.0/i586/Mandrake/RPMS/libbluez-sdp2-1.5-1mdk.i586.rpm
Aug 11 20:53:18 localhost rpmdrake[12577]: Installing package
ftp://ftp.proxad.net/pub/Distributions_Linux/Mandrakelinux/official/10.0/i586/Mandrake/RPMS/libbluez-sdp2-devel-1.5-1mdk.i586.rpm
Aug 11 20:54:19 localhost rpmdrake[12577]: [RPM] libbluez1-2.5-1mdk
installed
Aug 11 20:54:20 localhost rpmdrake[12577]: [RPM] libbluez-sdp2-1.5-1mdk
installed
Aug 11 20:54:21 localhost rpmdrake[12577]: [RPM]
libbluez1-devel-2.5-1mdk installed
Aug 11 20:54:23 localhost rpmdrake[12577]: [RPM]
libbluez-sdp2-devel-1.5-1mdk installed
Aug 11 21:01:00 localhost msec: changed mode of
/etc/rc.d/init.d/bluetooth from 755 to 744
[root@localhost sigrid]#


I'm missing an entry for loading the firmware.... (or I'm blind and
don't see this entry... 

Has anyone an idea what can I do? I want my Bluetooth dongle working
under Linux (under Windows it works! - so there's no problem with the
dongle). 

If you need more infos, tell me, what you need, I'll give it to you

Greetings

Sigrid


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
