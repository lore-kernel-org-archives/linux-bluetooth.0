Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <1109691651.42248d0394218@mail.orbitel.bg>
From: Todor Todorov <dr_doom@engineer.bg>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] BNEP connection destroing :(
References: <1109664374.42242276c644b@mail.orbitel.bg>
In-Reply-To: <1109664374.42242276c644b@mail.orbitel.bg>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
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
Date: Tue,  1 Mar 2005 17:40:51 +0200

OK.
First i run  run "hcidump -X -V", after that i make bnep connection and start normal internet work (surfing web sites 
and icq).
Here is the result:

this is the end of the result:

< ACL data: handle 41 flags 0x02 dlen 67
    L2CAP(d): cid 0x0045 len 63 [psm 15]
      BNEP: Compressed(0x02|0)
        [proto 0x0800]
        0000: 45 00 00 3c 49 d3 40 00  40 06 dc e6 0a 00 00 02  E..<I.@.@.......
        0010: 0a 00 00 01 0c d3 03 28  35 2b e7 f6 00 00 00 00  .......(5+......
        0020: a0 02 16 d0 41 c2 00 00  02 04 05 b4 04 02 08 0a  ....A...........
        0030: 00 2f ae 25 00 00 00 00  01 03 03 01              ./.%........
< ACL data: handle 41 flags 0x02 dlen 67
    L2CAP(d): cid 0x0045 len 63 [psm 15]
      BNEP: Compressed(0x02|0)
        [proto 0x0800]
        0000: 45 00 00 3c 06 56 40 00  40 06 20 64 0a 00 00 02  E..<.V@.@. d....
        0010: 0a 00 00 01 0c d4 03 28  35 6b a8 73 00 00 00 00  .......(5k.s....
        0020: a0 02 16 d0 81 04 00 00  02 04 05 b4 04 02 08 0a  ................
        0030: 00 2f ae 25 00 00 00 00  01 03 03 01              ./.%........
< ACL data: handle 41 flags 0x02 dlen 192
< ACL data: handle 41 flags 0x01 dlen 192
< ACL data: handle 41 flags 0x01 dlen 192
< ACL data: handle 41 flags 0x01 dlen 192
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 41 reason 0x13
    Reason: Remote User Teminated Connection
> HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 41 reason 0x16
    Reason: Connection Terminated by Local Host

And this is the result when i try to make a new connection without re-plug the bluetooth usb dongle:

HCI sniffer - Bluetooth packet analyzer ver 1.18
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:10:60:A6:1C:30 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 41 bdaddr 00:10:60:A6:1C:30 type ACL encrypt 0x00
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 15 scid 0x0040
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
  0000: 30 1c a6 60 10 00 01                              0..`...
> HCI Event: Max Slots Change (0x1b) plen 3
  0000: 29 00 05                                          )..
< HCI Command: Write Link Supervision Timeout (0x03|0x0037) plen 4
  0000: 29 00 00 00                                       )...
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Supervision Timeout (0x03|0x0037) ncmd 1
    0000: 00 29 00                                          .).

I don't understand what is the problem i how can i fix it.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
