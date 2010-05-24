Return-Path: <cyrus@holtmann.org>
Date: Mon, 24 May 2010 10:33:30 +0200
From: Christian Birchinger <joker@netswarm.net>
To: linux-bluetooth@vger.kernel.org
Subject: Auto trust entry remove
Message-ID: <20100524083330.GA18128@netswarm.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello

In another futile attempt to get a SixAxis controller working
i noticed that bluetoothd removes the trust entry that's needed
for that device to work.

It doesn't matter if i use some device management tool like blueman
or just add the entry directly before starting the daemon. The later
seems the less problematic way to make sure no external component
messes with the config.

I started bluetoothd in debug mode with -nd and it doesn't even and
it does this right after it does "HIDP: Control: Virtual cable unplug"
for a reason i don't know.

I only see in strace that it does this and after it the trusts
file is 0 bytes again:
open("/var/lib/bluetooth/... .../trusts", O_RDWR) = 23

I didn't get any input data before but at least i got it connect
and register it to the kernel as HID device before.

Is this auto-untrust by the bluetoothd itself something new?

This is a 2.6.34 kernel with bluez 4.64(+sixaxis cable patch).
It's a fresh installation but with known working hardware components.
The controller works and the USB dongle worked with it back in
the bluez 3.x days.

I'm thankfull for any hints. Below is a hcidump of the session
to the point where it self disconnects, resets trusts and then
gets a access denied because of it.

Bye, Christian



HCI sniffer - Bluetooth packet analyzer ver 1.42
device: hci0 snap_len: 1028 filter: 0xffffffffffffffff
< HCI Command: Disconnect (0x01|0x0006) plen 3
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Disconn Complete (0x05) plen 4
> HCI Event: Connect Request (0x04) plen 10
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Role Change (0x12) plen 8
> HCI Event: Connect Complete (0x03) plen 11
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Read Remote Supported Features (0x0b) plen 11
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
> HCI Event: Command Status (0x0f) plen 4
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 17 scid 0x00e0
< ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x00e0 result 1 status 0
      Connection pending - No futher information available
< ACL data: handle 11 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
> ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x0000
< ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x00e0 result 0 status 0
      Connection successful
> HCI Event: Remote Name Req Complete (0x07) plen 255
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
< ACL data: handle 11 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x00e0 flags 0x00 result 0 clen 4
      MTU 672 
< ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x00e0 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 11 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 11 flags 0x02 dlen 5
    L2CAP(d): cid 0x00e0 len 1 [psm 17]
      HIDP: Control: Virtual cable unplug
< ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x00e0 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 19 scid 0x00e1
< ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x00e1 result 1 status 2
      Connection pending - Authorization pending
< ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x00e1 result 0 status 0
      Connection successful
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x00e0 scid 0x0040
> ACL data: handle 11 flags 0x02 dlen 36
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 24
      QoS 0x02 (Guaranteed) 
< ACL data: handle 11 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x00e1 flags 0x00 result 0 clen 4
      MTU 672 
< ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x00e1 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 11 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x00e1 scid 0x0041
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0041 scid 0x00e1
< ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x00e1
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x00e1 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
< HCI Command: Disconnect (0x01|0x0006) plen 3
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Disconn Complete (0x05) plen 4
> HCI Event: Connect Request (0x04) plen 10
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Role Change (0x12) plen 8
> HCI Event: Connect Complete (0x03) plen 11
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Read Remote Supported Features (0x0b) plen 11
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
> HCI Event: Command Status (0x0f) plen 4
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 17 scid 0x00e2
< ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x00e2 result 1 status 0
      Connection pending - No futher information available
< ACL data: handle 11 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
> ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x0000
< ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x00e2 result 0 status 0
      Connection successful
> HCI Event: Remote Name Req Complete (0x07) plen 255
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
< ACL data: handle 11 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x00e2 flags 0x00 result 0 clen 4
      MTU 672 
< ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x00e2 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 11 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 11 flags 0x02 dlen 5
    L2CAP(d): cid 0x00e2 len 1 [psm 17]
      HIDP: Control: Virtual cable unplug
< ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x00e2 scid 0x0040
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 19 scid 0x00e3
< ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x00e3 result 1 status 2
      Connection pending - Authorization pending
< ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x00e3 result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x00e2 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 11 flags 0x02 dlen 36
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 24
      QoS 0x02 (Guaranteed) 
< ACL data: handle 11 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x00e3 flags 0x00 result 0 clen 4
      MTU 672 
< ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x00e3 flags 0x00 clen 0
> ACL data: handle 11 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x00e3 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x00e3 scid 0x0041
< HCI Command: Disconnect (0x01|0x0006) plen 3
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Disconn Complete (0x05) plen 4
> HCI Event: Connect Request (0x04) plen 10
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Role Change (0x12) plen 8
> HCI Event: Connect Complete (0x03) plen 11
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Read Remote Supported Features (0x0b) plen 11
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
> HCI Event: Command Status (0x0f) plen 4
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 17 scid 0x00e4
< ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x00e4 result 1 status 0
      Connection pending - No futher information available
< ACL data: handle 11 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
> ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x0000
< ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x00e4 result 0 status 0
      Connection successful
> HCI Event: Remote Name Req Complete (0x07) plen 255
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
< ACL data: handle 11 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x00e4 flags 0x00 result 0 clen 4
      MTU 672 
< ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x00e4 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 11 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 11 flags 0x02 dlen 5
    L2CAP(d): cid 0x00e4 len 1 [psm 17]
      HIDP: Control: Virtual cable unplug
< ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x00e4 scid 0x0040
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 19 scid 0x00e5
< ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x00e5 result 1 status 2
      Connection pending - Authorization pending
< ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x00e5 result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x00e4 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 11 flags 0x02 dlen 36
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 24
      QoS 0x02 (Guaranteed) 
< ACL data: handle 11 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x00e5 flags 0x00 result 0 clen 4
      MTU 672 
< ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x00e5 flags 0x00 clen 0
> ACL data: handle 11 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x00e5 scid 0x0041
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0041 scid 0x00e5
< ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x00e5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x00e5 scid 0x0041
< HCI Command: Disconnect (0x01|0x0006) plen 3
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Disconn Complete (0x05) plen 4
> HCI Event: Connect Request (0x04) plen 10
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Role Change (0x12) plen 8
> HCI Event: Connect Complete (0x03) plen 11
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Read Remote Supported Features (0x0b) plen 11
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
> HCI Event: Command Status (0x0f) plen 4
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 17 scid 0x00e6
< ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x00e6 result 1 status 0
      Connection pending - No futher information available
< ACL data: handle 11 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
> ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x0000
< ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x00e6 result 0 status 0
      Connection successful
> HCI Event: Remote Name Req Complete (0x07) plen 255
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
< ACL data: handle 11 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x00e6 flags 0x00 result 0 clen 4
      MTU 672 
< ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x00e6 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 11 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 11 flags 0x02 dlen 5
    L2CAP(d): cid 0x00e6 len 1 [psm 17]
      HIDP: Control: Virtual cable unplug
< ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x00e6 scid 0x0040
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 19 scid 0x00e7
< ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x00e7 result 1 status 2
      Connection pending - Authorization pending
< ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x00e7 result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x00e6 scid 0x0040
> ACL data: handle 11 flags 0x02 dlen 36
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 24
      QoS 0x02 (Guaranteed) 
< ACL data: handle 11 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x00e7 flags 0x00 result 0 clen 4
      MTU 672 
< ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x00e7 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 11 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x00e7 scid 0x0041
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x00e7 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
< HCI Command: Disconnect (0x01|0x0006) plen 3
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Disconn Complete (0x05) plen 4
> HCI Event: Connect Request (0x04) plen 10
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Role Change (0x12) plen 8
> HCI Event: Connect Complete (0x03) plen 11
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Read Remote Supported Features (0x0b) plen 11
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
> HCI Event: Command Status (0x0f) plen 4
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 17 scid 0x00e8
< ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x00e8 result 1 status 0
      Connection pending - No futher information available
< ACL data: handle 11 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
> ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x0000
< ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x00e8 result 0 status 0
      Connection successful
> HCI Event: Remote Name Req Complete (0x07) plen 255
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
< ACL data: handle 11 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x00e8 flags 0x00 result 0 clen 4
      MTU 672 
< ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x00e8 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 11 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 11 flags 0x02 dlen 5
    L2CAP(d): cid 0x00e8 len 1 [psm 17]
      HIDP: Control: Virtual cable unplug
< ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x00e8 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 19 scid 0x00e9
< ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x00e9 result 1 status 2
      Connection pending - Authorization pending
< ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x00e9 result 3 status 0
      Connection refused - security block
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x00e8 scid 0x0040
