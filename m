Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <1101073449.41a10c2976047@www.bluebottle.com>
From: jago25_98 <jago25_98@bluebottle.com>
To: bluez-users@lists.sourceforge.net
Subject: Re3: [Bluez-users] Can l2ping phone but can't `sdptool browse` or
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
Date: Sun, 21 Nov 2004 15:44:09 -0600

discover?
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
User-Agent: Internet Messaging Program (IMP) 3.2.2



root@betty.net[~] # uname -a 
Linux betty 2.6.5 #6 Tue Jun 1 17:11:14 GMT 2004 i686 Intel(R)
Celeron(TM) CPU                1000MHz GenuineIntel GNU/Linux
root@betty.net[~] #

root@betty.net[~] # hciconfig -a
hci0:   Type: USB
        BD Address: 00:0C:41:E2:0D:BE ACL MTU: 192:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN 
        RX bytes:368202 acl:23542 sco:0 events:3232 errors:0
        TX bytes:100964 acl:2584 sco:0 commands:335 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
        Link policy: RSWITCH HOLD SNIFF PARK 
        Link mode: SLAVE ACCEPT 
        Name: 'Ethel-Linux (0)'
        Class: 0x100100
        Service Classes: Object Transfer
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP
Subver: 0x20d
        Manufacturer: Cambridge Silicon Radio (10)

root@betty.net[~] # emerge -s bluez
Searching...   
[ Results for search key : bluez ]
[ Applications found : 9 ]
 
*  net-wireless/bluez-bluefw
      Latest version available: 1.0
      Latest version installed: 1.0
      Size of downloaded files: 135 kB
      Homepage:    http://bluez.sourceforge.net/
      Description: Bluetooth USB Firmware Downloader
      License:     GPL-2

*  net-wireless/bluez-firmware
      Latest version available: 1.0
      Latest version installed: 1.0
      Size of downloaded files: 114 kB
      Homepage:    http://bluez.sourceforge.net/
      Description: Bluetooth Broadcom Firmware
      License:     as-is

*  net-wireless/bluez-hcidump
      Latest version available: 1.9
      Latest version installed: 1.9
      Size of downloaded files: 110 kB
      Homepage:    http://bluez.sourceforge.net/
      Description: bluetooth HCI package analyzer
      License:     GPL-2

*  net-wireless/bluez-hciemu
      Latest version available: 1.0
      Latest version installed: 1.0
      Size of downloaded files: 144 kB
      Homepage:    http://bluez.sourceforge.net/
      Description: bluetooth HCI emulator
      License:     GPL-2

*  net-wireless/bluez-kernel
      Latest version available: 2.3
      Latest version installed: 2.3
      Size of downloaded files: 169 kB
      Homepage:    http://bluez.sourceforge.net/
      Description: bluetooth kernel drivers
      License:     GPL-2

*  net-wireless/bluez-libs
      Latest version available: 2.10
      Latest version installed: 2.10
      Size of downloaded files: 261 kB
      Homepage:    http://bluez.sourceforge.net/
      Description: Bluetooth Userspace Libraries
      License:     GPL-2

*  net-wireless/bluez-pan [ Masked ]
      Latest version available: 1.1
      Latest version installed: [ Not Installed ]
      Size of downloaded files: 190 kB
      Homepage:    http://bluez.sourceforge.net/
      Description: Bluetooth PAN profile implementation
      License:     GPL-2

*  net-wireless/bluez-sdp [ Masked ]
      Latest version available: 1.5
      Latest version installed: 1.5
      Size of downloaded files: 240 kB
      Homepage:    http://bluez.sourceforge.net/
      Description: bluetooth service discovery protocol (sdp)
utilities
      License:     GPL-2

*  net-wireless/bluez-utils
      Latest version available: 2.10-r1
      Latest version installed: 2.10-r1
      Size of downloaded files: 283 kB
      Homepage:    http://bluez.sourceforge.net/
      Description: bluetooth utilities
      License:     GPL-2




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
