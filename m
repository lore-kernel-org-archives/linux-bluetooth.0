Return-Path: <bluez@thomae-privat.de>
Message-ID: <40CF4B17.2010806@thomae-privat.de>
Date: Tue, 15 Jun 2004 21:16:39 +0200
From: Matthias Thomae <bluez@thomae-privat.de>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Epox Barton keyboard: HID create error 53
References: <40CDE18C.70703@thomae-privat.de>	 <1087255678.13792.51.camel@pegasus>  <40CE96A8.3020407@thomae-privat.de>	 <1087284859.13792.67.camel@pegasus>  <40CEC020.6050107@thomae-privat.de> <1087292887.13792.81.camel@pegasus>
In-Reply-To: <1087292887.13792.81.camel@pegasus>
Content-Type: multipart/mixed;
 boundary="------------000402040704030200030809"
List-ID: <bluez-users.lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------000402040704030200030809
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marcel,

Marcel Holtmann wrote:
> someone has to fix the HID parser to get it working with the keyboard
> and the presenter from EPoX. I am a little bit busy in getting the boot
> protocol support ready, so that we can at least include HID boot support
> into the mainline kernel. The full report protocol support has to wait
> until the kernel gets its device independent HID support.

Alright, thank you meanwhile.

>>>Please send me the output of your mouse too and use
>>
>>I`ll send it tonight, 'cause I haven't got it with me now.

Here it is:

 > hcitool info 00:04:61:XX:XX:XX
Requesting information ...
	BD Address:  00:04:61:XX:XX:XX
	Device Name: Bluetooth-Mouse 817860
	LMP Version: 1.1 (0x1) LMP Subversion: 0x356
	Manufacturer: Cambridge Silicon Radio (10)
	Features: 0xff 0xff 0x0b 0x00 0x00 0x00 0x00 0x00
		<3-slot packets> <5-slot packets> <encryption> <slot offset>
		<timing accuracy> <role switch> <hold mode> <sniff mode>
		<park state> <RSSI> <channel quality> <SCO link> <HV2 packets>
		<HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme>
		<transparent SCO>

>>>	sdptest records 00:04:61:xx:xx:xx > file
>>>
>>>from the utils2 CVS to get the full SDP record information.
>>
>>It's attached. Do you need the same from the mouse, too?
>>Anything else I can do?
> 
> 
> Please do so. I want to compare it with my devices. The keyboard looks
> the same as mine. It seems they only choosed a newer CSR firmware.

Hopefully a better one ;)
It's attached.

Regards.
Matthias

--------------000402040704030200030809
Content-Type: text/plain;
 name="BT-MS02B-sdptest-records.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="BT-MS02B-sdptest-records.txt"

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
		String CSR Mouse
	Attribute 0x0101
		String Three Button Mouse
	Attribute 0x0102
		String CSR HIDEngine
	Attribute 0x0200
		UINT16 0x0100
	Attribute 0x0201
		UINT16 0x0100
	Attribute 0x0202
		UINT8 0x80
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
				String 05 01 09 02 a1 01 09 01 a1 00 85 02 05 09 19 01 29 03 15 00 25 01 95 03 75 01 81 02 95 01 75 05 81 03 05 01 09 30 09 31 09 38 15 81 25 7f 75 08 95 03 81 06 c0 c0
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

--------------000402040704030200030809--
