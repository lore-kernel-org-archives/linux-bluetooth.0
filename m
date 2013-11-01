Return-Path: <cyrus@holtmann.org>
Message-ID: <5273147E.4040004@canonical.com>
Date: Fri, 01 Nov 2013 10:39:58 +0800
From: Hui Wang <hui.wang@canonical.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Tedd An <tedd.an@intel.com>, Johan Hedberg <johan.hedberg@intel.com>,
 xiong.y.zhang@intel.com,
 "Gustavo F. Padovan" <gustavo.padovan@collabora.co.uk>,
 "linux-bluetooth@vger.kernel.org development" <linux-bluetooth@vger.kernel.org>,
 Kun Yang <kun.yang@canonical.com>,
 Anthony Wong <anthony.wong@canonical.com>
Subject: Re: Intel 7260 bluetooth malfunction when it is connected to EHCI
 bus
References: <526F8804.9060906@canonical.com> <A07820C9-C272-4AD4-AE16-49F81956C2D7@holtmann.org> <52707428.9070908@canonical.com> <6091DDC7-7B00-4457-82A0-F8CC9B4EE9DD@holtmann.org> <5271EAA2.1030705@canonical.com> <D0B840E3-36C4-4751-A757-1ADDAC0707B9@holtmann.org>
In-Reply-To: <D0B840E3-36C4-4751-A757-1ADDAC0707B9@holtmann.org>
Content-Type: multipart/mixed;
 boundary="------------020607070303000304060102"
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------020607070303000304060102
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

On 10/31/2013 05:49 PM, Marcel Holtmann wrote:
> Hi Hui,
>
>>>>>> The problem is:
>>>>>> On the machine which has Intel 7260 BT module, i use it to connect a bluetooth headset,
>>>>>> it can successfully scan and connect to the headset, when i play sound to the bt headset,
>>>>>> the problem comes, if the bt module is connected to the XHCI, it can work very well.
>>>>>>
>>>>>> u@u-Lenovo-B4400:~$ lsusb -t
>>>>>> 1-7:1.0: No such file or directory
>>>>>> /: Bus 02.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/4p, 5000M
>>>>>> /: Bus 01.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/14p, 480M
>>>>>>     |__ Port 6: Dev 8, If 0, Class=HID, Driver=usbhid, 1.5M
>>>>>>     |__ Port 7: Dev 2, If 0, Class=vend., Driver=, 12M
>>>>>>     |__ Port 11: Dev 3, If 0, Class='bInterfaceClass 0xe0 not yet handled', Driver=btusb, 12M
>>>>>>     |__ Port 11: Dev 3, If 1, Class='bInterfaceClass 0xe0 not yet handled', Driver=btusb, 12M
>>>>>>
>>>>>> But if the bt module is connected to the EHCI, it always fails to play sound.
>>>>>>
>>>>>> u@u-Lenovo-B4400:~$ lsusb -t
>>>>>> /: Bus 04.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/4p, 5000M
>>>>>> /: Bus 03.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/14p, 480M
>>>>>> /: Bus 02.Port 1: Dev 1, Class=root_hub, Driver=ehci_hcd/3p, 480M
>>>>>>     |__ Port 1: Dev 2, If 0, Class=hub, Driver=hub/8p, 480M
>>>>>> /: Bus 01.Port 1: Dev 1, Class=root_hub, Driver=ehci_hcd/3p, 480M
>>>>>>     |__ Port 1: Dev 2, If 0, Class=hub, Driver=hub/6p, 480M
>>>>>>         |__ Port 5: Dev 3, If 0, Class='bInterfaceClass 0xe0 not yet handled', Driver=btusb, 12M
>>>>>>         |__ Port 5: Dev 3, If 1, Class='bInterfaceClass 0xe0 not yet handled', Driver=btusb, 12M
>>>>>>         |__ Port 6: Dev 4, If 0, Class='bInterfaceClass 0x0e not yet handled', Driver=uvcvideo, 480M
>>>>>>         |__ Port 6: Dev 4, If 1, Class='bInterfaceClass 0x0e not yet handled', Driver=uvcvideo, 480M
>>>>> can you paste /sys/kernel/debug/usb/devices here.
>>>>>
>>>>> If the uvcvideo driver is also using ISOC URBs, we might have just exhausted the bandwidth of the USB bus here or these two devices just do not play nice with each other.
>>>>>
>>>>> Try to unload the uvcvideo driver and try it again.
>>>> Thanks for your reply, follow your instruction, i totally disabled the camera from the BIOS, then the usb tree like this,
>>>> u@u-Lenovo-B4400:~$ lsusb -t
>>>> 1-1.3:1.0: No such file or directory
>>>> /:  Bus 04.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/4p, 5000M
>>>> /:  Bus 03.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/14p, 480M
>>>> /:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=ehci-pci/3p, 480M
>>>>     |__ Port 1: Dev 2, If 0, Class=hub, Driver=hub/8p, 480M
>>>> /:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=ehci-pci/3p, 480M
>>>>     |__ Port 1: Dev 2, If 0, Class=hub, Driver=hub/6p, 480M
>>>>         |__ Port 2: Dev 3, If 0, Class=HID, Driver=usbhid, 1.5M
>>>>         |__ Port 3: Dev 4, If 0, Class=vend., Driver=, 12M
>>>>         |__ Port 5: Dev 5, If 0, Class='bInterfaceClass 0xe0 not yet handled', Driver=btusb, 12M
>>>>         |__ Port 5: Dev 5, If 1, Class='bInterfaceClass 0xe0 not yet handled', Driver=btusb, 12M
>>>> u@u-Lenovo-B4400:~$ uname -a
>>>> Linux u-Lenovo-B4400 3.12.0-031200rc6-generic #201310191635 SMP Sat Oct 19 20:36:43 UTC 2013 x86_64 x86_64 x86_64 GNU/Linux
>>>>
>>>> I re-did the test, the result is same as before, after the headset is connected and i play audio, no sound is heard from the headset.
>>>> And hciconfig output shows still no SCO packets received by BT driver.
>>>> u@u-Lenovo-B4400:~$ hciconfig
>>>> hci0:    Type: BR/EDR  Bus: USB
>>>>     BD Address: 00:15:00:CC:2D:D2  ACL MTU: 1021:5  SCO MTU: 96:5
>>>>     UP RUNNING PSCAN
>>>>     RX bytes:5853 acl:61 sco:0 events:298 errors:0
>>>>     TX bytes:19212 acl:68 sco:1 commands:179 errors:0
>>> this is strange. The only reason I can think of is that you do not have the firmware installed and or it is not loaded correctly. Does dmesg give any indication that something failed here.
>> I can confirm the firmware file is the /lib/firmware/intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq, and it is in the filesystem. And from the dmesg, the firmware was successfully loaded.
>>
>> [    8.600217] Bluetooth: hci0: Intel Bluetooth firmware file: intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq
>> [    8.653635] kvm: disabled by bios
>> [    8.672981] psmouse serio1: synaptics: Touchpad model: 1, fw: 8.1, id: 0x1e2b1, caps: 0xd00123/0x840300/0x126c00
>> [    8.707034] input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio1/input/input13
>> [    8.717725] Registered led device: phy0-led
>> [    8.722730] ieee80211 phy0: Selected rate control algorithm 'iwl-mvm-rs'
>> [    8.752626] Bluetooth: hci0: Intel Bluetooth firmware patch completed and activated
>>
>>> Since this is a 3.12 kernel it should have native support for Intel specific setup routing. Any chance you can run btmon -w <file> before plugging the device into the bus. Maybe something goes wrong with the setup routine on EHCI.
>> Do you mean the hcidump file i just sent in my previous email.
> I do not get this. I specifically asked to run “btmon -w <file>” before plugging in the device. I want to see the early setup process here. What would I do with a hcidump trace.
Hi Marcel,

The attachment is the logfile generated by "btmon -w <file>". And the 
logfile was generated by below steps,

1) boot up the system into the ubuntu desktop
2) open a terminal and run "sudo btmon -w ~/lenovo-m4400s-btmon.log"
3) open bluetooth applet and click adding a new device, the bluetooth 
begin to scan devices
4) power up the bt headset
5) laptop bt module find the headset and connect it successfully
6) open the sound applet, choose bt headset as output device, play 
sound, but no sound can be heard from bt headset
7) Ctrl+C to terminate the "btmon -w <file>"

In case you can't receive the attachment, i decode the logfile and paste 
the content here.

Thanks,
Hui.

=================================================================================================
Bluetooth monitor ver 5.9
= New Index (BR/EDR,USB,hci0) [hci0] 0.218046
 > HCI Event (0x04) plen 10 [hci0] 2.886816
         Address: 78:F7:BE:08:5E:DF (OUI 78-F7-BE)
         Class: 0x240404
           Major class: Audio/Video (headset, speaker, stereo, video, vcr)
           Minor class: 0x01
           Rendering (Printing, Speaker)
           Audio (Speaker, Microphone, Headset)
         Link type: ACL (0x01)
< HCI Command (0x01|0x0009) plen 7 [hci0] 2.887014
         Address: 78:F7:BE:08:5E:DF (OUI 78-F7-BE)
         Role: Master (0x00)
 > HCI Event (0x0f) plen 4 [hci0] 2.887807
       Accept Connection Request (0x01|0x0009) ncmd 1
         Status: Success (0x00)
 > HCI Event (0x12) plen 8 [hci0] 3.028749
         Status: Success (0x00)
         Address: 78:F7:BE:08:5E:DF (OUI 78-F7-BE)
         Role: Master (0x00)
 > HCI Event (0x03) plen 11 [hci0] 3.034733
         Status: Success (0x00)
         Handle: 256
         Address: 78:F7:BE:08:5E:DF (OUI 78-F7-BE)
         Link type: ACL (0x01)
         Encryption: Disabled (0x00)
< HCI Command (0x01|0x001b) plen 2 [hci0] 3.034808
         Handle: 256
 > HCI Event (0x0f) plen 4 [hci0] 3.035730
       Read Remote Supported Features (0x01|0x001b) ncmd 1
         Status: Success (0x00)
 > HCI Event (0x1b) plen 3 [hci0] 3.041745
         Handle: 256
         Max slots: 5
 > HCI Event (0x0b) plen 11 [hci0] 3.043740
         Status: Success (0x00)
         Handle: 256
         Features: 0xbf 0xfe 0x8f 0xfe 0x9b 0xff 0x79 0x87
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
           Enhanced Power Control
           Extended features
< HCI Command (0x01|0x001c) plen 3 [hci0] 3.043755
         Handle: 256
         Page: 1
 > ACL Data RX flags 0x02 dlen 12 [hci0] 3.045734
       L2CAP: Connection Request (0x02) ident 2 len 4
         PSM: 1 (0x0001)
         Source CID: 65
 > HCI Event (0x0f) plen 4 [hci0] 3.045738
       Read Remote Extended Features (0x01|0x001c) ncmd 1
         Status: Success (0x00)
< ACL Data TX flags 0x00 dlen 16 [hci0] 3.045762
       L2CAP: Connection Response (0x03) ident 2 len 8
         Destination CID: 64
         Source CID: 65
         Result: Connection pending (0x0001)
         Status: No further information available (0x0000)
< ACL Data TX flags 0x00 dlen 10 [hci0] 3.045767
       L2CAP: Information Request (0x0a) ident 1 len 2
         Type: Extended features supported (0x0002)
 > HCI Event (0x23) plen 13 [hci0] 3.049734
         Status: Success (0x00)
         Handle: 256
         Page: 1/0
         Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
           Secure Simple Pairing (Host Support)
< HCI Command (0x01|0x0019) plen 10 [hci0] 3.049745
         Address: 78:F7:BE:08:5E:DF (OUI 78-F7-BE)
         Page scan repetition mode: R2 (0x02)
         Page scan mode: Mandatory (0x00)
         Clock offset: 0x0000
 > HCI Event (0x0f) plen 4 [hci0] 3.050721
       Remote Name Request (0x01|0x0019) ncmd 1
         Status: Success (0x00)
 > HCI Event (0x13) plen 5 [hci0] 3.051735
         Num handles: 1
         Handle: 256
         Count: 1
 > HCI Event (0x13) plen 5 [hci0] 3.056726
         Num handles: 1
         Handle: 256
         Count: 1
 > ACL Data RX flags 0x02 dlen 16 [hci0] 3.056969
       L2CAP: Information Response (0x0b) ident 1 len 8
         Type: Extended features supported (0x0002)
         Result: Success (0x0000)
         Features: 0x00000200
           Unicast Connectionless Data Reception
< ACL Data TX flags 0x00 dlen 10 [hci0] 3.056995
       L2CAP: Command Reject (0x01) ident 1 len 2
         Reason: Command not understood (0x0000)
 > HCI Event (0x13) plen 5 [hci0] 3.061726
         Num handles: 1
         Handle: 256
         Count: 1
 > HCI Event (0x07) plen 255 [hci0] 3.070718
         Status: Success (0x00)
         Address: 78:F7:BE:08:5E:DF (OUI 78-F7-BE)
         Name: HM1700
< ACL Data TX flags 0x00 dlen 16 [hci0] 7.047684
       L2CAP: Connection Response (0x03) ident 2 len 8
         Destination CID: 64
         Source CID: 65
         Result: Connection successful (0x0000)
         Status: No further information available (0x0000)
< ACL Data TX flags 0x00 dlen 12 [hci0] 7.047708
       L2CAP: Configure Request (0x04) ident 2 len 4
         Destination CID: 65
         Flags: 0x0000
 > HCI Event (0x13) plen 5 [hci0] 7.051758
         Num handles: 1
         Handle: 256
         Count: 1
 > ACL Data RX flags 0x02 dlen 16 [hci0] 7.052502
       L2CAP: Configure Request (0x04) ident 3 len 8
         Destination CID: 64
         Flags: 0x0000
         Option: Maximum Transmission Unit (0x01)
           MTU: 64
< ACL Data TX flags 0x00 dlen 18 [hci0] 7.052550
       L2CAP: Configure Response (0x05) ident 3 len 10
         Source CID: 65
         Flags: 0x0000
         Result: Success (0x0000)
         Option: Maximum Transmission Unit (0x01)
           MTU: 64
 > HCI Event (0x13) plen 5 [hci0] 7.052733
         Num handles: 1
         Handle: 256
         Count: 1
 > ACL Data RX flags 0x02 dlen 14 [hci0] 7.053751
       L2CAP: Configure Response (0x05) ident 2 len 6
         Source CID: 64
         Flags: 0x0000
         Result: Success (0x0000)
 > HCI Event (0x13) plen 5 [hci0] 7.056754
         Num handles: 1
         Handle: 256
         Count: 1
 > ACL Data RX flags 0x02 dlen 31 [hci0] 7.057249
       Channel: 64 len 27 [PSM 1 mode 0] {chan 0}
       SDP: Service Search Attribute Request (0x06) tid 0 len 22
         Search pattern: [len 5]
           Sequence (6) with 3 bytes [8 extra bits] len 5
             UUID (3) with 2 bytes [0 extra bits] len 3
               Handsfree Audio Gateway (0x111f)
         Max record count: 48
         Attribute list: [len 14]
           Sequence (6) with 12 bytes [8 extra bits] len 14
             Unsigned Integer (1) with 2 bytes [0 extra bits] len 3
               0x0001
             Unsigned Integer (1) with 2 bytes [0 extra bits] len 3
               0x0004
             Unsigned Integer (1) with 2 bytes [0 extra bits] len 3
               0x0009
             Unsigned Integer (1) with 2 bytes [0 extra bits] len 3
               0x0311
         Continuation state: 0
< ACL Data TX flags 0x00 dlen 68 [hci0] 7.057567
       Channel: 65 len 64 [PSM 1 mode 0] {chan 0}
       SDP: Service Search Attribute Response (0x07) tid 0 len 59
         Attribute bytes: 48
         Continuation state: 8
         5b 10 73 52 30 00 00 00 [.sR0...
 > ACL Data RX flags 0x02 dlen 39 [hci0] 7.063746
       Channel: 64 len 35 [PSM 1 mode 0] {chan 0}
       SDP: Service Search Attribute Request (0x06) tid 1 len 30
         Search pattern: [len 5]
           Sequence (6) with 3 bytes [8 extra bits] len 5
             UUID (3) with 2 bytes [0 extra bits] len 3
               Handsfree Audio Gateway (0x111f)
         Max record count: 48
         Attribute list: [len 14]
           Sequence (6) with 12 bytes [8 extra bits] len 14
             Unsigned Integer (1) with 2 bytes [0 extra bits] len 3
               0x0001
             Unsigned Integer (1) with 2 bytes [0 extra bits] len 3
               0x0004
             Unsigned Integer (1) with 2 bytes [0 extra bits] len 3
               0x0009
             Unsigned Integer (1) with 2 bytes [0 extra bits] len 3
               0x0311
         Continuation state: 8
         5b 10 73 52 30 00 00 00 [.sR0...
< ACL Data TX flags 0x00 dlen 15 [hci0] 7.063938
       Channel: 65 len 11 [PSM 1 mode 0] {chan 0}
       SDP: Service Search Attribute Response (0x07) tid 1 len 6
         Attribute bytes: 3
         Continuation state: 0
         Combined attribute bytes: 51
           Attribute list: [len 47] {position 0}
             Attribute: Service Class ID List (0x0001) [len 2]
               UUID (3) with 2 bytes [0 extra bits] len 3
                 Handsfree Audio Gateway (0x111f)
               UUID (3) with 2 bytes [0 extra bits] len 3
                 Generic Audio (0x1203)
             Attribute: Protocol Descriptor List (0x0004) [len 2]
               Sequence (6) with 3 bytes [8 extra bits] len 5
                 UUID (3) with 2 bytes [0 extra bits] len 3
                   L2CAP (0x0100)
               Sequence (6) with 5 bytes [8 extra bits] len 7
                 UUID (3) with 2 bytes [0 extra bits] len 3
                   RFCOMM (0x0003)
                 Unsigned Integer (1) with 1 byte [0 extra bits] len 2
                   0x0d
             Attribute: Bluetooth Profile Descriptor List (0x0009) [len 2]
               Sequence (6) with 6 bytes [8 extra bits] len 8
                 UUID (3) with 2 bytes [0 extra bits] len 3
                   Handsfree (0x111e)
                 Unsigned Integer (1) with 2 bytes [0 extra bits] len 3
                   0x0105
             Attribute: Unknown (0x0311) [len 2]
               0x0000
 > HCI Event (0x13) plen 5 [hci0] 7.064747
         Num handles: 1
         Handle: 256
         Count: 1
 > HCI Event (0x13) plen 5 [hci0] 7.067749
         Num handles: 1
         Handle: 256
         Count: 1
 > ACL Data RX flags 0x02 dlen 12 [hci0] 7.068619
       L2CAP: Disconnection Request (0x06) ident 4 len 4
         Destination CID: 64
         Source CID: 65
< ACL Data TX flags 0x00 dlen 12 [hci0] 7.068674
       L2CAP: Disconnection Response (0x07) ident 4 len 4
         Destination CID: 64
         Source CID: 65
 > HCI Event (0x13) plen 5 [hci0] 7.072746
         Num handles: 1
         Handle: 256
         Count: 1
 > HCI Event (0x17) plen 6 [hci0] 7.074742
         Address: 78:F7:BE:08:5E:DF (OUI 78-F7-BE)
< HCI Command (0x01|0x000c) plen 6 [hci0] 7.074922
         Address: 78:F7:BE:08:5E:DF (OUI 78-F7-BE)
 > HCI Event (0x0e) plen 10 [hci0] 7.075743
       Link Key Request Negative Reply (0x01|0x000c) ncmd 1
         Status: Success (0x00)
         Address: 78:F7:BE:08:5E:DF (OUI 78-F7-BE)
 > HCI Event (0x32) plen 9 [hci0] 7.080726
         Address: 78:F7:BE:08:5E:DF (OUI 78-F7-BE)
         IO capability: NoInputNoOutput (0x03)
         OOB data: Authentication data not present (0x00)
         Authentication: General Bonding - MITM required (0x05)
 > HCI Event (0x31) plen 6 [hci0] 7.081716
         Address: 78:F7:BE:08:5E:DF (OUI 78-F7-BE)
< HCI Command (0x01|0x002b) plen 9 [hci0] 7.081876
         Address: 78:F7:BE:08:5E:DF (OUI 78-F7-BE)
         IO capability: DisplayYesNo (0x01)
         OOB data: Authentication data not present (0x00)
         Authentication: General Bonding - MITM required (0x05)
 > HCI Event (0x0e) plen 10 [hci0] 7.082712
       IO Capability Request Reply (0x01|0x002b) ncmd 1
         Status: Success (0x00)
         Address: 78:F7:BE:08:5E:DF (OUI 78-F7-BE)
 > HCI Event (0x33) plen 10 [hci0] 7.339625
         Address: 78:F7:BE:08:5E:DF (OUI 78-F7-BE)
         Passkey: 575136
< HCI Command (0x01|0x002d) plen 6 [hci0] 7.339848
         Address: 78:F7:BE:08:5E:DF (OUI 78-F7-BE)
 > HCI Event (0x0e) plen 10 [hci0] 7.340647
       User Confirmation Request Neg Reply (0x01|0x002d) ncmd 1
         Status: Success (0x00)
         Address: 78:F7:BE:08:5E:DF (OUI 78-F7-BE)
 > HCI Event (0x36) plen 7 [hci0] 7.742431
         Status: Authentication Failure (0x05)
         Address: 78:F7:BE:08:5E:DF (OUI 78-F7-BE)
 > HCI Event (0x05) plen 4 [hci0] 7.897336
         Status: Success (0x00)
         Handle: 256
         Reason: Remote User Terminated Connection (0x13)
< HCI Command (0x01|0x0001) plen 5 [hci0] 16.279595
         Access code: 0x9e8b33 (General Inquiry)
         Length: 10.24s (0x08)
         Num responses: 0
 > HCI Event (0x0f) plen 4 [hci0] 16.281119
       Inquiry (0x01|0x0001) ncmd 2
         Status: Success (0x00)
 > HCI Event (0x2f) plen 255 [hci0] 17.025785
         Num responses: 1
         Address: 78:F7:BE:08:5E:DF (OUI 78-F7-BE)
         Page scan repetition mode: R1 (0x01)
         Page period mode: P0 (0x00)
         Class: 0x240404
           Major class: Audio/Video (headset, speaker, stereo, video, vcr)
           Minor class: 0x01
           Rendering (Printing, Speaker)
           Audio (Speaker, Microphone, Headset)
         Clock offset: 0x51f1
         RSSI: -44 dBm (0xd4)
         Name (complete): HM1700
         16-bit Service UUIDs (complete): 5 entries
           Headset (0x1108)
           Handsfree (0x111e)
           Audio Sink (0x110b)
           A/V Remote Control (0x110e)
           Serial Port (0x1101)
< HCI Command (0x01|0x0002) plen 0 [hci0] 25.122354
 > HCI Event (0x0e) plen 4 [hci0] 25.124712
       Inquiry Cancel (0x01|0x0002) ncmd 2
         Status: Success (0x00)
< HCI Command (0x01|0x0005) plen 13 [hci0] 25.127063
         Address: 78:F7:BE:08:5E:DF (OUI 78-F7-BE)
         Packet type: 0xcc18
         Page scan repetition mode: R2 (0x02)
         Page scan mode: Mandatory (0x00)
         Clock offset: 0x0000
         Role switch: Allow slave (0x01)
 > HCI Event (0x0f) plen 4 [hci0] 25.127693
       Create Connection (0x01|0x0005) ncmd 1
         Status: Success (0x00)
 > HCI Event (0x03) plen 11 [hci0] 25.988303
         Status: Success (0x00)
         Handle: 256
         Address: 78:F7:BE:08:5E:DF (OUI 78-F7-BE)
         Link type: ACL (0x01)
         Encryption: Disabled (0x00)
< HCI Command (0x01|0x001b) plen 2 [hci0] 25.988535
         Handle: 256
 > HCI Event (0x0f) plen 4 [hci0] 25.990330
       Read Remote Supported Features (0x01|0x001b) ncmd 1
         Status: Success (0x00)
 > HCI Event (0x1b) plen 3 [hci0] 25.993260
         Handle: 256
         Max slots: 5
 > HCI Event (0x0b) plen 11 [hci0] 25.996270
         Status: Success (0x00)
         Handle: 256
         Features: 0xbf 0xfe 0x8f 0xfe 0x9b 0xff 0x79 0x87
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
           Enhanced Power Control
           Extended features
< HCI Command (0x01|0x001c) plen 3 [hci0] 25.996285
         Handle: 256
         Page: 1
 > HCI Event (0x0f) plen 4 [hci0] 25.997267
       Read Remote Extended Features (0x01|0x001c) ncmd 1
         Status: Success (0x00)
 > HCI Event (0x23) plen 13 [hci0] 26.005271
         Status: Success (0x00)
         Handle: 256
         Page: 1/0
         Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
           Secure Simple Pairing (Host Support)
< HCI Command (0x01|0x0019) plen 10 [hci0] 26.005292
         Address: 78:F7:BE:08:5E:DF (OUI 78-F7-BE)
         Page scan repetition mode: R2 (0x02)
         Page scan mode: Mandatory (0x00)
         Clock offset: 0x0000
 > HCI Event (0x0f) plen 4 [hci0] 26.006256
       Remote Name Request (0x01|0x0019) ncmd 1
         Status: Success (0x00)
 > HCI Event (0x07) plen 255 [hci0] 26.025242
         Status: Success (0x00)
         Address: 78:F7:BE:08:5E:DF (OUI 78-F7-BE)
         Name: HM1700
< HCI Command (0x01|0x0011) plen 2 [hci0] 26.025266
         Handle: 256
 > HCI Event (0x0f) plen 4 [hci0] 26.026243
       Authentication Requested (0x01|0x0011) ncmd 1
         Status: Success (0x00)
 > HCI Event (0x17) plen 6 [hci0] 26.027313
         Address: 78:F7:BE:08:5E:DF (OUI 78-F7-BE)
< HCI Command (0x01|0x000c) plen 6 [hci0] 26.033110
         Address: 78:F7:BE:08:5E:DF (OUI 78-F7-BE)
 > HCI Event (0x0e) plen 10 [hci0] 26.034256
       Link Key Request Negative Reply (0x01|0x000c) ncmd 1
         Status: Success (0x00)
         Address: 78:F7:BE:08:5E:DF (OUI 78-F7-BE)
 > HCI Event (0x31) plen 6 [hci0] 26.035237
         Address: 78:F7:BE:08:5E:DF (OUI 78-F7-BE)
< HCI Command (0x01|0x002b) plen 9 [hci0] 26.035287
         Address: 78:F7:BE:08:5E:DF (OUI 78-F7-BE)
         IO capability: DisplayYesNo (0x01)
         OOB data: Authentication data not present (0x00)
         Authentication: Dedicated Bonding - MITM required (0x03)
 > HCI Event (0x0e) plen 10 [hci0] 26.036270
       IO Capability Request Reply (0x01|0x002b) ncmd 1
         Status: Success (0x00)
         Address: 78:F7:BE:08:5E:DF (OUI 78-F7-BE)
 > HCI Event (0x32) plen 9 [hci0] 26.040267
         Address: 78:F7:BE:08:5E:DF (OUI 78-F7-BE)
         IO capability: NoInputNoOutput (0x03)
         OOB data: Authentication data not present (0x00)
         Authentication: Dedicated Bonding - MITM not required (0x02)
 > HCI Event (0x33) plen 10 [hci0] 26.280169
         Address: 78:F7:BE:08:5E:DF (OUI 78-F7-BE)
         Passkey: 270951
< HCI Command (0x01|0x002c) plen 6 [hci0] 26.285610
         Address: 78:F7:BE:08:5E:DF (OUI 78-F7-BE)
 > HCI Event (0x0e) plen 10 [hci0] 26.287160
       User Confirmation Request Reply (0x01|0x002c) ncmd 1
         Status: Success (0x00)
         Address: 78:F7:BE:08:5E:DF (OUI 78-F7-BE)
 > HCI Event (0x36) plen 7 [hci0] 26.766879
         Status: Success (0x00)
         Address: 78:F7:BE:08:5E:DF (OUI 78-F7-BE)
 > HCI Event (0x18) plen 23 [hci0] 26.782938
         Address: 78:F7:BE:08:5E:DF (OUI 78-F7-BE)
         Link key: de2eb68b175d2935833022b04c121ce2
         Key type: Unauthenticated Combination key (0x04)
 > HCI Event (0x06) plen 3 [hci0] 26.783870
         Status: Success (0x00)
         Handle: 256
< HCI Command (0x01|0x0013) plen 3 [hci0] 26.783942
         Handle: 256
         Encryption: Enabled (0x01)
 > HCI Event (0x0f) plen 4 [hci0] 26.784940
       Set Connection Encryption (0x01|0x0013) ncmd 1
         Status: Success (0x00)
 > HCI Event (0x08) plen 4 [hci0] 26.826850
         Status: Success (0x00)
         Handle: 256
         Encryption: Enabled with E0 (0x01)
< ACL Data TX flags 0x00 dlen 10 [hci0] 26.826893
       L2CAP: Information Request (0x0a) ident 1 len 2
         Type: Extended features supported (0x0002)
 > HCI Event (0x13) plen 5 [hci0] 26.830847
         Num handles: 1
         Handle: 256
         Count: 1
 > ACL Data RX flags 0x02 dlen 16 [hci0] 26.831344
       L2CAP: Information Response (0x0b) ident 1 len 8
         Type: Extended features supported (0x0002)
         Result: Success (0x0000)
         Features: 0x00000200
           Unicast Connectionless Data Reception
< ACL Data TX flags 0x00 dlen 10 [hci0] 26.831381
       L2CAP: Command Reject (0x01) ident 1 len 2
         Reason: Command not understood (0x0000)
 > HCI Event (0x13) plen 5 [hci0] 26.835845
         Num handles: 1
         Handle: 256
         Count: 1
< ACL Data TX flags 0x00 dlen 12 [hci0] 30.831706
       L2CAP: Connection Request (0x02) ident 2 len 4
         PSM: 1 (0x0001)
         Source CID: 64
 > HCI Event (0x13) plen 5 [hci0] 30.835877
         Num handles: 1
         Handle: 256
         Count: 1
 > ACL Data RX flags 0x02 dlen 16 [hci0] 30.836841
       L2CAP: Connection Response (0x03) ident 2 len 8
         Destination CID: 67
         Source CID: 64
         Result: Connection successful (0x0000)
         Status: No further information available (0x0000)
< ACL Data TX flags 0x00 dlen 12 [hci0] 30.836891
       L2CAP: Configure Request (0x04) ident 3 len 4
         Destination CID: 67
         Flags: 0x0000
 > ACL Data RX flags 0x02 dlen 16 [hci0] 30.838159
       L2CAP: Configure Request (0x04) ident 2 len 8
         Destination CID: 64
         Flags: 0x0000
         Option: Maximum Transmission Unit (0x01)
           MTU: 64
< ACL Data TX flags 0x00 dlen 18 [hci0] 30.838224
       L2CAP: Configure Response (0x05) ident 2 len 10
         Source CID: 67
         Flags: 0x0000
         Result: Success (0x0000)
         Option: Maximum Transmission Unit (0x01)
           MTU: 64
 > HCI Event (0x13) plen 5 [hci0] 30.840918
         Num handles: 1
         Handle: 256
         Count: 1
 > ACL Data RX flags 0x02 dlen 14 [hci0] 30.841845
       L2CAP: Configure Response (0x05) ident 3 len 6
         Source CID: 64
         Flags: 0x0000
         Result: Success (0x0000)
< ACL Data TX flags 0x00 dlen 24 [hci0] 30.842014
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
 > HCI Event (0x13) plen 5 [hci0] 30.842845
         Num handles: 1
         Handle: 256
         Count: 1
 > HCI Event (0x13) plen 5 [hci0] 30.845847
         Num handles: 1
         Handle: 256
         Count: 1
 > ACL Data RX flags 0x02 dlen 68 [hci0] 30.846904
       Channel: 64 len 64 [PSM 1 mode 0] {chan 0}
       SDP: Service Search Attribute Response (0x07) tid 0 len 59
         Attribute bytes: 54
         Continuation state: 2
         00 36 .6
< ACL Data TX flags 0x00 dlen 26 [hci0] 30.847135
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
         00 36 .6
 > HCI Event (0x13) plen 5 [hci0] 30.850887
         Num handles: 1
         Handle: 256
         Count: 1
 > ACL Data RX flags 0x02 dlen 68 [hci0] 30.851837
       Channel: 64 len 64 [PSM 1 mode 0] {chan 0}
       SDP: Service Search Attribute Response (0x07) tid 1 len 59
         Attribute bytes: 54
         Continuation state: 2
         00 6c .l
< ACL Data TX flags 0x00 dlen 26 [hci0] 30.851969
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
         00 6c .l
 > HCI Event (0x13) plen 5 [hci0] 30.855867
         Num handles: 1
         Handle: 256
         Count: 1
 > ACL Data RX flags 0x02 dlen 68 [hci0] 30.856899
       Channel: 64 len 64 [PSM 1 mode 0] {chan 0}
       SDP: Service Search Attribute Response (0x07) tid 2 len 59
         Attribute bytes: 54
         Continuation state: 2
         00 a2 ..
< ACL Data TX flags 0x00 dlen 26 [hci0] 30.857114
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
         00 a2 ..
 > HCI Event (0x13) plen 5 [hci0] 30.860833
         Num handles: 1
         Handle: 256
         Count: 1
 > ACL Data RX flags 0x02 dlen 68 [hci0] 30.861829
       Channel: 64 len 64 [PSM 1 mode 0] {chan 0}
       SDP: Service Search Attribute Response (0x07) tid 3 len 59
         Attribute bytes: 54
         Continuation state: 2
         00 d8 ..
< ACL Data TX flags 0x00 dlen 26 [hci0] 30.862014
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
         00 d8 ..
 > HCI Event (0x13) plen 5 [hci0] 30.865838
         Num handles: 1
         Handle: 256
         Count: 1
 > ACL Data RX flags 0x02 dlen 62 [hci0] 30.866859
       Channel: 64 len 58 [PSM 1 mode 0] {chan 0}
       SDP: Service Search Attribute Response (0x07) tid 4 len 53
         Attribute bytes: 50
         Continuation state: 0
         Combined attribute bytes: 266
           Attribute list: [len 82] {position 0}
             Attribute: Service Record Handle (0x0000) [len 2]
               0x00010001
             Attribute: Service Class ID List (0x0001) [len 2]
               UUID (3) with 2 bytes [0 extra bits] len 3
                 Headset (0x1108)
               UUID (3) with 2 bytes [0 extra bits] len 3
                 Headset HS (0x1131)
               UUID (3) with 2 bytes [0 extra bits] len 3
                 Generic Audio (0x1203)
             Attribute: Protocol Descriptor List (0x0004) [len 2]
               Sequence (6) with 3 bytes [8 extra bits] len 5
                 UUID (3) with 2 bytes [0 extra bits] len 3
                   L2CAP (0x0100)
               Sequence (6) with 5 bytes [8 extra bits] len 7
                 UUID (3) with 2 bytes [0 extra bits] len 3
                   RFCOMM (0x0003)
                 Unsigned Integer (1) with 1 byte [0 extra bits] len 2
                   0x01
             Attribute: Browse Group List (0x0005) [len 2]
               UUID (3) with 2 bytes [0 extra bits] len 3
                 Public Browse Root (0x1002)
             Attribute: Bluetooth Profile Descriptor List (0x0009) [len 2]
               Sequence (6) with 6 bytes [8 extra bits] len 8
                 UUID (3) with 2 bytes [0 extra bits] len 3
                   Headset (0x1108)
                 Unsigned Integer (1) with 2 bytes [0 extra bits] len 3
                   0x0102
             Attribute: Unknown (0x0100) [len 2]
               HSP service [len 12]
             Attribute: Unknown (0x0302) [len 2]
               true
           Attribute list: [len 80] {position 1}
             Attribute: Service Record Handle (0x0000) [len 2]
               0x00010002
             Attribute: Service Class ID List (0x0001) [len 2]
               UUID (3) with 2 bytes [0 extra bits] len 3
                 Handsfree (0x111e)
               UUID (3) with 2 bytes [0 extra bits] len 3
                 Generic Audio (0x1203)
             Attribute: Protocol Descriptor List (0x0004) [len 2]
               Sequence (6) with 3 bytes [8 extra bits] len 5
                 UUID (3) with 2 bytes [0 extra bits] len 3
                   L2CAP (0x0100)
               Sequence (6) with 5 bytes [8 extra bits] len 7
                 UUID (3) with 2 bytes [0 extra bits] len 3
                   RFCOMM (0x0003)
                 Unsigned Integer (1) with 1 byte [0 extra bits] len 2
                   0x02
             Attribute: Browse Group List (0x0005) [len 2]
               UUID (3) with 2 bytes [0 extra bits] len 3
                 Public Browse Root (0x1002)
             Attribute: Bluetooth Profile Descriptor List (0x0009) [len 2]
               Sequence (6) with 6 bytes [8 extra bits] len 8
                 UUID (3) with 2 bytes [0 extra bits] len 3
                   Handsfree (0x111e)
                 Unsigned Integer (1) with 2 bytes [0 extra bits] len 3
                   0x0105
             Attribute: Unknown (0x0100) [len 2]
               HFP service [len 12]
             Attribute: Unknown (0x0311) [len 2]
               0x001b
           Attribute list: [len 92] {position 2}
             Attribute: Service Record Handle (0x0000) [len 2]
               0x00010003
             Attribute: Service Class ID List (0x0001) [len 2]
               UUID (3) with 2 bytes [0 extra bits] len 3
                 Audio Sink (0x110b)
             Attribute: Protocol Descriptor List (0x0004) [len 2]
               Sequence (6) with 6 bytes [8 extra bits] len 8
                 UUID (3) with 2 bytes [0 extra bits] len 3
                   L2CAP (0x0100)
                 Unsigned Integer (1) with 2 bytes [0 extra bits] len 3
                   0x0019
               Sequence (6) with 6 bytes [8 extra bits] len 8
                 UUID (3) with 2 bytes [0 extra bits] len 3
                   AVDTP (0x0019)
                 Unsigned Integer (1) with 2 bytes [0 extra bits] len 3
                   0x0102
             Attribute: Browse Group List (0x0005) [len 2]
               UUID (3) with 2 bytes [0 extra bits] len 3
                 Public Browse Root (0x1002)
             Attribute: Bluetooth Profile Descriptor List (0x0009) [len 2]
               Sequence (6) with 6 bytes [8 extra bits] len 8
                 UUID (3) with 2 bytes [0 extra bits] len 3
                   Advanced Audio Distribution (0x110d)
                 Unsigned Integer (1) with 2 bytes [0 extra bits] len 3
                   0x0102
             Attribute: Unknown (0x0100) [len 2]
               Advanced audio service [len 23]
             Attribute: Unknown (0x0311) [len 2]
               0x0001
< ACL Data TX flags 0x00 dlen 24 [hci0] 30.987030
       Channel: 67 len 20 [PSM 1 mode 0] {chan 0}
       SDP: Service Search Attribute Request (0x06) tid 5 len 15
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
 > HCI Event (0x13) plen 5 [hci0] 30.990839
         Num handles: 1
         Handle: 256
         Count: 1
 > ACL Data RX flags 0x02 dlen 67 [hci0] 30.991834
       Channel: 64 len 63 [PSM 1 mode 0] {chan 0}
       SDP: Service Search Attribute Response (0x07) tid 5 len 58
         Attribute bytes: 53
         Continuation state: 2
         00 35 .5
< ACL Data TX flags 0x00 dlen 26 [hci0] 30.992052
       Channel: 67 len 22 [PSM 1 mode 0] {chan 0}
       SDP: Service Search Attribute Request (0x06) tid 6 len 17
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
         00 35 .5
 > HCI Event (0x13) plen 5 [hci0] 30.995811
         Num handles: 1
         Handle: 256
         Count: 1
 > ACL Data RX flags 0x02 dlen 29 [hci0] 30.996518
       Channel: 64 len 25 [PSM 1 mode 0] {chan 0}
       SDP: Service Search Attribute Response (0x07) tid 6 len 20
         Attribute bytes: 17
         Continuation state: 0
         Combined attribute bytes: 70
           Attribute list: [len 65] {position 0}
             Attribute: Service Record Handle (0x0000) [len 2]
               0x00010000
             Attribute: Service Class ID List (0x0001) [len 2]
               UUID (3) with 2 bytes [0 extra bits] len 3
                 PnP Information (0x1200)
             Attribute: Browse Group List (0x0005) [len 2]
               UUID (3) with 2 bytes [0 extra bits] len 3
                 Public Browse Root (0x1002)
             Attribute: Unknown (0x0200) [len 2]
               0x0103
             Attribute: Unknown (0x0201) [len 2]
               0x000f
             Attribute: Unknown (0x0202) [len 2]
               0x0000
             Attribute: Unknown (0x0203) [len 2]
               0x0000
             Attribute: Unknown (0x0204) [len 2]
               true
             Attribute: Unknown (0x0205) [len 2]
               0x0001
             Attribute: Unknown (0x8001) [len 2]
               0x0001
< ACL Data TX flags 0x00 dlen 24 [hci0] 31.099275
       Channel: 67 len 20 [PSM 1 mode 0] {chan 0}
       SDP: Service Search Attribute Request (0x06) tid 7 len 15
         Search pattern: [len 5]
           Sequence (6) with 3 bytes [8 extra bits] len 5
             UUID (3) with 2 bytes [0 extra bits] len 3
               Handsfree (0x111e)
         Max record count: 65535
         Attribute list: [len 7]
           Sequence (6) with 5 bytes [8 extra bits] len 7
             Unsigned Integer (1) with 4 bytes [0 extra bits] len 5
               0x0000ffff
         Continuation state: 0
 > HCI Event (0x13) plen 5 [hci0] 31.101722
         Num handles: 1
         Handle: 256
         Count: 1
 > ACL Data RX flags 0x02 dlen 67 [hci0] 31.102965
       Channel: 64 len 63 [PSM 1 mode 0] {chan 0}
       SDP: Service Search Attribute Response (0x07) tid 7 len 58
         Attribute bytes: 53
         Continuation state: 2
         00 35 .5
< ACL Data TX flags 0x00 dlen 26 [hci0] 31.103181
       Channel: 67 len 22 [PSM 1 mode 0] {chan 0}
       SDP: Service Search Attribute Request (0x06) tid 8 len 17
         Search pattern: [len 5]
           Sequence (6) with 3 bytes [8 extra bits] len 5
             UUID (3) with 2 bytes [0 extra bits] len 3
               Handsfree (0x111e)
         Max record count: 65535
         Attribute list: [len 7]
           Sequence (6) with 5 bytes [8 extra bits] len 7
             Unsigned Integer (1) with 4 bytes [0 extra bits] len 5
               0x0000ffff
         Continuation state: 2
         00 35 .5
 > HCI Event (0x13) plen 5 [hci0] 31.106718
         Num handles: 1
         Handle: 256
         Count: 1
 > ACL Data RX flags 0x02 dlen 44 [hci0] 31.107962
       Channel: 64 len 40 [PSM 1 mode 0] {chan 0}
       SDP: Service Search Attribute Response (0x07) tid 8 len 35
         Attribute bytes: 32
         Continuation state: 0
         Combined attribute bytes: 85
           Attribute list: [len 80] {position 0}
             Attribute: Service Record Handle (0x0000) [len 2]
               0x00010002
             Attribute: Service Class ID List (0x0001) [len 2]
               UUID (3) with 2 bytes [0 extra bits] len 3
                 Handsfree (0x111e)
               UUID (3) with 2 bytes [0 extra bits] len 3
                 Generic Audio (0x1203)
             Attribute: Protocol Descriptor List (0x0004) [len 2]
               Sequence (6) with 3 bytes [8 extra bits] len 5
                 UUID (3) with 2 bytes [0 extra bits] len 3
                   L2CAP (0x0100)
               Sequence (6) with 5 bytes [8 extra bits] len 7
                 UUID (3) with 2 bytes [0 extra bits] len 3
                   RFCOMM (0x0003)
                 Unsigned Integer (1) with 1 byte [0 extra bits] len 2
                   0x02
             Attribute: Browse Group List (0x0005) [len 2]
               UUID (3) with 2 bytes [0 extra bits] len 3
                 Public Browse Root (0x1002)
             Attribute: Bluetooth Profile Descriptor List (0x0009) [len 2]
               Sequence (6) with 6 bytes [8 extra bits] len 8
                 UUID (3) with 2 bytes [0 extra bits] len 3
                   Handsfree (0x111e)
                 Unsigned Integer (1) with 2 bytes [0 extra bits] len 3
                   0x0105
             Attribute: Unknown (0x0100) [len 2]
               HFP service [len 12]
             Attribute: Unknown (0x0311) [len 2]
               0x001b
< ACL Data TX flags 0x00 dlen 12 [hci0] 31.108484
       L2CAP: Connection Request (0x02) ident 4 len 4
         PSM: 3 (0x0003)
         Source CID: 65
 > HCI Event (0x13) plen 5 [hci0] 31.111705
         Num handles: 1
         Handle: 256
         Count: 1
 > ACL Data RX flags 0x02 dlen 16 [hci0] 31.112953
       L2CAP: Connection Response (0x03) ident 4 len 8
         Destination CID: 68
         Source CID: 65
         Result: Connection successful (0x0000)
         Status: No further information available (0x0000)
< ACL Data TX flags 0x00 dlen 16 [hci0] 31.112979
       L2CAP: Configure Request (0x04) ident 5 len 8
         Destination CID: 68
         Flags: 0x0000
         Option: Maximum Transmission Unit (0x01)
           MTU: 1013
 > ACL Data RX flags 0x02 dlen 16 [hci0] 31.116703
       L2CAP: Configure Request (0x04) ident 3 len 8
         Destination CID: 65
         Flags: 0x0000
         Option: Maximum Transmission Unit (0x01)
           MTU: 1024
 > HCI Event (0x13) plen 5 [hci0] 31.116714
         Num handles: 1
         Handle: 256
         Count: 1
< ACL Data TX flags 0x00 dlen 18 [hci0] 31.116742
       L2CAP: Configure Response (0x05) ident 3 len 10
         Source CID: 68
         Flags: 0x0000
         Result: Success (0x0000)
         Option: Maximum Transmission Unit (0x01)
           MTU: 1024
 > ACL Data RX flags 0x02 dlen 14 [hci0] 31.117950
       L2CAP: Configure Response (0x05) ident 5 len 6
         Source CID: 65
         Flags: 0x0000
         Result: Success (0x0000)
< ACL Data TX flags 0x00 dlen 8 [hci0] 31.118046
       Channel: 68 len 4 [PSM 3 mode 0] {chan 1}
         03 3f 01 1c .?..
 > HCI Event (0x13) plen 5 [hci0] 31.120702
         Num handles: 1
         Handle: 256
         Count: 1
 > HCI Event (0x13) plen 5 [hci0] 31.121697
         Num handles: 1
         Handle: 256
         Count: 1
 > ACL Data RX flags 0x02 dlen 8 [hci0] 31.122697
       Channel: 65 len 4 [PSM 3 mode 0] {chan 1}
         03 73 01 d7 .s..
< ACL Data TX flags 0x00 dlen 18 [hci0] 31.122799
       Channel: 68 len 14 [PSM 3 mode 0] {chan 1}
         03 ef 15 83 11 04 f0 07 00 f0 03 00 07 70 .............p
 > HCI Event (0x13) plen 5 [hci0] 31.126699
         Num handles: 1
         Handle: 256
         Count: 1
 > ACL Data RX flags 0x02 dlen 18 [hci0] 31.127694
       Channel: 65 len 14 [PSM 3 mode 0] {chan 1}
         01 ef 15 81 11 04 e0 07 00 ff 00 00 07 aa ..............
< ACL Data TX flags 0x00 dlen 8 [hci0] 31.127795
       Channel: 68 len 4 [PSM 3 mode 0] {chan 1}
         13 3f 01 96 .?..
 > HCI Event (0x13) plen 5 [hci0] 31.131699
         Num handles: 1
         Handle: 256
         Count: 1
 > ACL Data RX flags 0x02 dlen 8 [hci0] 31.132691
       Channel: 65 len 4 [PSM 3 mode 0] {chan 1}
         13 73 01 5d .s.]
< ACL Data TX flags 0x00 dlen 12 [hci0] 31.132733
       Channel: 68 len 8 [PSM 3 mode 0] {chan 1}
         03 ef 09 e3 05 13 8d 70 .......p
 > ACL Data RX flags 0x02 dlen 12 [hci0] 31.134208
       L2CAP: Connection Request (0x02) ident 4 len 4
         PSM: 1 (0x0001)
         Source CID: 69
< ACL Data TX flags 0x00 dlen 16 [hci0] 31.134238
       L2CAP: Connection Response (0x03) ident 4 len 8
         Destination CID: 66
         Source CID: 69
         Result: Connection successful (0x0000)
         Status: No further information available (0x0000)
< ACL Data TX flags 0x00 dlen 12 [hci0] 31.134242
       L2CAP: Configure Request (0x04) ident 6 len 4
         Destination CID: 69
         Flags: 0x0000
 > HCI Event (0x13) plen 5 [hci0] 31.136698
         Num handles: 1
         Handle: 256
         Count: 1
 > ACL Data RX flags 0x02 dlen 12 [hci0] 31.137952
       Channel: 65 len 8 [PSM 3 mode 0] {chan 1}
         01 ef 09 e1 05 13 8d aa ........
 > HCI Event (0x13) plen 5 [hci0] 31.138724
         Num handles: 1
         Handle: 256
         Count: 1
 > ACL Data RX flags 0x02 dlen 12 [hci0] 31.139098
       Channel: 65 len 8 [PSM 3 mode 0] {chan 1}
         01 ef 09 e3 05 13 8d aa ........
< ACL Data TX flags 0x00 dlen 12 [hci0] 31.139163
       Channel: 68 len 8 [PSM 3 mode 0] {chan 1}
         03 ef 09 e1 05 13 8d 70 .......p
< ACL Data TX flags 0x00 dlen 9 [hci0] 31.139170
       Channel: 68 len 5 [PSM 3 mode 0] {chan 1}
         13 ff 01 21 79 ...!y
 > HCI Event (0x13) plen 5 [hci0] 31.139726
         Num handles: 1
         Handle: 256
         Count: 1
 > ACL Data RX flags 0x02 dlen 16 [hci0] 31.140473
       L2CAP: Configure Request (0x04) ident 5 len 8
         Destination CID: 66
         Flags: 0x0000
         Option: Maximum Transmission Unit (0x01)
           MTU: 64
< ACL Data TX flags 0x00 dlen 18 [hci0] 31.140505
       L2CAP: Configure Response (0x05) ident 5 len 10
         Source CID: 69
         Flags: 0x0000
         Result: Success (0x0000)
         Option: Maximum Transmission Unit (0x01)
           MTU: 64
 > ACL Data RX flags 0x02 dlen 14 [hci0] 31.141754
       L2CAP: Configure Response (0x05) ident 6 len 6
         Source CID: 66
         Flags: 0x0000
         Result: Success (0x0000)
 > HCI Event (0x13) plen 5 [hci0] 31.143762
         Num handles: 1
         Handle: 256
         Count: 1
 > ACL Data RX flags 0x02 dlen 20 [hci0] 31.144187
       Channel: 65 len 16 [PSM 3 mode 0] {chan 1}
         11 ff 17 09 41 54 2b 42 52 53 46 3d 32 37 0d a3 ....AT+BRSF=27..
< ACL Data TX flags 0x00 dlen 22 [hci0] 31.144324
       Channel: 68 len 18 [PSM 3 mode 0] {chan 1}
         13 ef 1d 0d 0a 2b 42 52 53 46 3a 20 33 35 32 0d  .....+BRSF: 352.
         0a 65 .e
< ACL Data TX flags 0x00 dlen 14 [hci0] 31.144332
       Channel: 68 len 10 [PSM 3 mode 0] {chan 1}
         13 ef 0d 0d 0a 4f 4b 0d 0a 65 .....OK..e
 > HCI Event (0x13) plen 5 [hci0] 31.144605
         Num handles: 1
         Handle: 256
         Count: 1
 > HCI Event (0x13) plen 5 [hci0] 31.145757
         Num handles: 1
         Handle: 256
         Count: 1
 > ACL Data RX flags 0x02 dlen 28 [hci0] 31.146503
       Channel: 66 len 24 [PSM 1 mode 0] {chan 2}
       SDP: Service Search Attribute Request (0x06) tid 0 len 19
         Search pattern: [len 5]
           Sequence (6) with 3 bytes [8 extra bits] len 5
             UUID (3) with 2 bytes [0 extra bits] len 3
               Handsfree Audio Gateway (0x111f)
         Max record count: 48
         Attribute list: [len 11]
           Sequence (6) with 9 bytes [8 extra bits] len 11
             Unsigned Integer (1) with 2 bytes [0 extra bits] len 3
               0x0001
             Unsigned Integer (1) with 2 bytes [0 extra bits] len 3
               0x0009
             Unsigned Integer (1) with 2 bytes [0 extra bits] len 3
               0x0311
         Continuation state: 0
< ACL Data TX flags 0x00 dlen 46 [hci0] 31.146720
       Channel: 69 len 42 [PSM 1 mode 0] {chan 2}
       SDP: Service Search Attribute Response (0x07) tid 0 len 37
         Attribute bytes: 34
           Attribute list: [len 30] {position 0}
             Attribute: Service Class ID List (0x0001) [len 2]
               UUID (3) with 2 bytes [0 extra bits] len 3
                 Handsfree Audio Gateway (0x111f)
               UUID (3) with 2 bytes [0 extra bits] len 3
                 Generic Audio (0x1203)
             Attribute: Bluetooth Profile Descriptor List (0x0009) [len 2]
               Sequence (6) with 6 bytes [8 extra bits] len 8
                 UUID (3) with 2 bytes [0 extra bits] len 3
                   Handsfree (0x111e)
                 Unsigned Integer (1) with 2 bytes [0 extra bits] len 3
                   0x0105
             Attribute: Unknown (0x0311) [len 2]
               0x0000
         Continuation state: 0
 > HCI Event (0x13) plen 5 [hci0] 31.148755
         Num handles: 1
         Handle: 256
         Count: 1
 > HCI Event (0x13) plen 5 [hci0] 31.149755
         Num handles: 1
         Handle: 256
         Count: 1
 > ACL Data RX flags 0x02 dlen 19 [hci0] 31.150250
       Channel: 65 len 15 [PSM 3 mode 0] {chan 1}
         11 ff 15 02 41 54 2b 43 49 4e 44 3d 3f 0d a3 ....AT+CIND=?..
< ACL Data TX flags 0x00 dlen 141 [hci0] 31.150438
       Channel: 68 len 137 [PSM 3 mode 0] {chan 1}
         13 ef 08 01 0d 0a 2b 43 49 4e 44 3a 20 28 22 62 ......+CIND: ("b
         61 74 74 63 68 67 22 2c 28 30 2d 35 29 29 2c 28 attchg",(0-5)),(
         22 73 69 67 6e 61 6c 22 2c 28 30 2d 35 29 29 2c "signal",(0-5)),
         28 22 73 65 72 76 69 63 65 22 2c 28 30 2c 31 29 ("service",(0,1)
         29 2c 28 22 63 61 6c 6c 22 2c 28 30 2c 31 29 29 ),("call",(0,1))
         2c 28 22 63 61 6c 6c 73 65 74 75 70 22 2c 28 30 ,("callsetup",(0
         2d 33 29 29 2c 28 22 63 61 6c 6c 68 65 6c 64 22 -3)),("callheld"
         2c 28 30 2d 32 29 29 2c 28 22 72 6f 61 6d 22 2c ,(0-2)),("roam",
         28 30 2c 31 29 29 0d 0a 65 (0,1))..e
< ACL Data TX flags 0x00 dlen 14 [hci0] 31.150448
       Channel: 68 len 10 [PSM 3 mode 0] {chan 1}
         13 ef 0d 0d 0a 4f 4b 0d 0a 65 .....OK..e
 > HCI Event (0x13) plen 5 [hci0] 31.150729
         Num handles: 1
         Handle: 256
         Count: 1
 > ACL Data RX flags 0x02 dlen 12 [hci0] 31.151699
       L2CAP: Disconnection Request (0x06) ident 6 len 4
         Destination CID: 66
         Source CID: 69
< ACL Data TX flags 0x00 dlen 12 [hci0] 31.151732
       L2CAP: Disconnection Response (0x07) ident 6 len 4
         Destination CID: 66
         Source CID: 69
 > HCI Event (0x13) plen 5 [hci0] 31.155700
         Num handles: 1
         Handle: 256
         Count: 1
 > HCI Event (0x13) plen 5 [hci0] 31.156717
         Num handles: 1
         Handle: 256
         Count: 1
 > ACL Data RX flags 0x02 dlen 18 [hci0] 31.157715
       Channel: 65 len 14 [PSM 3 mode 0] {chan 1}
         11 ff 13 02 41 54 2b 43 49 4e 44 3f 0d a3 ....AT+CIND?..
< ACL Data TX flags 0x00 dlen 32 [hci0] 31.157811
       Channel: 68 len 28 [PSM 3 mode 0] {chan 1}
         13 ef 31 0d 0a 2b 43 49 4e 44 3a 20 35 2c 35 2c  ..1..+CIND: 5,5,
         31 2c 30 2c 30 2c 30 2c 30 0d 0a 65 1,0,0,0,0..e
< ACL Data TX flags 0x00 dlen 14 [hci0] 31.157820
       Channel: 68 len 10 [PSM 3 mode 0] {chan 1}
         13 ef 0d 0d 0a 4f 4b 0d 0a 65 .....OK..e
 > HCI Event (0x13) plen 5 [hci0] 31.158716
         Num handles: 1
         Handle: 256
         Count: 1
 > HCI Event (0x13) plen 5 [hci0] 31.162700
         Num handles: 1
         Handle: 256
         Count: 1
 > HCI Event (0x13) plen 5 [hci0] 31.166681
         Num handles: 1
         Handle: 256
         Count: 1
 > ACL Data RX flags 0x02 dlen 25 [hci0] 31.167709
       Channel: 65 len 21 [PSM 3 mode 0] {chan 1}
         11 ff 21 02 41 54 2b 43 4d 45 52 3d 33 2c 30 2c ..!.AT+CMER=3,0,
         30 2c 31 0d a3 0,1..
< ACL Data TX flags 0x00 dlen 14 [hci0] 31.167854
       Channel: 68 len 10 [PSM 3 mode 0] {chan 1}
         13 ef 0d 0d 0a 4f 4b 0d 0a 65 .....OK..e
 > HCI Event (0x13) plen 5 [hci0] 31.171687
         Num handles: 1
         Handle: 256
         Count: 1
 > ACL Data RX flags 0x02 dlen 19 [hci0] 31.197692
       Channel: 65 len 15 [PSM 3 mode 0] {chan 1}
         11 ff 15 01 41 54 2b 43 43 57 41 3d 31 0d a3 ....AT+CCWA=1..
< ACL Data TX flags 0x00 dlen 14 [hci0] 31.197863
       Channel: 68 len 10 [PSM 3 mode 0] {chan 1}
         13 ef 0d 0d 0a 4f 4b 0d 0a 65 .....OK..e
 > HCI Event (0x13) plen 5 [hci0] 31.201671
         Num handles: 1
         Handle: 256
         Count: 1
 > ACL Data RX flags 0x02 dlen 31 [hci0] 31.203939
       Channel: 65 len 27 [PSM 3 mode 0] {chan 1}
         11 ff 2d 01 41 54 2b 42 49 41 3d 30 2c 30 2c 31 ..-.AT+BIA=0,0,1
         2c 31 2c 31 2c 31 2c 30 2c 0d a3 ,1,1,1,0,..
< ACL Data TX flags 0x00 dlen 17 [hci0] 31.204263
       Channel: 68 len 13 [PSM 3 mode 0] {chan 1}
         13 ef 13 0d 0a 45 52 52 4f 52 0d 0a 65 .....ERROR..e
 > HCI Event (0x13) plen 5 [hci0] 31.208729
         Num handles: 1
         Handle: 256
         Count: 1
 > ACL Data RX flags 0x02 dlen 20 [hci0] 31.208907
       Channel: 65 len 16 [PSM 3 mode 0] {chan 1}
         11 ff 17 01 41 54 2b 43 42 43 3d 31 30 30 0d a3 ....AT+CBC=100..
< ACL Data TX flags 0x00 dlen 17 [hci0] 31.209194
       Channel: 68 len 13 [PSM 3 mode 0] {chan 1}
         13 ef 13 0d 0a 45 52 52 4f 52 0d 0a 65 .....ERROR..e
 > HCI Event (0x13) plen 5 [hci0] 31.213727
         Num handles: 1
         Handle: 256
         Count: 1
 > ACL Data RX flags 0x02 dlen 19 [hci0] 31.213935
       Channel: 65 len 15 [PSM 3 mode 0] {chan 1}
         11 ff 15 01 41 54 2b 56 47 53 3d 31 35 0d a3 ....AT+VGS=15..
< ACL Data TX flags 0x00 dlen 14 [hci0] 31.214182
       Channel: 68 len 10 [PSM 3 mode 0] {chan 1}
         13 ef 0d 0d 0a 4f 4b 0d 0a 65 .....OK..e
 > HCI Event (0x13) plen 5 [hci0] 31.218699
         Num handles: 1
         Handle: 256
         Count: 1
 > ACL Data RX flags 0x02 dlen 21 [hci0] 31.218903
       Channel: 65 len 17 [PSM 3 mode 0] {chan 1}
         11 ff 19 01 41 54 2b 43 4f 50 53 3d 33 2c 30 0d ....AT+COPS=3,0.
         a3 .
< ACL Data TX flags 0x00 dlen 14 [hci0] 31.219151
       Channel: 68 len 10 [PSM 3 mode 0] {chan 1}
         13 ef 0d 0d 0a 4f 4b 0d 0a 65 .....OK..e
 > HCI Event (0x13) plen 5 [hci0] 31.223655
         Num handles: 1
         Handle: 256
         Count: 1
 > ACL Data RX flags 0x02 dlen 19 [hci0] 31.223901
       Channel: 65 len 15 [PSM 3 mode 0] {chan 1}
         11 ff 15 01 41 54 2b 43 4d 45 45 3d 31 0d a3 ....AT+CMEE=1..
< ACL Data TX flags 0x00 dlen 14 [hci0] 31.224044
       Channel: 68 len 10 [PSM 3 mode 0] {chan 1}
         13 ef 0d 0d 0a 4f 4b 0d 0a 65 .....OK..e
 > HCI Event (0x13) plen 5 [hci0] 31.229657
         Num handles: 1
         Handle: 256
         Count: 1
< ACL Data TX flags 0x00 dlen 12 [hci0] 32.913824
       L2CAP: Disconnection Request (0x06) ident 7 len 4
         Destination CID: 67
         Source CID: 64
< ACL Data TX flags 0x00 dlen 12 [hci0] 32.913967
       L2CAP: Connection Request (0x02) ident 8 len 4
         PSM: 25 (0x0019)
         Source CID: 66
 > HCI Event (0x13) plen 5 [hci0] 32.917809
         Num handles: 1
         Handle: 256
         Count: 1
 > ACL Data RX flags 0x02 dlen 12 [hci0] 32.918175
       L2CAP: Disconnection Response (0x07) ident 7 len 4
         Destination CID: 67
         Source CID: 64
 > HCI Event (0x13) plen 5 [hci0] 32.918799
         Num handles: 1
         Handle: 256
         Count: 1
 > ACL Data RX flags 0x02 dlen 16 [hci0] 32.919548
       L2CAP: Connection Response (0x03) ident 8 len 8
         Destination CID: 70
         Source CID: 66
         Result: Connection successful (0x0000)
         Status: No further information available (0x0000)
< ACL Data TX flags 0x00 dlen 12 [hci0] 32.919590
       L2CAP: Configure Request (0x04) ident 9 len 4
         Destination CID: 70
         Flags: 0x0000
 > ACL Data RX flags 0x02 dlen 16 [hci0] 32.920800
       L2CAP: Configure Request (0x04) ident 7 len 8
         Destination CID: 66
         Flags: 0x0000
         Option: Maximum Transmission Unit (0x01)
           MTU: 672
< ACL Data TX flags 0x00 dlen 18 [hci0] 32.920846
       L2CAP: Configure Response (0x05) ident 7 len 10
         Source CID: 70
         Flags: 0x0000
         Result: Success (0x0000)
         Option: Maximum Transmission Unit (0x01)
           MTU: 672
 > HCI Event (0x13) plen 5 [hci0] 32.923795
         Num handles: 1
         Handle: 256
         Count: 1
 > ACL Data RX flags 0x02 dlen 14 [hci0] 32.924545
       L2CAP: Configure Response (0x05) ident 9 len 6
         Source CID: 66
         Flags: 0x0000
         Result: Success (0x0000)
< ACL Data TX flags 0x00 dlen 6 [hci0] 32.924675
       Channel: 70 len 2 [PSM 25 mode 0] {chan 2}
         00 01 ..
 > HCI Event (0x13) plen 5 [hci0] 32.924798
         Num handles: 1
         Handle: 256
         Count: 1
 > HCI Event (0x13) plen 5 [hci0] 32.928796
         Num handles: 1
         Handle: 256
         Count: 1
 > ACL Data RX flags 0x02 dlen 8 [hci0] 32.929291
       Channel: 66 len 4 [PSM 25 mode 0] {chan 2}
         02 01 04 08 ....
< ACL Data TX flags 0x00 dlen 7 [hci0] 32.929397
       Channel: 70 len 3 [PSM 25 mode 0] {chan 2}
         10 02 04 ...
 > HCI Event (0x13) plen 5 [hci0] 32.933791
         Num handles: 1
         Handle: 256
         Count: 1
 > ACL Data RX flags 0x02 dlen 16 [hci0] 32.934578
       Channel: 66 len 12 [PSM 25 mode 0] {chan 2}
         12 02 01 00 07 06 00 00 ff ff 02 59 ...........Y
< ACL Data TX flags 0x00 dlen 18 [hci0] 32.934704
       Channel: 70 len 14 [PSM 25 mode 0] {chan 2}
         20 03 04 04 01 00 07 06 00 00 21 15 02 35 .........!..5
 > HCI Event (0x13) plen 5 [hci0] 32.938861
         Num handles: 1
         Handle: 256
         Count: 1
 > ACL Data RX flags 0x02 dlen 6 [hci0] 32.939354
       Channel: 66 len 2 [PSM 25 mode 0] {chan 2}
         22 03 ".
< ACL Data TX flags 0x00 dlen 7 [hci0] 32.939468
       Channel: 70 len 3 [PSM 25 mode 0] {chan 2}
         30 06 04 0..
 > HCI Event (0x13) plen 5 [hci0] 32.943806
         Num handles: 1
         Handle: 256
         Count: 1
 > ACL Data RX flags 0x02 dlen 6 [hci0] 32.944301
       Channel: 66 len 2 [PSM 25 mode 0] {chan 2}
         32 06 2.
< ACL Data TX flags 0x00 dlen 12 [hci0] 32.944424
       L2CAP: Connection Request (0x02) ident 10 len 4
         PSM: 25 (0x0019)
         Source CID: 64
 > HCI Event (0x13) plen 5 [hci0] 32.948804
         Num handles: 1
         Handle: 256
         Count: 1
 > ACL Data RX flags 0x02 dlen 16 [hci0] 32.949551
       L2CAP: Connection Response (0x03) ident 10 len 8
         Destination CID: 71
         Source CID: 64
         Result: Connection successful (0x0000)
         Status: No further information available (0x0000)
< ACL Data TX flags 0x00 dlen 12 [hci0] 32.949582
       L2CAP: Configure Request (0x04) ident 11 len 4
         Destination CID: 71
         Flags: 0x0000
 > ACL Data RX flags 0x02 dlen 20 [hci0] 32.950571
       L2CAP: Configure Request (0x04) ident 8 len 12
         Destination CID: 64
         Flags: 0x0000
         Option: Maximum Transmission Unit (0x01)
           MTU: 1008
         Option: Flush Timeout (0x02)
           Flush timeout: 200
< ACL Data TX flags 0x00 dlen 18 [hci0] 32.950597
       L2CAP: Configure Response (0x05) ident 8 len 10
         Source CID: 71
         Flags: 0x0000
         Result: Success (0x0000)
         Option: Maximum Transmission Unit (0x01)
           MTU: 1008
 > HCI Event (0x13) plen 5 [hci0] 32.953824
         Num handles: 1
         Handle: 256
         Count: 1
 > ACL Data RX flags 0x02 dlen 14 [hci0] 32.954566
       L2CAP: Configure Response (0x05) ident 11 len 6
         Source CID: 64
         Flags: 0x0000
         Result: Success (0x0000)
 > HCI Event (0x13) plen 5 [hci0] 32.954798
         Num handles: 1
         Handle: 256
         Count: 1
< HCI Command (0x01|0x0028) plen 17 [hci0] 32.964171
         Handle: 256
         Transmit bandwidth: 8000
         Receive bandwidth: 8000
         Max latency: 65535
         Setting: 0x0060
         Retransmission effort: Don't care (0xff)
         Packet type: 0x003f
 > HCI Event (0x0f) plen 4 [hci0] 32.965775
       Setup Synchronous Connection (0x01|0x0028) ncmd 1
         Status: Success (0x00)
 > HCI Event (0x1b) plen 3 [hci0] 32.969774
         Handle: 256
         Max slots: 1
 > HCI Event (0x2c) plen 17 [hci0] 32.986795
         Status: Success (0x00)
         Handle: 257
         Address: 78:F7:BE:08:5E:DF (OUI 78-F7-BE)
         Link type: eSCO (0x02)
         Transmission interval: 0x0c
         Retransmission window: 0x02
         RX packet length: 60
         TX packet length: 60
         Air mode: CVSD (0x02)
< ACL Data TX flags 0x00 dlen 19 [hci0] 32.987649
       Channel: 68 len 15 [PSM 3 mode 0] {chan 1}
         13 ef 17 0d 0a 2b 56 47 53 3d 31 35 0d 0a 65 .....+VGS=15..e
< ACL Data TX flags 0x00 dlen 19 [hci0] 32.987662
       Channel: 68 len 15 [PSM 3 mode 0] {chan 1}
         13 ef 17 0d 0a 2b 56 47 4d 3d 31 35 0d 0a 65 .....+VGM=15..e
 > HCI Event (0x1b) plen 3 [hci0] 32.991768
         Handle: 256
         Max slots: 5
 > HCI Event (0x13) plen 5 [hci0] 32.992762
         Num handles: 1
         Handle: 256
         Count: 1
< SCO Data TX flags 0x00 dlen 48 [hci0] 32.993934
 > HCI Event (0x13) plen 5 [hci0] 32.995762
         Num handles: 1
         Handle: 256
         Count: 1
 > HCI Event (0x14) plen 6 [hci0] 37.801432
         Status: Success (0x00)
         Handle: 256
         Mode: Sniff (0x02)
         Interval: 247.500 msec (0x018c)
< HCI Command (0x01|0x0006) plen 3 [hci0] 38.011637
         Handle: 257
         Reason: Remote User Terminated Connection (0x13)
 > HCI Event (0x0f) plen 4 [hci0] 38.012251
       Disconnect (0x01|0x0006) ncmd 1
         Status: Success (0x00)
 > HCI Event (0x05) plen 4 [hci0] 38.051233
         Status: Success (0x00)
         Handle: 257
         Reason: Connection Terminated By Local Host (0x16)
 > HCI Event (0x14) plen 6 [hci0] 38.057234
         Status: Success (0x00)
         Handle: 256
         Mode: Active (0x00)
         Interval: 0.000 msec (0x0000)
 > HCI Event (0x14) plen 6 [hci0] 42.803863
         Status: Success (0x00)
         Handle: 256
         Mode: Sniff (0x02)
         Interval: 500.000 msec (0x0320)
< HCI Command (0x02|0x0004) plen 2 [hci0] 42.927906
         Handle: 256
 > HCI Event (0x0f) plen 4 [hci0] 42.928836
       Exit Sniff Mode (0x02|0x0004) ncmd 1
         Status: Success (0x00)
 > HCI Event (0x14) plen 6 [hci0] 43.264703
         Status: Success (0x00)
         Handle: 256
         Mode: Active (0x00)
         Interval: 0.000 msec (0x0000)
< HCI Command (0x01|0x0028) plen 17 [hci0] 43.264779
         Handle: 256
         Transmit bandwidth: 8000
         Receive bandwidth: 8000
         Max latency: 65535
         Setting: 0x0060
         Retransmission effort: Don't care (0xff)
         Packet type: 0x003f
 > HCI Event (0x0f) plen 4 [hci0] 43.265703
       Setup Synchronous Connection (0x01|0x0028) ncmd 1
         Status: Success (0x00)
 > HCI Event (0x1b) plen 3 [hci0] 43.271679
         Handle: 256
         Max slots: 1
 > HCI Event (0x2c) plen 17 [hci0] 43.290665
         Status: Success (0x00)
         Handle: 257
         Address: 78:F7:BE:08:5E:DF (OUI 78-F7-BE)
         Link type: eSCO (0x02)
         Transmission interval: 0x0c
         Retransmission window: 0x02
         RX packet length: 60
         TX packet length: 60
         Air mode: CVSD (0x02)
< ACL Data TX flags 0x00 dlen 19 [hci0] 43.291490
       Channel: 68 len 15 [PSM 3 mode 0] {chan 1}
         13 ef 17 0d 0a 2b 56 47 53 3d 31 35 0d 0a 65 .....+VGS=15..e
< ACL Data TX flags 0x00 dlen 19 [hci0] 43.291512
       Channel: 68 len 15 [PSM 3 mode 0] {chan 1}
         13 ef 17 0d 0a 2b 56 47 4d 3d 31 35 0d 0a 65 .....+VGM=15..e
< SCO Data TX flags 0x00 dlen 48 [hci0] 43.295627
< SCO Data TX flags 0x00 dlen 48 [hci0] 43.295850
 > HCI Event (0x1b) plen 3 [hci0] 43.296621
         Handle: 256
         Max slots: 5
 > HCI Event (0x13) plen 5 [hci0] 43.297623
         Num handles: 1
         Handle: 256
         Count: 1
 > HCI Event (0x13) plen 5 [hci0] 43.298627
         Num handles: 1
         Handle: 256
         Count: 1
 > HCI Event (0x14) plen 6 [hci0] 47.786446
         Status: Success (0x00)
         Handle: 256
         Mode: Sniff (0x02)
         Interval: 247.500 msec (0x018c)
< HCI Command (0x01|0x0006) plen 3 [hci0] 49.907615
         Handle: 257
         Reason: Remote User Terminated Connection (0x13)
 > HCI Event (0x0f) plen 4 [hci0] 49.908340
       Disconnect (0x01|0x0006) ncmd 1
         Status: Success (0x00)
 > HCI Event (0x05) plen 4 [hci0] 50.015272
         Status: Success (0x00)
         Handle: 257
         Reason: Connection Terminated By Local Host (0x16)
 > HCI Event (0x14) plen 6 [hci0] 50.021320
         Status: Success (0x00)
         Handle: 256
         Mode: Active (0x00)
         Interval: 0.000 msec (0x0000)
 > HCI Event (0x14) plen 6 [hci0] 54.795921
         Status: Success (0x00)
         Handle: 256
         Mode: Sniff (0x02)
         Interval: 500.000 msec (0x0320)
>
> Regards
>
> Marcel
>
>
>


--------------020607070303000304060102
Content-Type: text/x-log;
 name="lenovo-m4400s-btmon.log"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="lenovo-m4400s-btmon.log"

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
AAADAAAAAADhx8dOWVuRFAYAAAECIAM=
--------------020607070303000304060102--
