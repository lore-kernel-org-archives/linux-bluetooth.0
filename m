Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <3eef79ed04100803094fd88c74@mail.gmail.com>
From: Sven Ehret <sven.ehret@gmail.com>
Reply-To: Sven Ehret <sven.ehret@gmail.com>
To: bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [Bluez-users] hid2hci: No devices in HCI mode found
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
Date: Fri, 8 Oct 2004 12:09:52 +0200

running Gentoo Linux. I searched the web like crazy but did not get
much or even helpful information.


# uname -a
Linux svens-gentoo-buechse 2.6.9-rc2 #3 Wed Oct 6 19:34:44 CEST 2004
i686 Intel(R) Pentium(R) 4 CPU 2.53GHz GenuineIntel GNU/Linux


# hciconfig
hci0:   Type: USB
        BD Address: 00:0A:3A:51:F6:C7 ACL MTU: 192:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:84009 acl:1345 sco:0 events:8445 errors:0
        TX bytes:1274818 acl:8338 sco:0 commands:66 errors:0


# lsmod
Module                  Size  Used by
hidp                   11008  2
l2cap                  18692  10 rfcomm,hidp
ohci_hcd               18052  0
ehci_hcd               25348  0
uhci_hcd               27664  0
8139cp                 15360  0
via_agp                 7040  1
firmware_class          7168  1 bcm203x
hci_usb                 8448  2
usbcore                95204  7 ohci_hcd,ehci_hcd,uhci_hcd,bcm203x,hci_usb
nvidia               4810516  12
8139too                19456  0
mii                     3968  2 8139cp,8139too
(some modules not listed for clarity)


I'm thankful for any hints, as usual.

-- 
Sven Ehret


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
