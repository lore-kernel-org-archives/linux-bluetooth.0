Return-Path: <cyrus@holtmann.org>
From: "Mellberg, Bo" <Bo.Mellberg@physio-control.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Responding to DID inquiries
Date: Tue, 8 Sep 2015 06:31:26 +0000
Message-ID: <BY2PR08MB1669FD4CC0ED6960011BA2F4D2530@BY2PR08MB1669.namprd08.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

My embedded system is required to respond to "Device Identification Profile" requests, sometimes called DID, DI or DIP. The DID should hold the following attributes:

SpecificationID
VendorID
ProductID
Version
PrimaryRecord
VendorIDSource
ServiceDescription

My question: how do I "activate" this profile? For example, to let the sdp-daemon know that I offer OBEX-FTP, I use:

~ #sdptool add FTP
OBEX File Transfer service registered
~ # sdptool browse local
Browsing FF:FF:FF:00:00:00 ...
Service Name: OBEX File Transfer
Service RecHandle: 0x10000
Service Class ID List:
  "OBEX File Transfer" (0x1106)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 10
  "OBEX" (0x0008)
Profile Descriptor List:
  "OBEX File Transfer" (0x1106)
    Version: 0x0100

Looking at the help for sdptool:

~ # sdptool --help
sdptool - SDP tool v2.25
Usage:
        sdptool [options] <command> [command parameters]
Options:
        -h              Display help
        -i              Specify source interface
Commands:
        search          Search for a service
        browse          Browse all available services
        records         Request all records
        add             Add local service
        del             Delete local service
        get             Get local service
        setattr         Set/Add attribute to a SDP record
        setseq          Set/Add attribute sequence to a SDP record

Services:
        DID SP DUN LAN FAX OPUSH FTP HS HF HFAG SAP NAP GN PANU HID CIP
        CTP A2SRC A2SNK AVRCT AVRTG SR1 SYNCML ACTIVESYNC HOTSYNC PALMOS
        NOKID PCSUITE NGAGE APPLE ISYNC

There is clearly a DID service available.

But adding DID:

~ #sdptool add DID
~ #

Does nothing. No new service is registered. What do I need to do to be able to let my clients request the DID service record, and to populate it with my desired attributes above?

Thanks,

/Bo


________________________________
________________________________
[CONFIDENTIALITY AND PRIVACY NOTICE]

Information transmitted by this email is proprietary to Physio-Control and is intended for use only by the individual or entity to which it is addressed, and may contain information that is private, privileged, confidential or exempt from disclosure under applicable law. If you are not the intended recipient or it appears that this mail has been forwarded to you without proper authority, you are notified that any use or dissemination of this information in any manner is strictly prohibited. In such cases, please delete this mail from your records.

To view this notice in other languages you can either select the following link or manually copy and paste the link into the address bar of a web browser: http://www.physio-control.com/emaildisclaimer/

________________________________
________________________________
