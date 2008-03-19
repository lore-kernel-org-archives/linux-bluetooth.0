Return-Path: <cyrus@holtmann.org>
Message-ID: <8f5c4ad0803182345r5ff7fbc3v951ce38596436e3d@mail.gmail.com>
Date: Wed, 19 Mar 2008 12:15:17 +0530
From: Matt <chemvell@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-users] Can't connect RFCOMM socket
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1676357937=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1676357937==
Content-Type: multipart/alternative;
	boundary="----=_Part_14148_11910076.1205909117729"

------=_Part_14148_11910076.1205909117729
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

                    I am using bluez-utils-3.28 and am trying to connect to
a Nokia phone from my PC which has a BT dongle.I run hcid .I scan for other
devies using hcitool scan..and connect to my Phone using....

$hcid &
$passkey-agent --default 0000 &
$ hcitool scan
$ rfcomm connect 0 00:0E:6D:E0:E5:13 1

The Phone asks for the pin . I enter "0000" as the PIN .After sometime I get
the error message
Can't connect RFCOMM socket: Resource temporarily unavailable.

hcidump shows that (After I enter the PIN on the phone )

> HCI Event: PIN Code Request (0x16) plen 6
< ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0064 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 2 pf 1 ilen 0 fcs 0xb8
< ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0064 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0064 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 2 pf 1 ilen 0 fcs 0x92
> ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
> ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0064 scid 0x0040
< HCI Command: Disconnect (0x01|0x0006) plen 3
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Disconn Complete (0x05) plen 4

        I tried after removing the link keys
(/var/lib/bluetooth/XX:XX:XX:XX:XX:XX/) .Still I get the same error..What
could be the problem here..?
       When I try the same thing with a PC with Fedora Core5 (without the
latest bluez and passkey-agent), I am asked to enter the PIN when I enter it
on the phone and the connection is successful..

Thank you for your time and consideration,
regards,
Matt.

------=_Part_14148_11910076.1205909117729
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I am using bluez-utils-3.28 and am trying to connect to a Nokia phone from my PC which has a BT dongle.I run hcid .I scan for other devies using hcitool scan..and connect to my Phone using....<br>
<br>$hcid &amp;<br>$passkey-agent --default 0000 &amp;<br>$ hcitool scan<br>$ rfcomm connect 0 00:0E:6D:E0:E5:13 1<br><br>The Phone asks for the pin . I enter &quot;0000&quot; as the PIN .After sometime I get the error message <br>
Can&#39;t connect RFCOMM socket: Resource temporarily unavailable.<br><br>hcidump shows that (After I enter the PIN on the phone )<br><br>&gt; HCI Event: PIN Code Request (0x16) plen 6<br>&lt; ACL data: handle 1 flags 0x02 dlen 8<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0064 len 4 [psm 3]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): DISC: cr 1 dlci 2 pf 1 ilen 0 fcs 0xb8<br>&lt; ACL data: handle 1 flags 0x02 dlen 8<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0064 len 4 [psm 3]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd<br>
&lt; ACL data: handle 1 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn req: dcid 0x0064 scid 0x0040<br>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&gt; ACL data: handle 1 flags 0x02 dlen 8<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 4 [psm 3]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): UA: cr 1 dlci 2 pf 1 ilen 0 fcs 0x92<br>&gt; ACL data: handle 1 flags 0x02 dlen 8<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 4 [psm 3]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7<br>&gt; ACL data: handle 1 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn rsp: dcid 0x0064 scid 0x0040<br>&lt; HCI Command: Disconnect (0x01|0x0006) plen 3<br>
&gt; HCI Event: Command Status (0x0f) plen 4<br>&gt; HCI Event: Disconn Complete (0x05) plen 4<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I tried after removing the link keys (/var/lib/bluetooth/XX:XX:XX:XX:XX:XX/) .Still I get the same error..What could be the problem here..?<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; When I try the same thing with a PC with Fedora Core5 (without the latest bluez and passkey-agent), I am asked to enter the PIN when I enter it on the phone and the connection is successful..<br><br>Thank you for your time and consideration,<br>
regards,<br>Matt. <br><br><br>

------=_Part_14148_11910076.1205909117729--


--===============1676357937==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1676357937==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1676357937==--
