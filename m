Return-Path: <mfrey@pepper.com>
In-Reply-To: <1090940516.4845.19.camel@pegasus>
References: <1090054739.4558.2.camel@pegasus> <1090759952.4791.91.camel@pegasus> <9A44A69C-DF28-11D8-B83A-00039390D626@pepper.com> <1090864026.29589.1.camel@pegasus> <5F07F140-DF2E-11D8-B83A-00039390D626@pepper.com> <1090865790.29589.5.camel@pegasus> <76F28965-DF34-11D8-B83A-00039390D626@pepper.com> <1090875679.10807.1.camel@pegasus> <4B8C0D08-DF64-11D8-95A4-003065B218E0@pepper.com> <1090916301.4650.9.camel@pegasus> <ABD9E52C-DFDC-11D8-BE76-00039390D626@pepper.com> <1090940516.4845.19.camel@pegasus>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: multipart/mixed; boundary=Apple-Mail-1-964922949
Message-Id: <A9BDE398-DFDF-11D8-BE76-00039390D626@pepper.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
From: Michael Frey <mfrey@pepper.com>
Subject: Re: [Bluez-devel] HIDP backport for 2.4
Date: Tue, 27 Jul 2004 11:14:32 -0400
To: Marcel Holtmann <marcel@holtmann.org>
List-ID: <bluez-devel.lists.sourceforge.net>


--Apple-Mail-1-964922949
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed

Marcel,

Here we go:

root@(none):/usr/bin# hcitool inq
Inquiring ...
         00:02:72:40:8A:97       clock offset: 0x4a58    class: 0x002540

root@(none):/usr/bin# hcitool info 00:02:72:40:8A:97
Requesting information ...
bcsp_timed_event: Timeout, retransmitting 1 pkts
         BD Address:  00:02:72:40:8A:97
         Device Name: BlueLogic Keyboard
         LMP Version: 1.1 (0x1) LMP Subversion: 0x1a5
         Manufacturer: Cambridge Silicon Radio (10)
         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
                 <3-slot packets> <5-slot packets> <encryption> <slot 
offset>
                 <timing accuracy> <role switch> <hold mode> <sniff mode>
                 <park state> <RSSI> <channel quality> <SCO link> <HV2 
packets>
                 <HV3 packets> <u-law log> <A-law log> <CVSD> <paging 
scheme>
                 <power control> <transparent SCO>


The website is http://www.bluelogic.co.kr/main_eng.php

I have attached the sdp records file.

Michael

--Apple-Mail-1-964922949
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	x-unix-mode=0700;
	name="sdp_records.txt"
Content-Disposition: attachment;
	filename=sdp_records.txt

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
				UUID16 0x0011 - HIDP
				UINT16 0x0100
	Attribute 0x000d - Additional protocol descriptor lists
		Sequence
			Sequence
				UUID16 0x0100 - L2CAP
				UINT16 0x0013
			Sequence
				UUID16 0x0011 - HIDP
	Attribute 0x0200
		UINT16 0x0100
	Attribute 0x0201
		UINT16 0x0111
	Attribute 0x0202
		UINT8 0x40
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
				String 05 01 09 06 a1 01 85 01 05 07 19 e0 29 e7 15 00 25 01 75 01 95 08 81 02 95 01 75 08 81 01 95 05 75 01 05 08 19 01 29 05 91 02 95 01 75 03 91 01 95 05 75 08 15 00 25 65 05 07 19 00 29 ff 81 00 c0 05 01 09 02 a1 01 85 02 09 01 a1 00 05 09 19 01 29 03 15 00 25 01 95 03 75 01 81 02 95 01 75 05 81 01 05 01 09 30 09 31 09 38 15 81 25 7f 95 03 75 08 81 06 c0 c0 05 0c 09 01 a1 01 85 03 15 00 25 01 09 e9 09 ea 75 01 95 02 81 02 95 06 81 01 c0 05 01 09 80 a1 01 85 04 19 81 29 83 15 00 25 01 75 01 95 03 81 02 75 05 95 01 81 01 c0 05 0c 09 01 a1 01 85 05 95 08 75 01 15 00 25 01 0a 93 01 0a cd 00 0a b7 00 0a e2 00 0a ea 00 0a e9 00 0a 2a 02 0a 23 02 81 02 05 0c 0a 27 02 0a 8a 01 0a 26 02 15 00 25 01 95 03 75 01 81 02 95 05 75 01 81 01 c0
	Attribute 0x0207
		Sequence
			Sequence
				UINT16 0x0309
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

--Apple-Mail-1-964922949
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed



On Jul 27, 2004, at 11:01 AM, Marcel Holtmann wrote:

> Hi Michael,
>
>>> at the end of hidp_input_report() and see if this helps out for your
>>> keyboard and mouse problems. What do "hidd -l" say after you have
>>> connected the devices? What devices do you use?
>>
>> root@(none):~# hidd -l
>> 00:02:72:40:8A:97 HID Boot Device [0000:0000] connected
>>
>> I am using a Keyboard with integrated mouse.  So I guess it is
>> technically one device.  The mouse is a track ball embedded in the
>> keyboard.  The keyboard is made by BlueLogic.
>
> you should have said this earlier. Do you have a website for me? I need
> more information about this device. Please use sdptest from libs2 CVS
> repository to get the SDP record.
>
> 	./sdptest records 00:xx:xx:xx:xx:xx > sdp_record.txt
>
> Send me that file. I also need the information from "hcitool inq" and
> from "hcitool info" for that device.
>
> Regards
>
> Marcel
>

--Apple-Mail-1-964922949--
