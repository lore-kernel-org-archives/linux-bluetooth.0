Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <20050420130640.9548.qmail@web41304.mail.yahoo.com>
From: Alex Dubov <oakad@yahoo.com>
Subject: Re: [Bluez-devel] Strange problem with sdp and Motorola E398
To: bluez-devel@lists.sourceforge.net
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-581300901-1114002400=:8213"
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
Date: Wed, 20 Apr 2005 06:06:40 -0700 (PDT)

--0-581300901-1114002400=:8213
Content-Type: text/plain; charset=us-ascii
Content-Id: 
Content-Disposition: inline

Ok, here are the dumps (all have same symptoms,
really).

--- Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Alex,
> 
> > I've checked out libs2 from sf cvs and ran sdptest
> -
> > I've attached the results, though they are not
> > exciting (no other strings - only arabic).
> 
> please redo it with "sdptest records" and also
> include the output of
> "hcitool info" (as root) for this phone.
> 
> > Does it
> > means that I have to write to motorola people -
> this
> > seems as a firmware bug after all. 
> 
> Check again with "hcidump -X -V" and post the dump,
> but I really think
> that these attributes are missing.
> 
> Write to the Motorola people and see what they tell
> you about it.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
>
-------------------------------------------------------
> This SF.Net email is sponsored by: New Crystal
> Reports XI.
> Version 11 adds new functionality designed to reduce
> time involved in
> creating, integrating, and deploying reporting
> solutions. Free runtime info,
> new features, or free trial, at:
> http://www.businessobjects.com/devxi/728
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
>
https://lists.sourceforge.net/lists/listinfo/bluez-devel
> 

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-581300901-1114002400=:8213
Content-Type: text/plain; name="sdt3.txt"
Content-Description: sdt3.txt
Content-Disposition: inline; filename="sdt3.txt"

Sequence
	Attribute 0x0000 - Service record handle
		UINT32 0x00010001
	Attribute 0x0001 - Service class ID list
		Sequence
			UUID16 0x1103 - Dialup Networking
	Attribute 0x0002 - Service record state
		UINT32 0x00000001
	Attribute 0x0004 - Protocol descriptor list
		Sequence
			Sequence
				UUID16 0x0100 - L2CAP
			Sequence
				UUID16 0x0003 - RFCOMM
				UINT8 0x01
	Attribute 0x0005 - Browse group list
		Sequence
			UUID16 0x1002 - Public Browse Group
	Attribute 0x0006 - Language base attribute ID list
		Sequence
			UINT16 0x6172
			UINT16 0x006a
			UINT16 0x0100
			UINT16 0x6865
			UINT16 0x006a
			UINT16 0xd800
			UINT16 0x7275
			UINT16 0x006a
			UINT16 0xd803
			UINT16 0x656e
			UINT16 0x006a
			UINT16 0xd806
			UINT16 0x6672
			UINT16 0x006a
			UINT16 0xd809
			UINT16 0x6573
			UINT16 0x006a
			UINT16 0xd80c
			UINT16 0x7472
			UINT16 0x006a
			UINT16 0xd80f
	Attribute 0x0009 - Bluetooth profile descriptor list
		Sequence
			Sequence
				UUID16 0x1103 - Dialup Networking
				UINT16 0x0100
	Attribute 0x0100
		String منفذ اتصا
	Attribute 0x0101
		String منفذ اتصا
	Attribute 0x0102
		String Motorola
	Attribute 0x0201
		Sequence
			UINT16 0x3002
	Attribute 0x0202
		Sequence
			UINT16 0x22b8
Sequence
	Attribute 0x0000 - Service record handle
		UINT32 0x00010003
	Attribute 0x0001 - Service class ID list
		Sequence
			UUID16 0x1112 - Headset Audio Gateway
			UUID16 0x1203 - Generic Audio
	Attribute 0x0002 - Service record state
		UINT32 0x00000001
	Attribute 0x0004 - Protocol descriptor list
		Sequence
			Sequence
				UUID16 0x0100 - L2CAP
			Sequence
				UUID16 0x0003 - RFCOMM
				UINT8 0x03
	Attribute 0x0005 - Browse group list
		Sequence
			UUID16 0x1002 - Public Browse Group
	Attribute 0x0006 - Language base attribute ID list
		Sequence
			UINT16 0x6172
			UINT16 0x006a
			UINT16 0x0100
			UINT16 0x6865
			UINT16 0x006a
			UINT16 0xd800
			UINT16 0x7275
			UINT16 0x006a
			UINT16 0xd803
			UINT16 0x656e
			UINT16 0x006a
			UINT16 0xd806
			UINT16 0x6672
			UINT16 0x006a
			UINT16 0xd809
			UINT16 0x6573
			UINT16 0x006a
			UINT16 0xd80c
			UINT16 0x7472
			UINT16 0x006a
			UINT16 0xd80f
	Attribute 0x0009 - Bluetooth profile descriptor list
		Sequence
			Sequence
				UUID16 0x1108 - Headset
				UINT16 0x0100
	Attribute 0x0100
		String المنفذ 
	Attribute 0x0101
		String منفذ سماع
	Attribute 0x0102
		String Motorola
Sequence
	Attribute 0x0000 - Service record handle
		UINT32 0x00010007
	Attribute 0x0001 - Service class ID list
		Sequence
			UUID16 0x111f - Handsfree Audio Gateway
			UUID16 0x1203 - Generic Audio
	Attribute 0x0002 - Service record state
		UINT32 0x00000001
	Attribute 0x0004 - Protocol descriptor list
		Sequence
			Sequence
				UUID16 0x0100 - L2CAP
			Sequence
				UUID16 0x0003 - RFCOMM
				UINT8 0x07
	Attribute 0x0005 - Browse group list
		Sequence
			UUID16 0x1002 - Public Browse Group
	Attribute 0x0006 - Language base attribute ID list
		Sequence
			UINT16 0x6172
			UINT16 0x006a
			UINT16 0x0100
			UINT16 0x6865
			UINT16 0x006a
			UINT16 0xd800
			UINT16 0x7275
			UINT16 0x006a
			UINT16 0xd803
			UINT16 0x656e
			UINT16 0x006a
			UINT16 0xd806
			UINT16 0x6672
			UINT16 0x006a
			UINT16 0xd809
			UINT16 0x6573
			UINT16 0x006a
			UINT16 0xd80c
			UINT16 0x7472
			UINT16 0x006a
			UINT16 0xd80f
	Attribute 0x0009 - Bluetooth profile descriptor list
		Sequence
			Sequence
				UUID16 0x111e - Handsfree
				UINT16 0x0101
	Attribute 0x0100
		String منفذ الصوت 
	Attribute 0x0101
		String منفذ الصوت 
	Attribute 0x0102
		String Motorola
	Attribute 0x0301
		UINT8 0x01
	Attribute 0x0311
		UINT16 0x001f
Sequence
	Attribute 0x0000 - Service record handle
		UINT32 0x00010008
	Attribute 0x0001 - Service class ID list
		Sequence
			UUID16 0x1105 - OBEX Object Push
	Attribute 0x0002 - Service record state
		UINT32 0x00000001
	Attribute 0x0004 - Protocol descriptor list
		Sequence
			Sequence
				UUID16 0x0100 - L2CAP
			Sequence
				UUID16 0x0003 - RFCOMM
				UINT8 0x08
			Sequence
				UUID16 0x0008 - OBEX
	Attribute 0x0005 - Browse group list
		Sequence
			UUID16 0x1002 - Public Browse Group
	Attribute 0x0006 - Language base attribute ID list
		Sequence
			UINT16 0x6172
			UINT16 0x006a
			UINT16 0x0100
			UINT16 0x6865
			UINT16 0x006a
			UINT16 0xd800
			UINT16 0x7275
			UINT16 0x006a
			UINT16 0xd803
			UINT16 0x656e
			UINT16 0x006a
			UINT16 0xd806
			UINT16 0x6672
			UINT16 0x006a
			UINT16 0xd809
			UINT16 0x6573
			UINT16 0x006a
			UINT16 0xd80c
			UINT16 0x7472
			UINT16 0x006a
			UINT16 0xd80f
	Attribute 0x0009 - Bluetooth profile descriptor list
		Sequence
			Sequence
				UUID16 0x1105 - OBEX Object Push
				UINT16 0x0100
	Attribute 0x0100
		String تبادل العناص
	Attribute 0x0101
		String تبادل العناص
	Attribute 0x0102
		String Motorola
	Attribute 0x0303
		Sequence
			UINT8 0xff
Sequence
	Attribute 0x0000 - Service record handle
		UINT32 0x00010009
	Attribute 0x0001 - Service class ID list
		Sequence
			UUID16 0x1106 - OBEX File Transfer
	Attribute 0x0002 - Service record state
		UINT32 0x00000001
	Attribute 0x0004 - Protocol descriptor list
		Sequence
			Sequence
				UUID16 0x0100 - L2CAP
			Sequence
				UUID16 0x0003 - RFCOMM
				UINT8 0x09
			Sequence
				UUID16 0x0008 - OBEX
	Attribute 0x0005 - Browse group list
		Sequence
			UUID16 0x1002 - Public Browse Group
	Attribute 0x0006 - Language base attribute ID list
		Sequence
			UINT16 0x6172
			UINT16 0x006a
			UINT16 0x0100
			UINT16 0x6865
			UINT16 0x006a
			UINT16 0xd800
			UINT16 0x7275
			UINT16 0x006a
			UINT16 0xd803
			UINT16 0x656e
			UINT16 0x006a
			UINT16 0xd806
			UINT16 0x6672
			UINT16 0x006a
			UINT16 0xd809
			UINT16 0x6573
			UINT16 0x006a
			UINT16 0xd80c
			UINT16 0x7472
			UINT16 0x006a
			UINT16 0xd80f
	Attribute 0x0009 - Bluetooth profile descriptor list
		Sequence
			Sequence
				UUID16 0x1106 - OBEX File Transfer
				UINT16 0x0100
	Attribute 0x0100
		String تم نقل مل
	Attribute 0x0101
		String تم نقل مل
	Attribute 0x0102
		String Motorola

--0-581300901-1114002400=:8213
Content-Type: text/plain; name="hcii.txt"
Content-Description: hcii.txt
Content-Disposition: inline; filename="hcii.txt"

Requesting information ...
	BD Address:  00:0a:28:59:8c:6f
	Device Name: Kentabor
	LMP Version: 1.1 (0x1) LMP Subversion: 0x700
	Manufacturer: Broadcom Corporation (15)
	Features: 0xff 0xff 0x0d 0x00 0x00 0x00 0x00 0x00
		<3-slot packets> <5-slot packets> <encryption> <slot offset> 
		<timing accuracy> <role switch> <hold mode> <sniff mode> 
		<park state> <RSSI> <channel quality> <SCO link> <HV2 packets> 
		<HV3 packets> <u-law log> <A-law log> <CVSD> <power control> 
		<transparent SCO> 

--0-581300901-1114002400=:8213
Content-Type: text/plain; name="hcid.txt"
Content-Description: hcid.txt
Content-Disposition: inline; filename="hcid.txt"

HCI sniffer - Bluetooth packet analyzer ver 1.19
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Inquiry (0x01|0x0001) plen 5
    lap 0x9e8b33 len 6 num 0
> HCI Event: Command Status (0x0f) plen 4
    Inquiry (0x01|0x0001) status 0x00 ncmd 1
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:0A:28:59:8C:6F ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 
> HCI Event: Inquiry Complete (0x01) plen 1
    status 0x00
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:0A:28:59:8C:6F
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 00:0A:28:59:8C:6F
    Link key: 5b7a51d0ff60eff843eaa8833a594f20
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 00:0A:28:59:8C:6F
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 41 bdaddr 00:0A:28:59:8C:6F type ACL encrypt 0x01
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 41 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK 
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
> HCI Event: Max Slots Change (0x1b) plen 3
  0000: 29 00 05                                          )..
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 41
> ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
> ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 1024 
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
> ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 41 flags 0x02 dlen 26
    L2CAP(d): cid 0x0040 len 22 [psm 1]
        SDP SSA Req: tid 0x0 len 0x11
          pat uuid-32 0x1002 (PubBrwsGrp)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
> ACL data: handle 41 flags 0x02 dlen 339
> ACL data: handle 41 flags 0x01 dlen 331
    L2CAP(d): cid 0x0040 len 666 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x295
          count 656
          cont 02 02 90
< ACL data: handle 41 flags 0x02 dlen 28
    L2CAP(d): cid 0x0040 len 24 [psm 1]
        SDP SSA Req: tid 0x1 len 0x13
          pat uuid-32 0x1002 (PubBrwsGrp)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 02 02 90
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
> ACL data: handle 41 flags 0x02 dlen 339
> ACL data: handle 41 flags 0x01 dlen 105
    L2CAP(d): cid 0x0040 len 440 [psm 1]
        SDP SSA Rsp: tid 0x1 len 0x1b3
          count 432
          record #0
              aid 0x0000 (SrvRecHndl)
                 uint 0x0
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x1000 (SDServer) >
              aid 0x0002 (SrvRecState)
                 uint 0x1
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0001 (SDP) > >
              aid 0x0005 (BrwGrpList)
                 < uuid-16 0x1002 (PubBrwsGrp) >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x1000 (SDServer) uint 0x100 > >
              aid 0x0200 (VersionNumList)
                 < uint 0x1000 >
              aid 0x0201 (SrvDBState)
                 uint 0x1
          record #1
              aid 0x0000 (SrvRecHndl)
                 uint 0x10001
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x1103 (DUN) >
              aid 0x0002 (SrvRecState)
                 uint 0x1
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0x1 > >
              aid 0x0005 (BrwGrpList)
                 < uuid-16 0x1002 (PubBrwsGrp) >
              aid 0x0006 (LangBaseAttrIDList)
                 < uint 0x6172 uint 0x6a uint 0x100 uint 0x6865 uint 0x6a uint 0xd800 uint 0x7275 uint 0x6a uint 0xd803 uint 0x656e uint 0x6a uint 0xd806 uint 0x6672 uint 0x6a uint 0xd809 uint 0x6573 uint 0x6a uint 0xd80c uint 0x7472 uint 0x6a uint 0xd80f >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x1103 (DUN) uint 0x100 > >
              aid 0x0100 (SrvName)
                 str "منفذ اتصا"
              aid 0x0101 (SrvDesc)
                 str "منفذ اتصا"
              aid 0x0102 (ProviderName)
                 str "Motorola"
              aid 0x0201 (SrvDBState)
                 < uint 0x3002 >
              aid 0x0202 (unknown)
                 < uint 0x22b8 >
          record #2
              aid 0x0000 (SrvRecHndl)
                 uint 0x10003
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x1112 (Headset AG) uuid-16 0x1203 (Audio) >
              aid 0x0002 (SrvRecState)
                 uint 0x1
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0x3 > >
              aid 0x0005 (BrwGrpList)
                 < uuid-16 0x1002 (PubBrwsGrp) >
              aid 0x0006 (LangBaseAttrIDList)
                 < uint 0x6172 uint 0x6a uint 0x100 uint 0x6865 uint 0x6a uint 0xd800 uint 0x7275 uint 0x6a uint 0xd803 uint 0x656e uint 0x6a uint 0xd806 uint 0x6672 uint 0x6a uint 0xd809 uint 0x6573 uint 0x6a uint 0xd80c uint 0x7472 uint 0x6a uint 0xd80f >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x1108 (Headset) uint 0x100 > >
              aid 0x0100 (SrvName)
                 str "المنفذ "
              aid 0x0101 (SrvDesc)
                 str "منفذ سماع"
              aid 0x0102 (ProviderName)
                 str "Motorola"
          record #3
              aid 0x0000 (SrvRecHndl)
                 uint 0x10007
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x111f (Handsfree AG) uuid-16 0x1203 (Audio) >
              aid 0x0002 (SrvRecState)
                 uint 0x1
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0x7 > >
              aid 0x0005 (BrwGrpList)
                 < uuid-16 0x1002 (PubBrwsGrp) >
              aid 0x0006 (LangBaseAttrIDList)
                 < uint 0x6172 uint 0x6a uint 0x100 uint 0x6865 uint 0x6a uint 0xd800 uint 0x7275 uint 0x6a uint 0xd803 uint 0x656e uint 0x6a uint 0xd806 uint 0x6672 uint 0x6a uint 0xd809 uint 0x6573 uint 0x6a uint 0xd80c uint 0x7472 uint 0x6a uint 0xd80f >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x111e (Handsfree) uint 0x101 > >
              aid 0x0100 (SrvName)
                 str "منفذ الصوت "
              aid 0x0101 (SrvDesc)
                 str "منفذ الصوت "
              aid 0x0102 (ProviderName)
                 str "Motorola"
              aid 0x0301 (SuppDataStoresList)
                 uint 0x1
              aid 0x0311 (unknown)
                 uint 0x1f
          record #4
              aid 0x0000 (SrvRecHndl)
                 uint 0x10008
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x1105 (OBEXObjPush) >
              aid 0x0002 (SrvRecState)
                 uint 0x1
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0x8 > <
                 uuid-16 0x0008 (OBEX) > >
              aid 0x0005 (BrwGrpList)
                 < uuid-16 0x1002 (PubBrwsGrp) >
              aid 0x0006 (LangBaseAttrIDList)
                 < uint 0x6172 uint 0x6a uint 0x100 uint 0x6865 uint 0x6a uint 0xd800 uint 0x7275 uint 0x6a uint 0xd803 uint 0x656e uint 0x6a uint 0xd806 uint 0x6672 uint 0x6a uint 0xd809 uint 0x6573 uint 0x6a uint 0xd80c uint 0x7472 uint 0x6a uint 0xd80f >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x1105 (OBEXObjPush) uint 0x100 > >
              aid 0x0100 (SrvName)
                 str "تبادل العناص"
              aid 0x0101 (SrvDesc)
                 str "تبادل العناص"
              aid 0x0102 (ProviderName)
                 str "Motorola"
              aid 0x0303 (SuppFormatsList)
                 < uint 0xff >
          record #5
              aid 0x0000 (SrvRecHndl)
                 uint 0x10009
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x1106 (OBEXObjTrnsf) >
              aid 0x0002 (SrvRecState)
                 uint 0x1
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0x9 > <
                 uuid-16 0x0008 (OBEX) > >
              aid 0x0005 (BrwGrpList)
                 < uuid-16 0x1002 (PubBrwsGrp) >
              aid 0x0006 (LangBaseAttrIDList)
                 < uint 0x6172 uint 0x6a uint 0x100 uint 0x6865 uint 0x6a uint 0xd800 uint 0x7275 uint 0x6a uint 0xd803 uint 0x656e uint 0x6a uint 0xd806 uint 0x6672 uint 0x6a uint 0xd809 uint 0x6573 uint 0x6a uint 0xd80c uint 0x7472 uint 0x6a uint 0xd80f >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x1106 (OBEXObjTrnsf) uint 0x100 > >
              aid 0x0100 (SrvName)
                 str "تم نقل مل"
              aid 0x0101 (SrvDesc)
                 str "تم نقل مل"
              aid 0x0102 (ProviderName)
                 str "Motorola"
          cont 00
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 41 reason 0x13
    Reason: Remote User Terminated Connection
> HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 41 reason 0x16
    Reason: Connection Terminated by Local Host

--0-581300901-1114002400=:8213--


-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
