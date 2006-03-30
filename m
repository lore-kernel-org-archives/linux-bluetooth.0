Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <f64f4e8a0603291723r2f529303md34d79a52a8f2f2e@mail.gmail.com>
From: "zhu yong" <zhuyong0003@gmail.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <f64f4e8a0603290636m323b0802v10a71ce9be067254@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_10493_5017448.1143681795607"
References: <f64f4e8a0603290636m323b0802v10a71ce9be067254@mail.gmail.com>
Subject: [Bluez-users] Fwd: l2ping problem about "Can't connect: Host is down"
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
Date: Thu, 30 Mar 2006 09:23:15 +0800

------=_Part_10493_5017448.1143681795607
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

---------- Forwarded message ----------
From: zhu yong <zhuyong0003@gmail.com>
Date: Mar 29, 2006 10:36 PM
Subject: l2ping problem about "Can't connect: Host is down"
To: bluez-users@lists.sourceforge.net

Hi everyone,

I am working with two bluetooth USB dongles. I use bluez-utils-2.25
and bluez-libs-2.25 packet. I use redhat9.0 with linux kernel 2.4.20,
I am not familier with kernel update, so I don't use bluez patch to
2.4.20.
They are connected to the same host. However I cannot l2ping one from
the other.
info as follows:
[root@localhost root]# l2ping -i 00:11:67:20:7e:33 00:11:67:1a:a7:0f
Can't connect: Host is down

And it looks like they are configured:
[root@localhost root]# hciconfig -a hci0
hci0:   Type: USB
       BD Address: 00:11:67:1A:A7:0F ACL MTU: 678:8 SCO MTU: 48:10
       UP RUNNING PSCAN ISCAN INQUIRY
       RX bytes:1038 acl:0 sco:0 events:38 errors:0
       TX bytes:923 acl:0 sco:0 commands:38 errors:0
       Features: 0xbf 0xfe 0x8d 0x78 0x08 0x18 0x00 0x00
       Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
       Link policy: RSWITCH HOLD SNIFF PARK
       Link mode: SLAVE ACCEPT
       Name: 'BlueZ (0)'
       Class: 0x3e0100
       Service Classes: Networking, Rendering, Capturing
       Device Class: Computer, Uncategorized
       HCI Ver: 1.2 (0x2) HCI Rev: 0x1fe LMP Ver: 1.2 (0x2) LMP Subver:
0x1fe
       Manufacturer: Integrated System Solution Corp. (57)

[root@localhost root]# hciconfig -a hci1
hci1:   Type: USB
       BD Address: 00:11:67:20:7E:33 ACL MTU: 678:8 SCO MTU: 48:10
       UP RUNNING PSCAN ISCAN
       RX bytes:724 acl:0 sco:0 events:58 errors:0
       TX bytes:1075 acl:0 sco:0 commands:49 errors:0
       Features: 0xbf 0xfe 0x8d 0x78 0x08 0x18 0x00 0x00
       Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
       Link policy: RSWITCH HOLD SNIFF PARK
       Link mode: SLAVE ACCEPT
       Name: 'BlueZ (1)'
       Class: 0x3e0100
       Service Classes: Networking, Rendering, Capturing
       Device Class: Computer, Uncategorized
       HCI Ver: 1.2 (0x2) HCI Rev: 0x1f4 LMP Ver: 1.2 (0x2) LMP Subver:
0x1f4
       Manufacturer: Integrated System Solution Corp. (57)

load module as follows:
[root@localhost bluez-utils-2.25]# lsmod
Module                  Size  Used by    Not tainted
l2cap                  19276   1
hci_usb                 8920   2
bluez                  40132  11  [l2cap hci_usb]
nls_iso8859-1           3516   1  (autoclean)
nls_cp437               5116   1  (autoclean)
vfat                   13004   1  (autoclean)
fat                    38808   0  (autoclean) [vfat]
ide-cd                 35708   0  (autoclean)
cdrom                  33728   0  (autoclean) [ide-cd]
parport_pc             19076   1  (autoclean)
lp                      8996   0  (autoclean)
parport                37056   1  (autoclean) [parport_pc lp]
autofs                 13268   0  (autoclean) (unused)
sis900                 16812   1
ipt_REJECT              3928   6  (autoclean)
iptable_filter          2412   1  (autoclean)
ip_tables              15096   2  [ipt_REJECT iptable_filter]
microcode               4668   0  (autoclean)
keybdev                 2944   0  (unused)
mousedev                5492   1
hid                    22148   0  (unused)
input                   5856   0  [keybdev mousedev hid]
ehci-hcd               19976   0  (unused)
usb-ohci               21480   0  (unused)
usbcore                78784   1  [hci_usb hid ehci-hcd usb-ohci]
[root@localhost bluez-utils-2.25]#

Can anyone figure out what"s wrong?

Thanks in advance,
yong Zhu

------=_Part_10493_5017448.1143681795607
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br><br>---------- Forwarded message ----------<br><span class=3D"gmail_quo=
te">From: <b class=3D"gmail_sendername">zhu yong</b> &lt;<a href=3D"mailto:=
zhuyong0003@gmail.com">zhuyong0003@gmail.com</a>&gt;<br>Date: Mar 29, 2006 =
10:36 PM
<br>Subject: l2ping problem about &quot;Can't connect: Host is down&quot;<b=
r>To: <a href=3D"mailto:bluez-users@lists.sourceforge.net">bluez-users@list=
s.sourceforge.net</a><br><br></span>Hi everyone,<br><br>I am working with t=
wo bluetooth USB dongles. I use=20
bluez-utils-2.25<br>and bluez-libs-2.25 packet. I use redhat9.0 with linux =
kernel 2.4.20,<br>I am not familier with kernel update, so I don't use blue=
z patch to<br>2.4.20.<br>They are connected to the same host. However I can=
not l2ping one from
<br>the other.<br>info as follows:<br>[root@localhost root]# l2ping -i 00:1=
1:67:20:7e:33 00:11:67:1a:a7:0f<br>Can't connect: Host is down<br><br>And i=
t looks like they are configured:<br>[root@localhost root]# hciconfig -a hc=
i0
<br>hci0:&nbsp;&nbsp; Type: USB<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD =
Address: 00:11:67:1A:A7:0F ACL MTU: 678:8 SCO MTU: 48:10<br>&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; UP RUNNING PSCAN ISCAN INQUIRY<br>&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; RX bytes:1038 acl:0 sco:0 events:38 errors:0<br>&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:923 acl:0 sco:0 commands:38 errors:0
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features: 0xbf 0xfe 0x8d 0x78 0x08=
 0x18 0x00 0x00<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Packet type: DM1 DM=
3 DM5 DH1 DH3 DH5 HV1 HV2 HV3<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link =
policy: RSWITCH HOLD SNIFF PARK<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Lin=
k mode: SLAVE ACCEPT<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Name: 'BlueZ (=
0)'
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Class: 0x3e0100<br>&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; Service Classes: Networking, Rendering, Capturing<br>=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Device Class: Computer, Uncategorized<=
br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HCI Ver: 1.2 (0x2) HCI Rev: 0x1fe L=
MP Ver: 1.2 (0x2) LMP Subver: 0x1fe<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 Manufacturer: Integrated System Solution Corp. (57)
<br><br>[root@localhost root]# hciconfig -a hci1<br>hci1:&nbsp;&nbsp; Type:=
 USB<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:11:67:20:7E:33 =
ACL MTU: 678:8 SCO MTU: 48:10<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP RU=
NNING PSCAN ISCAN<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:724 acl:=
0 sco:0 events:58 errors:0
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:1075 acl:0 sco:0 commands=
:49 errors:0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features: 0xbf 0xfe 0x=
8d 0x78 0x08 0x18 0x00 0x00<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Packet =
type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; Link policy: RSWITCH HOLD SNIFF PARK
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link mode: SLAVE ACCEPT<br>&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Name: 'BlueZ (1)'<br>&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; Class: 0x3e0100<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Servic=
e Classes: Networking, Rendering, Capturing<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; Device Class: Computer, Uncategorized<br>&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; HCI Ver: 1.2 (0x2) HCI Rev: 0x1f4 LMP Ver:=20
1.2 (0x2) LMP Subver: 0x1f4<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufac=
turer: Integrated System Solution Corp. (57)<br><br>load module as follows:=
<br>[root@localhost bluez-utils-2.25]# lsmod<br>Module&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;Size&nbsp;&nbsp;Used by&nbsp;&nbsp;&nbsp;&nbsp;Not tainted<br>
l2cap&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;19276&nbsp;&nbsp; 1<br>hci_usb&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 8920&nbsp;&nbsp; 2<br>bluez&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
40132&nbsp;&nbsp;11&nbsp;&nbsp;[l2cap hci_usb]<br>nls_iso8859-1&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3516&nbsp;&nbsp; 1&nbsp;&n=
bsp;(autoclean)<br>nls_cp437&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5116&nbsp;&nbsp; 1&nbsp;&nbsp;(autocl=
ean)<br>
vfat&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 13004&nbsp;&nbsp; 1&nbsp;&nbsp;(autoc=
lean)<br>fat&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;38808&nbsp;&nbsp; =
0&nbsp;&nbsp;(autoclean) [vfat]<br>ide-cd&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 35708&nbsp;&=
nbsp; 0&nbsp;&nbsp;(autoclean)<br>cdrom&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;337=
28&nbsp;&nbsp; 0&nbsp;&nbsp;(autoclean) [ide-cd]<br>parport_pc&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 19076&nbsp;&nbs=
p; 1&nbsp;&nbsp;(autoclean)
<br>lp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;8996&nbsp;&n=
bsp; 0&nbsp;&nbsp;(autoclean)<br>parport&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;37056&nbsp;&nb=
sp; 1&nbsp;&nbsp;(autoclean) [parport_pc lp]<br>autofs&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 13268&nbsp;&nbsp; 0&nbsp;&nbsp;(autoclean) (unused)<br>sis900&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; 16812&nbsp;&nbsp; 1<br>ipt_REJECT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3928&nbsp;&nbsp; 6&nbsp;=
&nbsp;(autoclean)
<br>iptable_filter&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;2412&nbsp;&nbsp; 1&nbsp;&nbsp;(autoclean)<br>ip_tables&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;15096&nbs=
p;&nbsp; 2&nbsp;&nbsp;[ipt_REJECT iptable_filter]<br>microcode&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 466=
8&nbsp;&nbsp; 0&nbsp;&nbsp;(autoclean)<br>keybdev&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2944=
&nbsp;&nbsp; 0&nbsp;&nbsp;(unused)<br>mousedev&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;5492&nbs=
p;&nbsp; 1
<br>hid&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;22148&nbsp;&nbsp; 0&nbs=
p;&nbsp;(unused)<br>input&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5856&nbsp;&nbsp;=
 0&nbsp;&nbsp;[keybdev mousedev hid]<br>ehci-hcd&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 19976&nbsp;&nbsp;=
 0&nbsp;&nbsp;(unused)<br>usb-ohci&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 21480&nbsp;&nbsp; 0&nbsp;&nbsp;=
(unused)<br>usbcore&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;78784&nbsp;&nbsp; 1&nbsp;&nbsp;[hci=
_usb hid ehci-hcd usb-ohci]
<br>[root@localhost bluez-utils-2.25]#<br><br>Can anyone figure out what&qu=
ot;s wrong?<br><br>Thanks in advance,<br>yong Zhu<br>

------=_Part_10493_5017448.1143681795607--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
