Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <fe0a97c20604152352o818da63o75232a1a0a0bceee@mail.gmail.com>
From: "Sowmya Gattupalli" <sowmya.gattupalli@gmail.com>
To: Bluez-devel@lists.sourceforge.net
In-Reply-To: <fe0a97c20604060405l2e3452c5i31b111a54bf73aee@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_17161_7596178.1145170366330"
References: <fe0a97c20604060405l2e3452c5i31b111a54bf73aee@mail.gmail.com>
Subject: [Bluez-devel] ISSC dongle---- does it support SCO?
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 16 Apr 2006 12:22:46 +0530

------=_Part_17161_7596178.1145170366330
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi guys...
I have an ISSC dongle which has the following bdaddress and other info....
Now does it support SCO??


root@0[test]# hciconfig hci0 revision
hci0:   Type: USB
        BD Address: 11:11:11:11:11:11 ACL MTU: 678:8  SCO MTU: 48:10
        Unsupported manufacturer

its hciconfig -a gives
root@0[test]# hciconfig -a
hci0:   Type: USB
        BD Address: 11:11:11:11:11:11 ACL MTU: 678:8  SCO MTU: 48:10
        UP RUNNING PSCAN ISCAN
        RX bytes:6891545 acl:128 sco:168567 events:425 errors:0
        TX bytes:3268 acl:128 sco:0 commands:139 errors:0
        Features: 0xbf 0xfe 0x8d 0x78 0x08 0x18 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'Knoppix-0'
        Class: 0x000100
        Service Classes: Unspecified
        Device Class: Computer, Uncategorized
        HCI Ver: 1.2 (0x2) HCI Rev: 0x1fe LMP Ver: 1.2 (0x2) LMP Subver:
0x1fe
        Manufacturer: Integrated System Solution Corp. (57)

hcitool info gives:
root@bluetooth:~# hcitool info 11:11:11:11:11:11
Requesting information ...
        BD Address:  11:11:11:11:11:11
        Device Name: Knoppix-0
        LMP Version: 1.2 (0x2) LMP Subversion: 0x1fe
        Manufacturer: Integrated System Solution Corp. (57)
        Features: 0xbf 0xfe 0x8d 0x78 0x08 0x18 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot offset=
>
                <timing accuracy> <role switch> <sniff mode> <RSSI>
                <channel quality> <SCO link> <HV2 packets> <HV3 packets>
                <u-law log> <A-law log> <CVSD> <power control>
                <transparent SCO> <broadcast encrypt> <enhanced iscan>
                <interlaced iscan> <interlaced pscan> <inquiry with RSSI>
                <AFH cap. slave> <AFH cap. master> <AFH class. master>


ne ideas??

------=_Part_17161_7596178.1145170366330
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br><br><span class=3D"gmail_quote"><br><br></span><div style=3D"direction:=
 ltr;">Hi guys... <br>I have an ISSC dongle which has the following bdaddre=
ss and other info.... <br>Now does it support SCO?? <br><br><br>root@0[test=
]# hciconfig hci0 revision
<br>hci0:&nbsp;&nbsp; Type: USB<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; BD Address: 11:11:11:11:11:11 ACL MTU: 678:8&nbsp; SCO MTU: 48:10
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Unsupported manufacturer<br>=
<br>its hciconfig -a gives<br>root@0[test]# hciconfig -a<br>hci0:&nbsp;&nbs=
p; Type: USB<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 11:1=
1:11:11:11:11 ACL MTU: 678:8&nbsp; SCO MTU: 48:10<br>&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; UP RUNNING PSCAN ISCAN
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:6891545 acl:128 sco=
:168567 events:425 errors:0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; T=
X bytes:3268 acl:128 sco:0 commands:139 errors:0<br>&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; Features: 0xbf 0xfe 0x8d 0x78 0x08 0x18 0x00 0x00<br>&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Packet type: DM1 DM3 DM5 DH1 DH3 D=
H5 HV1 HV2 HV3
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link policy: RSWITCH HOLD SN=
IFF PARK<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link mode: SLAVE ACC=
EPT<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Name: 'Knoppix-0'<br>&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Class: 0x000100<br>&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; Service Classes: Unspecified<br>&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; Device Class: Computer, Uncategorized
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HCI Ver: 1.2 (0x2) HCI Rev: =
0x1fe LMP Ver: 1.2 (0x2) LMP Subver: 0x1fe<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; Manufacturer: Integrated System Solution Corp. (57)<br><br>hc=
itool info gives:<br>root@bluetooth:~# hcitool info 11:11:11:11:11:11
<br>Requesting information ...<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; BD Address:&nbsp; 11:11:11:11:11:11<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; Device Name: Knoppix-0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; LMP Version: 1.2 (0x2) LMP Subversion: 0x1fe<br>&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; Manufacturer: Integrated System Solution Corp. (57)
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features: 0xbf 0xfe 0x8d 0x7=
8 0x08 0x18 0x00 0x00<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&lt;3-slot packets&gt; &lt;5-slot packets&gt; &lt;encryption&gt;
&lt;slot offset&gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&lt;timing accuracy&gt; &lt;role switch&gt; &lt;sniff mode&gt;
&lt;RSSI&gt;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;
&lt;channel quality&gt; &lt;SCO link&gt; &lt;HV2 packets&gt; &lt;HV3
packets&gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&lt;u-law log&gt; &lt;A-law log&gt; &lt;CVSD&gt; &lt;power control&gt;<br>&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;
&lt;transparent SCO&gt; &lt;broadcast encrypt&gt; &lt;enhanced
iscan&gt;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;
&lt;interlaced iscan&gt; &lt;interlaced pscan&gt; &lt;inquiry with
RSSI&gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;
&lt;AFH cap. slave&gt; &lt;AFH cap. master&gt; &lt;AFH class. master&gt;<br=
><br><br>ne ideas??<br><br><br>
<br><br>

</div>

------=_Part_17161_7596178.1145170366330--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
