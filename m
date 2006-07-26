Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <24a5055d0607260906r68603af7w891471edd176ef48@mail.gmail.com>
Date: Wed, 26 Jul 2006 21:36:53 +0530
From: "Rahul Tank" <tank.rahul@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] Bluetooth headset problem
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0565513518=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0565513518==
Content-Type: multipart/alternative;
	boundary="----=_Part_50624_26050630.1153930013846"

------=_Part_50624_26050630.1153930013846
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hello,
   I came across the bluetooth-alsa project and decided to use it on my
laptop.I have successfully used bluetooth for file transfer but am new to
headset. I downloaded and installed the "btsco-0.42"  package. I also  have
bluez-utils  and  bluez-libs  installed.

However on following the instructions, it still doesn't work
i did the following

1. modprobe snd_bt_sco
2. btsco 00:0C:55:0D:AA:12

but it gives me error as :

rahul@rahul:~/btsco-0.42$ sudo ./btsco 00:0c:55:0D:aa:12
Error: Failed to connect to SDP server: Function not implemented
Assuming channel 2

Can't connect RFCOMM channel: Host is down


Below is the output of my hcidump -XV

**> HCI Event: Connect Complete (0x03) plen 11
    status 0x22 handle 0 bdaddr 00:0C:55:0D:AA:12 type ACL encrypt 0x00
    Error: LMP Response Timeout
< HCI Command: Read Voice Setting (0x03|0x0025) plen 0
> HCI Event: Command Complete (0x0e) plen 6
    Read Voice Setting (0x03|0x0025) ncmd 1
    status 0x00 voice setting 0x0060
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:0C:55:0D:AA:12 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x04 handle 0 bdaddr 00:0C:55:0D:AA:12 type ACL encrypt 0x00
    Error: Page Timeout



Any pointers as to what am i missing ???


Regards,
 Rahul

------=_Part_50624_26050630.1153930013846
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hello,<br>&nbsp;&nbsp; I came across the bluetooth-alsa project and decided to use it on my laptop.I have successfully used bluetooth for file transfer but am new to headset. I downloaded and installed the &quot;btsco-0.42&quot;&nbsp; package. I also&nbsp; have bluez-utils&nbsp; and&nbsp; bluez-libs&nbsp; installed. 
<br><br>However on following the instructions, it still doesn't work<br>i did the following<br><br>1. modprobe snd_bt_sco<br>2. btsco 00:0C:55:0D:AA:12 <br><br>but it gives me error as :<br><br>rahul@rahul:~/btsco-0.42$ sudo ./btsco 00:0c:55:0D:aa:12
<br>Error: Failed to connect to SDP server: Function not implemented<br>Assuming channel 2<br><br>Can't connect RFCOMM channel: Host is down<br><br><br>Below is the output of my hcidump -XV<br><br><b><span class="nw" id="_user_bluez-devel@lists.sourceforge.net">
</span></b>&gt; HCI Event: Connect Complete (0x03) plen 11<br>&nbsp;&nbsp;&nbsp; status 0x22 handle 0 bdaddr 00:0C:55:0D:AA:12 type ACL encrypt 0x00<br>&nbsp;&nbsp;&nbsp; Error: LMP Response Timeout<br>&lt; HCI Command: Read Voice Setting (0x03|0x0025) plen 0
<br>&gt; HCI Event: Command Complete (0x0e) plen 6<br>&nbsp;&nbsp;&nbsp; Read Voice Setting (0x03|0x0025) ncmd 1<br>&nbsp;&nbsp;&nbsp; status 0x00 voice setting 0x0060<br>&lt; HCI Command: Create Connection (0x01|0x0005) plen 13<br>&nbsp;&nbsp;&nbsp; bdaddr 00:0C:55:0D:AA:12 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
<br>&nbsp;&nbsp;&nbsp; Packet type: DM1 DM3 DM5 DH1 DH3 DH5<br>&gt; HCI Event: Command Status (0x0f) plen 4<br>&nbsp;&nbsp;&nbsp; Create Connection (0x01|0x0005) status 0x00 ncmd 1<br>&gt; HCI Event: Connect Complete (0x03) plen 11<br>&nbsp;&nbsp;&nbsp; status 0x04 handle 0 bdaddr 00:0C:55:0D:AA:12 type ACL encrypt 0x00
<br>&nbsp;&nbsp;&nbsp; Error: Page Timeout<br><br><br><br>Any pointers as to what am i missing ???<br><br><br>Regards,<br>&nbsp;Rahul<br>

------=_Part_50624_26050630.1153930013846--


--===============0565513518==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0565513518==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0565513518==--
