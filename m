Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Riku Voipio <riku.voipio@iki.fi>
To: bluez-users@lists.sourceforge.net
Message-ID: <20040501171104.GA3539@kos.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] Pairing problems(?)
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
Date: Sat, 1 May 2004 20:11:04 +0300

Hi,

I'm having problems pairin and hci_usb device and siemens s55 mobile
phone..  Everything seems to work fine, the mobile asks for pin, but
the actual connections time out.

 nchip@wombat:~$ hcitool scan
 Scanning ...
	00:01:E3:xx:xx:xx       Satu87

 nchip@wombat:~$ sdptool search --bdaddr 00:01:E3:xx:xx:xx DUN
 Failed to connect to SDP server on 00:01:E3:xx:xx:xx: Connection timed out

Thats when the phone asks for pin, and I enter the same one as in the
givepin script I wrote.

< HCI Command: Create Connection(0x01|0x0005) plen 13
> HCI Event: Command Status(0x0f) plen 4
> HCI Event: Link Key Request(0x17) plen 6
< HCI Command: Link Key Request Reply(0x01|0x000b) plen 22
> HCI Event: Command Complete(0x0e) plen 10
> HCI Event: PIN Code Request(0x16) plen 6
< HCI Command: PIN Code Request Reply(0x01|0x000d) plen 23
> HCI Event: Command Complete(0x0e) plen 10
> HCI Event: Link Key Notification(0x18) plen 23
> HCI Event: Connect Complete(0x03) plen 11
< ACL data: handle 0x002a flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
> HCI Event: Command Complete(0x0e) plen 6
> HCI Event: Max Slots Change(0x1b) plen 3
(here is a long wait)
> HCI Event: Mode Change(0x14) plen 6
< HCI Command: Disconnect(0x01|0x0006) plen 3
> HCI Event: Command Status(0x0f) plen 4
> HCI Event: Disconn Complete(0x05) plen 4

After the connection ends, the phone asks if it should add womba-0 to
known devices. even atfer adding to known devices, connections fail.
Trying to connect or send stuff from phone to bluez causes just an
internal bluetooth error.

I tried with and without auth/encrypt. Can anyone hint with me what I am
doing wrong?

rfcomm fails too:

  $ rfcomm
  rfcomm0: 00:01:E3:xx:xx:xx channel 1 clean
  $ rfcomm connect 0
  Can't connect RFCOMM socket: Resource temporarily unavailable

hcid.conf:

options {
        autoinit yes;
        security auto;
        pairing multi;
        pin_helper /etc/bluetooth/givepin;
}
device {
        name "%h-%d";
        class 0x100;
        iscan enable; pscan enable;
        lm accept;
        lp hold,sniff,park;
        auth enable;
        encrypt enable;
}

givepin:

#!/bin/sh
echo "PIN:1234"

Linux wombat 2.6.6-rc1 #1 Wed Apr 21 03:05:54 EEST 2004 i686 GNU/Linux

hciconfig -a

hci0:   Type: USB
        BD Address: 00:20:E0:74:49:2C ACL MTU: 192:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN AUTH ENCRYPT
        RX bytes:9239 acl:4 sco:0 events:675 errors:0
        TX bytes:6880 acl:58 sco:0 commands:371 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DH1 HV1
        Link policy: HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'wombat-0'
        Class: 0x000100
        Service Classes: Unspecified
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x222 LMP Ver: 1.1 (0x1) LMP Subver: 0x222
        Manufacturer: Cambridge Silicon Radio (10)



-- 
Riku Voipio  	       | riku.voipio at iki.fi         |
kirkkonummentie 33     |    +358 44 5000343          --+--
02140 Espoo            |                               |
dark> A bad analogy is like leaky screwdriver          |


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
