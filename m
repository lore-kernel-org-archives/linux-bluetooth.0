Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] connection times out with hcitool
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <29ee90ed0601030512i42aa27dtef1e65a88cc57375@mail.gmail.com>
References: <29ee90ed0601030512i42aa27dtef1e65a88cc57375@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1136294238.20704.5.camel@localhost>
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
Date: Tue, 03 Jan 2006 14:17:18 +0100

Hi,

> I have an IISC (Integrated System Solution Corp) USB Bluetooth Dongle.
> 
> hciconfig -a output is as below :
> 
> hci0:   Type: USB
>         BD Address: 22:22:22:22:22:22 ACL MTU: 678:8  SCO MTU: 48:10
>         UP RUNNING PSCAN ISCAN INQUIRY
>         RX bytes:1185 acl:0 sco:0 events:21 errors:0
>         TX bytes:75 acl:0 sco:0 commands:21 errors:0
>         Features: 0xbf 0xfe 0x8d 0x78 0x08 0x18 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy:
>         Link mode: SLAVE ACCEPT
>         Name: 'ISSC-BTSPP'
>         Class: 0x000000
>         Service Classes: Unspecified
>         Device Class: Miscellaneous,
>         HCI Ver: 1.2 (0x2) HCI Rev: 0x1f4 LMP Ver: 1.2 (0x2) LMP Subver: 0x1f4
>         Manufacturer: Integrated System Solution Corp. (57)
> 
> A. I have bluez-utils, bluez-libs, bluez-hcidump, bluez-hciemu, 
> kbluetoothd installed
> B.  both daemons (hcid, sdpd) are running.
> C. Kernel version is 2.6.3
> 
> Problem:
> 
> When I try to scan for remote devices using hcitool the connection times out .
> 
> [neo@neo neo]$ hcitool -i hci0 scan
> Scanning ...
> Inquiry failed: Connection timed out
> 
> would appreciate any clues or pointers about this.

use the latest 2.6.15 kernel and everything will be fine.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
