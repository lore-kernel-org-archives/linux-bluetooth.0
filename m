Return-Path: <noring@nocrew.org>
Subject: Re: [Bluez-users] IBM Thinkpad A31p and Bluetooth
From: Fredrik Noring <noring@nocrew.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: jvp@lateapex.net, BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1063545999.28890.464.camel@pegasus>
References: <200309130612.h8D6CKs06276@localhost.lateapex.net>
	 <1063441693.19165.31.camel@h9n1fls20o980.bredband.comhem.se>
	 <1063449127.28890.407.camel@pegasus>
	 <1063473896.18942.35.camel@h9n1fls20o980.bredband.comhem.se>
	 <1063475808.28891.450.camel@pegasus>
	 <1063477310.19165.49.camel@h9n1fls20o980.bredband.comhem.se>
	 <1063545999.28890.464.camel@pegasus>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1063556894.12978.20.camel@h9n1fls20o980.bredband.comhem.se>
Mime-Version: 1.0
Date: Sun, 14 Sep 2003 18:28:14 +0200
List-ID: <bluez-users.lists.sourceforge.net>

Hi Marcel,

sön 2003-09-14 klockan 15.26 skrev Marcel Holtmann:
> 	sdptool get --tree --bdaddr <bdaddr> 0x10000
> 	...

I've tested 0x10000 through 0x1007f with interesting results on 0x10000
and 0x10001.

Thanks,
	Fredrik

Probing 0x10000...
Attribute Identifier : 0x0 - ServiceRecordHandle
  Integer : 0x10000
Attribute Identifier : 0x1 - ServiceClassIDList
  Data Sequence
    UUID128 : 0xf5beb651-4171-4051-acf5-6ca72022-42f0

Probing 0x10001...
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

Probing 0x10002...
Service get request failed.

...
