Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
From: Scott <scottbholt@gmail.com>
Subject: Issue using obexftp -l
Message-ID: <7a1e24b2-44cf-03cc-1b0c-ded47df39929@gmail.com>
Date: Thu, 21 Dec 2017 11:35:42 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello, My name is Scott and am new to the list.  I am currently 
attempting to use obexftp (and hopefully later obexfs) to move files 
between an Android device (Android 7.1.1) and a device using 
openembedded Linux (Ettus E312).  I am attempting to use USB Bluetooth 
Dongles (have tried both Broadcom BCM2072A0 chips and CSR chips) with 
the same results.  I am currently able to push a file from the Linux 
device to the Android device, but cannot move anything from the Android 
device to the Linux device (either pulling from Linux device or pushing 
from Android device).  Any help/advice is much appreciated!

uname -r:  3.14.2-xilinx

bluetoothd -v:  4.101

bluetoothctl -v:  5.47

lsusb:  Bus 001 Device 004: ID 0a5c:21e8 Broadcom Corp. BCM20702A0 
Bluetooth 4.0

hcitool dev:  hci0	5C:F3:70:82:F0:FA

hciconfig -a:
hci0:	Type: BR/EDR  Bus: USB
	BD Address: 5C:F3:70:82:F0:FA  ACL MTU: 1021:8  SCO MTU: 64:1
	UP RUNNING PSCAN ISCAN
	RX bytes:13146 acl:211 sco:0 events:382 errors:0
	TX bytes:6265 acl:219 sco:0 commands:149 errors:0
	Features: 0xbf 0xfe 0xcf 0xfe 0xdb 0xff 0x7b 0x87
	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
	Link policy: RSWITCH SNIFF
	Link mode: SLAVE ACCEPT
	Name: '312_BT-0'
	Class: 0x000100
	Service Classes: Unspecified
	Device Class: Computer, Uncategorized
	HCI Version: 4.0 (0x6)  Revision: 0x1000
	LMP Version: 4.0 (0x6)  Subversion: 0x220e
	Manufacturer: Broadcom Corporation (15)


Succesful file push from Linux device to Android device:
obexftp -b D4:63:C6:45:67:CF -B 6 -U none -p /home/root/test.txt
Suppressing FBS.
Connecting..\done
Sending "/home/root/test.txt".../done
Disconnecting..-done


Attempting to list file structure on Android device:
obexftp -b D4:63:C6:45:67:CF -B 6 -U none -l
Suppressing FBS.
Connecting..\done
Receiving "(null)"...|failed: (null)
The operation failed with return code 81
Disconnecting../done


Output of btmon when attempting above obexftp -l command:
= New Index: 5C:F3:70:82:F0:FA (Primary,USB,hci0) 
             [hci0] 0.316536
< HCI Command: Create Connection (0x01|0x0005) plen 13 
          #1 [hci0] 3.563946
         Address: D4:63:C6:45:67:CF (OUI D4-63-C6)
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
 > HCI Event: Command Status (0x0f) plen 4 
           #2 [hci0] 3.565628
       Create Connection (0x01|0x0005) ncmd 1
         Status: Success (0x00)
 > HCI Event: Role Change (0x12) plen 8 
           #3 [hci0] 5.392513
         Status: Success (0x00)
         Address: D4:63:C6:45:67:CF (OUI D4-63-C6)
         Role: Slave (0x01)
 > HCI Event: Connect Complete (0x03) plen 11 
           #4 [hci0] 5.414518
         Status: Success (0x00)
         Handle: 11
         Address: D4:63:C6:45:67:CF (OUI D4-63-C6)
         Link type: ACL (0x01)
         Encryption: Disabled (0x00)
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2 
          #5 [hci0] 5.414709
         Handle: 11
 > HCI Event: Command Status (0x0f) plen 4 
           #6 [hci0] 5.415523
       Read Remote Supported Features (0x01|0x001b) ncmd 1
         Status: Success (0x00)
 > HCI Event: Max Slots Change (0x1b) plen 3 
           #7 [hci0] 5.425523
         Handle: 11
         Max slots: 5
 > HCI Event: Link Supervision Timeout Changed (0x38) plen 4 
           #8 [hci0] 5.429522
         Handle: 11
         Timeout: 5000.000 msec (0x1f40)
 > ACL Data RX: Handle 11 flags 0x02 dlen 10 
           #9 [hci0] 5.432524
       L2CAP: Information Request (0x0a) ident 2 len 2
         Type: Extended features supported (0x0002)
< ACL Data TX: Handle 11 flags 0x00 dlen 16 
         #10 [hci0] 5.432580
       L2CAP: Information Response (0x0b) ident 2 len 8
         Type: Extended features supported (0x0002)
         Result: Success (0x0000)
         Features: 0x000002b8
           Enhanced Retransmission Mode
           Streaming Mode
           FCS Option
           Fixed Channels
           Unicast Connectionless Data Reception
 > HCI Event: Read Remote Supported Features (0x0b) plen 11 
          #11 [hci0] 5.438528
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
< HCI Command: Read Remote Extended Features (0x01|0x001c) plen 3 
         #12 [hci0] 5.438569
         Handle: 11
         Page: 1
 > ACL Data RX: Handle 11 flags 0x02 dlen 10 
          #13 [hci0] 5.438782
       L2CAP: Information Request (0x0a) ident 3 len 2
         Type: Fixed channels supported (0x0003)
< ACL Data TX: Handle 11 flags 0x00 dlen 20 
         #14 [hci0] 5.438818
       L2CAP: Information Response (0x0b) ident 3 len 12
         Type: Fixed channels supported (0x0003)
         Result: Success (0x0000)
         Channels: 0x0000000000000006
           L2CAP Signaling (BR/EDR)
           Connectionless reception
 > HCI Event: Command Status (0x0f) plen 4 
          #15 [hci0] 5.440527
       Read Remote Extended Features (0x01|0x001c) ncmd 1
         Status: Success (0x00)
 > HCI Event: Number of Completed Packets (0x13) plen 5 
          #16 [hci0] 5.443529
         Num handles: 1
         Handle: 11
         Count: 2
 > HCI Event: Read Remote Extended Features (0x23) plen 13 
          #17 [hci0] 5.444528
         Status: Success (0x00)
         Handle: 11
         Page: 1/1
         Features: 0x0f 0x00 0x00 0x00 0x00 0x00 0x00 0x00
           Secure Simple Pairing (Host Support)
           LE Supported (Host)
           Simultaneous LE and BR/EDR (Host)
           Secure Connections (Host Support)
< HCI Command: Remote Name Request (0x01|0x0019) plen 10 
         #18 [hci0] 5.444573
         Address: D4:63:C6:45:67:CF (OUI D4-63-C6)
         Page scan repetition mode: R2 (0x02)
         Page scan mode: Mandatory (0x00)
         Clock offset: 0x0000
 > HCI Event: Command Status (0x0f) plen 4 
          #19 [hci0] 5.445529
       Remote Name Request (0x01|0x0019) ncmd 1
         Status: Success (0x00)
 > HCI Event: Remote Name Req Complete (0x07) plen 255 
          #20 [hci0] 5.465535
         Status: Success (0x00)
         Address: D4:63:C6:45:67:CF (OUI D4-63-C6)
         Name: Moto E (4)
< HCI Command: Authentication Requested (0x01|0x0011) plen 2 
         #21 [hci0] 5.465591
         Handle: 11
@ Device Connected: D4:63:C6:45:67:CF (0) flags 0x0000
         0b 09 4d 6f 74 6f 20 45 20 28 34 29 04 0d 0c 02  ..Moto E (4)....
         5a                                               Z
 > HCI Event: Command Status (0x0f) plen 4 
          #22 [hci0] 5.466545
       Authentication Requested (0x01|0x0011) ncmd 1
         Status: Success (0x00)
 > HCI Event: Link Key Request (0x17) plen 6 
          #23 [hci0] 5.467541
         Address: D4:63:C6:45:67:CF (OUI D4-63-C6)
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22 
         #24 [hci0] 5.467588
         Address: D4:63:C6:45:67:CF (OUI D4-63-C6)
         Link key: b0912a0c42db7615860023aa911d552b
 > HCI Event: Command Complete (0x0e) plen 10 
          #25 [hci0] 5.470540
       Link Key Request Reply (0x01|0x000b) ncmd 1
         Status: Success (0x00)
         Address: D4:63:C6:45:67:CF (OUI D4-63-C6)
 > HCI Event: Auth Complete (0x06) plen 3 
          #26 [hci0] 5.489555
         Status: Success (0x00)
         Handle: 11
< HCI Command: Set Connection Encryption (0x01|0x0013) plen 3 
         #27 [hci0] 5.489604
         Handle: 11
         Encryption: Enabled (0x01)
 > HCI Event: Command Status (0x0f) plen 4 
          #28 [hci0] 5.490550
       Set Connection Encryption (0x01|0x0013) ncmd 1
         Status: Success (0x00)
 > HCI Event: Encryption Change (0x08) plen 4 
          #29 [hci0] 5.532580
         Status: Success (0x00)
         Handle: 11
         Encryption: Enabled with E0 (0x01)
< ACL Data TX: Handle 11 flags 0x00 dlen 10 
         #30 [hci0] 5.532645
       L2CAP: Information Request (0x0a) ident 1 len 2
         Type: Extended features supported (0x0002)
 > ACL Data RX: Handle 11 flags 0x02 dlen 16 
          #31 [hci0] 5.562719
       L2CAP: Information Response (0x0b) ident 1 len 8
         Type: Extended features supported (0x0002)
         Result: Success (0x0000)
         Features: 0x000000b8
           Enhanced Retransmission Mode
           Streaming Mode
           FCS Option
           Fixed Channels
< ACL Data TX: Handle 11 flags 0x00 dlen 10 
         #32 [hci0] 5.562780
       L2CAP: Information Request (0x0a) ident 2 len 2
         Type: Fixed channels supported (0x0003)
 > HCI Event: Number of Completed Packets (0x13) plen 5 
          #33 [hci0] 5.565591
         Num handles: 1
         Handle: 11
         Count: 2
 > ACL Data RX: Handle 11 flags 0x02 dlen 20 
          #34 [hci0] 5.566462
       L2CAP: Information Response (0x0b) ident 2 len 12
         Type: Fixed channels supported (0x0003)
         Result: Success (0x0000)
         Channels: 0x0000000000000082
           L2CAP Signaling (BR/EDR)
           Security Manager (BR/EDR)
< ACL Data TX: Handle 11 flags 0x00 dlen 12 
         #35 [hci0] 5.566511
       L2CAP: Connection Request (0x02) ident 3 len 4
         PSM: 3 (0x0003)
         Source CID: 64
 > ACL Data RX: Handle 11 flags 0x02 dlen 16 
          #36 [hci0] 5.570089
       L2CAP: Connection Response (0x03) ident 3 len 8
         Destination CID: 67
         Source CID: 64
         Result: Connection successful (0x0000)
         Status: No further information available (0x0000)
< ACL Data TX: Handle 11 flags 0x00 dlen 27 
         #37 [hci0] 5.570138
       L2CAP: Configure Request (0x04) ident 4 len 19
         Destination CID: 67
         Flags: 0x0000
         Option: Maximum Transmission Unit (0x01) [mandatory]
           MTU: 1013
         Option: Retransmission and Flow Control (0x04) [mandatory]
           Mode: Basic (0x00)
           TX window size: 0
           Max transmit: 0
           Retransmission timeout: 0
           Monitor timeout: 0
           Maximum PDU size: 0
 > ACL Data RX: Handle 11 flags 0x02 dlen 16 
          #38 [hci0] 5.571470
       L2CAP: Configure Request (0x04) ident 4 len 8
         Destination CID: 64
         Flags: 0x0000
         Option: Maximum Transmission Unit (0x01) [mandatory]
           MTU: 1691
< ACL Data TX: Handle 11 flags 0x00 dlen 18 
         #39 [hci0] 5.571521
       L2CAP: Configure Response (0x05) ident 4 len 10
         Source CID: 67
         Flags: 0x0000
         Result: Success (0x0000)
         Option: Maximum Transmission Unit (0x01) [mandatory]
           MTU: 1691
 > HCI Event: Number of Completed Packets (0x13) plen 5 
          #40 [hci0] 5.573594
         Num handles: 1
         Handle: 11
         Count: 2
 > ACL Data RX: Handle 11 flags 0x02 dlen 14 
          #41 [hci0] 5.573967
       L2CAP: Configure Response (0x05) ident 4 len 6
         Source CID: 64
         Flags: 0x0000
         Result: Success (0x0000)
< ACL Data TX: Handle 11 flags 0x00 dlen 8 
         #42 [hci0] 5.574064
       Channel: 67 len 4 [PSM 3 mode 0] {chan 0}
       RFCOMM: Set Async Balance Mode (SABM) (0x2f)
          Address: 0x03 cr 1 dlci 0x00
          Control: 0x3f poll/final 1
          Length: 0
          FCS: 0x1c
 > HCI Event: Number of Completed Packets (0x13) plen 5 
          #43 [hci0] 5.577595
         Num handles: 1
         Handle: 11
         Count: 2
 > ACL Data RX: Handle 11 flags 0x02 dlen 8 
          #44 [hci0] 5.577612
       Channel: 64 len 4 [PSM 3 mode 0] {chan 0}
       RFCOMM: Unnumbered Ack (UA) (0x63)
          Address: 0x03 cr 1 dlci 0x00
          Control: 0x73 poll/final 1
          Length: 0
          FCS: 0xd7
< ACL Data TX: Handle 11 flags 0x00 dlen 18 
         #45 [hci0] 5.577681
       Channel: 67 len 14 [PSM 3 mode 0] {chan 0}
       RFCOMM: Unnumbered Info with Header Check (UIH) (0xef)
          Address: 0x03 cr 1 dlci 0x00
          Control: 0xef poll/final 0
          Length: 10
          FCS: 0x70
          MCC Message type: DLC Parameter Negotiation CMD (0x20)
            Length: 8
            dlci 12 frame_type 0 credit_flow 15 pri 7
            ack_timer 0 frame_size 1008 max_retrans 0 credits 7
 > ACL Data RX: Handle 11 flags 0x02 dlen 18 
          #46 [hci0] 5.581473
       Channel: 64 len 14 [PSM 3 mode 0] {chan 0}
       RFCOMM: Unnumbered Info with Header Check (UIH) (0xef)
          Address: 0x01 cr 0 dlci 0x00
          Control: 0xef poll/final 0
          Length: 10
          FCS: 0xaa
          MCC Message type: DLC Parameter Negotiation RSP (0x20)
            Length: 8
            dlci 12 frame_type 0 credit_flow 14 pri 7
            ack_timer 0 frame_size 990 max_retrans 0 credits 7
< ACL Data TX: Handle 11 flags 0x00 dlen 8 
         #47 [hci0] 5.581541
       Channel: 67 len 4 [PSM 3 mode 0] {chan 0}
       RFCOMM: Set Async Balance Mode (SABM) (0x2f)
          Address: 0x33 cr 1 dlci 0x0c
          Control: 0x3f poll/final 1
          Length: 0
          FCS: 0x43
 > HCI Event: Number of Completed Packets (0x13) plen 5 
          #48 [hci0] 5.584597
         Num handles: 1
         Handle: 11
         Count: 2
 > ACL Data RX: Handle 11 flags 0x02 dlen 8 
          #49 [hci0] 5.585096
       Channel: 64 len 4 [PSM 3 mode 0] {chan 0}
       RFCOMM: Unnumbered Ack (UA) (0x63)
          Address: 0x33 cr 1 dlci 0x0c
          Control: 0x73 poll/final 1
          Length: 0
          FCS: 0x88
< ACL Data TX: Handle 11 flags 0x00 dlen 12 
         #50 [hci0] 5.585552
       Channel: 67 len 8 [PSM 3 mode 0] {chan 0}
       RFCOMM: Unnumbered Info with Header Check (UIH) (0xef)
          Address: 0x03 cr 1 dlci 0x00
          Control: 0xef poll/final 0
          Length: 4
          FCS: 0x70
          MCC Message type: Modem Status Command CMD (0x38)
            Length: 2
            dlci 12
            fc 0 rtc 1 rtr 1 ic 0 dv 1
 > ACL Data RX: Handle 11 flags 0x02 dlen 12 
          #51 [hci0] 5.591479
       Channel: 64 len 8 [PSM 3 mode 0] {chan 0}
       RFCOMM: Unnumbered Info with Header Check (UIH) (0xef)
          Address: 0x01 cr 0 dlci 0x00
          Control: 0xef poll/final 0
          Length: 4
          FCS: 0xaa
          MCC Message type: Modem Status Command RSP (0x38)
            Length: 2
            dlci 12
            fc 0 rtc 1 rtr 1 ic 0 dv 1
 > ACL Data RX: Handle 11 flags 0x02 dlen 12 
          #52 [hci0] 5.592601
       Channel: 64 len 8 [PSM 3 mode 0] {chan 0}
       RFCOMM: Unnumbered Info with Header Check (UIH) (0xef)
          Address: 0x01 cr 0 dlci 0x00
          Control: 0xef poll/final 0
          Length: 4
          FCS: 0xaa
          MCC Message type: Modem Status Command CMD (0x38)
            Length: 2
            dlci 12
            fc 0 rtc 1 rtr 1 ic 0 dv 1
< ACL Data TX: Handle 11 flags 0x00 dlen 12 
         #53 [hci0] 5.592664
       Channel: 67 len 8 [PSM 3 mode 0] {chan 0}
       RFCOMM: Unnumbered Info with Header Check (UIH) (0xef)
          Address: 0x03 cr 1 dlci 0x00
          Control: 0xef poll/final 0
          Length: 4
          FCS: 0x70
          MCC Message type: Modem Status Command RSP (0x38)
            Length: 2
            dlci 12
            fc 0 rtc 1 rtr 1 ic 0 dv 1
< ACL Data TX: Handle 11 flags 0x00 dlen 9 
         #54 [hci0] 5.592678
       Channel: 67 len 5 [PSM 3 mode 0] {chan 0}
       RFCOMM: Unnumbered Info with Header Check (UIH) (0xef)
          Address: 0x33 cr 1 dlci 0x0c
          Control: 0xff poll/final 1
          Length: 0
          FCS: 0x53
          Credits: 33
         53                                               S
< ACL Data TX: Handle 11 flags 0x00 dlen 15 
         #55 [hci0] 5.592688
       Channel: 67 len 11 [PSM 3 mode 0] {chan 0}
       RFCOMM: Unnumbered Info with Header Check (UIH) (0xef)
          Address: 0x33 cr 1 dlci 0x0c
          Control: 0xef poll/final 0
          Length: 7
          FCS: 0x4f
         80 00 07 10 00 04 00 4f                          .......O
 > HCI Event: Number of Completed Packets (0x13) plen 5 
          #56 [hci0] 5.595604
         Num handles: 1
         Handle: 11
         Count: 2
 > HCI Event: Number of Completed Packets (0x13) plen 5 
          #57 [hci0] 5.598602
         Num handles: 1
         Handle: 11
         Count: 2
 > ACL Data RX: Handle 11 flags 0x02 dlen 21 
          #58 [hci0] 5.601479
       Channel: 64 len 17 [PSM 3 mode 0] {chan 0}
       RFCOMM: Unnumbered Info with Header Check (UIH) (0xef)
          Address: 0x31 cr 0 dlci 0x0c
          Control: 0xff poll/final 1
          Length: 12
          FCS: 0x89
          Credits: 4
         a0 00 0c 10 00 04 00 cb 00 00 00 01 89           .............
< ACL Data TX: Handle 11 flags 0x00 dlen 41 
         #59 [hci0] 5.601739
       Channel: 67 len 37 [PSM 3 mode 0] {chan 0}
       RFCOMM: Unnumbered Info with Header Check (UIH) (0xef)
          Address: 0x33 cr 1 dlci 0x0c
          Control: 0xef poll/final 0
          Length: 33
          FCS: 0x4f
         83 00 21 cb 00 00 00 01 42 00 19 78 2d 6f 62 65  ..!.....B..x-obe
         78 2f 66 6f 6c 64 65 72 2d 6c 69 73 74 69 6e 67  x/folder-listing
         00 4f                                            .O
 > ACL Data RX: Handle 11 flags 0x02 dlen 17 
          #60 [hci0] 5.612611
       Channel: 64 len 13 [PSM 3 mode 0] {chan 0}
       RFCOMM: Unnumbered Info with Header Check (UIH) (0xef)
          Address: 0x31 cr 0 dlci 0x0c
          Control: 0xff poll/final 1
          Length: 8
          FCS: 0x89
          Credits: 1
         d1 00 08 cb 00 00 00 01 89                       .........
< ACL Data TX: Handle 11 flags 0x00 dlen 16 
         #61 [hci0] 5.613075
       Channel: 67 len 12 [PSM 3 mode 0] {chan 0}
       RFCOMM: Unnumbered Info with Header Check (UIH) (0xef)
          Address: 0x33 cr 1 dlci 0x0c
          Control: 0xef poll/final 0
          Length: 8
          FCS: 0x4f
         81 00 08 cb 00 00 00 01 4f                       ........O
 > HCI Event: Number of Completed Packets (0x13) plen 5 
          #62 [hci0] 5.618623
         Num handles: 1
         Handle: 11
         Count: 2
 > ACL Data RX: Handle 11 flags 0x02 dlen 17 
          #63 [hci0] 5.623869
       Channel: 64 len 13 [PSM 3 mode 0] {chan 0}
       RFCOMM: Unnumbered Info with Header Check (UIH) (0xef)
          Address: 0x31 cr 0 dlci 0x0c
          Control: 0xff poll/final 1
          Length: 8
          FCS: 0x89
          Credits: 1
         a0 00 08 cb 00 00 00 01 89                       .........
< ACL Data TX: Handle 11 flags 0x00 dlen 8 
         #64 [hci0] 5.624057
       Channel: 67 len 4 [PSM 3 mode 0] {chan 0}
       RFCOMM: Disconnect (DISC) (0x43)
          Address: 0x33 cr 1 dlci 0x0c
          Control: 0x53 poll/final 1
          Length: 0
          FCS: 0xa2
 > ACL Data RX: Handle 11 flags 0x02 dlen 8 
          #65 [hci0] 5.628872
       Channel: 64 len 4 [PSM 3 mode 0] {chan 0}
       RFCOMM: Unnumbered Ack (UA) (0x63)
          Address: 0x33 cr 1 dlci 0x0c
          Control: 0x73 poll/final 1
          Length: 0
          FCS: 0x88
< ACL Data TX: Handle 11 flags 0x00 dlen 8 
         #66 [hci0] 5.628967
       Channel: 67 len 4 [PSM 3 mode 0] {chan 0}
       RFCOMM: Disconnect (DISC) (0x43)
          Address: 0x03 cr 1 dlci 0x00
          Control: 0x53 poll/final 1
          Length: 0
          FCS: 0xfd
 > HCI Event: Number of Completed Packets (0x13) plen 5 
          #67 [hci0] 5.632625
         Num handles: 1
         Handle: 11
         Count: 2
 > ACL Data RX: Handle 11 flags 0x02 dlen 8 
          #68 [hci0] 5.632644
       Channel: 64 len 4 [PSM 3 mode 0] {chan 0}
       RFCOMM: Unnumbered Ack (UA) (0x63)
          Address: 0x03 cr 1 dlci 0x00
          Control: 0x73 poll/final 1
          Length: 0
          FCS: 0xd7
< ACL Data TX: Handle 11 flags 0x00 dlen 12 
         #69 [hci0] 5.632733
       L2CAP: Disconnection Request (0x06) ident 5 len 4
         Destination CID: 67
         Source CID: 64
 > ACL Data RX: Handle 11 flags 0x02 dlen 12 
          #70 [hci0] 5.637623
       L2CAP: Disconnection Response (0x07) ident 5 len 4
         Destination CID: 67
         Source CID: 64
 > HCI Event: Number of Completed Packets (0x13) plen 5 
          #71 [hci0] 5.863739
         Num handles: 1
         Handle: 11
         Count: 1
< HCI Command: Disconnect (0x01|0x0006) plen 3 
         #72 [hci0] 7.631380
         Handle: 11
         Reason: Remote User Terminated Connection (0x13)
 > HCI Event: Command Status (0x0f) plen 4 
          #73 [hci0] 7.632590
       Disconnect (0x01|0x0006) ncmd 1
         Status: Success (0x00)
 > HCI Event: Disconnect Complete (0x05) plen 4 
          #74 [hci0] 7.727640
         Status: Success (0x00)
         Handle: 11
         Reason: Connection Terminated By Local Host (0x16)
@ Device Disconnected: D4:63:C6:45:67:CF (0) reason 2
