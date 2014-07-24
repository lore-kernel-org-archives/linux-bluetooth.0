Return-Path: <cyrus@holtmann.org>
Message-ID: <1406199939.21242.105.camel@pc.interlinx.bc.ca>
Subject: Re: phone connects and then disconnects immediately
From: "Brian J. Murrell" <brian@brian.murrell.ca>
To: linux-bluetooth@vger.kernel.org
Date: Thu, 24 Jul 2014 07:05:39 -0400
In-Reply-To: <20140724081659.GA9891@t440s.lan>
References: <1406119074.21242.55.camel@pc.interlinx.bc.ca>
	 <20140724081659.GA9891@t440s.lan>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-fKDw54E24L7RSjoksFfQ"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-fKDw54E24L7RSjoksFfQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2014-07-24 at 11:16 +0300, Johan Hedberg wrote:=20
> Hi Brian,

Hi Johan,

> To analyze the matter further we'd need to get bluetoothd debug logs
> (for which you need to pass -d to the daemon)

Did that.  Not sure where those debug logs go on a Fedora 20 system
though.

> as well as HCI-level logs
> (e.g. using btmon) of this connection failure.

> HCI Event: Connect Request (0x04) plen 10                   [hci0] 556.51=
7273
        Address: XX:XX:XX:XX:XX:XX (LG Electronics)
        Class: 0x5a020c
          Major class: Phone (cellular, cordless, payphone, modem)
          Minor class: Smart phone
          Networking (LAN, Ad hoc)
          Capturing (Scanner, Microphone)
          Object Transfer (v-Inbox, v-Folder)
          Telephony (Cordless telephony, Modem, Headset)
        Link type: ACL (0x01)
< HCI Command: Accept Connection Requ.. (0x01|0x0009) plen 7  [hci0] 556.51=
7375
        Address: XX:XX:XX:XX:XX:XX (LG Electronics)
        Role: Master (0x00)
> HCI Event: Command Status (0x0f) plen 4                     [hci0] 556.52=
0255
      Accept Connection Request (0x01|0x0009) ncmd 1
        Status: Success (0x00)
> HCI Event: Role Change (0x12) plen 8                        [hci0] 556.68=
4269
        Status: Success (0x00)
        Address: XX:XX:XX:XX:XX:XX (LG Electronics)
        Role: Master (0x00)
> HCI Event: Connect Complete (0x03) plen 11                  [hci0] 556.83=
2264
        Status: Success (0x00)
        Handle: 11
        Address: XX:XX:XX:XX:XX:XX (LG Electronics)
        Link type: ACL (0x01)
        Encryption: Disabled (0x00)
< HCI Command: Read Remote Supported... (0x01|0x001b) plen 2  [hci0] 556.83=
2500
        Handle: 11
> HCI Event: Command Status (0x0f) plen 4                     [hci0] 556.83=
5253
      Read Remote Supported Features (0x01|0x001b) ncmd 1
        Status: Success (0x00)
> HCI Event: Read Remote Supported Features (0x0b) plen 11    [hci0] 556.83=
6249
        Status: Success (0x00)
        Handle: 11
        Features: 0xff 0xfe 0x8f 0xfe 0xd8 0x3f 0x5b 0x87
          3 slot packets
          5 slot packets
          Encryption
          Slot offset
          Timing accuracy
          Role switch
          Hold mode
          Sniff mode
          Power control requests
          Channel quality driven data rate (CQDDR)
          SCO link
          HV2 packets
          HV3 packets
          u-law log synchronous data
          A-law log synchronous data
          CVSD synchronous data
          Paging parameter negotiation
          Power control
          Transparent synchronous data
          Broadcast Encryption
          Enhanced Data Rate ACL 2 Mbps mode
          Enhanced Data Rate ACL 3 Mbps mode
          Enhanced inquiry scan
          Interlaced inquiry scan
          Interlaced page scan
          RSSI with inquiry results
          Extended SCO link (EV3 packets)
          AFH capable slave
          AFH classification slave
          LE Supported (Controller)
          3-slot Enhanced Data Rate ACL packets
          5-slot Enhanced Data Rate ACL packets
          Sniff subrating
          Pause encryption
          AFH capable master
          AFH classification master
          Enhanced Data Rate eSCO 2 Mbps mode
          Extended Inquiry Response
          Simultaneous LE and BR/EDR (Controller)
          Secure Simple Pairing
          Encapsulated PDU
          Non-flushable Packet Boundary Flag
          Link Supervision Timeout Changed Event
          Inquiry TX Power Level
          Enhanced Power Control
          Extended features
< HCI Command: Read Remote Extended F.. (0x01|0x001c) plen 3  [hci0] 556.83=
6473
        Handle: 11
        Page: 1
> HCI Event: Command Status (0x0f) plen 4                     [hci0] 556.83=
9254
      Read Remote Extended Features (0x01|0x001c) ncmd 1
        Status: Success (0x00)
> HCI Event: Max Slots Change (0x1b) plen 3                   [hci0] 556.85=
9258
        Handle: 11
        Max slots: 5
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7   [hci0] 556.86=
2250
        Address: XX:XX:XX:XX:XX:XX (LG Electronics)
        Page scan repetition mode: R1 (0x01)
> ACL Data RX: Handle 11 flags 0x02 dlen 10                   [hci0] 556.90=
7263
      L2CAP: Information Request (0x0a) ident 2 len 2
        Type: Extended features supported (0x0002)
< ACL Data TX: Handle 11 flags 0x00 dlen 16                   [hci0] 556.90=
7343
      L2CAP: Information Response (0x0b) ident 2 len 8
        Type: Extended features supported (0x0002)
        Result: Success (0x0000)
        Features: 0x000002b8
          Enhanced Retransmission Mode
          Streaming Mode
          FCS Option
          Fixed Channels
          Unicast Connectionless Data Reception
> HCI Event: Read Remote Extended Features (0x23) plen 13     [hci0] 556.91=
3287
        Status: Success (0x00)
        Handle: 11
        Page: 1/2
        Features: 0x03 0x00 0x00 0x00 0x00 0x00 0x00 0x00
          Secure Simple Pairing (Host Support)
          LE Supported (Host)
> ACL Data RX: Handle 11 flags 0x02 dlen 10                   [hci0] 556.91=
3303
      L2CAP: Information Request (0x0a) ident 3 len 2
        Type: Fixed channels supported (0x0003)
< HCI Command: Remote Name Request (0x01|0x0019) plen 10      [hci0] 556.91=
3381
        Address: XX:XX:XX:XX:XX:XX (LG Electronics)
        Page scan repetition mode: R2 (0x02)
        Page scan mode: Mandatory (0x00)
        Clock offset: 0x0000
< ACL Data TX: Handle 11 flags 0x00 dlen 20                   [hci0] 556.91=
3399
      L2CAP: Information Response (0x0b) ident 3 len 12
        Type: Fixed channels supported (0x0003)
        Result: Success (0x0000)
        Channels: 0x0000000000000006
          L2CAP Signaling (BR/EDR)
          Connectionless reception
> HCI Event: Command Status (0x0f) plen 4                     [hci0] 556.91=
6243
      Remote Name Request (0x01|0x0019) ncmd 1
        Status: Success (0x00)
> HCI Event: Number of Completed Packets (0x13) plen 5        [hci0] 556.91=
8245
        Num handles: 1
        Handle: 11
        Count: 2
> ACL Data RX: Handle 11 flags 0x02 dlen 12                   [hci0] 556.91=
8264
      L2CAP: Connection Request (0x02) ident 4 len 4
        PSM: 1 (0x0001)
        Source CID: 67
< ACL Data TX: Handle 11 flags 0x00 dlen 16                   [hci0] 556.91=
8383
      L2CAP: Connection Response (0x03) ident 4 len 8
        Destination CID: 64
        Source CID: 67
        Result: Connection pending (0x0001)
        Status: No further information available (0x0000)
< ACL Data TX: Handle 11 flags 0x00 dlen 10                   [hci0] 556.91=
8410
      L2CAP: Information Request (0x0a) ident 1 len 2
        Type: Extended features supported (0x0002)
@ Device Connected: XX:XX:XX:XX:XX:XX (0) flags 0x0000
        04 0d 0c 02 5a                                   ....Z          =
=20
> ACL Data RX: Handle 11 flags 0x02 dlen 16                   [hci0] 556.92=
5247
      L2CAP: Information Response (0x0b) ident 1 len 8
        Type: Extended features supported (0x0002)
        Result: Success (0x0000)
        Features: 0x000000b8
          Enhanced Retransmission Mode
          Streaming Mode
          FCS Option
          Fixed Channels
< ACL Data TX: Handle 11 flags 0x00 dlen 10                   [hci0] 556.92=
5323
      L2CAP: Information Request (0x0a) ident 2 len 2
        Type: Fixed channels supported (0x0003)
> HCI Event: Remote Name Req Complete (0x07) plen 255         [hci0] 556.93=
7296
        Status: Success (0x00)
        Address: XX:XX:XX:XX:XX:XX (LG Electronics)
        Name: Brian's phone
> HCI Event: Number of Completed Packets (0x13) plen 5        [hci0] 556.93=
8252
        Num handles: 1
        Handle: 11
        Count: 2
> ACL Data RX: Handle 11 flags 0x02 dlen 20                   [hci0] 556.97=
8252
      L2CAP: Information Response (0x0b) ident 2 len 12
        Type: Fixed channels supported (0x0003)
        Result: Success (0x0000)
        Channels: 0x0000000000000052
          L2CAP Signaling (BR/EDR)
          Attribute Protocol
          Security Manager
< ACL Data TX: Handle 11 flags 0x00 dlen 16                   [hci0] 556.97=
8338
      L2CAP: Connection Response (0x03) ident 4 len 8
        Destination CID: 64
        Source CID: 67
        Result: Connection successful (0x0000)
        Status: No further information available (0x0000)
< ACL Data TX: Handle 11 flags 0x00 dlen 23                   [hci0] 556.97=
8367
      L2CAP: Configure Request (0x04) ident 3 len 15
        Destination CID: 67
        Flags: 0x0000
        Option: Retransmission and Flow Control (0x04)
          Mode: Basic (0x00)
          TX window size: 0
          Max transmit: 0
          Retransmission timeout: 0
          Monitor timeout: 0
          Maximum PDU size: 0
> HCI Event: Number of Completed Packets (0x13) plen 5        [hci0] 556.98=
2245
        Num handles: 1
        Handle: 11
        Count: 2
> ACL Data RX: Handle 11 flags 0x02 dlen 16                   [hci0] 556.98=
2266
      L2CAP: Configure Request (0x04) ident 5 len 8
        Destination CID: 64
        Flags: 0x0000
        Option: Maximum Transmission Unit (0x01)
          MTU: 256
< ACL Data TX: Handle 11 flags 0x00 dlen 18                   [hci0] 556.98=
2334
      L2CAP: Configure Response (0x05) ident 5 len 10
        Source CID: 67
        Flags: 0x0000
        Result: Success (0x0000)
        Option: Maximum Transmission Unit (0x01)
          MTU: 256
> ACL Data RX: Handle 11 flags 0x02 dlen 14                   [hci0] 556.98=
3252
      L2CAP: Configure Response (0x05) ident 3 len 6
        Source CID: 64
        Flags: 0x0000
        Result: Success (0x0000)
> HCI Event: Number of Completed Packets (0x13) plen 5        [hci0] 556.98=
7254
        Num handles: 1
        Handle: 11
        Count: 2
> ACL Data RX: Handle 11 flags 0x02 dlen 28                   [hci0] 556.98=
7269
      Channel: 64 len 24 [PSM 17 mode 0] {chan 0}
        06 00 00 00 13 35 03 19 11 0b 00 f0 35 09 09 00  .....5......5...
        01 09 00 04 09 00 09 00                          ........       =
=20
< ACL Data TX: Handle 11 flags 0x00 dlen 14                   [hci0] 556.98=
7795
      Channel: 67 len 10 [PSM 1 mode 0] {chan 2}
      SDP: Service Search Attribute Response (0x07) tid 0 len 5
        Attribute bytes: 2
        Continuation state: 0
> ACL Data RX: Handle 11 flags 0x02 dlen 12                   [hci0] 556.99=
2262
      L2CAP: Disconnection Request (0x06) ident 6 len 4
        Destination CID: 64
        Source CID: 67
< ACL Data TX: Handle 11 flags 0x00 dlen 12                   [hci0] 556.99=
2361
      L2CAP: Disconnection Response (0x07) ident 6 len 4
        Destination CID: 64
        Source CID: 67
> HCI Event: Number of Completed Packets (0x13) plen 5        [hci0] 556.99=
7246
        Num handles: 1
        Handle: 11
        Count: 2
> HCI Event: Link Key Request (0x17) plen 6                   [hci0] 557.12=
0266
        Address: XX:XX:XX:XX:XX:XX (LG Electronics)
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22   [hci0] 557.12=
0346
        Address: XX:XX:XX:XX:XX:XX (LG Electronics)
        Link key: 577a9d0df3707630fa0b08fcfd0b37f9
> HCI Event: Command Complete (0x0e) plen 10                  [hci0] 557.20=
5250
      Link Key Request Reply (0x01|0x000b) ncmd 1
        Status: Success (0x00)
        Address: XX:XX:XX:XX:XX:XX (LG Electronics)
> ACL Data RX: Handle 11 flags 0x02 dlen 12                   [hci0] 557.27=
3255
      L2CAP: Connection Request (0x02) ident 7 len 4
        PSM: 25 (0x0019)
        Source CID: 75
< ACL Data TX: Handle 11 flags 0x00 dlen 16                   [hci0] 557.27=
3330
      L2CAP: Connection Response (0x03) ident 7 len 8
        Destination CID: 0
        Source CID: 75
        Result: Connection refused - PSM not supported (0x0002)
        Status: No further information available (0x0000)
> HCI Event: Encryption Change (0x08) plen 4                  [hci0] 557.27=
5239
        Status: Success (0x00)
        Handle: 11
        Encryption: Enabled with E0 (0x01)
> HCI Event: Number of Completed Packets (0x13) plen 5        [hci0] 557.43=
2260
        Num handles: 1
        Handle: 11
        Count: 1
< HCI Command: Disconnect (0x01|0x0006) plen 3                [hci0] 560.99=
4017
        Handle: 11
        Reason: Remote User Terminated Connection (0x13)
> HCI Event: Command Status (0x0f) plen 4                     [hci0] 560.99=
6192
      Disconnect (0x01|0x0006) ncmd 1
        Status: Invalid HCI Command Parameters (0x12)
> HCI Event: Disconnect Complete (0x05) plen 4                [hci0] 561.14=
5201
        Status: Success (0x00)
        Handle: 11
        Reason: Remote User Terminated Connection (0x13)
@ Device Disconnected: XX:XX:XX:XX:XX:XX (0) reason 3

Cheers,
b.


--=-fKDw54E24L7RSjoksFfQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJT0OiEAAoJENrB0DQWy8igizEIAKWn0KbI/K4TQWZs2F8FTHUm
UegeRXMhAD1yVfUW9FEqdIvusgbizzfRJfHFFFXgIBWVc03SFpeuo/EqmznG07Fn
hrj2n7Z4pRm0Nx8WIBEMwkQu6Y3/b+m6A9sQVuVenonZ2gPRWajaosTqxFdaG5Ii
qrSzt3ql2m4cMqW9b0bLtfHppyD4kfegW1tiFeCYHb2BNevViZmm1bmJ/Gq0PO9l
6v9F8HRYqDRVGm/G3pI5gvfKj3dTlf7evFhbVp7AsODz339i6v+uvhUCgJLfleb3
iCy+hb+C6VFb9TWYOaFe+GojRvnnQtAKMI5LS4b9PNasbjZ/57EQcvCnEmTBoLY=
=y/92
-----END PGP SIGNATURE-----

--=-fKDw54E24L7RSjoksFfQ--

