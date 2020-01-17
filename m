Return-Path: <SRS0=B7Pc=3G=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF77C33CB1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jan 2020 06:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D77C2083E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jan 2020 06:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgAQGaC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Jan 2020 01:30:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:44764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbgAQGaC (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Jan 2020 01:30:02 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Fri, 17 Jan 2020 06:29:59 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mastercatz@hotmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-60824-62941-0Dy9eSfL2q@https.bugzilla.kernel.org/>
In-Reply-To: <bug-60824-62941@https.bugzilla.kernel.org/>
References: <bug-60824-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=60824

MasterCATZ (mastercatz@hotmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |mastercatz@hotmail.com

--- Comment #46 from MasterCATZ (mastercatz@hotmail.com) ---
same boat have not used my Bluetooth dongle for years and need them again 
and can not get working Ubuntu 19 


hciconfig
hci0:   Type: Primary  Bus: USB
        BD Address: 00:11:67:55:8F:C3  ACL MTU: 672:3  SCO MTU: 48:1
        DOWN 
        RX bytes:918 acl:0 sco:0 events:32 errors:0
        TX bytes:112 acl:0 sco:0 commands:32 errors:2

usb 5-1: USB disconnect, device number 2
[176552.338881] usb 5-1: new full-speed USB device number 4 using xhci_hcd
[176552.494463] usb 5-1: config 1 interface 1 altsetting 0 endpoint 0x83 has
wMaxPacketSize 0, skipping
[176552.494466] usb 5-1: config 1 interface 1 altsetting 0 endpoint 0x3 has
wMaxPacketSize 0, skipping
[176552.503454] usb 5-1: New USB device found, idVendor=0a12, idProduct=0001,
bcdDevice= 1.34
[176552.503456] usb 5-1: New USB device strings: Mfr=1, Product=2,
SerialNumber=0
[176552.503458] usb 5-1: Product: USB demo board
[176552.503458] usb 5-1: Manufacturer: Conwise Technology
[176847.054212] usb 5-1: USB disconnect, device number 4
[176849.007636] usb 5-1: new full-speed USB device number 5 using xhci_hcd
[176849.167625] usb 5-1: config 1 interface 1 altsetting 0 endpoint 0x83 has
wMaxPacketSize 0, skipping
[176849.167627] usb 5-1: config 1 interface 1 altsetting 0 endpoint 0x3 has
wMaxPacketSize 0, skipping
[176849.176617] usb 5-1: New USB device found, idVendor=0a12, idProduct=0001,
bcdDevice= 1.34
[176849.176618] usb 5-1: New USB device strings: Mfr=1, Product=2,
SerialNumber=0
[176849.176619] usb 5-1: Product: USB demo board
[176849.176620] usb 5-1: Manufacturer: Conwise Technology
[177010.700332] NET: Registered protocol family 38
[177027.690747] debugfs: File 'dut_mode' in directory 'hci0' already present!
[177111.033769] usbcore: deregistering interface driver btusb
[177115.941071] usbcore: registered new interface driver btusb


sudo btmon
Bluetooth monitor ver 5.50
= Note: Linux version 5.4.11-050411-generic (x86_64)                           
                                            0.303554
= Note: Bluetooth subsystem version 2.22                                       
                                            0.303557
= New Index: 00:11:67:55:8F:C3 (Primary,USB,hci0)                              
                                     [hci0] 0.303588
@ MGMT Open: bluetoothd (privileged) version 1.14                              
                                   {0x0001} 0.303589
@ MGMT Open: btmon (privileged) version 1.14                                   
                                   {0x0002} 0.303655
@ RAW Open: hciconfig (privileged) version 2.22                                
                                  {0x0003} 17.071322
= Open Index: 00:11:67:55:8F:C3                                                
                                    [hci0] 17.186259
= Index Info: 00:11:67:55:8F:C3 (Cambridge Silicon Radio)                      
                                    [hci0] 17.186268
< HCI Command: Read Local Version Information (0x04|0x0001) plen 0             
                                 #1 [hci0] 17.186284
> HCI Event: Command Complete (0x0e) plen 12                                   
>                                  #2 [hci0] 17.189217
      Read Local Version Information (0x04|0x0001) ncmd 1
        Status: Success (0x00)
        HCI version: Bluetooth 2.0 (0x03) - Revision 500 (0x01f4)
        LMP version: Bluetooth 2.0 (0x03) - Subversion 500 (0x01f4)
        Manufacturer: Cambridge Silicon Radio (10)
< HCI Command: Reset (0x03|0x0003) plen 0                                      
                                 #3 [hci0] 17.189246
> HCI Event: Command Complete (0x0e) plen 4                                    
>                                  #4 [hci0] 17.265218
      Reset (0x03|0x0003) ncmd 1
        Status: Success (0x00)
< HCI Command: Read Local Supported Features (0x04|0x0003) plen 0              
                                 #5 [hci0] 17.265235
> HCI Event: Command Complete (0x0e) plen 12                                   
>                                  #6 [hci0] 17.267216
      Read Local Supported Features (0x04|0x0003) ncmd 1
        Status: Success (0x00)
        Features: 0xff 0x3e 0x05 0x30 0x18 0x18 0x00 0x00
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
          CVSD synchronous data
          Power control
          Interlaced inquiry scan
          Interlaced page scan
          AFH capable slave
          AFH classification slave
          AFH capable master
          AFH classification master
< HCI Command: Read Local Version Information (0x04|0x0001) plen 0             
                                 #7 [hci0] 17.267230
> HCI Event: Command Complete (0x0e) plen 12                                   
>                                  #8 [hci0] 17.270215
      Read Local Version Information (0x04|0x0001) ncmd 1
        Status: Success (0x00)
        HCI version: Bluetooth 2.0 (0x03) - Revision 500 (0x01f4)
        LMP version: Bluetooth 2.0 (0x03) - Subversion 500 (0x01f4)
        Manufacturer: Cambridge Silicon Radio (10)
< HCI Command: Read BD ADDR (0x04|0x0009) plen 0                               
                                 #9 [hci0] 17.270232
> HCI Event: Command Complete (0x0e) plen 10                                   
>                                 #10 [hci0] 17.276215
      Read BD ADDR (0x04|0x0009) ncmd 1
        Status: Success (0x00)
        Address: 00:11:67:55:8F:C3 (Integrated System Solution Corp.)
< HCI Command: Read Buffer Size (0x04|0x0005) plen 0                           
                                #11 [hci0] 17.276270
> HCI Event: Command Complete (0x0e) plen 11                                   
>                                 #12 [hci0] 17.278218
      Read Buffer Size (0x04|0x0005) ncmd 1
        Status: Success (0x00)
        ACL MTU: 672  ACL max packet: 3
        SCO MTU: 48   SCO max packet: 1
< HCI Command: Read Class of Device (0x03|0x0023) plen 0                       
                                #13 [hci0] 17.278240
> HCI Event: Command Complete (0x0e) plen 7                                    
>                                 #14 [hci0] 17.282211
      Read Class of Device (0x03|0x0023) ncmd 1
        Status: Success (0x00)
        Class: 0x120104
          Major class: Computer (desktop, notebook, PDA, organizers)
          Minor class: Desktop workstation
          Networking (LAN, Ad hoc)
          Object Transfer (v-Inbox, v-Folder)
< HCI Command: Read Local Name (0x03|0x0014) plen 0                            
                                #15 [hci0] 17.282282
> HCI Event: Command Complete (0x0e) plen 252                                  
>                                 #16 [hci0] 17.305215
      Read Local Name (0x03|0x0014) ncmd 1
        Status: Success (0x00)
        Name: POV-ION
< HCI Command: Read Voice Setting (0x03|0x0025) plen 0                         
                                #17 [hci0] 17.305262
> HCI Event: Command Complete (0x0e) plen 6                                    
>                                 #18 [hci0] 17.307215
      Read Voice Setting (0x03|0x0025) ncmd 1
        Status: Success (0x00)
        Setting: 0x0060
          Input Coding: Linear
          Input Data Format: 2's complement
          Input Sample Size: 16-bit
          # of bits padding at MSB: 0
          Air Coding Format: CVSD
< HCI Command: Read Number of Supported IAC (0x03|0x0038) plen 0               
                                #19 [hci0] 17.307235
> HCI Event: Command Complete (0x0e) plen 5                                    
>                                 #20 [hci0] 17.311210
      Read Number of Supported IAC (0x03|0x0038) ncmd 1
        Status: Success (0x00)
        Number of IAC: 2
< HCI Command: Read Current IAC LAP (0x03|0x0039) plen 0                       
                                #21 [hci0] 17.311230
> HCI Event: Command Complete (0x0e) plen 8                                    
>                                 #22 [hci0] 17.313214
      Read Current IAC LAP (0x03|0x0039) ncmd 1
        Status: Success (0x00)
        Number of IAC: 1
        Access code: 0x9e8b33 (General Inquiry)
< HCI Command: Set Event Filter (0x03|0x0005) plen 1                           
                                #23 [hci0] 17.313230
        Type: Clear All Filters (0x00)
> HCI Event: Command Complete (0x0e) plen 4                                    
>                                 #24 [hci0] 17.316211
      Set Event Filter (0x03|0x0005) ncmd 1
        Status: Success (0x00)
< HCI Command: Write Connection Accept Timeout (0x03|0x0016) plen 2            
                                #25 [hci0] 17.316223
        Timeout: 20000.000 msec (0x7d00)
> HCI Event: Command Complete (0x0e) plen 4                                    
>                                 #26 [hci0] 17.319210
      Write Connection Accept Timeout (0x03|0x0016) ncmd 1
        Status: Success (0x00)
< HCI Command: Read Local Supported Commands (0x04|0x0002) plen 0              
                                #27 [hci0] 17.319221
> HCI Event: Command Complete (0x0e) plen 68                                   
>                                 #28 [hci0] 17.327209
      Read Local Supported Commands (0x04|0x0002) ncmd 1
        Status: Success (0x00)
        Commands: 109 entries
          Inquiry (Octet 0 - Bit 0)
          Inquiry Cancel (Octet 0 - Bit 1)
          Periodic Inquiry Mode (Octet 0 - Bit 2)
          Exit Periodic Inquiry Mode (Octet 0 - Bit 3)
          Create Connection (Octet 0 - Bit 4)
          Disconnect (Octet 0 - Bit 5)
          Add SCO Connection (Octet 0 - Bit 6)
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
          Read Remote Supported Features (Octet 2 - Bit 5)
          Read Remote Extended Features (Octet 2 - Bit 6)
          Read Remote Version Information (Octet 2 - Bit 7)
          Read Clock Offset (Octet 3 - Bit 0)
          Read LMP Handle (Octet 3 - Bit 1)
          Hold Mode (Octet 4 - Bit 1)
          Sniff Mode (Octet 4 - Bit 2)
          Exit Sniff Mode (Octet 4 - Bit 3)
          QoS Setup (Octet 4 - Bit 6)
          Role Discovery (Octet 4 - Bit 7)
          Switch Role (Octet 5 - Bit 0)
          Read Link Policy Settings (Octet 5 - Bit 1)
          Write Link Policy Settings (Octet 5 - Bit 2)
          Read Default Link Policy Settings (Octet 5 - Bit 3)
          Write Default Link Policy Settings (Octet 5 - Bit 4)
          Set Event Mask (Octet 5 - Bit 6)
          Reset (Octet 5 - Bit 7)
          Set Event Filter (Octet 6 - Bit 0)
          Flush (Octet 6 - Bit 1)
          Read PIN Type (Octet 6 - Bit 2)
          Write PIN Type (Octet 6 - Bit 3)
          Create New Unit Key (Octet 6 - Bit 4)
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
          Read Hold Mode Activity (Octet 10 - Bit 0)
          Write Hold Mode Activity (Octet 10 - Bit 1)
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
          Read Local Supported Commands (Octet 14 - Bit 4)
          Read Local Supported Features (Octet 14 - Bit 5)
          Read Local Extended Features (Octet 14 - Bit 6)
          Read Buffer Size (Octet 14 - Bit 7)
          Read Country Code (Octet 15 - Bit 0)
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
< HCI Command: Set Event Mask (0x03|0x0001) plen 8                             
                                #29 [hci0] 17.327247
        Mask: 0x00000001fffbffff
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
> HCI Event: Command Complete (0x0e) plen 4                                    
>                                 #30 [hci0] 17.329211
      Set Event Mask (0x03|0x0001) ncmd 1
        Status: Success (0x00)
< HCI Command: Read Stored Link Key (0x03|0x000d) plen 7                       
                                #31 [hci0] 17.329225
        Address: 00:00:00:00:00:00 (OUI 00-00-00)
        Read all: 0x01
> HCI Event: Command Complete (0x0e) plen 8                                    
>                                 #32 [hci0] 17.332214

@lsusb -v

Bus 005 Device 005: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth Dongle
(HCI mode)
Couldn't open device, some information will be missing
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass          224 Wireless
  bDeviceSubClass         1 Radio Frequency
  bDeviceProtocol         1 Bluetooth
  bMaxPacketSize0        16
  idVendor           0x0a12 Cambridge Silicon Radio, Ltd
  idProduct          0x0001 Bluetooth Dongle (HCI mode)
  bcdDevice            1.34
  iManufacturer           1 
  iProduct                2 
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength       0x006c
    bNumInterfaces          2
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0x80
      (Bus Powered)
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           3
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0010  1x 16 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0000  1x 0 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0000  1x 0 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       1
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0009  1x 9 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0009  1x 9 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       2
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0011  1x 17 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0011  1x 17 bytes
        bInterval               1


      Read Stored Link Key (0x03|0x000d) ncmd 1
        Status: Unsupported Feature or Parameter Value (0x11)
        Max num keys: 0
        Num keys: 0
= Close Index: 00:11:67:55:8F:C3                                               
                                    [hci0] 17.332241
@ RAW Close: hciconfig

-- 
You are receiving this mail because:
You are the assignee for the bug.
