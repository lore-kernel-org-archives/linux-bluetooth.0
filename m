Return-Path: <haagch@frickel.club>
Subject: Re: [PATCH] Bluetooth: btusb: add support for 0bb4:0306
To: Marcel Holtmann <marcel@holtmann.org>
References: <20170210003142.3871-1-haagch@frickel.club>
 <04A5C1B8-16D8-4146-8A3E-7DCBA0FDB7CB@holtmann.org>
 <0dd3dccb-e0b2-fcd1-5271-5388ab847bd3@frickel.club>
 <AF9A409D-9EAD-4037-984E-81BBDA7CB5E5@holtmann.org>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>,
 "Gustavo F. Padovan" <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>
From: Christoph Haag <haagch@frickel.club>
Message-ID: <67bd4ead-0957-abf8-6228-52e7dedcf8a8@frickel.club>
Date: Fri, 10 Feb 2017 13:54:47 +0100
MIME-Version: 1.0
In-Reply-To: <AF9A409D-9EAD-4037-984E-81BBDA7CB5E5@holtmann.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel
> Hi Christoph,
>
>> I've sent a new version but it seems my message was not included, so here it is.
>>
>> Thanks for the comment.
>> It did not work right with the first patch anyway, was probably missing some stuff.
>>
>> With this new patch I can actually pair and use gatttool.
>> lsusb says BCM920703 now.
>>
>> dmesg says
>>
>> Bluetooth: hci0: BCM: chip id 102
>> Bluetooth: hci0: c-l
>> Bluetooth: hci0: BCM (001.001.005) build 0000
>> Bluetooth: hci0: BCM (001.001.005) build 0481
>> Bluetooth: hci0: BCM20703A1 Generic USB 20Mhz fcbga_BU
>>
>> Would this be useful for the commit message?
> yes, please include it in the commit message.
>
> Just for my personal curiosity, can you run btmon and capture the HCI Version Information, HCI Supported Features, HCI Supported Commands and HCI LE Supported Features commands. It sounds like this is a Bluetooth 4.1 capable chip.
>
> Regards
>
> Marcel

Yes, it supports Bluetooth LE.
The Basestations that come with the Vive *only* support Bluetooth LE. I need the bluetooth adapter in the Vive because the USB bluetooth adapters I have here are all too old and cheap to support LE.

I don't know how to do this best with just btmon. Does hciconfig output suffice?

$ hciconfig hci0 version
hci0:   Type: Primary  Bus: USB
        BD Address: AC:37:43:E1:10:CE  ACL MTU: 1021:8  SCO MTU: 64:1
        HCI Version: 4.1 (0x7)  Revision: 0x11e1
        LMP Version: 4.1 (0x7)  Subversion: 0x2105
        Manufacturer: Broadcom Corporation (15)
$ hciconfig hci0 features
hci0:   Type: Primary  Bus: USB
        BD Address: AC:37:43:E1:10:CE  ACL MTU: 1021:8  SCO MTU: 64:1
        Features page 0: 0xbf 0xfe 0xcf 0xfe 0xdb 0xff 0x7b 0x87
                <3-slot packets> <5-slot packets> <encryption> <slot offset>
                <timing accuracy> <role switch> <sniff mode> <RSSI>
                <channel quality> <SCO link> <HV2 packets> <HV3 packets>
                <u-law log> <A-law log> <CVSD> <paging scheme> <power control>
                <transparent SCO> <broadcast encrypt> <EDR ACL 2 Mbps>
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
        Features page 1: 0x0b 0x00 0x00 0x00 0x00 0x00 0x00 0x00
        Features page 2: 0x3f 0x0b 0x00 0x00 0x00 0x00 0x00 0x00
$ hciconfig hci0 commands
hci0:   Type: Primary  Bus: USB
        BD Address: AC:37:43:E1:10:CE  ACL MTU: 1021:8  SCO MTU: 64:1
        Commands: Octet 0  = 0xff (Bit 0 1 2 3 4 5 6 7)
                  Octet 1  = 0xff (Bit 0 1 2 3 4 5 6 7)
                  Octet 2  = 0xff (Bit 0 1 2 3 4 5 6 7)
                  Octet 3  = 0x03 (Bit 0 1)
                  Octet 4  = 0xcc (Bit 2 3 6 7)
                  Octet 5  = 0xff (Bit 0 1 2 3 4 5 6 7)
                  Octet 6  = 0xef (Bit 0 1 2 3 5 6 7)
                  Octet 7  = 0xff (Bit 0 1 2 3 4 5 6 7)
                  Octet 8  = 0xff (Bit 0 1 2 3 4 5 6 7)
                  Octet 9  = 0xff (Bit 0 1 2 3 4 5 6 7)
                  Octet 10 = 0xec (Bit 2 3 5 6 7)
                  Octet 11 = 0x1f (Bit 0 1 2 3 4)
                  Octet 12 = 0xf2 (Bit 1 4 5 6 7)
                  Octet 13 = 0x0f (Bit 0 1 2 3)
                  Octet 14 = 0xe8 (Bit 3 5 6 7)
                  Octet 15 = 0xfe (Bit 1 2 3 4 5 6 7)
                  Octet 16 = 0x3f (Bit 0 1 2 3 4 5)
                  Octet 17 = 0xf7 (Bit 0 1 2 4 5 6 7)
                  Octet 18 = 0x8f (Bit 0 1 2 3 7)
                  Octet 19 = 0xff (Bit 0 1 2 3 4 5 6 7)
                  Octet 20 = 0x1c (Bit 2 3 4)
                  Octet 22 = 0x04 (Bit 2)
                  Octet 24 = 0x61 (Bit 0 5 6)
                  Octet 25 = 0xf7 (Bit 0 1 2 4 5 6 7)
                  Octet 26 = 0xff (Bit 0 1 2 3 4 5 6 7)
                  Octet 27 = 0xff (Bit 0 1 2 3 4 5 6 7)
                  Octet 28 = 0x7f (Bit 0 1 2 3 4 5 6)
                  Octet 29 = 0xf8 (Bit 3 4 5 6 7)
                  Octet 30 = 0xff (Bit 0 1 2 3 4 5 6 7)
                  Octet 31 = 0xff (Bit 0 1 2 3 4 5 6 7)
                  Octet 32 = 0xff (Bit 0 1 2 3 4 5 6 7)
                  Octet 33 = 0x3f (Bit 0 1 2 3 4 5)
        'Inquiry' 'Inquiry Cancel' 'Periodic Inquiry Mode'
        'Exit Periodic Inquiry Mode' 'Create Connection' 'Disconnect'
        'Add SCO Connection' 'Cancel Create Connection'
        'Accept Connection Request' 'Reject Connection Request'
        'Link Key Request Reply' 'Link Key Request Negative Reply'
        'PIN Code Request Reply' 'PIN Code Request Negative Reply'
        'Change Connection Packet Type' 'Authentication Requested'
        'Set Connection Encryption' 'Change Connection Link Key'
        'Master Link Key' 'Remote Name Request' 'Cancel Remote Name Request'
        'Read Remote Supported Features' 'Read Remote Extended Features'
        'Read Remote Version Information' 'Read Clock Offset'
        'Read LMP Handle' 'Sniff Mode' 'Exit Sniff Mode' 'QoS Setup'
        'Role Discovery' 'Switch Role' 'Read Link Policy Settings'
        'Write Link Policy Settings' 'Read Default Link Policy Settings'
        'Write Default Link Policy Settings' 'Flow Specification'
        'Set Event Mask' 'Reset' 'Set Event Filter' 'Flush' 'Read PIN Type'
        'Write PIN Type' 'Read Stored Link Key' 'Write Stored Link Key'
        'Delete Stored Link Key' 'Write Local Name' 'Read Local Name'
        'Read Connection Accept Timeout' 'Write Connection Accept Timeout'
        'Read Page Timeout' 'Write Page Timeout' 'Read Scan Enable'
        'Write Scan Enable' 'Read Page Scan Activity'
        'Write Page Scan Activity' 'Read Inquiry Scan Activity'
        'Write Inquiry Scan Activity' 'Read Authentication Enable'
        'Write Authentication Enable' 'Read Encryption Mode'
        'Write Encryption Mode' 'Read Class Of Device' 'Write Class Of Device'
        'Read Voice Setting' 'Write Voice Setting'
        'Read Automatic Flush Timeout' 'Write Automatic Flush Timeout'
        'Read Num Broadcast Retransmissions'
        'Write Num Broadcast Retransmissions' 'Read Transmit Power Level'
        'Read Synchronous Flow Control Enable'
        'Set Host Controller To Host Flow Control' 'Host Buffer Size'
        'Host Number Of Completed Packets' 'Read Link Supervision Timeout'
        'Write Link Supervision Timeout' 'Read Number of Supported IAC'
        'Read Current IAC LAP' 'Write Current IAC LAP'
        'Set AFH Channel Classification' 'Read Inquiry Scan Type'
        'Write Inquiry Scan Type' 'Read Inquiry Mode' 'Write Inquiry Mode'
        'Read Page Scan Type' 'Write Page Scan Type'
        'Read AFH Channel Assessment Mode' 'Write AFH Channel Assessment Mode'
        'Read Local Version Information' 'Read Local Supported Features'
        'Read Local Extended Features' 'Read Buffer Size' 'Read BD ADDR'
        'Read Failed Contact Counter' 'Reset Failed Contact Counter'
        'Get Link Quality' 'Read RSSI' 'Read AFH Channel Map' 'Read BD Clock'
        'Read Loopback Mode' 'Write Loopback Mode'
        'Enable Device Under Test Mode' 'Setup Synchronous Connection'
        'Accept Synchronous Connection' 'Reject Synchronous Connection'
        'Read Extended Inquiry Response' 'Write Extended Inquiry Response'
        'Refresh Encryption Key' 'Sniff Subrating' 'Read Simple Pairing Mode'
        'Write Simple Pairing Mode' 'Read Local OOB Data'
        'Read Inquiry Response Transmit Power Level'
        'Write Inquiry Transmit Power Level'
        'Read Default Erroneous Data Reporting'
        'Write Default Erroneous Data Reporting' 'IO Capability Request Reply'
        'User Confirmation Request Reply'
        'User Confirmation Request Negative Reply'
        'User Passkey Request Reply' 'User Passkey Request Negative Reply'
        'Remote OOB Data Request Reply' 'Write Simple Pairing Debug Mode'
        'Enhanced Flush' 'Remote OOB Data Request Negative Reply'
        'Send Keypress Notification' 'IO Capability Request Negative Reply'
        'Read Encryption Key Size' 'Set Event Mask Page 2'
        'Read Enhanced Transmit Power Level' 'Read LE Host Support'
        'Write LE Host Support' 'LE Set Event Mask' 'LE Read Buffer Size'
        'LE Read Local Supported Features' 'LE Set Random Address'
        'LE Set Advertising Parameters' 'LE Read Advertising Channel TX Power'
        'LE Set Advertising Data' 'LE Set Scan Response Data'
        'LE Set Advertise Enable' 'LE Set Scan Parameters'
        'LE Set Scan Enable' 'LE Create Connection'
        'LE Create Connection Cancel' 'LE Read White List Size'
        'LE Clear White List' 'LE Add Device To White List'
        'LE Remove Device From White List' 'LE Connection Update'
        'LE Set Host Channel Classification' 'LE Read Channel Map'
        'LE Read Remote Used Features' 'LE Encrypt' 'LE Rand'
        'LE Start Encryption' 'LE Long Term Key Request Reply'
        'LE Long Term Key Request Negative Reply' 'LE Read Supported States'
        'LE Receiver Test' 'LE Transmitter Test' 'LE Test End'

Christoph
