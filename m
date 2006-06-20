Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <aa7ce83b0606200737m3c91d17anfce14229ca245b13@mail.gmail.com>
Date: Wed, 21 Jun 2006 00:37:26 +1000
From: "Ken Robinson" <kenrobinsonster@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] Cannot Get bnep0 on pand connect
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0296435380=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0296435380==
Content-Type: multipart/alternative;
	boundary="----=_Part_104557_24625940.1150814246512"

------=_Part_104557_24625940.1150814246512
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,
I am presently trying to get a bluetooth IP connection between two linux
boxes.
I have made 2.25 bluez-utils and bluez-libs  for  both the  host  computer
(a kanotix 2.6.x kernel) and at target  (a korebot with a 2.4.19 kernel with
the bluez patch-2.4.19-mh18 applied)
I have experimented on the host computer (a kanotix 2.6.x kernel) and am
able to get a bnep0 interface.
For the connection between host and target:
I do the following:
# modprobe bnep
# pand --listen -r GN
On the target computer I do:
# modprobe bnep
# pand --connect <BT address>
I cannot get a bnep0 interface
# ifconfig bnep0
ifconfig: bnep0: error fetching interface information: Device not found

The hcidump on the host computer is shown below. Does anyone have any ideas?

root@Possibility:/home/krobinson# hcidump -X -V
HCI sniffer - Bluetooth packet analyzer ver 1.23
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:02:72:B0:C5:FB class 0x000000 type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 00:02:72:B0:C5:FB role 0x00
    Role: Master
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> HCI Event: Role Change (0x12) plen 8
    status 0x00 bdaddr 00:02:72:B0:C5:FB role 0x00
    Role: Master
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 42 bdaddr 00:02:72:B0:C5:FB type ACL encrypt 0x00
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
    handle 42 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
    bdaddr 00:02:72:B0:C5:FB mode 1
> HCI Event: Command Status (0x0f) plen 4
    Change Connection Packet Type (0x01|0x000f) status 0x00 ncmd 1
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
    status 0x00 handle 42 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 42 slots 5
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 15 scid 0x0040
< ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 1691
< ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 1691
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success

------=_Part_104557_24625940.1150814246512
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br>I am presently trying to get a bluetooth IP connection between two linux boxes.<br>I have made 2.25 bluez-utils and bluez-libs&nbsp; for&nbsp; both the&nbsp; host&nbsp; computer (a kanotix 2.6.x kernel) and at target&nbsp;  (a korebot with a 
2.4.19 kernel with the bluez patch-2.4.19-mh18 applied)<br>I have experimented on the host computer (a kanotix 2.6.x kernel) and am able to get a bnep0 interface.<br>For the connection between host and target:<br>I do the following:
<br># modprobe bnep&nbsp;<br># pand --listen -r GN<br>On the target computer I do:<br># modprobe bnep<br># pand --connect &lt;BT address&gt;<br>I cannot get a bnep0 interface <br># ifconfig bnep0<br>ifconfig: bnep0: error fetching interface information: Device not found
<br><br>The hcidump on the host computer is shown below. Does anyone have any ideas?<br><br>root@Possibility:/home/krobinson# hcidump -X -V<br>HCI sniffer - Bluetooth packet analyzer ver 1.23<br>device: hci0 snap_len: 1028 filter: 0xffffffff
<br>&gt; HCI Event: Connect Request (0x04) plen 10<br>&nbsp;&nbsp;&nbsp; bdaddr 00:02:72:B0:C5:FB class 0x000000 type ACL<br>&lt; HCI Command: Accept Connection Request (0x01|0x0009) plen 7<br>&nbsp;&nbsp;&nbsp; bdaddr 00:02:72:B0:C5:FB role 0x00<br>&nbsp;&nbsp;&nbsp; Role: Master
<br>&gt; HCI Event: Command Status (0x0f) plen 4<br>&nbsp;&nbsp;&nbsp; Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1<br>&gt; HCI Event: Role Change (0x12) plen 8<br>&nbsp;&nbsp;&nbsp; status 0x00 bdaddr 00:02:72:B0:C5:FB role 0x00<br>&nbsp;&nbsp;&nbsp; Role: Master
<br>&gt; HCI Event: Connect Complete (0x03) plen 11<br>&nbsp;&nbsp;&nbsp; status 0x00 handle 42 bdaddr 00:02:72:B0:C5:FB type ACL encrypt 0x00<br>&lt; HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4<br>&nbsp;&nbsp;&nbsp; handle 42 ptype 0xcc18
<br>&nbsp;&nbsp;&nbsp; Packet type: DM1 DM3 DM5 DH1 DH3 DH5<br>&gt; HCI Event: Page Scan Repetition Mode Change (0x20) plen 7<br>&nbsp;&nbsp;&nbsp; bdaddr 00:02:72:B0:C5:FB mode 1<br>&gt; HCI Event: Command Status (0x0f) plen 4<br>&nbsp;&nbsp;&nbsp; Change Connection Packet Type (0x01|0x000f) status 0x00 ncmd 1
<br>&gt; HCI Event: Connection Packet Type Changed (0x1d) plen 5<br>&nbsp;&nbsp;&nbsp; status 0x00 handle 42 ptype 0xcc18<br>&nbsp;&nbsp;&nbsp; Packet type: DM1 DM3 DM5 DH1 DH3 DH5<br>&gt; HCI Event: Max Slots Change (0x1b) plen 3<br>&nbsp;&nbsp;&nbsp; handle 42 slots 5
<br>&gt; ACL data: handle 42 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect req: psm 15 scid 0x0040<br>&lt; ACL data: handle 42 flags 0x02 dlen 16<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connection successful
<br>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&nbsp;&nbsp;&nbsp; handle 42 packets 1<br>&gt; ACL data: handle 42 flags 0x02 dlen 16<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU 1691<br>&lt; ACL data: handle 42 flags 0x02 dlen 14
<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<br>&lt; ACL data: handle 42 flags 0x02 dlen 16<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU 1691<br>&gt; HCI Event: Number of Completed Packets (0x13) plen 5
<br>&nbsp;&nbsp;&nbsp; handle 42 packets 1<br>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&nbsp;&nbsp;&nbsp; handle 42 packets 1<br>&gt; ACL data: handle 42 flags 0x02 dlen 14<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<br><br> 

------=_Part_104557_24625940.1150814246512--


--===============0296435380==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0296435380==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0296435380==--
