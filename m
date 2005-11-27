Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Robert Siemer <Robert.Siemer@backsla.sh>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: Jumpy cursor with Wacom Graphire Bluetooth
Message-ID: <20051127234927.GI15156@polar.elf12.net>
References: <20051008132533.GA954@polar.elf12.net> <20051127174209.GB15156@polar.elf12.net> <1133115990.13629.1.camel@blade> <20051127184902.GD15156@polar.elf12.net> <1133119580.13629.13.camel@blade> <20051127213835.GF15156@polar.elf12.net> <1133128569.13629.28.camel@blade> <20051127230444.GG15156@polar.elf12.net> <1133133083.13629.43.camel@blade>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1133133083.13629.43.camel@blade>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 28 Nov 2005 00:49:27 +0100

> >  panorama:/etc/udev# sdptool browse --raw 00:13:C2:00:11:2C
> >  panorama:/etc/udev# 
> 
> the do "sdptool search --bdaddr 00:13:C2:00:11:2C --raw <hid|did>" and
> see what comes out.

Aha. Looks similar to "sdptool records --raw addr".


siemer@panorama:~$ sdptool search --bdaddr 00:13:C2:00:11:2C --raw did
Sequence
        Attribute 0x0000 - ServiceRecordHandle
                UINT32 0x00010001
        Attribute 0x0001 - ServiceClassIDList
                Sequence
                        UUID16 0x1200 - PnPInformation
        Attribute 0x0004 - ProtocolDescriptorList
                Sequence
                        Sequence
                                UUID16 0x0100 - L2CAP
                                UINT16 0x0001
                        Sequence
                                UUID16 0x0001 - SDP
        Attribute 0x0006 - LanguageBaseAttributeIDList
                Sequence
                        UINT16 0x656e
                        UINT16 0x006a
                        UINT16 0x0100
        Attribute 0x0009 - BluetoothProfileDescriptorList
                Sequence
                        Sequence
                                UUID16 0x1200 - PnPInformation
                                UINT16 0x0100
        Attribute 0x0101
                String WACOM Pen Tablet
        Attribute 0x0200
                UINT16 0x0100
        Attribute 0x0201
                UINT16 0x056a
        Attribute 0x0202
                UINT16 0x0081
        Attribute 0x0203
                UINT16 0x0100
        Attribute 0x0204
                Bool True
        Attribute 0x0205
                UINT16 0x0002
siemer@panorama:~$ 

siemer@panorama:~$ sdptool search --bdaddr 00:13:C2:00:11:2C --raw hid
Sequence
        Attribute 0x0000 - ServiceRecordHandle
                UINT32 0x00010000
        Attribute 0x0001 - ServiceClassIDList
                Sequence
                        UUID16 0x1124 - HumanInterfaceDeviceService
(HID)
        Attribute 0x0004 - ProtocolDescriptorList
                Sequence
                        Sequence
                                UUID16 0x0100 - L2CAP
                                UINT16 0x0011
                        Sequence
                                UUID16 0x0011 - HIDP
        Attribute 0x0006 - LanguageBaseAttributeIDList
                Sequence
                        UINT16 0x656e
                        UINT16 0x006a
                        UINT16 0x0100
        Attribute 0x0009 - BluetoothProfileDescriptorList
                Sequence
                        Sequence
                                UUID16 0x1124 -
HumanInterfaceDeviceService (HID)
                                UINT16 0x0100
        Attribute 0x000d - AdditionalProtocolDescriptorLists
                Sequence
                        Sequence
                                Sequence
                                        UUID16 0x0100 - L2CAP
                                        UINT16 0x0013
                                Sequence
                                        UUID16 0x0011 - HIDP
        Attribute 0x0100
                String Tablet
        Attribute 0x0101
                String WACOM Pen Tablet
        Attribute 0x0102
                String WACOM
        Attribute 0x0200
                UINT16 0x0100
        Attribute 0x0201
                UINT16 0x0100
        Attribute 0x0202
                UINT8 0x80
        Attribute 0x0203
                UINT8 0x21
        Attribute 0x0204
                Bool True
        Attribute 0x0205
                Bool True
        Attribute 0x0206
                Sequence
                        Sequence
                                UINT8 0x22
                                String 05 01 09 02 a1 01 85 02 09 01 a1
00 05 09 19 01 29 03 15 00 25 01 95 03 75 01 81 02 95 01 75 05 81 01 05
01 09 30 09 31 09 38 15 81 25 7f 75 08 95 03 81 06 c0 c0 05 0d 09 01 a1
01 85 03 a1 00 06 00 ff 09 01 15 00 26 ff 00 75 08 95 07 81 02 c0 09 02
85 03 95 01 b1 02 09 03 85 04 95 01 b1 02 09 04 85 05 95 01 b1 02 09 05
85 06 95 01 b1 02 09 06 85 07 95 01 b1 02 09 07 85 08 95 01 b1 02 09 08
85 09 95 01 b1 02 c0
        Attribute 0x0207
                Sequence
                        Sequence
                                UINT16 0x0409
                                UINT16 0x0100
        Attribute 0x0208
                Bool False
        Attribute 0x0209
                Bool True
        Attribute 0x020a
                Bool True
        Attribute 0x020b
                UINT16 0x0100
        Attribute 0x020c
                UINT16 0x1f40
        Attribute 0x020d
                Bool False
        Attribute 0x020e
                Bool True
siemer@panorama:~$ 



Bye,
	Robert


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
