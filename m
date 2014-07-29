Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAD81oNbjd3-Y_7C=75TfBP0oXjA3eFWbezsD8nROUrseUJZNhg@mail.gmail.com>
References: <CAD81oNZL0qATu_z_TJT8psaMhpmV34w6xmA2+=OKerSE1NSvOw@mail.gmail.com>
	<CABBYNZ+zRKzv4yTc8M2Fi0eN6gC921b9zaey5FKGVq_bJJueBg@mail.gmail.com>
	<CAD81oNbjd3-Y_7C=75TfBP0oXjA3eFWbezsD8nROUrseUJZNhg@mail.gmail.com>
Date: Mon, 28 Jul 2014 22:16:36 -0700
Message-ID: <CAD81oNZkRk-KFcE1bkj8TWiqe7dyVjHJADicT-f5KEkKtcnbyA@mail.gmail.com>
Subject: Re: [A2DP] Incoming connections do not succeed
From: Artem Rakhov <arakhov@google.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Have tried to connect the speaker to Macbook Pro (OS X, does not use
BlueZ). For some reason, when speaker initiates the incoming
connection, it connects via L2CAP to different PSM.
First, it goes to PSM 0x01 (Service Discovery Protocol), then
disconnects. Then it connects to 0x03 (RFCOMM) and keeps the
connection. After that speaker connects to PSM 0x01 again, and drops
connection.
And then finally the Mac itself initiates two L2CAP connections to
speaker, with correct PSM 0x19 (AVDTP). On device with BlueZ L2CAP
connection goes straight to PSM 0x19.

Here is a log from Macbook for the first connection to AVDTP:
[Jul 28 21:06:37.848]  [L2CAP SEND]  Connection Request - PSM: 0x0019
               Connection Request - PSM: 0x0019
               Identifier: 0x81
               Size: 4 (0x0004)
               PSM: 0x0019 - AVDTP (Audio/Video Distribution Transport
Protocol).
               Source CID: 0x0043
               Channel ID: 0x0001  Length: 0x0008 (08) [ 0B 20 0C 00
08 00 01 00 ]
               00000000: 0800 0100 0281 0400 1900 4300            ..........C.
[Jul 28 21:06:37.848]  [ACL SEND]  Data [Handle: 0x000B, Packet
Boundary Flags: 0x2, Length: 0x000C (12)]
[Jul 28 21:06:37.849]  [HCI COMMAND]  [FC48] Vendor Specific Command
[FC48] - Read Raw RSSI
[Jul 28 21:06:37.851]  [HCI EVENT]  [FC48] Command Complete - Broadcom
VSC Event - Read Raw RSSI - Handle: 0x000B  -50 dBm
[Jul 28 21:06:37.877]  [L2CAP RECEIVE]  Connection Response
               Connection Response
               Identifier: 0x81
               Size: 8 (0x0008)
               Destination CID: 0x0043
               Source CID: 0x0043
               Result: 0x0001 (Connection Pending)
               Status: 0x0002 (Authorization Pending)
               Channel ID: 0x0001  Length: 0x000C (12) [ 0B 20 10 00
0C 00 01 00 03 81 08 00 ]
               00000000: 0c00 0100 0381 0800 4300 4300 0100 0200
........C.C.....
[Jul 28 21:06:37.877]  [ACL RECEIVE]  Data [Handle: 0x000B, Packet
Boundary Flags: 0x2, Length: 0x0010 (16)]
[Jul 28 21:06:37.986]  [L2CAP RECEIVE]  Connection Response
               Connection Response
               Identifier: 0x81
               Size: 8 (0x0008)
               Destination CID: 0x0043
               Source CID: 0x0043
               Result: 0x0000 (Connection Successful)
               Status: 0x0000 (No further information available)
               Channel ID: 0x0001  Length: 0x000C (12) [ 0B 20 10 00
0C 00 01 00 03 81 08 00 ]
               00000000: 0c00 0100 0381 0800 4300 4300 0000 0000
........C.C.....
[Jul 28 21:06:37.986]  [ACL RECEIVE]  Data [Handle: 0x000B, Packet
Boundary Flags: 0x2, Length: 0x0010 (16)]
[Jul 28 21:06:37.986]  [L2CAP SEND]  Configuration Request
               Configuration Request
               Identifier: 0x84
               Size: 8 (0x0008)
               Destination CID: 0x0043
               Flags: 0x0000  - Not Continuation
               Options:
               Type: 0x01 (Hint)
               Length: 0x02
               MTU: 0xFFFF
               Channel ID: 0x0001  Length: 0x000C (12) [ 0B 20 10 00
0C 00 01 00 04 84 08 00 ]
               00000000: 0c00 0100 0484 0800 4300 0000 0102 ffff
........C.......
[Jul 28 21:06:37.986]  [ACL SEND]  Data [Handle: 0x000B, Packet
Boundary Flags: 0x2, Length: 0x0010 (16)]
[Jul 28 21:06:37.987]  [L2CAP RECEIVE]  Configuration Request
               Configuration Request
               Identifier: 0x0a
               Size: 8 (0x0008)
               Destination CID: 0x0043
               Flags: 0x0000  - Not Continuation
               Options:
               Type: 0x01 (Hint)
               Length: 0x02
               MTU: 0x037F
               Channel ID: 0x0001  Length: 0x000C (12) [ 0B 20 10 00
0C 00 01 00 04 0A 08 00 ]
               00000000: 0c00 0100 040a 0800 4300 0000 0102 7f03
........C.......
[Jul 28 21:06:37.987]  [ACL RECEIVE]  Data [Handle: 0x000B, Packet
Boundary Flags: 0x2, Length: 0x0010 (16)]
[Jul 28 21:06:37.987]  [L2CAP SEND]  Configure Response
               Configure Response
               Identifier: 0x0a
               Size: 10 (0x000A)
               Source CID: 0x0043
               Flags: 0x0000 - Not Continuation
               Result: 0x0000
               Success
               Config:
               Type: 0x01 (Hint)
               Length: 0x02
               MTU: 0x037F
               Channel ID: 0x0001  Length: 0x000E (14) [ 0B 20 12 00
0E 00 01 00 05 0A 0A 00 43 00 ]
               00000000: 0e00 0100 050a 0a00 4300 0000 0000 0102
........C.......
               00000010: 7f03                                     ..
[Jul 28 21:06:37.987]  [ACL SEND]  Data [Handle: 0x000B, Packet
Boundary Flags: 0x2, Length: 0x0012 (18)]
[Jul 28 21:06:37.991]  [HCI EVENT]  Number of Completed Packets -
Connection Handle: 0x000B - Packets: 0x0002
[Jul 28 21:06:38.020]  [L2CAP RECEIVE]  Configure Response
               Configure Response
               Identifier: 0x84
               Size: 6 (0x0006)
               Source CID: 0x0043
               Flags: 0x0000 - Not Continuation
               Result: 0x0000
               Success
               Empty Config Response.
               Channel ID: 0x0001  Length: 0x000A (10) [ 0B 20 0E 00
0A 00 01 00 05 84 ]
               00000000: 0a00 0100 0584 0600 4300 0000 0000       ........C.....
[Jul 28 21:06:38.020]  [ACL RECEIVE]  Data [Handle: 0x000B, Packet
Boundary Flags: 0x2, Length: 0x000E (14)]
[Jul 28 21:06:38.020]  [AVDTP SEND]  Discover: Signal (0x01)
[Jul 28 21:06:38.024]  [HCI EVENT]  Number of Completed Packets -
Connection Handle: 0x000B - Packets: 0x0002
[Jul 28 21:06:38.077]  [AVDTP RECEIVE]  Discover: Accept-Response (0x01)
[Jul 28 21:06:38.178]  [AVDTP SEND]  Get Cap.: Signal (0x02)
...

Log for the second connection:
[Jul 28 21:06:38.519]  [L2CAP SEND]  Connection Request - PSM: 0x0019
               Connection Request - PSM: 0x0019
               Identifier: 0x14
               Size: 4 (0x0004)
               PSM: 0x0019 - AVDTP (Audio/Video Distribution Transport
Protocol).
               Source CID: 0x0044
               Channel ID: 0x0001  Length: 0x0008 (08) [ 0B 20 0C 00
08 00 01 00 ]
               00000000: 0800 0100 0214 0400 1900 4400            ..........D.
[Jul 28 21:06:38.519]  [ACL SEND]  Data [Handle: 0x000B, Packet
Boundary Flags: 0x2, Length: 0x000C (12)]
[Jul 28 21:06:38.520]  [HCI COMMAND]  [FC48] Vendor Specific Command
[FC48] - Read Raw RSSI
[Jul 28 21:06:38.521]  [HCI EVENT]  [FC48] Command Complete - Broadcom
VSC Event - Read Raw RSSI - Handle: 0x000B  -48 dBm
[Jul 28 21:06:38.550]  [L2CAP RECEIVE]  Connection Response
               Connection Response
               Identifier: 0x14
               Size: 8 (0x0008)
               Destination CID: 0x0044
               Source CID: 0x0044
               Result: 0x0001 (Connection Pending)
               Status: 0x0002 (Authorization Pending)
               Channel ID: 0x0001  Length: 0x000C (12) [ 0B 20 10 00
0C 00 01 00 03 14 08 00 ]
               00000000: 0c00 0100 0314 0800 4400 4400 0100 0200
........D.D.....
[Jul 28 21:06:38.550]  [ACL RECEIVE]  Data [Handle: 0x000B, Packet
Boundary Flags: 0x2, Length: 0x0010 (16)]
[Jul 28 21:06:38.608]  [L2CAP RECEIVE]  Connection Response
               Connection Response
               Identifier: 0x14
               Size: 8 (0x0008)
               Destination CID: 0x0044
               Source CID: 0x0044
               Result: 0x0000 (Connection Successful)
               Status: 0x0000 (No further information available)
               Channel ID: 0x0001  Length: 0x000C (12) [ 0B 20 10 00
0C 00 01 00 03 14 08 00 ]
               00000000: 0c00 0100 0314 0800 4400 4400 0000 0000
........D.D.....
[Jul 28 21:06:38.608]  [ACL RECEIVE]  Data [Handle: 0x000B, Packet
Boundary Flags: 0x2, Length: 0x0010 (16)]
[Jul 28 21:06:38.608]  [L2CAP SEND]  Configuration Request
               Configuration Request
               Identifier: 0x3d
               Size: 8 (0x0008)
               Destination CID: 0x0044
               Flags: 0x0000  - Not Continuation
               Options:
               Type: 0x01 (Hint)
               Length: 0x02
               MTU: 0xFFFF
               Channel ID: 0x0001  Length: 0x000C (12) [ 0B 20 10 00
0C 00 01 00 04 3D 08 00 ]
               00000000: 0c00 0100 043d 0800 4400 0000 0102 ffff
.....=..D.......
[Jul 28 21:06:38.608]  [ACL SEND]  Data [Handle: 0x000B, Packet
Boundary Flags: 0x2, Length: 0x0010 (16)]
[Jul 28 21:06:38.611]  [HCI EVENT]  Number of Completed Packets -
Connection Handle: 0x000B - Packets: 0x0002
[Jul 28 21:06:38.640]  [L2CAP RECEIVE]  Configuration Request
               Configuration Request
               Identifier: 0x0b
               Size: 8 (0x0008)
               Destination CID: 0x0044
               Flags: 0x0000  - Not Continuation
               Options:
               Type: 0x01 (Hint)
               Length: 0x02
               MTU: 0x037F
               Channel ID: 0x0001  Length: 0x000C (12) [ 0B 20 10 00
0C 00 01 00 04 0B 08 00 ]
               00000000: 0c00 0100 040b 0800 4400 0000 0102 7f03
........D.......
[Jul 28 21:06:38.640]  [ACL RECEIVE]  Data [Handle: 0x000B, Packet
Boundary Flags: 0x2, Length: 0x0010 (16)]
[Jul 28 21:06:38.640]  [L2CAP SEND]  Configure Response
               Configure Response
               Identifier: 0x0b
               Size: 10 (0x000A)
               Source CID: 0x0044
               Flags: 0x0000 - Not Continuation
               Result: 0x0000
               Success
               Config:
               Type: 0x01 (Hint)
               Length: 0x02
               MTU: 0x037F
               Channel ID: 0x0001  Length: 0x000E (14) [ 0B 20 12 00
0E 00 01 00 05 0B 0A 00 44 00 ]
               00000000: 0e00 0100 050b 0a00 4400 0000 0000 0102
........D.......
               00000010: 7f03                                     ..
[Jul 28 21:06:38.640]  [ACL SEND]  Data [Handle: 0x000B, Packet
Boundary Flags: 0x2, Length: 0x0012 (18)]
[Jul 28 21:06:38.641]  [L2CAP RECEIVE]  Configure Response
               Configure Response
               Identifier: 0x3d
               Size: 6 (0x0006)
               Source CID: 0x0044
               Flags: 0x0000 - Not Continuation
               Result: 0x0000
               Success
               Empty Config Response.
               Channel ID: 0x0001  Length: 0x000A (10) [ 0B 20 0E 00
0A 00 01 00 05 3D ]
               00000000: 0a00 0100 053d 0600 4400 0000 0000       .....=..D.....
[Jul 28 21:06:38.641]  [ACL RECEIVE]  Data [Handle: 0x000B, Packet
Boundary Flags: 0x2, Length: 0x000E (14)]


Another observation is that BlueZ's L2CAP Configure Request does not
contain any MTU. Is that normal?

Thanks,
Artem

On Mon, Jul 28, 2014 at 5:24 PM, Artem Rakhov <arakhov@chromium.org> wrote:
> Hi Luiz,
>
> Yes, the device is trusted.
> So far I've tried BlueZ 4 with kernel 3.13, and Bluez 5.19 with kernel 3.8.11
>
> Thanks,
> Artem
>
> On Mon, Jul 28, 2014 at 1:21 AM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Hi Artem,
>>
>> On Sat, Jul 26, 2014 at 4:33 AM, Artem Rakhov <arakhov@chromium.org> wrote:
>>> Hello,
>>>
>>> I have a problem with A2DP incoming connections. I have a BT speaker
>>> (Monster Clarity HD), which automatically reconnects on startup to the
>>> last connected source. It works fine with BlueZ 4, but it never
>>> reconnects successfully when using BlueZ 5.19
>>>
>>> Here is btmon log:
>>> < ACL Data TX: Handle 21 flags 0x00 dlen 16
>>>                [hci0] 3471.224113
>>>       L2CAP: Connection Response (0x03) ident 2 len 8
>>>         Destination CID: 64
>>>         Source CID: 108
>>>         Result: Connection pending (0x0001)
>>>         Status: Authorization pending (0x0002)
>>> < ACL Data TX: Handle 21 flags 0x00 dlen 16
>>>                [hci0] 3471.224313
>>>       L2CAP: Connection Response (0x03) ident 2 len 8
>>>         Destination CID: 64
>>>         Source CID: 108
>>>         Result: Connection successful (0x0000)
>>>         Status: No further information available (0x0000)
>>> < ACL Data TX: Handle 21 flags 0x00 dlen 12
>>>                [hci0] 3471.224417
>>>       L2CAP: Configure Request (0x04) ident 2 len 4
>>>         Destination CID: 108
>>>         Flags: 0x0000
>>>> HCI Event: Number of Completed Packets (0x13) plen 5                                [hci0] 3471.226831
>>>         Num handles: 1
>>>         Handle: 21
>>>         Count: 1
>>>> HCI Event: Number of Completed Packets (0x13) plen 5                                [hci0] 3471.227794
>>>         Num handles: 1
>>>         Handle: 21
>>>         Count: 1
>>>> HCI Event: Number of Completed Packets (0x13) plen 5                                [hci0] 3471.228807
>>>         Num handles: 1
>>>         Handle: 21
>>>         Count: 1
>>>> ACL Data RX: Handle 21 flags 0x02 dlen 12                                           [hci0] 3471.256507
>>>       L2CAP: Disconnection Request (0x06) ident 3 len 4
>>>         Destination CID: 64
>>>         Source CID: 108
>>> < ACL Data TX: Handle 21 flags 0x00 dlen 12
>>>                [hci0] 3471.256592
>>>       L2CAP: Disconnection Response (0x07) ident 3 len 4
>>>         Destination CID: 64
>>>         Source CID: 108
>>>> HCI Event: Number of Completed Packets (0x13) plen 5                                [hci0] 3471.258773
>>>         Num handles: 1
>>>         Handle: 21
>>>         Count: 1
>>>> HCI Event: Vendor (0xff) plen 7                                                     [hci0] 3471.549833
>>>         82 00 01 00 01 15 00                             .......
>>>> HCI Event: Disconnect Complete (0x05) plen 4                                        [hci0] 3471.550757
>>>         Status: Success (0x00)
>>>         Handle: 21
>>>         Reason: Remote User Terminated Connection (0x13)
>>> @ Device Disconnected: 10:B7:F6:01:31:ED (0) reason 3
>>>
>>>
>>> As could be seen from the log, after the source sends L2CAP Configure
>>> Request the speaker does not answer and disconnects (sends L2CAP
>>> Disconnection Request).
>>>
>>> Debugging avdtp.c showed that processing of incoming connections is
>>> held in avdtp_confirm_cb() function. There, at some point after
>>> successful authorization G_IO_ERR and G_IO_HUP events appear. And then
>>> session_cb() function is called (as callback for these events), which
>>> drops the connection.
>>
>> This looks pretty strange as the remote seems to be disconnecting not
>> us, btw did you tried to mark the device as trusted? Regarding it
>> working with BlueZ 4, what kernel are you using with that and can you
>> try to compare what is the difference in the logs, perhaps the remote
>> does like the Configure Request for some reason.
>>
>>
>> --
>> Luiz Augusto von Dentz
