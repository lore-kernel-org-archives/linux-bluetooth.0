Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Sean Barry" <sfelkes@hotmail.com>
To: Bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY7-F1074lDPHpNwqe00003086@hotmail.com>
Subject: [Bluez-users] BlueZ on Linux iPAQ
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
Date: Tue, 06 Jan 2004 00:27:04 +0000

Hi,

I have the following instructions for installing BlueZ on a Sharp Zaurus, 
however, I have attempted to follow them for Familiar but with no luck.  
Could someone translate the Sharp Zaurus instructions into instructions for 
Familiar on an iPAQ with integrated Bluetooth, but Bluetooth on a CF or 
PCMCIA card.

---------------------------------------------------------------------
Installation instructions for BlueZ binaries on Sharp Zaurus with ROM v3.10
===========================================================================

Upload all of the files to /home/root on the Zaurus, either using scp or 
ftp.
Log into the Zaurus as root.

* Kernel modules
----------------

# mv bluez-kernel-2.4.18-rmk7-pxa3-embedix-arm.tar.gz 
/home/root/modules/2.4.18-rmk7-pxa3-embedix
# cd /home/root/modules/2.4.18-rmk7-pxa3-embedix
# tar zxf bluez-kernel-2.4.18-rmk7-pxa3-embedix-arm.tar.gz
# depmod -a
# mv bluetooth /etc/pcmcia
# mv bluetooth.conf /etc/pcmcia
# /etc/rc.d/init.d/pcmcia restart

* User-libraries
----------------

# cd
# mv libbluetooth.so.1.0.1 libsdp.so.2.0.1 /usr/lib
# cd /usr/lib
# ln -s libbluetooth.so.1.0.1 libbluetooth.so.1
# ln -s libbluetooth.so.1.0.1 libbluetooth.so
# ln -s libsdp.so.2.0.1 libsdp.so.2
# ln -s libsdp.so.2.0.1 libsdp.so

* User-programs
---------------

# cd
# mv hciconfig /usr/sbin
# mv hcid /usr/sbin
# mv sdpd /usr/sbin
# mv sdptool /usr/bin

* Verifying the install
-----------------------
(Insert the Bluetooth card!)

# modprobe l2cap
# lsmod
bluecard_cs             6944   1
l2cap                  16368   2
bluez                  33984   3  [bluecard_cs l2cap]

# hciconfig hci0 up
hci0:   Type: PCCARD
        BD Address: 00:90:02:03:89:0C ACL MTU: 672:10  SCO MTU: 64:0
        UP RUNNING PSCAN ISCAN
        RX bytes:1659564 acl:10626 sco:0 events:5147 errors:0
        TX bytes:1255739 acl:11550 sco:0 commands:1214 errors:0
# sdpd
# sdptool browse ff:ff:ff
Browsing FF:FF:FF:00:00:00 ...
Service Name: SDP Server
Service Description: Bluetooth service discovery server
Service Provider: BlueZ
Service RecHandle: 0x0
Service Class ID List:
  "SDP Server" (0x1000)
Protocol Descriptor List:
  "L2CAP" (0x0100)
    PSM: 1
    Version: 0x0001
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100

Service Name: Public Browse Group Root
Service Description: Root of public group hierarchy
Service Provider: BlueZ
Service RecHandle: 0x15000
Service Class ID List:
  "Browse Group Descriptor" (0x1001)
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100

---------------------------------------------------------------------

Regards,

Sean

_________________________________________________________________
Express yourself with cool new emoticons http://www.msn.co.uk/specials/myemo



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
