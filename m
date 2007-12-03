Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <e378cfb20712022232yff12800gd8a6ae68dffbb530@mail.gmail.com>
Date: Mon, 3 Dec 2007 12:02:21 +0530
From: "Nel D" <newatlinux@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] Support for multicasting in bluetooth
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1426905446=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1426905446==
Content-Type: multipart/alternative;
	boundary="----=_Part_11253_31103874.1196663541804"

------=_Part_11253_31103874.1196663541804
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hello,
  I want to write a small app wherein am able to broadcast a message to a
piconet. However to start of with, i found that bluetooth version
1.2doesn't have mutlicast support[1].

However a little of googling and i found that bluetooth version2.0 supports
multicasting :) [2]

So now here's a question [might be stupid for some but am stuck :( ]. How do
i find out whether a given bluetooth adapter adheres to version 2.0 ? .

hciconfig -a on current adapter shows the following output.

hci0:   Type: USB
        BD Address: 00:11:67:12:04:18 ACL MTU: 678:8 SCO MTU: 48:10
        UP RUNNING PSCAN
        RX bytes:420 acl:0 sco:0 events:19 errors:0
        TX bytes:323 acl:0 sco:0 commands:19 errors:0
        Features: 0xbf 0xfe 0x8d 0x78 0x08 0x18 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'BlueZ (0)'
        Class: 0x100100
        Service Classes: Unspecified
        Device Class: Computer, Uncategorized
        HCI Ver: 1.2 (0x2) HCI Rev: 0x1f4 LMP Ver: 1.2 (0x2) LMP Subver:
0x1f4
        Manufacturer: Integrated System Solution Corp. (57)


Is the HCI Ver. the one i should look out for ?
Any help on this would be greatly appreciated.


[1]
http://www.bluetooth.com/Bluetooth/Learn/Works/Data_Transport_Architecture.htm
[2] http://www.funsms.net/what_is_bluetooth.htm



Thanks ,
  nel

------=_Part_11253_31103874.1196663541804
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hello,<br>&nbsp; I want to write a small app wherein am able to broadcast a message to a piconet. However to start of with, i found that bluetooth version 1.2 doesn&#39;t have mutlicast support[1]. <br><br>However a little of googling and i found that bluetooth 
version2.0 supports multicasting :) [2]<br><br>So now here&#39;s a question [might be stupid for some but am stuck :( ]. How do i find out whether a given bluetooth adapter adheres to version 2.0 ? . <br><br>hciconfig -a on current adapter shows the following output.
<br><br>hci0:&nbsp;&nbsp; Type: USB<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:11:67:12:04:18 ACL MTU: 678:8 SCO MTU: 48:10<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP RUNNING PSCAN<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:420 acl:0 sco:0 events:19 errors:0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:323 acl:0 sco:0 commands:19 errors:0
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features: 0xbf 0xfe 0x8d 0x78 0x08 0x18 0x00 0x00<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link policy: RSWITCH HOLD SNIFF PARK<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link mode: SLAVE ACCEPT<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Name: &#39;BlueZ (0)&#39;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Class: 0x100100<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Service Classes: Unspecified<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Device Class: Computer, Uncategorized<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HCI Ver: 1.2 (0x2) HCI Rev: 0x1f4 LMP Ver: 1.2 (0x2) LMP Subver: 0x1f4<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufacturer: Integrated System Solution Corp. (57)
<br><br><br>Is the HCI Ver. the one i should look out for ? <br>Any help on this would be greatly appreciated. <br><br><br>[1] <a href="http://www.bluetooth.com/Bluetooth/Learn/Works/Data_Transport_Architecture.htm">http://www.bluetooth.com/Bluetooth/Learn/Works/Data_Transport_Architecture.htm
</a><br>[2] <a href="http://www.funsms.net/what_is_bluetooth.htm">http://www.funsms.net/what_is_bluetooth.htm</a><br><br><br><br>Thanks ,<br>&nbsp; nel<br>&nbsp; <br>

------=_Part_11253_31103874.1196663541804--


--===============1426905446==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
--===============1426905446==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1426905446==--
