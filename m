Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAPoRPAsObjOb23oh09cXFMNf-oN8ryTKamWKEfS+zX1JV0yZ-A@mail.gmail.com>
References: <CAPoRPAunSBGZPGPt9_T9kDsNM2M_JqoK3das76ST+Z-FfxLXUg@mail.gmail.com>
	<20140524063440.GA24167@t440s.P-661HNU-F1>
	<CAPoRPAt=Yr1oRPQn=7dJ18W9FCxOm_aEcw6ZBGUz1qA+1HwMMg@mail.gmail.com>
	<CAPoRPAsObjOb23oh09cXFMNf-oN8ryTKamWKEfS+zX1JV0yZ-A@mail.gmail.com>
Date: Mon, 2 Jun 2014 12:30:28 +0300
Message-ID: <CABBYNZ+FX1SHCbXsOkJUE1gbnR3sD15BQ7QH0oyn_f-nX_C0Lg@mail.gmail.com>
Subject: Re: Kernel 3.14.4, BlueZ 5.18 - Bluetooth keyboard - error updating
 services: Input/output error (5)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?UTF-8?Q?Magnus_Larsg=C3=A5rden?= <larsgarden@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Magnus,

On Mon, Jun 2, 2014 at 1:04 AM, Magnus Larsgården <larsgarden@gmail.com> wrote:
> Hi guys,
> Any thoughts regarding this issue? Is it some sort of user error, or could
> it be a real bug?
>
> Thanks
> /Magnus
>
>
>
> On Sat, May 24, 2014 at 1:37 PM, Magnus Larsgården <larsgarden@gmail.com> wrote:
>> Hej Johan,
>>
>> On Sat, May 24, 2014 at 8:34 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
>>> Hi Magnus,
>>>
>>> On Fri, May 23, 2014, Magnus Larsgården wrote:
>>>> The setup:
>>>> Raspberry Pi revB
>>>> OpenELEC 4.0.2 (Linux kernel 3.14.4)
>>>>
>>>> # /usr/lib/bluetooth/bluetoothd -v
>>>> 5.18
>>>>
>>>> # bluetoothctl -v
>>>> 5.18
>>>>
>>>> Bluetooth keyboard, Microsoft Wedge Keyboard
>>>>
>>>>
>>>> The problem:
>>>> The keyboard is detected, paired and connected, but after a couple of
>>>> seconds it gets disconnected.
>>>>
>>>> [bluetooth]# connect 7C:1E:52:18:7D:4F
>>>> Attempting to connect to 7C:1E:52:18:7D:4F
>>>> [CHG] Device 7C:1E:52:18:7D:4F Connected: yes
>>>> .... ~20 seconds pass.....
>>>> Failed to connect: org.bluez.Error.Failed
>>>> [CHG] Device 7C:1E:52:18:7D:4F Connected: no
>>>>
>>>> From bluetoothd:
>>>>
>>>> bluetoothd[513]: src/adapter.c:discovering_callback() hci0 type 1 discovering 0
>>>> bluetoothd[513]: src/adapter.c:trigger_start_discovery()
>>>> bluetoothd[513]: 7C:1E:52:18:7D:4F: error updating services:
>>>> Input/output error (5)
>>>> bluetoothd[513]: src/device.c:device_svc_resolved()
>>>> /org/bluez/hci0/dev_7C_1E_52_18_7D_4F err -5
>>>> bluetoothd[513]: src/adapter.c:dev_disconnected() Device
>>>> 7C:1E:52:18:7D:4F disconnected, reason 2
>>>> bluetoothd[513]: src/adapter.c:adapter_remove_connection()
>>>> bluetoothd[513]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr
>>>> 7C:1E:52:18:7D:4F type 0 status 0xe
>>>> bluetoothd[513]: src/device.c:device_bonding_complete() bonding (nil)
>>>> status 0x0e
>>>> bluetoothd[513]: src/device.c:device_bonding_failed() status 14
>>>> bluetoothd[513]: src/adapter.c:resume_discovery()
>>>>
>>>> I would appreciate any help here.
>>>
>>> It would help analyze the issue if you could provide HCI-level logs for
>>> the disconnection. You can accomplish this by running btmon -w <filename>
>>> while performing the use case.
>>>
>>> Johan
>>
>>
>> Unfortunately btmon is not included in the OpenELEC 4.0.2 distro.
>> However, hcidump is present. Will that work?
>>
>> Use case:
>>
>> 1. Start with Raspberry Pi powered on. Keyboard off.
>> 2. Turn keyboard on, and set it in "discovery mode"
>>
>> At this point I can see:
>>
>> bluetoothctl
>> [NEW] Controller 00:02:72:C4:9A:E4 OpenELEC [default]
>> [NEW] Device 7C:1E:52:18:7D:4F Microsoft Wedge Mobile Keyboard
>> [CHG] Device 7C:1E:52:18:7D:4F Class: 0x000540
>> [CHG] Device 7C:1E:52:18:7D:4F Icon: input-keyboard
>> [CHG] Device 7C:1E:52:18:7D:4F Connected: yes
>> [CHG] Device 7C:1E:52:18:7D:4F Connected: no
>>
>> and hcidump:
>>
>> HCI sniffer - Bluetooth packet analyzer ver 5.18
>> device: hci0 snap_len: 1500 filter: 0xffffffff
>>> HCI Event: Connect Request (0x04) plen 10
>>     bdaddr 7C:1E:52:18:7D:4F class 0x000540 type ACL
>> < HCI Command: Accept Connection Request (0x01|0x0009) plen 7
>>     bdaddr 7C:1E:52:18:7D:4F role 0x00
>>     Role: Master
>>> HCI Event: Command Status (0x0f) plen 4
>>     Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
>>> HCI Event: Role Change (0x12) plen 8
>>     status 0x00 bdaddr 7C:1E:52:18:7D:4F role 0x00
>>     Role: Master
>>> HCI Event: Connect Complete (0x03) plen 11
>>     status 0x00 handle 6 bdaddr 7C:1E:52:18:7D:4F type ACL encrypt 0x00
>> < HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
>>     handle 6
>>> HCI Event: Command Status (0x0f) plen 4
>>     Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
>> < HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
>>     handle 6 ptype 0xcc18
>>     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
>>> HCI Event: Command Status (0x0f) plen 4
>>     Change Connection Packet Type (0x01|0x000f) status 0x00 ncmd 1
>>> HCI Event: Read Remote Supported Features (0x0b) plen 11
>>     status 0x00 handle 6
>>     Features: 0xbc 0x06 0x86 0x78 0x18 0x1c 0x59 0x87
>> < HCI Command: Remote Name Request (0x01|0x0019) plen 10
>>     bdaddr 7C:1E:52:18:7D:4F mode 2 clkoffset 0x0000
>>> HCI Event: Command Status (0x0f) plen 4
>>     Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
>>> HCI Event: Connection Packet Type Changed (0x1d) plen 5
>>     status 0x34 handle 6 ptype 0x0008
>>     Error: Reserved Slot Violation
>>> ACL data: handle 6 flags 0x02 dlen 12
>>     L2CAP(s): Connect req: psm 17 scid 0x0040
>> < ACL data: handle 6 flags 0x02 dlen 16
>>     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 0
>>       Connection pending - No futher information available
>> < ACL data: handle 6 flags 0x02 dlen 10
>>     L2CAP(s): Info req: type 2
>>> HCI Event: Remote Name Req Complete (0x07) plen 255
>>     status 0x00 bdaddr 7C:1E:52:18:7D:4F name 'Microsoft Wedge Mobile Keyboard'
>>> ACL data: handle 6 flags 0x02 dlen 16
>>     L2CAP(s): Info rsp: type 2 result 0
>>       Extended feature mask 0x0280
>>         Fixed Channels
>>         Unicast Connectless Data Reception
>> < ACL data: handle 6 flags 0x02 dlen 10
>>     L2CAP(s): Info req: type 3
>>> ACL data: handle 6 flags 0x02 dlen 20
>>     L2CAP(s): Info rsp: type 3 result 0
>>       Fixed channel list 0x00000006
>>         L2CAP Signalling Channel
>>         L2CAP Connless
>> < ACL data: handle 6 flags 0x02 dlen 16
>>     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
>>       Connection successful
>> < ACL data: handle 6 flags 0x02 dlen 12
>>     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
>>> ACL data: handle 6 flags 0x02 dlen 16
>>     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
>>       MTU 48
>> < ACL data: handle 6 flags 0x02 dlen 18
>>     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
>>       MTU 48
>>> ACL data: handle 6 flags 0x02 dlen 14
>>     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
>>       Success
>>> ACL data: handle 6 flags 0x02 dlen 12
>>     L2CAP(s): Connect req: psm 19 scid 0x0041
>> < ACL data: handle 6 flags 0x02 dlen 16
>>     L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 1 status 2
>>       Connection pending - Authorization pending
>> < ACL data: handle 6 flags 0x02 dlen 5
>>     L2CAP(d): cid 0x0040 len 1 [psm 17]
>>       HIDP: Control: Virtual cable unplug
>> < ACL data: handle 6 flags 0x02 dlen 12
>>     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
>> < ACL data: handle 6 flags 0x02 dlen 16
>>     L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 3 status 0
>>       Connection refused - security block
>>> HCI Event: Disconn Complete (0x05) plen 4
>>     status 0x00 handle 6 reason 0x13
>>     Reason: Remote User Terminated Connection
>>
>>
>> 3. Try to manually connect to the keyboard.
>>
>> [bluetooth]# trust 7C:1E:52:18:7D:4F
>> Changing 7C:1E:52:18:7D:4F trust succeeded
>> [bluetooth]# pair 7C:1E:52:18:7D:4F
>> Attempting to pair with 7C:1E:52:18:7D:4F
>> Failed to pair: org.bluez.Error.AlreadyExists
>> [bluetooth]# connect 7C:1E:52:18:7D:4F
>> Attempting to connect to 7C:1E:52:18:7D:4F
>> [CHG] Device 7C:1E:52:18:7D:4F Connected: yes
>> [CHG] Device 7C:1E:52:18:7D:4F Paired: yes
>>
>> hcidump at this stage:
>>
>> < HCI Command: Create Connection (0x01|0x0005) plen 13
>>     bdaddr 7C:1E:52:18:7D:4F ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
>>     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
>>> HCI Event: Command Status (0x0f) plen 4
>>     Create Connection (0x01|0x0005) status 0x00 ncmd 1
>>> HCI Event: Connect Complete (0x03) plen 11
>>     status 0x00 handle 6 bdaddr 7C:1E:52:18:7D:4F type ACL encrypt 0x00
>> < HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
>>     handle 6
>>> HCI Event: Command Status (0x0f) plen 4
>>     Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
>>> HCI Event: Read Remote Supported Features (0x0b) plen 11
>>     status 0x00 handle 6
>>     Features: 0xbc 0x06 0x86 0x78 0x18 0x1c 0x59 0x87
>> < HCI Command: Remote Name Request (0x01|0x0019) plen 10
>>     bdaddr 7C:1E:52:18:7D:4F mode 2 clkoffset 0x0000
>> < ACL data: handle 6 flags 0x02 dlen 10
>>     L2CAP(s): Info req: type 2
>>> HCI Event: Command Status (0x0f) plen 4
>>     Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
>>> ACL data: handle 6 flags 0x02 dlen 16
>>     L2CAP(s): Info rsp: type 2 result 0
>>       Extended feature mask 0x0280
>>         Fixed Channels
>>         Unicast Connectless Data Reception
>> < ACL data: handle 6 flags 0x02 dlen 10
>>     L2CAP(s): Info req: type 3
>>> ACL data: handle 6 flags 0x02 dlen 20
>>     L2CAP(s): Info rsp: type 3 result 0
>>       Fixed channel list 0x00000006
>>         L2CAP Signalling Channel
>>         L2CAP Connless
>> < ACL data: handle 6 flags 0x02 dlen 12
>>     L2CAP(s): Connect req: psm 1 scid 0x0040
>>> ACL data: handle 6 flags 0x02 dlen 16
>>     L2CAP(s): Connect rsp: dcid 0x0042 scid 0x0040 result 0 status 0
>>       Connection successful
>> < ACL data: handle 6 flags 0x02 dlen 12
>>     L2CAP(s): Config req: dcid 0x0042 flags 0x00 clen 0
>>> HCI Event: Remote Name Req Complete (0x07) plen 255
>>     status 0x00 bdaddr 7C:1E:52:18:7D:4F name 'Microsoft Wedge Mobile Keyboard'
>>> ACL data: handle 6 flags 0x02 dlen 16
>>     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
>>       MTU 48
>> < ACL data: handle 6 flags 0x02 dlen 18
>>     L2CAP(s): Config rsp: scid 0x0042 flags 0x00 result 0 clen 4
>>       MTU 48
>>> ACL data: handle 6 flags 0x02 dlen 14
>>     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
>>       Success
>> < ACL data: handle 6 flags 0x02 dlen 24
>>     L2CAP(d): cid 0x0042 len 20 [psm 1]
>>         SDP SSA Req: tid 0x0 len 0xf
>>           pat uuid-16 0x0100 (L2CAP)
>>           max 65535
>>           aid(s) 0x0000 - 0xffff
>>           cont 00
>>> ACL data: handle 6 flags 0x02 dlen 27
>>> ACL data: handle 6 flags 0x01 dlen 25
>>     L2CAP(d): cid 0x0040 len 48 [psm 1]
>>         SDP SSA Rsp: tid 0x0 len 0x2b
>>           count 38
>>           cont 02 00 26
>> < ACL data: handle 6 flags 0x02 dlen 26
>>     L2CAP(d): cid 0x0042 len 22 [psm 1]
>>         SDP SSA Req: tid 0x1 len 0x11
>>           pat uuid-16 0x0100 (L2CAP)
>>           max 65535
>>           aid(s) 0x0000 - 0xffff
>>           cont 02 00 26
>>> ACL data: handle 6 flags 0x02 dlen 27
>>> ACL data: handle 6 flags 0x01 dlen 25
>>     L2CAP(d): cid 0x0040 len 48 [psm 1]
>>         SDP SSA Rsp: tid 0x1 len 0x2b
>>           count 38
>>           cont 02 00 4C
>> < ACL data: handle 6 flags 0x02 dlen 26
>>     L2CAP(d): cid 0x0042 len 22 [psm 1]
>>         SDP SSA Req: tid 0x2 len 0x11
>>           pat uuid-16 0x0100 (L2CAP)
>>           max 65535
>>           aid(s) 0x0000 - 0xffff
>>           cont 02 00 4C
>>> ACL data: handle 6 flags 0x02 dlen 27
>>> ACL data: handle 6 flags 0x01 dlen 25
>>     L2CAP(d): cid 0x0040 len 48 [psm 1]
>>         SDP SSA Rsp: tid 0x2 len 0x2b
>>           count 38
>>           cont 02 00 72
>> < ACL data: handle 6 flags 0x02 dlen 26
>>     L2CAP(d): cid 0x0042 len 22 [psm 1]
>>         SDP SSA Req: tid 0x3 len 0x11
>>           pat uuid-16 0x0100 (L2CAP)
>>           max 65535
>>           aid(s) 0x0000 - 0xffff
>>           cont 02 00 72
>>> ACL data: handle 6 flags 0x02 dlen 27
>>> ACL data: handle 6 flags 0x01 dlen 25
>>     L2CAP(d): cid 0x0040 len 48 [psm 1]
>>         SDP SSA Rsp: tid 0x3 len 0x2b
>>           count 38
>>           cont 02 00 98
>> < ACL data: handle 6 flags 0x02 dlen 26
>>     L2CAP(d): cid 0x0042 len 22 [psm 1]
>>         SDP SSA Req: tid 0x4 len 0x11
>>           pat uuid-16 0x0100 (L2CAP)
>>           max 65535
>>           aid(s) 0x0000 - 0xffff
>>           cont 02 00 98
>>> ACL data: handle 6 flags 0x02 dlen 27
>>> ACL data: handle 6 flags 0x01 dlen 25
>>     L2CAP(d): cid 0x0040 len 48 [psm 1]
>>         SDP SSA Rsp: tid 0x4 len 0x2b
>>           count 38
>>           cont 02 00 BE
>>
>>
>> 4. Problem occurs after a couple of seconds.
>>
>> Failed to connect: org.bluez.Error.Failed
>> [CHG] Device 7C:1E:52:18:7D:4F Connected: no
>>
>> hcidump:
>>
>>> ACL data: handle 6 flags 0x02 dlen 12
>>     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0042
>> < HCI Command: Disconnect (0x01|0x0006) plen 3
>>     handle 6 reason 0x13
>>     Reason: Remote User Terminated Connection
>>> HCI Event: Command Status (0x0f) plen 4
>>     Disconnect (0x01|0x0006) status 0x00 ncmd 1
>>> HCI Event: Disconn Complete (0x05) plen 4
>>     status 0x00 handle 6 reason 0x16
>>     Reason: Connection Terminated by Local Host
>>
>> Appreciate your help!
>> Cheers/Magnus
> --

It looks like that the first time it was not able to complete the
connection and cable unplug was sent (which is probably wrong) so you
might have to pair again, make sure that you have set bluetoothctl as
default agent so you can authorize incoming connections and addition
to that you mark the device as trusted so next time you will not have
to authorize any connection.

Btw, it would be great if you can test this device with 5.19 or latter
since there have been some changes regarding the disconnect logic for
HID devices and I believe we would only sent cable unplug if the
device is removed.


-- 
Luiz Augusto von Dentz
