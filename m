Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Travis Griggs <travisgriggs@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.0 \(3445.1.7\))
Subject: Get Name in Scan Response?
Message-Id: <87796201-DEA7-4158-8822-F461BAF68B78@gmail.com>
Date: Thu, 2 Nov 2017 15:35:14 -0700
To: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We=E2=80=99ve been developing products using BlueNRG chips, that act as =
BLE peripherals and are connected via Android/iOS devices acting as =
centrals to control/configure them. It is desirable to be able to =
discover nearby devices and then connect to them. Because of heinous =
caching strategies in both Android and iOS just using a previously =
connected devices name (derived from the name characteristic). The most =
reliable thing to do at the iOS/Droid level is capture the name from the =
advertising data and associate that with the device. This is the only =
reliable way to have a device determine its name programmatically and =
advertise that reliably.

I=E2=80=99m trying to do a product with a Pi like SBC that runs BlueZ =
with a BLE dongle. I set the device=E2=80=99s alias with:

    adapterProperties.Set('org.bluez.Adapter1', 'Alias', bleName())

Where bleName() returns the string I want to use for the device. If I =
connect a time or two and reboot a time or two, this will eventually =
show up as the name property in Android/iOS. But if I try to get it from =
the advertising data, there doesn=E2=80=99t seem to be a name in there. =
Is this name not set as part of either the advertisement or scan =
response packet? I know that when doing a custom service UUID, there is =
not enough room in the advertisement packet to have both service UUID =
and name, so it has to go in the scan response packet. Can any bluez =
developers confirm what I should be expecting to happen with setting the =
Alias property?

Is there a way to achieve what I want to do? I have an Advertisement =
interface that I worked up from the examples that I use to do the =
solicitID in. Do I need to shove the name in there somehow additionally?

I don=E2=80=99t really know how to parse btmon output, but here=E2=80=99s =
what it looks like when I start up my app:


----
sudo btmon
[sudo] password for nelson:
Bluetooth monitor ver 5.47
=3D Note: Linux version 4.12.8-nelson (armv7l)                           =
                                                                         =
                                                         0.183783
=3D Note: Bluetooth subsystem version 2.22                               =
                                                                         =
                                                         0.183801
=3D New Index: 5C:F3:70:68:C1:F9 (Primary,USB,hci0)                      =
                                                                         =
                                                  [hci0] 0.183806
@ MGMT Open: bluetoothd (privileged) version 1.14                        =
                                                                         =
                                              {0x0002} 0.183812
@ MGMT Open: bluetoothd (privileged) version 1.14                        =
                                                                         =
                                              {0x0001} 0.183815
@ MGMT Open: btmon (privileged) version 1.14                             =
                                                                         =
                                              {0x0003} 0.183941
@ MGMT Command: Set Powered (0x0005) plen 1                              =
                                                                         =
                                    {0x0001} [hci0] 1049.660570
        Powered: Enabled (0x01)
=3D Open Index: 5C:F3:70:68:C1:F9                                        =
                                                                         =
                                               [hci0] 1049.661241
< HCI Command: Reset (0x03|0x0003) plen 0                                =
                                                                         =
                                          #1 [hci0] 1049.663093
> HCI Event: Command Complete (0x0e) plen 4                              =
                                                                         =
                                          #2 [hci0] 1049.666831
      Reset (0x03|0x0003) ncmd 1
        Status: Success (0x00)
< HCI Command: Read Local Supported Features (0x04|0x0003) plen 0        =
                                                                         =
                                          #3 [hci0] 1049.668313
> HCI Event: Command Complete (0x0e) plen 12                             =
                                                                         =
                                          #4 [hci0] 1049.669821
      Read Local Supported Features (0x04|0x0003) ncmd 1
        Status: Success (0x00)
        Features: 0xbf 0xfe 0xcf 0xfe 0xdb 0xff 0x7b 0x87
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
< HCI Command: Read Local Version Information (0x04|0x0001) plen 0       =
                                                                         =
                                          #5 [hci0] 1049.670154
> HCI Event: Command Complete (0x0e) plen 12                             =
                                                                         =
                                          #6 [hci0] 1049.671828
      Read Local Version Information (0x04|0x0001) ncmd 1
        Status: Success (0x00)
        HCI version: Bluetooth 4.0 (0x06) - Revision 4096 (0x1000)
        LMP version: Bluetooth 4.0 (0x06) - Subversion 8718 (0x220e)
        Manufacturer: Broadcom Corporation (15)
          Firmware: 001.002.014 (BCM20702A1)
          Build: 0000
< HCI Command: Read BD ADDR (0x04|0x0009) plen 0                         =
                                                                         =
                                          #7 [hci0] 1049.672376
> HCI Event: Command Complete (0x0e) plen 10                             =
                                                                         =
                                          #8 [hci0] 1049.673826
      Read BD ADDR (0x04|0x0009) ncmd 1
        Status: Success (0x00)
        Address: 5C:F3:70:68:C1:F9 (CC&C Technologies, Inc)
< HCI Command: Read Buffer Size (0x04|0x0005) plen 0                     =
                                                                         =
                                          #9 [hci0] 1049.674459
> HCI Event: Command Complete (0x0e) plen 11                             =
                                                                         =
                                         #10 [hci0] 1049.675829
      Read Buffer Size (0x04|0x0005) ncmd 1
        Status: Success (0x00)
        ACL MTU: 1021 ACL max packet: 8
        SCO MTU: 64   SCO max packet: 1
< HCI Command: Read Class of Device (0x03|0x0023) plen 0                 =
                                                                         =
                                         #11 [hci0] 1049.676386
> HCI Event: Command Complete (0x0e) plen 7                              =
                                                                         =
                                         #12 [hci0] 1049.677827
      Read Class of Device (0x03|0x0023) ncmd 1
        Status: Success (0x00)
        Class: 0x000000
          Major class: Miscellaneous
          Minor class: 0x00
< HCI Command: Read Local Name (0x03|0x0014) plen 0                      =
                                                                         =
                                         #13 [hci0] 1049.677974
> HCI Event: Command Complete (0x0e) plen 252                            =
                                                                         =
                                         #14 [hci0] 1049.694817
      Read Local Name (0x03|0x0014) ncmd 1
        Status: Success (0x00)
        Name: BCM20702A
< HCI Command: Read Voice Setting (0x03|0x0025) plen 0                   =
                                                                         =
                                         #15 [hci0] 1049.694983
> HCI Event: Command Complete (0x0e) plen 6                              =
                                                                         =
                                         #16 [hci0] 1049.696821
      Read Voice Setting (0x03|0x0025) ncmd 1
        Status: Success (0x00)
        Setting: 0x0060
          Input Coding: Linear
          Input Data Format: 2's complement
          Input Sample Size: 16-bit
          # of bits padding at MSB: 0
          Air Coding Format: CVSD
< HCI Command: Read Number of Supported IAC (0x03|0x0038) plen 0         =
                                                                         =
                                         #17 [hci0] 1049.696988
> HCI Event: Command Complete (0x0e) plen 5                              =
                                                                         =
                                         #18 [hci0] 1049.698824
      Read Number of Supported IAC (0x03|0x0038) ncmd 1
        Status: Success (0x00)
        Number of IAC: 4
< HCI Command: Read Current IAC LAP (0x03|0x0039) plen 0                 =
                                                                         =
                                         #19 [hci0] 1049.699098
> HCI Event: Command Complete (0x0e) plen 8                              =
                                                                         =
                                         #20 [hci0] 1049.700826
      Read Current IAC LAP (0x03|0x0039) ncmd 1
        Status: Success (0x00)
        Number of IAC: 1
        Access code: 0x9e8b33 (General Inquiry)
< HCI Command: Set Event Filter (0x03|0x0005) plen 1                     =
                                                                         =
                                         #21 [hci0] 1049.701013
        Type: Clear All Filters (0x00)
> HCI Event: Command Complete (0x0e) plen 4                              =
                                                                         =
                                         #22 [hci0] 1049.702826
      Set Event Filter (0x03|0x0005) ncmd 1
        Status: Success (0x00)
< HCI Command: Write Connection Accept Timeout (0x03|0x0016) plen 2      =
                                                                         =
                                         #23 [hci0] 1049.703056
        Timeout: 20000.000 msec (0x7d00)
> HCI Event: Command Complete (0x0e) plen 4                              =
                                                                         =
                                         #24 [hci0] 1049.704818
      Write Connection Accept Timeout (0x03|0x0016) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Read Buffer Size (0x08|0x0002) plen 0                  =
                                                                         =
                                         #25 [hci0] 1049.704974
> HCI Event: Command Complete (0x0e) plen 7                              =
                                                                         =
                                         #26 [hci0] 1049.706825
      LE Read Buffer Size (0x08|0x0002) ncmd 1
        Status: Success (0x00)
        Data packet length: 27
        Num data packets: 15
< HCI Command: LE Read Local Supported Features (0x08|0x0003) plen 0     =
                                                                         =
                                         #27 [hci0] 1049.707125
> HCI Event: Command Complete (0x0e) plen 12                             =
                                                                         =
                                         #28 [hci0] 1049.708824
      LE Read Local Supported Features (0x08|0x0003) ncmd 1
        Status: Success (0x00)
        Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
          LE Encryption
< HCI Command: LE Read Supported States (0x08|0x001c) plen 0             =
                                                                         =
                                         #29 [hci0] 1049.709614
> HCI Event: Command Complete (0x0e) plen 12                             =
                                                                         =
                                         #30 [hci0] 1049.711827
      LE Read Supported States (0x08|0x001c) ncmd 1
        Status: Success (0x00)
        States: 0x000000001fffffff
          Non-connectable Advertising State
          Scannable Advertising State
          Connectable Advertising State
          High Duty Cycle Directed Advertising State
          Passive Scanning State
          Active Scanning State
          Initiating State
            and Connection State (Master Role)
          Connection State (Slave Role)
          Non-connectable Advertising State
            and Passive Scanning State
          Scannable Advertising State
            and Passive Scanning State
          Connectable Advertising State
            and Passive Scanning State
          High Duty Cycle Directed Advertising State
            and Passive Scanning State
          Non-connectable Advertising State
            and Active Scanning State
          Scannable Advertising State
            and Active Scanning State
          Connectable Advertising State
            and Active Scanning State
          High Duty Cycle Directed Advertising State
            and Active Scanning State
          Non-connectable Advertising State
            and Initiating State
          Scannable Advertising State
            and Initiating State
          Non-connectable Advertising State
            and Connection State (Master Role)
          Scannable Advertising State
            and Connection State (Master Role)
          Non-connectable Advertising State
            and Connection State (Slave Role)
          Scannable Advertising State
            and Connection State (Slave Role)
          Passive Scanning State
            and Initiating State
          Active Scanning State
            and Initiating State
          Passive Scanning State
            and Connection State (Master Role)
          Active Scanning State
            and Connection State (Master Role)
          Passive Scanning State
            and Connection State (Slave Role)
          Active Scanning State
            and Connection State (Slave Role)
          Initiating State
            and Connection State (Master Role)
            and Master Role & Master Role
< HCI Command: Read Local Supported Commands (0x04|0x0002) plen 0        =
                                                                         =
                                         #31 [hci0] 1049.712439
> HCI Event: Command Complete (0x0e) plen 68                             =
                                                                         =
                                         #32 [hci0] 1049.717817
      Read Local Supported Commands (0x04|0x0002) ncmd 1
        Status: Success (0x00)
        Commands: 161 entries
          Inquiry (Octet 0 - Bit 0)
          Inquiry Cancel (Octet 0 - Bit 1)
          Periodic Inquiry Mode (Octet 0 - Bit 2)
          Exit Periodic Inquiry Mode (Octet 0 - Bit 3)
          Create Connection (Octet 0 - Bit 4)
          Disconnect (Octet 0 - Bit 5)
          Add SCO Connection (Octet 0 - Bit 6)
          Create Connection Cancel (Octet 0 - Bit 7)
          Accept Connection Request (Octet 1 - Bit 0)
          Reject Connection Request (Octet 1 - Bit 1)
          Link Key Request Reply (Octet 1 - Bit 2)
          Link Key Request Negative Reply (Octet 1 - Bit 3)
          PIN Code Request Reply (Octet 1 - Bit 4)
          PIN Code Request Negative Reply (Octet 1 - Bit 5)
          Change Connection Packet Type (Octet 1 - Bit 6)
          Authentication Requested (Octet 1 - Bit 7)
          Set Connection Encryption (Octet 2 - Bit 0)
          Change Connection Link Key (Octet 2 - Bit 1)
          Master Link Key (Octet 2 - Bit 2)
          Remote Name Request (Octet 2 - Bit 3)
          Remote Name Request Cancel (Octet 2 - Bit 4)
          Read Remote Supported Features (Octet 2 - Bit 5)
          Read Remote Extended Features (Octet 2 - Bit 6)
          Read Remote Version Information (Octet 2 - Bit 7)
          Read Clock Offset (Octet 3 - Bit 0)
          Read LMP Handle (Octet 3 - Bit 1)
          Sniff Mode (Octet 4 - Bit 2)
          Exit Sniff Mode (Octet 4 - Bit 3)
          QoS Setup (Octet 4 - Bit 6)
          Role Discovery (Octet 4 - Bit 7)
          Switch Role (Octet 5 - Bit 0)
          Read Link Policy Settings (Octet 5 - Bit 1)
          Write Link Policy Settings (Octet 5 - Bit 2)
          Read Default Link Policy Settings (Octet 5 - Bit 3)
          Write Default Link Policy Settings (Octet 5 - Bit 4)
          Flow Specification (Octet 5 - Bit 5)
          Set Event Mask (Octet 5 - Bit 6)
          Reset (Octet 5 - Bit 7)
          Set Event Filter (Octet 6 - Bit 0)
          Flush (Octet 6 - Bit 1)
          Read PIN Type (Octet 6 - Bit 2)
          Write PIN Type (Octet 6 - Bit 3)
          Read Stored Link Key (Octet 6 - Bit 5)
          Write Stored Link Key (Octet 6 - Bit 6)
          Delete Stored Link Key (Octet 6 - Bit 7)
          Write Local Name (Octet 7 - Bit 0)
          Read Local Name (Octet 7 - Bit 1)
          Read Connection Accept Timeout (Octet 7 - Bit 2)
          Write Connection Accept Timeout (Octet 7 - Bit 3)
          Read Page Timeout (Octet 7 - Bit 4)
          Write Page Timeout (Octet 7 - Bit 5)
          Read Scan Enable (Octet 7 - Bit 6)
          Write Scan Enable (Octet 7 - Bit 7)
          Read Page Scan Activity (Octet 8 - Bit 0)
          Write Page Scan Activity (Octet 8 - Bit 1)
          Read Inquiry Scan Activity (Octet 8 - Bit 2)
          Write Inquiry Scan Activity (Octet 8 - Bit 3)
          Read Authentication Enable (Octet 8 - Bit 4)
          Write Authentication Enable (Octet 8 - Bit 5)
          Read Encryption Mode (Octet 8 - Bit 6)
          Write Encryption Mode (Octet 8 - Bit 7)
          Read Class of Device (Octet 9 - Bit 0)
          Write Class of Device (Octet 9 - Bit 1)
          Read Voice Setting (Octet 9 - Bit 2)
          Write Voice Setting (Octet 9 - Bit 3)
          Read Automatic Flush Timeout (Octet 9 - Bit 4)
          Write Automatic Flush Timeout (Octet 9 - Bit 5)
          Read Num Broadcast Retransmissions (Octet 9 - Bit 6)
          Write Num Broadcast Retransmissions (Octet 9 - Bit 7)
          Read Transmit Power Level (Octet 10 - Bit 2)
          Read Sync Flow Control Enable (Octet 10 - Bit 3)
          Set Controller To Host Flow Control (Octet 10 - Bit 5)
          Host Buffer Size (Octet 10 - Bit 6)
          Host Number of Completed Packets (Octet 10 - Bit 7)
          Read Link Supervision Timeout (Octet 11 - Bit 0)
          Write Link Supervision Timeout (Octet 11 - Bit 1)
          Read Number of Supported IAC (Octet 11 - Bit 2)
          Read Current IAC LAP (Octet 11 - Bit 3)
          Write Current IAC LAP (Octet 11 - Bit 4)
          Set AFH Host Channel Classification (Octet 12 - Bit 1)
          Read Inquiry Scan Type (Octet 12 - Bit 4)
          Write Inquiry Scan Type (Octet 12 - Bit 5)
          Read Inquiry Mode (Octet 12 - Bit 6)
          Write Inquiry Mode (Octet 12 - Bit 7)
          Read Page Scan Type (Octet 13 - Bit 0)
          Write Page Scan Type (Octet 13 - Bit 1)
          Read AFH Channel Assessment Mode (Octet 13 - Bit 2)
          Write AFH Channel Assessment Mode (Octet 13 - Bit 3)
          Read Local Version Information (Octet 14 - Bit 3)
          Read Local Supported Features (Octet 14 - Bit 5)
          Read Local Extended Features (Octet 14 - Bit 6)
          Read Buffer Size (Octet 14 - Bit 7)
          Read BD ADDR (Octet 15 - Bit 1)
          Read Failed Contact Counter (Octet 15 - Bit 2)
          Reset Failed Contact Counter (Octet 15 - Bit 3)
          Read Link Quality (Octet 15 - Bit 4)
          Read RSSI (Octet 15 - Bit 5)
          Read AFH Channel Map (Octet 15 - Bit 6)
          Read Clock (Octet 15 - Bit 7)
          Read Loopback Mode (Octet 16 - Bit 0)
          Write Loopback Mode (Octet 16 - Bit 1)
          Enable Device Under Test Mode (Octet 16 - Bit 2)
          Setup Synchronous Connection (Octet 16 - Bit 3)
          Accept Synchronous Connection Request (Octet 16 - Bit 4)
          Reject Synchronous Connection Request (Octet 16 - Bit 5)
          Read Extended Inquiry Response (Octet 17 - Bit 0)
          Write Extended Inquiry Response (Octet 17 - Bit 1)
          Refresh Encryption Key (Octet 17 - Bit 2)
          Sniff Subrating (Octet 17 - Bit 4)
          Read Simple Pairing Mode (Octet 17 - Bit 5)
          Write Simple Pairing Mode (Octet 17 - Bit 6)
          Read Local OOB Data (Octet 17 - Bit 7)
          Read Inquiry Response TX Power Level (Octet 18 - Bit 0)
          Write Inquiry Transmit Power Level (Octet 18 - Bit 1)
          Read Default Erroneous Data Reporting (Octet 18 - Bit 2)
          Write Default Erroneous Data Reporting (Octet 18 - Bit 3)
          IO Capability Request Reply (Octet 18 - Bit 7)
          User Confirmation Request Reply (Octet 19 - Bit 0)
          User Confirmation Request Neg Reply (Octet 19 - Bit 1)
          User Passkey Request Reply (Octet 19 - Bit 2)
          User Passkey Request Negative Reply (Octet 19 - Bit 3)
          Remote OOB Data Request Reply (Octet 19 - Bit 4)
          Write Simple Pairing Debug Mode (Octet 19 - Bit 5)
          Enhanced Flush (Octet 19 - Bit 6)
          Remote OOB Data Request Neg Reply (Octet 19 - Bit 7)
          Send Keypress Notification (Octet 20 - Bit 2)
          IO Capability Request Negative Reply (Octet 20 - Bit 3)
          Read Encryption Key Size (Octet 20 - Bit 4)
          Read Enhanced Transmit Power Level (Octet 24 - Bit 0)
          Read LE Host Supported (Octet 24 - Bit 5)
          Write LE Host Supported (Octet 24 - Bit 6)
          LE Set Event Mask (Octet 25 - Bit 0)
          LE Read Buffer Size (Octet 25 - Bit 1)
          LE Read Local Supported Features (Octet 25 - Bit 2)
          LE Set Random Address (Octet 25 - Bit 4)
          LE Set Advertising Parameters (Octet 25 - Bit 5)
          LE Read Advertising Channel TX Power (Octet 25 - Bit 6)
          LE Set Advertising Data (Octet 25 - Bit 7)
          LE Set Scan Response Data (Octet 26 - Bit 0)
          LE Set Advertise Enable (Octet 26 - Bit 1)
          LE Set Scan Parameters (Octet 26 - Bit 2)
          LE Set Scan Enable (Octet 26 - Bit 3)
          LE Create Connection (Octet 26 - Bit 4)
          LE Create Connection Cancel (Octet 26 - Bit 5)
          LE Read White List Size (Octet 26 - Bit 6)
          LE Clear White List (Octet 26 - Bit 7)
          LE Add Device To White List (Octet 27 - Bit 0)
          LE Remove Device =46rom White List (Octet 27 - Bit 1)
          LE Connection Update (Octet 27 - Bit 2)
          LE Set Host Channel Classification (Octet 27 - Bit 3)
          LE Read Channel Map (Octet 27 - Bit 4)
          LE Read Remote Used Features (Octet 27 - Bit 5)
          LE Encrypt (Octet 27 - Bit 6)
          LE Rand (Octet 27 - Bit 7)
          LE Start Encryption (Octet 28 - Bit 0)
          LE Long Term Key Request Reply (Octet 28 - Bit 1)
          LE Long Term Key Request Neg Reply (Octet 28 - Bit 2)
          LE Read Supported States (Octet 28 - Bit 3)
          LE Receiver Test (Octet 28 - Bit 4)
          LE Transmitter Test (Octet 28 - Bit 5)
          LE Test End (Octet 28 - Bit 6)
< HCI Command: Write Simple Pairing Mode (0x03|0x0056) plen 1            =
                                                                         =
                                         #33 [hci0] 1049.718291
        Mode: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4                              =
                                                                         =
                                         #34 [hci0] 1049.783828
      Write Simple Pairing Mode (0x03|0x0056) ncmd 1
        Status: Success (0x00)
< HCI Command: Write Inquiry Mode (0x03|0x0045) plen 1                   =
                                                                         =
                                         #35 [hci0] 1049.784435
        Mode: Inquiry Result with RSSI or Extended Inquiry Result (0x02)
> HCI Event: Command Complete (0x0e) plen 4                              =
                                                                         =
                                         #36 [hci0] 1049.785815
      Write Inquiry Mode (0x03|0x0045) ncmd 1
        Status: Success (0x00)
< HCI Command: Read Inquiry Response TX Power Level (0x03|0x0058) plen 0 =
                                                                         =
                                         #37 [hci0] 1049.786563
> HCI Event: Command Complete (0x0e) plen 5                              =
                                                                         =
                                         #38 [hci0] 1049.788806
      Read Inquiry Response TX Power Level (0x03|0x0058) ncmd 1
        Status: Success (0x00)
        TX power: 0 dbm (0x00)
< HCI Command: Read Local Extended Features (0x04|0x0004) plen 1         =
                                                                         =
                                         #39 [hci0] 1049.788905
        Page: 1
> HCI Event: Command Complete (0x0e) plen 14                             =
                                                                         =
                                         #40 [hci0] 1049.790815
      Read Local Extended Features (0x04|0x0004) ncmd 1
        Status: Success (0x00)
        Page: 1/1
        Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
          Secure Simple Pairing (Host Support)
< HCI Command: Set Event Mask (0x03|0x0001) plen 8                       =
                                                                         =
                                         #41 [hci0] 1049.791732
        Mask: 0x3dbff807fffbffff
          Inquiry Complete
          Inquiry Result
          Connection Complete
          Connection Request
          Disconnection Complete
          Authentication Complete
          Remote Name Request Complete
          Encryption Change
          Change Connection Link Key Complete
          Master Link Key Complete
          Read Remote Supported Features Complete
          Read Remote Version Information Complete
          QoS Setup Complete
          Command Complete
          Command Status
          Hardware Error
          Flush Occurred
          Role Change
          Mode Change
          Return Link Keys
          PIN Code Request
          Link Key Request
          Link Key Notification
          Loopback Command
          Data Buffer Overflow
          Max Slots Change
          Read Clock Offset Complete
          Connection Packet Type Changed
          QoS Violation
          Page Scan Mode Change
          Page Scan Repetition Mode Change
          Flow Specification Complete
          Inquiry Result with RSSI
          Read Remote Extended Features Complete
          Synchronous Connection Complete
          Synchronous Connection Changed
          Sniff Subrating
          Extended Inquiry Result
          Encryption Key Refresh Complete
          IO Capability Request
          IO Capability Request Reply
          User Confirmation Request
          User Passkey Request
          Remote OOB Data Request
          Simple Pairing Complete
          Link Supervision Timeout Changed
          Enhanced Flush Complete
          User Passkey Notification
          Keypress Notification
          Remote Host Supported Features Notification
          LE Meta
> HCI Event: Command Complete (0x0e) plen 4                              =
                                                                         =
                                         #42 [hci0] 1049.793832
      Set Event Mask (0x03|0x0001) ncmd 1
        Status: Success (0x00)
< HCI Command: Read Stored Link Key (0x03|0x000d) plen 7                 =
                                                                         =
                                         #43 [hci0] 1049.794006
        Address: 00:00:00:00:00:00 (OUI 00-00-00)
        Read all: 0x01
> HCI Event: Command Complete (0x0e) plen 8                              =
                                                                         =
                                         #44 [hci0] 1049.795808
      Read Stored Link Key (0x03|0x000d) ncmd 1
        Status: Success (0x00)
        Max num keys: 1
        Num keys: 0
< HCI Command: Write Default Link Policy Settings (0x02|0x000f) plen 2   =
                                                                         =
                                         #45 [hci0] 1049.796050
        Link policy: 0x0005
          Enable Role Switch
          Enable Sniff Mode
> HCI Event: Command Complete (0x0e) plen 4                              =
                                                                         =
                                         #46 [hci0] 1049.797817
      Write Default Link Policy Settings (0x02|0x000f) ncmd 1
        Status: Success (0x00)
< HCI Command: Read Page Scan Activity (0x03|0x001b) plen 0              =
                                                                         =
                                         #47 [hci0] 1049.797939
> HCI Event: Command Complete (0x0e) plen 8                              =
                                                                         =
                                         #48 [hci0] 1049.799821
      Read Page Scan Activity (0x03|0x001b) ncmd 1
        Status: Success (0x00)
        Interval: 1280.000 msec (0x0800)
        Window: 11.250 msec (0x0012)
< HCI Command: Read Page Scan Type (0x03|0x0046) plen 0                  =
                                                                         =
                                         #49 [hci0] 1049.799939
> HCI Event: Command Complete (0x0e) plen 5                              =
                                                                         =
                                         #50 [hci0] 1049.801825
      Read Page Scan Type (0x03|0x0046) ncmd 1
        Status: Success (0x00)
        Type: Standard Scan (0x00)
< HCI Command: LE Set Event Mask (0x08|0x0001) plen 8                    =
                                                                         =
                                         #51 [hci0] 1049.801989
        Mask: 0x000000000000001f
          LE Connection Complete
          LE Advertising Report
          LE Connection Update Complete
          LE Read Remote Used Features Complete
          LE Long Term Key Request
> HCI Event: Command Complete (0x0e) plen 4                              =
                                                                         =
                                         #52 [hci0] 1049.803822
      LE Set Event Mask (0x08|0x0001) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Read Advertising Channel TX Power (0x08|0x0007) plen 0 =
                                                                         =
                                         #53 [hci0] 1049.803952
> HCI Event: Command Complete (0x0e) plen 5                              =
                                                                         =
                                         #54 [hci0] 1049.805815
      LE Read Advertising Channel TX Power (0x08|0x0007) ncmd 1
        Status: Success (0x00)
        TX power: 4 dbm (0x04)
< HCI Command: LE Read White List Size (0x08|0x000f) plen 0              =
                                                                         =
                                         #55 [hci0] 1049.806071
> HCI Event: Command Complete (0x0e) plen 5                              =
                                                                         =
                                         #56 [hci0] 1049.807817
      LE Read White List Size (0x08|0x000f) ncmd 1
        Status: Success (0x00)
        Size: 32
< HCI Command: LE Clear White List (0x08|0x0010) plen 0                  =
                                                                         =
                                         #57 [hci0] 1049.808027
> HCI Event: Command Complete (0x0e) plen 4                              =
                                                                         =
                                         #58 [hci0] 1049.809820
      LE Clear White List (0x08|0x0010) ncmd 1
        Status: Success (0x00)
< HCI Command: Write LE Host Supported (0x03|0x006d) plen 2              =
                                                                         =
                                         #59 [hci0] 1049.809953
        Supported: 0x01
        Simultaneous: 0x00
> HCI Event: Command Complete (0x0e) plen 4                              =
                                                                         =
                                         #60 [hci0] 1049.811816
      Write LE Host Supported (0x03|0x006d) ncmd 1
        Status: Success (0x00)
< HCI Command: Delete Stored Link Key (0x03|0x0012) plen 7               =
                                                                         =
                                         #61 [hci0] 1049.812072
        Address: 00:00:00:00:00:00 (OUI 00-00-00)
        Delete all: 0x01
> HCI Event: Command Complete (0x0e) plen 6                              =
                                                                         =
                                         #62 [hci0] 1049.813823
      Delete Stored Link Key (0x03|0x0012) ncmd 1
        Status: Success (0x00)
        Num keys: 0
=3D Index Info: 5C:F3:70:68:C1:F9 (Broadcom Corporation)                 =
                                                                         =
                                               [hci0] 1049.814026
< HCI Command: LE Set Advertising Data (0x08|0x0008) plen 32             =
                                                                         =
                                         #63 [hci0] 1049.814229
        Length: 3
        TX power: 4 dBm
> HCI Event: Command Complete (0x0e) plen 4                              =
                                                                         =
                                         #64 [hci0] 1049.815821
      LE Set Advertising Data (0x08|0x0008) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Response Data (0x08|0x0009) plen 32           =
                                                                         =
                                         #65 [hci0] 1049.815970
        Length: 13
        Name (short): PILOT-FFED
> HCI Event: Command Complete (0x0e) plen 4                              =
                                                                         =
                                         #66 [hci0] 1049.817815
      LE Set Scan Response Data (0x08|0x0009) ncmd 1
        Status: Success (0x00)
< HCI Command: Write Local Name (0x03|0x0013) plen 248                   =
                                                                         =
                                         #67 [hci0] 1049.818082
        Name: PILOT-FFED98
> HCI Event: Command Complete (0x0e) plen 4                              =
                                                                         =
                                         #68 [hci0] 1049.820841
      Write Local Name (0x03|0x0013) ncmd 1
        Status: Success (0x00)
< HCI Command: Write Extended Inquiry Response (0x03|0x0052) plen 241    =
                                                                         =
                                         #69 [hci0] 1049.821084
        FEC: Not required (0x00)
        Name (complete): PILOT-FFED98
        TX power: 0 dBm
        Device ID: USB Implementer's Forum assigned (0x0002)
          Vendor: Linux Foundation (0x1d6b)
          Product: 0x0246
          Version: 5.2.15 (0x052f)
        16-bit Service UUIDs (complete): 2 entries
          Generic Access Profile (0x1800)
          Generic Attribute Profile (0x1801)
> HCI Event: Command Complete (0x0e) plen 4                              =
                                                                         =
                                         #70 [hci0] 1049.823816
      Write Extended Inquiry Response (0x03|0x0052) ncmd 1
        Status: Success (0x00)
@ MGMT Event: Command Complete (0x0001) plen 7                           =
                                                                         =
                                    {0x0001} [hci0] 1049.824091
      Set Powered (0x0005) plen 4
        Status: Success (0x00)
        Current settings: 0x00000ad1
          Powered
          Bondable
          Secure Simple Pairing
          BR/EDR
          Low Energy
          Secure Connections
@ MGMT Event: New Settings (0x0006) plen 4                               =
                                                                         =
                                    {0x0003} [hci0] 1049.824114
        Current settings: 0x00000ad1
          Powered
          Bondable
          Secure Simple Pairing
          BR/EDR
          Low Energy
          Secure Connections
@ MGMT Event: New Settings (0x0006) plen 4                               =
                                                                         =
                                    {0x0002} [hci0] 1049.824114
        Current settings: 0x00000ad1
          Powered
          Bondable
          Secure Simple Pairing
          BR/EDR
          Low Energy
          Secure Connections
@ MGMT Command: Add Advertising (0x003e) plen 29                         =
                                                                         =
                                    {0x0002} [hci0] 1050.209116
        Instance: 1
        Flags: 0x00000003
          Switch into Connectable mode
          Advertise as Discoverable
        Duration: 0
        Timeout: 0
        Advertising data length: 18
        128-bit Service UUIDs (complete): 1 entry
          Vendor specific (00000000-08af-41c0-8048-4215e1560a37)
        Scan response length: 0
@ MGMT Event: Advertising Added (0x0023) plen 1                          =
                                                                         =
                                    {0x0003} [hci0] 1050.209149
        Instance: 1
@ MGMT Event: Advertising Added (0x0023) plen 1                          =
                                                                         =
                                    {0x0001} [hci0] 1050.209149
        Instance: 1
< HCI Command: LE Set Advertising Data (0x08|0x0008) plen 32             =
                                                                         =
                                         #71 [hci0] 1050.214845
        Length: 21
        Flags: 0x02
          LE General Discoverable Mode
        128-bit Service UUIDs (complete): 1 entry
          Vendor specific (00000000-08af-41c0-8048-4215e1560a37)
> HCI Event: Command Complete (0x0e) plen 4                              =
                                                                         =
                                         #72 [hci0] 1050.216824
      LE Set Advertising Data (0x08|0x0008) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Response Data (0x08|0x0009) plen 32           =
                                                                         =
                                         #73 [hci0] 1050.217797
        Length: 0
> HCI Event: Command Complete (0x0e) plen 4                              =
                                                                         =
                                         #74 [hci0] 1050.219823
      LE Set Scan Response Data (0x08|0x0009) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Advertising Parameters (0x08|0x0006) plen 15       =
                                                                         =
                                         #75 [hci0] 1050.220255
        Min advertising interval: 1280.000 msec (0x0800)
        Max advertising interval: 1280.000 msec (0x0800)
        Type: Connectable undirected - ADV_IND (0x00)
        Own address type: Public (0x00)
        Direct address type: Public (0x00)
        Direct address: 00:00:00:00:00:00 (OUI 00-00-00)
        Channel map: 37, 38, 39 (0x07)
        Filter policy: Allow Scan Request from Any, Allow Connect =
Request from Any (0x00)
> HCI Event: Command Complete (0x0e) plen 4                              =
                                                                         =
                                         #76 [hci0] 1050.221822
      LE Set Advertising Parameters (0x08|0x0006) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Advertise Enable (0x08|0x000a) plen 1              =
                                                                         =
                                         #77 [hci0] 1050.222283
        Advertising: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4                              =
                                                                         =
                                         #78 [hci0] 1050.223815
      LE Set Advertise Enable (0x08|0x000a) ncmd 1
        Status: Success (0x00)
@ MGMT Event: Command Complete (0x0001) plen 4                           =
                                                                         =
                                    {0x0002} [hci0] 1050.223943
      Add Advertising (0x003e) plen 1
        Status: Success (0x00)
        Instance: 1

