Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Peter K. Martin" <Peter.K.Martin@t-online.de>
To: <bluez-users@lists.sourceforge.net>
Subject: AW: AW: [Bluez-users]  Again dund
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAosiAEZOtxUiHqgChZUVmh8KAAAAQAAAAO5qWLdOLE0SlT9H59+95+AEAAAAA@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1099685906.6919.25.camel@pegasus>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 8 Nov 2004 09:50:04 +0100

Hi Marcel,
now I give you the responses of hcidump -x and I hope that you can give =
me a
hint for my next steps to the bluetooth connection.
At first I have to initialize the BT-function of my Toshiba-notebook by
dmabt, then I run the hcidump -x

With hcitool I'm scanning for BT-devices:
Linux-Notebook:~ # hcitool scan
Scanning ...
        00:0B:CE:00:01:8F       Bluetooth-Modul
        00:02:EE:D0:49:44       PkM 6820
HCIDUMP -X gives the response
< HCI Command: Inquiry(0x01|0x0001) plen 5
  33 8B 9E 08 64
> HCI Event: Command Status(0x0f) plen 4
  00 01 01 04
> HCI Event: Inquiry Result(0x02) plen 15
  01 44 49 D0 EE 02 00 01 00 00 04 02 52 5E 30
> HCI Event: Inquiry Result(0x02) plen 15
  01 8F 01 00 CE 0B 00 01 00 00 00 03 02 57 7A
> HCI Event: Inquiry Complete(0x01) plen 1
  00
< HCI Command: Remote Name Request(0x01|0x0019) plen 10
  8F 01 00 CE 0B 00 02 00 00 00
> HCI Event: Command Status(0x0f) plen 4
  00 01 19 04
> HCI Event: Remote Name Req Complete(0x07) plen 255
  00 8F 01 00 CE 0B 00 42 6C 75 65 74 6F 6F 74 68 2D 4D 6F 64
  75 6C 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
< HCI Command: Remote Name Request(0x01|0x0019) plen 10
  44 49 D0 EE 02 00 02 00 00 00
> HCI Event: Command Status(0x0f) plen 4
  00 01 19 04
> HCI Event: Remote Name Req Complete(0x07) plen 255
  00 44 49 D0 EE 02 00 50 6B 4D 20 36 38 32 30 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Than I run dund --connect 00:0B:CE:00:01:8F # address of BT-Modul
and
HCIDUMP -X response
< HCI Command: Create Connection(0x01|0x0005) plen 13
  8F 01 00 CE 0B 00 18 CC 02 00 00 00 01
> HCI Event: Command Status(0x0f) plen 4
  00 01 05 04
> HCI Event: Role Change(0x12) plen 8
  00 8F 01 00 CE 0B 00 01
> HCI Event: Connect Complete(0x03) plen 11
  00 29 00 8F 01 00 CE 0B 00 01 00
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
  29 00 0F 00
> HCI Event: Page Scan Repetition Mode Change(0x20) plen 7
  8F 01 00 CE 0B 00 01
> HCI Event: Command Complete(0x0e) plen 6
  01 0D 08 00 29 00
> HCI Event: Max Slots Change(0x1b) plen 3
  29 00 05
> HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
> HCI Event: Link Key Request(0x17) plen 6
  8F 01 00 CE 0B 00
< HCI Command: Link Key Request Reply(0x01|0x000b) plen 22
  8F 01 00 CE 0B 00 57 D3 4C A0 11 16 5C 3F 27 59 01 71 9C D2
  AC 1B
> HCI Event: Command Complete(0x0e) plen 10
  01 0B 04 00 8F 01 00 CE 0B 00
> ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 3 status 0
< HCI Command: Disconnect(0x01|0x0006) plen 3
  29 00 13
> HCI Event: Command Status(0x0f) plen 4
  00 01 06 04
> HCI Event: Disconn Complete(0x05) plen 4
  00 29 00 16

there is no bt-connection established and I don't know why.

Marcel, please be so kind to give me some hints.

Thanks and regards
Peter




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users
