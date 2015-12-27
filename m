Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Mon, 28 Dec 2015 04:15:41 +0500
From: Mike Kazantsev <mk.fraggod@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Issue with processing (incorrect?) GET_REPORT replies from HID
 keyboard
Message-ID: <20151228041541.12c66477@malediction>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/J1=ENyXBLdIAVWSVejlGJim"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--MP_/J1=ENyXBLdIAVWSVejlGJim
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,


I have a Samsung VG-KBD1000 HID Keyboard + Touchpad device, which does
not seem to work with Linux 4.1/4.2 and BlueZ 5.36.


It *almost* works though, even getting registered in X, but seem to get
timed-out by kernel due to missing replies to GET_REPORT calls.

I can see these replies in Wireshark and btmon (both attached), with
correct keypress info, but without Report ID which Linux seem to be
requesting.

GET_REPORT request sent by kernel looks like this (as decoded by
wireshark, HID layer only):

  Bluetooth HID Profile
    0100 .... =3D Transaction Type: GET_REPORT (0x04)
    .... 0... =3D Size: Buffer equal to report size (0x00)
    .... .0.. =3D Parameter reserved: 0x00
    .... ..01 =3D Report Type: Input (0x01)
    Report Id: Unknown (0x03)

And response that follows looks like this:

  Bluetooth HID Profile
    1010 .... =3D Transaction Type: DATA (0x0a)
    .... 00.. =3D Parameter reserved: 0x00
    .... ..01 =3D Report Type: Input (0x01)
    Protocol Code: Keyboard (0x01)
    0... .... =3D Modifier: RIGHT GUI: False
    .0.. .... =3D Modifier: RIGHT ALT: False
    ..0. .... =3D Modifier: RIGHT SHIFT: False
    ...0 .... =3D Modifier: RIGHT CTRL: False
    .... 0... =3D Modifier: LEFT GUI: False
    .... .0.. =3D Modifier: LEFT ALT: False
    .... ..0. =3D Modifier: LEFT SHIFT: False
    .... ...0 =3D Modifier: LEFT CTRL: False
    Reserved: 0x00
    Keycode 1: l (0x0f)
    Keycode 2: <ACTION KEY UP> (0x00)
    Keycode 3: <ACTION KEY UP> (0x00)
    Keycode 4: <ACTION KEY UP> (0x00)
    Keycode 5: <ACTION KEY UP> (0x00)
    Keycode 6: <ACTION KEY UP> (0x00)

Unfortunately, kernel/bluez don't seem to acknowledge it in any way,
and send 4 more repeated GET_REPORT requests, after which drop device
with "Reason: Connection Timeout (0x08)".

=46rom "HUMAN INTERFACE DEVICE PROFILE 1.1" doc, I see that it is clearly
stated that device "Report ID shall precede report data if Report IDs
are declared in the report descriptor ..."  (3.1.2.3), but
unfortunately device does not seem to follow that, if I'm reading
wireshark data correctly.

Wireshark pcap and btmon ascii output for the whole exchange from
pressing button on the keyboard to it getting disconnected should be
attached to this message.


Prehaps someone with more bluetooth protocols knowledge can check if my
conclusion above seem to be correct or not?


If it is, what's the best way to approach this problem?
Maybe there is an easy flag or option to disable using Report IDs in
kernel for the device?


If there's no existing workaround to handle such devices, I'd greatly
appreciate any hints as to where/how to add an exception case for it in
the code in a proper and/or upstreamable way.


Thanks in advance for any response and happy holidays!


--=20
Mike Kazantsev // fraggod.net

--MP_/J1=ENyXBLdIAVWSVejlGJim
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename=bt_vg-kbd1000_get_report_issue.btmon.txt

Bluetooth monitor ver 5.36
=3D New Index: F2:D9:6D:CF:EB:AF (BR/EDR,USB,hci0)                         =
                                                                       [hci=
0] 0.886995
> HCI Event: Connect Request (0x04) plen 10                                =
                                                                    [hci0] =
20.846651
        Address: C4:57:6E:FA:9E:D1 (Samsung Electronics Co.,Ltd)
        Class: 0x0005cc
          Major class: Peripheral (mouse, joystick, keyboards)
          Minor class: 0x33
        Link type: ACL (0x01)
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7              =
                                                                    [hci0] =
20.846725
        Address: C4:57:6E:FA:9E:D1 (Samsung Electronics Co.,Ltd)
        Role: Master (0x00)
> HCI Event: Command Status (0x0f) plen 4                                  =
                                                                    [hci0] =
20.851649
      Accept Connection Request (0x01|0x0009) ncmd 1
        Status: Success (0x00)
> HCI Event: Role Change (0x12) plen 8                                     =
                                                                    [hci0] =
21.020648
        Status: Success (0x00)
        Address: C4:57:6E:FA:9E:D1 (Samsung Electronics Co.,Ltd)
        Role: Master (0x00)
> HCI Event: Connect Complete (0x03) plen 11                               =
                                                                    [hci0] =
21.075650
        Status: Success (0x00)
        Handle: 43
        Address: C4:57:6E:FA:9E:D1 (Samsung Electronics Co.,Ltd)
        Link type: ACL (0x01)
        Encryption: Disabled (0x00)
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2         =
                                                                    [hci0] =
21.075773
        Handle: 43
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7                =
                                                                    [hci0] =
21.076631
        Address: C4:57:6E:FA:9E:D1 (Samsung Electronics Co.,Ltd)
        Page scan repetition mode: R0 (0x00)
> HCI Event: Max Slots Change (0x1b) plen 3                                =
                                                                    [hci0] =
21.077617
        Handle: 43
        Max slots: 5
> HCI Event: Command Status (0x0f) plen 4                                  =
                                                                    [hci0] =
21.081625
      Read Remote Supported Features (0x01|0x001b) ncmd 1
        Status: Success (0x00)
> HCI Event: Read Remote Supported Features (0x0b) plen 11                 =
                                                                    [hci0] =
21.086655
        Status: Success (0x00)
        Handle: 43
        Features: 0xbf 0x06 0x86 0x7e 0x98 0x1f 0x79 0x87
          3 slot packets
          5 slot packets
          Encryption
          Slot offset
          Timing accuracy
          Role switch
          Sniff mode
          Power control requests
          Channel quality driven data rate (CQDDR)
          Paging parameter negotiation
          Power control
          Broadcast Encryption
          Enhanced Data Rate ACL 2 Mbps mode
          Enhanced Data Rate ACL 3 Mbps mode
          Enhanced inquiry scan
          Interlaced inquiry scan
          Interlaced page scan
          RSSI with inquiry results
          AFH capable slave
          AFH classification slave
          3-slot Enhanced Data Rate ACL packets
          5-slot Enhanced Data Rate ACL packets
          Sniff subrating
          Pause encryption
          AFH capable master
          AFH classification master
          Extended Inquiry Response
          Secure Simple Pairing
          Encapsulated PDU
          Erroneous Data Reporting
          Non-flushable Packet Boundary Flag
          Link Supervision Timeout Changed Event
          Inquiry TX Power Level
          Enhanced Power Control
          Extended features
< HCI Command: Read Remote Extended Features (0x01|0x001c) plen 3          =
                                                                    [hci0] =
21.086749
        Handle: 43
        Page: 1
> HCI Event: Command Status (0x0f) plen 4                                  =
                                                                    [hci0] =
21.092653
      Read Remote Extended Features (0x01|0x001c) ncmd 1
        Status: Success (0x00)
> HCI Event: Link Key Request (0x17) plen 6                                =
                                                                    [hci0] =
21.108647
        Address: C4:57:6E:FA:9E:D1 (Samsung Electronics Co.,Ltd)
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22                =
                                                                    [hci0] =
21.108715
        Address: C4:57:6E:FA:9E:D1 (Samsung Electronics Co.,Ltd)
        Link key: ffc14eab18b75c33471acb068007df7f
> HCI Event: Read Remote Extended Features (0x23) plen 13                  =
                                                                    [hci0] =
21.109646
        Status: Success (0x00)
        Handle: 43
        Page: 1/1
        Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
          Secure Simple Pairing (Host Support)
< ACL Data TX: Handle 43 flags 0x00 dlen 10                                =
                                                                    [hci0] =
21.109726
      L2CAP: Information Request (0x0a) ident 1 len 2
        Type: Extended features supported (0x0002)
> HCI Event: Number of Completed Packets (0x13) plen 5                     =
                                                                    [hci0] =
21.116614
        Num handles: 1
        Handle: 43
        Count: 1
> ACL Data RX: Handle 43 flags 0x02 dlen 16                                =
                                                                    [hci0] =
21.119615
      L2CAP: Information Response (0x0b) ident 1 len 8
        Type: Extended features supported (0x0002)
        Result: Success (0x0000)
        Features: 0x00000280
          Fixed Channels
          Unicast Connectionless Data Reception
> HCI Event: Command Complete (0x0e) plen 10                               =
                                                                    [hci0] =
21.119635
      Link Key Request Reply (0x01|0x000b) ncmd 1
        Status: Success (0x00)
        Address: C4:57:6E:FA:9E:D1 (Samsung Electronics Co.,Ltd)
< ACL Data TX: Handle 43 flags 0x00 dlen 10                                =
                                                                    [hci0] =
21.119689
      L2CAP: Information Request (0x0a) ident 2 len 2
        Type: Fixed channels supported (0x0003)
< HCI Command: Remote Name Request (0x01|0x0019) plen 10                   =
                                                                    [hci0] =
21.119705
        Address: C4:57:6E:FA:9E:D1 (Samsung Electronics Co.,Ltd)
        Page scan repetition mode: R2 (0x02)
        Page scan mode: Mandatory (0x00)
        Clock offset: 0x0000
> HCI Event: Command Status (0x0f) plen 4                                  =
                                                                    [hci0] =
21.123613
      Remote Name Request (0x01|0x0019) ncmd 1
        Status: Success (0x00)
> HCI Event: Number of Completed Packets (0x13) plen 5                     =
                                                                    [hci0] =
21.131649
        Num handles: 1
        Handle: 43
        Count: 1
> HCI Event: Remote Name Req Complete (0x07) plen 255                      =
                                                                    [hci0] =
21.163630
        Status: Success (0x00)
        Address: C4:57:6E:FA:9E:D1 (Samsung Electronics Co.,Ltd)
        Name: Samsung Wireless Keyboard
@ Device Connected: C4:57:6E:FA:9E:D1 (0) flags 0x0000
        1a 09 53 61 6d 73 75 6e 67 20 57 69 72 65 6c 65  ..Samsung Wirele
        73 73 20 4b 65 79 62 6f 61 72 64 04 0d cc 05 00  ss Keyboard.....
> HCI Event: Encryption Change (0x08) plen 4                               =
                                                                    [hci0] =
21.189613
        Status: Success (0x00)
        Handle: 43
        Encryption: Enabled with E0 (0x01)
> ACL Data RX: Handle 43 flags 0x02 dlen 20                                =
                                                                    [hci0] =
21.190609
      L2CAP: Information Response (0x0b) ident 2 len 12
        Type: Fixed channels supported (0x0003)
        Result: Success (0x0000)
        Channels: 0x0000000000000006
          L2CAP Signaling (BR/EDR)
          Connectionless reception
> ACL Data RX: Handle 43 flags 0x02 dlen 12                                =
                                                                    [hci0] =
21.193613
      L2CAP: Connection Request (0x02) ident 2 len 4
        PSM: 17 (0x0011)
        Source CID: 64
< ACL Data TX: Handle 43 flags 0x00 dlen 16                                =
                                                                    [hci0] =
21.193697
      L2CAP: Connection Response (0x03) ident 2 len 8
        Destination CID: 64
        Source CID: 64
        Result: Connection successful (0x0000)
        Status: No further information available (0x0000)
< ACL Data TX: Handle 43 flags 0x00 dlen 12                                =
                                                                    [hci0] =
21.193711
      L2CAP: Configure Request (0x04) ident 3 len 4
        Destination CID: 64
        Flags: 0x0000
> HCI Event: Number of Completed Packets (0x13) plen 5                     =
                                                                    [hci0] =
21.199618
        Num handles: 1
        Handle: 43
        Count: 1
> ACL Data RX: Handle 43 flags 0x02 dlen 16                                =
                                                                    [hci0] =
21.224616
      L2CAP: Configure Request (0x04) ident 3 len 8
        Destination CID: 64
        Flags: 0x0000
        Option: Maximum Transmission Unit (0x01) [mandatory]
          MTU: 700
< ACL Data TX: Handle 43 flags 0x00 dlen 18                                =
                                                                    [hci0] =
21.224692
      L2CAP: Configure Response (0x05) ident 3 len 10
        Source CID: 64
        Flags: 0x0000
        Result: Success (0x0000)
        Option: Maximum Transmission Unit (0x01) [mandatory]
          MTU: 700
> HCI Event: Number of Completed Packets (0x13) plen 5                     =
                                                                    [hci0] =
21.225623
        Num handles: 1
        Handle: 43
        Count: 1
> ACL Data RX: Handle 43 flags 0x02 dlen 14                                =
                                                                    [hci0] =
21.226646
      L2CAP: Configure Response (0x05) ident 3 len 6
        Source CID: 64
        Flags: 0x0000
        Result: Success (0x0000)
> HCI Event: Number of Completed Packets (0x13) plen 5                     =
                                                                    [hci0] =
21.237627
        Num handles: 1
        Handle: 43
        Count: 1
> ACL Data RX: Handle 43 flags 0x02 dlen 12                                =
                                                                    [hci0] =
21.259617
      L2CAP: Connection Request (0x02) ident 4 len 4
        PSM: 19 (0x0013)
        Source CID: 65
< ACL Data TX: Handle 43 flags 0x00 dlen 16                                =
                                                                    [hci0] =
21.259713
      L2CAP: Connection Response (0x03) ident 4 len 8
        Destination CID: 65
        Source CID: 65
        Result: Connection pending (0x0001)
        Status: Authorization pending (0x0002)
< ACL Data TX: Handle 43 flags 0x00 dlen 16                                =
                                                                    [hci0] =
21.259820
      L2CAP: Connection Response (0x03) ident 4 len 8
        Destination CID: 65
        Source CID: 65
        Result: Connection successful (0x0000)
        Status: No further information available (0x0000)
< ACL Data TX: Handle 43 flags 0x00 dlen 12                                =
                                                                    [hci0] =
21.259835
      L2CAP: Configure Request (0x04) ident 4 len 4
        Destination CID: 65
        Flags: 0x0000
> HCI Event: Number of Completed Packets (0x13) plen 5                     =
                                                                    [hci0] =
21.265653
        Num handles: 1
        Handle: 43
        Count: 1
> HCI Event: Number of Completed Packets (0x13) plen 5                     =
                                                                    [hci0] =
21.266613
        Num handles: 1
        Handle: 43
        Count: 1
> ACL Data RX: Handle 43 flags 0x02 dlen 16                                =
                                                                    [hci0] =
21.267646
      L2CAP: Configure Request (0x04) ident 5 len 8
        Destination CID: 65
        Flags: 0x0000
        Option: Maximum Transmission Unit (0x01) [mandatory]
          MTU: 700
< ACL Data TX: Handle 43 flags 0x00 dlen 18                                =
                                                                    [hci0] =
21.267716
      L2CAP: Configure Response (0x05) ident 5 len 10
        Source CID: 65
        Flags: 0x0000
        Result: Success (0x0000)
        Option: Maximum Transmission Unit (0x01) [mandatory]
          MTU: 700
> HCI Event: Number of Completed Packets (0x13) plen 5                     =
                                                                    [hci0] =
21.268617
        Num handles: 1
        Handle: 43
        Count: 1
> ACL Data RX: Handle 43 flags 0x02 dlen 14                                =
                                                                    [hci0] =
21.269617
      L2CAP: Configure Response (0x05) ident 4 len 6
        Source CID: 65
        Flags: 0x0000
        Result: Success (0x0000)
> HCI Event: Number of Completed Packets (0x13) plen 5                     =
                                                                    [hci0] =
21.272613
        Num handles: 1
        Handle: 43
        Count: 1
< ACL Data TX: Handle 43 flags 0x00 dlen 6                                 =
                                                                    [hci0] =
21.273543
      Channel: 64 len 2 [PSM 17 mode 0] {chan 0}
        41 03                                            A.
> HCI Event: Number of Completed Packets (0x13) plen 5                     =
                                                                    [hci0] =
21.279614
        Num handles: 1
        Handle: 43
        Count: 1
> ACL Data RX: Handle 43 flags 0x02 dlen 14                                =
                                                                    [hci0] =
21.280625
      Channel: 65 len 10 [PSM 19 mode 0] {chan 1}
        a1 01 00 00 0f 00 00 00 00 00                    ..........
< ACL Data TX: Handle 43 flags 0x00 dlen 6                                 =
                                                                    [hci0] =
26.273180
      Channel: 64 len 2 [PSM 17 mode 0] {chan 0}
        41 03                                            A.
< ACL Data TX: Handle 43 flags 0x00 dlen 6                                 =
                                                                    [hci0] =
31.273865
      Channel: 64 len 2 [PSM 17 mode 0] {chan 0}
        41 03                                            A.
< ACL Data TX: Handle 43 flags 0x00 dlen 6                                 =
                                                                    [hci0] =
36.274036
      Channel: 64 len 2 [PSM 17 mode 0] {chan 0}
        41 03                                            A.
< ACL Data TX: Handle 43 flags 0x00 dlen 6                                 =
                                                                    [hci0] =
41.273326
      Channel: 64 len 2 [PSM 17 mode 0] {chan 0}
        41 03                                            A.
> HCI Event: Disconnect Complete (0x05) plen 4                             =
                                                                    [hci0] =
41.283405
        Status: Success (0x00)
        Handle: 43
        Reason: Connection Timeout (0x08)
@ Device Disconnected: C4:57:6E:FA:9E:D1 (0) reason 1

--MP_/J1=ENyXBLdIAVWSVejlGJim
Content-Type: application/x-pcapng
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename=bt_vg-kbd1000_get_report_issue.pcapng

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
AAEEBQQAKwAIACwAAAA=

--MP_/J1=ENyXBLdIAVWSVejlGJim--
