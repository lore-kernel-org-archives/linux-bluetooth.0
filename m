Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <be976db60607061016yf4cebb1mda306e5c3912b2bc@mail.gmail.com>
Date: Thu, 6 Jul 2006 10:16:37 -0700
From: "Mark S. Townsley" <mstownsley@gmail.com>
To: bluez-users <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-users] hcidump output
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0014663769=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0014663769==
Content-Type: multipart/alternative;
	boundary="----=_Part_32068_6076554.1152206197225"

------=_Part_32068_6076554.1152206197225
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear All:

When connecting to my device, I got a "Connection timeout" from sdpd.  I did
an hcidump but I have no idea how to interpret the output.
Specifically, there is a "Command Disallowed" but I don't see what the
command is.  Is there a guide online explaining how to interpret hcidump
results?

Thanks

--------------------------------------------------------
hcidump -X -V
HCI sniffer - Bluetooth packet analyzer ver 1.30
device: hci0 snap_len: 1028 filter: 0xffffffffffffffff
> HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:A0:96:0D:3B:1C class 0x000000 type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 00:A0:96:0D:3B:1C role 0x01
    Role: Slave
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:A0:96:0D:3B:1C
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 00:A0:96:0D:3B:1C key DA9C58280F96613899D9B1E7EDF75884
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 00:A0:96:0D:3B:1C
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 6 bdaddr 00:A0:96:0D:3B:1C type ACL encrypt 0x01
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 6 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 6
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
    handle 6 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Change Connection Packet Type (0x01|0x000f) status 0x0c ncmd 1
    Error: Command Disallowed
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 6 slots 5
> ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 1
> ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 48
< ACL data: handle 6 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 2
> ACL data: handle 6 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 6 flags 0x02 dlen 17
> ACL data: handle 6 flags 0x01 dlen 2
    L2CAP(d): cid 0x0040 len 15 [psm 1]
        SDP SS Req: tid 0x1 len 0xa
          pat uuid-32 0x1101 (SP)
          max 40
          cont 00
< ACL data: handle 6 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 1]
        SDP SS Rsp: tid 0x1 len 0x5
          count 0
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 6 reason 0x08
    Reason: Connection Timeout
> HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:A0:96:0D:3B:1C class 0x000000 type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 00:A0:96:0D:3B:1C role 0x01
    Role: Slave
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:A0:96:0D:3B:1C
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 00:A0:96:0D:3B:1C key DA9C58280F96613899D9B1E7EDF75884
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 00:A0:96:0D:3B:1C
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 6 bdaddr 00:A0:96:0D:3B:1C type ACL encrypt 0x01
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 6 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 6
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
    handle 6 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Change Connection Packet Type (0x01|0x000f) status 0x0c ncmd 1
    Error: Command Disallowed
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 6 slots 5
> ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 1
> ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 48
< ACL data: handle 6 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 1
> ACL data: handle 6 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 6 flags 0x02 dlen 17
> ACL data: handle 6 flags 0x01 dlen 2
    L2CAP(d): cid 0x0040 len 15 [psm 1]
        SDP SS Req: tid 0x1 len 0xa
          pat uuid-32 0x1101 (SP)
          max 40
          cont 00
< ACL data: handle 6 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 1]
        SDP SS Rsp: tid 0x1 len 0x5
          count 0
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6 packets 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 6 reason 0x08
    Reason: Connection Timeout
^

------=_Part_32068_6076554.1152206197225
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear All:<br>
<br>
When connecting to my device, I got a &quot;Connection timeout&quot; from
sdpd.&nbsp; I did an hcidump but I have no idea how to interpret the
output.<br>
Specifically, there is a &quot;Command Disallowed&quot; but I don't see what the
command is.&nbsp; Is there a guide online explaining how to interpret
hcidump <br>
results?<br>
<br>
Thanks<br>
<br>
--------------------------------------------------------<br>
hcidump -X -V<br>
HCI sniffer - Bluetooth packet analyzer ver 1.30<br>
device: hci0 snap_len: 1028 filter: 0xffffffffffffffff<br>
&gt; HCI Event: Connect Request (0x04) plen 10<br>
&nbsp;&nbsp;&nbsp; bdaddr 00:A0:96:0D:3B:1C class 0x000000 type ACL<br>
&lt; HCI Command: Accept Connection Request (0x01|0x0009) plen 7<br>
&nbsp;&nbsp;&nbsp; bdaddr 00:A0:96:0D:3B:1C role 0x01<br>
&nbsp;&nbsp;&nbsp; Role: Slave<br>
&gt; HCI Event: Command Status (0x0f) plen 4<br>
&nbsp;&nbsp;&nbsp; Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1<br>
&gt; HCI Event: Link Key Request (0x17) plen 6<br>
&nbsp;&nbsp;&nbsp; bdaddr 00:A0:96:0D:3B:1C<br>
&lt; HCI Command: Link Key Request Reply (0x01|0x000b) plen 22<br>
&nbsp;&nbsp;&nbsp; bdaddr 00:A0:96:0D:3B:1C key DA9C58280F96613899D9B1E7EDF75884<br>
&gt; HCI Event: Command Complete (0x0e) plen 10<br>
&nbsp;&nbsp;&nbsp; Link Key Request Reply (0x01|0x000b) ncmd 1<br>
&nbsp;&nbsp;&nbsp; status 0x00 bdaddr 00:A0:96:0D:3B:1C<br>
&gt; HCI Event: Connect Complete (0x03) plen 11<br>
&nbsp;&nbsp;&nbsp; status 0x00 handle 6 bdaddr 00:A0:96:0D:3B:1C type ACL encrypt 0x01<br>
&lt; HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4<br>
&nbsp;&nbsp;&nbsp; handle 6 policy 0x0f<br>
&nbsp;&nbsp;&nbsp; Link policy: RSWITCH HOLD SNIFF PARK<br>
&gt; HCI Event: Command Complete (0x0e) plen 6<br>
&nbsp;&nbsp;&nbsp; Write Link Policy Settings (0x02|0x000d) ncmd 1<br>
&nbsp;&nbsp;&nbsp; status 0x00 handle 6<br>
&lt; HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4<br>
&nbsp;&nbsp;&nbsp; handle 6 ptype 0xcc18<br>
&nbsp;&nbsp;&nbsp; Packet type: DM1 DM3 DM5 DH1 DH3 DH5<br>
&gt; HCI Event: Command Status (0x0f) plen 4<br>
&nbsp;&nbsp;&nbsp; Change Connection Packet Type (0x01|0x000f) status 0x0c ncmd 1<br>
&nbsp;&nbsp;&nbsp; Error: Command Disallowed<br>
&gt; HCI Event: Max Slots Change (0x1b) plen 3<br>
&nbsp;&nbsp;&nbsp; handle 6 slots 5<br>
&gt; ACL data: handle 6 flags 0x02 dlen 12<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Connect req: psm 1 scid 0x0040<br>
&lt; ACL data: handle 6 flags 0x02 dlen 16<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connection successful<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&nbsp;&nbsp;&nbsp; handle 6 packets 1<br>
&gt; ACL data: handle 6 flags 0x02 dlen 16<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU 48<br>
&lt; ACL data: handle 6 flags 0x02 dlen 14<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<br>
&lt; ACL data: handle 6 flags 0x02 dlen 12<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&nbsp;&nbsp;&nbsp; handle 6 packets 2<br>
&gt; ACL data: handle 6 flags 0x02 dlen 14<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<br>
&gt; ACL data: handle 6 flags 0x02 dlen 17<br>
&gt; ACL data: handle 6 flags 0x01 dlen 2<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 15 [psm 1]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SS Req: tid 0x1 len 0xa<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pat uuid-32 0x1101 (SP)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max 40<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont 00<br>
&lt; ACL data: handle 6 flags 0x02 dlen 14<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 10 [psm 1]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SS Rsp: tid 0x1 len 0x5<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count 0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont 00<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&nbsp;&nbsp;&nbsp; handle 6 packets 1<br>
&gt; HCI Event: Disconn Complete (0x05) plen 4<br>
&nbsp;&nbsp;&nbsp; status 0x00 handle 6 reason 0x08<br>
&nbsp;&nbsp;&nbsp; Reason: Connection Timeout<br>
&gt; HCI Event: Connect Request (0x04) plen 10<br>
&nbsp;&nbsp;&nbsp; bdaddr 00:A0:96:0D:3B:1C class 0x000000 type ACL<br>
&lt; HCI Command: Accept Connection Request (0x01|0x0009) plen 7<br>
&nbsp;&nbsp;&nbsp; bdaddr 00:A0:96:0D:3B:1C role 0x01<br>
&nbsp;&nbsp;&nbsp; Role: Slave<br>
&gt; HCI Event: Command Status (0x0f) plen 4<br>
&nbsp;&nbsp;&nbsp; Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1<br>
&gt; HCI Event: Link Key Request (0x17) plen 6<br>
&nbsp;&nbsp;&nbsp; bdaddr 00:A0:96:0D:3B:1C<br>
&lt; HCI Command: Link Key Request Reply (0x01|0x000b) plen 22<br>
&nbsp;&nbsp;&nbsp; bdaddr 00:A0:96:0D:3B:1C key DA9C58280F96613899D9B1E7EDF75884<br>
&gt; HCI Event: Command Complete (0x0e) plen 10<br>
&nbsp;&nbsp;&nbsp; Link Key Request Reply (0x01|0x000b) ncmd 1<br>
&nbsp;&nbsp;&nbsp; status 0x00 bdaddr 00:A0:96:0D:3B:1C<br>
&gt; HCI Event: Connect Complete (0x03) plen 11<br>
&nbsp;&nbsp;&nbsp; status 0x00 handle 6 bdaddr 00:A0:96:0D:3B:1C type ACL encrypt 0x01<br>
&lt; HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4<br>
&nbsp;&nbsp;&nbsp; handle 6 policy 0x0f<br>
&nbsp;&nbsp;&nbsp; Link policy: RSWITCH HOLD SNIFF PARK<br>
&gt; HCI Event: Command Complete (0x0e) plen 6<br>
&nbsp;&nbsp;&nbsp; Write Link Policy Settings (0x02|0x000d) ncmd 1<br>
&nbsp;&nbsp;&nbsp; status 0x00 handle 6<br>
&lt; HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4<br>
&nbsp;&nbsp;&nbsp; handle 6 ptype 0xcc18<br>
&nbsp;&nbsp;&nbsp; Packet type: DM1 DM3 DM5 DH1 DH3 DH5<br>
&gt; HCI Event: Command Status (0x0f) plen 4<br>
&nbsp;&nbsp;&nbsp; Change Connection Packet Type (0x01|0x000f) status 0x0c ncmd 1<br>
&nbsp;&nbsp;&nbsp; Error: Command Disallowed<br>
&gt; HCI Event: Max Slots Change (0x1b) plen 3<br>
&nbsp;&nbsp;&nbsp; handle 6 slots 5<br>
&gt; ACL data: handle 6 flags 0x02 dlen 12<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Connect req: psm 1 scid 0x0040<br>
&lt; ACL data: handle 6 flags 0x02 dlen 16<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connection successful<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&nbsp;&nbsp;&nbsp; handle 6 packets 1<br>
&gt; ACL data: handle 6 flags 0x02 dlen 16<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU 48<br>
&lt; ACL data: handle 6 flags 0x02 dlen 14<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<br>
&lt; ACL data: handle 6 flags 0x02 dlen 12<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&nbsp;&nbsp;&nbsp; handle 6 packets 1<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&nbsp;&nbsp;&nbsp; handle 6 packets 1<br>
&gt; ACL data: handle 6 flags 0x02 dlen 14<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<br>
&gt; ACL data: handle 6 flags 0x02 dlen 17<br>
&gt; ACL data: handle 6 flags 0x01 dlen 2<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 15 [psm 1]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SS Req: tid 0x1 len 0xa<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pat uuid-32 0x1101 (SP)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max 40<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont 00<br>
&lt; ACL data: handle 6 flags 0x02 dlen 14<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 10 [psm 1]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SS Rsp: tid 0x1 len 0x5<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count 0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont 00<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&nbsp;&nbsp;&nbsp; handle 6 packets 1<br>
&gt; HCI Event: Disconn Complete (0x05) plen 4<br>
&nbsp;&nbsp;&nbsp; status 0x00 handle 6 reason 0x08<br>
&nbsp;&nbsp;&nbsp; Reason: Connection Timeout<br>
^<br>
<br>

------=_Part_32068_6076554.1152206197225--


--===============0014663769==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0014663769==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0014663769==--
