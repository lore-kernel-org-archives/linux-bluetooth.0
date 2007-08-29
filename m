Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <c669a7c70708290023ia617125rda5bc9e7547fe9f6@mail.gmail.com>
Date: Wed, 29 Aug 2007 12:53:19 +0530
From: "Mahin Gupta" <mahingupta@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] hcidump output problem
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1796603956=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1796603956==
Content-Type: multipart/alternative;
	boundary="----=_Part_396_12142433.1188372199380"

------=_Part_396_12142433.1188372199380
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi All,
I am using bluez-libs 3.14, bluez-utils 3.14, hcidump 1.40 ..
when I am using hcidump -V -X I am continuously getting following output..

> SCO data: handle 92 flags 0x00 dlen 48
    0000: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
    0010: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
    0020: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
 It gives nothing else ...


 below is output of my hciconfig hci0 -a
 [root@vmware-fc6 bluez-hcidump-1.40]# hciconfig hci0 -a
hci0:   Type: USB
        BD Address: 11:11:11:11:11:11 ACL MTU: 672:3 SCO MTU: 48:1
        UP RUNNING PSCAN ISCAN
        RX bytes:387498 acl:0 sco:7357 events:9 errors:0
        TX bytes:34 acl:0 sco:0 commands:9 errors:0
        Features: 0xff 0x3e 0x85 0x38 0x18 0x18 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy:
        Link mode: SLAVE ACCEPT
        Name: ''
        Class: 0x000104
        Service Classes: Unspecified
        Device Class: Computer, Desktop workstation
        HCI Ver: 2.0 (0x3) HCI Rev: 0x1f4 LMP Ver: 2.0 (0x3) LMP Subver:
0x1f4
        Manufacturer: CONWISE Technology Corporation Ltd (66)

 I have not created any SCO connection..  and there is no other device near
in the range..
  [root@vmware-fc6 bluez-hcidump-1.40]# hcitool scan
    Scanning ...
[root@vmware-fc6 bluez-hcidump-1.40]# hcitool con
   Connections:
[root@vmware-fc6 bluez-hcidump-1.40]# hcidump -V
HCI sniffer - Bluetooth packet analyzer ver 1.40
device: hci0 snap_len: 1028 filter: 0xffffffff
> SCO data: handle 92 flags 0x00 dlen 48
> SCO data: handle 92 flags 0x00 dlen 48
> SCO data: handle 92 flags 0x00 dlen 48
> SCO data: handle 92 flags 0x00 dlen 48
> SCO data: handle 92 flags 0x00 dlen 48
> SCO data: handle 92 flags 0x00 dlen 48
> SCO data: handle 92 flags 0x00 dlen 48
> SCO data: handle 92 flags 0x00 dlen 48

may be I am missing something here...
can anyone guide me on this...
thanks in advance for any help/suggestion/links ..

Best Regards,
Mahin Gupta.

------=_Part_396_12142433.1188372199380
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi All,<br>I am using bluez-libs 3.14, bluez-utils 3.14, hcidump 1.40 ..<br>when I am using hcidump -V -X I am continuously getting following output..<br><br>&gt; SCO data: handle 92 flags 0x00 dlen 48<br>&nbsp;&nbsp;&nbsp; 0000: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00 00&nbsp; ................
<br>&nbsp;&nbsp;&nbsp; 0010: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00 00&nbsp; ................<br>&nbsp;&nbsp;&nbsp; 0020: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00 00&nbsp; ................<br>&nbsp;It gives nothing else ...<br><br>&nbsp;<br>&nbsp;below is output of my hciconfig hci0 -a
<br>&nbsp;[root@vmware-fc6 bluez-hcidump-1.40]# hciconfig hci0 -a<br>hci0:&nbsp;&nbsp; Type: USB<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 11:11:11:11:11:11 ACL MTU: 672:3 SCO MTU: 48:1<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP RUNNING PSCAN ISCAN<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:387498 acl:0 sco:7357 events:9 errors:0
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:34 acl:0 sco:0 commands:9 errors:0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features: 0xff 0x3e 0x85 0x38 0x18 0x18 0x00 0x00<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link policy:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link mode: SLAVE ACCEPT
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Name: &#39;&#39;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Class: 0x000104<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Service Classes: Unspecified<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Device Class: Computer, Desktop workstation<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HCI Ver: 2.0 (0x3) HCI Rev: 0x1f4 LMP Ver: 2.0 (0x3) LMP Subver: 0x1f4
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufacturer: CONWISE Technology Corporation Ltd (66)<br><br>&nbsp;I have not created any SCO connection..&nbsp; and there is no other device near in the range..<br>&nbsp; [root@vmware-fc6 bluez-hcidump-1.40]# hcitool scan<br>
&nbsp;&nbsp;&nbsp; Scanning ...<br>[root@vmware-fc6 bluez-hcidump-1.40]# hcitool con<br>&nbsp;&nbsp; Connections:<br>[root@vmware-fc6 bluez-hcidump-1.40]# hcidump -V<br>HCI sniffer - Bluetooth packet analyzer ver 1.40<br>device: hci0 snap_len: 1028 filter: 0xffffffff
<br>&gt; SCO data: handle 92 flags 0x00 dlen 48<br>&gt; SCO data: handle 92 flags 0x00 dlen 48<br>&gt; SCO data: handle 92 flags 0x00 dlen 48<br>&gt; SCO data: handle 92 flags 0x00 dlen 48<br>&gt; SCO data: handle 92 flags 0x00 dlen 48
<br>&gt; SCO data: handle 92 flags 0x00 dlen 48<br>&gt; SCO data: handle 92 flags 0x00 dlen 48<br>&gt; SCO data: handle 92 flags 0x00 dlen 48<br><br>may be I am missing something here...<br>can anyone guide me on this...<br>
thanks in advance for any help/suggestion/links ..<br><br>Best Regards,<br>Mahin Gupta.

------=_Part_396_12142433.1188372199380--


--===============1796603956==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--===============1796603956==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1796603956==--
