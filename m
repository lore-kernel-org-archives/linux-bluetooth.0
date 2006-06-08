Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <4487CE44.2050104@personnelware.com>
Date: Thu, 08 Jun 2006 02:14:12 -0500
From: Carl K <carl@personnelware.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] PM325 by LG cell phone
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

(re posted to the list from a new account - gmail was held up for some 
reason, so forgive me if a 2nd copy shows up.)

> > carl@asus17:~$ sdptool browse 08:00:37:03:EF:36
> > Browsing 08:00:37:03:EF:36 ...
> > Service Name: WBTEXT
> > Service RecHandle: 0x10000
> > Service Class ID List:
> >   "Error: This is UUID-128" (0xdb1d8f12-95f3-402c-9b97-bc504c9a55c4)
> > Protocol Descriptor List:
> >   "L2CAP" (0x0100)
> >   "RFCOMM" (0x0003)
> >     Channel: 1
> > Language Base Attr List:
> >   code_ISO639: 0x656e
> >   encoding:    0x6a
> >   base_offset: 0x100
> > Profile Descriptor List:
> >   "Error: This is UUID-128" (0x1cdb1d8f-1295-f340-2c9b-97bc504c9a55)
> >     Version: 0x0100
>
> The WBTEXT service is some LG specific one and I actually like to know
> what you can do with it, but this might be used by LG phones and
> software only. However you might try "sdptool records --raw <bdaddr>"
> and see if you find some more records.


I'm guessing nothing new, but I am not qualified, so here you go...

carl@asus17:~$ sdptool records --raw  08:00:37:03:EF:36
Sequence
        Attribute 0x0000 - ServiceRecordHandle
                UINT32 0x00010000
        Attribute 0x0001 - ServiceClassIDList
                Sequence
                        UUID128 db1d8f12-95f3-402c-9b97
-bc504c9a55c4
        Attribute 0x0004 - ProtocolDescriptorList
                Sequence
                        Sequence
                                UUID16 0x0100 - L2CAP
                        Sequence
                                UUID16 0x0003 - RFCOMM
                                UINT8 0x01
        Attribute 0x0005 - BrowseGroupList
                Sequence
                        UUID16 0x1002 - PublicBrowseGroup
        Attribute 0x0006 - LanguageBaseAttributeIDList
                Sequence
                        UINT16 0x656e
                        UINT16 0x006a
                        UINT16 0x0100
        Attribute 0x0009 - BluetoothProfileDescriptorList
                Sequence
                        Sequence
                                UUID128 1cdb1d8f-1295-f340-2c9b-97bc504c9a55
                                UINT16 0x0100
        Attribute 0x0100
                Data 57 42 54 45 58 54 00
        Attribute 0x8003
                UINT16 0x0001
Sequence
        Attribute 0x0000 - ServiceRecordHandle
                UINT32 0x00010001
        Attribute 0x0001 - ServiceClassIDList
                Sequence
                        UUID16 0x1112 - HeadsetAudioGateway
                        UUID16 0x1203 - GenericAudio
        Attribute 0x0004 - ProtocolDescriptorList
                Sequence
                        Sequence
                                UUID16 0x0100 - L2CAP
                        Sequence
                                UUID16 0x0003 - RFCOMM
                                UINT8 0x02
        Attribute 0x0005 - BrowseGroupList
                Sequence
                        UUID16 0x1002 - PublicBrowseGroup
        Attribute 0x0009 - BluetoothProfileDescriptorList
                Sequence
                        Sequence
                                UUID16 0x1108 - Headset
                                UINT16 0x0100
        Attribute 0x0100
                Data 4c 47 20 4c 58 33 32 35 20 48 65 61 64 73 65 74 20 
41 47 20 53 65 72 76 69 63 65 00
        Attribute 0x0302
                Bool True
Sequence
        Attribute 0x0000 - ServiceRecordHandle
                UINT32 0x00010002
        Attribute 0x0001 - ServiceClassIDList
                Sequence
                        UUID16 0x111f - HandsfreeAudioGateway
                        UUID16 0x1203 - GenericAudio
        Attribute 0x0004 - ProtocolDescriptorList
                Sequence
                        Sequence
                                UUID16 0x0100 - L2CAP
                        Sequence
                                UUID16 0x0003 - RFCOMM
                                UINT8 0x03
        Attribute 0x0005 - BrowseGroupList
                Sequence
                        UUID16 0x1002 - PublicBrowseGroup
        Attribute 0x0009 - BluetoothProfileDescriptorList
                Sequence
                        Sequence
                                UUID16 0x111e - Handsfree
                                UINT16 0x0100
        Attribute 0x0100
                Data 4c 47 20 4c 58 33 32 35 20 48 61 6e 64 73 2d 46 72 
65 65 20 41 47 20 53 65 72 76 69 63 65 00
        Attribute 0x0301
                UINT8 0x00
        Attribute 0x0311
                UINT16 0x0005
carl@asus17:~$


_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
