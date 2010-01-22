Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 22 Jan 2010 18:12:58 +0800
Message-ID: <6aeb672b1001220212u518836fds5df2a7e3de8463bf@mail.gmail.com>
Subject: Kernel panic when handing Motorola S305 headset
From: Liang Bao <tim.bao@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary=001485e9a9e26178a3047dbe10f0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--001485e9a9e26178a3047dbe10f0
Content-Type: text/plain; charset=ISO-8859-1

Hello,

Recently we found an almost 100% reproducible issue when using
Motorola S305 stereo headset and Ubuntu 9.10. The Ubuntu system has
auto-update turned on and keeps up with the latest stable release. At
this point, the system is using:

bash$dpkg -l | grep bluez
ii  bluez                                      4.51-0ubuntu2
                   Bluetooth tools and daemons
ii  bluez-alsa                                 4.51-0ubuntu2
                   Bluetooth audio support
ii  bluez-compat                               4.51-0ubuntu2
                   BlueZ 3.x compatibility binaries
ii  bluez-cups                                 4.51-0ubuntu2
                   Bluetooth printer driver for CUPS
rc  bluez-gnome                                1.8-0ubuntu5
                   Bluetooth utilities for GNOME
ii  bluez-gstreamer                            4.51-0ubuntu2
                   Bluetooth GStreamer support
ii  bluez-hcidump                              1.42-1build1
                   Analyses Bluetooth HCI packets
ii  bluez-utils                                4.51-0ubuntu2
                   Transitional package

bash$uname -a
Linux wahoo 2.6.31-17-generic #54-Ubuntu SMP Thu Dec 10 16:20:31 UTC
2009 i686 GNU/Linux

The pattern to reproduce the issue is:
1. Pair the S305 headset from Ubuntu using the bluetooth icon in the
task bar, "Set up new device..."
2. In the "Bluetooth Preferences" screen, hit "Remove" button to
remove the paired S305.
3. Power off and then power on S305.
4. The S305 will try to connect and get a negative link key reply.
You'll see the PIN input dialog flash away quickly because after the
negative reply, the LMP link is detached.
5. After step 4, the S305 willl request again and this time you'll be
given the dialog to input the PIN. Put '0000' and you'll see the
desktop frozen. Keyboard, mouse, network ... everything is down.

This phenomenon is quite similar with what Lan Zhu described in last
September(see the end of this mail). Although Ubuntu does't record the
panic dump by default, we did some analysis based on the hcidump log
and the sniffer log. Here's our thought.

The S305 is a stereo headset which supports both A2DP and HFP. When I
power cycle it in step 3, it will try to connect but as the Ubuntu
system has removed it from paired list, connection will fail as
mentioned in step 4 above(see the packets at line 74-115 in the
attached log).

After that, the S305 will try again to initiate a pair, which can be
reflected by messages from line 116 to 164. You can find pair succeeds
and encryption starts.

Then comes our weird thing. The S305 seems remember the capability of
the Ubuntu system and directly try to connect AVDTP and SDP almost at
the same time(line 165,166,172,173). For both L2CAP connection
request, the Ubuntu system responds with "connection pending"(167-169
and 174-176). Shortly the channel for SDP is ready(line 190-192) and
an "authentication pending" response is sent to the headset (line
193-195) for the pending AVDTP connection request. After that the
desktop freezes and network interfaces(I mean ssh here) is down, which
I believe kernel panic happens at this point. The only thing I can do
is to press the power button on the PC case.

With the Droid+S305 problemthat Lan Zhu mentioned in his mail, I
checked into the kernel code carefully. I admit that I can't
understand the kernel part well and therefore below is just my guess.
I'd like to share to see if it can help. The two L2CAP connection
arrive in a quite short interval. These two requests are put into a
link list by bt_accept_enqueue() and l2cap_do_start() will send out
L2CAP_INFO_REQ for both. If the SDP connection is accepted first,
bt_accept_dequeue() will remove it from the link list. This probably
caused the AVDTP entry has its parent as NULL. When AVDTP connection
is accepted in a while, l2cap_conn_start() will run into problem here
becuse the AVDTP is deferred too:

				if (bt_sk(sk)->defer_setup) {
					struct sock *parent = bt_sk(sk)->parent;
					rsp.result = cpu_to_le16(L2CAP_CR_PEND);
					rsp.status = cpu_to_le16(L2CAP_CS_AUTHOR_PEND);
					parent->sk_data_ready(parent, 0);

				}

Again, this is still my guess and could be in wrong direction.
However, the issue is quite easy to be reproduced with the combination
of S305 and Ubuntu 9.10(at least the versions I mentioned above). Is
this also a kind of race condition happening with those weird devices
try to make L2CAP connections simultaneously instead of one by one?
Could someone suggest a fix to prevent the kernel panic in this
scenario?

BTW, the SDP record of my Ubuntu system is listed here.

bash$sdptool records local
Service Name: BlueZ PANU service
Service Description: BlueZ PAN service
Service RecHandle: 0x10000
Service Class ID List:
  "PAN User" (0x1115)
Protocol Descriptor List:
  "L2CAP" (0x0100)
    PSM: 15
  "BNEP" (0x000f)
    Version: 0x0100
    SEQ16: 800 806
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "PAN User" (0x1115)
    Version: 0x0100

Service Name: BlueZ GN service
Service Description: BlueZ PAN service
Service RecHandle: 0x10001
Service Class ID List:
  "PAN Group Network" (0x1117)
Protocol Descriptor List:
  "L2CAP" (0x0100)
    PSM: 15
  "BNEP" (0x000f)
    Version: 0x0100
    SEQ16: 800 806
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "PAN Group Network" (0x1117)
    Version: 0x0100

Service Name: BlueZ NAP service
Service Description: BlueZ PAN service
Service RecHandle: 0x10002
Service Class ID List:
  "Network Access Point" (0x1116)
Protocol Descriptor List:
  "L2CAP" (0x0100)
    PSM: 15
  "BNEP" (0x000f)
    Version: 0x0100
    SEQ16: 800 806
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "Network Access Point" (0x1116)
    Version: 0x0100

Service Name: Headset Audio Gateway
Service RecHandle: 0x10003
Service Class ID List:
  "Headset Audio Gateway" (0x1112)
  "Generic Audio" (0x1203)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 12
Profile Descriptor List:
  "Headset" (0x1108)
    Version: 0x0102

Service Name: Hands-Free Audio Gateway
Service RecHandle: 0x10004
Service Class ID List:
  "Handsfree Audio Gateway" (0x111f)
  "Generic Audio" (0x1203)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 13
Profile Descriptor List:
  "Handsfree" (0x111e)
    Version: 0x0105

Service Name: Audio Source
Service RecHandle: 0x10005
Service Class ID List:
  "Audio Source" (0x110a)
Protocol Descriptor List:
  "L2CAP" (0x0100)
    PSM: 25
  "AVDTP" (0x0019)
    uint16: 0x100
Profile Descriptor List:
  "Advanced Audio" (0x110d)
    Version: 0x0100

Service Name: AVRCP TG
Service RecHandle: 0x10006
Service Class ID List:
  "AV Remote Target" (0x110c)
Protocol Descriptor List:
  "L2CAP" (0x0100)
    PSM: 23
  "AVCTP" (0x0017)
    uint16: 0x100
Profile Descriptor List:
  "AV Remote" (0x110e)
    Version: 0x0100

Service Name: AVRCP CT
Service RecHandle: 0x10007
Service Class ID List:
  "AV Remote" (0x110e)
Protocol Descriptor List:
  "L2CAP" (0x0100)
    PSM: 23
  "AVCTP" (0x0017)
    uint16: 0x100
Profile Descriptor List:
  "AV Remote" (0x110e)
    Version: 0x0100

From: Lan Zhu <zhu.lan.cn@...>
Subject: Re: null pointer error in bluez kernel
Newsgroups: gmane.linux.bluez.kernel
Date: 2009-10-13 02:13:18 GMT (14 weeks, 3 days, 7 hours and 50 minutes ago)

Hi Marcel,

>
> Reproduce steps:
> 1. Pair and connect with Motorola S305 headset.
> 2. Disconnect and unpair with the headset.
> 3. Turn off and then turn on the headset. The headset will auto pair with phone.
> 4. Input PIN code "0000" on the phone to complete the incoming pairing.
>
> Repeat step 2-4 for many times, then kernel panic may happen right
> after step 4.
>
> From the kernel log, I found if the bt_accept_unlink() is called
> before l2cap_conn_start(), then panic will happen because in the
> bt_accept_unlink() function it set parent to NULL.
>
> Below is the call order  when the result is successful. We can see the
> parent is not NULL.
>
> [  190.162475] bt_accept_enqueue: parent ccda5298, sk cdb68920
> [  190.170104] bt_accept_enqueue: parent ccda5d10, sk cdf5cd90
> [  190.191223] l2cap_conn_start: conn cd14a320
> [  190.218719] l2cap_conn_start: conn cd14a320
> [  190.223480] l2cap_conn_start: @@@ in l2cap_conn_start --- sk =
> cdb68920, parent = ccda5298
> [  190.235565] bt_accept_unlink: sk cdb68920 state 6
>
> Below is the call order when the result is kernel panic.
> bt_accept_unlink is called first, then we can see the parent is NULL.
>
> [  238.188812] bt_accept_enqueue: parent ccda5298, sk ccf60040
> [  238.196350] bt_accept_enqueue: parent ccda5d10, sk cdf5c960
> [  238.217590] l2cap_conn_start: conn cd14a848
> [  238.223449] bt_accept_unlink: sk ccf60040 state 6
> [  238.229400] l2cap_sock_accept: new socket ccf60040
> [  238.245086] l2cap_conn_start: conn cd14a848
> [  238.249725] l2cap_conn_start: @@@ in l2cap_conn_start --- sk =
> ccf60040, parent = (null)
> [  238.258636] Unable to handle kernel NULL pointer dereference at
> virtual address 00000120
> [  238.267456] pgd = cdb34000
> [  238.270446] [00000120] *pgd=8db32031, *pte=00000000, *ppte=00000000
> [  238.277740] Internal error: Oops: 17 [#1] PREEMPT
>

--001485e9a9e26178a3047dbe10f0
Content-Type: application/octet-stream;
	name="s305-panics-with-ubuntu.hcidump.log"
Content-Disposition: attachment;
	filename="s305-panics-with-ubuntu.hcidump.log"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g4qsyi5v0

ICAgICAgICBNZWRpYSBDb2RlYyAtIFNCQw0KICAgICAgICAgIDE2a0h6IDMya0h6IDQ0LjFrSHog
NDhrSHoNCiAgICAgICAgICBNb25vIER1YWxDaGFubmVsIFN0ZXJlbyBKb2ludFN0ZXJlbw0KICAg
ICAgICAgIDQgOCAxMiAxNiBCbG9ja3MNCiAgICAgICAgICA0IDggU3ViYmFuZHMNCiAgICAgICAg
ICBTTlIgTG91ZG5lc3MNCiAgICAgICAgICBCaXRwb29sIFJhbmdlIDItNTMNCiAgICAgICAgQ29u
dGVudCBQcm90ZWN0aW9uDQogICAgICAgICAgMDIgMDANCjIwMTAtMDEtMjIgMTY6NTE6MzcuMDAz
MTA5IDwgQUNMIGRhdGE6IGhhbmRsZSAxIGZsYWdzIDB4MDIgZGxlbiA3DQogICAgTDJDQVAoZCk6
IGNpZCAweDAwNDIgbGVuIDMgW3BzbSAyNV0NCiAgICAgIEFWRFRQKHMpOiBTdXNwZW5kIGNtZDog
dHJhbnNhY3Rpb24gMg0KICAgICAgICBBQ1AgU0VJRCAxDQoyMDEwLTAxLTIyIDE2OjUxOjM3LjAx
NjIwOCA+IEhDSSBFdmVudDogTnVtYmVyIG9mIENvbXBsZXRlZCBQYWNrZXRzICgweDEzKSBwbGVu
IDUNCiAgICBoYW5kbGUgMSBwYWNrZXRzIDENCjIwMTAtMDEtMjIgMTY6NTE6MzcuMDQxMjEzID4g
QUNMIGRhdGE6IGhhbmRsZSAxIGZsYWdzIDB4MDIgZGxlbiA2DQogICAgTDJDQVAoZCk6IGNpZCAw
eDAwNDEgbGVuIDIgW3BzbSAyNV0NCiAgICAgIEFWRFRQKHMpOiBTdXNwZW5kIHJzcDogdHJhbnNh
Y3Rpb24gMg0KMjAxMC0wMS0yMiAxNjo1MTozOC4wMDE0MjUgPCBBQ0wgZGF0YTogaGFuZGxlIDEg
ZmxhZ3MgMHgwMiBkbGVuIDEyDQogICAgTDJDQVAocyk6IERpc2Nvbm4gcmVxOiBkY2lkIDB4MDA0
NCBzY2lkIDB4MDA0Mg0KMjAxMC0wMS0yMiAxNjo1MTozOC4wMDE0NTAgPCBBQ0wgZGF0YTogaGFu
ZGxlIDEgZmxhZ3MgMHgwMiBkbGVuIDEyDQogICAgTDJDQVAocyk6IERpc2Nvbm4gcmVxOiBkY2lk
IDB4MDA0MiBzY2lkIDB4MDA0MQ0KMjAxMC0wMS0yMiAxNjo1MTozOC4wMjEyMTcgPiBIQ0kgRXZl
bnQ6IE51bWJlciBvZiBDb21wbGV0ZWQgUGFja2V0cyAoMHgxMykgcGxlbiA1DQogICAgaGFuZGxl
IDEgcGFja2V0cyAxDQoyMDEwLTAxLTIyIDE2OjUxOjM4LjAyMzIwNyA+IEhDSSBFdmVudDogTnVt
YmVyIG9mIENvbXBsZXRlZCBQYWNrZXRzICgweDEzKSBwbGVuIDUNCiAgICBoYW5kbGUgMSBwYWNr
ZXRzIDENCjIwMTAtMDEtMjIgMTY6NTE6MzguMDc3MjA4ID4gQUNMIGRhdGE6IGhhbmRsZSAxIGZs
YWdzIDB4MDIgZGxlbiAxMg0KICAgIEwyQ0FQKHMpOiBEaXNjb25uIHJzcDogZGNpZCAweDAwNDQg
c2NpZCAweDAwNDINCjIwMTAtMDEtMjIgMTY6NTE6MzguMTA1MjA3ID4gQUNMIGRhdGE6IGhhbmRs
ZSAxIGZsYWdzIDB4MDIgZGxlbiAxMg0KICAgIEwyQ0FQKHMpOiBEaXNjb25uIHJzcDogZGNpZCAw
eDAwNDIgc2NpZCAweDAwNDENCjIwMTAtMDEtMjIgMTY6NTE6NDIuMzMxMjE0ID4gQUNMIGRhdGE6
IGhhbmRsZSAxIGZsYWdzIDB4MDIgZGxlbiAxNg0KICAgIEwyQ0FQKHMpOiBDb25maWcgcmVxOiBk
Y2lkIDB4MDA0NCBmbGFncyAweDAwIGNsZW4gNA0KICAgICAgTVRVIDg5NQ0KMjAxMC0wMS0yMiAx
Njo1MTo0Mi4zMzEyMjUgPCBBQ0wgZGF0YTogaGFuZGxlIDEgZmxhZ3MgMHgwMiBkbGVuIDEwDQog
ICAgTDJDQVAocyk6IENvbW1hbmQgcmVqOiByZWFzb24gMA0KICAgICAgQ29tbWFuZCBub3QgdW5k
ZXJzdG9vZA0KMjAxMC0wMS0yMiAxNjo1MTo0Mi4zNTMyMDcgPiBIQ0kgRXZlbnQ6IE51bWJlciBv
ZiBDb21wbGV0ZWQgUGFja2V0cyAoMHgxMykgcGxlbiA1DQogICAgaGFuZGxlIDEgcGFja2V0cyAx
DQoyMDEwLTAxLTIyIDE2OjUxOjU1LjUxNTE0MSA8IEFDTCBkYXRhOiBoYW5kbGUgMSBmbGFncyAw
eDAyIGRsZW4gOA0KICAgIEwyQ0FQKGQpOiBjaWQgMHgwMDQxIGxlbiA0IFtwc20gM10NCiAgICAg
IFJGQ09NTShzKTogRElTQzogY3IgMCBkbGNpIDI2IHBmIDEgaWxlbiAwIGZjcyAweDY3DQoyMDEw
LTAxLTIyIDE2OjUxOjU1LjUyNTIxMyA+IEhDSSBFdmVudDogTnVtYmVyIG9mIENvbXBsZXRlZCBQ
YWNrZXRzICgweDEzKSBwbGVuIDUNCiAgICBoYW5kbGUgMSBwYWNrZXRzIDENCjIwMTAtMDEtMjIg
MTY6NTE6NTUuNTMwMjEwID4gQUNMIGRhdGE6IGhhbmRsZSAxIGZsYWdzIDB4MDIgZGxlbiA4DQog
ICAgTDJDQVAoZCk6IGNpZCAweDAwNDAgbGVuIDQgW3BzbSAzXQ0KICAgICAgUkZDT01NKHMpOiBV
QTogY3IgMCBkbGNpIDI2IHBmIDEgaWxlbiAwIGZjcyAweDRkDQoyMDEwLTAxLTIyIDE2OjUxOjU1
LjUzMDIzNCA8IEFDTCBkYXRhOiBoYW5kbGUgMSBmbGFncyAweDAyIGRsZW4gOA0KICAgIEwyQ0FQ
KGQpOiBjaWQgMHgwMDQxIGxlbiA0IFtwc20gM10NCiAgICAgIFJGQ09NTShzKTogRElTQzogY3Ig
MCBkbGNpIDAgcGYgMSBpbGVuIDAgZmNzIDB4OWMNCjIwMTAtMDEtMjIgMTY6NTE6NTUuNTM4MjEx
ID4gSENJIEV2ZW50OiBOdW1iZXIgb2YgQ29tcGxldGVkIFBhY2tldHMgKDB4MTMpIHBsZW4gNQ0K
ICAgIGhhbmRsZSAxIHBhY2tldHMgMQ0KMjAxMC0wMS0yMiAxNjo1MTo1NS41NDQyMDkgPiBBQ0wg
ZGF0YTogaGFuZGxlIDEgZmxhZ3MgMHgwMiBkbGVuIDgNCiAgICBMMkNBUChkKTogY2lkIDB4MDA0
MCBsZW4gNCBbcHNtIDNdDQogICAgICBSRkNPTU0ocyk6IFVBOiBjciAwIGRsY2kgMCBwZiAxIGls
ZW4gMCBmY3MgMHhiNg0KMjAxMC0wMS0yMiAxNjo1MTo1NS41NDQyMjggPCBBQ0wgZGF0YTogaGFu
ZGxlIDEgZmxhZ3MgMHgwMiBkbGVuIDEyDQogICAgTDJDQVAocyk6IERpc2Nvbm4gcmVxOiBkY2lk
IDB4MDA0MSBzY2lkIDB4MDA0MA0KMjAxMC0wMS0yMiAxNjo1MTo1NS41NTMyMDkgPiBIQ0kgRXZl
bnQ6IE51bWJlciBvZiBDb21wbGV0ZWQgUGFja2V0cyAoMHgxMykgcGxlbiA1DQogICAgaGFuZGxl
IDEgcGFja2V0cyAxDQoyMDEwLTAxLTIyIDE2OjUxOjU1LjU2NzIxMCA+IEFDTCBkYXRhOiBoYW5k
bGUgMSBmbGFncyAweDAyIGRsZW4gMTINCiAgICBMMkNBUChzKTogRGlzY29ubiByc3A6IGRjaWQg
MHgwMDQxIHNjaWQgMHgwMDQwDQoyMDEwLTAxLTIyIDE2OjUxOjU4LjAwMDExNiA8IEhDSSBDb21t
YW5kOiBEaXNjb25uZWN0ICgweDAxfDB4MDAwNikgcGxlbiAzDQogICAgaGFuZGxlIDEgcmVhc29u
IDB4MTMNCiAgICBSZWFzb246IFJlbW90ZSBVc2VyIFRlcm1pbmF0ZWQgQ29ubmVjdGlvbg0KMjAx
MC0wMS0yMiAxNjo1MTo1OC4wMDMyMDkgPiBIQ0kgRXZlbnQ6IENvbW1hbmQgU3RhdHVzICgweDBm
KSBwbGVuIDQNCiAgICBEaXNjb25uZWN0ICgweDAxfDB4MDAwNikgc3RhdHVzIDB4MDAgbmNtZCAx
DQoyMDEwLTAxLTIyIDE2OjUxOjU4LjEwMDIxMCA+IEhDSSBFdmVudDogRGlzY29ubiBDb21wbGV0
ZSAoMHgwNSkgcGxlbiA0DQogICAgc3RhdHVzIDB4MDAgaGFuZGxlIDEgcmVhc29uIDB4MTYNCiAg
ICBSZWFzb246IENvbm5lY3Rpb24gVGVybWluYXRlZCBieSBMb2NhbCBIb3N0DQoyMDEwLTAxLTIy
IDE2OjUyOjAwLjIxNTgxMCA8IEhDSSBDb21tYW5kOiBEZWxldGUgU3RvcmVkIExpbmsgS2V5ICgw
eDAzfDB4MDAxMikgcGxlbiA3DQogICAgYmRhZGRyIDAwOjBEOkZEOjJEOjM2OkUwIGFsbCAwDQoy
MDEwLTAxLTIyIDE2OjUyOjAwLjIxOTIwOSA+IEhDSSBFdmVudDogQ29tbWFuZCBDb21wbGV0ZSAo
MHgwZSkgcGxlbiA2DQogICAgRGVsZXRlIFN0b3JlZCBMaW5rIEtleSAoMHgwM3wweDAwMTIpIG5j
bWQgMQ0KICAgIHN0YXR1cyAweDAwIGRlbGV0ZWQgMA0KMjAxMC0wMS0yMiAxNjo1MjoxOC4xMjMy
MTIgPiBIQ0kgRXZlbnQ6IENvbm5lY3QgUmVxdWVzdCAoMHgwNCkgcGxlbiAxMA0KICAgIGJkYWRk
ciAwMDowRDpGRDoyRDozNjpFMCBjbGFzcyAweDI0MDQwNCB0eXBlIEFDTA0KMjAxMC0wMS0yMiAx
Njo1MjoxOC4xMjMyMjkgPCBIQ0kgQ29tbWFuZDogQWNjZXB0IENvbm5lY3Rpb24gUmVxdWVzdCAo
MHgwMXwweDAwMDkpIHBsZW4gNw0KICAgIGJkYWRkciAwMDowRDpGRDoyRDozNjpFMCByb2xlIDB4
MDANCiAgICBSb2xlOiBNYXN0ZXINCjIwMTAtMDEtMjIgMTY6NTI6MTguMTI3MjExID4gSENJIEV2
ZW50OiBDb21tYW5kIFN0YXR1cyAoMHgwZikgcGxlbiA0DQogICAgQWNjZXB0IENvbm5lY3Rpb24g
UmVxdWVzdCAoMHgwMXwweDAwMDkpIHN0YXR1cyAweDAwIG5jbWQgMQ0KMjAxMC0wMS0yMiAxNjo1
MjoxOC4yODcyMTMgPiBIQ0kgRXZlbnQ6IFJvbGUgQ2hhbmdlICgweDEyKSBwbGVuIDgNCiAgICBz
dGF0dXMgMHgwMCBiZGFkZHIgMDA6MEQ6RkQ6MkQ6MzY6RTAgcm9sZSAweDAwDQogICAgUm9sZTog
TWFzdGVyDQoyMDEwLTAxLTIyIDE2OjUyOjE4LjI5NTIxMiA+IEhDSSBFdmVudDogQ29ubmVjdCBD
b21wbGV0ZSAoMHgwMykgcGxlbiAxMQ0KICAgIHN0YXR1cyAweDAwIGhhbmRsZSAxIGJkYWRkciAw
MDowRDpGRDoyRDozNjpFMCB0eXBlIEFDTCBlbmNyeXB0IDB4MDANCjIwMTAtMDEtMjIgMTY6NTI6
MTguMjk1MjI0IDwgSENJIENvbW1hbmQ6IFJlYWQgUmVtb3RlIFN1cHBvcnRlZCBGZWF0dXJlcyAo
MHgwMXwweDAwMWIpIHBsZW4gMg0KICAgIGhhbmRsZSAxDQoyMDEwLTAxLTIyIDE2OjUyOjE4LjI5
ODIxMyA+IEhDSSBFdmVudDogQ29tbWFuZCBTdGF0dXMgKDB4MGYpIHBsZW4gNA0KICAgIFJlYWQg
UmVtb3RlIFN1cHBvcnRlZCBGZWF0dXJlcyAoMHgwMXwweDAwMWIpIHN0YXR1cyAweDAwIG5jbWQg
MQ0KMjAxMC0wMS0yMiAxNjo1MjoxOC4yOTgyMjYgPCBIQ0kgQ29tbWFuZDogUmVtb3RlIE5hbWUg
UmVxdWVzdCAoMHgwMXwweDAwMTkpIHBsZW4gMTANCiAgICBiZGFkZHIgMDA6MEQ6RkQ6MkQ6MzY6
RTAgbW9kZSAyIGNsa29mZnNldCAweDAwMDANCjIwMTAtMDEtMjIgMTY6NTI6MTguMzAxMjIwID4g
SENJIEV2ZW50OiBDb21tYW5kIFN0YXR1cyAoMHgwZikgcGxlbiA0DQogICAgUmVtb3RlIE5hbWUg
UmVxdWVzdCAoMHgwMXwweDAwMTkpIHN0YXR1cyAweDAwIG5jbWQgMQ0KMjAxMC0wMS0yMiAxNjo1
MjoxOC4zMTEyMjUgPiBIQ0kgRXZlbnQ6IE1heCBTbG90cyBDaGFuZ2UgKDB4MWIpIHBsZW4gMw0K
ICAgIGhhbmRsZSAxIHNsb3RzIDUNCjIwMTAtMDEtMjIgMTY6NTI6MTguMzIxMjE5ID4gSENJIEV2
ZW50OiBDb25uZWN0aW9uIFBhY2tldCBUeXBlIENoYW5nZWQgKDB4MWQpIHBsZW4gNQ0KICAgIHN0
YXR1cyAweDAwIGhhbmRsZSAxIHB0eXBlIDB4NjYwYw0KICAgIFBhY2tldCB0eXBlOiBETTEgRE0z
IERNNSAzLURIMSAzLURIMyAzLURINQ0KMjAxMC0wMS0yMiAxNjo1MjoxOC4zNTgyMTMgPiBIQ0kg
RXZlbnQ6IFJlYWQgUmVtb3RlIFN1cHBvcnRlZCBGZWF0dXJlcyAoMHgwYikgcGxlbiAxMQ0KICAg
IHN0YXR1cyAweDAwIGhhbmRsZSAxDQogICAgRmVhdHVyZXM6IDB4ZmYgMHhmZSAweDBmIDB4ODYg
MHg4YiAweGE5IDB4MDAgMHgwMA0KMjAxMC0wMS0yMiAxNjo1MjoxOC4zNzcyMTEgPiBIQ0kgRXZl
bnQ6IFJlbW90ZSBOYW1lIFJlcSBDb21wbGV0ZSAoMHgwNykgcGxlbiAyNTUNCiAgICBzdGF0dXMg
MHgwMCBiZGFkZHIgMDA6MEQ6RkQ6MkQ6MzY6RTAgbmFtZSAnTW90b3JvbGEgUzMwNScNCjIwMTAt
MDEtMjIgMTY6NTI6MTguNDA1MjEyID4gSENJIEV2ZW50OiBMaW5rIEtleSBSZXF1ZXN0ICgweDE3
KSBwbGVuIDYNCiAgICBiZGFkZHIgMDA6MEQ6RkQ6MkQ6MzY6RTANCjIwMTAtMDEtMjIgMTY6NTI6
MTguNDA1MzQyIDwgSENJIENvbW1hbmQ6IExpbmsgS2V5IFJlcXVlc3QgTmVnYXRpdmUgUmVwbHkg
KDB4MDF8MHgwMDBjKSBwbGVuIDYNCiAgICBiZGFkZHIgMDA6MEQ6RkQ6MkQ6MzY6RTANCjIwMTAt
MDEtMjIgMTY6NTI6MTguNDA5MjExID4gSENJIEV2ZW50OiBDb21tYW5kIENvbXBsZXRlICgweDBl
KSBwbGVuIDEwDQogICAgTGluayBLZXkgUmVxdWVzdCBOZWdhdGl2ZSBSZXBseSAoMHgwMXwweDAw
MGMpIG5jbWQgMQ0KICAgIHN0YXR1cyAweDAwIGJkYWRkciAwMDowRDpGRDoyRDozNjpFMA0KMjAx
MC0wMS0yMiAxNjo1MjoxOC40MTAyMTEgPiBIQ0kgRXZlbnQ6IFBJTiBDb2RlIFJlcXVlc3QgKDB4
MTYpIHBsZW4gNg0KICAgIGJkYWRkciAwMDowRDpGRDoyRDozNjpFMA0KMjAxMC0wMS0yMiAxNjo1
MjoxOC44NTIyMTIgPiBIQ0kgRXZlbnQ6IERpc2Nvbm4gQ29tcGxldGUgKDB4MDUpIHBsZW4gNA0K
ICAgIHN0YXR1cyAweDAwIGhhbmRsZSAxIHJlYXNvbiAweDEzDQogICAgUmVhc29uOiBSZW1vdGUg
VXNlciBUZXJtaW5hdGVkIENvbm5lY3Rpb24NCjIwMTAtMDEtMjIgMTY6NTI6MjQuNTIwMjE1ID4g
SENJIEV2ZW50OiBDb25uZWN0IFJlcXVlc3QgKDB4MDQpIHBsZW4gMTANCiAgICBiZGFkZHIgMDA6
MEQ6RkQ6MkQ6MzY6RTAgY2xhc3MgMHgyNDA0MDQgdHlwZSBBQ0wNCjIwMTAtMDEtMjIgMTY6NTI6
MjQuNTIwMjMzIDwgSENJIENvbW1hbmQ6IEFjY2VwdCBDb25uZWN0aW9uIFJlcXVlc3QgKDB4MDF8
MHgwMDA5KSBwbGVuIDcNCiAgICBiZGFkZHIgMDA6MEQ6RkQ6MkQ6MzY6RTAgcm9sZSAweDAwDQog
ICAgUm9sZTogTWFzdGVyDQoyMDEwLTAxLTIyIDE2OjUyOjI0LjUyNDIxMSA+IEhDSSBFdmVudDog
Q29tbWFuZCBTdGF0dXMgKDB4MGYpIHBsZW4gNA0KICAgIEFjY2VwdCBDb25uZWN0aW9uIFJlcXVl
c3QgKDB4MDF8MHgwMDA5KSBzdGF0dXMgMHgwMCBuY21kIDENCjIwMTAtMDEtMjIgMTY6NTI6MjQu
Njg1MjEzID4gSENJIEV2ZW50OiBSb2xlIENoYW5nZSAoMHgxMikgcGxlbiA4DQogICAgc3RhdHVz
IDB4MDAgYmRhZGRyIDAwOjBEOkZEOjJEOjM2OkUwIHJvbGUgMHgwMA0KICAgIFJvbGU6IE1hc3Rl
cg0KMjAxMC0wMS0yMiAxNjo1MjoyNC42OTIyMTIgPiBIQ0kgRXZlbnQ6IENvbm5lY3QgQ29tcGxl
dGUgKDB4MDMpIHBsZW4gMTENCiAgICBzdGF0dXMgMHgwMCBoYW5kbGUgMSBiZGFkZHIgMDA6MEQ6
RkQ6MkQ6MzY6RTAgdHlwZSBBQ0wgZW5jcnlwdCAweDAwDQoyMDEwLTAxLTIyIDE2OjUyOjI0LjY5
MjIyNSA8IEhDSSBDb21tYW5kOiBSZWFkIFJlbW90ZSBTdXBwb3J0ZWQgRmVhdHVyZXMgKDB4MDF8
MHgwMDFiKSBwbGVuIDINCiAgICBoYW5kbGUgMQ0KMjAxMC0wMS0yMiAxNjo1MjoyNC42OTUyMTQg
PiBIQ0kgRXZlbnQ6IENvbW1hbmQgU3RhdHVzICgweDBmKSBwbGVuIDQNCiAgICBSZWFkIFJlbW90
ZSBTdXBwb3J0ZWQgRmVhdHVyZXMgKDB4MDF8MHgwMDFiKSBzdGF0dXMgMHgwMCBuY21kIDENCjIw
MTAtMDEtMjIgMTY6NTI6MjQuNjk1MjI4IDwgSENJIENvbW1hbmQ6IFJlbW90ZSBOYW1lIFJlcXVl
c3QgKDB4MDF8MHgwMDE5KSBwbGVuIDEwDQogICAgYmRhZGRyIDAwOjBEOkZEOjJEOjM2OkUwIG1v
ZGUgMiBjbGtvZmZzZXQgMHgwMDAwDQoyMDEwLTAxLTIyIDE2OjUyOjI0LjY5ODIxNCA+IEhDSSBF
dmVudDogQ29tbWFuZCBTdGF0dXMgKDB4MGYpIHBsZW4gNA0KICAgIFJlbW90ZSBOYW1lIFJlcXVl
c3QgKDB4MDF8MHgwMDE5KSBzdGF0dXMgMHgwMCBuY21kIDENCjIwMTAtMDEtMjIgMTY6NTI6MjQu
NzA5MjE5ID4gSENJIEV2ZW50OiBNYXggU2xvdHMgQ2hhbmdlICgweDFiKSBwbGVuIDMNCiAgICBo
YW5kbGUgMSBzbG90cyA1DQoyMDEwLTAxLTIyIDE2OjUyOjI0LjcxOTIxNCA+IEhDSSBFdmVudDog
Q29ubmVjdGlvbiBQYWNrZXQgVHlwZSBDaGFuZ2VkICgweDFkKSBwbGVuIDUNCiAgICBzdGF0dXMg
MHgwMCBoYW5kbGUgMSBwdHlwZSAweDY2MGMNCiAgICBQYWNrZXQgdHlwZTogRE0xIERNMyBETTUg
My1ESDEgMy1ESDMgMy1ESDUNCjIwMTAtMDEtMjIgMTY6NTI6MjQuNzU1MjEzID4gSENJIEV2ZW50
OiBSZWFkIFJlbW90ZSBTdXBwb3J0ZWQgRmVhdHVyZXMgKDB4MGIpIHBsZW4gMTENCiAgICBzdGF0
dXMgMHgwMCBoYW5kbGUgMQ0KICAgIEZlYXR1cmVzOiAweGZmIDB4ZmUgMHgwZiAweDg2IDB4OGIg
MHhhOSAweDAwIDB4MDANCjIwMTAtMDEtMjIgMTY6NTI6MjQuNzc0MjExID4gSENJIEV2ZW50OiBS
ZW1vdGUgTmFtZSBSZXEgQ29tcGxldGUgKDB4MDcpIHBsZW4gMjU1DQogICAgc3RhdHVzIDB4MDAg
YmRhZGRyIDAwOjBEOkZEOjJEOjM2OkUwIG5hbWUgJ01vdG9yb2xhIFMzMDUnDQoyMDEwLTAxLTIy
IDE2OjUyOjI0LjgwMzIxMiA+IEhDSSBFdmVudDogTGluayBLZXkgUmVxdWVzdCAoMHgxNykgcGxl
biA2DQogICAgYmRhZGRyIDAwOjBEOkZEOjJEOjM2OkUwDQoyMDEwLTAxLTIyIDE2OjUyOjI0Ljgw
MzM0MSA8IEhDSSBDb21tYW5kOiBMaW5rIEtleSBSZXF1ZXN0IE5lZ2F0aXZlIFJlcGx5ICgweDAx
fDB4MDAwYykgcGxlbiA2DQogICAgYmRhZGRyIDAwOjBEOkZEOjJEOjM2OkUwDQoyMDEwLTAxLTIy
IDE2OjUyOjI0LjgwNzIxMSA+IEhDSSBFdmVudDogQ29tbWFuZCBDb21wbGV0ZSAoMHgwZSkgcGxl
biAxMA0KICAgIExpbmsgS2V5IFJlcXVlc3QgTmVnYXRpdmUgUmVwbHkgKDB4MDF8MHgwMDBjKSBu
Y21kIDENCiAgICBzdGF0dXMgMHgwMCBiZGFkZHIgMDA6MEQ6RkQ6MkQ6MzY6RTANCjIwMTAtMDEt
MjIgMTY6NTI6MjQuODA4MjEyID4gSENJIEV2ZW50OiBQSU4gQ29kZSBSZXF1ZXN0ICgweDE2KSBw
bGVuIDYNCiAgICBiZGFkZHIgMDA6MEQ6RkQ6MkQ6MzY6RTANCjIwMTAtMDEtMjIgMTY6NTI6MzEu
NTMxMTI4IDwgSENJIENvbW1hbmQ6IFBJTiBDb2RlIFJlcXVlc3QgUmVwbHkgKDB4MDF8MHgwMDBk
KSBwbGVuIDIzDQogICAgYmRhZGRyIDAwOjBEOkZEOjJEOjM2OkUwIGxlbiA0IHBpbiAnMDAwMCcN
CjIwMTAtMDEtMjIgMTY6NTI6MzEuNTM0MjEzID4gSENJIEV2ZW50OiBDb21tYW5kIENvbXBsZXRl
ICgweDBlKSBwbGVuIDEwDQogICAgUElOIENvZGUgUmVxdWVzdCBSZXBseSAoMHgwMXwweDAwMGQp
IG5jbWQgMQ0KICAgIHN0YXR1cyAweDAwIGJkYWRkciAwMDowRDpGRDoyRDozNjpFMA0KMjAxMC0w
MS0yMiAxNjo1MjozMS43OTQyMTIgPiBIQ0kgRXZlbnQ6IExpbmsgS2V5IE5vdGlmaWNhdGlvbiAo
MHgxOCkgcGxlbiAyMw0KICAgIGJkYWRkciAwMDowRDpGRDoyRDozNjpFMCBrZXkgQTcwQzVFN0VD
MTlDQTQwMEU1NTZFMTIxNjI2QjM1QjYgdHlwZSAwDQogICAgVHlwZTogQ29tYmluYXRpb24gS2V5
DQoyMDEwLTAxLTIyIDE2OjUyOjMxLjkxNjIxNSA+IEhDSSBFdmVudDogRW5jcnlwdCBDaGFuZ2Ug
KDB4MDgpIHBsZW4gNA0KICAgIHN0YXR1cyAweDAwIGhhbmRsZSAxIGVuY3J5cHQgMHgwMQ0KMjAx
MC0wMS0yMiAxNjo1MjozMS45MTgyMTQgPiBBQ0wgZGF0YTogaGFuZGxlIDEgZmxhZ3MgMHgwMiBk
bGVuIDEyDQogICAgTDJDQVAocyk6IENvbm5lY3QgcmVxOiBwc20gMjUgc2NpZCAweDAwNDENCjIw
MTAtMDEtMjIgMTY6NTI6MzEuOTE4MjI4IDwgQUNMIGRhdGE6IGhhbmRsZSAxIGZsYWdzIDB4MDIg
ZGxlbiAxNg0KICAgIEwyQ0FQKHMpOiBDb25uZWN0IHJzcDogZGNpZCAweDAwNDAgc2NpZCAweDAw
NDEgcmVzdWx0IDEgc3RhdHVzIDANCiAgICAgIENvbm5lY3Rpb24gcGVuZGluZyAtIE5vIGZ1dGhl
ciBpbmZvcm1hdGlvbiBhdmFpbGFibGUNCjIwMTAtMDEtMjIgMTY6NTI6MzEuOTE4MjMyIDwgQUNM
IGRhdGE6IGhhbmRsZSAxIGZsYWdzIDB4MDIgZGxlbiAxMA0KICAgIEwyQ0FQKHMpOiBJbmZvIHJl
cTogdHlwZSAyDQoyMDEwLTAxLTIyIDE2OjUyOjMxLjkyMjIxMyA+IEFDTCBkYXRhOiBoYW5kbGUg
MSBmbGFncyAweDAyIGRsZW4gMTINCiAgICBMMkNBUChzKTogQ29ubmVjdCByZXE6IHBzbSAxIHNj
aWQgMHgwMDQyDQoyMDEwLTAxLTIyIDE2OjUyOjMxLjkyMjIyNCA8IEFDTCBkYXRhOiBoYW5kbGUg
MSBmbGFncyAweDAyIGRsZW4gMTYNCiAgICBMMkNBUChzKTogQ29ubmVjdCByc3A6IGRjaWQgMHgw
MDQxIHNjaWQgMHgwMDQyIHJlc3VsdCAxIHN0YXR1cyAwDQogICAgICBDb25uZWN0aW9uIHBlbmRp
bmcgLSBObyBmdXRoZXIgaW5mb3JtYXRpb24gYXZhaWxhYmxlDQoyMDEwLTAxLTIyIDE2OjUyOjMx
LjkyMjIyNyA8IEFDTCBkYXRhOiBoYW5kbGUgMSBmbGFncyAweDAyIGRsZW4gMTANCiAgICBMMkNB
UChzKTogSW5mbyByZXE6IHR5cGUgMg0KMjAxMC0wMS0yMiAxNjo1MjozMS45MjMyMTMgPiBIQ0kg
RXZlbnQ6IE51bWJlciBvZiBDb21wbGV0ZWQgUGFja2V0cyAoMHgxMykgcGxlbiA1DQogICAgaGFu
ZGxlIDEgcGFja2V0cyAxDQoyMDEwLTAxLTIyIDE2OjUyOjMxLjkyNDIxMyA+IEhDSSBFdmVudDog
TnVtYmVyIG9mIENvbXBsZXRlZCBQYWNrZXRzICgweDEzKSBwbGVuIDUNCiAgICBoYW5kbGUgMSBw
YWNrZXRzIDENCjIwMTAtMDEtMjIgMTY6NTI6MzEuOTI2MjE0ID4gSENJIEV2ZW50OiBOdW1iZXIg
b2YgQ29tcGxldGVkIFBhY2tldHMgKDB4MTMpIHBsZW4gNQ0KICAgIGhhbmRsZSAxIHBhY2tldHMg
MQ0KMjAxMC0wMS0yMiAxNjo1MjozMS45MjcyMTMgPiBIQ0kgRXZlbnQ6IE51bWJlciBvZiBDb21w
bGV0ZWQgUGFja2V0cyAoMHgxMykgcGxlbiA1DQogICAgaGFuZGxlIDEgcGFja2V0cyAxDQoyMDEw
LTAxLTIyIDE2OjUyOjMxLjk2NDIxMyA+IEFDTCBkYXRhOiBoYW5kbGUgMSBmbGFncyAweDAyIGRs
ZW4gMTYNCiAgICBMMkNBUChzKTogSW5mbyByc3A6IHR5cGUgMiByZXN1bHQgMA0KICAgICAgRXh0
ZW5kZWQgZmVhdHVyZSBtYXNrIDB4MDAwMA0KMjAxMC0wMS0yMiAxNjo1MjozMS45NjQyMjIgPCBB
Q0wgZGF0YTogaGFuZGxlIDEgZmxhZ3MgMHgwMiBkbGVuIDE2DQogICAgTDJDQVAocyk6IENvbm5l
Y3QgcnNwOiBkY2lkIDB4MDA0MSBzY2lkIDB4MDA0MiByZXN1bHQgMCBzdGF0dXMgMA0KICAgICAg
Q29ubmVjdGlvbiBzdWNjZXNzZnVsDQoyMDEwLTAxLTIyIDE2OjUyOjMxLjk2NDIyNiA8IEFDTCBk
YXRhOiBoYW5kbGUgMSBmbGFncyAweDAyIGRsZW4gMTYNCiAgICBMMkNBUChzKTogQ29ubmVjdCBy
c3A6IGRjaWQgMHgwMDQwIHNjaWQgMHgwMDQxIHJlc3VsdCAxIHN0YXR1cyAxDQogICAgICBDb25u
ZWN0aW9uIHBlbmRpbmcgLSBBdXRoZW50aWNhdGlvbiBwZW5kaW5nDQoyMDEwLTAxLTIyIDE2OjUy
OjMxLjk2NDIzMCA8IEhDSSBDb21tYW5kOiBBdXRoZW50aWNhdGlvbiBSZXF1ZXN0ZWQgKDB4MDF8
MHgwMDExKSBwbGVuIDINCiAgICBoYW5kbGUgMQ0K
--001485e9a9e26178a3047dbe10f0--
