Return-Path: <noring@nocrew.org>
Subject: Re: [Bluez-users] IBM Thinkpad A31p and Bluetooth
From: Fredrik Noring <noring@nocrew.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: jvp@lateapex.net, BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1063449127.28890.407.camel@pegasus>
References: <200309130612.h8D6CKs06276@localhost.lateapex.net>
	 <1063441693.19165.31.camel@h9n1fls20o980.bredband.comhem.se>
	 <1063449127.28890.407.camel@pegasus>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1063473896.18942.35.camel@h9n1fls20o980.bredband.comhem.se>
Mime-Version: 1.0
Date: Sat, 13 Sep 2003 19:24:56 +0200
List-ID: <bluez-users.lists.sourceforge.net>

lör 2003-09-13 klockan 12.32 skrev Marcel Holtmann:
> Please, can someone post the result of a SDP search with --tree option
> for the OBEX push profile.

Sure. Does the result indicate anything?

	Fredrik

# sdptool search --tree OPUSH 00:07:E0:0C:1B:3F
Inquiring ...
Searching for OPUSH on 00:07:E0:0C:1B:3F ...
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
      Channel/Port (Integer) : 0x1
    Data Sequence
      UUID16 : 0x0008 - OBEX
Attribute Identifier : 0x6 - LanguageBaseAttributeIDList
  Data Sequence
    Integer : 0x656e
    Integer : 0x8cc
    Integer : 0x100
Attribute Identifier : 0x100
  Text : "OBEX Object Push"
Attribute Identifier : 0x303
  Data Sequence
    Integer : 0x1
    Integer : 0x2
    Integer : 0x3
    Integer : 0xff
