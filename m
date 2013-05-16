Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 16 May 2013 13:38:09 -0700
Message-ID: <CAHZ1yCkuuUCkKhe_h0TdYZ8jNxY0GYt60+4a1c41dr=diJ-MyQ@mail.gmail.com>
Subject: l2test: Can't connect: Invalid exchange (52)
From: Scott James Remnant <keybuk@google.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On one machine I'm running "l2test -w" (listen and send), and on the
other "l2test -u" (connect and receive). Neither specifies
authentication or encryption. The machines are not paired.

Attempting to connect does this:

> HCI Event: Vendor (0xff) plen 2                             [hci0] 260.582938
        81 00                                            ..
> HCI Event: Connect Request (0x04) plen 10                   [hci0] 260.583838
        Address: 00:80:C1:53:22:09 (OUI 00-80-C1)
        Class: 0x6e0100
          Major class: Computer (desktop, notebook, PDA, organizers)
          Minor class: Uncategorized, code for device not assigned
          Networking (LAN, Ad hoc)
          Rendering (Printing, Speaker)
          Capturing (Scanner, Microphone)
          Audio (Speaker, Microphone, Headset)
          Telephony (Cordless telephony, Modem, Headset)
        Link type: ACL (0x01)
< HCI Command: Accept Connection Requ.. (0x01|0x0009) plen 7  [hci0] 260.583951
        Address: 00:80:C1:53:22:09 (OUI 00-80-C1)
        Role: Master (0x00)
> HCI Event: Command Status (0x0f) plen 4                     [hci0] 260.584890
      Accept Connection Request (0x01|0x0009) ncmd 1
        Status: Success (0x00)
> HCI Event: Role Change (0x12) plen 8                        [hci0] 260.736918
        Status: Success (0x00)
        Address: 00:80:C1:53:22:09 (OUI 00-80-C1)
        Role: Master (0x00)
> HCI Event: Vendor (0xff) plen 2                             [hci0] 260.751930
        81 01                                            ..
> HCI Event: Vendor (0xff) plen 7                             [hci0] 260.752839
        82 00 00 00 01 15 00                             .......
> HCI Event: Connect Complete (0x03) plen 11                  [hci0] 260.753839
        Status: Success (0x00)
        Handle: 21
        Address: 00:80:C1:53:22:09 (OUI 00-80-C1)
        Link type: ACL (0x01)
        Encryption: Disabled (0x00)
< HCI Command: Read Remote Supported... (0x01|0x001b) plen 2  [hci0] 260.754059
        Handle: 21
> HCI Event: Command Status (0x0f) plen 4                     [hci0] 260.754839
      Read Remote Supported Features (0x01|0x001b) ncmd 1
        Status: Success (0x00)
> HCI Event: Read Remote Supported Features (0x0b) plen 11    [hci0] 260.758922
        Status: Success (0x00)
        Handle: 21
        Features: 0xff 0xff 0x8f 0xfe 0x9b 0xff 0x79 0x83
          3 slot packets
          5 slot packets
          Encryption
          Slot offset
          Timing accuracy
          Role switch
          Hold mode
          Sniff mode
          Park state
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
          EV4 packets
          EV5 packets
          AFH capable slave
          AFH classification slave
          3-slot Enhanced Data Rate ACL packets
          5-slot Enhanced Data Rate ACL packets
          Sniff subrating
          Pause encryption
          AFH capable master
          AFH classification master
          Enhanced Data Rate eSCO 2 Mbps mode
          Enhanced Data Rate eSCO 3 Mbps mode
          3-slot Enhanced Data Rate eSCO packets
          Extended Inquiry Response
          Secure Simple Pairing
          Encapsulated PDU
          Erroneous Data Reporting
          Non-flushable Packet Boundary Flag
          Link Supervision Timeout Changed Event
          Inquiry TX Power Level
          Extended features
< HCI Command: Read Remote Extended F.. (0x01|0x001c) plen 3  [hci0] 260.759016
        Handle: 21
        Page: 1
> HCI Event: Command Status (0x0f) plen 4                     [hci0] 260.759841
      Read Remote Extended Features (0x01|0x001c) ncmd 1
        Status: Success (0x00)
> HCI Event: Read Remote Extended Features (0x23) plen 13     [hci0] 260.762922
        Status: Success (0x00)
        Handle: 21
        Page: 1/1
        Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
          Secure Simple Pairing (Host Support)
< HCI Command: Remote Name Request (0x01|0x0019) plen 10      [hci0] 260.763059
        Address: 00:80:C1:53:22:09 (OUI 00-80-C1)
        Page scan repetition mode: R2 (0x02)
        Page scan mode: Mandatory (0x00)
        Clock offset: 0x0000
> HCI Event: Vendor (0xff) plen 2                             [hci0] 260.763835
        81 00                                            ..
> HCI Event: Command Status (0x0f) plen 4                     [hci0] 260.764868
      Remote Name Request (0x01|0x0019) ncmd 1
        Status: Success (0x00)
> HCI Event: Vendor (0xff) plen 2                             [hci0] 260.777930
        81 01                                            ..
> HCI Event: Remote Name Req Complete (0x07) plen 255         [hci0] 260.794921
        Status: Success (0x00)
        Address: 00:80:C1:53:22:09 (OUI 00-80-C1)
        Name: dovahkiin.mtv.corp.google.com-0
@ Device Connected: 00:80:C1:53:22:09 (0) flags 0x0000
        20 09 64 6f 76 61 68 6b 69 69 6e 2e 6d 74 76 2e   .dovahkiin.mtv.
        63 6f 72 70 2e 67 6f 6f 67 6c 65 2e 63 6f 6d 2d  corp.google.com-
        30 04 0d 00 01 6e                                0....n
> HCI Event: Link Key Request (0x17) plen 6                   [hci0] 260.809885
        Address: 00:80:C1:53:22:09 (OUI 00-80-C1)
< HCI Command: Link Key Request Negat.. (0x01|0x000c) plen 6  [hci0] 260.809912
        Address: 00:80:C1:53:22:09 (OUI 00-80-C1)
> HCI Event: Command Complete (0x0e) plen 10                  [hci0] 260.810820
      Link Key Request Negative Reply (0x01|0x000c) ncmd 1
        Status: Success (0x00)
        Address: 00:80:C1:53:22:09 (OUI 00-80-C1)
> HCI Event: Vendor (0xff) plen 7                             [hci0] 262.835921
        82 00 01 00 01 15 00                             .......
> HCI Event: Disconnect Complete (0x05) plen 4                [hci0] 262.836826
        Status: Success (0x00)
        Handle: 21
        Reason: Remote User Terminated Connection (0x13)
@ Device Disconnected: 00:80:C1:53:22:09 (0) reason 3


I was expecting this to work - why the Link Key Request?

Scott
--
Scott James Remnant | Chrome OS Systems | keybuk@google.com | Google
