Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] pand connection to XP SP2 fails
From: Erwin Authried <eauth@softsys.co.at>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1103024932.2143.156.camel@pegasus>
References: <1103024795.4097.65.camel@justakiss>
	 <1103024932.2143.156.camel@pegasus>
Content-Type: multipart/mixed; boundary="=-Ym6fQBzzqBkUPiY5ICdx"
Message-Id: <1103025459.4095.68.camel@justakiss>
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
Date: Tue, 14 Dec 2004 12:57:39 +0100


--=-Ym6fQBzzqBkUPiY5ICdx
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Am Die, den 14.12.2004 schrieb Marcel Holtmann um 12:48:
> Hi Erwin,
> 
> > I want to establish a pand connection to XP/SP2 with a MSI-6967 dongle.
> > I have installed the MSI driver for WinXP with SP2. The client is a
> > Laptop with a CBT100C card, Linux 2.4.22-mh7, bluez-libs+utils 2.12.
> > When I try to connect to the XP box with 
> >   pand --role PANU -c <ADR>
> > Windows is asking for the Pin. After entering the correct pin, I'm
> > always getting the following pand error:
> > 
> > ...
> > pand[15249]: Connecting to <ADR>
> > hcid[15183]: link_key_request (sba=..., dab=...)
> > pand[15249]: Connect to <ADR> failed. Protocol error(71)
> > 
> > I'm able to connect to a PC running Bluez with the same setup.
> 
> show us the output of "hcidump -X" (as root) while your are connecting.
> 
> Regards
> 
> Marcel
> 
I have attached the output of "hciconfig -a" and "hcidump -x"

Regards,
Erwin



--=-Ym6fQBzzqBkUPiY5ICdx
Content-Disposition: attachment; filename=hciconfig.txt
Content-Type: text/plain; name=hciconfig.txt; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

hci0:	Type: UART
	BD Address: 00:80:5A:20:F1:5B ACL MTU: 192:8  SCO MTU: 64:8
	UP RUNNING PSCAN ISCAN 
	RX bytes:5644 acl:48 sco:0 events:202 errors:0
	TX bytes:5169 acl:42 sco:0 commands:89 errors:0
	Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
	Link policy: RSWITCH HOLD SNIFF PARK 
	Link mode: SLAVE ACCEPT 
	Name: 'BlueZ (0)'
	Class: 0x3e0100
	Service Classes: Networking, Rendering, Capturing
	Device Class: Computer, Uncategorized
	HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver: 0x20d
	Manufacturer: Cambridge Silicon Radio (10)


--=-Ym6fQBzzqBkUPiY5ICdx
Content-Disposition: attachment; filename=dump.txt
Content-Type: text/plain; name=dump.txt; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

HCIDump - HCI packet analyzer ver 1.16
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
  4D 5D 48 76 0C 00 18 CC 02 00 00 00 01 
> HCI Event: Command Status (0x0f) plen 4
  00 01 05 04 
> HCI Event: Role Change (0x12) plen 8
  00 4D 5D 48 76 0C 00 01 
> HCI Event: Connect Complete (0x03) plen 11
  00 29 00 4D 5D 48 76 0C 00 01 00 
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 15 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
  29 00 0F 00 
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
  4D 5D 48 76 0C 00 01 
> HCI Event: Command Complete (0x0e) plen 6
  01 0D 08 00 29 00 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> HCI Event: Max Slots Change (0x1b) plen 3
  29 00 05 
> ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0040 result 1 status 0
> HCI Event: Link Key Request (0x17) plen 6
  4D 5D 48 76 0C 00 
< HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
  4D 5D 48 76 0C 00 
> HCI Event: Command Complete (0x0e) plen 10
  01 0C 04 00 4D 5D 48 76 0C 00 
> HCI Event: PIN Code Request (0x16) plen 6
  4D 5D 48 76 0C 00 
< HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
  4D 5D 48 76 0C 00 04 31 32 33 34 00 00 00 00 00 00 00 00 00 
  00 00 00 
> HCI Event: Command Complete (0x0e) plen 10
  01 0D 04 00 4D 5D 48 76 0C 00 
> HCI Event: Link Key Notification (0x18) plen 23
  4D 5D 48 76 0C 00 97 24 3F 6E DA 91 C1 4F C5 62 6B 11 0B 27 
  38 3A 00 
> HCI Event: Encrypt Change (0x08) plen 4
  00 29 00 01 
> ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
< ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 1691 
> ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 1691 
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 15]
      BNEP: Control(0x01|0)
        Setup Req(0x01) size 0x02 dst 0x1116(NAP) src 0x1115(PANU)
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 15]
      BNEP: Control(0x01|0)
        Setup Rsp(0x02) res 0x0001
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
< HCI Command: Disconnect (0x01|0x0006) plen 3
  29 00 13 
> HCI Event: Command Status (0x0f) plen 4
  00 01 06 04 
> HCI Event: Disconn Complete (0x05) plen 4
  00 29 00 16 

--=-Ym6fQBzzqBkUPiY5ICdx--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
