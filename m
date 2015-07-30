Return-Path: <cyrus@holtmann.org>
Message-ID: <55BA2290.8090308@gmail.com>
Date: Thu, 30 Jul 2015 15:11:44 +0200
From: Florian Grandel <fgrandel@gmail.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Szymon Janc <Szymon.Janc@tieto.com>,
 BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: Problems with incoming connection request on Nexus 4
References: <55B83614.8090702@gmail.com> <BC4DBE9E-8369-4B20-BBE5-F175DD4C5626@holtmann.org> <55BA16BA.5060302@gmail.com> <F5B83C8F-6BD0-49C8-96C9-F13DF68CEECE@holtmann.org>
In-Reply-To: <F5B83C8F-6BD0-49C8-96C9-F13DF68CEECE@holtmann.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel and Szymon,

On 07/30/2015 02:25 PM, Marcel Holtmann wrote:
> Hi Florian,
>
>>>> Symptoms:
>>>> - The connection request times out.
>>>> - bt_io_accept() is being called but the accept_cb (=connect_cb) only gets called when the request times out.
>>>> - the device is stuck in the CONNECT READY state and never reaches the CONNECTED state
>>>>
>>>>
>>>> Any ideas how I could analyze/solve that problem? I'm stuck on this for many hours already...
>>>
>>> what does btmon actually tell you about what is going on with HCI.
>>
>> = New Index: 10:68:3F:56:AD:35 (BR/EDR,UNKNOWN,hci0)            [hci0] 0.629837
>> @ Advertising Added: 1
>> < HCI Command: LE Set Advertising Para.. (0x08|0x0006) plen 15  [hci0] 4.398493
>>         Min advertising interval: 1280.000 msec (0x0800)
>>         Max advertising interval: 1280.000 msec (0x0800)
>>         Type: Connectable undirected - ADV_IND (0x00)
>>         Own address type: Public (0x00)
>>         Direct address type: Public (0x00)
>>         Direct address: 00:00:00:00:00:00 (OUI 00-00-00)
>>         Channel map: 37, 38, 39 (0x07)
>>         Filter policy: Allow Scan Request from Any, Allow Connect Request from Any (0x00)
>>> HCI Event: Command Complete (0x0e) plen 4                     [hci0] 4.401392
>>       LE Set Advertising Parameters (0x08|0x0006) ncmd 1
>>         Status: Success (0x00)
>> < HCI Command: LE Set Advertise Enable (0x08|0x000a) plen 1     [hci0] 4.401484
>>         Advertising: Enabled (0x01)
>>> HCI Event: Command Complete (0x0e) plen 4                     [hci0] 4.402277
>>       LE Set Advertise Enable (0x08|0x000a) ncmd 1
>>         Status: Success (0x00)
>>
>> There is no connection related HCI activity going on at all on the Nexus 4 side. You can see from the debug logs that I sent before, that the connection is being initiated correctly. The bt_io_accept() call does return without error, just the accept callback never gets called. To me it seems as if the Nexus4 was not responding to the incoming connect request.
>
> we are advertising now. If the HCI traffic stays this way, then we are basically waiting for the central to connect to us. It is up to your Nexus 4 to connect.
>
> If it would connect, then you would see an LE Connect Complete event indicated that the connection has been established.

Sorry, I left out the actual connection part the first time. Here it is:

= New Index: 10:68:3F:56:AD:35 (BR/EDR,UNKNOWN,hci0)            [hci0] 
0.248759
 > HCI Event: Connect Request (0x04) plen 10                     [hci0] 
9.147279
         Address: 94:01:C2:AB:46:05 (OUI 94-01-C2)
         Class: 0x5a020c
           Major class: Phone (cellular, cordless, payphone, modem)
           Minor class: Smart phone
           Networking (LAN, Ad hoc)
           Capturing (Scanner, Microphone)
           Object Transfer (v-Inbox, v-Folder)
           Telephony (Cordless telephony, Modem, Headset)
         Link type: ACL (0x01)
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7   [hci0] 
9.147523
         Address: 94:01:C2:AB:46:05 (OUI 94-01-C2)
         Role: Master (0x00)
 > HCI Event: Command Status (0x0f) plen 4                       [hci0] 
9.148347
       Accept Connection Request (0x01|0x0009) ncmd 1
         Status: Success (0x00)
 > HCI Event: Role Change (0x12) plen 8                          [hci0] 
9.402337
         Status: Success (0x00)
         Address: 94:01:C2:AB:46:05 (OUI 94-01-C2)
         Role: Master (0x00)
 > HCI Event: Connect Complete (0x03) plen 11                    [hci0] 
9.415339
         Status: Success (0x00)
         Handle: 4
         Address: 94:01:C2:AB:46:05 (OUI 94-01-C2)
         Link type: ACL (0x01)
         Encryption: Disabled (0x00)
 > HCI Event: Max Slots Change (0x1b) plen 3                     [hci0] 
9.417506
         Handle: 4
         Max slots: 5
< HCI Command: Read Remote Supported Fe.. (0x01|0x001b) plen 2  [hci0] 
9.418360
         Handle: 4
 > HCI Event: Command Status (0x0f) plen 4                       [hci0] 
9.418910
       Read Remote Supported Features (0x01|0x001b) ncmd 1
         Status: Success (0x00)
 > HCI Event: Read Remote Supported Features (0x0b) plen 11      [hci0] 
9.423793
         Status: Success (0x00)
         Handle: 4
         Features: 0xbf 0xfe 0xcf 0xff 0xdf 0xff 0x7b 0x87
           3 slot packets
           5 slot packets
           Encryption
           Slot offset
           Timing accuracy
           Role switch
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
           Flow control lag (most significant bit)
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
           LE Supported (Controller)
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
           Simultaneous LE and BR/EDR (Controller)
           Secure Simple Pairing
           Encapsulated PDU
           Erroneous Data Reporting
           Non-flushable Packet Boundary Flag
           Link Supervision Timeout Changed Event
           Inquiry TX Power Level
           Enhanced Power Control
           Extended features
           Unknown features (0x0000000401000000)
< HCI Command: Read Remote Extended Fea.. (0x01|0x001c) plen 3  [hci0] 
9.423946
         Handle: 4
         Page: 1
 > HCI Event: Command Status (0x0f) plen 4                       [hci0] 
9.424373
       Read Remote Extended Features (0x01|0x001c) ncmd 1
         Status: Success (0x00)
 > ACL Data RX: Handle 4 flags 0x02 dlen 10                      [hci0] 
9.426235
       L2CAP: Information Request (0x0a) ident 2 len 2
         Type: Extended features supported (0x0002)
 > HCI Event: Read Remote Extended Features (0x23) plen 13       [hci0] 
9.427517
         Status: Success (0x00)
         Handle: 4
         Page: 1/1
         Features: 0x03 0x00 0x00 0x00 0x00 0x00 0x00 0x00
           Secure Simple Pairing (Host Support)
           LE Supported (Host)
< HCI Command: Remote Name Request (0x01|0x0019) plen 10        [hci0] 
9.427944
         Address: 94:01:C2:AB:46:05 (OUI 94-01-C2)
         Page scan repetition mode: R2 (0x02)
         Page scan mode: Mandatory (0x00)
         Clock offset: 0x0000
< ACL Data TX: Handle 4 flags 0x00 dlen 10                      [hci0] 
9.428005
       L2CAP: Information Request (0x0a) ident 1 len 2
         Type: Extended features supported (0x0002)
< ACL Data TX: Handle 4 flags 0x00 dlen 16                      [hci0] 
9.428066
       L2CAP: Information Response (0x0b) ident 2 len 8
         Type: Extended features supported (0x0002)
         Result: Success (0x0000)
         Features: 0x000002b8
           Enhanced Retransmission Mode
           Streaming Mode
           FCS Option
           Fixed Channels
           Unicast Connectionless Data Reception
 > HCI Event: Command Status (0x0f) plen 4                       [hci0] 
9.428554
       Remote Name Request (0x01|0x0019) ncmd 1
         Status: Success (0x00)
 > HCI Event: Remote Name Req Complete (0x07) plen 255           [hci0] 
9.432522
         Status: Success (0x00)
         Address: 94:01:C2:AB:46:05 (OUI 94-01-C2)
         Name: fg-samsung
 > HCI Event: Number of Completed Packets (0x13) plen 5          [hci0] 
9.433102
         Num handles: 1
         Handle: 4
         Count: 1
@ Device Connected: 94:01:C2:AB:46:05 (0) flags 0x0000
         0b 09 66 67 2d 73 61 6d 73 75 6e 67 04 0d 0c 02  ..fg-samsung....
         5a                                               Z
 > HCI Event: Link Key Request (0x17) plen 6                     [hci0] 
9.558724
         Address: 94:01:C2:AB:46:05 (OUI 94-01-C2)
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22     [hci0] 
9.558785
         Address: 94:01:C2:AB:46:05 (OUI 94-01-C2)
         Link key: 80a94e676e77657ad219b275c1c2964a
 > HCI Event: Command Complete (0x0e) plen 10                    [hci0] 
9.558998
       Link Key Request Reply (0x01|0x000b) ncmd 1
         Status: Success (0x00)
         Address: 94:01:C2:AB:46:05 (OUI 94-01-C2)
 > HCI Event: Number of Completed Packets (0x13) plen 5          [hci0] 
9.559304
         Num handles: 1
         Handle: 4
         Count: 1
 > ACL Data RX: Handle 4 flags 0x02 dlen 16                      [hci0] 
9.559944
       L2CAP: Information Response (0x0b) ident 1 len 8
         Type: Extended features supported (0x0002)
         Result: Success (0x0000)
         Features: 0x000000b8
           Enhanced Retransmission Mode
           Streaming Mode
           FCS Option
           Fixed Channels
< ACL Data TX: Handle 4 flags 0x00 dlen 10                      [hci0] 
9.560006
       L2CAP: Information Request (0x0a) ident 2 len 2
         Type: Fixed channels supported (0x0003)
 > ACL Data RX: Handle 4 flags 0x02 dlen 10                      [hci0] 
9.562447
       L2CAP: Information Request (0x0a) ident 3 len 2
         Type: Fixed channels supported (0x0003)
< ACL Data TX: Handle 4 flags 0x00 dlen 20                      [hci0] 
9.562508
       L2CAP: Information Response (0x0b) ident 3 len 12
         Type: Fixed channels supported (0x0003)
         Result: Success (0x0000)
         Channels: 0x0000000000000086
           L2CAP Signaling (BR/EDR)
           Connectionless reception
           Security Manager (BR/EDR)
 > HCI Event: Number of Completed Packets (0x13) plen 5          [hci0] 
9.564309
         Num handles: 1
         Handle: 4
         Count: 1
 > HCI Event: Number of Completed Packets (0x13) plen 5          [hci0] 
9.586802
         Num handles: 1
         Handle: 4
         Count: 1
 > HCI Event: Encryption Change (0x08) plen 4                    [hci0] 
9.680012
         Status: Success (0x00)
         Handle: 4
         Encryption: Enabled with E0 (0x01)
< HCI Command: Read Encryption Key Size (0x05|0x0008) plen 2    [hci0] 
9.680042
         Handle: 4
 > HCI Event: Command Complete (0x0e) plen 7                     [hci0] 
9.680256
       Read Encryption Key Size (0x05|0x0008) ncmd 1
         Status: Success (0x00)
         Handle: 4
         Key size: 16
 > ACL Data RX: Handle 4 flags 0x02 dlen 20                      [hci0] 
9.682453
       L2CAP: Information Response (0x0b) ident 2 len 12
         Type: Fixed channels supported (0x0003)
         Result: Success (0x0000)
         Channels: 0x0000000000000052
           L2CAP Signaling (BR/EDR)
           Attribute Protocol
           Security Manager (LE)
 > ACL Data RX: Handle 4 flags 0x02 dlen 12                      [hci0] 
9.683674
       L2CAP: Connection Request (0x02) ident 4 len 4
         PSM: 31 (0x001f)
         Source CID: 66
< ACL Data TX: Handle 4 flags 0x00 dlen 16                      [hci0] 
9.683766
       L2CAP: Connection Response (0x03) ident 4 len 8
         Destination CID: 64
         Source CID: 66
         Result: Connection pending (0x0001)
         Status: Authorization pending (0x0002)
< ACL Data TX: Handle 4 flags 0x00 dlen 16                      [hci0] 
9.686970
       L2CAP: Connection Response (0x03) ident 4 len 8
         Destination CID: 64
         Source CID: 66
         Result: Connection successful (0x0000)
         Status: No further information available (0x0000)
< ACL Data TX: Handle 4 flags 0x00 dlen 23                      [hci0] 
9.687031
       L2CAP: Configure Request (0x04) ident 3 len 15
         Destination CID: 66
         Flags: 0x0000
         Option: Retransmission and Flow Control (0x04) [mandatory]
           Mode: Basic (0x00)
           TX window size: 0
           Max transmit: 0
           Retransmission timeout: 0
           Monitor timeout: 0
           Maximum PDU size: 0
 > HCI Event: Number of Completed Packets (0x13) plen 5          [hci0] 
9.686787
         Num handles: 1
         Handle: 4
         Count: 1
 > HCI Event: Number of Completed Packets (0x13) plen 5          [hci0] 
9.689687
         Num handles: 1
         Handle: 4
         Count: 1
 > HCI Event: Number of Completed Packets (0x13) plen 5          [hci0] 
9.690602
         Num handles: 1
         Handle: 4
         Count: 1
 > ACL Data RX: Handle 4 flags 0x02 dlen 12                     [hci0] 
39.623824
       L2CAP: Disconnection Request (0x06) ident 5 len 4
         Destination CID: 64
         Source CID: 66
< ACL Data TX: Handle 4 flags 0x00 dlen 12                     [hci0] 
39.624037
       L2CAP: Disconnection Response (0x07) ident 5 len 4
         Destination CID: 64
         Source CID: 66
 > HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 
39.626815
         Num handles: 1
         Handle: 4
         Count: 1
< HCI Command: Read Clock Offset (0x01|0x001f) plen 2          [hci0] 
43.626998
         Handle: 4
 > HCI Event: Command Status (0x0f) plen 4                      [hci0] 
43.627547
       Read Clock Offset (0x01|0x001f) ncmd 1
         Status: Success (0x00)
< HCI Command: Disconnect (0x01|0x0006) plen 3                 [hci0] 
43.627791
         Handle: 4
         Reason: Remote User Terminated Connection (0x13)
 > HCI Event: Command Status (0x0f) plen 4                      [hci0] 
43.628249
       Disconnect (0x01|0x0006) ncmd 1
         Status: Success (0x00)
 > HCI Event: Read Clock Offset Complete (0x1c) plen 5          [hci0] 
43.637192
         Status: Connection Terminated By Local Host (0x16)
         Handle: 4
         Clock offset: 0x0000
 > HCI Event: Disconnect Complete (0x05) plen 4                 [hci0] 
43.637283
         Status: Success (0x00)
         Handle: 4
         Reason: Connection Terminated By Local Host (0x16)
@ Device Disconnected: 94:01:C2:AB:46:05 (0) reason 2

Can you seen anything from this?

Thanks!

Florian
