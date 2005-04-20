Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <20050420105952.90278.qmail@web41311.mail.yahoo.com>
From: Alex Dubov <oakad@yahoo.com>
Subject: Re: [Bluez-devel] Strange problem with sdp and Motorola E398
To: bluez-devel@lists.sourceforge.net
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1236117676-1113994791=:89046"
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
Date: Wed, 20 Apr 2005 03:59:51 -0700 (PDT)

--0-1236117676-1113994791=:89046
Content-Type: text/plain; charset=us-ascii
Content-Id: 
Content-Disposition: inline

I've checked out libs2 from sf cvs and ran sdptest -
I've attached the results, though they are not
exciting (no other strings - only arabic). Does it
means that I have to write to motorola people - this
seems as a firmware bug after all. 

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-1236117676-1113994791=:89046
Content-Type: text/plain; name="sdt2.txt"
Content-Description: sdt2.txt
Content-Disposition: inline; filename="sdt2.txt"

Sequence
	Attribute 0x0000 - Service record handle
		UINT32 0x00000000
	Attribute 0x0001 - Service class ID list
		Sequence
			UUID16 0x1000 - Service Discovery Service
	Attribute 0x0002 - Service record state
		UINT32 0x00000001
	Attribute 0x0004 - Protocol descriptor list
		Sequence
			Sequence
				UUID16 0x0100 - L2CAP
			Sequence
				UUID16 0x0001 - SDP
	Attribute 0x0005 - Browse group list
		Sequence
			UUID16 0x1002 - Public Browse Group
	Attribute 0x0009 - Bluetooth profile descriptor list
		Sequence
			Sequence
				UUID16 0x1000 - Service Discovery Service
				UINT16 0x0100
	Attribute 0x0200
		Sequence
			UINT16 0x1000
	Attribute 0x0201
		UINT32 0x00000001
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

--0-1236117676-1113994791=:89046--


-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
