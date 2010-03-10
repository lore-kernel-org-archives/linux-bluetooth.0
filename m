Return-Path: <cyrus@holtmann.org>
Date: Wed, 10 Mar 2010 17:35:12 +0100
From: Christian Birchinger <joker@netswarm.net>
To: linux-bluetooth@vger.kernel.org
Subject: Sixaxis paring and connection works, but no input data
Message-ID: <20100310163512.GA31661@netswarm.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello

I'm trying to use a SixAxis controller with bluez 4.61 and the cable
pairing patch. Pairing and connecting (PS press) fully works.

However i do not get any input data from the Sixaxis Pad no matter
what buttons i press or what axes i wiggle.

I see in the kernel log that the joystick got connected as BT HID
device and the device files get created and buttons and axes are
reported by jstest.

I noticed that bluez 4.61 doesn't have the sony_set_operational_bt
stuff anymore and applied a recently here posted kernel patch here
to compensate. I even added a printk to fully verify that function
gets executed when the BT HID device appears.

"Unpluging" works. I use the legacy hidd command with --unplug for
this. I only use this command for --show and --unplug and _NOT_
as a daemon of course.

I tried it on 2 different BT hosts. This one here was fully working
with old bluez 3.x with hidd hacks, so i doubt it's a bt hardware
dongle limitation. Controller works in USB mode and on a PS3 with
with bluetooth too. As i said, the hardware was working before.

Below are some infos that might be of interests.

Thanks a lot for your help
Christian Birchinger


--[ dmesg ]--------------------------------------------------------------------
input: PLAYSTATION(R)3 Controller as /devices/pci0000:00/0000:00:02.0/usb1/1-3/1-3.1/1-3.1:1.0/bluetooth/hci0/hci0:11/input44
generic-bluetooth 0005:054C:0268.002A: input: BLUETOOTH HID v0.00 Joystick [PLAYSTATION(R)3 Controller] on 00:16:38:3A:3E:DD
-------------------------------------------------------------------------------

--[ hidd --show ]---------------------------------------------------------------
00:23:06:C9:DE:69 PLAYSTATION(R)3 Controller [054c:0268] connected 
-------------------------------------------------------------------------------

--[ hcidump (PS button press)]-------------------------------------------------
HCI sniffer - Bluetooth packet analyzer ver 1.42
device: hci0 snap_len: 1028 filter: 0xffffffffffffffff
> HCI Event: Connect Request (0x04) plen 10
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Role Change (0x12) plen 8
> HCI Event: Connect Complete (0x03) plen 11
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Read Remote Supported Features (0x0b) plen 11
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 17 scid 0x0048
< ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0048 result 1 status 0
      Connection pending - No futher information available
< ACL data: handle 11 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
> HCI Event: Command Status (0x0f) plen 4
> ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x0000
< ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0048 result 0 status 0
      Connection successful
> HCI Event: Remote Name Req Complete (0x07) plen 255
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
< ACL data: handle 11 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0048 flags 0x00 result 0 clen 4
      MTU 672 
< ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0048 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 11 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 19 scid 0x0049
< ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0049 result 1 status 2
      Connection pending - Authorization pending
< ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0049 result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 11 flags 0x02 dlen 36
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 24
      QoS 0x02 (Guaranteed) 
< ACL data: handle 11 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0049 flags 0x00 result 0 clen 4
      MTU 672 
< ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0049 flags 0x00 clen 0
> ACL data: handle 11 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
> HCI Event: Number of Completed Packets (0x13) plen 5
-------------------------------------------------------------------------------

--[ hcidump (hidd --unplug)]---------------------------------
< ACL data: handle 11 flags 0x02 dlen 5
    L2CAP(d): cid 0x0048 len 1 [psm 17]
      HIDP: Control: Virtual cable unplug
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0041 scid 0x0049
< ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0049
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0048
< ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0048
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Disconn Complete (0x05) plen 4
-------------------------------------------------------------------------------

--[ jstest ]-------------------------------------------------------------------
Driver version is 2.1.0.
Joystick (PLAYSTATION(R)3 Controller) has 28 axes (X, Y, Z, Rz, (null), (null), (null), (null), (null), (null), (null), (null), (null), (null), (null), (null), (null), (null), (null), (null), (null), (null), (null), (null), (null), (null), (null), (null))
and 19 buttons (Trigger, ThumbBtn, ThumbBtn2, TopBtn, TopBtn2, PinkieBtn, BaseBtn, BaseBtn2, BaseBtn3, BaseBtn4, BaseBtn5, BaseBtn6, BtnDead, BtnA, BtnB, BtnC, BtnX, BtnY, BtnZ).
Testing ... (interrupt to exit)

Axes:  0:     0  1:     0  2:     0  3:     0  4:     0  5:     0  6:     0  7:     0  8:     0  9:     0 10:     0 11:     0 12:     0 13:     0 14:     0 15:     0 16:     0 17:     0 18:     0 19:     0 20:     0 21:     0 22:     0 23:     0 24:     0 25:     0 26:     0 27:     0 Buttons:  0:off  1:off  2:off  3:off  4:off  5:off  6:off  7:off  8:off  9:off 10:off 11:off 12:off 13:off 14:off 15:off 16:off 17:off 18:off 
Axes:  0:     0  1:     0  2:     0  3:     0  4:     0  5:     0  6:     0  7:     0  8:     0  9:     0 10:     0 11:     0 12:     0 13:     0 14:     0 15:     0 16:     0 17:     0 18:     0 19:     0 20:     0 21:     0 22:     0 23:     0 24:     0 25:     0 26:     0 27:     0 Buttons:  0:off  1:off  2:off  3:off  4:off  5:off  6:off  7:off  8:off  9:off 10:off 11:off 12:off 13:off 14:off 15:off 16:off 17:off 18:off 
Axes:  0:     0  1:     0  2:     0  3:     0  4:     0  5:     0  6:     0  7:     0  8:     0  9:     0 10:     0 11:     0 12:     0 13:     0 14:     0 15:     0 16:     0 17:     0 18:     0 19:     0 20:     0 21:     0 22:     0 23:     0 24:     0 25:     0 26:     0 27:     0 Buttons:  0:off  1:off  2:off  3:off  4:off  5:off  6:off  7:off  8:off  9:off 10:off 11:off 12:off 13:off 14:off 15:off 16:off 17:off 18:off 
Axes:  0:     0  1:     0  2:     0  3:     0  4:     0  5:     0  6:     0  7:     0  8:     0  9:     0 10:     0 11:     0 12:     0 13:     0 14:     0 15:     0 16:     0 17:     0 18:     0 19:     0 20:     0 21:     0 22:     0 23:     0 24:     0 25:     0 26:     0 27:     0 Buttons:  0:off  1:off  2:off  3:off  4:off  5:off  6:off  7:off  8:off  9:off 10:off 11:off 12:off 13:off 14:off 15:off 16:off 17:off 18:off 
Axes:  0:     0  1:     0  2:     0  3:     0  4:     0  5:     0  6:     0  7:     0  8:     0  9:     0 10:     0 11:     0 12:     0 13:     0 14:     0 15:     0 16:     0 17:     0 18:     0 19:     0 20:     0 21:     0 22:     0 23:     0 24:     0 25:     0 26:     0 27:     0 Buttons:  0:off  1:off  2:off  3:off  4:off  5:off  6:off  7:off  8:off  9:off 10:off 11:off 12:off 13:off 14:off 15:off 16:off 17:off 18:off 
Axes:  0:     0  1:     0  2:     0  3:     0  4:     0  5:     0  6:     0  7:     0  8:     0  9:     0 10:     0 11:     0 12:     0 13:     0 14:     0 15:     0 16:     0 17:     0 18:     0 19:     0 20:     0 21:     0 22:     0 23:     0 24:     0 25:     0 26:     0 27:     0 Buttons:  0:off  1:off  2:off  3:off  4:off  5:off  6:off  7:off  8:off  9:off 10:off 11:off 12:off 13:off 14:off 15:off 16:off 17:off 18:off 
Axes:  0:     0  1:     0  2:     0  3:     0  4:     0  5:     0  6:     0  7:     0  8:     0  9:     0 10:     0 11:     0 12:     0 13:     0 14:     0 15:     0 16:     0 17:     0 18:     0 19:     0 20:     0 21:     0 22:     0 23:     0 24:     0 25:     0 26:     0 27:     0 Buttons:  0:off  1:off  2:off  3:off  4:off  5:off  6:off  7:off  8:off  9:off 10:off 11:off 12:off 13:off 14:off 15:off 16:off 17:off 18:off 
Axes:  0:     0  1:     0  2:     0  3:     0  4:     0  5:     0  6:     0  7:     0  8:     0  9:     0 10:     0 11:     0 12:     0 13:     0 14:     0 15:     0 16:     0 17:     0 18:     0 19:     0 20:     0 21:     0 22:     0 23:     0 24:     0 25:     0 26:     0 27:     0 Buttons:  0:off  1:off  2:off  3:off  4:off  5:off  6:off  7:off  8:off  9:off 10:off 11:off 12:off 13:off 14:off 15:off 16:off 17:off 18:off 
Axes:  0:     0  1:     0  2:     0  3:     0  4:     0  5:     0  6:     0  7:     0  8:     0  9:     0 10:     0 11:     0 12:     0 13:     0 14:     0 15:     0 16:     0 17:     0 18:     0 19:     0 20:     0 21:     0 22:     0 23:     0 24:     0 25:     0 26:     0 27:     0 Buttons:  0:off  1:off  2:off  3:off  4:off  5:off  6:off  7:off  8:off  9:off 10:off 11:off 12:off 13:off 14:off 15:off 16:off 17:off 18:off 
Axes:  0:     0  1:     0  2:     0  3:     0  4:     0  5:     0  6:     0  7:     0  8:     0  9:     0 10:     0 11:     0 12:     0 13:     0 14:     0 15:     0 16:     0 17:     0 18:     0 19:     0 20:     0 21:     0 22:     0 23:     0 24:     0 25:     0 26:     0 27:     0 Buttons:  0:off  1:off  2:off  3:off  4:off  5:off  6:off  7:off  8:off  9:off 10:off 11:off 12:off 13:off 14:off 15:off 16:off 17:off 18:off 
Axes:  0:     0  1:     0  2:     0  3:     0  4:     0  5:     0  6:     0  7:     0  8:     0  9:     0 10:     0 11:     0 12:     0 13:     0 14:     0 15:     0 16:     0 17:     0 18:     0 19:     0 20:     0 21:     0 22:     0 23:     0 24:     0 25:     0 26:     0 27:     0 Buttons:  0:off  1:off  2:off  3:off  4:off  5:off  6:off  7:off  8:off  9:off 10:off 11:off 12:off 13:off 14:off 15:off 16:off 17:off 18:off 
Axes:  0:     0  1:     0  2:     0  3:     0  4:     0  5:     0  6:     0  7:     0  8:     0  9:     0 10:     0 11:     0 12:     0 13:     0 14:     0 15:     0 16:     0 17:     0 18:     0 19:     0 20:     0 21:     0 22:     0 23:     0 24:     0 25:     0 26:     0 27:     0 Buttons:  0:off  1:off  2:off  3:off  4:off  5:off  6:off  7:off  8:off  9:off 10:off 11:off 12:off 13:off 14:off 15:off 16:off 17:off 18:off 
Axes:  0:     0  1:     0  2:     0  3:     0  4:     0  5:     0  6:     0  7:     0  8:     0  9:     0 10:     0 11:     0 12:     0 13:     0 14:     0 15:     0 16:     0 17:     0 18:     0 19:     0 20:     0 21:     0 22:     0 23:     0 24:     0 25:     0 26:     0 27:     0 Buttons:  0:off  1:off  2:off  3:off  4:off  5:off  6:off  7:off  8:off  9:off 10:off 11:off 12:off 13:off 14:off 15:off 16:off 17:off 18:off 
Axes:  0:     0  1:     0  2:     0  3:     0  4:     0  5:     0  6:     0  7:     0  8:     0  9:     0 10:     0 11:     0 12:     0 13:     0 14:     0 15:     0 16:     0 17:     0 18:     0 19:     0 20:     0 21:     0 22:     0 23:     0 24:     0 25:     0 26:     0 27:     0 Buttons:  0:off  1:off  2:off  3:off  4:off  5:off  6:off  7:off  8:off  9:off 10:off 11:off 12:off 13:off 14:off 15:off 16:off 17:off 18:off 
Axes:  0:     0  1:     0  2:     0  3:     0  4:     0  5:     0  6:     0  7:     0  8:     0  9:     0 10:     0 11:     0 12:     0 13:     0 14:     0 15:     0 16:     0 17:     0 18:     0 19:     0 20:     0 21:     0 22:     0 23:     0 24:     0 25:     0 26:     0 27:     0 Buttons:  0:off  1:off  2:off  3:off  4:off  5:off  6:off  7:off  8:off  9:off 10:off 11:off 12:off 13:off 14:off 15:off 16:off 17:off 18:off 
Axes:  0:     0  1:     0  2:     0  3:     0  4:     0  5:     0  6:     0  7:     0  8:     0  9:     0 10:     0 11:     0 12:     0 13:     0 14:     0 15:     0 16:     0 17:     0 18:     0 19:     0 20:     0 21:     0 22:     0 23:     0 24:     0 25:     0 26:     0 27:     0 Buttons:  0:off  1:off  2:off  3:off  4:off  5:off  6:off  7:off  8:off  9:off 10:off 11:off 12:off 13:off 14:off 15:off 16:off 17:off 18:off 
Axes:  0:     0  1:     0  2:     0  3:     0  4:     0  5:     0  6:     0  7:     0  8:     0  9:     0 10:     0 11:     0 12:     0 13:     0 14:     0 15:     0 16:     0 17:     0 18:     0 19:     0 20:     0 21:     0 22:     0 23:     0 24:     0 25:     0 26:     0 27:     0 Buttons:  0:off  1:off  2:off  3:off  4:off  5:off  6:off  7:off  8:off  9:off 10:off 11:off 12:off 13:off 14:off 15:off 16:off 17:off 18:off 
Axes:  0:     0  1:     0  2:     0  3:     0  4:     0  5:     0  6:     0  7:     0  8:     0  9:     0 10:     0 11:     0 12:     0 13:     0 14:     0 15:     0 16:     0 17:     0 18:     0 19:     0 20:     0 21:     0 22:     0 23:     0 24:     0 25:     0 26:     0 27:     0 Buttons:  0:off  1:off  2:off  3:off  4:off  5:off  6:off  7:off  8:off  9:off 10:off 11:off 12:off 13:off 14:off 15:off 16:off 17:off 18:off 
Axes:  0:     0  1:     0  2:     0  3:     0  4:     0  5:     0  6:     0  7:     0  8:     0  9:     0 10:     0 11:     0 12:     0 13:     0 14:     0 15:     0 16:     0 17:     0 18:     0 19:     0 20:     0 21:     0 22:     0 23:     0 24:     0 25:     0 26:     0 27:     0 Buttons:  0:off  1:off  2:off  3:off  4:off  5:off  6:off  7:off  8:off  9:off 10:off 11:off 12:off 13:off 14:off 15:off 16:off 17:off 18:off 
Axes:  0:-32767  1:     0  2:     0  3:     0  4:     0  5:     0  6:     0  7:     0  8:     0  9:     0 10:     0 11:     0 12:     0 13:     0 14:     0 15:     0 16:     0 17:     0 18:     0 19:     0 20:     0 21:     0 22:     0 23:     0 24:     0 25:     0 26:     0 27:     0 Buttons:  0:off  1:off  2:off  3:off  4:off  5:off  6:off  7:off  8:off  9:off 10:off 11:off 12:off 13:off 14:off 15:off 16:off 17:off 18:off 
Axes:  0:-32767  1:-32767  2:     0  3:     0  4:     0  5:     0  6:     0  7:     0  8:     0  9:     0 10:     0 11:     0 12:     0 13:     0 14:     0 15:     0 16:     0 17:     0 18:     0 19:     0 20:     0 21:     0 22:     0 23:     0 24:     0 25:     0 26:     0 27:     0 Buttons:  0:off  1:off  2:off  3:off  4:off  5:off  6:off  7:off  8:off  9:off 10:off 11:off 12:off 13:off 14:off 15:off 16:off 17:off 18:off 
Axes:  0:-32767  1:-32767  2:-32767  3:     0  4:     0  5:     0  6:     0  7:     0  8:     0  9:     0 10:     0 11:     0 12:     0 13:     0 14:     0 15:     0 16:     0 17:     0 18:     0 19:     0 20:     0 21:     0 22:     0 23:     0 24:     0 25:     0 26:     0 27:     0 Buttons:  0:off  1:off  2:off  3:off  4:off  5:off  6:off  7:off  8:off  9:off 10:off 11:off 12:off 13:off 14:off 15:off 16:off 17:off 18:off 
Axes:  0:-32767  1:-32767  2:-32767  3:-32767  4:     0  5:     0  6:     0  7:     0  8:     0  9:     0 10:     0 11:     0 12:     0 13:     0 14:     0 15:     0 16:     0 17:     0 18:     0 19:     0 20:     0 21:     0 22:     0 23:     0 24:     0 25:     0 26:     0 27:     0 Buttons:  0:off  1:off  2:off  3:off  4:off  5:off  6:off  7:off  8:off  9:off 10:off 11:off 12:off 13:off 14:off 15:off 16:off 17:off 18:off 
Axes:  0:-32767  1:-32767  2:-32767  3:-32767  4:-32767  5:     0  6:     0  7:     0  8:     0  9:     0 10:     0 11:     0 12:     0 13:     0 14:     0 15:     0 16:     0 17:     0 18:     0 19:     0 20:     0 21:     0 22:     0 23:     0 24:     0 25:     0 26:     0 27:     0 Buttons:  0:off  1:off  2:off  3:off  4:off  5:off  6:off  7:off  8:off  9:off 10:off 11:off 12:off 13:off 14:off 15:off 16:off 17:off 18:off 
Axes:  0:-32767  1:-32767  2:-32767  3:-32767  4:-32767  5:-32767  6:     0  7:     0  8:     0  9:     0 10:     0 11:     0 12:     0 13:     0 14:     0 15:     0 16:     0 17:     0 18:     0 19:     0 20:     0 21:     0 22:     0 23:     0 24:     0 25:     0 26:     0 27:     0 Buttons:  0:off  1:off  2:off  3:off  4:off  5:off  6:off  7:off  8:off  9:off 10:off 11:off 12:off 13:off 14:off 15:off 16:off 17:off 18:off 
Axes:  0:-32767  1:-32767  2:-32767  3:-32767  4:-32767  5:-32767  6:-32767  7:     0  8:     0  9:     0 10:     0 11:     0 12:     0 13:     0 14:     0 15:     0 16:     0 17:     0 18:     0 19:     0 20:     0 21:     0 22:     0 23:     0 24:     0 25:     0 26:     0 27:     0 Buttons:  0:off  1:off  2:off  3:off  4:off  5:off  6:off  7:off  8:off  9:off 10:off 11:off 12:off 13:off 14:off 15:off 16:off 17:off 18:off 
Axes:  0:-32767  1:-32767  2:-32767  3:-32767  4:-32767  5:-32767  6:-32767  7:-32767  8:     0  9:     0 10:     0 11:     0 12:     0 13:     0 14:     0 15:     0 16:     0 17:     0 18:     0 19:     0 20:     0 21:     0 22:     0 23:     0 24:     0 25:     0 26:     0 27:     0 Buttons:  0:off  1:off  2:off  3:off  4:off  5:off  6:off  7:off  8:off  9:off 10:off 11:off 12:off 13:off 14:off 15:off 16:off 17:off 18:off 
Axes:  0:-32767  1:-32767  2:-32767  3:-32767  4:-32767  5:-32767  6:-32767  7:-32767  8:-32767  9:     0 10:     0 11:     0 12:     0 13:     0 14:     0 15:     0 16:     0 17:     0 18:     0 19:     0 20:     0 21:     0 22:     0 23:     0 24:     0 25:     0 26:     0 27:     0 Buttons:  0:off  1:off  2:off  3:off  4:off  5:off  6:off  7:off  8:off  9:off 10:off 11:off 12:off 13:off 14:off 15:off 16:off 17:off 18:off 
Axes:  0:-32767  1:-32767  2:-32767  3:-32767  4:-32767  5:-32767  6:-32767  7:-32767  8:-32767  9:-32767 10:     0 11:     0 12:     0 13:     0 14:     0 15:     0 16:     0 17:     0 18:     0 19:     0 20:     0 21:     0 22:     0 23:     0 24:     0 25:     0 26:     0 27:     0 Buttons:  0:off  1:off  2:off  3:off  4:off  5:off  6:off  7:off  8:off  9:off 10:off 11:off 12:off 13:off 14:off 15:off 16:off 17:off 18:off 
Axes:  0:-32767  1:-32767  2:-32767  3:-32767  4:-32767  5:-32767  6:-32767  7:-32767  8:-32767  9:-32767 10:-32767 11:     0 12:     0 13:     0 14:     0 15:     0 16:     0 17:     0 18:     0 19:     0 20:     0 21:     0 22:     0 23:     0 24:     0 25:     0 26:     0 27:     0 Buttons:  0:off  1:off  2:off  3:off  4:off  5:off  6:off  7:off  8:off  9:off 10:off 11:off 12:off 13:off 14:off 15:off 16:off 17:off 18:off 
Axes:  0:-32767  1:-32767  2:-32767  3:-32767  4:-32767  5:-32767  6:-32767  7:-32767  8:-32767  9:-32767 10:-32767 11:-32767 12:     0 13:     0 14:     0 15:     0 16:     0 17:     0 18:     0 19:     0 20:     0 21:     0 22:     0 23:     0 24:     0 25:     0 26:     0 27:     0 Buttons:  0:off  1:off  2:off  3:off  4:off  5:off  6:off  7:off  8:off  9:off 10:off 11:off 12:off 13:off 14:off 15:off 16:off 17:off 18:off 
Axes:  0:-32767  1:-32767  2:-32767  3:-32767  4:-32767  5:-32767  6:-32767  7:-32767  8:-32767  9:-32767 10:-32767 11:-32767 12:-32767 13:     0 14:     0 15:     0 16:     0 17:     0 18:     0 19:     0 20:     0 21:     0 22:     0 23:     0 24:     0 25:     0 26:     0 27:     0 Buttons:  0:off  1:off  2:off  3:off  4:off  5:off  6:off  7:off  8:off  9:off 10:off 11:off 12:off 13:off 14:off 15:off 16:off 17:off 18:off 
Axes:  0:-32767  1:-32767  2:-32767  3:-32767  4:-32767  5:-32767  6:-32767  7:-32767  8:-32767  9:-32767 10:-32767 11:-32767 12:-32767 13:-32767 14:     0 15:     0 16:     0 17:     0 18:     0 19:     0 20:     0 21:     0 22:     0 23:     0 24:     0 25:     0 26:     0 27:     0 Buttons:  0:off  1:off  2:off  3:off  4:off  5:off  6:off  7:off  8:off  9:off 10:off 11:off 12:off 13:off 14:off 15:off 16:off 17:off 18:off 
Axes:  0:-32767  1:-32767  2:-32767  3:-32767  4:-32767  5:-32767  6:-32767  7:-32767  8:-32767  9:-32767 10:-32767 11:-32767 12:-32767 13:-32767 14:-32767 15:     0 16:     0 17:     0 18:     0 19:     0 20:     0 21:     0 22:     0 23:     0 24:     0 25:     0 26:     0 27:     0 Buttons:  0:off  1:off  2:off  3:off  4:off  5:off  6:off  7:off  8:off  9:off 10:off 11:off 12:off 13:off 14:off 15:off 16:off 17:off 18:off 
Axes:  0:-32767  1:-32767  2:-32767  3:-32767  4:-32767  5:-32767  6:-32767  7:-32767  8:-32767  9:-32767 10:-32767 11:-32767 12:-32767 13:-32767 14:-32767 15:-32767 16:     0 17:     0 18:     0 19:     0 20:     0 21:     0 22:     0 23:     0 24:     0 25:     0 26:     0 27:     0 Buttons:  0:off  1:off  2:off  3:off  4:off  5:off  6:off  7:off  8:off  9:off 10:off 11:off 12:off 13:off 14:off 15:off 16:off 17:off 18:off 
Axes:  0:-32767  1:-32767  2:-32767  3:-32767  4:-32767  5:-32767  6:-32767  7:-32767  8:-32767  9:-32767 10:-32767 11:-32767 12:-32767 13:-32767 14:-32767 15:-32767 16:-32767 17:     0 18:     0 19:     0 20:     0 21:     0 22:     0 23:     0 24:     0 25:     0 26:     0 27:     0 Buttons:  0:off  1:off  2:off  3:off  4:off  5:off  6:off  7:off  8:off  9:off 10:off 11:off 12:off 13:off 14:off 15:off 16:off 17:off 18:off 
Axes:  0:-32767  1:-32767  2:-32767  3:-32767  4:-32767  5:-32767  6:-32767  7:-32767  8:-32767  9:-32767 10:-32767 11:-32767 12:-32767 13:-32767 14:-32767 15:-32767 16:-32767 17:-32767 18:     0 19:     0 20:     0 21:     0 22:     0 23:     0 24:     0 25:     0 26:     0 27:     0 Buttons:  0:off  1:off  2:off  3:off  4:off  5:off  6:off  7:off  8:off  9:off 10:off 11:off 12:off 13:off 14:off 15:off 16:off 17:off 18:off 
Axes:  0:-32767  1:-32767  2:-32767  3:-32767  4:-32767  5:-32767  6:-32767  7:-32767  8:-32767  9:-32767 10:-32767 11:-32767 12:-32767 13:-32767 14:-32767 15:-32767 16:-32767 17:-32767 18:-32767 19:     0 20:     0 21:     0 22:     0 23:     0 24:     0 25:     0 26:     0 27:     0 Buttons:  0:off  1:off  2:off  3:off  4:off  5:off  6:off  7:off  8:off  9:off 10:off 11:off 12:off 13:off 14:off 15:off 16:off 17:off 18:off 
Axes:  0:-32767  1:-32767  2:-32767  3:-32767  4:-32767  5:-32767  6:-32767  7:-32767  8:-32767  9:-32767 10:-32767 11:-32767 12:-32767 13:-32767 14:-32767 15:-32767 16:-32767 17:-32767 18:-32767 19:-32767 20:     0 21:     0 22:     0 23:     0 24:     0 25:     0 26:     0 27:     0 Buttons:  0:off  1:off  2:off  3:off  4:off  5:off  6:off  7:off  8:off  9:off 10:off 11:off 12:off 13:off 14:off 15:off 16:off 17:off 18:off 
Axes:  0:-32767  1:-32767  2:-32767  3:-32767  4:-32767  5:-32767  6:-32767  7:-32767  8:-32767  9:-32767 10:-32767 11:-32767 12:-32767 13:-32767 14:-32767 15:-32767 16:-32767 17:-32767 18:-32767 19:-32767 20:-32767 21:     0 22:     0 23:     0 24:     0 25:     0 26:     0 27:     0 Buttons:  0:off  1:off  2:off  3:off  4:off  5:off  6:off  7:off  8:off  9:off 10:off 11:off 12:off 13:off 14:off 15:off 16:off 17:off 18:off 
Axes:  0:-32767  1:-32767  2:-32767  3:-32767  4:-32767  5:-32767  6:-32767  7:-32767  8:-32767  9:-32767 10:-32767 11:-32767 12:-32767 13:-32767 14:-32767 15:-32767 16:-32767 17:-32767 18:-32767 19:-32767 20:-32767 21:-32767 22:     0 23:     0 24:     0 25:     0 26:     0 27:     0 Buttons:  0:off  1:off  2:off  3:off  4:off  5:off  6:off  7:off  8:off  9:off 10:off 11:off 12:off 13:off 14:off 15:off 16:off 17:off 18:off 
Axes:  0:-32767  1:-32767  2:-32767  3:-32767  4:-32767  5:-32767  6:-32767  7:-32767  8:-32767  9:-32767 10:-32767 11:-32767 12:-32767 13:-32767 14:-32767 15:-32767 16:-32767 17:-32767 18:-32767 19:-32767 20:-32767 21:-32767 22:-32767 23:     0 24:     0 25:     0 26:     0 27:     0 Buttons:  0:off  1:off  2:off  3:off  4:off  5:off  6:off  7:off  8:off  9:off 10:off 11:off 12:off 13:off 14:off 15:off 16:off 17:off 18:off 
Axes:  0:-32767  1:-32767  2:-32767  3:-32767  4:-32767  5:-32767  6:-32767  7:-32767  8:-32767  9:-32767 10:-32767 11:-32767 12:-32767 13:-32767 14:-32767 15:-32767 16:-32767 17:-32767 18:-32767 19:-32767 20:-32767 21:-32767 22:-32767 23:-32767 24:     0 25:     0 26:     0 27:     0 Buttons:  0:off  1:off  2:off  3:off  4:off  5:off  6:off  7:off  8:off  9:off 10:off 11:off 12:off 13:off 14:off 15:off 16:off 17:off 18:off 
Axes:  0:-32767  1:-32767  2:-32767  3:-32767  4:-32767  5:-32767  6:-32767  7:-32767  8:-32767  9:-32767 10:-32767 11:-32767 12:-32767 13:-32767 14:-32767 15:-32767 16:-32767 17:-32767 18:-32767 19:-32767 20:-32767 21:-32767 22:-32767 23:-32767 24:-32767 25:     0 26:     0 27:     0 Buttons:  0:off  1:off  2:off  3:off  4:off  5:off  6:off  7:off  8:off  9:off 10:off 11:off 12:off 13:off 14:off 15:off 16:off 17:off 18:off 
Axes:  0:-32767  1:-32767  2:-32767  3:-32767  4:-32767  5:-32767  6:-32767  7:-32767  8:-32767  9:-32767 10:-32767 11:-32767 12:-32767 13:-32767 14:-32767 15:-32767 16:-32767 17:-32767 18:-32767 19:-32767 20:-32767 21:-32767 22:-32767 23:-32767 24:-32767 25:-32767 26:     0 27:     0 Buttons:  0:off  1:off  2:off  3:off  4:off  5:off  6:off  7:off  8:off  9:off 10:off 11:off 12:off 13:off 14:off 15:off 16:off 17:off 18:off 
Axes:  0:-32767  1:-32767  2:-32767  3:-32767  4:-32767  5:-32767  6:-32767  7:-32767  8:-32767  9:-32767 10:-32767 11:-32767 12:-32767 13:-32767 14:-32767 15:-32767 16:-32767 17:-32767 18:-32767 19:-32767 20:-32767 21:-32767 22:-32767 23:-32767 24:-32767 25:-32767 26:-32767 27:     0 Buttons:  0:off  1:off  2:off  3:off  4:off  5:off  6:off  7:off  8:off  9:off 10:off 11:off 12:off 13:off 14:off 15:off 16:off 17:off 18:off 
Axes:  0:-32767  1:-32767  2:-32767  3:-32767  4:-32767  5:-32767  6:-32767  7:-32767  8:-32767  9:-32767 10:-32767 11:-32767 12:-32767 13:-32767 14:-32767 15:-32767 16:-32767 17:-32767 18:-32767 19:-32767 20:-32767 21:-32767 22:-32767 23:-32767 24:-32767 25:-32767 26:-32767 27:-32767 Buttons:  0:off  1:off  2:off  3:off  4:off  5:off  6:off  7:off  8:off  9:off 10:off 11:off 12:off 13:off 14:off 15:off 16:off 17:off 18:off 
-------------------------------------------------------------------------------

--[ lsusb ]--------------------------------------------------------------------
Bus 001 Device 004: ID 0a5c:4500 Broadcom Corp. BCM2046B1 USB 2.0 Hub (part of BCM2046 Bluetooth)
-------------------------------------------------------------------------------

