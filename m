Return-Path: <bluez@thomae-privat.de>
Message-ID: <40CEC020.6050107@thomae-privat.de>
Date: Tue, 15 Jun 2004 11:23:44 +0200
From: Matthias Thomae <bluez@thomae-privat.de>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Epox Barton keyboard: HID create error 53
References: <40CDE18C.70703@thomae-privat.de>	 <1087255678.13792.51.camel@pegasus>  <40CE96A8.3020407@thomae-privat.de> <1087284859.13792.67.camel@pegasus>
In-Reply-To: <1087284859.13792.67.camel@pegasus>
Content-Type: multipart/mixed;
 boundary="------------040505080006040201070805"
List-ID: <bluez-users.lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------040505080006040201070805
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marcel,

Marcel Holtmann wrote:
> it is a problem of the HID parser. If you enable debugging with "#define
> DEBUG" in net/bluetooth/hidp/hid.h then you should see those lines with
> dmesg:
> 
> net/bluetooth/hidp/hid.c: usage index exceeded
> net/bluetooth/hidp/hid.c: hid_add_usage failed
> net/bluetooth/hidp/hid.c: item 0 2 2 2 parsing failed
> 
> Do you see it, too?

Yes, I see exactly the same.

> Please send me the output of your mouse too and use

I`ll send it tonight, 'cause I haven't got it with me now.

> 	sdptest records 00:04:61:xx:xx:xx > file
> 
> from the utils2 CVS to get the full SDP record information.

It's attached. Do you need the same from the mouse, too?
Anything else I can do?

Regards.
Matthias

--------------040505080006040201070805
Content-Type: text/plain;
 name="BT-KB01B-sdptest-records.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="BT-KB01B-sdptest-records.txt"

Sequence
	Attribute 0x0000 - Service record handle
		UINT32 0x00010000
	Attribute 0x0001 - Service class ID list
		Sequence
			UUID16 0x1124 - Human Interface Device Service
	Attribute 0x0004 - Protocol descriptor list
		Sequence
			Sequence
				UUID16 0x0100 - L2CAP
				UINT16 0x0011
			Sequence
				UUID16 0x0011 - HIDP
	Attribute 0x0006 - Language base attribute ID list
		Sequence
			UINT16 0x656e
			UINT16 0x006a
			UINT16 0x0100
	Attribute 0x0009 - Bluetooth profile descriptor list
		Sequence
			Sequence
				UUID16 0x1124 - Human Interface Device Service
				UINT16 0x0100
	Attribute 0x000d - Additional protocol descriptor lists
		Sequence
			Sequence
				Sequence
					UUID16 0x0100 - L2CAP
					UINT16 0x0013
				Sequence
					UUID16 0x0011 - HIDP
	Attribute 0x0100
		String Epox Keyboard
	Attribute 0x0101
		String Keyboard
	Attribute 0x0102
		String Epox HIDEngine
	Attribute 0x0200
		UINT16 0x0100
	Attribute 0x0201
		UINT16 0x0100
	Attribute 0x0202
		UINT8 0x40
	Attribute 0x0203
		UINT8 0x33
	Attribute 0x0204
		Bool True
	Attribute 0x0205
		Bool True
	Attribute 0x0206
		Sequence
			Sequence
				UINT8 0x22
				String 05 01 09 06 a1 01 05 07 85 01 19 e0 29 e7 15 00 25 01 75 01 95 08 81 02 75 08 95 01 81 01 05 07 19 00 2a 00 ff 15 00 26 00 ff 75 08 95 06 81 00 05 08 85 01 19 01 29 05 75 01 95 05 91 02 75 03 95 01 91 01 c0 05 0c 09 01 a1 01 85 02 05 0c 15 00 25 01 75 01 95 12 09 b7 09 cd 09 b5 09 b6 0a 83 01 09 ea 09 e9 09 e2 0a 2a 02 0a 8a 01 0a 23 02 0a 94 01 0a 92 01 0a 27 02 0a 26 02 0a 21 02 0a 25 02 0a 24 02 81 02 75 01 95 06 81 01 c0 05 01 09 80 a1 01 85 03 15 00 25 01 09 81 09 82 09 83 75 03 95 01 81 02 95 05 75 01 81 01 c0 05 06 09 01 a1 01 85 ff 95 01 75 02 09 24 09 26 81 02 75 06 81 01 c0
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

--------------040505080006040201070805--
