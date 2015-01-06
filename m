Return-Path: <cyrus@holtmann.org>
From: James Cloos <cloos@jhcloos.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Keeping hci interface powered
In-Reply-To: <FFFB52BA-6CC2-4E9E-ACA3-C3D2099BAA9B@holtmann.org> (Marcel
	Holtmann's message of "Mon, 5 Jan 2015 15:29:03 -0800")
References: <m3oaqfl79f.fsf@carbon.jhcloos.org>
	<D043D131-E9F8-43C1-8671-0EACAE810420@holtmann.org>
	<m361cklxwo.fsf@carbon.jhcloos.org>
	<C5CDA647-8415-44F3-9F89-0D596D76498F@holtmann.org>
	<m3zj9wkfsw.fsf@carbon.jhcloos.org>
	<FFFB52BA-6CC2-4E9E-ACA3-C3D2099BAA9B@holtmann.org>
Date: Mon, 05 Jan 2015 19:33:13 -0500
Message-ID: <m3tx04kat2.fsf@carbon.jhcloos.org>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

>> link_keys has the line:
>> 
>> 90:7f:xx:xx:xx:xx 4 eaxxxxxxxxxxxxxxxxxxxxxxxxxxxx1e 0

MH> this is an unauthenticated link key from SSP. Surprising to me that
MH> you do not have an authenticated link key. That is odd.

>> ,----< debug/bluetooth/hci0/features >
>> |  0: 0xff 0xfe 0x0f 0xfe 0xdb 0xff 0x7b 0x87

MH> The features page 1 should list at least 0x01 to indicate Secure
MH> Simple Pairing support. Can you run hciconfig hci0 features

That reports the same hex string, which it decodes as:

	<3-slot packets> <5-slot packets> <encryption> <slot offset> 
	<timing accuracy> <role switch> <hold mode> <sniff mode> 
	<RSSI> <channel quality> <SCO link> <HV2 packets> 
	<HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme> 
	<power control> <transparent SCO> <EDR ACL 2 Mbps> 
	<EDR ACL 3 Mbps> <enhanced iscan> <interlaced iscan> 
	<interlaced pscan> <inquiry with RSSI> <extended SCO> 
	<EV4 packets> <EV5 packets> <AFH cap. slave> 
	<AFH class. slave> <LE support> <3-slot EDR ACL> 
	<5-slot EDR ACL> <sniff subrating> <pause encryption> 
	<AFH cap. master> <AFH class. master> <EDR eSCO 2 Mbps> 
	<EDR eSCO 3 Mbps> <3-slot EDR eSCO> <extended inquiry> 
	<LE and BR/EDR> <simple pairing> <encapsulated PDU> 
	<err. data report> <non-flush flag> <LSTO> <inquiry TX power> 
	<EPC> <extended features> 

MH> and btmgmt info

Built, but not installed by the ebuild....

hci0:	addr 80:86:F2:xx:xx:xx version 6 manufacturer 2 class 0x000104
	supported settings: powered connectable fast-connectable discoverable bondable link-security ssp br/edr hs le advertising debug-keys privacy configuration 
	current settings: powered bondable ssp br/edr le 
	name BlueZ 5.27
	short name 

I also found:

  :; hciconfig hci0 sspmode
  hci0:	Type: BR/EDR  Bus: USB
  	BD Address: 80:86:F2:xx:xx:xx  ACL MTU: 1021:5  SCO MTU: 96:5
  	Simple Pairing mode: Disabled


MH> This is odd. It should show also features page 1. Run btmon while
MH> executing this command and I can tell you what is going on.

Bluetooth monitor ver 5.27
= New Index: 80:86:F2:xx:xx:xx (BR/EDR,USB,hci0)                                [hci0] 0.590153

< HCI Command: Remote Name Request (0x01|0x0019) plen 10                        [hci0] 4.074510
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
        Page scan repetition mode: R2 (0x02)
        Page scan mode: Mandatory (0x00)
        Clock offset: 0x0000
> HCI Event: Command Status (0x0f) plen 4                                       [hci0] 4.076607
      Remote Name Request (0x01|0x0019) ncmd 1
        Status: Success (0x00)
> HCI Event: Remote Name Req Complete (0x07) plen 255                           [hci0] 5.924745
        Status: Success (0x00)
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
        Name: ThinkPad Compact Bluetooth Keyboard with TrackPoint
< HCI Command: Read Remote Version Information (0x01|0x001d) plen 2             [hci0] 5.925091
        Handle: 256
> HCI Event: Command Status (0x0f) plen 4                                       [hci0] 5.926589
      Read Remote Version Information (0x01|0x001d) ncmd 1
        Status: Success (0x00)
> HCI Event: Read Remote Version Complete (0x0c) plen 8                         [hci0] 6.434751
        Status: Success (0x00)
        Handle: 256
        LMP version: Bluetooth 3.0 (0x05) - Subversion 8721 (0x2211)
        Manufacturer: Broadcom Corporation (15)
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2              [hci0] 6.435093
        Handle: 256
> HCI Event: Command Status (0x0f) plen 4                                       [hci0] 6.436677
      Read Remote Supported Features (0x01|0x001b) ncmd 1
        Status: Success (0x00)
> HCI Event: Read Remote Supported Features (0x0b) plen 11                      [hci0] 6.951761
        Status: Success (0x00)
        Handle: 256
        Features: 0xbf 0x06 0x86 0x78 0x18 0x1e 0x59 0x87
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
          Enhanced inquiry scan
          Interlaced inquiry scan
          Interlaced page scan
          RSSI with inquiry results
          AFH capable slave
          AFH classification slave
          Sniff subrating
          Pause encryption
          AFH capable master
          AFH classification master
          Extended Inquiry Response
          Secure Simple Pairing
          Encapsulated PDU
          Non-flushable Packet Boundary Flag
          Link Supervision Timeout Changed Event
          Inquiry TX Power Level
          Enhanced Power Control
          Extended features
< HCI Command: Read Remote Extended Features (0x01|0x001c) plen 3               [hci0] 6.952067
        Handle: 256
        Page: 0
> HCI Event: Command Status (0x0f) plen 4                                       [hci0] 6.953595
      Read Remote Extended Features (0x01|0x001c) ncmd 1
        Status: Success (0x00)
> HCI Event: Read Remote Extended Features (0x23) plen 13                       [hci0] 7.469753
        Status: Success (0x00)
        Handle: 256
        Page: 0/0
        Features: 0xbf 0x06 0x86 0x78 0x18 0x1e 0x59 0x87
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
          Enhanced inquiry scan
          Interlaced inquiry scan
          Interlaced page scan
          RSSI with inquiry results
          AFH capable slave
          AFH classification slave
          Sniff subrating
          Pause encryption
          AFH capable master
          AFH classification master
          Extended Inquiry Response
          Secure Simple Pairing
          Encapsulated PDU
          Non-flushable Packet Boundary Flag
          Link Supervision Timeout Changed Event
          Inquiry TX Power Level
          Enhanced Power Control
          Extended features


MH> The LegacyPairing: no is not a 100% indication, but I assume your
MH> keyboard is actually a Bluetooth 2.1 keyboard with Secure Simple
MH> Pairing.
>> 
MH> Do you have an exact model number or link? We might have to buy one
MH> of these keyboards.
>> 
>> Lenovo's pages are:
>> 
>> http://shop.lenovo.com/us/en/itemdetails/0B47189/460/60AC6A0372B14F5BA7B12F1FF88E33C7
>> http://support.lenovo.com/en/documents/pd026744
>> 
>> I got that one to support my trackpoint addiction. :^/
>> 
>> Are there any good tech specs for bt available w/o cost?

MH> Can you capture a pairing procedure with your keyboard with btmon?
MH> Then I can tell what is actually going on between these two devices.

After unpairing, it refuses to re-pair at all.  So now no keyboard
whatsoever......

Btmon reports:

Bluetooth monitor ver 5.27
= New Index: 80:86:xx:xx:xx:xx (BR/EDR,USB,hci0)                [hci0] 0.256980
< HCI Command: Create Connection (0x01|0x0005) plen 13         [hci0] 22.783716
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
        Packet type: 0xcc18
          DM1 may be used
          DH1 may be used
          DM3 may be used
          DH3 may be used
          DM5 may be used
          DH5 may be used
        Page scan repetition mode: R2 (0x02)
        Page scan mode: Mandatory (0x00)
        Clock offset: 0x0000
        Role switch: Allow slave (0x01)
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 22.785144
      Create Connection (0x01|0x0005) ncmd 1
        Status: Success (0x00)
> HCI Event: Connect Complete (0x03) plen 11                   [hci0] 27.907235
        Status: Page Timeout (0x04)
        Handle: 65535
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
        Link type: ACL (0x01)
        Encryption: Disabled (0x00)
@ Connect Failed: 90:7F:61:xx:xx:xx (0) status 0x04
< HCI Command: Create Connection (0x01|0x0005) plen 13         [hci0] 34.293035
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
        Packet type: 0xcc18
          DM1 may be used
          DH1 may be used
          DM3 may be used
          DH3 may be used
          DM5 may be used
          DH5 may be used
        Page scan repetition mode: R2 (0x02)
        Page scan mode: Mandatory (0x00)
        Clock offset: 0x0000
        Role switch: Allow slave (0x01)
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 34.295155
      Create Connection (0x01|0x0005) ncmd 1
        Status: Success (0x00)
> HCI Event: Connect Complete (0x03) plen 11                   [hci0] 35.553243
        Status: Success (0x00)
        Handle: 256
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
        Link type: ACL (0x01)
        Encryption: Disabled (0x00)
< HCI Command: Read Remote Supported F.. (0x01|0x001b) plen 2  [hci0] 35.553440
        Handle: 256
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 35.555086
      Read Remote Supported Features (0x01|0x001b) ncmd 1
        Status: Success (0x00)
< HCI Command: Write Scan Enable (0x03|0x001a) plen 1          [hci0] 35.555150
        Scan enable: No Scans (0x00)
> HCI Event: Max Slots Change (0x1b) plen 3                    [hci0] 35.558112
        Handle: 256
        Max slots: 5
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 35.559112
      Write Scan Enable (0x03|0x001a) ncmd 2
        Status: Success (0x00)
> HCI Event: Read Remote Supported Features (0x0b) plen 11     [hci0] 35.561110
        Status: Success (0x00)
        Handle: 256
        Features: 0xbf 0x06 0x86 0x78 0x18 0x1e 0x59 0x87
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
          Enhanced inquiry scan
          Interlaced inquiry scan
          Interlaced page scan
          RSSI with inquiry results
          AFH capable slave
          AFH classification slave
          Sniff subrating
          Pause encryption
          AFH capable master
          AFH classification master
          Extended Inquiry Response
          Secure Simple Pairing
          Encapsulated PDU
          Non-flushable Packet Boundary Flag
          Link Supervision Timeout Changed Event
          Inquiry TX Power Level
          Enhanced Power Control
          Extended features
< HCI Command: Read Remote Extended Fe.. (0x01|0x001c) plen 3  [hci0] 35.561183
        Handle: 256
        Page: 1
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 35.563155
      Read Remote Extended Features (0x01|0x001c) ncmd 1
        Status: Success (0x00)
> HCI Event: Read Remote Extended Features (0x23) plen 13      [hci0] 35.567237
        Status: Success (0x00)
        Handle: 256
        Page: 1/0
        Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
          Secure Simple Pairing (Host Support)
< HCI Command: Remote Name Request (0x01|0x0019) plen 10       [hci0] 35.567335
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
        Page scan repetition mode: R2 (0x02)
        Page scan mode: Mandatory (0x00)
        Clock offset: 0x0000
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 35.569154
      Remote Name Request (0x01|0x0019) ncmd 1
        Status: Success (0x00)
> HCI Event: Remote Name Req Complete (0x07) plen 255          [hci0] 35.597231
        Status: Success (0x00)
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
        Name: ThinkPad Compact Bluetooth Keyboard with TrackPoint
< HCI Command: Authentication Requested (0x01|0x0011) plen 2   [hci0] 35.597346
        Handle: 256
@ Device Connected: 90:7F:61:xx:xx:xx (0) flags 0x0000
        34 09 54 68 69 6e 6b 50 61 64 20 43 6f 6d 70 61  4.ThinkPad Compa
        63 74 20 42 6c 75 65 74 6f 6f 74 68 20 4b 65 79  ct Bluetooth Key
        62 6f 61 72 64 20 77 69 74 68 20 54 72 61 63 6b  board with Track
        50 6f 69 6e 74 04 0d 40 25 00                    Point..@%.      
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 35.599088
      Authentication Requested (0x01|0x0011) ncmd 1
        Status: Success (0x00)
> HCI Event: Link Key Request (0x17) plen 6                    [hci0] 35.600112
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
< HCI Command: Link Key Request Negati.. (0x01|0x000c) plen 6  [hci0] 35.600194
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
> HCI Event: Command Complete (0x0e) plen 10                   [hci0] 35.602099
      Link Key Request Negative Reply (0x01|0x000c) ncmd 1
        Status: Success (0x00)
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
> HCI Event: PIN Code Request (0x16) plen 6                    [hci0] 35.603085
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
@ PIN Code Request: 90:7F:61:xx:xx:xx (0) secure 0x00
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 35.607113
      Set AFH Host Channel Classification (0x03|0x003f) ncmd 2
        Status: Success (0x00)
< HCI Command: PIN Code Request Negati.. (0x01|0x000e) plen 6  [hci0] 35.970265
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
> HCI Event: Command Complete (0x0e) plen 10                   [hci0] 35.972124
      PIN Code Request Negative Reply (0x01|0x000e) ncmd 1
        Status: Success (0x00)
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
> HCI Event: Auth Complete (0x06) plen 3                       [hci0] 35.973089
        Status: PIN or Key Missing (0x06)
        Handle: 256
@ Authentication Failed: 90:7F:61:xx:xx:xx (0) status 0x05
< HCI Command: Read Clock Offset (0x01|0x001f) plen 2          [hci0] 37.980160
        Handle: 256
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 37.982242
      Read Clock Offset (0x01|0x001f) ncmd 1
        Status: Success (0x00)
< HCI Command: Disconnect (0x01|0x0006) plen 3                 [hci0] 37.982339
        Handle: 256
        Reason: Remote User Terminated Connection (0x13)
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 37.984240
      Disconnect (0x01|0x0006) ncmd 1
        Status: Success (0x00)
> HCI Event: Read Clock Offset Complete (0x1c) plen 5          [hci0] 37.986244
        Status: Success (0x00)
        Handle: 256
        Clock offset: 0x561c
> HCI Event: Disconnect Complete (0x05) plen 4                 [hci0] 38.070240
        Status: Success (0x00)
        Handle: 256
        Reason: Connection Terminated By Local Host (0x16)
@ Device Disconnected: 90:7F:61:xx:xx:xx (0) reason 2
< HCI Command: Write Scan Enable (0x03|0x001a) plen 1          [hci0] 38.075079
        Scan enable: Page Scan (0x02)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 38.077114
      Write Scan Enable (0x03|0x001a) ncmd 2
        Status: Success (0x00)
< HCI Command: Create Connection (0x01|0x0005) plen 13         [hci0] 38.974654
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
        Packet type: 0xcc18
          DM1 may be used
          DH1 may be used
          DM3 may be used
          DH3 may be used
          DM5 may be used
          DH5 may be used
        Page scan repetition mode: R2 (0x02)
        Page scan mode: Mandatory (0x00)
        Clock offset: 0x0000
        Role switch: Allow slave (0x01)
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 38.976151
      Create Connection (0x01|0x0005) ncmd 1
        Status: Success (0x00)
> HCI Event: Connect Complete (0x03) plen 11                   [hci0] 40.436248
        Status: Success (0x00)
        Handle: 256
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
        Link type: ACL (0x01)
        Encryption: Disabled (0x00)
< HCI Command: Read Remote Supported F.. (0x01|0x001b) plen 2  [hci0] 40.436443
        Handle: 256
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 40.438093
      Read Remote Supported Features (0x01|0x001b) ncmd 1
        Status: Success (0x00)
< HCI Command: Write Scan Enable (0x03|0x001a) plen 1          [hci0] 40.438160
        Scan enable: No Scans (0x00)
> HCI Event: Max Slots Change (0x1b) plen 3                    [hci0] 40.440111
        Handle: 256
        Max slots: 5
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 40.442112
      Write Scan Enable (0x03|0x001a) ncmd 2
        Status: Success (0x00)
> HCI Event: Read Remote Supported Features (0x0b) plen 11     [hci0] 40.444107
        Status: Success (0x00)
        Handle: 256
        Features: 0xbf 0x06 0x86 0x78 0x18 0x1e 0x59 0x87
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
          Enhanced inquiry scan
          Interlaced inquiry scan
          Interlaced page scan
          RSSI with inquiry results
          AFH capable slave
          AFH classification slave
          Sniff subrating
          Pause encryption
          AFH capable master
          AFH classification master
          Extended Inquiry Response
          Secure Simple Pairing
          Encapsulated PDU
          Non-flushable Packet Boundary Flag
          Link Supervision Timeout Changed Event
          Inquiry TX Power Level
          Enhanced Power Control
          Extended features
< HCI Command: Read Remote Extended Fe.. (0x01|0x001c) plen 3  [hci0] 40.444181
        Handle: 256
        Page: 1
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 40.446109
      Read Remote Extended Features (0x01|0x001c) ncmd 1
        Status: Success (0x00)
> HCI Event: Read Remote Extended Features (0x23) plen 13      [hci0] 40.453243
        Status: Success (0x00)
        Handle: 256
        Page: 1/0
        Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
          Secure Simple Pairing (Host Support)
< HCI Command: Remote Name Request (0x01|0x0019) plen 10       [hci0] 40.453340
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
        Page scan repetition mode: R2 (0x02)
        Page scan mode: Mandatory (0x00)
        Clock offset: 0x0000
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 40.455159
      Remote Name Request (0x01|0x0019) ncmd 1
        Status: Success (0x00)
> HCI Event: Remote Name Req Complete (0x07) plen 255          [hci0] 40.483244
        Status: Success (0x00)
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
        Name: ThinkPad Compact Bluetooth Keyboard with TrackPoint
< HCI Command: Authentication Requested (0x01|0x0011) plen 2   [hci0] 40.483356
        Handle: 256
@ Device Connected: 90:7F:61:xx:xx:xx (0) flags 0x0000
        34 09 54 68 69 6e 6b 50 61 64 20 43 6f 6d 70 61  4.ThinkPad Compa
        63 74 20 42 6c 75 65 74 6f 6f 74 68 20 4b 65 79  ct Bluetooth Key
        62 6f 61 72 64 20 77 69 74 68 20 54 72 61 63 6b  board with Track
        50 6f 69 6e 74 04 0d 40 25 00                    Point..@%.      
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 40.485149
      Authentication Requested (0x01|0x0011) ncmd 1
        Status: Success (0x00)
> HCI Event: Link Key Request (0x17) plen 6                    [hci0] 40.487153
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
< HCI Command: Link Key Request Negati.. (0x01|0x000c) plen 6  [hci0] 40.487242
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
> HCI Event: Command Complete (0x0e) plen 10                   [hci0] 40.489098
      Link Key Request Negative Reply (0x01|0x000c) ncmd 1
        Status: Success (0x00)
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
> HCI Event: PIN Code Request (0x16) plen 6                    [hci0] 40.490120
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
@ PIN Code Request: 90:7F:61:xx:xx:xx (0) secure 0x00
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 40.524248
      Set AFH Host Channel Classification (0x03|0x003f) ncmd 2
        Status: Success (0x00)
< HCI Command: PIN Code Request Negati.. (0x01|0x000e) plen 6  [hci0] 40.575160
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
> HCI Event: Command Complete (0x0e) plen 10                   [hci0] 40.577149
      PIN Code Request Negative Reply (0x01|0x000e) ncmd 1
        Status: Success (0x00)
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
> HCI Event: Auth Complete (0x06) plen 3                       [hci0] 40.579157
        Status: PIN or Key Missing (0x06)
        Handle: 256
@ Authentication Failed: 90:7F:61:xx:xx:xx (0) status 0x05
< HCI Command: Read Clock Offset (0x01|0x001f) plen 2          [hci0] 42.580162
        Handle: 256
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 42.582240
      Read Clock Offset (0x01|0x001f) ncmd 1
        Status: Success (0x00)
< HCI Command: Disconnect (0x01|0x0006) plen 3                 [hci0] 42.582338
        Handle: 256
        Reason: Remote User Terminated Connection (0x13)
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 42.584244
      Disconnect (0x01|0x0006) ncmd 1
        Status: Success (0x00)
> HCI Event: Read Clock Offset Complete (0x1c) plen 5          [hci0] 42.588242
        Status: Success (0x00)
        Handle: 256
        Clock offset: 0x562b
> HCI Event: Disconnect Complete (0x05) plen 4                 [hci0] 42.669243
        Status: Success (0x00)
        Handle: 256
        Reason: Connection Terminated By Local Host (0x16)
@ Device Disconnected: 90:7F:61:xx:xx:xx (0) reason 2
< HCI Command: Write Scan Enable (0x03|0x001a) plen 1          [hci0] 42.674322
        Scan enable: Page Scan (0x02)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 42.676112
      Write Scan Enable (0x03|0x001a) ncmd 2
        Status: Success (0x00)
< HCI Command: Create Connection (0x01|0x0005) plen 13         [hci0] 43.580730
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
        Packet type: 0xcc18
          DM1 may be used
          DH1 may be used
          DM3 may be used
          DH3 may be used
          DM5 may be used
          DH5 may be used
        Page scan repetition mode: R2 (0x02)
        Page scan mode: Mandatory (0x00)
        Clock offset: 0x0000
        Role switch: Allow slave (0x01)
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 43.582159
      Create Connection (0x01|0x0005) ncmd 1
        Status: Success (0x00)
> HCI Event: Connect Complete (0x03) plen 11                   [hci0] 44.578249
        Status: Success (0x00)
        Handle: 256
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
        Link type: ACL (0x01)
        Encryption: Disabled (0x00)
< HCI Command: Read Remote Supported F.. (0x01|0x001b) plen 2  [hci0] 44.578442
        Handle: 256
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 44.580083
      Read Remote Supported Features (0x01|0x001b) ncmd 1
        Status: Success (0x00)
< HCI Command: Write Scan Enable (0x03|0x001a) plen 1          [hci0] 44.580134
        Scan enable: No Scans (0x00)
> HCI Event: Max Slots Change (0x1b) plen 3                    [hci0] 44.583084
        Handle: 256
        Max slots: 5
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 44.584089
      Write Scan Enable (0x03|0x001a) ncmd 2
        Status: Success (0x00)
> HCI Event: Read Remote Supported Features (0x0b) plen 11     [hci0] 44.586109
        Status: Success (0x00)
        Handle: 256
        Features: 0xbf 0x06 0x86 0x78 0x18 0x1e 0x59 0x87
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
          Enhanced inquiry scan
          Interlaced inquiry scan
          Interlaced page scan
          RSSI with inquiry results
          AFH capable slave
          AFH classification slave
          Sniff subrating
          Pause encryption
          AFH capable master
          AFH classification master
          Extended Inquiry Response
          Secure Simple Pairing
          Encapsulated PDU
          Non-flushable Packet Boundary Flag
          Link Supervision Timeout Changed Event
          Inquiry TX Power Level
          Enhanced Power Control
          Extended features
< HCI Command: Read Remote Extended Fe.. (0x01|0x001c) plen 3  [hci0] 44.586186
        Handle: 256
        Page: 1
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 44.588157
      Read Remote Extended Features (0x01|0x001c) ncmd 1
        Status: Success (0x00)
> HCI Event: Read Remote Extended Features (0x23) plen 13      [hci0] 44.593244
        Status: Success (0x00)
        Handle: 256
        Page: 1/0
        Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
          Secure Simple Pairing (Host Support)
< HCI Command: Remote Name Request (0x01|0x0019) plen 10       [hci0] 44.593340
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
        Page scan repetition mode: R2 (0x02)
        Page scan mode: Mandatory (0x00)
        Clock offset: 0x0000
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 44.595157
      Remote Name Request (0x01|0x0019) ncmd 1
        Status: Success (0x00)
> HCI Event: Remote Name Req Complete (0x07) plen 255          [hci0] 44.623238
        Status: Success (0x00)
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
        Name: ThinkPad Compact Bluetooth Keyboard with TrackPoint
< HCI Command: Authentication Requested (0x01|0x0011) plen 2   [hci0] 44.623352
        Handle: 256
@ Device Connected: 90:7F:61:xx:xx:xx (0) flags 0x0000
        34 09 54 68 69 6e 6b 50 61 64 20 43 6f 6d 70 61  4.ThinkPad Compa
        63 74 20 42 6c 75 65 74 6f 6f 74 68 20 4b 65 79  ct Bluetooth Key
        62 6f 61 72 64 20 77 69 74 68 20 54 72 61 63 6b  board with Track
        50 6f 69 6e 74 04 0d 40 25 00                    Point..@%.      
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 44.625107
      Set AFH Host Channel Classification (0x03|0x003f) ncmd 2
        Status: Success (0x00)
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 44.626112
      Authentication Requested (0x01|0x0011) ncmd 1
        Status: Success (0x00)
> HCI Event: Link Key Request (0x17) plen 6                    [hci0] 44.627117
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
< HCI Command: Link Key Request Negati.. (0x01|0x000c) plen 6  [hci0] 44.627186
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
> HCI Event: Command Complete (0x0e) plen 10                   [hci0] 44.629083
      Link Key Request Negative Reply (0x01|0x000c) ncmd 1
        Status: Success (0x00)
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
> HCI Event: PIN Code Request (0x16) plen 6                    [hci0] 44.630108
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
@ PIN Code Request: 90:7F:61:xx:xx:xx (0) secure 0x00
< HCI Command: PIN Code Request Negati.. (0x01|0x000e) plen 6  [hci0] 44.714093
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
> HCI Event: Command Complete (0x0e) plen 10                   [hci0] 44.716092
      PIN Code Request Negative Reply (0x01|0x000e) ncmd 1
        Status: Success (0x00)
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
> HCI Event: Auth Complete (0x06) plen 3                       [hci0] 44.717097
        Status: PIN or Key Missing (0x06)
        Handle: 256
@ Authentication Failed: 90:7F:61:xx:xx:xx (0) status 0x05
< HCI Command: Read Clock Offset (0x01|0x001f) plen 2          [hci0] 46.724179
        Handle: 256
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 46.726248
      Read Clock Offset (0x01|0x001f) ncmd 1
        Status: Success (0x00)
< HCI Command: Disconnect (0x01|0x0006) plen 3                 [hci0] 46.726347
        Handle: 256
        Reason: Remote User Terminated Connection (0x13)
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 46.728248
      Disconnect (0x01|0x0006) ncmd 1
        Status: Success (0x00)
> HCI Event: Read Clock Offset Complete (0x1c) plen 5          [hci0] 46.730251
        Status: Success (0x00)
        Handle: 256
        Clock offset: 0x563a
> HCI Event: Disconnect Complete (0x05) plen 4                 [hci0] 46.811251
        Status: Success (0x00)
        Handle: 256
        Reason: Connection Terminated By Local Host (0x16)
@ Device Disconnected: 90:7F:61:xx:xx:xx (0) reason 2
< HCI Command: Write Scan Enable (0x03|0x001a) plen 1          [hci0] 46.816311
        Scan enable: Page Scan (0x02)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 46.818114
      Write Scan Enable (0x03|0x001a) ncmd 2
        Status: Success (0x00)
< HCI Command: Create Connection (0x01|0x0005) plen 13         [hci0] 47.718804
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
        Packet type: 0xcc18
          DM1 may be used
          DH1 may be used
          DM3 may be used
          DH3 may be used
          DM5 may be used
          DH5 may be used
        Page scan repetition mode: R2 (0x02)
        Page scan mode: Mandatory (0x00)
        Clock offset: 0x0000
        Role switch: Allow slave (0x01)
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 47.720156
      Create Connection (0x01|0x0005) ncmd 1
        Status: Success (0x00)
> HCI Event: Connect Complete (0x03) plen 11                   [hci0] 47.967252
        Status: Success (0x00)
        Handle: 256
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
        Link type: ACL (0x01)
        Encryption: Disabled (0x00)
< HCI Command: Read Remote Supported F.. (0x01|0x001b) plen 2  [hci0] 47.967446
        Handle: 256
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 47.969094
      Read Remote Supported Features (0x01|0x001b) ncmd 1
        Status: Success (0x00)
< HCI Command: Write Scan Enable (0x03|0x001a) plen 1          [hci0] 47.969161
        Scan enable: No Scans (0x00)
> HCI Event: Max Slots Change (0x1b) plen 3                    [hci0] 47.972111
        Handle: 256
        Max slots: 5
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 47.973112
      Write Scan Enable (0x03|0x001a) ncmd 2
        Status: Success (0x00)
> HCI Event: Read Remote Supported Features (0x0b) plen 11     [hci0] 47.977136
        Status: Success (0x00)
        Handle: 256
        Features: 0xbf 0x06 0x86 0x78 0x18 0x1e 0x59 0x87
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
          Enhanced inquiry scan
          Interlaced inquiry scan
          Interlaced page scan
          RSSI with inquiry results
          AFH capable slave
          AFH classification slave
          Sniff subrating
          Pause encryption
          AFH capable master
          AFH classification master
          Extended Inquiry Response
          Secure Simple Pairing
          Encapsulated PDU
          Non-flushable Packet Boundary Flag
          Link Supervision Timeout Changed Event
          Inquiry TX Power Level
          Enhanced Power Control
          Extended features
< HCI Command: Read Remote Extended Fe.. (0x01|0x001c) plen 3  [hci0] 47.977246
        Handle: 256
        Page: 1
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 47.979243
      Read Remote Extended Features (0x01|0x001c) ncmd 1
        Status: Success (0x00)
> HCI Event: Read Remote Extended Features (0x23) plen 13      [hci0] 47.985249
        Status: Success (0x00)
        Handle: 256
        Page: 1/0
        Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
          Secure Simple Pairing (Host Support)
< HCI Command: Remote Name Request (0x01|0x0019) plen 10       [hci0] 47.985346
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
        Page scan repetition mode: R2 (0x02)
        Page scan mode: Mandatory (0x00)
        Clock offset: 0x0000
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 47.987156
      Remote Name Request (0x01|0x0019) ncmd 1
        Status: Success (0x00)
> HCI Event: Remote Name Req Complete (0x07) plen 255          [hci0] 48.014250
        Status: Success (0x00)
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
        Name: ThinkPad Compact Bluetooth Keyboard with TrackPoint
< HCI Command: Authentication Requested (0x01|0x0011) plen 2   [hci0] 48.014360
        Handle: 256
@ Device Connected: 90:7F:61:xx:xx:xx (0) flags 0x0000
        34 09 54 68 69 6e 6b 50 61 64 20 43 6f 6d 70 61  4.ThinkPad Compa
        63 74 20 42 6c 75 65 74 6f 6f 74 68 20 4b 65 79  ct Bluetooth Key
        62 6f 61 72 64 20 77 69 74 68 20 54 72 61 63 6b  board with Track
        50 6f 69 6e 74 04 0d 40 25 00                    Point..@%.      
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 48.016160
      Authentication Requested (0x01|0x0011) ncmd 1
        Status: Success (0x00)
> HCI Event: Link Key Request (0x17) plen 6                    [hci0] 48.018133
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
< HCI Command: Link Key Request Negati.. (0x01|0x000c) plen 6  [hci0] 48.018244
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
> HCI Event: Command Complete (0x0e) plen 10                   [hci0] 48.020099
      Link Key Request Negative Reply (0x01|0x000c) ncmd 1
        Status: Success (0x00)
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
> HCI Event: PIN Code Request (0x16) plen 6                    [hci0] 48.021152
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
@ PIN Code Request: 90:7F:61:xx:xx:xx (0) secure 0x00
< HCI Command: PIN Code Request Negati.. (0x01|0x000e) plen 6  [hci0] 48.109595
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
> HCI Event: Command Complete (0x0e) plen 10                   [hci0] 48.111080
      PIN Code Request Negative Reply (0x01|0x000e) ncmd 1
        Status: Success (0x00)
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
> HCI Event: Auth Complete (0x06) plen 3                       [hci0] 48.112096
        Status: PIN or Key Missing (0x06)
        Handle: 256
@ Authentication Failed: 90:7F:61:xx:xx:xx (0) status 0x05
< HCI Command: Read Clock Offset (0x01|0x001f) plen 2          [hci0] 50.116222
        Handle: 256
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 50.118198
      Read Clock Offset (0x01|0x001f) ncmd 1
        Status: Success (0x00)
< HCI Command: Disconnect (0x01|0x0006) plen 3                 [hci0] 50.118317
        Handle: 256
        Reason: Remote User Terminated Connection (0x13)
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 50.120165
      Disconnect (0x01|0x0006) ncmd 1
        Status: Success (0x00)
> HCI Event: Read Clock Offset Complete (0x1c) plen 5          [hci0] 50.122245
        Status: Success (0x00)
        Handle: 256
        Clock offset: 0x563f
> HCI Event: Disconnect Complete (0x05) plen 4                 [hci0] 50.205256
        Status: Success (0x00)
        Handle: 256
        Reason: Connection Terminated By Local Host (0x16)
@ Device Disconnected: 90:7F:61:xx:xx:xx (0) reason 2
< HCI Command: Write Scan Enable (0x03|0x001a) plen 1          [hci0] 50.210307
        Scan enable: Page Scan (0x02)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 50.212109
      Write Scan Enable (0x03|0x001a) ncmd 2
        Status: Success (0x00)
< HCI Command: Create Connection (0x01|0x0005) plen 13         [hci0] 56.167262
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
        Packet type: 0xcc18
          DM1 may be used
          DH1 may be used
          DM3 may be used
          DH3 may be used
          DM5 may be used
          DH5 may be used
        Page scan repetition mode: R2 (0x02)
        Page scan mode: Mandatory (0x00)
        Clock offset: 0x0000
        Role switch: Allow slave (0x01)
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 56.169122
      Create Connection (0x01|0x0005) ncmd 1
        Status: Success (0x00)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 57.527242
      Set AFH Host Channel Classification (0x03|0x003f) ncmd 2
        Status: Success (0x00)
> HCI Event: Connect Complete (0x03) plen 11                   [hci0] 57.537251
        Status: Success (0x00)
        Handle: 256
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
        Link type: ACL (0x01)
        Encryption: Disabled (0x00)
< HCI Command: Read Remote Supported F.. (0x01|0x001b) plen 2  [hci0] 57.537450
        Handle: 256
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 57.539099
      Read Remote Supported Features (0x01|0x001b) ncmd 1
        Status: Success (0x00)
< HCI Command: Write Scan Enable (0x03|0x001a) plen 1          [hci0] 57.539165
        Scan enable: No Scans (0x00)
> HCI Event: Max Slots Change (0x1b) plen 3                    [hci0] 57.542117
        Handle: 256
        Max slots: 5
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 57.543117
      Write Scan Enable (0x03|0x001a) ncmd 2
        Status: Success (0x00)
> HCI Event: Read Remote Supported Features (0x0b) plen 11     [hci0] 57.546248
        Status: Success (0x00)
        Handle: 256
        Features: 0xbf 0x06 0x86 0x78 0x18 0x1e 0x59 0x87
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
          Enhanced inquiry scan
          Interlaced inquiry scan
          Interlaced page scan
          RSSI with inquiry results
          AFH capable slave
          AFH classification slave
          Sniff subrating
          Pause encryption
          AFH capable master
          AFH classification master
          Extended Inquiry Response
          Secure Simple Pairing
          Encapsulated PDU
          Non-flushable Packet Boundary Flag
          Link Supervision Timeout Changed Event
          Inquiry TX Power Level
          Enhanced Power Control
          Extended features
< HCI Command: Read Remote Extended Fe.. (0x01|0x001c) plen 3  [hci0] 57.546346
        Handle: 256
        Page: 1
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 57.548107
      Read Remote Extended Features (0x01|0x001c) ncmd 1
        Status: Success (0x00)
> HCI Event: Read Remote Extended Features (0x23) plen 13      [hci0] 57.554250
        Status: Success (0x00)
        Handle: 256
        Page: 1/0
        Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
          Secure Simple Pairing (Host Support)
< HCI Command: Remote Name Request (0x01|0x0019) plen 10       [hci0] 57.554349
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
        Page scan repetition mode: R2 (0x02)
        Page scan mode: Mandatory (0x00)
        Clock offset: 0x0000
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 57.556112
      Remote Name Request (0x01|0x0019) ncmd 1
        Status: Success (0x00)
> HCI Event: Remote Name Req Complete (0x07) plen 255          [hci0] 57.584246
        Status: Success (0x00)
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
        Name: ThinkPad Compact Bluetooth Keyboard with TrackPoint
< HCI Command: Authentication Requested (0x01|0x0011) plen 2   [hci0] 57.584362
        Handle: 256
@ Device Connected: 90:7F:61:xx:xx:xx (0) flags 0x0000
        34 09 54 68 69 6e 6b 50 61 64 20 43 6f 6d 70 61  4.ThinkPad Compa
        63 74 20 42 6c 75 65 74 6f 6f 74 68 20 4b 65 79  ct Bluetooth Key
        62 6f 61 72 64 20 77 69 74 68 20 54 72 61 63 6b  board with Track
        50 6f 69 6e 74 04 0d 40 25 00                    Point..@%.      
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 57.586098
      Authentication Requested (0x01|0x0011) ncmd 1
        Status: Success (0x00)
> HCI Event: Link Key Request (0x17) plen 6                    [hci0] 57.587112
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
< HCI Command: Link Key Request Negati.. (0x01|0x000c) plen 6  [hci0] 57.587190
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
> HCI Event: Command Complete (0x0e) plen 10                   [hci0] 57.589091
      Link Key Request Negative Reply (0x01|0x000c) ncmd 1
        Status: Success (0x00)
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
> HCI Event: PIN Code Request (0x16) plen 6                    [hci0] 57.590093
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
@ PIN Code Request: 90:7F:61:xx:xx:xx (0) secure 0x00
< HCI Command: PIN Code Request Negati.. (0x01|0x000e) plen 6  [hci0] 57.685474
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
> HCI Event: Command Complete (0x0e) plen 10                   [hci0] 57.687095
      PIN Code Request Negative Reply (0x01|0x000e) ncmd 1
        Status: Success (0x00)
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
> HCI Event: Auth Complete (0x06) plen 3                       [hci0] 57.688116
        Status: PIN or Key Missing (0x06)
        Handle: 256
@ Authentication Failed: 90:7F:61:xx:xx:xx (0) status 0x05
< HCI Command: Read Clock Offset (0x01|0x001f) plen 2          [hci0] 59.692183
        Handle: 256
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 59.694246
      Read Clock Offset (0x01|0x001f) ncmd 1
        Status: Success (0x00)
< HCI Command: Disconnect (0x01|0x0006) plen 3                 [hci0] 59.694344
        Handle: 256
        Reason: Remote User Terminated Connection (0x13)
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 59.696248
      Disconnect (0x01|0x0006) ncmd 1
        Status: Success (0x00)
> HCI Event: Read Clock Offset Complete (0x1c) plen 5          [hci0] 59.698252
        Status: Success (0x00)
        Handle: 256
        Clock offset: 0x567b
> HCI Event: Disconnect Complete (0x05) plen 4                 [hci0] 59.778252
        Status: Success (0x00)
        Handle: 256
        Reason: Connection Terminated By Local Host (0x16)
@ Device Disconnected: 90:7F:61:xx:xx:xx (0) reason 2
< HCI Command: Write Scan Enable (0x03|0x001a) plen 1          [hci0] 59.786314
        Scan enable: Page Scan (0x02)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 59.788110
      Write Scan Enable (0x03|0x001a) ncmd 2
        Status: Success (0x00)
< HCI Command: Create Connection (0x01|0x0005) plen 13         [hci0] 60.689892
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
        Packet type: 0xcc18
          DM1 may be used
          DH1 may be used
          DM3 may be used
          DH3 may be used
          DM5 may be used
          DH5 may be used
        Page scan repetition mode: R2 (0x02)
        Page scan mode: Mandatory (0x00)
        Clock offset: 0x0000
        Role switch: Allow slave (0x01)
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 60.692114
      Create Connection (0x01|0x0005) ncmd 1
        Status: Success (0x00)
> HCI Event: Connect Complete (0x03) plen 11                   [hci0] 62.076251
        Status: Success (0x00)
        Handle: 256
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
        Link type: ACL (0x01)
        Encryption: Disabled (0x00)
< HCI Command: Read Remote Supported F.. (0x01|0x001b) plen 2  [hci0] 62.076453
        Handle: 256
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 62.078096
      Read Remote Supported Features (0x01|0x001b) ncmd 1
        Status: Success (0x00)
< HCI Command: Write Scan Enable (0x03|0x001a) plen 1          [hci0] 62.078163
        Scan enable: No Scans (0x00)
> HCI Event: Max Slots Change (0x1b) plen 3                    [hci0] 62.081117
        Handle: 256
        Max slots: 5
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 62.082113
      Write Scan Enable (0x03|0x001a) ncmd 2
        Status: Success (0x00)
> HCI Event: Read Remote Supported Features (0x0b) plen 11     [hci0] 62.084121
        Status: Success (0x00)
        Handle: 256
        Features: 0xbf 0x06 0x86 0x78 0x18 0x1e 0x59 0x87
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
          Enhanced inquiry scan
          Interlaced inquiry scan
          Interlaced page scan
          RSSI with inquiry results
          AFH capable slave
          AFH classification slave
          Sniff subrating
          Pause encryption
          AFH capable master
          AFH classification master
          Extended Inquiry Response
          Secure Simple Pairing
          Encapsulated PDU
          Non-flushable Packet Boundary Flag
          Link Supervision Timeout Changed Event
          Inquiry TX Power Level
          Enhanced Power Control
          Extended features
< HCI Command: Read Remote Extended Fe.. (0x01|0x001c) plen 3  [hci0] 62.084205
        Handle: 256
        Page: 1
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 62.086159
      Read Remote Extended Features (0x01|0x001c) ncmd 1
        Status: Success (0x00)
> HCI Event: Read Remote Extended Features (0x23) plen 13      [hci0] 62.091257
        Status: Success (0x00)
        Handle: 256
        Page: 1/0
        Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
          Secure Simple Pairing (Host Support)
< HCI Command: Remote Name Request (0x01|0x0019) plen 10       [hci0] 62.091358
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
        Page scan repetition mode: R2 (0x02)
        Page scan mode: Mandatory (0x00)
        Clock offset: 0x0000
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 62.093108
      Remote Name Request (0x01|0x0019) ncmd 1
        Status: Success (0x00)
> HCI Event: Remote Name Req Complete (0x07) plen 255          [hci0] 62.121246
        Status: Success (0x00)
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
        Name: ThinkPad Compact Bluetooth Keyboard with TrackPoint
< HCI Command: Authentication Requested (0x01|0x0011) plen 2   [hci0] 62.121359
        Handle: 256
@ Device Connected: 90:7F:61:xx:xx:xx (0) flags 0x0000
        34 09 54 68 69 6e 6b 50 61 64 20 43 6f 6d 70 61  4.ThinkPad Compa
        63 74 20 42 6c 75 65 74 6f 6f 74 68 20 4b 65 79  ct Bluetooth Key
        62 6f 61 72 64 20 77 69 74 68 20 54 72 61 63 6b  board with Track
        50 6f 69 6e 74 04 0d 40 25 00                    Point..@%.      
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 62.123121
      Authentication Requested (0x01|0x0011) ncmd 1
        Status: Success (0x00)
> HCI Event: Link Key Request (0x17) plen 6                    [hci0] 62.124109
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
< HCI Command: Link Key Request Negati.. (0x01|0x000c) plen 6  [hci0] 62.124215
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
> HCI Event: Command Complete (0x0e) plen 10                   [hci0] 62.126084
      Link Key Request Negative Reply (0x01|0x000c) ncmd 1
        Status: Success (0x00)
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
> HCI Event: PIN Code Request (0x16) plen 6                    [hci0] 62.127091
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
@ PIN Code Request: 90:7F:61:xx:xx:xx (0) secure 0x00
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 62.163248
      Set AFH Host Channel Classification (0x03|0x003f) ncmd 2
        Status: Success (0x00)
< HCI Command: PIN Code Request Negati.. (0x01|0x000e) plen 6  [hci0] 62.225446
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
> HCI Event: Command Complete (0x0e) plen 10                   [hci0] 62.227096
      PIN Code Request Negative Reply (0x01|0x000e) ncmd 1
        Status: Success (0x00)
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
> HCI Event: Auth Complete (0x06) plen 3                       [hci0] 62.228092
        Status: PIN or Key Missing (0x06)
        Handle: 256
@ Authentication Failed: 90:7F:61:xx:xx:xx (0) status 0x05
< HCI Command: Read Clock Offset (0x01|0x001f) plen 2          [hci0] 64.232207
        Handle: 256
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 64.234250
      Read Clock Offset (0x01|0x001f) ncmd 1
        Status: Success (0x00)
< HCI Command: Disconnect (0x01|0x0006) plen 3                 [hci0] 64.234348
        Handle: 256
        Reason: Remote User Terminated Connection (0x13)
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 64.236258
      Disconnect (0x01|0x0006) ncmd 1
        Status: Success (0x00)
> HCI Event: Read Clock Offset Complete (0x1c) plen 5          [hci0] 64.238259
        Status: Success (0x00)
        Handle: 256
        Clock offset: 0x568a
> HCI Event: Disconnect Complete (0x05) plen 4                 [hci0] 64.321254
        Status: Success (0x00)
        Handle: 256
        Reason: Connection Terminated By Local Host (0x16)
@ Device Disconnected: 90:7F:61:xx:xx:xx (0) reason 2
< HCI Command: Write Scan Enable (0x03|0x001a) plen 1          [hci0] 64.329308
        Scan enable: Page Scan (0x02)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 64.331097
      Write Scan Enable (0x03|0x001a) ncmd 2
        Status: Success (0x00)
< HCI Command: Create Connection (0x01|0x0005) plen 13         [hci0] 65.229866
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
        Packet type: 0xcc18
          DM1 may be used
          DH1 may be used
          DM3 may be used
          DH3 may be used
          DM5 may be used
          DH5 may be used
        Page scan repetition mode: R2 (0x02)
        Page scan mode: Mandatory (0x00)
        Clock offset: 0x0000
        Role switch: Allow slave (0x01)
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 65.232119
      Create Connection (0x01|0x0005) ncmd 1
        Status: Success (0x00)
> HCI Event: Connect Complete (0x03) plen 11                   [hci0] 66.269255
        Status: Success (0x00)
        Handle: 256
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
        Link type: ACL (0x01)
        Encryption: Disabled (0x00)
< HCI Command: Read Remote Supported F.. (0x01|0x001b) plen 2  [hci0] 66.269454
        Handle: 256
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 66.271161
      Read Remote Supported Features (0x01|0x001b) ncmd 1
        Status: Success (0x00)
< HCI Command: Write Scan Enable (0x03|0x001a) plen 1          [hci0] 66.271255
        Scan enable: No Scans (0x00)
> HCI Event: Max Slots Change (0x1b) plen 3                    [hci0] 66.275144
        Handle: 256
        Max slots: 5
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 66.276102
      Write Scan Enable (0x03|0x001a) ncmd 2
        Status: Success (0x00)
> HCI Event: Read Remote Supported Features (0x0b) plen 11     [hci0] 66.278170
        Status: Success (0x00)
        Handle: 256
        Features: 0xbf 0x06 0x86 0x78 0x18 0x1e 0x59 0x87
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
          Enhanced inquiry scan
          Interlaced inquiry scan
          Interlaced page scan
          RSSI with inquiry results
          AFH capable slave
          AFH classification slave
          Sniff subrating
          Pause encryption
          AFH capable master
          AFH classification master
          Extended Inquiry Response
          Secure Simple Pairing
          Encapsulated PDU
          Non-flushable Packet Boundary Flag
          Link Supervision Timeout Changed Event
          Inquiry TX Power Level
          Enhanced Power Control
          Extended features
< HCI Command: Read Remote Extended Fe.. (0x01|0x001c) plen 3  [hci0] 66.278260
        Handle: 256
        Page: 1
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 66.280255
      Read Remote Extended Features (0x01|0x001c) ncmd 1
        Status: Success (0x00)
> HCI Event: Read Remote Extended Features (0x23) plen 13      [hci0] 66.285253
        Status: Success (0x00)
        Handle: 256
        Page: 1/0
        Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
          Secure Simple Pairing (Host Support)
< HCI Command: Remote Name Request (0x01|0x0019) plen 10       [hci0] 66.285349
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
        Page scan repetition mode: R2 (0x02)
        Page scan mode: Mandatory (0x00)
        Clock offset: 0x0000
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 66.287115
      Remote Name Request (0x01|0x0019) ncmd 1
        Status: Success (0x00)
> HCI Event: Remote Name Req Complete (0x07) plen 255          [hci0] 66.315254
        Status: Success (0x00)
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
        Name: ThinkPad Compact Bluetooth Keyboard with TrackPoint
< HCI Command: Authentication Requested (0x01|0x0011) plen 2   [hci0] 66.315369
        Handle: 256
@ Device Connected: 90:7F:61:xx:xx:xx (0) flags 0x0000
        34 09 54 68 69 6e 6b 50 61 64 20 43 6f 6d 70 61  4.ThinkPad Compa
        63 74 20 42 6c 75 65 74 6f 6f 74 68 20 4b 65 79  ct Bluetooth Key
        62 6f 61 72 64 20 77 69 74 68 20 54 72 61 63 6b  board with Track
        50 6f 69 6e 74 04 0d 40 25 00                    Point..@%.      
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 66.317097
      Authentication Requested (0x01|0x0011) ncmd 1
        Status: Success (0x00)
> HCI Event: Link Key Request (0x17) plen 6                    [hci0] 66.318117
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
< HCI Command: Link Key Request Negati.. (0x01|0x000c) plen 6  [hci0] 66.318209
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
> HCI Event: Command Complete (0x0e) plen 10                   [hci0] 66.320101
      Link Key Request Negative Reply (0x01|0x000c) ncmd 1
        Status: Success (0x00)
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
> HCI Event: PIN Code Request (0x16) plen 6                    [hci0] 66.321098
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
@ PIN Code Request: 90:7F:61:xx:xx:xx (0) secure 0x00
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 66.331128
      Set AFH Host Channel Classification (0x03|0x003f) ncmd 2
        Status: Success (0x00)
< HCI Command: PIN Code Request Negati.. (0x01|0x000e) plen 6  [hci0] 66.419802
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
> HCI Event: Command Complete (0x0e) plen 10                   [hci0] 66.421109
      PIN Code Request Negative Reply (0x01|0x000e) ncmd 1
        Status: Success (0x00)
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
> HCI Event: Auth Complete (0x06) plen 3                       [hci0] 66.422091
        Status: PIN or Key Missing (0x06)
        Handle: 256
@ Authentication Failed: 90:7F:61:xx:xx:xx (0) status 0x05
< HCI Command: Read Clock Offset (0x01|0x001f) plen 2          [hci0] 68.428166
        Handle: 256
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 68.430253
      Read Clock Offset (0x01|0x001f) ncmd 1
        Status: Success (0x00)
< HCI Command: Disconnect (0x01|0x0006) plen 3                 [hci0] 68.430350
        Handle: 256
        Reason: Remote User Terminated Connection (0x13)
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 68.432251
      Disconnect (0x01|0x0006) ncmd 1
        Status: Success (0x00)
> HCI Event: Read Clock Offset Complete (0x1c) plen 5          [hci0] 68.434260
        Status: Success (0x00)
        Handle: 256
        Clock offset: 0x569c
> HCI Event: Disconnect Complete (0x05) plen 4                 [hci0] 68.513262
        Status: Success (0x00)
        Handle: 256
        Reason: Connection Terminated By Local Host (0x16)
@ Device Disconnected: 90:7F:61:xx:xx:xx (0) reason 2
< HCI Command: Write Scan Enable (0x03|0x001a) plen 1          [hci0] 68.521315
        Scan enable: Page Scan (0x02)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 68.523103
      Write Scan Enable (0x03|0x001a) ncmd 2
        Status: Success (0x00)
< HCI Command: Create Connection (0x01|0x0005) plen 13         [hci0] 69.423819
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
        Packet type: 0xcc18
          DM1 may be used
          DH1 may be used
          DM3 may be used
          DH3 may be used
          DM5 may be used
          DH5 may be used
        Page scan repetition mode: R2 (0x02)
        Page scan mode: Mandatory (0x00)
        Clock offset: 0x0000
        Role switch: Allow slave (0x01)
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 69.425159
      Create Connection (0x01|0x0005) ncmd 1
        Status: Success (0x00)
> HCI Event: Connect Complete (0x03) plen 11                   [hci0] 69.748256
        Status: Success (0x00)
        Handle: 256
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
        Link type: ACL (0x01)
        Encryption: Disabled (0x00)
< HCI Command: Read Remote Supported F.. (0x01|0x001b) plen 2  [hci0] 69.748457
        Handle: 256
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 69.750096
      Read Remote Supported Features (0x01|0x001b) ncmd 1
        Status: Success (0x00)
< HCI Command: Write Scan Enable (0x03|0x001a) plen 1          [hci0] 69.750164
        Scan enable: No Scans (0x00)
> HCI Event: Max Slots Change (0x1b) plen 3                    [hci0] 69.752114
        Handle: 256
        Max slots: 5
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 69.754113
      Write Scan Enable (0x03|0x001a) ncmd 2
        Status: Success (0x00)
> HCI Event: Read Remote Supported Features (0x0b) plen 11     [hci0] 69.756114
        Status: Success (0x00)
        Handle: 256
        Features: 0xbf 0x06 0x86 0x78 0x18 0x1e 0x59 0x87
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
          Enhanced inquiry scan
          Interlaced inquiry scan
          Interlaced page scan
          RSSI with inquiry results
          AFH capable slave
          AFH classification slave
          Sniff subrating
          Pause encryption
          AFH capable master
          AFH classification master
          Extended Inquiry Response
          Secure Simple Pairing
          Encapsulated PDU
          Non-flushable Packet Boundary Flag
          Link Supervision Timeout Changed Event
          Inquiry TX Power Level
          Enhanced Power Control
          Extended features
< HCI Command: Read Remote Extended Fe.. (0x01|0x001c) plen 3  [hci0] 69.756199
        Handle: 256
        Page: 1
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 69.758112
      Read Remote Extended Features (0x01|0x001c) ncmd 1
        Status: Success (0x00)
> HCI Event: Read Remote Extended Features (0x23) plen 13      [hci0] 69.762124
        Status: Success (0x00)
        Handle: 256
        Page: 1/0
        Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
          Secure Simple Pairing (Host Support)
< HCI Command: Remote Name Request (0x01|0x0019) plen 10       [hci0] 69.762195
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
        Page scan repetition mode: R2 (0x02)
        Page scan mode: Mandatory (0x00)
        Clock offset: 0x0000
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 69.764164
      Remote Name Request (0x01|0x0019) ncmd 1
        Status: Success (0x00)
> HCI Event: Remote Name Req Complete (0x07) plen 255          [hci0] 69.791252
        Status: Success (0x00)
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
        Name: ThinkPad Compact Bluetooth Keyboard with TrackPoint
< HCI Command: Authentication Requested (0x01|0x0011) plen 2   [hci0] 69.791370
        Handle: 256
@ Device Connected: 90:7F:61:xx:xx:xx (0) flags 0x0000
        34 09 54 68 69 6e 6b 50 61 64 20 43 6f 6d 70 61  4.ThinkPad Compa
        63 74 20 42 6c 75 65 74 6f 6f 74 68 20 4b 65 79  ct Bluetooth Key
        62 6f 61 72 64 20 77 69 74 68 20 54 72 61 63 6b  board with Track
        50 6f 69 6e 74 04 0d 40 25 00                    Point..@%.      
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 69.793119
      Authentication Requested (0x01|0x0011) ncmd 1
        Status: Success (0x00)
> HCI Event: Link Key Request (0x17) plen 6                    [hci0] 69.794117
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
< HCI Command: Link Key Request Negati.. (0x01|0x000c) plen 6  [hci0] 69.794207
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
> HCI Event: Command Complete (0x0e) plen 10                   [hci0] 69.796100
      Link Key Request Negative Reply (0x01|0x000c) ncmd 1
        Status: Success (0x00)
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
> HCI Event: PIN Code Request (0x16) plen 6                    [hci0] 69.797101
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
@ PIN Code Request: 90:7F:61:xx:xx:xx (0) secure 0x00
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 69.812255
      Set AFH Host Channel Classification (0x03|0x003f) ncmd 2
        Status: Success (0x00)
< HCI Command: PIN Code Request Negati.. (0x01|0x000e) plen 6  [hci0] 69.893139
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
> HCI Event: Command Complete (0x0e) plen 10                   [hci0] 69.895164
      PIN Code Request Negative Reply (0x01|0x000e) ncmd 1
        Status: Success (0x00)
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
> HCI Event: Auth Complete (0x06) plen 3                       [hci0] 69.897101
        Status: PIN or Key Missing (0x06)
        Handle: 256
@ Authentication Failed: 90:7F:61:xx:xx:xx (0) status 0x05
< HCI Command: Read Clock Offset (0x01|0x001f) plen 2          [hci0] 71.900213
        Handle: 256
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 71.902250
      Read Clock Offset (0x01|0x001f) ncmd 1
        Status: Success (0x00)
< HCI Command: Disconnect (0x01|0x0006) plen 3                 [hci0] 71.902348
        Handle: 256
        Reason: Remote User Terminated Connection (0x13)
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 71.904261
      Disconnect (0x01|0x0006) ncmd 1
        Status: Success (0x00)
> HCI Event: Read Clock Offset Complete (0x1c) plen 5          [hci0] 71.906258
        Status: Success (0x00)
        Handle: 256
        Clock offset: 0x56a1
> HCI Event: Disconnect Complete (0x05) plen 4                 [hci0] 71.987247
        Status: Success (0x00)
        Handle: 256
        Reason: Connection Terminated By Local Host (0x16)
@ Device Disconnected: 90:7F:61:xx:xx:xx (0) reason 2
< HCI Command: Write Scan Enable (0x03|0x001a) plen 1          [hci0] 71.995315
        Scan enable: Page Scan (0x02)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 71.997119
      Write Scan Enable (0x03|0x001a) ncmd 2
        Status: Success (0x00)
< HCI Command: Create Connection (0x01|0x0005) plen 13         [hci0] 78.490870
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
        Packet type: 0xcc18
          DM1 may be used
          DH1 may be used
          DM3 may be used
          DH3 may be used
          DM5 may be used
          DH5 may be used
        Page scan repetition mode: R2 (0x02)
        Page scan mode: Mandatory (0x00)
        Clock offset: 0x0000
        Role switch: Allow slave (0x01)
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 78.492168
      Create Connection (0x01|0x0005) ncmd 1
        Status: Success (0x00)
> HCI Event: Connect Complete (0x03) plen 11                   [hci0] 79.365267
        Status: Success (0x00)
        Handle: 256
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
        Link type: ACL (0x01)
        Encryption: Disabled (0x00)
< HCI Command: Read Remote Supported F.. (0x01|0x001b) plen 2  [hci0] 79.365459
        Handle: 256
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 79.367167
      Read Remote Supported Features (0x01|0x001b) ncmd 1
        Status: Success (0x00)
< HCI Command: Write Scan Enable (0x03|0x001a) plen 1          [hci0] 79.367259
        Scan enable: No Scans (0x00)
> HCI Event: Max Slots Change (0x1b) plen 3                    [hci0] 79.370115
        Handle: 256
        Max slots: 5
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 79.371116
      Write Scan Enable (0x03|0x001a) ncmd 2
        Status: Success (0x00)
> HCI Event: Read Remote Supported Features (0x0b) plen 11     [hci0] 79.374115
        Status: Success (0x00)
        Handle: 256
        Features: 0xbf 0x06 0x86 0x78 0x18 0x1e 0x59 0x87
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
          Enhanced inquiry scan
          Interlaced inquiry scan
          Interlaced page scan
          RSSI with inquiry results
          AFH capable slave
          AFH classification slave
          Sniff subrating
          Pause encryption
          AFH capable master
          AFH classification master
          Extended Inquiry Response
          Secure Simple Pairing
          Encapsulated PDU
          Non-flushable Packet Boundary Flag
          Link Supervision Timeout Changed Event
          Inquiry TX Power Level
          Enhanced Power Control
          Extended features
< HCI Command: Read Remote Extended Fe.. (0x01|0x001c) plen 3  [hci0] 79.374202
        Handle: 256
        Page: 1
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 79.376102
      Read Remote Extended Features (0x01|0x001c) ncmd 1
        Status: Success (0x00)
> HCI Event: Read Remote Extended Features (0x23) plen 13      [hci0] 79.381114
        Status: Success (0x00)
        Handle: 256
        Page: 1/0
        Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
          Secure Simple Pairing (Host Support)
< HCI Command: Remote Name Request (0x01|0x0019) plen 10       [hci0] 79.381256
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
        Page scan repetition mode: R2 (0x02)
        Page scan mode: Mandatory (0x00)
        Clock offset: 0x0000
< ACL Data TX: Handle 256 flags 0x00 dlen 10                   [hci0] 79.381273
      L2CAP: Information Request (0x0a) ident 1 len 2
        Type: Extended features supported (0x0002)
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 79.383107
      Remote Name Request (0x01|0x0019) ncmd 1
        Status: Success (0x00)
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 79.387165
        Num handles: 1
        Handle: 256
        Count: 1
> ACL Data RX: Handle 256 flags 0x02 dlen 16                   [hci0] 79.388164
      L2CAP: Information Response (0x0b) ident 1 len 8
        Type: Extended features supported (0x0002)
        Result: Success (0x0000)
        Features: 0x00000280
          Fixed Channels
          Unicast Connectionless Data Reception
< ACL Data TX: Handle 256 flags 0x00 dlen 10                   [hci0] 79.388264
      L2CAP: Information Request (0x0a) ident 2 len 2
        Type: Fixed channels supported (0x0003)
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 79.392254
        Num handles: 1
        Handle: 256
        Count: 1
> ACL Data RX: Handle 256 flags 0x02 dlen 20                   [hci0] 79.393162
      L2CAP: Information Response (0x0b) ident 2 len 12
        Type: Fixed channels supported (0x0003)
        Result: Success (0x0000)
        Channels: 0x0000000000000006
          L2CAP Signaling (BR/EDR)
          Connectionless reception
< ACL Data TX: Handle 256 flags 0x00 dlen 12                   [hci0] 79.393260
      L2CAP: Connection Request (0x02) ident 3 len 4
        PSM: 1 (0x0001)
        Source CID: 64
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 79.397254
        Num handles: 1
        Handle: 256
        Count: 1
> ACL Data RX: Handle 256 flags 0x02 dlen 16                   [hci0] 79.398259
      L2CAP: Connection Response (0x03) ident 3 len 8
        Destination CID: 67
        Source CID: 64
        Result: Connection successful (0x0000)
        Status: No further information available (0x0000)
< ACL Data TX: Handle 256 flags 0x00 dlen 12                   [hci0] 79.398362
      L2CAP: Configure Request (0x04) ident 4 len 4
        Destination CID: 67
        Flags: 0x0000
> ACL Data RX: Handle 256 flags 0x02 dlen 16                   [hci0] 79.399257
      L2CAP: Configure Request (0x04) ident 2 len 8
        Destination CID: 64
        Flags: 0x0000
        Option: Maximum Transmission Unit (0x01)
          MTU: 48
< ACL Data TX: Handle 256 flags 0x00 dlen 18                   [hci0] 79.399366
      L2CAP: Configure Response (0x05) ident 2 len 10
        Source CID: 67
        Flags: 0x0000
        Result: Success (0x0000)
        Option: Maximum Transmission Unit (0x01)
          MTU: 48
> ACL Data RX: Handle 256 flags 0x02 dlen 14                   [hci0] 79.404258
      L2CAP: Configure Response (0x05) ident 4 len 6
        Source CID: 64
        Flags: 0x0000
        Result: Success (0x0000)
< ACL Data TX: Handle 256 flags 0x00 dlen 24                   [hci0] 79.404471
      Channel: 67 len 20 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Request (0x06) tid 0 len 15
        Search pattern: [len 5]
          Sequence (6) with 3 bytes [8 extra bits] len 5
            UUID (3) with 2 bytes [0 extra bits] len 3
              L2CAP (0x0100)
        Max record count: 65535
        Attribute list: [len 7]
          Sequence (6) with 5 bytes [8 extra bits] len 7
            Unsigned Integer (1) with 4 bytes [0 extra bits] len 5
              0x0000ffff
        Continuation state: 0
> HCI Event: Remote Name Req Complete (0x07) plen 255          [hci0] 79.408283
        Status: Success (0x00)
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
        Name: ThinkPad Compact Bluetooth Keyboard with TrackPoint
@ Device Connected: 90:7F:61:xx:xx:xx (0) flags 0x0000
        34 09 54 68 69 6e 6b 50 61 64 20 43 6f 6d 70 61  4.ThinkPad Compa
        63 74 20 42 6c 75 65 74 6f 6f 74 68 20 4b 65 79  ct Bluetooth Key
        62 6f 61 72 64 20 77 69 74 68 20 54 72 61 63 6b  board with Track
        50 6f 69 6e 74 04 0d 40 25 00                    Point..@%.      
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 79.410113
        Num handles: 1
        Handle: 256
        Count: 1
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 79.411113
        Num handles: 1
        Handle: 256
        Count: 1
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 79.412130
        Num handles: 1
        Handle: 256
        Count: 1
> ACL Data RX: Handle 256 flags 0x02 dlen 52                   [hci0] 79.435263
      Channel: 64 len 48 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Response (0x07) tid 0 len 43
        Attribute bytes: 38
        Continuation state: 2
        00 26                                            .&              
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 79.441252
      Set AFH Host Channel Classification (0x03|0x003f) ncmd 2
        Status: Success (0x00)
< ACL Data TX: Handle 256 flags 0x00 dlen 26                   [hci0] 79.524416
      Channel: 67 len 22 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Request (0x06) tid 1 len 17
        Search pattern: [len 5]
          Sequence (6) with 3 bytes [8 extra bits] len 5
            UUID (3) with 2 bytes [0 extra bits] len 3
              L2CAP (0x0100)
        Max record count: 65535
        Attribute list: [len 7]
          Sequence (6) with 5 bytes [8 extra bits] len 7
            Unsigned Integer (1) with 4 bytes [0 extra bits] len 5
              0x0000ffff
        Continuation state: 2
        00 26                                            .&              
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 79.528117
        Num handles: 1
        Handle: 256
        Count: 1
> ACL Data RX: Handle 256 flags 0x02 dlen 52                   [hci0] 79.554259
      Channel: 64 len 48 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Response (0x07) tid 1 len 43
        Attribute bytes: 38
        Continuation state: 2
        00 4c                                            .L              
< ACL Data TX: Handle 256 flags 0x00 dlen 26                   [hci0] 79.554445
      Channel: 67 len 22 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Request (0x06) tid 2 len 17
        Search pattern: [len 5]
          Sequence (6) with 3 bytes [8 extra bits] len 5
            UUID (3) with 2 bytes [0 extra bits] len 3
              L2CAP (0x0100)
        Max record count: 65535
        Attribute list: [len 7]
          Sequence (6) with 5 bytes [8 extra bits] len 7
            Unsigned Integer (1) with 4 bytes [0 extra bits] len 5
              0x0000ffff
        Continuation state: 2
        00 4c                                            .L              
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 79.558257
        Num handles: 1
        Handle: 256
        Count: 1
> ACL Data RX: Handle 256 flags 0x02 dlen 52                   [hci0] 79.585270
      Channel: 64 len 48 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Response (0x07) tid 2 len 43
        Attribute bytes: 38
        Continuation state: 2
        00 72                                            .r              
< ACL Data TX: Handle 256 flags 0x00 dlen 26                   [hci0] 79.585621
      Channel: 67 len 22 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Request (0x06) tid 3 len 17
        Search pattern: [len 5]
          Sequence (6) with 3 bytes [8 extra bits] len 5
            UUID (3) with 2 bytes [0 extra bits] len 3
              L2CAP (0x0100)
        Max record count: 65535
        Attribute list: [len 7]
          Sequence (6) with 5 bytes [8 extra bits] len 7
            Unsigned Integer (1) with 4 bytes [0 extra bits] len 5
              0x0000ffff
        Continuation state: 2
        00 72                                            .r              
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 79.590260
        Num handles: 1
        Handle: 256
        Count: 1
> ACL Data RX: Handle 256 flags 0x02 dlen 52                   [hci0] 79.617266
      Channel: 64 len 48 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Response (0x07) tid 3 len 43
        Attribute bytes: 38
        Continuation state: 2
        00 98                                            ..              
< ACL Data TX: Handle 256 flags 0x00 dlen 26                   [hci0] 79.617449
      Channel: 67 len 22 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Request (0x06) tid 4 len 17
        Search pattern: [len 5]
          Sequence (6) with 3 bytes [8 extra bits] len 5
            UUID (3) with 2 bytes [0 extra bits] len 3
              L2CAP (0x0100)
        Max record count: 65535
        Attribute list: [len 7]
          Sequence (6) with 5 bytes [8 extra bits] len 7
            Unsigned Integer (1) with 4 bytes [0 extra bits] len 5
              0x0000ffff
        Continuation state: 2
        00 98                                            ..              
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 79.622263
        Num handles: 1
        Handle: 256
        Count: 1
> ACL Data RX: Handle 256 flags 0x02 dlen 52                   [hci0] 79.648269
      Channel: 64 len 48 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Response (0x07) tid 4 len 43
        Attribute bytes: 38
        Continuation state: 2
        00 be                                            ..              
< ACL Data TX: Handle 256 flags 0x00 dlen 26                   [hci0] 79.648454
      Channel: 67 len 22 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Request (0x06) tid 5 len 17
        Search pattern: [len 5]
          Sequence (6) with 3 bytes [8 extra bits] len 5
            UUID (3) with 2 bytes [0 extra bits] len 3
              L2CAP (0x0100)
        Max record count: 65535
        Attribute list: [len 7]
          Sequence (6) with 5 bytes [8 extra bits] len 7
            Unsigned Integer (1) with 4 bytes [0 extra bits] len 5
              0x0000ffff
        Continuation state: 2
        00 be                                            ..              
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 79.653270
        Num handles: 1
        Handle: 256
        Count: 1
> ACL Data RX: Handle 256 flags 0x02 dlen 52                   [hci0] 79.679262
      Channel: 64 len 48 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Response (0x07) tid 5 len 43
        Attribute bytes: 38
        Continuation state: 2
        00 e4                                            ..              
< ACL Data TX: Handle 256 flags 0x00 dlen 26                   [hci0] 79.679445
      Channel: 67 len 22 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Request (0x06) tid 6 len 17
        Search pattern: [len 5]
          Sequence (6) with 3 bytes [8 extra bits] len 5
            UUID (3) with 2 bytes [0 extra bits] len 3
              L2CAP (0x0100)
        Max record count: 65535
        Attribute list: [len 7]
          Sequence (6) with 5 bytes [8 extra bits] len 7
            Unsigned Integer (1) with 4 bytes [0 extra bits] len 5
              0x0000ffff
        Continuation state: 2
        00 e4                                            ..              
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 79.683263
        Num handles: 1
        Handle: 256
        Count: 1
> ACL Data RX: Handle 256 flags 0x02 dlen 52                   [hci0] 79.710264
      Channel: 64 len 48 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Response (0x07) tid 6 len 43
        Attribute bytes: 38
        Continuation state: 2
        01 0a                                            ..              
< ACL Data TX: Handle 256 flags 0x00 dlen 26                   [hci0] 79.710492
      Channel: 67 len 22 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Request (0x06) tid 7 len 17
        Search pattern: [len 5]
          Sequence (6) with 3 bytes [8 extra bits] len 5
            UUID (3) with 2 bytes [0 extra bits] len 3
              L2CAP (0x0100)
        Max record count: 65535
        Attribute list: [len 7]
          Sequence (6) with 5 bytes [8 extra bits] len 7
            Unsigned Integer (1) with 4 bytes [0 extra bits] len 5
              0x0000ffff
        Continuation state: 2
        01 0a                                            ..              
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 79.715258
        Num handles: 1
        Handle: 256
        Count: 1
> ACL Data RX: Handle 256 flags 0x02 dlen 52                   [hci0] 79.742264
      Channel: 64 len 48 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Response (0x07) tid 7 len 43
        Attribute bytes: 38
        Continuation state: 2
        01 30                                            .0              
< ACL Data TX: Handle 256 flags 0x00 dlen 26                   [hci0] 79.742489
      Channel: 67 len 22 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Request (0x06) tid 8 len 17
        Search pattern: [len 5]
          Sequence (6) with 3 bytes [8 extra bits] len 5
            UUID (3) with 2 bytes [0 extra bits] len 3
              L2CAP (0x0100)
        Max record count: 65535
        Attribute list: [len 7]
          Sequence (6) with 5 bytes [8 extra bits] len 7
            Unsigned Integer (1) with 4 bytes [0 extra bits] len 5
              0x0000ffff
        Continuation state: 2
        01 30                                            .0              
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 79.747254
        Num handles: 1
        Handle: 256
        Count: 1
> ACL Data RX: Handle 256 flags 0x02 dlen 52                   [hci0] 79.773254
      Channel: 64 len 48 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Response (0x07) tid 8 len 43
        Attribute bytes: 38
        Continuation state: 2
        01 56                                            .V              
< ACL Data TX: Handle 256 flags 0x00 dlen 26                   [hci0] 79.773479
      Channel: 67 len 22 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Request (0x06) tid 9 len 17
        Search pattern: [len 5]
          Sequence (6) with 3 bytes [8 extra bits] len 5
            UUID (3) with 2 bytes [0 extra bits] len 3
              L2CAP (0x0100)
        Max record count: 65535
        Attribute list: [len 7]
          Sequence (6) with 5 bytes [8 extra bits] len 7
            Unsigned Integer (1) with 4 bytes [0 extra bits] len 5
              0x0000ffff
        Continuation state: 2
        01 56                                            .V              
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 79.827259
        Num handles: 1
        Handle: 256
        Count: 1
> ACL Data RX: Handle 256 flags 0x02 dlen 52                   [hci0] 79.853268
      Channel: 64 len 48 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Response (0x07) tid 9 len 43
        Attribute bytes: 38
        Continuation state: 2
        01 7c                                            .|              
< ACL Data TX: Handle 256 flags 0x00 dlen 26                   [hci0] 79.853493
      Channel: 67 len 22 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Request (0x06) tid 10 len 17
        Search pattern: [len 5]
          Sequence (6) with 3 bytes [8 extra bits] len 5
            UUID (3) with 2 bytes [0 extra bits] len 3
              L2CAP (0x0100)
        Max record count: 65535
        Attribute list: [len 7]
          Sequence (6) with 5 bytes [8 extra bits] len 7
            Unsigned Integer (1) with 4 bytes [0 extra bits] len 5
              0x0000ffff
        Continuation state: 2
        01 7c                                            .|              
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 79.858269
        Num handles: 1
        Handle: 256
        Count: 1
> ACL Data RX: Handle 256 flags 0x02 dlen 52                   [hci0] 79.884267
      Channel: 64 len 48 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Response (0x07) tid 10 len 43
        Attribute bytes: 38
        Continuation state: 2
        01 a2                                            ..              
< ACL Data TX: Handle 256 flags 0x00 dlen 26                   [hci0] 79.884493
      Channel: 67 len 22 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Request (0x06) tid 11 len 17
        Search pattern: [len 5]
          Sequence (6) with 3 bytes [8 extra bits] len 5
            UUID (3) with 2 bytes [0 extra bits] len 3
              L2CAP (0x0100)
        Max record count: 65535
        Attribute list: [len 7]
          Sequence (6) with 5 bytes [8 extra bits] len 7
            Unsigned Integer (1) with 4 bytes [0 extra bits] len 5
              0x0000ffff
        Continuation state: 2
        01 a2                                            ..              
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 79.888261
        Num handles: 1
        Handle: 256
        Count: 1
> ACL Data RX: Handle 256 flags 0x02 dlen 52                   [hci0] 79.915266
      Channel: 64 len 48 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Response (0x07) tid 11 len 43
        Attribute bytes: 38
        Continuation state: 2
        01 c8                                            ..              
< ACL Data TX: Handle 256 flags 0x00 dlen 26                   [hci0] 79.915489
      Channel: 67 len 22 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Request (0x06) tid 12 len 17
        Search pattern: [len 5]
          Sequence (6) with 3 bytes [8 extra bits] len 5
            UUID (3) with 2 bytes [0 extra bits] len 3
              L2CAP (0x0100)
        Max record count: 65535
        Attribute list: [len 7]
          Sequence (6) with 5 bytes [8 extra bits] len 7
            Unsigned Integer (1) with 4 bytes [0 extra bits] len 5
              0x0000ffff
        Continuation state: 2
        01 c8                                            ..              
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 79.920266
        Num handles: 1
        Handle: 256
        Count: 1
> ACL Data RX: Handle 256 flags 0x02 dlen 52                   [hci0] 79.947261
      Channel: 64 len 48 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Response (0x07) tid 12 len 43
        Attribute bytes: 38
        Continuation state: 2
        01 ee                                            ..              
< ACL Data TX: Handle 256 flags 0x00 dlen 26                   [hci0] 79.947488
      Channel: 67 len 22 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Request (0x06) tid 13 len 17
        Search pattern: [len 5]
          Sequence (6) with 3 bytes [8 extra bits] len 5
            UUID (3) with 2 bytes [0 extra bits] len 3
              L2CAP (0x0100)
        Max record count: 65535
        Attribute list: [len 7]
          Sequence (6) with 5 bytes [8 extra bits] len 7
            Unsigned Integer (1) with 4 bytes [0 extra bits] len 5
              0x0000ffff
        Continuation state: 2
        01 ee                                            ..              
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 79.952259
        Num handles: 1
        Handle: 256
        Count: 1
> ACL Data RX: Handle 256 flags 0x02 dlen 52                   [hci0] 79.978252
      Channel: 64 len 48 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Response (0x07) tid 13 len 43
        Attribute bytes: 38
        Continuation state: 2
        02 14                                            ..              
< ACL Data TX: Handle 256 flags 0x00 dlen 26                   [hci0] 79.978474
      Channel: 67 len 22 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Request (0x06) tid 14 len 17
        Search pattern: [len 5]
          Sequence (6) with 3 bytes [8 extra bits] len 5
            UUID (3) with 2 bytes [0 extra bits] len 3
              L2CAP (0x0100)
        Max record count: 65535
        Attribute list: [len 7]
          Sequence (6) with 5 bytes [8 extra bits] len 7
            Unsigned Integer (1) with 4 bytes [0 extra bits] len 5
              0x0000ffff
        Continuation state: 2
        02 14                                            ..              
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 79.983257
        Num handles: 1
        Handle: 256
        Count: 1
> ACL Data RX: Handle 256 flags 0x02 dlen 52                   [hci0] 80.009257
      Channel: 64 len 48 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Response (0x07) tid 14 len 43
        Attribute bytes: 38
        Continuation state: 2
        02 3a                                            .:              
< ACL Data TX: Handle 256 flags 0x00 dlen 26                   [hci0] 80.009482
      Channel: 67 len 22 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Request (0x06) tid 15 len 17
        Search pattern: [len 5]
          Sequence (6) with 3 bytes [8 extra bits] len 5
            UUID (3) with 2 bytes [0 extra bits] len 3
              L2CAP (0x0100)
        Max record count: 65535
        Attribute list: [len 7]
          Sequence (6) with 5 bytes [8 extra bits] len 7
            Unsigned Integer (1) with 4 bytes [0 extra bits] len 5
              0x0000ffff
        Continuation state: 2
        02 3a                                            .:              
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 80.013187
        Num handles: 1
        Handle: 256
        Count: 1
> ACL Data RX: Handle 256 flags 0x02 dlen 52                   [hci0] 80.040262
      Channel: 64 len 48 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Response (0x07) tid 15 len 43
        Attribute bytes: 38
        Continuation state: 2
        02 60                                            .`              
< ACL Data TX: Handle 256 flags 0x00 dlen 26                   [hci0] 80.040485
      Channel: 67 len 22 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Request (0x06) tid 16 len 17
        Search pattern: [len 5]
          Sequence (6) with 3 bytes [8 extra bits] len 5
            UUID (3) with 2 bytes [0 extra bits] len 3
              L2CAP (0x0100)
        Max record count: 65535
        Attribute list: [len 7]
          Sequence (6) with 5 bytes [8 extra bits] len 7
            Unsigned Integer (1) with 4 bytes [0 extra bits] len 5
              0x0000ffff
        Continuation state: 2
        02 60                                            .`              
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 80.045261
        Num handles: 1
        Handle: 256
        Count: 1
> ACL Data RX: Handle 256 flags 0x02 dlen 52                   [hci0] 80.072260
      Channel: 64 len 48 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Response (0x07) tid 16 len 43
        Attribute bytes: 38
        Continuation state: 2
        02 86                                            ..              
< ACL Data TX: Handle 256 flags 0x00 dlen 26                   [hci0] 80.072486
      Channel: 67 len 22 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Request (0x06) tid 17 len 17
        Search pattern: [len 5]
          Sequence (6) with 3 bytes [8 extra bits] len 5
            UUID (3) with 2 bytes [0 extra bits] len 3
              L2CAP (0x0100)
        Max record count: 65535
        Attribute list: [len 7]
          Sequence (6) with 5 bytes [8 extra bits] len 7
            Unsigned Integer (1) with 4 bytes [0 extra bits] len 5
              0x0000ffff
        Continuation state: 2
        02 86                                            ..              
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 80.077260
        Num handles: 1
        Handle: 256
        Count: 1
> ACL Data RX: Handle 256 flags 0x02 dlen 52                   [hci0] 80.103264
      Channel: 64 len 48 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Response (0x07) tid 17 len 43
        Attribute bytes: 38
        Continuation state: 2
        02 ac                                            ..              
< ACL Data TX: Handle 256 flags 0x00 dlen 26                   [hci0] 80.103490
      Channel: 67 len 22 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Request (0x06) tid 18 len 17
        Search pattern: [len 5]
          Sequence (6) with 3 bytes [8 extra bits] len 5
            UUID (3) with 2 bytes [0 extra bits] len 3
              L2CAP (0x0100)
        Max record count: 65535
        Attribute list: [len 7]
          Sequence (6) with 5 bytes [8 extra bits] len 7
            Unsigned Integer (1) with 4 bytes [0 extra bits] len 5
              0x0000ffff
        Continuation state: 2
        02 ac                                            ..              
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 80.108256
        Num handles: 1
        Handle: 256
        Count: 1
> ACL Data RX: Handle 256 flags 0x02 dlen 52                   [hci0] 80.134262
      Channel: 64 len 48 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Response (0x07) tid 18 len 43
        Attribute bytes: 38
        Continuation state: 2
        02 d2                                            ..              
< ACL Data TX: Handle 256 flags 0x00 dlen 26                   [hci0] 80.134487
      Channel: 67 len 22 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Request (0x06) tid 19 len 17
        Search pattern: [len 5]
          Sequence (6) with 3 bytes [8 extra bits] len 5
            UUID (3) with 2 bytes [0 extra bits] len 3
              L2CAP (0x0100)
        Max record count: 65535
        Attribute list: [len 7]
          Sequence (6) with 5 bytes [8 extra bits] len 7
            Unsigned Integer (1) with 4 bytes [0 extra bits] len 5
              0x0000ffff
        Continuation state: 2
        02 d2                                            ..              
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 80.138263
        Num handles: 1
        Handle: 256
        Count: 1
> ACL Data RX: Handle 256 flags 0x02 dlen 52                   [hci0] 80.165261
      Channel: 64 len 48 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Response (0x07) tid 19 len 43
        Attribute bytes: 38
        Continuation state: 2
        02 f8                                            ..              
< ACL Data TX: Handle 256 flags 0x00 dlen 26                   [hci0] 80.165485
      Channel: 67 len 22 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Request (0x06) tid 20 len 17
        Search pattern: [len 5]
          Sequence (6) with 3 bytes [8 extra bits] len 5
            UUID (3) with 2 bytes [0 extra bits] len 3
              L2CAP (0x0100)
        Max record count: 65535
        Attribute list: [len 7]
          Sequence (6) with 5 bytes [8 extra bits] len 7
            Unsigned Integer (1) with 4 bytes [0 extra bits] len 5
              0x0000ffff
        Continuation state: 2
        02 f8                                            ..              
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 80.171262
        Num handles: 1
        Handle: 256
        Count: 1
> ACL Data RX: Handle 256 flags 0x02 dlen 52                   [hci0] 80.197258
      Channel: 64 len 48 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Response (0x07) tid 20 len 43
        Attribute bytes: 38
        Continuation state: 2
        03 1e                                            ..              
< ACL Data TX: Handle 256 flags 0x00 dlen 26                   [hci0] 80.197481
      Channel: 67 len 22 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Request (0x06) tid 21 len 17
        Search pattern: [len 5]
          Sequence (6) with 3 bytes [8 extra bits] len 5
            UUID (3) with 2 bytes [0 extra bits] len 3
              L2CAP (0x0100)
        Max record count: 65535
        Attribute list: [len 7]
          Sequence (6) with 5 bytes [8 extra bits] len 7
            Unsigned Integer (1) with 4 bytes [0 extra bits] len 5
              0x0000ffff
        Continuation state: 2
        03 1e                                            ..              
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 80.202263
        Num handles: 1
        Handle: 256
        Count: 1
> ACL Data RX: Handle 256 flags 0x02 dlen 52                   [hci0] 80.228266
      Channel: 64 len 48 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Response (0x07) tid 21 len 43
        Attribute bytes: 38
        Continuation state: 2
        03 44                                            .D              
< ACL Data TX: Handle 256 flags 0x00 dlen 26                   [hci0] 80.228489
      Channel: 67 len 22 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Request (0x06) tid 22 len 17
        Search pattern: [len 5]
          Sequence (6) with 3 bytes [8 extra bits] len 5
            UUID (3) with 2 bytes [0 extra bits] len 3
              L2CAP (0x0100)
        Max record count: 65535
        Attribute list: [len 7]
          Sequence (6) with 5 bytes [8 extra bits] len 7
            Unsigned Integer (1) with 4 bytes [0 extra bits] len 5
              0x0000ffff
        Continuation state: 2
        03 44                                            .D              
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 80.233262
        Num handles: 1
        Handle: 256
        Count: 1
> ACL Data RX: Handle 256 flags 0x02 dlen 52                   [hci0] 80.259267
      Channel: 64 len 48 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Response (0x07) tid 22 len 43
        Attribute bytes: 38
        Continuation state: 2
        03 6a                                            .j              
< ACL Data TX: Handle 256 flags 0x00 dlen 26                   [hci0] 80.259492
      Channel: 67 len 22 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Request (0x06) tid 23 len 17
        Search pattern: [len 5]
          Sequence (6) with 3 bytes [8 extra bits] len 5
            UUID (3) with 2 bytes [0 extra bits] len 3
              L2CAP (0x0100)
        Max record count: 65535
        Attribute list: [len 7]
          Sequence (6) with 5 bytes [8 extra bits] len 7
            Unsigned Integer (1) with 4 bytes [0 extra bits] len 5
              0x0000ffff
        Continuation state: 2
        03 6a                                            .j              
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 80.263258
        Num handles: 1
        Handle: 256
        Count: 1
> ACL Data RX: Handle 256 flags 0x02 dlen 52                   [hci0] 80.290265
      Channel: 64 len 48 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Response (0x07) tid 23 len 43
        Attribute bytes: 38
        Continuation state: 2
        03 90                                            ..              
< ACL Data TX: Handle 256 flags 0x00 dlen 26                   [hci0] 80.290491
      Channel: 67 len 22 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Request (0x06) tid 24 len 17
        Search pattern: [len 5]
          Sequence (6) with 3 bytes [8 extra bits] len 5
            UUID (3) with 2 bytes [0 extra bits] len 3
              L2CAP (0x0100)
        Max record count: 65535
        Attribute list: [len 7]
          Sequence (6) with 5 bytes [8 extra bits] len 7
            Unsigned Integer (1) with 4 bytes [0 extra bits] len 5
              0x0000ffff
        Continuation state: 2
        03 90                                            ..              
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 80.295258
        Num handles: 1
        Handle: 256
        Count: 1
> ACL Data RX: Handle 256 flags 0x02 dlen 52                   [hci0] 80.322267
      Channel: 64 len 48 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Response (0x07) tid 24 len 43
        Attribute bytes: 38
        Continuation state: 2
        03 b6                                            ..              
< ACL Data TX: Handle 256 flags 0x00 dlen 26                   [hci0] 80.322491
      Channel: 67 len 22 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Request (0x06) tid 25 len 17
        Search pattern: [len 5]
          Sequence (6) with 3 bytes [8 extra bits] len 5
            UUID (3) with 2 bytes [0 extra bits] len 3
              L2CAP (0x0100)
        Max record count: 65535
        Attribute list: [len 7]
          Sequence (6) with 5 bytes [8 extra bits] len 7
            Unsigned Integer (1) with 4 bytes [0 extra bits] len 5
              0x0000ffff
        Continuation state: 2
        03 b6                                            ..              
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 80.327257
        Num handles: 1
        Handle: 256
        Count: 1
> ACL Data RX: Handle 256 flags 0x02 dlen 21                   [hci0] 80.352266
      Channel: 64 len 17 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Response (0x07) tid 25 len 12
        Attribute bytes: 9
        Continuation state: 0
        Combined attribute bytes: 959
          Attribute list: [len 142] {position 0}
            Attribute: Service Record Handle (0x0000) [len 2]
              0x00000000
            Attribute: Service Class ID List (0x0001) [len 2]
              UUID (3) with 2 bytes [0 extra bits] len 3
                Service Discovery Server Service Class (0x1000)
            Attribute: Protocol Descriptor List (0x0004) [len 2]
              Sequence (6) with 6 bytes [8 extra bits] len 8
                UUID (3) with 2 bytes [0 extra bits] len 3
                  L2CAP (0x0100)
                Unsigned Integer (1) with 2 bytes [0 extra bits] len 3
                  0x0001
              Sequence (6) with 3 bytes [8 extra bits] len 5
                UUID (3) with 2 bytes [0 extra bits] len 3
                  SDP (0x0001)
            Attribute: Browse Group List (0x0005) [len 2]
              UUID (3) with 2 bytes [0 extra bits] len 3
                Public Browse Root (0x1002)
            Attribute: Language Base Attribute ID List (0x0006) [len 2]
              Unsigned Integer (1) with 2 bytes [0 extra bits] len 3
                0x656e
              Unsigned Integer (1) with 2 bytes [0 extra bits] len 3
                0x006a
              Unsigned Integer (1) with 2 bytes [0 extra bits] len 3
                0x0100
            Attribute: Bluetooth Profile Descriptor List (0x0009) [len 2]
              Sequence (6) with 6 bytes [8 extra bits] len 8
                UUID (3) with 2 bytes [0 extra bits] len 3
                  L2CAP (0x0100)
                Unsigned Integer (1) with 2 bytes [0 extra bits] len 3
                  0x0100
            Attribute: Unknown (0x0100) [len 2]
              Bluetooth Keyboard SNP Server                   [len 47]
            Attribute: Unknown (0x0101) [len 2]
              Keyboard [len 8]
            Attribute: Unknown (0x0200) [len 2]
              Unsigned Integer (1) with 2 bytes [0 extra bits] len 3
                0x0100
          Attribute list: [len 644] {position 1}
            Attribute: Service Record Handle (0x0000) [len 2]
              0x00010000
            Attribute: Service Class ID List (0x0001) [len 2]
              UUID (3) with 2 bytes [0 extra bits] len 3
                Human Interface Device Service (0x1124)
            Attribute: Protocol Descriptor List (0x0004) [len 2]
              Sequence (6) with 6 bytes [8 extra bits] len 8
                UUID (3) with 2 bytes [0 extra bits] len 3
                  L2CAP (0x0100)
                Unsigned Integer (1) with 2 bytes [0 extra bits] len 3
                  0x0011
              Sequence (6) with 3 bytes [8 extra bits] len 5
                UUID (3) with 2 bytes [0 extra bits] len 3
                  HIDP (0x0011)
            Attribute: Browse Group List (0x0005) [len 2]
              UUID (3) with 2 bytes [0 extra bits] len 3
                Public Browse Root (0x1002)
            Attribute: Language Base Attribute ID List (0x0006) [len 2]
              Unsigned Integer (1) with 2 bytes [0 extra bits] len 3
                0x656e
              Unsigned Integer (1) with 2 bytes [0 extra bits] len 3
                0x006a
              Unsigned Integer (1) with 2 bytes [0 extra bits] len 3
                0x0100
            Attribute: Bluetooth Profile Descriptor List (0x0009) [len 2]
              Sequence (6) with 6 bytes [8 extra bits] len 8
                UUID (3) with 2 bytes [0 extra bits] len 3
                  Human Interface Device Service (0x1124)
                Unsigned Integer (1) with 2 bytes [0 extra bits] len 3
                  0x0101
            Attribute: Additional Protocol Descriptor List (0x000d) [len 2]
              Sequence (6) with 13 bytes [8 extra bits] len 15
                Sequence (6) with 6 bytes [8 extra bits] len 8
                  UUID (3) with 2 bytes [0 extra bits] len 3
                    L2CAP (0x0100)
                  Unsigned Integer (1) with 2 bytes [0 extra bits] len 3
                    0x0013
                Sequence (6) with 3 bytes [8 extra bits] len 5
                  UUID (3) with 2 bytes [0 extra bits] len 3
                    HIDP (0x0011)
            Attribute: Unknown (0x0100) [len 2]
              Bluetooth Keyboard                                            [len 61]
            Attribute: Unknown (0x0101) [len 2]
              Keyboard [len 8]
            Attribute: Unknown (0x0102) [len 2]
              Lenovo [len 6]
            Attribute: Unknown (0x0201) [len 2]
              0x0111
            Attribute: Unknown (0x0202) [len 2]
              0x40
            Attribute: Unknown (0x0203) [len 2]
              0x21
            Attribute: Unknown (0x0204) [len 2]
              true
            Attribute: Unknown (0x0205) [len 2]
              true
            Attribute: Unknown (0x0206) [len 2]
              Sequence (6) with 379 bytes [16 extra bits] len 382
                Unsigned Integer (1) with 1 byte [0 extra bits] len 2
                  0x22
                String (4) with 374 bytes [16 extra bits] len 377
                  	¡…u•à) [len 374]
            Attribute: Unknown (0x0207) [len 2]
              Sequence (6) with 6 bytes [8 extra bits] len 8
                Unsigned Integer (1) with 2 bytes [0 extra bits] len 3
                  0x0409
                Unsigned Integer (1) with 2 bytes [0 extra bits] len 3
                  0x0100
            Attribute: Unknown (0x0209) [len 2]
              true
            Attribute: Unknown (0x020a) [len 2]
              true
            Attribute: Unknown (0x020c) [len 2]
              0x0c80
            Attribute: Unknown (0x020d) [len 2]
              false
            Attribute: Unknown (0x020e) [len 2]
              true
            Attribute: Unknown (0x020f) [len 2]
              0x0318
            Attribute: Unknown (0x0210) [len 2]
              0x0000
          Attribute list: [len 161] {position 2}
            Attribute: Service Record Handle (0x0000) [len 2]
              0x00010001
            Attribute: Service Class ID List (0x0001) [len 2]
              UUID (3) with 2 bytes [0 extra bits] len 3
                PnP Information (0x1200)
            Attribute: Protocol Descriptor List (0x0004) [len 2]
              Sequence (6) with 6 bytes [8 extra bits] len 8
                UUID (3) with 2 bytes [0 extra bits] len 3
                  L2CAP (0x0100)
                Unsigned Integer (1) with 2 bytes [0 extra bits] len 3
                  0x0001
              Sequence (6) with 3 bytes [8 extra bits] len 5
                UUID (3) with 2 bytes [0 extra bits] len 3
                  SDP (0x0001)
            Attribute: Language Base Attribute ID List (0x0006) [len 2]
              Unsigned Integer (1) with 2 bytes [0 extra bits] len 3
                0x656e
              Unsigned Integer (1) with 2 bytes [0 extra bits] len 3
                0x006a
              Unsigned Integer (1) with 2 bytes [0 extra bits] len 3
                0x0100
            Attribute: Bluetooth Profile Descriptor List (0x0009) [len 2]
              Sequence (6) with 6 bytes [8 extra bits] len 8
                UUID (3) with 2 bytes [0 extra bits] len 3
                  PnP Information (0x1200)
                Unsigned Integer (1) with 2 bytes [0 extra bits] len 3
                  0x0100
            Attribute: Unknown (0x0100) [len 2]
              Bluetooth Keyboard PNP Server                   [len 47]
            Attribute: Unknown (0x0101) [len 2]
              Keyboard [len 8]
            Attribute: Unknown (0x0200) [len 2]
              0x0103
            Attribute: Unknown (0x0201) [len 2]
              0x17ef
            Attribute: Unknown (0x0202) [len 2]
              0x6048
            Attribute: Unknown (0x0203) [len 2]
              0x0309
            Attribute: Unknown (0x0204) [len 2]
              true
            Attribute: Unknown (0x0205) [len 2]
              0x0002
< ACL Data TX: Handle 256 flags 0x00 dlen 24                   [hci0] 80.434689
      Channel: 67 len 20 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Request (0x06) tid 26 len 15
        Search pattern: [len 5]
          Sequence (6) with 3 bytes [8 extra bits] len 5
            UUID (3) with 2 bytes [0 extra bits] len 3
              PnP Information (0x1200)
        Max record count: 65535
        Attribute list: [len 7]
          Sequence (6) with 5 bytes [8 extra bits] len 7
            Unsigned Integer (1) with 4 bytes [0 extra bits] len 5
              0x0000ffff
        Continuation state: 0
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 80.438114
        Num handles: 1
        Handle: 256
        Count: 1
> ACL Data RX: Handle 256 flags 0x02 dlen 52                   [hci0] 80.464105
      Channel: 64 len 48 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Response (0x07) tid 26 len 43
        Attribute bytes: 38
        Continuation state: 2
        00 26                                            .&              
< ACL Data TX: Handle 256 flags 0x00 dlen 26                   [hci0] 80.479364
      Channel: 67 len 22 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Request (0x06) tid 27 len 17
        Search pattern: [len 5]
          Sequence (6) with 3 bytes [8 extra bits] len 5
            UUID (3) with 2 bytes [0 extra bits] len 3
              PnP Information (0x1200)
        Max record count: 65535
        Attribute list: [len 7]
          Sequence (6) with 5 bytes [8 extra bits] len 7
            Unsigned Integer (1) with 4 bytes [0 extra bits] len 5
              0x0000ffff
        Continuation state: 2
        00 26                                            .&              
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 80.483113
        Num handles: 1
        Handle: 256
        Count: 1
> ACL Data RX: Handle 256 flags 0x02 dlen 52                   [hci0] 80.509260
      Channel: 64 len 48 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Response (0x07) tid 27 len 43
        Attribute bytes: 38
        Continuation state: 2
        00 4c                                            .L              
< ACL Data TX: Handle 256 flags 0x00 dlen 26                   [hci0] 80.509473
      Channel: 67 len 22 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Request (0x06) tid 28 len 17
        Search pattern: [len 5]
          Sequence (6) with 3 bytes [8 extra bits] len 5
            UUID (3) with 2 bytes [0 extra bits] len 3
              PnP Information (0x1200)
        Max record count: 65535
        Attribute list: [len 7]
          Sequence (6) with 5 bytes [8 extra bits] len 7
            Unsigned Integer (1) with 4 bytes [0 extra bits] len 5
              0x0000ffff
        Continuation state: 2
        00 4c                                            .L              
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 80.513266
        Num handles: 1
        Handle: 256
        Count: 1
> ACL Data RX: Handle 256 flags 0x02 dlen 52                   [hci0] 80.540259
      Channel: 64 len 48 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Response (0x07) tid 28 len 43
        Attribute bytes: 38
        Continuation state: 2
        00 72                                            .r              
< ACL Data TX: Handle 256 flags 0x00 dlen 26                   [hci0] 80.540483
      Channel: 67 len 22 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Request (0x06) tid 29 len 17
        Search pattern: [len 5]
          Sequence (6) with 3 bytes [8 extra bits] len 5
            UUID (3) with 2 bytes [0 extra bits] len 3
              PnP Information (0x1200)
        Max record count: 65535
        Attribute list: [len 7]
          Sequence (6) with 5 bytes [8 extra bits] len 7
            Unsigned Integer (1) with 4 bytes [0 extra bits] len 5
              0x0000ffff
        Continuation state: 2
        00 72                                            .r              
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 80.545255
        Num handles: 1
        Handle: 256
        Count: 1
> ACL Data RX: Handle 256 flags 0x02 dlen 52                   [hci0] 80.572264
      Channel: 64 len 48 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Response (0x07) tid 29 len 43
        Attribute bytes: 38
        Continuation state: 2
        00 98                                            ..              
< ACL Data TX: Handle 256 flags 0x00 dlen 26                   [hci0] 80.572490
      Channel: 67 len 22 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Request (0x06) tid 30 len 17
        Search pattern: [len 5]
          Sequence (6) with 3 bytes [8 extra bits] len 5
            UUID (3) with 2 bytes [0 extra bits] len 3
              PnP Information (0x1200)
        Max record count: 65535
        Attribute list: [len 7]
          Sequence (6) with 5 bytes [8 extra bits] len 7
            Unsigned Integer (1) with 4 bytes [0 extra bits] len 5
              0x0000ffff
        Continuation state: 2
        00 98                                            ..              
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 80.577261
        Num handles: 1
        Handle: 256
        Count: 1
> ACL Data RX: Handle 256 flags 0x02 dlen 27                   [hci0] 80.602268
      Channel: 64 len 23 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Response (0x07) tid 30 len 18
        Attribute bytes: 15
        Continuation state: 0
        Combined attribute bytes: 167
          Attribute list: [len 161] {position 0}
            Attribute: Service Record Handle (0x0000) [len 2]
              0x00010001
            Attribute: Service Class ID List (0x0001) [len 2]
              UUID (3) with 2 bytes [0 extra bits] len 3
                PnP Information (0x1200)
            Attribute: Protocol Descriptor List (0x0004) [len 2]
              Sequence (6) with 6 bytes [8 extra bits] len 8
                UUID (3) with 2 bytes [0 extra bits] len 3
                  L2CAP (0x0100)
                Unsigned Integer (1) with 2 bytes [0 extra bits] len 3
                  0x0001
              Sequence (6) with 3 bytes [8 extra bits] len 5
                UUID (3) with 2 bytes [0 extra bits] len 3
                  SDP (0x0001)
            Attribute: Language Base Attribute ID List (0x0006) [len 2]
              Unsigned Integer (1) with 2 bytes [0 extra bits] len 3
                0x656e
              Unsigned Integer (1) with 2 bytes [0 extra bits] len 3
                0x006a
              Unsigned Integer (1) with 2 bytes [0 extra bits] len 3
                0x0100
            Attribute: Bluetooth Profile Descriptor List (0x0009) [len 2]
              Sequence (6) with 6 bytes [8 extra bits] len 8
                UUID (3) with 2 bytes [0 extra bits] len 3
                  PnP Information (0x1200)
                Unsigned Integer (1) with 2 bytes [0 extra bits] len 3
                  0x0100
            Attribute: Unknown (0x0100) [len 2]
              Bluetooth Keyboard PNP Server                   [len 47]
            Attribute: Unknown (0x0101) [len 2]
              Keyboard [len 8]
            Attribute: Unknown (0x0200) [len 2]
              0x0103
            Attribute: Unknown (0x0201) [len 2]
              0x17ef
            Attribute: Unknown (0x0202) [len 2]
              0x6048
            Attribute: Unknown (0x0203) [len 2]
              0x0309
            Attribute: Unknown (0x0204) [len 2]
              true
            Attribute: Unknown (0x0205) [len 2]
              0x0002
< HCI Command: Authentication Requested (0x01|0x0011) plen 2   [hci0] 80.668689
        Handle: 256
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 80.670115
      Authentication Requested (0x01|0x0011) ncmd 1
        Status: Success (0x00)
> HCI Event: Link Key Request (0x17) plen 6                    [hci0] 80.671104
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
< HCI Command: Link Key Request Negati.. (0x01|0x000c) plen 6  [hci0] 80.671150
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
> HCI Event: Command Complete (0x0e) plen 10                   [hci0] 80.673101
      Link Key Request Negative Reply (0x01|0x000c) ncmd 1
        Status: Success (0x00)
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
> HCI Event: PIN Code Request (0x16) plen 6                    [hci0] 80.674170
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
@ PIN Code Request: 90:7F:61:xx:xx:xx (0) secure 0x00
< HCI Command: PIN Code Request Negati.. (0x01|0x000e) plen 6  [hci0] 80.713488
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
> HCI Event: Command Complete (0x0e) plen 10                   [hci0] 80.715108
      PIN Code Request Negative Reply (0x01|0x000e) ncmd 1
        Status: Success (0x00)
        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
> HCI Event: Auth Complete (0x06) plen 3                       [hci0] 80.716170
        Status: PIN or Key Missing (0x06)
        Handle: 256
@ Authentication Failed: 90:7F:61:xx:xx:xx (0) status 0x05
< ACL Data TX: Handle 256 flags 0x00 dlen 12                   [hci0] 83.015918
      L2CAP: Disconnection Request (0x06) ident 5 len 4
        Destination CID: 67
        Source CID: 64
> ACL Data RX: Handle 256 flags 0x02 dlen 12                   [hci0] 83.020118
      L2CAP: Disconnection Response (0x07) ident 5 len 4
        Destination CID: 67
        Source CID: 64
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 83.020143
        Num handles: 1
        Handle: 256
        Count: 1
< HCI Command: Read Clock Offset (0x01|0x001f) plen 2          [hci0] 85.024128
        Handle: 256
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 85.026261
      Read Clock Offset (0x01|0x001f) ncmd 1
        Status: Success (0x00)
< HCI Command: Disconnect (0x01|0x0006) plen 3                 [hci0] 85.026360
        Handle: 256
        Reason: Remote User Terminated Connection (0x13)
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 85.028269
      Disconnect (0x01|0x0006) ncmd 1
        Status: Success (0x00)
> HCI Event: Read Clock Offset Complete (0x1c) plen 5          [hci0] 85.030266
        Status: Success (0x00)
        Handle: 256
        Clock offset: 0x56e0
> HCI Event: Disconnect Complete (0x05) plen 4

-JimC
-- 
James Cloos <cloos@jhcloos.com>         OpenPGP: 0x997A9F17ED7DAEA6
