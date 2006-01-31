Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <19c2b3920601310536l77bdc32ay@mail.gmail.com>
From: rangzen <lipare@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] [micro-howto] Ericsson K700i as hid device (hidd options)
In-Reply-To: <pan.2006.01.30.19.35.06.850476@wikidev.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_3493_11274754.1138714576872"
References: <pan.2006.01.30.19.35.06.850476@wikidev.net>
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
Date: Tue, 31 Jan 2006 14:36:16 +0100

------=_Part_3493_11274754.1138714576872
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Still doesn't work for me with a K750i :/

rm all in /var/lib/bluetooth/
no device in the phone

# /usr/local/sbin/hcidump -X -V
HCI sniffer - Bluetooth packet analyzer ver 1.29
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:16:20:2E:4F:08 class 0x520204 type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 00:16:20:2E:4F:08 role 0x00
    Role: Master
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> HCI Event: Role Change (0x12) plen 8
    status 0x00 bdaddr 00:16:20:2E:4F:08 role 0x00
    Role: Master
> HCI Event: PIN Code Request (0x16) plen 6
    bdaddr 00:16:20:2E:4F:08
< HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
    bdaddr 00:16:20:2E:4F:08 len 4 pin '1010'
> HCI Event: Command Complete (0x0e) plen 10
    PIN Code Request Reply (0x01|0x000d) ncmd 1
    status 0x00 bdaddr 00:16:20:2E:4F:08
> HCI Event: Link Key Notification (0x18) plen 23
    bdaddr 00:16:20:2E:4F:08 key 7D2DBC19D998316AE9DB5D9645707E08 type 0
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 42 bdaddr 00:16:20:2E:4F:08 type ACL encrypt 0x01
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 42 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
    bdaddr 00:16:20:2E:4F:08 mode 1
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 42
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
    handle 42 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Change Connection Packet Type (0x01|0x000f) status 0x00 ncmd 1
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
    status 0x00 handle 42 ptype 0xff1e
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 2-DH1 2-DH3 2-DH5 3-DH1 3-DH3 3-DH=
5
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 42 slots 5
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 17 scid 0x0040
< ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 36
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 24
      QoS 0x01 (Best effort)
< ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 48
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 19 scid 0x0041
< ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 36
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 24
      QoS 0x02 (Guaranteed)
< ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
      MTU 48
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 42 flags 0x02 dlen 5
    L2CAP(d): cid 0x0040 len 1 [psm 17]
      HIDP: Set protocol: Boot protocol
< ACL data: handle 42 flags 0x02 dlen 7
    L2CAP(d): cid 0x0041 len 3 [psm 19]
      HIDP: Data: Output report
      0000: 01 00                                             ..
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 5
    L2CAP(d): cid 0x0040 len 1 [psm 17]
      HIDP: Handshake: Successful
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 19]
      HIDP: Data: Input report
      0000: 02 00 f6 00                                       ....
> ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 19]
      HIDP: Data: Input report
      0000: 02 00 f6 00                                       ....
> ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 19]
      HIDP: Data: Input report
      0000: 02 00 f6 00                                       ....
> ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 19]
      HIDP: Data: Input report
      0000: 02 00 00 00                                       ....
> ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 19]
      HIDP: Data: Input report
      0000: 02 00 0a 00                                       ....
> ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 19]
      HIDP: Data: Input report
      0000: 02 00 0a 00                                       ....
> ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 19]
      HIDP: Data: Input report
      0000: 02 00 0a 00                                       ....
> ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 19]
      HIDP: Data: Input report
      0000: 02 00 00 00                                       ....
> ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 19]
      HIDP: Data: Input report
      0000: 02 00 00 00                                       ....
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 19]
      HIDP: Data: Input report
      0000: 01 00 00 00 00 00 00 00  00                       .........
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0041 scid 0x0041
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 42 reason 0x13
    Reason: Remote User Terminated Connection

All works fine :)

But now the device is registred in the phone and the "local" device is in
/var/lib/bluetooth
I try again and :

# /usr/local/sbin/hcidump -X -V
HCI sniffer - Bluetooth packet analyzer ver 1.29
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:16:20:2E:4F:08 class 0x520204 type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 00:16:20:2E:4F:08 role 0x00
    Role: Master
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> HCI Event: Role Change (0x12) plen 8
    status 0x00 bdaddr 00:16:20:2E:4F:08 role 0x00
    Role: Master
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:16:20:2E:4F:08
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 00:16:20:2E:4F:08 key 7D2DBC19D998316AE9DB5D9645707E08
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 00:16:20:2E:4F:08
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 42 bdaddr 00:16:20:2E:4F:08 type ACL encrypt 0x01
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 42 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
    bdaddr 00:16:20:2E:4F:08 mode 1
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 42
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
    handle 42 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Change Connection Packet Type (0x01|0x000f) status 0x00 ncmd 1
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
    status 0x00 handle 42 ptype 0xff1e
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 2-DH1 2-DH3 2-DH5 3-DH1 3-DH3 3-DH=
5
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 42 slots 5
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 42 reason 0x13
    Reason: Remote User Terminated Connection

:/
The phone display "Connection failed"

Any idea ?

2006/1/30, Gabriel Wicke <lists@wikidev.net>:
>
> Hi,
>
> I just got my Ericsson k700i to work with hidd 2.24 (Ubuntu Dapper) and
> would like to share what i needed to do:
>
> If you never paired the phone with your computer before:
> * edit /etc/bluetooth/pin, remember the number
> If you did pair it before, but it's failing now (was the case after a
> firmware upgrade in my case), remove the old pairing information in
> /var/lib/bluetooth/<deviveId>
>
> * edit /etc/default/bluez-utils
> ------------
> HIDD_ENABLED=3D1
>
> # -D (nosdp) special hack for k700i (and similar Ericsson phones afaik)
> # -Z (nocheck) also needed in the setup procedure
> HIDD_OPTIONS=3D"--master --server -D -Z"
> ------------
> * sudo /etc/init.d/bluez-utils restart
>
> Now you should be able to connect from your phone's remote control menu-
> enjoy!
>
> Thanks to everybody who made this possible!
> --
> Gabriel Wicke
>
>
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log
> files
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D103432&bid=3D230486&dat=
=3D121642
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>



--
libert=E9 - partage - respect
freedom - share - respect

------=_Part_3493_11274754.1138714576872
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Still doesn't work for me with a K750i :/<br>
<br>
rm all in /var/lib/bluetooth/<br>
no device in the phone<br>
<br>
# /usr/local/sbin/hcidump -X -V<br>
HCI sniffer - Bluetooth packet analyzer ver 1.29<br>
device: hci0 snap_len: 1028 filter: 0xffffffff<br>
&gt; HCI Event: Connect Request (0x04) plen 10<br>
&nbsp;&nbsp;&nbsp; bdaddr 00:16:20:2E:4F:08 class 0x520204 type ACL<br>
&lt; HCI Command: Accept Connection Request (0x01|0x0009) plen 7<br>
&nbsp;&nbsp;&nbsp; bdaddr 00:16:20:2E:4F:08 role 0x00<br>
&nbsp;&nbsp;&nbsp; Role: Master<br>
&gt; HCI Event: Command Status (0x0f) plen 4<br>
&nbsp;&nbsp;&nbsp; Accept Connection Request (0x01|0x0009) status 0x00 ncmd=
 1<br>
&gt; HCI Event: Role Change (0x12) plen 8<br>
&nbsp;&nbsp;&nbsp; status 0x00 bdaddr 00:16:20:2E:4F:08 role 0x00<br>
&nbsp;&nbsp;&nbsp; Role: Master<br>
&gt; HCI Event: PIN Code Request (0x16) plen 6<br>
&nbsp;&nbsp;&nbsp; bdaddr 00:16:20:2E:4F:08<br>
&lt; HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23<br>
&nbsp;&nbsp;&nbsp; bdaddr 00:16:20:2E:4F:08 len 4 pin '1010'<br>
&gt; HCI Event: Command Complete (0x0e) plen 10<br>
&nbsp;&nbsp;&nbsp; PIN Code Request Reply (0x01|0x000d) ncmd 1<br>
&nbsp;&nbsp;&nbsp; status 0x00 bdaddr 00:16:20:2E:4F:08<br>
&gt; HCI Event: Link Key Notification (0x18) plen 23<br>
&nbsp;&nbsp;&nbsp; bdaddr 00:16:20:2E:4F:08 key 7D2DBC19D998316AE9DB5D96457=
07E08 type 0<br>
&gt; HCI Event: Connect Complete (0x03) plen 11<br>
&nbsp;&nbsp;&nbsp; status 0x00 handle 42 bdaddr 00:16:20:2E:4F:08 type ACL =
encrypt 0x01<br>
&lt; HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4<br>
&nbsp;&nbsp;&nbsp; handle 42 policy 0x0f<br>
&nbsp;&nbsp;&nbsp; Link policy: RSWITCH HOLD SNIFF PARK<br>
&gt; HCI Event: Page Scan Repetition Mode Change (0x20) plen 7<br>
&nbsp;&nbsp;&nbsp; bdaddr 00:16:20:2E:4F:08 mode 1<br>
&gt; HCI Event: Command Complete (0x0e) plen 6<br>
&nbsp;&nbsp;&nbsp; Write Link Policy Settings (0x02|0x000d) ncmd 1<br>
&nbsp;&nbsp;&nbsp; status 0x00 handle 42<br>
&lt; HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4<br>
&nbsp;&nbsp;&nbsp; handle 42 ptype 0xcc18<br>
&nbsp;&nbsp;&nbsp; Packet type: DM1 DM3 DM5 DH1 DH3 DH5<br>
&gt; HCI Event: Command Status (0x0f) plen 4<br>
&nbsp;&nbsp;&nbsp; Change Connection Packet Type (0x01|0x000f) status 0x00 =
ncmd 1<br>
&gt; HCI Event: Connection Packet Type Changed (0x1d) plen 5<br>
&nbsp;&nbsp;&nbsp; status 0x00 handle 42 ptype 0xff1e<br>
&nbsp;&nbsp;&nbsp; Packet type: DM1 DM3 DM5 DH1 DH3 DH5 2-DH1 2-DH3 2-DH5 3=
-DH1 3-DH3 3-DH5<br>
&gt; HCI Event: Max Slots Change (0x1b) plen 3<br>
&nbsp;&nbsp;&nbsp; handle 42 slots 5<br>
&gt; ACL data: handle 42 flags 0x02 dlen 12<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Connect req: psm 17 scid 0x0040<br>
&lt; ACL data: handle 42 flags 0x02 dlen 16<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 =
status 0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connection successful<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&nbsp;&nbsp;&nbsp; handle 42 packets 1<br>
&gt; ACL data: handle 42 flags 0x02 dlen 36<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 24<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; QoS 0x01 (Best effort)<br>
&lt; ACL data: handle 42 flags 0x02 dlen 14<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 cl=
en 0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<br>
&lt; ACL data: handle 42 flags 0x02 dlen 16<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU 48<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&nbsp;&nbsp;&nbsp; handle 42 packets 1<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&nbsp;&nbsp;&nbsp; handle 42 packets 1<br>
&gt; ACL data: handle 42 flags 0x02 dlen 14<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 cl=
en 0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<br>
&gt; ACL data: handle 42 flags 0x02 dlen 12<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Connect req: psm 19 scid 0x0041<br>
&lt; ACL data: handle 42 flags 0x02 dlen 16<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 0 =
status 0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connection successful<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&nbsp;&nbsp;&nbsp; handle 42 packets 1<br>
&gt; ACL data: handle 42 flags 0x02 dlen 36<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 24<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; QoS 0x02 (Guaranteed)<br>
&lt; ACL data: handle 42 flags 0x02 dlen 14<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 cl=
en 0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<br>
&lt; ACL data: handle 42 flags 0x02 dlen 16<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU 48<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&nbsp;&nbsp;&nbsp; handle 42 packets 1<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&nbsp;&nbsp;&nbsp; handle 42 packets 1<br>
&gt; ACL data: handle 42 flags 0x02 dlen 14<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 cl=
en 0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<br>
&lt; ACL data: handle 42 flags 0x02 dlen 5<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 1 [psm 17]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HIDP: Set protocol: Boot protocol<br>
&lt; ACL data: handle 42 flags 0x02 dlen 7<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 3 [psm 19]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HIDP: Data: Output report<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0000: 01
00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
..<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&nbsp;&nbsp;&nbsp; handle 42 packets 1<br>
&gt; ACL data: handle 42 flags 0x02 dlen 5<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 1 [psm 17]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HIDP: Handshake: Successful<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&nbsp;&nbsp;&nbsp; handle 42 packets 1<br>
&gt; ACL data: handle 42 flags 0x02 dlen 9<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 5 [psm 19]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HIDP: Data: Input report<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0000: 02 00 f6
00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;
....<br>
&gt; ACL data: handle 42 flags 0x02 dlen 9<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 5 [psm 19]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HIDP: Data: Input report<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0000: 02 00 f6
00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;
....<br>
&gt; ACL data: handle 42 flags 0x02 dlen 9<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 5 [psm 19]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HIDP: Data: Input report<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0000: 02 00 f6
00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;
....<br>
&gt; ACL data: handle 42 flags 0x02 dlen 9<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 5 [psm 19]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HIDP: Data: Input report<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0000: 02 00 00
00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;
....<br>
&gt; ACL data: handle 42 flags 0x02 dlen 9<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 5 [psm 19]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HIDP: Data: Input report<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0000: 02 00 0a
00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;
....<br>
&gt; ACL data: handle 42 flags 0x02 dlen 9<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 5 [psm 19]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HIDP: Data: Input report<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0000: 02 00 0a
00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;
....<br>
&gt; ACL data: handle 42 flags 0x02 dlen 9<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 5 [psm 19]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HIDP: Data: Input report<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0000: 02 00 0a
00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;
....<br>
&gt; ACL data: handle 42 flags 0x02 dlen 9<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 5 [psm 19]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HIDP: Data: Input report<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0000: 02 00 00
00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;
....<br>
&gt; ACL data: handle 42 flags 0x02 dlen 9<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 5 [psm 19]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HIDP: Data: Input report<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0000: 02 00 00
00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;
....<br>
&gt; ACL data: handle 42 flags 0x02 dlen 14<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 10 [psm 19]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HIDP: Data: Input report<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0000: 01 00 00 00 00 00 00 00&nbsp;
00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
.........<br>
&gt; ACL data: handle 42 flags 0x02 dlen 12<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn req: dcid 0x0041 scid 0x0041<br>
&lt; ACL data: handle 42 flags 0x02 dlen 12<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0041<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&nbsp;&nbsp;&nbsp; handle 42 packets 1<br>
&gt; ACL data: handle 42 flags 0x02 dlen 12<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040<br>
&lt; ACL data: handle 42 flags 0x02 dlen 12<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&nbsp;&nbsp;&nbsp; handle 42 packets 1<br>
&gt; HCI Event: Disconn Complete (0x05) plen 4<br>
&nbsp;&nbsp;&nbsp; status 0x00 handle 42 reason 0x13<br>
&nbsp;&nbsp;&nbsp; Reason: Remote User Terminated Connection<br>
<br>
All works fine :)<br>
<br>
But now the device is registred in the phone and the &quot;local&quot; devi=
ce is in /var/lib/bluetooth<br>
I try again and :<br>
<br>
# /usr/local/sbin/hcidump -X -V<br>
HCI sniffer - Bluetooth packet analyzer ver 1.29<br>
device: hci0 snap_len: 1028 filter: 0xffffffff<br>
&gt; HCI Event: Connect Request (0x04) plen 10<br>
&nbsp;&nbsp;&nbsp; bdaddr 00:16:20:2E:4F:08 class 0x520204 type ACL<br>
&lt; HCI Command: Accept Connection Request (0x01|0x0009) plen 7<br>
&nbsp;&nbsp;&nbsp; bdaddr 00:16:20:2E:4F:08 role 0x00<br>
&nbsp;&nbsp;&nbsp; Role: Master<br>
&gt; HCI Event: Command Status (0x0f) plen 4<br>
&nbsp;&nbsp;&nbsp; Accept Connection Request (0x01|0x0009) status 0x00 ncmd=
 1<br>
&gt; HCI Event: Role Change (0x12) plen 8<br>
&nbsp;&nbsp;&nbsp; status 0x00 bdaddr 00:16:20:2E:4F:08 role 0x00<br>
&nbsp;&nbsp;&nbsp; Role: Master<br>
&gt; HCI Event: Link Key Request (0x17) plen 6<br>
&nbsp;&nbsp;&nbsp; bdaddr 00:16:20:2E:4F:08<br>
&lt; HCI Command: Link Key Request Reply (0x01|0x000b) plen 22<br>
&nbsp;&nbsp;&nbsp; bdaddr 00:16:20:2E:4F:08 key 7D2DBC19D998316AE9DB5D96457=
07E08<br>
&gt; HCI Event: Command Complete (0x0e) plen 10<br>
&nbsp;&nbsp;&nbsp; Link Key Request Reply (0x01|0x000b) ncmd 1<br>
&nbsp;&nbsp;&nbsp; status 0x00 bdaddr 00:16:20:2E:4F:08<br>
&gt; HCI Event: Connect Complete (0x03) plen 11<br>
&nbsp;&nbsp;&nbsp; status 0x00 handle 42 bdaddr 00:16:20:2E:4F:08 type ACL =
encrypt 0x01<br>
&lt; HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4<br>
&nbsp;&nbsp;&nbsp; handle 42 policy 0x0f<br>
&nbsp;&nbsp;&nbsp; Link policy: RSWITCH HOLD SNIFF PARK<br>
&gt; HCI Event: Page Scan Repetition Mode Change (0x20) plen 7<br>
&nbsp;&nbsp;&nbsp; bdaddr 00:16:20:2E:4F:08 mode 1<br>
&gt; HCI Event: Command Complete (0x0e) plen 6<br>
&nbsp;&nbsp;&nbsp; Write Link Policy Settings (0x02|0x000d) ncmd 1<br>
&nbsp;&nbsp;&nbsp; status 0x00 handle 42<br>
&lt; HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4<br>
&nbsp;&nbsp;&nbsp; handle 42 ptype 0xcc18<br>
&nbsp;&nbsp;&nbsp; Packet type: DM1 DM3 DM5 DH1 DH3 DH5<br>
&gt; HCI Event: Command Status (0x0f) plen 4<br>
&nbsp;&nbsp;&nbsp; Change Connection Packet Type (0x01|0x000f) status 0x00 =
ncmd 1<br>
&gt; HCI Event: Connection Packet Type Changed (0x1d) plen 5<br>
&nbsp;&nbsp;&nbsp; status 0x00 handle 42 ptype 0xff1e<br>
&nbsp;&nbsp;&nbsp; Packet type: DM1 DM3 DM5 DH1 DH3 DH5 2-DH1 2-DH3 2-DH5 3=
-DH1 3-DH3 3-DH5<br>
&gt; HCI Event: Max Slots Change (0x1b) plen 3<br>
&nbsp;&nbsp;&nbsp; handle 42 slots 5<br>
&gt; HCI Event: Disconn Complete (0x05) plen 4<br>
&nbsp;&nbsp;&nbsp; status 0x00 handle 42 reason 0x13<br>
&nbsp;&nbsp;&nbsp; Reason: Remote User Terminated Connection<br>
<br>
:/<br>
The phone display &quot;Connection failed&quot;<br><br>
Any idea ?<br>
<br><div><span class=3D"gmail_quote">2006/1/30, Gabriel Wicke &lt;<a href=
=3D"mailto:lists@wikidev.net" target=3D"_blank" onclick=3D"return top.js.Op=
enExtLink(window,event,this)">lists@wikidev.net</a>&gt;:</span><blockquote =
class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); m=
argin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">

Hi,<br><br>I just got my Ericsson k700i to work with hidd 2.24 (Ubuntu Dapp=
er) and<br>would like to share what i needed to do:<br><br>If you never pai=
red the phone with your computer before:<br>* edit /etc/bluetooth/pin, reme=
mber the number
<br>If you did pair it before, but it's failing now (was the case after a<b=
r>firmware upgrade in my case), remove the old pairing information in<br>/v=
ar/lib/bluetooth/&lt;deviveId&gt;<br><br>* edit /etc/default/bluez-utils
<br>------------<br>HIDD_ENABLED=3D1<br><br># -D (nosdp) special hack for k=
700i (and similar Ericsson phones afaik)<br># -Z (nocheck) also needed in t=
he setup procedure<br>HIDD_OPTIONS=3D&quot;--master --server -D -Z&quot;<br=
>

------------<br>* sudo /etc/init.d/bluez-utils restart<br><br>Now you shoul=
d be able to connect from your phone's remote control menu-<br>enjoy!<br><b=
r>Thanks to everybody who made this possible!<br>--<br>Gabriel Wicke<br>

<br><br><br><br>-------------------------------------------------------<br>=
This SF.net email is sponsored by: Splunk Inc. Do you grep through log file=
s<br>for problems?&nbsp;&nbsp;Stop!&nbsp;&nbsp;Download the new AJAX search=
 engine that makes
<br>searching your log files as easy as surfing the&nbsp;&nbsp;web.&nbsp;&n=
bsp;DOWNLOAD SPLUNK!<br><a href=3D"http://sel.as-us.falkag.net/sel?cmd=3Dln=
k&amp;kid=3D103432&amp;bid=3D230486&amp;dat=3D121642" target=3D"_blank" onc=
lick=3D"return top.js.OpenExtLink(window,event,this)">
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&amp;kid=3D103432&amp;bid=3D230486=
&amp;dat=3D121642
</a><br>_______________________________________________<br>Bluez-users mail=
ing list<br><a href=3D"mailto:Bluez-users@lists.sourceforge.net" target=3D"=
_blank" onclick=3D"return top.js.OpenExtLink(window,event,this)">Bluez-user=
s@lists.sourceforge.net
</a><br><a href=3D"https://lists.sourceforge.net/lists/listinfo/bluez-users=
" target=3D"_blank" onclick=3D"return top.js.OpenExtLink(window,event,this)=
">
https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br></blockquot=
e></div><br><br clear=3D"all"><br>-- <br>libert=E9 - partage - respect<br>f=
reedom - share - respect


------=_Part_3493_11274754.1138714576872--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
