Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Andreas Gaufer <Andreas.Gaufer@blue-cell-networks.com>
To: Bluez Devel <bluez-devel@lists.sourceforge.net>
Message-Id: <20040818193013.1ef8a79a.Andreas.Gaufer@blue-cell-networks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] Sharp GX15 Info
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 18 Aug 2004 19:30:13 +0200

Hi,

I got a Sharp GX15 (Vodafone Live Edition). It does nothing that needs a
ACL without pairing (only remote name request is possible w/o pairing).

Here are some details for your list Marcel:

Inq:

 08:00:1F:B7:EF:7A       clock offset: 0x7553    class: 0x500204

Info:

        BD Address:  08:00:1F:B7:EF:7A
        LMP Version: 1.1 (0x1) LMP Subversion: 0x460
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xef 0xff 0x0b 0x00 0x00 0x00 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot
offset>                 <role switch> <hold mode> <sniff mode> <park
state> <RSSI>                 <channel quality> <SCO link> <HV2 packets>
<HV3 packets>                 <u-law log> <A-law log> <CVSD> <paging
scheme>                 <transparent SCO> 

SDP:

Browsing 08:00:1F:B7:EF:7A ...
Attribute Identifier : 0x0 - ServiceRecordHandle
  Integer : 0x10001
Attribute Identifier : 0x1 - ServiceClassIDList
  Data Sequence
    UUID16 : 0x1105 - OBEXObjectPush
Attribute Identifier : 0x4 - ProtocolDescriptorList
  Data Sequence
    Data Sequence
      UUID16 : 0x0100 - L2CAP
    Data Sequence
      UUID16 : 0x0003 - RFCOMM
      Channel/Port (Integer) : 0x4
    Data Sequence
      UUID16 : 0x0008 - OBEX
Attribute Identifier : 0x5 - BrowseGroupList
  Data Sequence
    UUID16 : 0x1002 - PublicBrowseGroup (SDP)
Attribute Identifier : 0x6 - LanguageBaseAttributeIDList
  Data Sequence
    Code ISO639 (Integer) : 0x656e
    Encoding (Integer) : 0x6a
    Base Offset (Integer) : 0x100
Attribute Identifier : 0x9 - BluetoothProfileDescriptorList
  Data Sequence
    Data Sequence
      UUID16 : 0x1105 - OBEXObjectPush
      Version (Integer) : 0x100
Attribute Identifier : 0x100
  Text : "OBEX Object Push"
Attribute Identifier : 0x303
  Data Sequence
    Integer : 0xff

Attribute Identifier : 0x0 - ServiceRecordHandle
  Integer : 0x10002
Attribute Identifier : 0x1 - ServiceClassIDList
  Data Sequence
    UUID16 : 0x1101 - SerialPort
Attribute Identifier : 0x4 - ProtocolDescriptorList
  Data Sequence
    Data Sequence
      UUID16 : 0x0100 - L2CAP
    Data Sequence
      UUID16 : 0x0003 - RFCOMM
      Channel/Port (Integer) : 0x5
Attribute Identifier : 0x5 - BrowseGroupList
  Data Sequence
    UUID16 : 0x1002 - PublicBrowseGroup (SDP)
Attribute Identifier : 0x6 - LanguageBaseAttributeIDList
  Data Sequence
    Code ISO639 (Integer) : 0x656e
    Encoding (Integer) : 0x6a
    Base Offset (Integer) : 0x100
Attribute Identifier : 0x100
  Text : "Serial Port"

Attribute Identifier : 0x0 - ServiceRecordHandle
  Integer : 0x10003
Attribute Identifier : 0x1 - ServiceClassIDList
  Data Sequence
    UUID16 : 0x1103 - DialupNetworking (DUN)
Attribute Identifier : 0x4 - ProtocolDescriptorList
  Data Sequence
    Data Sequence
      UUID16 : 0x0100 - L2CAP
    Data Sequence
      UUID16 : 0x0003 - RFCOMM
      Channel/Port (Integer) : 0x3
Attribute Identifier : 0x5 - BrowseGroupList
  Data Sequence
    UUID16 : 0x1002 - PublicBrowseGroup (SDP)
Attribute Identifier : 0x6 - LanguageBaseAttributeIDList
  Data Sequence
    Code ISO639 (Integer) : 0x656e
    Encoding (Integer) : 0x6a
    Base Offset (Integer) : 0x100
Attribute Identifier : 0x9 - BluetoothProfileDescriptorList
  Data Sequence
    Data Sequence
      UUID16 : 0x1103 - DialupNetworking (DUN)
      Version (Integer) : 0x100
Attribute Identifier : 0x100
  Text : "Dial-up networking"

Attribute Identifier : 0x0 - ServiceRecordHandle
  Integer : 0x10004
Attribute Identifier : 0x1 - ServiceClassIDList
  Data Sequence
    UUID16 : 0x1112 - HeadsetAudioGateway
    UUID16 : 0x1203 - GenericAudio
Attribute Identifier : 0x4 - ProtocolDescriptorList
  Data Sequence
    Data Sequence
      UUID16 : 0x0100 - L2CAP
    Data Sequence
      UUID16 : 0x0003 - RFCOMM
      Channel/Port (Integer) : 0x1
Attribute Identifier : 0x5 - BrowseGroupList
  Data Sequence
    UUID16 : 0x1002 - PublicBrowseGroup (SDP)
Attribute Identifier : 0x6 - LanguageBaseAttributeIDList
  Data Sequence
    Code ISO639 (Integer) : 0x656e
    Encoding (Integer) : 0x6a
    Base Offset (Integer) : 0x100
Attribute Identifier : 0x9 - BluetoothProfileDescriptorList
  Data Sequence
    Data Sequence
      UUID16 : 0x1108 - Headset
      Version (Integer) : 0x100
Attribute Identifier : 0x100
  Text : "Voice gateway"

Attribute Identifier : 0x0 - ServiceRecordHandle
  Integer : 0x10005
Attribute Identifier : 0x1 - ServiceClassIDList
  Data Sequence
    UUID16 : 0x111f - HandsfreeAudioGateway
    UUID16 : 0x1203 - GenericAudio
Attribute Identifier : 0x4 - ProtocolDescriptorList
  Data Sequence
    Data Sequence
      UUID16 : 0x0100 - L2CAP
    Data Sequence
      UUID16 : 0x0003 - RFCOMM
      Channel/Port (Integer) : 0x2
Attribute Identifier : 0x5 - BrowseGroupList
  Data Sequence
    UUID16 : 0x1002 - PublicBrowseGroup (SDP)
Attribute Identifier : 0x6 - LanguageBaseAttributeIDList
  Data Sequence
    Code ISO639 (Integer) : 0x656e
    Encoding (Integer) : 0x6a
    Base Offset (Integer) : 0x100
Attribute Identifier : 0x9 - BluetoothProfileDescriptorList
  Data Sequence
    Data Sequence
      UUID16 : 0x111e - Handsfree
      Version (Integer) : 0x101
Attribute Identifier : 0x100
  Text : "Voice gateway"
Attribute Identifier : 0x301
  Integer : 0x1
Attribute Identifier : 0x311
  Integer : 0x1

Let me know what else you want to know.

Greetings

Andy


-- 
Blue Cell Networks GmbH
Industriestraße 1b
96163 Gundelsheim

Tel.: 0951-700 42 891 | Fax.: 0951-700 42 887

Diese Email sowie sämtliche mit ihr übertragenen Dateien enthalten
vertrauliche und/oder rechtlich geschützte Informationen, welche
lediglich für den/die Adressaten bestimmt sind. Sollten Sie nicht der
vorgesehene Empfänger sein, ist Ihnen der Gebrauch, die Verbreitung oder
Vervielfältigung der darin enthaltenen Informationen nicht gestattet.
Sollten Sie nicht der vorgesehene Empfänger sein, benachrichtigen Sie
den Absender bitte umgehend per Email und vernichten Sie die
Originalnachricht einschließlich etwaiger Kopien und angehängter
Dateien. Vielen Dank.


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
