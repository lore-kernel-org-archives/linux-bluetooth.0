Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <5d6875a11001190753j58aef427v2205f50760bcd477@mail.gmail.com>
References: <5d6875a11001190753j58aef427v2205f50760bcd477@mail.gmail.com>
Date: Sun, 31 Jan 2010 17:36:57 +0300
Message-ID: <5d6875a11001310636y7ee7ee77o805b02c7f3d03c3d@mail.gmail.com>
Subject: Re: bluetoothd Permission denied (13) when connecting A2DP headset
From: Murz <murznn@gmail.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I have tested my  problem on Ubuntu 9.10 livecd and Fedora 12 livecd
and have the same "permission denied" error too!
Bluetooth device is Nokia BH-504, bluetooth adapter is CBR SL-45, detected as
Bus 002 Device 002: ID 1131:1004 Integrated System Solution Corp.
Bluetooth Device

I think that the problem is in bluez daemon.

I can successfully pair my computer with other bluetooth devices,
sends and receives files via blueman.
Bluetooth headset Nokia BH-504 successfully pairs with windows mobile,
nokia, sonyerricson, and other phones via a2dp, and I can transfer
sound to id.

But when connect via bluez - it successfully pair, but when try to
connect a2dp or headset I have "Permission denied (13)" error.

I have pair the computer with device, and grab the hcidump of connect process:

< HCI Command: Create Connection (0x01|0x0005) plen 13
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Connect Complete (0x03) plen 11
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
< HCI Command: Read RSSI (0x05|0x0005) plen 2
> HCI Event: Max Slots Change (0x1b) plen 3
> HCI Event: Command Complete (0x0e) plen 7
< HCI Command: Read Link Quality (0x05|0x0003) plen 2
> HCI Event: Command Complete (0x0e) plen 7
< HCI Command: Read Transmit Power Level (0x03|0x002d) plen 3
> HCI Event: Command Complete (0x0e) plen 7
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
> HCI Event: Read Remote Supported Features (0x0b) plen 11
< ACL data: handle 1 flags 0x02 dlen 10
   L2CAP(s): Info req: type 2
> HCI Event: Number of Completed Packets (0x13) plen 5
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
> ACL data: handle 1 flags 0x02 dlen 16
   L2CAP(s): Info rsp: type 2 result 0
     Extended feature mask 0x0000
< ACL data: handle 1 flags 0x02 dlen 12
   L2CAP(s): Connect req: psm 25 scid 0x0040
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 1 flags 0x02 dlen 16
   L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0040 result 1 status 2
     Connection pending - Authorization pending
> HCI Event: Remote Name Req Complete (0x07) plen 255
< HCI Command: Read RSSI (0x05|0x0005) plen 2
> HCI Event: Command Complete (0x0e) plen 7
< HCI Command: Read Link Quality (0x05|0x0003) plen 2
> HCI Event: Command Complete (0x0e) plen 7
< HCI Command: Read Transmit Power Level (0x03|0x002d) plen 3
> HCI Event: Command Complete (0x0e) plen 7
< HCI Command: Read RSSI (0x05|0x0005) plen 2
> HCI Event: Command Complete (0x0e) plen 7
< HCI Command: Read Link Quality (0x05|0x0003) plen 2
> HCI Event: Command Complete (0x0e) plen 7
< HCI Command: Read Transmit Power Level (0x03|0x002d) plen 3
> HCI Event: Command Complete (0x0e) plen 7
> HCI Event: Disconn Complete (0x05) plen 4

Please help me to debug or solve this problem!

On Tue, Jan 19, 2010 at 6:53 PM, Murz <murznn@gmail.com> wrote:
> I have using bluez 4.60-0ubuntu1 and blueman 1.21-1~ppa1k on Kubuntu 9.10 AMD64.
> My bluetooth dongle is USB:
> Bus 002 Device 002: ID 1131:1004 Integrated System Solution Corp.
> Bluetooth Device
>
> I can successfully pair computer with mobile phone (HTC Touch HD, WM
> 6.5.3), connect via serial (dialup) and send files via bluetooth to
> the device.
> I have a Nokia BH-504 headset. It successfully connects with mobile
> phone via A2DP and Headset profiles.
>
> But I can't connect it with bluez on computer!
>
> I try this on four computers, and on one fresh install of Kubuntu 9.10
> and always see the permission error!
>
> bluez see the headset, I can succesfully pair it with password "0000".
> But when I try connect to any service (A2DP or Headset), I see the
> error in /var/log/daemon.log:
> Jan 19 18:29:47 axe bluetoothd[22040]: Permission denied (13)
>
> If I run bluetoothd -n -d, on connect process I see:
> bluetoothd[22040]: avdtp_ref(0x7f6b42fa6c10): ref=2
> bluetoothd[22040]: stream creation in progress
> bluetoothd[22040]: adapter_get_device(00:22:FC:74:AA:3C)
> bluetoothd[22040]: Permission denied (13)
> bluetoothd[22040]: Disconnected from 00:22:FC:74:AA:3C
> bluetoothd[22040]: avdtp_unref(0x7f6b42fa6c10): ref=1
> bluetoothd[22040]: connect:connect XCASE detected
> bluetoothd[22040]: avdtp_unref(0x7f6b42fa6c10): ref=0
> bluetoothd[22040]: avdtp_unref(0x7f6b42fa6c10): freeing session and
> removing from list
> bluetoothd[22040]: Stream setup failed, after XCASE connect:connect
>
> bluetoothd is ran as root, blueman I try to ran as my user and as root too.
>
> Which permissions does bluetoothd needs to create this connection? How
> I can give they to him?
>
> I can give you any additional info about my system, please help me
> detect the problem!
>
