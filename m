Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Fred Schaettgen <bluez-devel@schaettgen.de>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_d0iZC9+SWNkC6bW"
Message-Id: <200504201221.17999.bluez-devel@schaettgen.de>
Subject: [Bluez-devel] Translated strings in SDP records
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
Date: Wed, 20 Apr 2005 12:21:17 +0200

--Boundary-00=_d0iZC9+SWNkC6bW
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi folks,

A few days ago I have been asked to support translated strings in the SDP 
related parts of kdebluetooth, so that service names are displayed in an 
appropriate language in the user interface.
All my devices use English only for the SDP records, so I asked Alex Dubov, 
who sent the feature request, to show me his sdp records. 
The output of sdptool browse --tree is attached. His device claims to support 
various languages in the LanguageBaseAttributeIDList, but the services names 
themselves are only returned in one language. Shouldn't the names be returned 
in all suported languages at once? Or do I have to request the desired 
languages explicitly somehow? 

thanks for any hints

Fred

-- 
Fred Schaettgen
bluez-devel@schaettgen.de

--Boundary-00=_d0iZC9+SWNkC6bW
Content-Type: text/plain;
  charset="us-ascii";
  name="sdplogtr.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="sdplogtr.txt"

Browsing 00:0A:28:59:8C:6F ...
Attribute Identifier : 0x0 - ServiceRecordHandle
  Integer : 0x0
Attribute Identifier : 0x1 - ServiceClassIDList
  Data Sequence
    UUID16 : 0x1000 - ServiceDiscoveryServerServiceClassID (SDP)
Attribute Identifier : 0x2 - ServiceRecordState
  Integer : 0x1
Attribute Identifier : 0x4 - ProtocolDescriptorList
  Data Sequence
    Data Sequence
      UUID16 : 0x0100 - L2CAP
    Data Sequence
      UUID16 : 0x0001 - SDP (Service Discovery Protocol)
Attribute Identifier : 0x5 - BrowseGroupList
  Data Sequence
    UUID16 : 0x1002 - PublicBrowseGroup (SDP)
Attribute Identifier : 0x9 - BluetoothProfileDescriptorList
  Data Sequence
    Data Sequence
      UUID16 : 0x1000 - ServiceDiscoveryServerServiceClassID (SDP)
      Version (Integer) : 0x100
Attribute Identifier : 0x200 - VersionNumberList
  Data Sequence
    Integer : 0x1000
Attribute Identifier : 0x201 - ServiceDatabaseState
  Integer : 0x1

Attribute Identifier : 0x0 - ServiceRecordHandle
  Integer : 0x10001
Attribute Identifier : 0x1 - ServiceClassIDList
  Data Sequence
    UUID16 : 0x1103 - DialupNetworking (DUN)
Attribute Identifier : 0x2 - ServiceRecordState
  Integer : 0x1
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
    Code ISO639 (Integer) : 0x6172
    Encoding (Integer) : 0x6a
    Base Offset (Integer) : 0x100
    Integer : 0x6865
    Integer : 0x6a
    Integer : 0xd800
    Integer : 0x7275
    Integer : 0x6a
    Integer : 0xd803
    Integer : 0x656e
    Integer : 0x6a
    Integer : 0xd806
    Integer : 0x6672
    Integer : 0x6a
    Integer : 0xd809
    Integer : 0x6573
    Integer : 0x6a
    Integer : 0xd80c
    Integer : 0x7472
    Integer : 0x6a
    Integer : 0xd80f
Attribute Identifier : 0x9 - BluetoothProfileDescriptorList
  Data Sequence
    Data Sequence
      UUID16 : 0x1103 - DialupNetworking (DUN)
      Version (Integer) : 0x100
Attribute Identifier : 0x100
  Text : "=D9=85=D9=86=D9=81=D8=B0 =D8=A7=D8=AA=D8=B5=D8=A7"
Attribute Identifier : 0x101
  Text : "=D9=85=D9=86=D9=81=D8=B0 =D8=A7=D8=AA=D8=B5=D8=A7"
Attribute Identifier : 0x102
  Text : "Motorola"
Attribute Identifier : 0x201
  Data Sequence
    Integer : 0x3002
Attribute Identifier : 0x202
  Data Sequence
    Integer : 0x22b8

Attribute Identifier : 0x0 - ServiceRecordHandle
  Integer : 0x10003
Attribute Identifier : 0x1 - ServiceClassIDList
  Data Sequence
    UUID16 : 0x1112 - HeadsetAudioGateway
    UUID16 : 0x1203 - GenericAudio
Attribute Identifier : 0x2 - ServiceRecordState
  Integer : 0x1
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
    Code ISO639 (Integer) : 0x6172
    Encoding (Integer) : 0x6a
    Base Offset (Integer) : 0x100
    Integer : 0x6865
    Integer : 0x6a
    Integer : 0xd800
    Integer : 0x7275
    Integer : 0x6a
    Integer : 0xd803
    Integer : 0x656e
    Integer : 0x6a
    Integer : 0xd806
    Integer : 0x6672
    Integer : 0x6a
    Integer : 0xd809
    Integer : 0x6573
    Integer : 0x6a
    Integer : 0xd80c
    Integer : 0x7472
    Integer : 0x6a
    Integer : 0xd80f
Attribute Identifier : 0x9 - BluetoothProfileDescriptorList
  Data Sequence
    Data Sequence
      UUID16 : 0x1108 - Headset
      Version (Integer) : 0x100
Attribute Identifier : 0x100
  Text : "=D8=A7=D9=84=D9=85=D9=86=D9=81=D8=B0 "
Attribute Identifier : 0x101
  Text : "=D9=85=D9=86=D9=81=D8=B0 =D8=B3=D9=85=D8=A7=D8=B9"
Attribute Identifier : 0x102
  Text : "Motorola"

Attribute Identifier : 0x0 - ServiceRecordHandle
  Integer : 0x10007
Attribute Identifier : 0x1 - ServiceClassIDList
  Data Sequence
    UUID16 : 0x111f - HandsfreeAudioGateway
    UUID16 : 0x1203 - GenericAudio
Attribute Identifier : 0x2 - ServiceRecordState
  Integer : 0x1
Attribute Identifier : 0x4 - ProtocolDescriptorList
  Data Sequence
    Data Sequence
      UUID16 : 0x0100 - L2CAP
    Data Sequence
      UUID16 : 0x0003 - RFCOMM
      Channel/Port (Integer) : 0x7
Attribute Identifier : 0x5 - BrowseGroupList
  Data Sequence
    UUID16 : 0x1002 - PublicBrowseGroup (SDP)
Attribute Identifier : 0x6 - LanguageBaseAttributeIDList
  Data Sequence
    Code ISO639 (Integer) : 0x6172
    Encoding (Integer) : 0x6a
    Base Offset (Integer) : 0x100
    Integer : 0x6865
    Integer : 0x6a
    Integer : 0xd800
    Integer : 0x7275
    Integer : 0x6a
    Integer : 0xd803
    Integer : 0x656e
    Integer : 0x6a
    Integer : 0xd806
    Integer : 0x6672
    Integer : 0x6a
    Integer : 0xd809
    Integer : 0x6573
    Integer : 0x6a
    Integer : 0xd80c
    Integer : 0x7472
    Integer : 0x6a
    Integer : 0xd80f
Attribute Identifier : 0x9 - BluetoothProfileDescriptorList
  Data Sequence
    Data Sequence
      UUID16 : 0x111e - Handsfree
      Version (Integer) : 0x101
Attribute Identifier : 0x100
  Text : "=D9=85=D9=86=D9=81=D8=B0 =D8=A7=D9=84=D8=B5=D9=88=D8=AA "
Attribute Identifier : 0x101
  Text : "=D9=85=D9=86=D9=81=D8=B0 =D8=A7=D9=84=D8=B5=D9=88=D8=AA "
Attribute Identifier : 0x102
  Text : "Motorola"
Attribute Identifier : 0x301
  Integer : 0x1
Attribute Identifier : 0x311
  Integer : 0x1f

Attribute Identifier : 0x0 - ServiceRecordHandle
  Integer : 0x10008
Attribute Identifier : 0x1 - ServiceClassIDList
  Data Sequence
    UUID16 : 0x1105 - OBEXObjectPush
Attribute Identifier : 0x2 - ServiceRecordState
  Integer : 0x1
Attribute Identifier : 0x4 - ProtocolDescriptorList
  Data Sequence
    Data Sequence
      UUID16 : 0x0100 - L2CAP
    Data Sequence
      UUID16 : 0x0003 - RFCOMM
      Channel/Port (Integer) : 0x8
    Data Sequence
      UUID16 : 0x0008 - OBEX
Attribute Identifier : 0x5 - BrowseGroupList
  Data Sequence
    UUID16 : 0x1002 - PublicBrowseGroup (SDP)
Attribute Identifier : 0x6 - LanguageBaseAttributeIDList
  Data Sequence
    Code ISO639 (Integer) : 0x6172
    Encoding (Integer) : 0x6a
    Base Offset (Integer) : 0x100
    Integer : 0x6865
    Integer : 0x6a
    Integer : 0xd800
    Integer : 0x7275
    Integer : 0x6a
    Integer : 0xd803
    Integer : 0x656e
    Integer : 0x6a
    Integer : 0xd806
    Integer : 0x6672
    Integer : 0x6a
    Integer : 0xd809
    Integer : 0x6573
    Integer : 0x6a
    Integer : 0xd80c
    Integer : 0x7472
    Integer : 0x6a
    Integer : 0xd80f
Attribute Identifier : 0x9 - BluetoothProfileDescriptorList
  Data Sequence
    Data Sequence
      UUID16 : 0x1105 - OBEXObjectPush
      Version (Integer) : 0x100
Attribute Identifier : 0x100
  Text : "=D8=AA=D8=A8=D8=A7=D8=AF=D9=84 =D8=A7=D9=84=D8=B9=D9=86=D8=A7=D8=
=B5"
Attribute Identifier : 0x101
  Text : "=D8=AA=D8=A8=D8=A7=D8=AF=D9=84 =D8=A7=D9=84=D8=B9=D9=86=D8=A7=D8=
=B5"
Attribute Identifier : 0x102
  Text : "Motorola"
Attribute Identifier : 0x303
  Data Sequence
    Integer : 0xff

Attribute Identifier : 0x0 - ServiceRecordHandle
  Integer : 0x10009
Attribute Identifier : 0x1 - ServiceClassIDList
  Data Sequence
    UUID16 : 0x1106 - OBEXFileTransfer
Attribute Identifier : 0x2 - ServiceRecordState
  Integer : 0x1
Attribute Identifier : 0x4 - ProtocolDescriptorList
  Data Sequence
    Data Sequence
      UUID16 : 0x0100 - L2CAP
    Data Sequence
      UUID16 : 0x0003 - RFCOMM
      Channel/Port (Integer) : 0x9
    Data Sequence
      UUID16 : 0x0008 - OBEX
Attribute Identifier : 0x5 - BrowseGroupList
  Data Sequence
    UUID16 : 0x1002 - PublicBrowseGroup (SDP)
Attribute Identifier : 0x6 - LanguageBaseAttributeIDList
  Data Sequence
    Code ISO639 (Integer) : 0x6172
    Encoding (Integer) : 0x6a
    Base Offset (Integer) : 0x100
    Integer : 0x6865
    Integer : 0x6a
    Integer : 0xd800
    Integer : 0x7275
    Integer : 0x6a
    Integer : 0xd803
    Integer : 0x656e
    Integer : 0x6a
    Integer : 0xd806
    Integer : 0x6672
    Integer : 0x6a
    Integer : 0xd809
    Integer : 0x6573
    Integer : 0x6a
    Integer : 0xd80c
    Integer : 0x7472
    Integer : 0x6a
    Integer : 0xd80f
Attribute Identifier : 0x9 - BluetoothProfileDescriptorList
  Data Sequence
    Data Sequence
      UUID16 : 0x1106 - OBEXFileTransfer
      Version (Integer) : 0x100
Attribute Identifier : 0x100
  Text : "=D8=AA=D9=85 =D9=86=D9=82=D9=84 =D9=85=D9=84"
Attribute Identifier : 0x101
  Text : "=D8=AA=D9=85 =D9=86=D9=82=D9=84 =D9=85=D9=84"
Attribute Identifier : 0x102
  Text : "Motorola"


--Boundary-00=_d0iZC9+SWNkC6bW--


-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
