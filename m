Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] IBM T41 internal bluetooth, HCI Rev. 0x222
From: Marcel Holtmann <marcel@holtmann.org>
To: Matthias Thomae <thomae@ei.tum.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <406413FF.4070005@ei.tum.de>
References: <406413FF.4070005@ei.tum.de>
Content-Type: text/plain
Message-Id: <1080389355.2281.40.camel@pegasus>
Mime-Version: 1.0
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
Date: Sat, 27 Mar 2004 13:09:15 +0100

Hi Matthias,

> I got this output of 'hciconfig -a' on an IBM Thinkpad T41 with built-in 
> bluetooth (from a kind person, I don't own one myself):
> 
> hci0:   Type: USB
>          BD Address: 00:20:E0:XX:XX:XX ACL MTU: 192:8  SCO MTU: 64:8
>          UP RUNNING PSCAN ISCAN
>          RX bytes:1964236 acl:94984 sco:0 events:4993 errors:0
>          TX bytes:405157 acl:5003 sco:0 commands:15 errors:0
>          Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
>          Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>          Link policy: HOLD SNIFF PARK
>          Link mode: SLAVE ACCEPT
>          Name: 'ondrabook-0'
>          Class: 0x120104
>          Service Classes: Networking, Object Transfer
>          Device Class: Computer, Desktop workstation
>          HCI Ver: 1.1 (0x1) HCI Rev: 0x222 LMP Ver: 1.1 (0x1) LMP Subver:
> 0x222
>          Manufacturer: Cambridge Silicon Radio (10)
> 
> What kind of CSR chip (or Firmware) with what features is this? I 
> couldn't find anything about HCI Rev. 0x222 on 
> http://www.holtmann.org/linux/bluetooth/csr.html.

not all firmware builds are released and have version numbers. Your
Thinkpad uses bc02x_4hci_bt1.1_dev-115_encr128.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
