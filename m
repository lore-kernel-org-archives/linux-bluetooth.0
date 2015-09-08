Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <ext.szymon.janc@tieto.com>
To: "Mellberg, Bo" <Bo.Mellberg@physio-control.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Responding to DID inquiries
Date: Tue, 08 Sep 2015 11:00:47 +0200
Message-ID: <1456747.pkxWh6ZToa@leonov>
In-Reply-To: <BY2PR08MB1669FD4CC0ED6960011BA2F4D2530@BY2PR08MB1669.namprd08.prod.outlook.com>
References: <BY2PR08MB1669FD4CC0ED6960011BA2F4D2530@BY2PR08MB1669.namprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tuesday 08 of September 2015 06:31:26 Mellberg, Bo wrote:
> My embedded system is required to respond to "Device Identification Profile"
> requests, sometimes called DID, DI or DIP. The DID should hold the
> following attributes:
> 
> SpecificationID
> VendorID
> ProductID
> Version
> PrimaryRecord
> VendorIDSource
> ServiceDescription
> 
> My question: how do I "activate" this profile? For example, to let the
> sdp-daemon know that I offer OBEX-FTP, I use:
> 
> ~ #sdptool add FTP
> OBEX File Transfer service registered
> ~ # sdptool browse local
> Browsing FF:FF:FF:00:00:00 ...
> Service Name: OBEX File Transfer
> Service RecHandle: 0x10000
> Service Class ID List:
>   "OBEX File Transfer" (0x1106)
> Protocol Descriptor List:
>   "L2CAP" (0x0100)
>   "RFCOMM" (0x0003)
>     Channel: 10
>   "OBEX" (0x0008)
> Profile Descriptor List:
>   "OBEX File Transfer" (0x1106)
>     Version: 0x0100
> 
> Looking at the help for sdptool:
> 
> ~ # sdptool --help
> sdptool - SDP tool v2.25

Why do you use such ancient version? I strongly suggest updating to something 
newer.

> Usage:
>         sdptool [options] <command> [command parameters]
> Options:
>         -h              Display help
>         -i              Specify source interface
> Commands:
>         search          Search for a service
>         browse          Browse all available services
>         records         Request all records
>         add             Add local service
>         del             Delete local service
>         get             Get local service
>         setattr         Set/Add attribute to a SDP record
>         setseq          Set/Add attribute sequence to a SDP record
> 
> Services:
>         DID SP DUN LAN FAX OPUSH FTP HS HF HFAG SAP NAP GN PANU HID CIP
>         CTP A2SRC A2SNK AVRCT AVRTG SR1 SYNCML ACTIVESYNC HOTSYNC PALMOS
>         NOKID PCSUITE NGAGE APPLE ISYNC
> 
> There is clearly a DID service available.
> 
> But adding DID:
> 
> ~ #sdptool add DID
> ~ #
> 
> Does nothing. No new service is registered. What do I need to do to be able
> to let my clients request the DID service record, and to populate it with
> my desired attributes above?

DID is handled by bluetoothd if enabled in config file. Check DeviceID in 
main.conf.

-- 
BR
Szymon Janc
