Return-Path: <binch@mobilesoft.com.cn>
Subject: Re: [Bluez-users] how to recognize whether the connected device is
	a headset
From: Chen Bin <binch@mobilesoft.com.cn>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1098380504.4885.18.camel@pegasus>
References: <1098352217.1912.4.camel@debian>
	 <1098380504.4885.18.camel@pegasus>
Content-Type: text/plain; charset=gb2312
Message-Id: <1098407881.898.5.camel@debian>
Mime-Version: 1.0
Date: Fri, 22 Oct 2004 09:18:01 +0800
List-ID: <bluez-users.lists.sourceforge.net>

Hi Marcel,

Below is the infomation I got when I am connecting to a headset and
using 'sdptool browse 00:0D:18:02:4F:C0' to find out the service
provided by the headset:

binch@debian:/new/bt/mBluetooth$ sdptool browse 00:0D:18:02:4F:C0
Browsing 00:0D:18:02:4F:C0 ...
binch@debian:/new/bt/mBluetooth$ hcitool con
Connections:

BTW: I actually have connected to the headset because when I press some
key in the headset I can get some reaction on hcidump, I don't know
whether hcitool con can't see the connection.

The headset is DKH-03. Thanks in advance.

The log of hcidump:

HCIDump - HCI packet analyzer ver 1.10
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
  C0 4F 02 18 0D 00 18 CC 02 00 00 00 01
> HCI Event: Command Status (0x0f) plen 4
  00 01 05 04
> HCI Event: PIN Code Request (0x16) plen 6
  C0 4F 02 18 0D 00
< HCI Command: PIN Code Request Negative Reply (0x01|0x000e) plen 6
  C0 4F 02 18 0D 00
> HCI Event: Command Complete (0x0e) plen 10
  01 0E 04 00 C0 4F 02 18 0D 00
> HCI Event: Connect Complete (0x03) plen 11
  18 29 00 C0 4F 02 18 0D 00 01 00
< HCI Command: Write Scan Enable (0x03|0x001a) plen 1
  03
> HCI Event: Command Complete (0x0e) plen 4
  01 1A 0C 00
< HCI Command: Write Authentication Enable (0x03|0x0020) plen 1
  00
> HCI Event: Command Complete (0x0e) plen 4
  01 20 0C 00
< HCI Command: Write Authentication Enable (0x03|0x0020) plen 1
  00
> HCI Event: Command Complete (0x0e) plen 4
  01 20 0C 00
< HCI Command: Write Encryption Mode (0x03|0x0022) plen 1
  00
> HCI Event: Command Complete (0x0e) plen 4
  01 22 0C 00
< HCI Command: Write Class of Device (0x03|0x0024) plen 3
  00 01 00
> HCI Event: Command Complete (0x0e) plen 4
  01 24 0C 00
< HCI Command: Write Local Name (0x03|0x0013) plen 248
  4D 6F 62 69 6C 65 73 6F 66 74 20 28 30 29 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00
> HCI Event: Command Complete (0x0e) plen 4
  01 13 0C 00
< HCI Command: Create Connection (0x01|0x0005) plen 13
  C0 4F 02 18 0D 00 18 CC 02 00 00 00 01
> HCI Event: Command Status (0x0f) plen 4
  00 01 05 04
> HCI Event: PIN Code Request (0x16) plen 6
  C0 4F 02 18 0D 00
< HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
  C0 4F 02 18 0D 00 04 30 30 30 30 00 00 00 00 00 00 00 00 00
  00 00 00
> HCI Event: Command Complete (0x0e) plen 10
  01 0D 04 00 C0 4F 02 18 0D 00
> HCI Event: Link Key Notification (0x18) plen 23
  C0 4F 02 18 0D 00 7F EE 97 25 9C CB 7E 48 C1 20 A8 A9 15 A2
  62 4E 00
> HCI Event: Connect Complete (0x03) plen 11
  00 29 00 C0 4F 02 18 0D 00 01 00
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
  29 00 0F 00
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
  C0 4F 02 18 0D 00 01
> HCI Event: Command Complete (0x0e) plen 6
  01 0D 08 00 29 00
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
> ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0113 scid 0x0040 result 1 status 2
> ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0113 scid 0x0040 result 0 status 0
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0113 flags 0x0000 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 48
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0113 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0029 flags 0x02 dlen 24
    L2CAP(d): cid 0x0113 len 20 [psm 1]
        SDP SSA Req: tid 0x0 len 0xf
          pat uuid-16 0x1002 (PubBrwsGrp)
          max 0xffff
          aid(s) 0x0000 - 0xffff
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          cnt 0x2
          cont 00
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0113 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0113 scid 0x0040
< HCI Command: Disconnect (0x01|0x0006) plen 3
  29 00 13
> HCI Event: Command Status (0x0f) plen 4
  00 01 06 04
> HCI Event: Disconn Complete (0x05) plen 4
  00 29 00 16

Chen

在2004年10月22日的01:41，Marcel Holtmann写道：
> Hi Chen,
> 
> > Thanks very much for previous help from Holtman, and I happen a new
> > problem when I try to find out whether a connected device is a headset.
> > 
> > It can't be browsed using sdptool in both connected mode and discovery
> > mode(paring state), I wonder how I can know its charactics after
> > connected?
> 
> actually the class of device value can be inside the inquiry cache and
> you will see it when a remote device requests a connection. However we
> don't really store these information together with the connection to
> make them available afterwards. Any patch is welcome.
> 
> What I don't get is why you can't browse when the device is connected?
> Run "hcidump -X" as root and show it to us so we can see what happens.
> 
> > My phone  will be appeared in 3G conference next month, so I am very
> > anxious about the bluetooth feature...
> 
> What does this mean? Is it good or is it bad? And btw my first name is
> Marcel and not Holtmann.
> 
> Regards
> 
> Marcel
> 
> 
