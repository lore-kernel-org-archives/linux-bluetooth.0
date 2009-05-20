Return-Path: <cyrus@holtmann.org>
Message-ID: <504288.41529.qm@web95402.mail.in2.yahoo.com>
References: <113d36d80905192336i337964a9hcbaa5ccb729434b6@mail.gmail.com>  <113d36d80905192341q4aa2463dyd0b1ed107792cff0@mail.gmail.com>  <113d36d80905192344p3caf4c3dm3ebe1a5c00eda3f9@mail.gmail.com> <1242805691.3147.19.camel@localhost.localdomain>
Date: Wed, 20 May 2009 23:26:28 +0530 (IST)
From: balaji palaniswami <balaji_palaniswami@yahoo.com>
Subject: Re: bluetooth pairing issue in kernel 2.6.30-rc5
To: Marcel Holtmann <marcel@holtmann.org>, lan zhu <zhu.lan.cn@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1242805691.3147.19.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1593178881-1242842188=:41529"
List-ID: <linux-bluetooth.vger.kernel.org>


--0-1593178881-1242842188=:41529
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi ,=0A=0AI upgraded kernel 2.6.30-rc5 which includes below fixes =0A=0A=0A=
Marcel Holtmann (4):=0A      Bluetooth: Move dev_set_name() to a context th=
at can sleep=0A      Bluetooth: Fix wrong module refcount when connection s=
etup fails=0A      Bluetooth: Don't use hci_acl_connect_cancel() for incomi=
ng connections=0A      Bluetooth: Don't trigger disconnect timeout for secu=
rity mode 3 pairing=0Ai am using bluez 4.32 .After that i tried a2dp connec=
tion with automatic key option which is failed.=0Abecause Error : Authentic=
ation failure is thrown by another end. Is this problem with remote bluetoo=
th dongle ? =0ADo i need to upgrade bluez to latest version?=0A=0APlease  h=
elp me to reslove the issue.=0A=0AThanks,=0ABalaji.P=0A=0AFollowing dump is=
 captured during connection.=0A=0A balaji@balaji-desktop:~$ sudo hcidump -X=
Vt=0AHCI sniffer - Bluetooth packet analyzer ver 1.42=0Adevice: hci0 snap_l=
en: 1028 filter: 0xffffffff=0A2009-05-21 04:34:58.084229 < HCI Command: Per=
iodic Inquiry Mode (0x01|0x0003) plen 9=0A    max 24 min 16 lap 0x9e8b33 le=
n 8 num 0=0A2009-05-21 04:34:58.086376 > HCI Event: Command Complete (0x0e)=
 plen 4=0A    Periodic Inquiry Mode (0x01|0x0003) ncmd 1=0A    status 0x00=
=0A2009-05-21 04:34:59.950376 > HCI Event: Inquiry Result with RSSI (0x22) =
plen 15=0A    bdaddr 00:80:98:E7:32:2A mode 1 clkoffset 0x6065 class 0x0404=
1c rssi -62=0A2009-05-21 04:35:02.842471 < HCI Command: Exit Periodic Inqui=
ry Mode (0x01|0x0004) plen 0=0A2009-05-21 04:35:02.845380 > HCI Event: Comm=
and Complete (0x0e) plen 4=0A    Exit Periodic Inquiry Mode (0x01|0x0004) n=
cmd 1=0A    status 0x00=0A2009-05-21 04:35:02.852316 < HCI Command: Create =
Connection (0x01|0x0005) plen 13=0A    bdaddr 00:80:98:E7:32:2A ptype 0xcc1=
8 rswitch 0x01 clkoffset 0x6065 (valid)=0A    Packet type: DM1 DM3 DM5 DH1 =
DH3 DH5 =0A2009-05-21 04:35:02.856377 > HCI Event: Command Status (0x0f) pl=
en 4=0A    Create Connection (0x01|0x0005) status 0x00 ncmd 1=0A2009-05-21 =
04:35:03.691386 > HCI Event: Connect Complete (0x03) plen 11=0A    status 0=
x00 handle 21 bdaddr 00:80:98:E7:32:2A type ACL encrypt 0x00=0A2009-05-21 0=
4:35:03.691411 < HCI Command: Read Remote Supported Features (0x01|0x001b) =
plen 2=0A    handle 21=0A2009-05-21 04:35:03.694380 > HCI Event: Command St=
atus (0x0f) plen 4=0A    Read Remote Supported Features (0x01|0x001b) statu=
s 0x00 ncmd 1=0A2009-05-21 04:35:03.695285 < HCI Command: Remote Name Reque=
st (0x01|0x0019) plen 10=0A    bdaddr 00:80:98:E7:32:2A mode 2 clkoffset 0x=
0000=0A2009-05-21 04:35:03.771388 > HCI Event: Max Slots Change (0x1b) plen=
 3=0A    handle 21 slots 5=0A2009-05-21 04:35:03.773382 > HCI Event: Connec=
tion Packet Type Changed (0x1d) plen 5=0A    status 0x00 handle 21 ptype 0x=
cc18=0A    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 =0A2009-05-21 04:35:03.7753=
80 > HCI Event: Read Remote Supported Features (0x0b) plen 11=0A    status =
0x00 handle 21=0A    Features: 0xff 0xff 0x8f 0x7e 0x98 0x1f 0x59 0x83=0A20=
09-05-21 04:35:03.777379 > HCI Event: Command Status (0x0f) plen 4=0A    Re=
mote Name Request (0x01|0x0019) status 0x00 ncmd 1=0A2009-05-21 04:35:03.77=
7392 < HCI Command: Read Remote Extended Features (0x01|0x001c) plen 3=0A  =
  handle 21 page 1=0A2009-05-21 04:35:03.810390 > HCI Event: Remote Host Su=
pported Features Notification (0x3d) plen 14=0A    bdaddr 00:80:98:E7:32:2A=
=0A    Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00=0A2009-05-21 04:35=
:03.893380 > HCI Event: Remote Name Req Complete (0x07) plen 255=0A    stat=
us 0x00 bdaddr 00:80:98:E7:32:2A name 'PTS-A2DP-JKUMAPTS-A2DP-'=0A2009-05-2=
1 04:35:03.895378 > HCI Event: Command Status (0x0f) plen 4=0A    Read Remo=
te Extended Features (0x01|0x001c) status 0x00 ncmd 1=0A2009-05-21 04:35:03=
..895395 < HCI Command: Read Remote Version Information (0x01|0x001d) plen 2=
=0A    handle 21=0A2009-05-21 04:35:03.897380 > HCI Event: Read Remote Exte=
nded Features (0x23) plen 13=0A    status 0x00 handle 21 page 1 max 1=0A   =
 Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00=0A2009-05-21 04:35:03.89=
9378 > HCI Event: Command Status (0x0f) plen 4=0A    Read Remote Version In=
formation (0x01|0x001d) status 0x00 ncmd 1=0A2009-05-21 04:35:03.899392 < H=
CI Command: Authentication Requested (0x01|0x0011) plen 2=0A    handle 21=
=0A2009-05-21 04:35:03.901378 > HCI Event: Command Status (0x0f) plen 4=0A =
   Authentication Requested (0x01|0x0011) status 0x00 ncmd 1=0A2009-05-21 0=
4:35:03.903378 > HCI Event: Link Key Request (0x17) plen 6=0A    bdaddr 00:=
80:98:E7:32:2A=0A2009-05-21 04:35:03.905821 < HCI Command: Link Key Request=
 Negative Reply (0x01|0x000c) plen 6=0A    bdaddr 00:80:98:E7:32:2A=0A2009-=
05-21 04:35:03.907377 > HCI Event: Command Complete (0x0e) plen 10=0A    Li=
nk Key Request Negative Reply (0x01|0x000c) ncmd 1=0A    status 0x00 bdaddr=
 00:80:98:E7:32:2A=0A2009-05-21 04:35:03.909376 > HCI Event: IO Capability =
Request (0x31) plen 6=0A    bdaddr 00:80:98:E7:32:2A=0A2009-05-21 04:35:03.=
909499 < HCI Command: IO Capability Request Reply (0x01|0x002b) plen 9=0A  =
  bdaddr 00:80:98:E7:32:2A capability 0x00 oob 0x00 auth 0x03=0A    Capabil=
ity: DisplayOnly (OOB data not present)=0A    Authentication: Dedicated Bon=
ding (MITM Protection)=0A2009-05-21 04:35:03.911376 > HCI Event: Command Co=
mplete (0x0e) plen 10=0A    IO Capability Request Reply (0x01|0x002b) ncmd =
1=0A    status 0x00 bdaddr 00:80:98:E7:32:2A=0A2009-05-21 04:35:03.925382 >=
 HCI Event: Read Remote Ver Info Complete (0x0c) plen 8=0A    status 0x00 h=
andle 21=0A    LMP Version: 2.1 (0x4) LMP Subversion: 0x14f0=0A    Manufact=
urer: Cambridge Silicon Radio (10)=0A2009-05-21 04:35:04.315386 > HCI Event=
: IO Capability Response (0x32) plen 9=0A    bdaddr 00:80:98:E7:32:2A capab=
ility 0x01 oob 0x00 auth 0x02=0A    Capability: DisplayYesNo (OOB data not =
present)=0A    Authentication: Dedicated Bonding (No MITM Protection)=0A200=
9-05-21 04:35:05.002381 > HCI Event: User Confirmation Request (0x33) plen =
10=0A    bdaddr 00:80:98:E7:32:2A passkey 245729=0A2009-05-21 04:35:08.4313=
88 > HCI Event: Inquiry Complete (0x01) plen 1=0A    status 0x00=0A2009-05-=
21 04:35:35.469398 > HCI Event: Simple Pairing Complete (0x36) plen 7=0A   =
 status 0x05 bdaddr 00:80:98:E7:32:2A=0A    Error: Authentication Failure=
=0A2009-05-21 04:35:35.471393 > HCI Event: Auth Complete (0x06) plen 3=0A  =
  status 0x05 handle 21=0A    Error: Authentication Failure=0A2009-05-21 04=
:35:35.471557 < HCI Command: User Confirmation Request Negative Reply (0x01=
|0x002d) plen 6=0A    bdaddr 00:80:98:E7:32:2A=0A2009-05-21 04:35:37.468080=
 < HCI Command: Disconnect (0x01|0x0006) plen 3=0A    handle 21 reason 0x13=
=0A    Reason: Remote User Terminated Connection=0A2009-05-21 04:35:37.4703=
92 > HCI Event: Command Status (0x0f) plen 4=0A    Disconnect (0x01|0x0006)=
 status 0x00 ncmd 1=0A2009-05-21 04:35:37.652402 > HCI Event: Disconn Compl=
ete (0x05) plen 4=0A    status 0x00 handle 21 reason 0x16=0A    Reason: Con=
nection Terminated by Local Host=0A=0A=0A=0A=0A----- Original Message ----=
=0AFrom: Marcel Holtmann <marcel@holtmann.org>=0ATo: lan zhu <zhu.lan.cn@gm=
ail.com>=0ACc: linux-bluetooth@vger.kernel.org=0ASent: Wednesday, 20 May, 2=
009 1:18:11 PM=0ASubject: Re: bluetooth pairing issue in kernel 2.6.27=0A=
=0AHi,=0A=0A> When pairing two Android devices which are supported by Bluez=
 on=0A> kernel 2.6.27, it will always fail if the user can't finish the who=
le=0A> procedure in 10 seconds. After some analysis we found the root cause=
=0A> is that Bluez's HCI link's time out timer is set to 10s in the kernel,=
=0A> and in Bluez's create_bonding() function it calls l2raw_connect() to=
=0A> create only HCI link without L2CAP channel.=0A> =0A> One easy way to f=
ix this issue is to create L2CAP link when creating=0A> bonding, but this i=
s not a final solution, because=0A> according to Bluetooth Specification, c=
reating L2CAP link is only=0A> optional in the bonding establishment proced=
ure, so the thorough way=0A> to fix it is to alter the HCI link's time out =
timer when handling=0A> bonding request.=0A> =0A> Does anyone know has this=
 been fixed on Bluez kernel's patch on=0A> 2.6.27, or on the 2.6.29 and lat=
er's kernel?=0A=0Athe 2.6.30-rc6 kernel should contains fixes for this to m=
ake pairing=0Asmooth with either Legacy or Simple Pairing.=0A=0ARegards=0A=
=0AMarcel=0A=0A=0A--=0ATo unsubscribe from this list: send the line "unsubs=
cribe linux-bluetooth" in=0Athe body of a message to majordomo@vger.kernel.=
org=0AMore majordomo info at  http://vger.kernel.org/majordomo-info.html=0A=
=0A=0A=0A      Cricket on your mind? Visit the ultimate cricket website. En=
ter http://beta.cricket.yahoo.com
--0-1593178881-1242842188=:41529
Content-Type: text/plain; name="a2dp_log.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="a2dp_log.txt"

YmFsYWppQGJhbGFqaS1kZXNrdG9wOn4kIHN1ZG8gaGNpZHVtcCAtWFZ0CkhD
SSBzbmlmZmVyIC0gQmx1ZXRvb3RoIHBhY2tldCBhbmFseXplciB2ZXIgMS40
MgpkZXZpY2U6IGhjaTAgc25hcF9sZW46IDEwMjggZmlsdGVyOiAweGZmZmZm
ZmZmCjIwMDktMDUtMjEgMDQ6MzQ6NTguMDg0MjI5IDwgSENJIENvbW1hbmQ6
IFBlcmlvZGljIElucXVpcnkgTW9kZSAoMHgwMXwweDAwMDMpIHBsZW4gOQog
ICAgbWF4IDI0IG1pbiAxNiBsYXAgMHg5ZThiMzMgbGVuIDggbnVtIDAKMjAw
OS0wNS0yMSAwNDozNDo1OC4wODYzNzYgPiBIQ0kgRXZlbnQ6IENvbW1hbmQg
Q29tcGxldGUgKDB4MGUpIHBsZW4gNAogICAgUGVyaW9kaWMgSW5xdWlyeSBN
b2RlICgweDAxfDB4MDAwMykgbmNtZCAxCiAgICBzdGF0dXMgMHgwMAoyMDA5
LTA1LTIxIDA0OjM0OjU5Ljk1MDM3NiA+IEhDSSBFdmVudDogSW5xdWlyeSBS
ZXN1bHQgd2l0aCBSU1NJICgweDIyKSBwbGVuIDE1CiAgICBiZGFkZHIgMDA6
ODA6OTg6RTc6MzI6MkEgbW9kZSAxIGNsa29mZnNldCAweDYwNjUgY2xhc3Mg
MHgwNDA0MWMgcnNzaSAtNjIKMjAwOS0wNS0yMSAwNDozNTowMi44NDI0NzEg
PCBIQ0kgQ29tbWFuZDogRXhpdCBQZXJpb2RpYyBJbnF1aXJ5IE1vZGUgKDB4
MDF8MHgwMDA0KSBwbGVuIDAKMjAwOS0wNS0yMSAwNDozNTowMi44NDUzODAg
PiBIQ0kgRXZlbnQ6IENvbW1hbmQgQ29tcGxldGUgKDB4MGUpIHBsZW4gNAog
ICAgRXhpdCBQZXJpb2RpYyBJbnF1aXJ5IE1vZGUgKDB4MDF8MHgwMDA0KSBu
Y21kIDEKICAgIHN0YXR1cyAweDAwCjIwMDktMDUtMjEgMDQ6MzU6MDIuODUy
MzE2IDwgSENJIENvbW1hbmQ6IENyZWF0ZSBDb25uZWN0aW9uICgweDAxfDB4
MDAwNSkgcGxlbiAxMwogICAgYmRhZGRyIDAwOjgwOjk4OkU3OjMyOjJBIHB0
eXBlIDB4Y2MxOCByc3dpdGNoIDB4MDEgY2xrb2Zmc2V0IDB4NjA2NSAodmFs
aWQpCiAgICBQYWNrZXQgdHlwZTogRE0xIERNMyBETTUgREgxIERIMyBESDUg
CjIwMDktMDUtMjEgMDQ6MzU6MDIuODU2Mzc3ID4gSENJIEV2ZW50OiBDb21t
YW5kIFN0YXR1cyAoMHgwZikgcGxlbiA0CiAgICBDcmVhdGUgQ29ubmVjdGlv
biAoMHgwMXwweDAwMDUpIHN0YXR1cyAweDAwIG5jbWQgMQoyMDA5LTA1LTIx
IDA0OjM1OjAzLjY5MTM4NiA+IEhDSSBFdmVudDogQ29ubmVjdCBDb21wbGV0
ZSAoMHgwMykgcGxlbiAxMQogICAgc3RhdHVzIDB4MDAgaGFuZGxlIDIxIGJk
YWRkciAwMDo4MDo5ODpFNzozMjoyQSB0eXBlIEFDTCBlbmNyeXB0IDB4MDAK
MjAwOS0wNS0yMSAwNDozNTowMy42OTE0MTEgPCBIQ0kgQ29tbWFuZDogUmVh
ZCBSZW1vdGUgU3VwcG9ydGVkIEZlYXR1cmVzICgweDAxfDB4MDAxYikgcGxl
biAyCiAgICBoYW5kbGUgMjEKMjAwOS0wNS0yMSAwNDozNTowMy42OTQzODAg
PiBIQ0kgRXZlbnQ6IENvbW1hbmQgU3RhdHVzICgweDBmKSBwbGVuIDQKICAg
IFJlYWQgUmVtb3RlIFN1cHBvcnRlZCBGZWF0dXJlcyAoMHgwMXwweDAwMWIp
IHN0YXR1cyAweDAwIG5jbWQgMQoyMDA5LTA1LTIxIDA0OjM1OjAzLjY5NTI4
NSA8IEhDSSBDb21tYW5kOiBSZW1vdGUgTmFtZSBSZXF1ZXN0ICgweDAxfDB4
MDAxOSkgcGxlbiAxMAogICAgYmRhZGRyIDAwOjgwOjk4OkU3OjMyOjJBIG1v
ZGUgMiBjbGtvZmZzZXQgMHgwMDAwCjIwMDktMDUtMjEgMDQ6MzU6MDMuNzcx
Mzg4ID4gSENJIEV2ZW50OiBNYXggU2xvdHMgQ2hhbmdlICgweDFiKSBwbGVu
IDMKICAgIGhhbmRsZSAyMSBzbG90cyA1CjIwMDktMDUtMjEgMDQ6MzU6MDMu
NzczMzgyID4gSENJIEV2ZW50OiBDb25uZWN0aW9uIFBhY2tldCBUeXBlIENo
YW5nZWQgKDB4MWQpIHBsZW4gNQogICAgc3RhdHVzIDB4MDAgaGFuZGxlIDIx
IHB0eXBlIDB4Y2MxOAogICAgUGFja2V0IHR5cGU6IERNMSBETTMgRE01IERI
MSBESDMgREg1IAoyMDA5LTA1LTIxIDA0OjM1OjAzLjc3NTM4MCA+IEhDSSBF
dmVudDogUmVhZCBSZW1vdGUgU3VwcG9ydGVkIEZlYXR1cmVzICgweDBiKSBw
bGVuIDExCiAgICBzdGF0dXMgMHgwMCBoYW5kbGUgMjEKICAgIEZlYXR1cmVz
OiAweGZmIDB4ZmYgMHg4ZiAweDdlIDB4OTggMHgxZiAweDU5IDB4ODMKMjAw
OS0wNS0yMSAwNDozNTowMy43NzczNzkgPiBIQ0kgRXZlbnQ6IENvbW1hbmQg
U3RhdHVzICgweDBmKSBwbGVuIDQKICAgIFJlbW90ZSBOYW1lIFJlcXVlc3Qg
KDB4MDF8MHgwMDE5KSBzdGF0dXMgMHgwMCBuY21kIDEKMjAwOS0wNS0yMSAw
NDozNTowMy43NzczOTIgPCBIQ0kgQ29tbWFuZDogUmVhZCBSZW1vdGUgRXh0
ZW5kZWQgRmVhdHVyZXMgKDB4MDF8MHgwMDFjKSBwbGVuIDMKICAgIGhhbmRs
ZSAyMSBwYWdlIDEKMjAwOS0wNS0yMSAwNDozNTowMy44MTAzOTAgPiBIQ0kg
RXZlbnQ6IFJlbW90ZSBIb3N0IFN1cHBvcnRlZCBGZWF0dXJlcyBOb3RpZmlj
YXRpb24gKDB4M2QpIHBsZW4gMTQKICAgIGJkYWRkciAwMDo4MDo5ODpFNzoz
MjoyQQogICAgRmVhdHVyZXM6IDB4MDEgMHgwMCAweDAwIDB4MDAgMHgwMCAw
eDAwIDB4MDAgMHgwMAoyMDA5LTA1LTIxIDA0OjM1OjAzLjg5MzM4MCA+IEhD
SSBFdmVudDogUmVtb3RlIE5hbWUgUmVxIENvbXBsZXRlICgweDA3KSBwbGVu
IDI1NQogICAgc3RhdHVzIDB4MDAgYmRhZGRyIDAwOjgwOjk4OkU3OjMyOjJB
IG5hbWUgJ1BUUy1BMkRQLUpLVU1BUFRTLUEyRFAtJwoyMDA5LTA1LTIxIDA0
OjM1OjAzLjg5NTM3OCA+IEhDSSBFdmVudDogQ29tbWFuZCBTdGF0dXMgKDB4
MGYpIHBsZW4gNAogICAgUmVhZCBSZW1vdGUgRXh0ZW5kZWQgRmVhdHVyZXMg
KDB4MDF8MHgwMDFjKSBzdGF0dXMgMHgwMCBuY21kIDEKMjAwOS0wNS0yMSAw
NDozNTowMy44OTUzOTUgPCBIQ0kgQ29tbWFuZDogUmVhZCBSZW1vdGUgVmVy
c2lvbiBJbmZvcm1hdGlvbiAoMHgwMXwweDAwMWQpIHBsZW4gMgogICAgaGFu
ZGxlIDIxCjIwMDktMDUtMjEgMDQ6MzU6MDMuODk3MzgwID4gSENJIEV2ZW50
OiBSZWFkIFJlbW90ZSBFeHRlbmRlZCBGZWF0dXJlcyAoMHgyMykgcGxlbiAx
MwogICAgc3RhdHVzIDB4MDAgaGFuZGxlIDIxIHBhZ2UgMSBtYXggMQogICAg
RmVhdHVyZXM6IDB4MDEgMHgwMCAweDAwIDB4MDAgMHgwMCAweDAwIDB4MDAg
MHgwMAoyMDA5LTA1LTIxIDA0OjM1OjAzLjg5OTM3OCA+IEhDSSBFdmVudDog
Q29tbWFuZCBTdGF0dXMgKDB4MGYpIHBsZW4gNAogICAgUmVhZCBSZW1vdGUg
VmVyc2lvbiBJbmZvcm1hdGlvbiAoMHgwMXwweDAwMWQpIHN0YXR1cyAweDAw
IG5jbWQgMQoyMDA5LTA1LTIxIDA0OjM1OjAzLjg5OTM5MiA8IEhDSSBDb21t
YW5kOiBBdXRoZW50aWNhdGlvbiBSZXF1ZXN0ZWQgKDB4MDF8MHgwMDExKSBw
bGVuIDIKICAgIGhhbmRsZSAyMQoyMDA5LTA1LTIxIDA0OjM1OjAzLjkwMTM3
OCA+IEhDSSBFdmVudDogQ29tbWFuZCBTdGF0dXMgKDB4MGYpIHBsZW4gNAog
ICAgQXV0aGVudGljYXRpb24gUmVxdWVzdGVkICgweDAxfDB4MDAxMSkgc3Rh
dHVzIDB4MDAgbmNtZCAxCjIwMDktMDUtMjEgMDQ6MzU6MDMuOTAzMzc4ID4g
SENJIEV2ZW50OiBMaW5rIEtleSBSZXF1ZXN0ICgweDE3KSBwbGVuIDYKICAg
IGJkYWRkciAwMDo4MDo5ODpFNzozMjoyQQoyMDA5LTA1LTIxIDA0OjM1OjAz
LjkwNTgyMSA8IEhDSSBDb21tYW5kOiBMaW5rIEtleSBSZXF1ZXN0IE5lZ2F0
aXZlIFJlcGx5ICgweDAxfDB4MDAwYykgcGxlbiA2CiAgICBiZGFkZHIgMDA6
ODA6OTg6RTc6MzI6MkEKMjAwOS0wNS0yMSAwNDozNTowMy45MDczNzcgPiBI
Q0kgRXZlbnQ6IENvbW1hbmQgQ29tcGxldGUgKDB4MGUpIHBsZW4gMTAKICAg
IExpbmsgS2V5IFJlcXVlc3QgTmVnYXRpdmUgUmVwbHkgKDB4MDF8MHgwMDBj
KSBuY21kIDEKICAgIHN0YXR1cyAweDAwIGJkYWRkciAwMDo4MDo5ODpFNzoz
MjoyQQoyMDA5LTA1LTIxIDA0OjM1OjAzLjkwOTM3NiA+IEhDSSBFdmVudDog
SU8gQ2FwYWJpbGl0eSBSZXF1ZXN0ICgweDMxKSBwbGVuIDYKICAgIGJkYWRk
ciAwMDo4MDo5ODpFNzozMjoyQQoyMDA5LTA1LTIxIDA0OjM1OjAzLjkwOTQ5
OSA8IEhDSSBDb21tYW5kOiBJTyBDYXBhYmlsaXR5IFJlcXVlc3QgUmVwbHkg
KDB4MDF8MHgwMDJiKSBwbGVuIDkKICAgIGJkYWRkciAwMDo4MDo5ODpFNzoz
MjoyQSBjYXBhYmlsaXR5IDB4MDAgb29iIDB4MDAgYXV0aCAweDAzCiAgICBD
YXBhYmlsaXR5OiBEaXNwbGF5T25seSAoT09CIGRhdGEgbm90IHByZXNlbnQp
CiAgICBBdXRoZW50aWNhdGlvbjogRGVkaWNhdGVkIEJvbmRpbmcgKE1JVE0g
UHJvdGVjdGlvbikKMjAwOS0wNS0yMSAwNDozNTowMy45MTEzNzYgPiBIQ0kg
RXZlbnQ6IENvbW1hbmQgQ29tcGxldGUgKDB4MGUpIHBsZW4gMTAKICAgIElP
IENhcGFiaWxpdHkgUmVxdWVzdCBSZXBseSAoMHgwMXwweDAwMmIpIG5jbWQg
MQogICAgc3RhdHVzIDB4MDAgYmRhZGRyIDAwOjgwOjk4OkU3OjMyOjJBCjIw
MDktMDUtMjEgMDQ6MzU6MDMuOTI1MzgyID4gSENJIEV2ZW50OiBSZWFkIFJl
bW90ZSBWZXIgSW5mbyBDb21wbGV0ZSAoMHgwYykgcGxlbiA4CiAgICBzdGF0
dXMgMHgwMCBoYW5kbGUgMjEKICAgIExNUCBWZXJzaW9uOiAyLjEgKDB4NCkg
TE1QIFN1YnZlcnNpb246IDB4MTRmMAogICAgTWFudWZhY3R1cmVyOiBDYW1i
cmlkZ2UgU2lsaWNvbiBSYWRpbyAoMTApCjIwMDktMDUtMjEgMDQ6MzU6MDQu
MzE1Mzg2ID4gSENJIEV2ZW50OiBJTyBDYXBhYmlsaXR5IFJlc3BvbnNlICgw
eDMyKSBwbGVuIDkKICAgIGJkYWRkciAwMDo4MDo5ODpFNzozMjoyQSBjYXBh
YmlsaXR5IDB4MDEgb29iIDB4MDAgYXV0aCAweDAyCiAgICBDYXBhYmlsaXR5
OiBEaXNwbGF5WWVzTm8gKE9PQiBkYXRhIG5vdCBwcmVzZW50KQogICAgQXV0
aGVudGljYXRpb246IERlZGljYXRlZCBCb25kaW5nIChObyBNSVRNIFByb3Rl
Y3Rpb24pCjIwMDktMDUtMjEgMDQ6MzU6MDUuMDAyMzgxID4gSENJIEV2ZW50
OiBVc2VyIENvbmZpcm1hdGlvbiBSZXF1ZXN0ICgweDMzKSBwbGVuIDEwCiAg
ICBiZGFkZHIgMDA6ODA6OTg6RTc6MzI6MkEgcGFzc2tleSAyNDU3MjkKMjAw
OS0wNS0yMSAwNDozNTowOC40MzEzODggPiBIQ0kgRXZlbnQ6IElucXVpcnkg
Q29tcGxldGUgKDB4MDEpIHBsZW4gMQogICAgc3RhdHVzIDB4MDAKMjAwOS0w
NS0yMSAwNDozNTozNS40NjkzOTggPiBIQ0kgRXZlbnQ6IFNpbXBsZSBQYWly
aW5nIENvbXBsZXRlICgweDM2KSBwbGVuIDcKICAgIHN0YXR1cyAweDA1IGJk
YWRkciAwMDo4MDo5ODpFNzozMjoyQQogICAgRXJyb3I6IEF1dGhlbnRpY2F0
aW9uIEZhaWx1cmUKMjAwOS0wNS0yMSAwNDozNTozNS40NzEzOTMgPiBIQ0kg
RXZlbnQ6IEF1dGggQ29tcGxldGUgKDB4MDYpIHBsZW4gMwogICAgc3RhdHVz
IDB4MDUgaGFuZGxlIDIxCiAgICBFcnJvcjogQXV0aGVudGljYXRpb24gRmFp
bHVyZQoyMDA5LTA1LTIxIDA0OjM1OjM1LjQ3MTU1NyA8IEhDSSBDb21tYW5k
OiBVc2VyIENvbmZpcm1hdGlvbiBSZXF1ZXN0IE5lZ2F0aXZlIFJlcGx5ICgw
eDAxfDB4MDAyZCkgcGxlbiA2CiAgICBiZGFkZHIgMDA6ODA6OTg6RTc6MzI6
MkEKMjAwOS0wNS0yMSAwNDozNTozNy40NjgwODAgPCBIQ0kgQ29tbWFuZDog
RGlzY29ubmVjdCAoMHgwMXwweDAwMDYpIHBsZW4gMwogICAgaGFuZGxlIDIx
IHJlYXNvbiAweDEzCiAgICBSZWFzb246IFJlbW90ZSBVc2VyIFRlcm1pbmF0
ZWQgQ29ubmVjdGlvbgoyMDA5LTA1LTIxIDA0OjM1OjM3LjQ3MDM5MiA+IEhD
SSBFdmVudDogQ29tbWFuZCBTdGF0dXMgKDB4MGYpIHBsZW4gNAogICAgRGlz
Y29ubmVjdCAoMHgwMXwweDAwMDYpIHN0YXR1cyAweDAwIG5jbWQgMQoyMDA5
LTA1LTIxIDA0OjM1OjM3LjY1MjQwMiA+IEhDSSBFdmVudDogRGlzY29ubiBD
b21wbGV0ZSAoMHgwNSkgcGxlbiA0CiAgICBzdGF0dXMgMHgwMCBoYW5kbGUg
MjEgcmVhc29uIDB4MTYKICAgIFJlYXNvbjogQ29ubmVjdGlvbiBUZXJtaW5h
dGVkIGJ5IExvY2FsIEhvc3QKCg==

--0-1593178881-1242842188=:41529--
