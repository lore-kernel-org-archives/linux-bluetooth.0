Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7C4C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Nov 2021 16:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04D22611ED
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Nov 2021 16:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhKARBE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Nov 2021 13:01:04 -0400
Received: from p3plsmtpa06-08.prod.phx3.secureserver.net ([173.201.192.109]:32836
        "EHLO p3plsmtpa06-08.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229725AbhKARBD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Nov 2021 13:01:03 -0400
X-Greylist: delayed 441 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Nov 2021 13:01:03 EDT
Received: from [10.0.1.107] ([47.220.160.133])
        by :SMTPAUTH: with ESMTPSA
        id haWZmM9LoMJM5haWZmVoqu; Mon, 01 Nov 2021 09:51:07 -0700
X-CMAE-Analysis: v=2.4 cv=GeHSISbL c=1 sm=1 tr=0 ts=61801afb
 a=HBqLinmJ0zjM5xUhY0BCjg==:117 a=HBqLinmJ0zjM5xUhY0BCjg==:17
 a=IkcTkHD0fZMA:10 a=WKgXLZk-ml9j1Fgs9K0A:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19
 a=ZStK1UGq_4G4QTbJ:21 a=QEXdDO2ut3YA:10
X-SECURESERVER-ACCT: ethan@braneaudio.com
Message-ID: <1ae72e29-ca50-0d97-9b21-753194a8130b@braneaudio.com>
Date:   Mon, 1 Nov 2021 11:51:06 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
To:     linux-bluetooth@vger.kernel.org
Content-Language: en-US
From:   Ethan White <ethan@braneaudio.com>
Subject: LE Advertising: Immediate Timeout
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfPpukKS2VxYrW+xodKgD7XBQUKv/h4HWTMdXfut60gc9/iaPbyd8CxkDCZiUKzQsoe5N3dwt/imCBLvolEDh19UEhk+0CzaYi7Z5j13jftA0Wounanf+
 WbjsjyO5cfE1qUMEtXPSyKtTDdvGbzB4WtycQqUjPtAoBzR8xcMHgiFitW0cpmPGQDdHkbxn9WPDkLOqiytj8jbKwsKGc1laBR0=
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

I'm trying to figure out why BLE advertisements are timing out
immediately on my embedded system.  This is happening with both the
example-advertisements python script bundled with Bluez and a gatt
server I wrote (in C using Bluez D-Bus API).  Both the script and
C-program work as expected on Pop!_OS 21.04.

This is a clip from a btmon log that shows the timeout in relation to
an LE Set Extended Advertising Data command.  The full log is included
below.  The log was generated with the example-advertisements script.

< HCI Command: LE Set Extended Advertising Data (0x08|0x0037) plen 35 
            #109 [hci0] 5.468490
         Handle: 0x00
         Operation: Complete extended advertising data (0x03)
         Fragment preference: Minimize fragmentation (0x01)
         Data length: 0x1d
         16-bit Service UUIDs (complete): 1 entry
           Battery Service (0x180f)
         Company: internal use (65535)
           Data: 00010203
         Service Data (UUID 0x9999): 0001020304
         Transport Discovery Data
           Organization: Bluetooth SIG (0x01)
           Flags: 0x01
             Role: 0x01
               Seeker Only
             Transport Data Incomplete: False (0x00)
             Transport State: 0x00
               Off
           Length: 0
           Data:
         TX power: 7 dBm
 > HCI Event: LE Meta Event (0x3e) plen 6 
             #110 [hci0] 5.470404
       LE Advertising Set Terminated (0x12)
         Status: Advertising Timeout (0x3c)
         Handle: 1
         Connection handle: 65535
         Number of completed extended advertising events: 0
@ MGMT Event: Advertising Removed (0x0024) plen 1 
        {0x0001} [hci0] 5.470504
         Instance: 1
 > HCI Event: Command Complete (0x0e) plen 4 
             #111 [hci0] 5.472302
       LE Set Extended Advertising Data (0x08|0x0037) ncmd 1
         Status: Success (0x00)


Bluetooth monitor ver 5.61
= Note: Linux version 5.4.156-brane-imx+g10adcfb40c46 (armv7l) 
                        0.463876
= Note: Bluetooth subsystem version 2.22 
                        0.463892
= New Index: 20:79:18:E7:0C:42 (Primary,USB,hci0) 
                 [hci0] 0.463898
= Open Index: 20:79:18:E7:0C:42 
                 [hci0] 0.463901
= Index Info: 20:79:18:E7:0C:42 (Intel Corp.) 
                 [hci0] 0.463904
@ MGMT Open: bluetoothd (privileged) version 1.14 
               {0x0001} 0.463909
@ RAW Open: hciconfig (privileged) version 2.22 
               {0x0002} 2.636569
< HCI Command: Reset (0x03|0x0003) plen 0 
              #1 [hci0] 2.636805
 > HCI Event: Command Complete (0x0e) plen 4 
               #2 [hci0] 2.648453
       Reset (0x03|0x0003) ncmd 2
         Status: Success (0x00)
@ MGMT Event: Class Of Device Changed (0x0007) plen 3 
        {0x0001} [hci0] 2.648698
         Class: 0x000000
           Major class: Miscellaneous
           Minor class: 0x00
@ MGMT Event: New Settings (0x0006) plen 4 
        {0x0001} [hci0] 2.648732
         Current settings: 0x00000ac0
           Secure Simple Pairing
           BR/EDR
           Low Energy
           Secure Connections
= Close Index: 20:79:18:E7:0C:42 
                 [hci0] 2.648838
= Open Index: 20:79:18:E7:0C:42 
                 [hci0] 2.657961
< HCI Command: Reset (0x03|0x0003) plen 0 
              #3 [hci0] 2.658142
 > HCI Event: Command Complete (0x0e) plen 4 
               #4 [hci0] 2.669444
       Reset (0x03|0x0003) ncmd 2
         Status: Success (0x00)
< HCI Command: Read Local Supported Features (0x04|0x0003) plen 0 
              #5 [hci0] 2.669588
 > HCI Event: Command Complete (0x0e) plen 12 
               #6 [hci0] 2.670412
       Read Local Supported Features (0x04|0x0003) ncmd 1
         Status: Success (0x00)
         Features: 0xbf 0xfe 0x0f 0xfe 0xdb 0xff 0x7b 0x87
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
< HCI Command: Read Local Version Information (0x04|0x0001) plen 0 
              #7 [hci0] 2.670527
 > HCI Event: Command Complete (0x0e) plen 12 
               #8 [hci0] 2.672397
       Read Local Version Information (0x04|0x0001) ncmd 1
         Status: Success (0x00)
         HCI version: Bluetooth 5.1 (0x0a) - Revision 256 (0x0100)
         LMP version: Bluetooth 5.1 (0x0a) - Subversion 256 (0x0100)
         Manufacturer: Intel Corp. (2)
< HCI Command: Read BD ADDR (0x04|0x0009) plen 0 
              #9 [hci0] 2.672524
 > HCI Event: Command Complete (0x0e) plen 10 
              #10 [hci0] 2.674390
       Read BD ADDR (0x04|0x0009) ncmd 1
         Status: Success (0x00)
         Address: 20:79:18:E7:0C:42 (OUI 20-79-18)
< HCI Command: Read Buffer Size (0x04|0x0005) plen 0 
             #11 [hci0] 2.675476
 > HCI Event: Command Complete (0x0e) plen 11 
              #12 [hci0] 2.677391
       Read Buffer Size (0x04|0x0005) ncmd 1
         Status: Success (0x00)
         ACL MTU: 1021 ACL max packet: 4
         SCO MTU: 96   SCO max packet: 6
< HCI Command: Read Class of Device (0x03|0x0023) plen 0 
             #13 [hci0] 2.677513
 > HCI Event: Command Complete (0x0e) plen 7 
              #14 [hci0] 2.679389
       Read Class of Device (0x03|0x0023) ncmd 1
         Status: Success (0x00)
         Class: 0x000000
           Major class: Miscellaneous
           Minor class: 0x00
< HCI Command: Read Local Name (0x03|0x0014) plen 0 
             #15 [hci0] 2.679503
 > HCI Event: Command Complete (0x0e) plen 252 
              #16 [hci0] 2.687425
       Read Local Name (0x03|0x0014) ncmd 1
         Status: Success (0x00)
         Name:
< HCI Command: Read Voice Setting (0x03|0x0025) plen 0 
             #17 [hci0] 2.687536
 > HCI Event: Command Complete (0x0e) plen 6 
              #18 [hci0] 2.688458
       Read Voice Setting (0x03|0x0025) ncmd 1
         Status: Success (0x00)
         Setting: 0x0060
           Input Coding: Linear
           Input Data Format: 2's complement
           Input Sample Size: 16-bit
           # of bits padding at MSB: 0
           Air Coding Format: CVSD
< HCI Command: Read Number of Supported IAC (0x03|0x0038) plen 0 
             #19 [hci0] 2.688563
 > HCI Event: Command Complete (0x0e) plen 5 
              #20 [hci0] 2.689457
       Read Number of Supported IAC (0x03|0x0038) ncmd 1
         Status: Success (0x00)
         Number of IAC: 2
< HCI Command: Read Current IAC LAP (0x03|0x0039) plen 0 
             #21 [hci0] 2.689558
 > HCI Event: Command Complete (0x0e) plen 8 
              #22 [hci0] 2.691389
       Read Current IAC LAP (0x03|0x0039) ncmd 2
         Status: Success (0x00)
         Number of IAC: 1
         Access code: 0x9e8b33 (General Inquiry)
< HCI Command: Set Event Filter (0x03|0x0005) plen 1 
             #23 [hci0] 2.691531
         Type: Clear All Filters (0x00)
 > HCI Event: Command Complete (0x0e) plen 4 
              #24 [hci0] 2.692407
       Set Event Filter (0x03|0x0005) ncmd 1
         Status: Success (0x00)
< HCI Command: Write Connection Accept Timeout (0x03|0x0016) plen 2 
             #25 [hci0] 2.692523
         Timeout: 20000.000 msec (0x7d00)
 > HCI Event: Command Complete (0x0e) plen 4 
              #26 [hci0] 2.693406
       Write Connection Accept Timeout (0x03|0x0016) ncmd 1
         Status: Success (0x00)
< HCI Command: LE Read Buffer Size (0x08|0x0002) plen 0 
             #27 [hci0] 2.693520
 > HCI Event: Command Complete (0x0e) plen 7 
              #28 [hci0] 2.695392
       LE Read Buffer Size (0x08|0x0002) ncmd 1
         Status: Success (0x00)
         Data packet length: 251
         Num data packets: 3
< HCI Command: LE Read Local Supported Features (0x08|0x0003) plen 0 
             #29 [hci0] 2.695504
 > HCI Event: Command Complete (0x0e) plen 12 
              #30 [hci0] 2.697415
       LE Read Local Supported Features (0x08|0x0003) ncmd 1
         Status: Success (0x00)
         Features: 0xff 0x59 0x00 0x08 0x00 0x00 0x00 0x00
           LE Encryption
           Connection Parameter Request Procedure
           Extended Reject Indication
           Slave-initiated Features Exchange
           LE Ping
           LE Data Packet Length Extension
           LL Privacy
           Extended Scanner Filter Policies
           LE 2M PHY
           LE Coded PHY
           LE Extended Advertising
           Channel Selection Algorithm #2
           Remote Public Key Validation
< HCI Command: LE Read Supported States (0x08|0x001c) plen 0 
             #31 [hci0] 2.697529
 > HCI Event: Command Complete (0x0e) plen 12 
              #32 [hci0] 2.699406
       LE Read Supported States (0x08|0x001c) ncmd 1
         Status: Success (0x00)
         States: 0x000003ffffffffff
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
           Low Duty Cycle Directed Advertising State
           Low Duty Cycle Directed Advertising State
             and Passive Scanning State
           Low Duty Cycle Directed Advertising State
             and Active Scanning State
           Connectable Advertising State
             and Initiating State
             and Master Role & Slave Role
           High Duty Cycle Directed Advertising State
             and Initiating State
             and Master Role & Slave Role
           Low Duty Cycle Directed Advertising State
             and Initiating State
             and Master Role & Slave Role
           Connectable Advertising State
             and Connection State (Master Role)
             and Master Role & Slave Role
           High Duty Cycle Directed Advertising State
             and Connection State (Master Role)
             and Master Role & Slave Role
           Low Duty Cycle Directed Advertising State
             and Connection State (Master Role)
             and Master Role & Slave Role
           Connectable Advertising State
             and Connection State (Slave Role)
             and Master Role & Slave Role
           High Duty Cycle Directed Advertising State
             and Connection State (Slave Role)
             and Slave Role & Slave Role
           Low Duty Cycle Directed Advertising State
             and Connection State (Slave Role)
             and Slave Role & Slave Role
           Initiating State
             and Connection State (Slave Role)
             and Master Role & Slave Role
< HCI Command: Read Local Supported Commands (0x04|0x0002) plen 0 
             #33 [hci0] 2.699530
 > HCI Event: Command Complete (0x0e) plen 68 
              #34 [hci0] 2.703407
       Read Local Supported Commands (0x04|0x0002) ncmd 1
         Status: Success (0x00)
         Commands: 215 entries
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
           Read Transmit Power Level (Octet 10 - Bit 2)
           Read Sync Flow Control Enable (Octet 10 - Bit 3)
           Write Sync Flow Control Enable (Octet 10 - Bit 4)
           Set Controller To Host Flow Control (Octet 10 - Bit 5)
           Host Buffer Size (Octet 10 - Bit 6)
           Host Number of Completed Packets (Octet 10 - Bit 7)
           Read Link Supervision Timeout (Octet 11 - Bit 0)
           Write Link Supervision Timeout (Octet 11 - Bit 1)
           Read Number of Supported IAC (Octet 11 - Bit 2)
           Read Current IAC LAP (Octet 11 - Bit 3)
           Write Current IAC LAP (Octet 11 - Bit 4)
           Read Page Scan Mode (Octet 11 - Bit 7)
           Write Page Scan Mode (Octet 12 - Bit 0)
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
           Set Event Mask Page 2 (Octet 22 - Bit 2)
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
           LE Remove Device From White List (Octet 27 - Bit 1)
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
           Enhanced Setup Synchronous Connection (Octet 29 - Bit 3)
           Enhanced Accept Synchronous Connection Request (Octet 29 - Bit 4)
           Read Local Supported Codecs (Octet 29 - Bit 5)
           Set External Frame Configuration (Octet 29 - Bit 7)
           Remote OOB Extended Data Request Reply (Octet 32 - Bit 1)
           Read Secure Connections Host Support (Octet 32 - Bit 2)
           Write Secure Connections Host Support (Octet 32 - Bit 3)
           Read Authenticated Payload Timeout (Octet 32 - Bit 4)
           Write Authenticated Payload Timeout (Octet 32 - Bit 5)
           Read Local OOB Extended Data (Octet 32 - Bit 6)
           Write Secure Connections Test Mode (Octet 32 - Bit 7)
           Read Extended Page Timeout (Octet 33 - Bit 0)
           Write Extended Page Timeout (Octet 33 - Bit 1)
           Read Extended Inquiry Length (Octet 33 - Bit 2)
           Write Extended Inquiry Length (Octet 33 - Bit 3)
           LE Remote Connection Parameter Request Reply (Octet 33 - Bit 4)
           LE Remote Connection Parameter Request Negative Reply (Octet 
33 - Bit 5)
           LE Set Data Length (Octet 33 - Bit 6)
           LE Read Suggested Default Data Length (Octet 33 - Bit 7)
           LE Write Suggested Default Data Length (Octet 34 - Bit 0)
           LE Read Local P-256 Public Key (Octet 34 - Bit 1)
           LE Generate DHKey (Octet 34 - Bit 2)
           LE Add Device To Resolving List (Octet 34 - Bit 3)
           LE Remove Device From Resolving List (Octet 34 - Bit 4)
           LE Clear Resolving List (Octet 34 - Bit 5)
           LE Read Resolving List Size (Octet 34 - Bit 6)
           LE Read Peer Resolvable Address (Octet 34 - Bit 7)
           LE Read Local Resolvable Address (Octet 35 - Bit 0)
           LE Set Address Resolution Enable (Octet 35 - Bit 1)
           LE Set Resolvable Private Address Timeout (Octet 35 - Bit 2)
           LE Read Maximum Data Length (Octet 35 - Bit 3)
           LE Read PHY (Octet 35 - Bit 4)
           LE Set Default PHY (Octet 35 - Bit 5)
           LE Set PHY (Octet 35 - Bit 6)
           LE Enhanced Receiver Test (Octet 35 - Bit 7)
           LE Enhanced Transmitter Test (Octet 36 - Bit 0)
           LE Set Advertising Set Random Address (Octet 36 - Bit 1)
           LE Set Extended Advertising Parameters (Octet 36 - Bit 2)
           LE Set Extended Advertising Data (Octet 36 - Bit 3)
           LE Set Extended Scan Response Data (Octet 36 - Bit 4)
           LE Set Extended Advertising Enable (Octet 36 - Bit 5)
           LE Read Maximum Advertising Data Length (Octet 36 - Bit 6)
           LE Read Number of Supported Advertising Sets (Octet 36 - Bit 7)
           LE Remove Advertising Set (Octet 37 - Bit 0)
           LE Clear Advertising Sets (Octet 37 - Bit 1)
           LE Set Extended Scan Parameters (Octet 37 - Bit 5)
           LE Set Extended Scan Enable (Octet 37 - Bit 6)
           LE Extended Create Connection (Octet 37 - Bit 7)
           LE Read Transmit Power (Octet 38 - Bit 7)
           LE Read RF Path Compensation (Octet 39 - Bit 0)
           LE Write RF Path Compensation (Octet 39 - Bit 1)
           LE Set Privacy Mode (Octet 39 - Bit 2)
           Read Local Simple Pairing Options (Octet 41 - Bit 3)
< HCI Command: Write Simple Pairing Mode (0x03|0x0056) plen 1 
             #35 [hci0] 2.703518
         Mode: Enabled (0x01)
 > HCI Event: Command Complete (0x0e) plen 4 
              #36 [hci0] 2.704399
       Write Simple Pairing Mode (0x03|0x0056) ncmd 1
         Status: Success (0x00)
< HCI Command: Write Inquiry Mode (0x03|0x0045) plen 1 
             #37 [hci0] 2.704498
         Mode: Inquiry Result with RSSI or Extended Inquiry Result (0x02)
 > HCI Event: Command Complete (0x0e) plen 4 
              #38 [hci0] 2.705405
       Write Inquiry Mode (0x03|0x0045) ncmd 2
         Status: Success (0x00)
< HCI Command: Read Inquiry Response TX Power Level (0x03|0x0058) plen 0 
             #39 [hci0] 2.705500
 > HCI Event: Command Complete (0x0e) plen 5 
              #40 [hci0] 2.706401
       Read Inquiry Response TX Power Level (0x03|0x0058) ncmd 1
         Status: Success (0x00)
         TX power: 12 dbm (0x0c)
< HCI Command: Read Local Extended Features (0x04|0x0004) plen 1 
             #41 [hci0] 2.706500
         Page: 1
 > HCI Event: Command Complete (0x0e) plen 14 
              #42 [hci0] 2.708392
       Read Local Extended Features (0x04|0x0004) ncmd 1
         Status: Success (0x00)
         Page: 1/2
         Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
           Secure Simple Pairing (Host Support)
< HCI Command: Set Event Mask (0x03|0x0001) plen 8 
             #43 [hci0] 2.708718
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
 > HCI Event: Command Complete (0x0e) plen 4 
              #44 [hci0] 2.709411
       Set Event Mask (0x03|0x0001) ncmd 1
         Status: Success (0x00)
< HCI Command: Read Stored Link Key (0x03|0x000d) plen 7 
             #45 [hci0] 2.709508
         Address: 00:00:00:00:00:00 (OUI 00-00-00)
         Read all: 0x01
 > HCI Event: Command Complete (0x0e) plen 8 
              #46 [hci0] 2.711396
       Read Stored Link Key (0x03|0x000d) ncmd 1
         Status: Success (0x00)
         Max num keys: 5
         Num keys: 0
< HCI Command: Write Default Link Policy Settings (0x02|0x000f) plen 2 
             #47 [hci0] 2.711502
         Link policy: 0x0005
           Enable Role Switch
           Enable Sniff Mode
 > HCI Event: Command Complete (0x0e) plen 4 
              #48 [hci0] 2.713397
       Write Default Link Policy Settings (0x02|0x000f) ncmd 1
         Status: Success (0x00)
< HCI Command: Read Page Scan Activity (0x03|0x001b) plen 0 
             #49 [hci0] 2.713500
 > HCI Event: Command Complete (0x0e) plen 8 
              #50 [hci0] 2.715405
       Read Page Scan Activity (0x03|0x001b) ncmd 2
         Status: Success (0x00)
         Interval: 1280.000 msec (0x0800)
         Window: 11.250 msec (0x0012)
< HCI Command: Read Page Scan Type (0x03|0x0046) plen 0 
             #51 [hci0] 2.715504
 > HCI Event: Command Complete (0x0e) plen 5 
              #52 [hci0] 2.716399
       Read Page Scan Type (0x03|0x0046) ncmd 2
         Status: Success (0x00)
         Type: Standard Scan (0x00)
< HCI Command: LE Set Event Mask (0x08|0x0001) plen 8 
             #53 [hci0] 2.716499
         Mask: 0x00000000000a1fff
           LE Connection Complete
           LE Advertising Report
           LE Connection Update Complete
           LE Read Remote Used Features Complete
           LE Long Term Key Request
           LE Remote Connection Parameter Request
           LE Data Length Change
           LE Read Local P-256 Public Key Complete
           LE Generate DHKey Complete
           LE Enhanced Connection Complete
           LE Direct Advertising Report
           LE PHY Update Complete
           LE Extended Advertising Report
           LE Extended Advertising Set Terminated
           LE Channel Selection Algorithm
 > HCI Event: Command Complete (0x0e) plen 4 
              #54 [hci0] 2.717399
       LE Set Event Mask (0x08|0x0001) ncmd 1
         Status: Success (0x00)
< HCI Command: LE Read White List Size (0x08|0x000f) plen 0 
             #55 [hci0] 2.717498
 > HCI Event: Command Complete (0x0e) plen 5 
              #56 [hci0] 2.719398
       LE Read White List Size (0x08|0x000f) ncmd 1
         Status: Success (0x00)
         Size: 25
< HCI Command: LE Clear White List (0x08|0x0010) plen 0 
             #57 [hci0] 2.719510
 > HCI Event: Command Complete (0x0e) plen 4 
              #58 [hci0] 2.720402
       LE Clear White List (0x08|0x0010) ncmd 1
         Status: Success (0x00)
< HCI Command: LE Read Resolving List Size (0x08|0x002a) plen 0 
             #59 [hci0] 2.720504
 > HCI Event: Command Complete (0x0e) plen 5 
              #60 [hci0] 2.721415
       LE Read Resolving List Size (0x08|0x002a) ncmd 1
         Status: Success (0x00)
         Size: 25
< HCI Command: LE Clear Resolving List (0x08|0x0029) plen 0 
             #61 [hci0] 2.721520
 > HCI Event: Command Complete (0x0e) plen 4 
              #62 [hci0] 2.722404
       LE Clear Resolving List (0x08|0x0029) ncmd 1
         Status: Success (0x00)
< HCI Command: LE Read Maximum Data Length (0x08|0x002f) plen 0 
             #63 [hci0] 2.722509
 > HCI Event: Command Complete (0x0e) plen 12 
              #64 [hci0] 2.723410
       LE Read Maximum Data Length (0x08|0x002f) ncmd 1
         Status: Success (0x00)
         Max TX octets: 251
         Max TX time: 17040
         Max RX octets: 251
         Max RX time: 17040
< HCI Command: LE Read Suggested Default Data Length (0x08|0x0023) plen 
0            #65 [hci0] 2.723510
 > HCI Event: Command Complete (0x0e) plen 8 
              #66 [hci0] 2.725395
       LE Read Suggested Default Data Length (0x08|0x0023) ncmd 1
         Status: Success (0x00)
         TX octets: 27
         TX time: 328
< HCI Command: LE Read Number of Supported Advertising Sets 
(0x08|0x003b) plen 0     #67 [hci0] 2.725494
 > HCI Event: Command Complete (0x0e) plen 5 
              #68 [hci0] 2.726400
       LE Read Number of Supported Advertising Sets (0x08|0x003b) ncmd 1
         Status: Success (0x00)
         Num supported adv sets: 6
< HCI Command: Write LE Host Supported (0x03|0x006d) plen 2 
             #69 [hci0] 2.726501
         Supported: 0x01
         Simultaneous: 0x00
 > HCI Event: Command Complete (0x0e) plen 4 
              #70 [hci0] 2.728389
       Write LE Host Supported (0x03|0x006d) ncmd 1
         Status: Success (0x00)
< HCI Command: Read Local Extended Features (0x04|0x0004) plen 1 
             #71 [hci0] 2.728490
         Page: 2
 > HCI Event: Command Complete (0x0e) plen 14 
              #72 [hci0] 2.730469
       Read Local Extended Features (0x04|0x0004) ncmd 1
         Status: Success (0x00)
         Page: 2/2
         Features: 0x20 0x0b 0x00 0x00 0x00 0x00 0x00 0x00
           Generalized interlaced scan
           Secure Connections (Controller Support)
           Ping
           Train nudging
< HCI Command: Delete Stored Link Key (0x03|0x0012) plen 7 
             #73 [hci0] 2.730705
         Address: 00:00:00:00:00:00 (OUI 00-00-00)
         Delete all: 0x01
 > HCI Event: Command Complete (0x0e) plen 6 
              #74 [hci0] 2.731403
       Delete Stored Link Key (0x03|0x0012) ncmd 1
         Status: Success (0x00)
         Num keys: 0
< HCI Command: Set Event Mask Page 2 (0x03|0x0063) plen 8 
             #75 [hci0] 2.731505
         Mask: 0x0000000000800000
           Authenticated Payload Timeout Expired
 > HCI Event: Command Complete (0x0e) plen 4 
              #76 [hci0] 2.732409
       Set Event Mask Page 2 (0x03|0x0063) ncmd 1
         Status: Success (0x00)
< HCI Command: Read Local Supported Codecs (0x04|0x000b) plen 0 
             #77 [hci0] 2.732508
 > HCI Event: Command Complete (0x0e) plen 12 
              #78 [hci0] 2.734392
       Read Local Supported Codecs (0x04|0x000b) ncmd 1
         Status: Success (0x00)
         Number of supported codecs: 6
           Codec: u-law log (0x00)
           Codec: A-law log (0x01)
           Codec: CVSD (0x02)
           Codec: Transparent (0x03)
           Codec: Linear PCM (0x04)
           Codec: mSBC (0x05)
         Number of vendor codecs: 0
< HCI Command: Write Secure Connections Host Support (0x03|0x007a) plen 
1            #79 [hci0] 2.734500
         Support: Enabled (0x01)
 > HCI Event: Command Complete (0x0e) plen 4 
              #80 [hci0] 2.735401
       Write Secure Connections Host Support (0x03|0x007a) ncmd 1
         Status: Success (0x00)
< HCI Command: LE Write Suggested Default Data Length (0x08|0x0024) plen 
4           #81 [hci0] 2.735507
         TX octets: 251
         TX time: 17040
 > HCI Event: Command Complete (0x0e) plen 4 
              #82 [hci0] 2.736401
       LE Write Suggested Default Data Length (0x08|0x0024) ncmd 1
         Status: Success (0x00)
< HCI Command: LE Set Default PHY (0x08|0x0031) plen 3 
             #83 [hci0] 2.736505
         All PHYs preference: 0x00
         TX PHYs preference: 0x01
           LE 1M
         RX PHYs preference: 0x01
           LE 1M
 > HCI Event: Command Complete (0x0e) plen 4 
              #84 [hci0] 2.737399
       LE Set Default PHY (0x08|0x0031) ncmd 1
         Status: Success (0x00)
= Index Info: 20:79:18:E7:0C:42 (Intel Corp.) 
                 [hci0] 2.737521
< HCI Command: LE Set Extended Advertising Parameters (0x08|0x0036) plen 
25          #85 [hci0] 2.753556
         Handle: 0x00
         Properties: 0x0012
           Scannable
           Use legacy advertising PDUs: ADV_SCAN_IND
         Min advertising interval: 1280.000 msec (0x0800)
         Max advertising interval: 1280.000 msec (0x0800)
         Channel map: 37, 38, 39 (0x07)
         Own address type: Random (0x01)
         Peer address type: Public (0x00)
         Peer address: 00:00:00:00:00:00 (OUI 00-00-00)
         Filter policy: Allow Scan Request from Any, Allow Connect 
Request from Any (0x00)
         TX power: Host has no preference (0x7f)
         Primary PHY: LE 1M (0x01)
         Secondary max skip: 0x00
         Secondary PHY: LE 1M (0x01)
         SID: 0x00
         Scan request notifications: Disabled (0x00)
 > HCI Event: Command Complete (0x0e) plen 5 
              #86 [hci0] 2.755421
       LE Set Extended Advertising Parameters (0x08|0x0036) ncmd 1
         Status: Success (0x00)
         TX power (selected): 7 dbm (0x07)
< HCI Command: LE Set Advertising Set Random Address (0x08|0x0035) plen 
7            #87 [hci0] 2.755608
         Advertising handle: 0x00
         Advertising random address: 0D:7D:D2:EA:1F:63 (Non-Resolvable)
 > HCI Event: Command Complete (0x0e) plen 4 
              #88 [hci0] 2.756409
       LE Set Advertising Set Random Address (0x08|0x0035) ncmd 1
         Status: Success (0x00)
< HCI Command: LE Set Extended Scan Response Data (0x08|0x0038) plen 35 
             #89 [hci0] 2.756549
         Handle: 0x00
         Operation: Complete scan response data (0x03)
         Fragment preference: Minimize fragmentation (0x01)
         Data length: 0x0a
         Name (complete): Brane31
 > HCI Event: Command Complete (0x0e) plen 4 
              #90 [hci0] 2.757406
       LE Set Extended Scan Response Data (0x08|0x0038) ncmd 1
         Status: Success (0x00)
< HCI Command: Write Scan Enable (0x03|0x001a) plen 1 
             #91 [hci0] 2.757535
         Scan enable: Page Scan (0x02)
 > HCI Event: Command Complete (0x0e) plen 4 
              #92 [hci0] 2.758403
       Write Scan Enable (0x03|0x001a) ncmd 2
         Status: Success (0x00)
< HCI Command: Write Class of Device (0x03|0x0024) plen 3 
             #93 [hci0] 2.758536
         Class: 0x000414
           Major class: Audio/Video (headset, speaker, stereo, video, vcr)
           Minor class: Loudspeaker
 > HCI Event: Command Complete (0x0e) plen 4 
              #94 [hci0] 2.759404
       Write Class of Device (0x03|0x0024) ncmd 1
         Status: Success (0x00)
@ MGMT Event: Class Of Device Changed (0x0007) plen 3 
        {0x0001} [hci0] 2.759495
         Class: 0x000414
           Major class: Audio/Video (headset, speaker, stereo, video, vcr)
           Minor class: Loudspeaker
< HCI Command: Write Local Name (0x03|0x0013) plen 248 
             #95 [hci0] 2.759570
         Name: Brane31
 > HCI Event: Command Complete (0x0e) plen 4 
              #96 [hci0] 2.760408
       Write Local Name (0x03|0x0013) ncmd 1
         Status: Success (0x00)
@ MGMT Event: Local Name Changed (0x0008) plen 260 
        {0x0001} [hci0] 2.760505
         Name: Brane31
         Short name:
< HCI Command: Write Extended Inquiry Response (0x03|0x0052) plen 241 
             #97 [hci0] 2.760580
         FEC: Not required (0x00)
         Name (complete): Brane31
         TX power: 12 dBm
         Device ID: USB Implementer's Forum assigned (0x0002)
           Vendor: Linux Foundation (0x1d6b)
           Product: 0x0246
           Version: 5.3.13 (0x053d)
         16-bit Service UUIDs (complete): 5 entries
           Generic Access Profile (0x1800)
           Generic Attribute Profile (0x1801)
           Device Information (0x180a)
           A/V Remote Control (0x110e)
           A/V Remote Control Target (0x110c)
 > HCI Event: Command Complete (0x0e) plen 4 
              #98 [hci0] 2.761415
       Write Extended Inquiry Response (0x03|0x0052) ncmd 1
         Status: Success (0x00)
< HCI Command: LE Set Extended Advertising Data (0x08|0x0037) plen 35 
             #99 [hci0] 2.761562
         Handle: 0x00
         Operation: Complete extended advertising data (0x03)
         Fragment preference: Minimize fragmentation (0x01)
         Data length: 0x03
         TX power: 7 dBm
 > HCI Event: Command Complete (0x0e) plen 4 
             #100 [hci0] 2.762407
       LE Set Extended Advertising Data (0x08|0x0037) ncmd 1
         Status: Success (0x00)
@ MGMT Event: New Settings (0x0006) plen 4 
        {0x0001} [hci0] 2.764397
         Current settings: 0x00000ac1
           Powered
           Secure Simple Pairing
           BR/EDR
           Low Energy
           Secure Connections
@ RAW Close: hciconfig 
               {0x0002} 2.768949
@ MGMT Command: Add UUID (0x0010) plen 17 
        {0x0001} [hci0] 5.462119
         UUID: Battery Service
         Service class: 0x00
< HCI Command: Write Extended Inquiry Response (0x03|0x0052) plen 241 
            #101 [hci0] 5.462275
         FEC: Not required (0x00)
         Name (complete): Brane31
         TX power: 12 dBm
         Device ID: USB Implementer's Forum assigned (0x0002)
           Vendor: Linux Foundation (0x1d6b)
           Product: 0x0246
           Version: 5.3.13 (0x053d)
         16-bit Service UUIDs (complete): 6 entries
           Generic Access Profile (0x1800)
           Generic Attribute Profile (0x1801)
           Device Information (0x180a)
           A/V Remote Control (0x110e)
           A/V Remote Control Target (0x110c)
           Battery Service (0x180f)
 > HCI Event: Command Complete (0x0e) plen 4 
             #102 [hci0] 5.463331
       Write Extended Inquiry Response (0x03|0x0052) ncmd 1
         Status: Success (0x00)
@ MGMT Event: Command Complete (0x0001) plen 6 
        {0x0001} [hci0] 5.463454
       Add UUID (0x0010) plen 3
         Status: Success (0x00)
         Class: 0x000414
           Major class: Audio/Video (headset, speaker, stereo, video, vcr)
           Minor class: Loudspeaker
@ MGMT Command: Add Advertising (0x003e) plen 56 
        {0x0001} [hci0] 5.463615
         Instance: 1
         Flags: 0x00000011
           Switch into Connectable mode
           Add TX Power field to Advertising Data
         Duration: 0
         Timeout: 0
         Advertising data length: 26
         16-bit Service UUIDs (complete): 1 entry
           Battery Service (0x180f)
         Company: internal use (65535)
           Data: 00010203
         Service Data (UUID 0x9999): 0001020304
         Transport Discovery Data
           Organization: Bluetooth SIG (0x01)
           Flags: 0x01
             Role: 0x01
               Seeker Only
             Transport Data Incomplete: False (0x00)
             Transport State: 0x00
               Off
           Length: 0
           Data:
         Scan response length: 19
         Name (complete): TestAdvertisement
< HCI Command: LE Set Extended Advertising Parameters (0x08|0x0036) plen 
25         #103 [hci0] 5.463754
         Handle: 0x01
         Properties: 0x0013
           Connectable
           Scannable
           Use legacy advertising PDUs: ADV_IND
         Min advertising interval: 1280.000 msec (0x0800)
         Max advertising interval: 1280.000 msec (0x0800)
         Channel map: 37, 38, 39 (0x07)
         Own address type: Public (0x00)
         Peer address type: Public (0x00)
         Peer address: 00:00:00:00:00:00 (OUI 00-00-00)
         Filter policy: Allow Scan Request from Any, Allow Connect 
Request from Any (0x00)
         TX power: Host has no preference (0x7f)
         Primary PHY: LE 1M (0x01)
         Secondary max skip: 0x00
         Secondary PHY: LE 1M (0x01)
         SID: 0x00
         Scan request notifications: Disabled (0x00)
 > HCI Event: Command Complete (0x0e) plen 5 
             #104 [hci0] 5.464304
       LE Set Extended Advertising Parameters (0x08|0x0036) ncmd 1
         Status: Success (0x00)
         TX power (selected): 7 dbm (0x07)
< HCI Command: LE Set Extended Scan Response Data (0x08|0x0038) plen 35 
            #105 [hci0] 5.464461
         Handle: 0x00
         Operation: Complete scan response data (0x03)
         Fragment preference: Minimize fragmentation (0x01)
         Data length: 0x13
         Name (complete): TestAdvertisement
 > HCI Event: Command Complete (0x0e) plen 4 
             #106 [hci0] 5.465303
       LE Set Extended Scan Response Data (0x08|0x0038) ncmd 1
         Status: Success (0x00)
< HCI Command: LE Set Extended Advertising Enable (0x08|0x0039) plen 6 
            #107 [hci0] 5.465459
         Extended advertising: Enabled (0x01)
         Number of sets: 1 (0x01)
         Entry 0
           Handle: 0x01
           Duration: 2000 ms (0xc8)
           Max ext adv events: 0
 > HCI Event: Command Complete (0x0e) plen 4 
             #108 [hci0] 5.468300
       LE Set Extended Advertising Enable (0x08|0x0039) ncmd 2
         Status: Success (0x00)
@ MGMT Event: Command Complete (0x0001) plen 4 
        {0x0001} [hci0] 5.468437
       Add Advertising (0x003e) plen 1
         Status: Success (0x00)
         Instance: 1
< HCI Command: LE Set Extended Advertising Data (0x08|0x0037) plen 35 
            #109 [hci0] 5.468490
         Handle: 0x00
         Operation: Complete extended advertising data (0x03)
         Fragment preference: Minimize fragmentation (0x01)
         Data length: 0x1d
         16-bit Service UUIDs (complete): 1 entry
           Battery Service (0x180f)
         Company: internal use (65535)
           Data: 00010203
         Service Data (UUID 0x9999): 0001020304
         Transport Discovery Data
           Organization: Bluetooth SIG (0x01)
           Flags: 0x01
             Role: 0x01
               Seeker Only
             Transport Data Incomplete: False (0x00)
             Transport State: 0x00
               Off
           Length: 0
           Data:
         TX power: 7 dBm
 > HCI Event: LE Meta Event (0x3e) plen 6 
             #110 [hci0] 5.470404
       LE Advertising Set Terminated (0x12)
         Status: Advertising Timeout (0x3c)
         Handle: 1
         Connection handle: 65535
         Number of completed extended advertising events: 0
@ MGMT Event: Advertising Removed (0x0024) plen 1 
        {0x0001} [hci0] 5.470504
         Instance: 1
 > HCI Event: Command Complete (0x0e) plen 4 
             #111 [hci0] 5.472302
       LE Set Extended Advertising Data (0x08|0x0037) ncmd 1
         Status: Success (0x00)
@ MGMT Command: Remove Advertising (0x003f) plen 1 
        {0x0001} [hci0] 14.696878
         Instance: 1
@ MGMT Event: Command Status (0x0002) plen 3 
        {0x0001} [hci0] 14.696964
       Remove Advertising (0x003f)
         Status: Invalid Parameters (0x0d)
@ MGMT Command: Remove UUID (0x0011) plen 16 
        {0x0001} [hci0] 14.697089
         UUID: Battery Service
< HCI Command: Write Extended Inquiry Response (0x03|0x0052) plen 241 
            #112 [hci0] 14.697200
         FEC: Not required (0x00)
         Name (complete): Brane31
         TX power: 12 dBm
         Device ID: USB Implementer's Forum assigned (0x0002)
           Vendor: Linux Foundation (0x1d6b)
           Product: 0x0246
           Version: 5.3.13 (0x053d)
         16-bit Service UUIDs (complete): 5 entries
           Generic Access Profile (0x1800)
           Generic Attribute Profile (0x1801)
           Device Information (0x180a)
           A/V Remote Control (0x110e)
           A/V Remote Control Target (0x110c)
 > HCI Event: Command Complete (0x0e) plen 4 
             #113 [hci0] 14.697971
       Write Extended Inquiry Response (0x03|0x0052) ncmd 1
         Status: Success (0x00)
@ MGMT Event: Command Complete (0x0001) plen 6 
        {0x0001} [hci0] 14.698124
       Remove UUID (0x0011) plen 3
         Status: Success (0x00)
         Class: 0x000414
           Major class: Audio/Video (headset, speaker, stereo, video, vcr)
           Minor class: Loudspeaker


Any help on this would be appreciated.
- Ethan
