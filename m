Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: =?ISO-8859-1?Q?Tomas_Bj=F6rklund?= <tombjo@dd.chalmers.se>
To: bluez-users@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0502112202380.29873@frodo.dd.chalmers.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Subject: [Bluez-users] Re: Re: MS Optical Desktop Elite for BT; can"t reconnect after idle
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
Date: Fri, 11 Feb 2005 23:34:10 +0100 (MET)

Hi Marcel,
Wow, that's some fast reply. Thanks for caring! I hadn't joined the list
when you sent your reply (have now) so when I'm now replying I don't know
if my answer will show up as a new thread, sorry for that.

 >
 >is this the second version of Microsoft Bluetooth desktop? Is yes, is
 >the transceiver working?
 >
 >Show us the output of "hciconfig -a" and check with "sdptool" for the
 >service record of HID. Run "hcidump -x" while it disconnects.

Yes it's the second version. As I see it the transciever seems to be
working (had to upgrade the kernel to 2.6.10 though). Except the mouse an=
d
keyboard I have managed to recieve an image from my Sony Ericsson T630
cellphone via "Bluetooth File Sharing". The cellphone doesn't see any
services on the computer but that could very well be because I haven't
even tried configuring any yet.

A strange thing is that in /dev/input I get a few (1-2) keyboard entries
(which are not outputing anything when I 'cat' them) on top of the normal
keyboard and bluetooth-keyboard. These all are removed when the keyboard
goes into idle state.

To get the mouse and keyboard working I used the following steps (I
havn't touched any scipt- or configfiles yet except bluetooth/pin):
1. "hciconfig hci0 up"
2. Pressing the buttons underneath the mouse and keyboard for a few
seconds.
3. "hcitool scan"
4. "hidd --connect mAddr"
5. "hidd --connect kAddr"

In the use of hidd I feel quite lost. It seems to be living it's own life.
It can add devices by just searching for them and sometimes killall
doesn't kill all connections for example. So if I'm doing something wrong=
,
it might be there.

And to reconnect it after it becomes idle I repeat steps 2 though 5. OK,
that's the complete background, now over to the output you requested.

Didn't know exactly what you where looking for in sdptool so I am sending
the whole output. I strange thing I noticed when using hcidump was that
the scroll-wheel and the special buttons (not the left, scroll-wheel and
right buttons) only generated output when the mouse was in idle mode. The
extra keys (or the scroll-wheel) on the keyboard never generated any
output.

Sorry for the complete rambling, I just thought you might want to know
everything.

-Tomas

~# hciconfig -a
hci0:   Type: USB
        BD Address: 00:0D:3A:A3:08:DE ACL MTU: 377:10  SCO MTU: 16:0
        UP RUNNING PSCAN ISCAN
        RX bytes:793253 acl:58142 sco:0 events:376 errors:0
        TX bytes:3725 acl:158 sco:0 commands:67 errors:0
        Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy:
        Link mode: SLAVE ACCEPT
        Name: 'Broadcom BCM2035'
        Class: 0x000000
        Service Classes: Unspecified
        Device Class: Miscellaneous,
        HCI Ver: 1.2 (0x2) HCI Rev: 0x3 LMP Ver: 1.2 (0x2) LMP Subver: 0x=
800
        Manufacturer: Broadcom Corporation (15)

~# sdptool browse
Inquiring ...
Browsing 00:0D:3A:A2:D3:01 ...
Service RecHandle: 0x0
Service Class ID List:
  "SDP Server" (0x1000)
Protocol Descriptor List:
  "L2CAP" (0x0100)
    PSM: 1
  "SDP" (0x0001)
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "" (0x0100)
    Version: 0x0100

Service Name: Microsoft=C2=AE Keyboard Elite for Bluetooth=C2=AE
Service Description: A keyboard that runs over Bluetooth
Service Provider: Microsoft
Service RecHandle: 0x10000
Service Class ID List:
  "Human Interface Device" (0x1124)
Protocol Descriptor List:
  "L2CAP" (0x0100)
    PSM: 17
  "HIDP" (0x0011)
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "Human Interface Device" (0x1124)
    Version: 0x0100

Service RecHandle: 0x10001
Service Class ID List:
  "PnP Information" (0x1200)
Protocol Descriptor List:
  "L2CAP" (0x0100)
    PSM: 1
  "SDP" (0x0001)
Profile Descriptor List:
  "" (0x1200)
    Version: 0x0100

Browsing 00:0D:3A:A3:CC:73 ...
Service RecHandle: 0x0
Service Class ID List:
  "SDP Server" (0x1000)
Protocol Descriptor List:
  "L2CAP" (0x0100)
    PSM: 1
  "SDP" (0x0001)
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "" (0x0100)
    Version: 0x0100

Service Name: Microsoft=C2=AE IntelliMouse=C2=AE Explorer for Bluetooth=C2=
=AE
Service Description: Five Button Mouse
Service Provider: Microsoft
Service RecHandle: 0x10000
Service Class ID List:
  "Human Interface Device" (0x1124)
Protocol Descriptor List:
  "L2CAP" (0x0100)
    PSM: 17
  "HIDP" (0x0011)
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "Human Interface Device" (0x1124)
    Version: 0x0100

Service RecHandle: 0x10001
Service Class ID List:
  "PnP Information" (0x1200)
Protocol Descriptor List:
  "L2CAP" (0x0100)
    PSM: 1
  "SDP" (0x0001)
Profile Descriptor List:
  "" (0x1200)
    Version: 0x0100

~# hcidump -x
HCIDump - HCI packet analyzer ver 1.11
device: hci0 snap_len: 1028 filter: 0xffffffff
--Comment: Pressing a mousebutton-----
> ACL data: handle 0x0006 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 0]
      A1 02 01 00 00
> ACL data: handle 0x0006 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 0]
      A1 02 00 00 00
--Comment: Pressing the 'a'-key-----
> ACL data: handle 0x0007 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 0]
      A1 01 00 00 04 00 00 00 00 00
> ACL data: handle 0x0007 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 0]
      A1 01 00 00 00 00 00 00 00 00
---Comment: Mouse disconnecting-----
> ACL data: handle 0x0006 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0041 scid 0x0073
< ACL data: handle 0x0006 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0073
> ACL data: handle 0x0006 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0072
< ACL data: handle 0x0006 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0072
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 06 00 02 00
> HCI Event: Disconn Complete (0x05) plen 4
  00 06 00 16
--Comment: Keyboard disconnecting (a long time after the mouse)------
< ACL data: handle 0x0007 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0051 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 07 00 01 00
> ACL data: handle 0x0007 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0051 scid 0x0040
< ACL data: handle 0x0007 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0052 scid 0x0041
> ACL data: handle 0x0007 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0052 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 07 00 01 00
< HCI Command: Disconnect (0x01|0x0006) plen 3
  07 00 13
> HCI Event: Command Status (0x0f) plen 4
  00 01 06 04
> HCI Event: Disconn Complete (0x05) plen 4
  00 07 00 16
---Comment: Mousebutton pressed while disconnected----
> HCI Event: Connect Request (0x04) plen 10
  73 CC A3 3A 0D 00 80 25 00 01
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
  73 CC A3 3A 0D 00 01
> HCI Event: Command Status (0x0f) plen 4
  00 01 09 04
> HCI Event: Connect Complete (0x03) plen 11
  00 08 00 73 CC A3 3A 0D 00 01 00
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
  08 00 18 CC
> ACL data: handle 0x0008 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 17 scid 0x0075
> HCI Event: Command Status (0x0f) plen 4
  00 01 0F 04
< ACL data: handle 0x0008 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0075 result 2 status 0
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 08 00 01 00
> HCI Event: Max Slots Change (0x1b) plen 3
  08 00 03
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
  00 08 00 18 CC
> HCI Event: Disconn Complete (0x05) plen 4
  00 08 00 16
--Comment: Using the keyboard while disconnected gives nothing---


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
