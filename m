Return-Path: <bluez@thomae-privat.de>
Message-ID: <40CE96A8.3020407@thomae-privat.de>
Date: Tue, 15 Jun 2004 08:26:48 +0200
From: Matthias Thomae <bluez@thomae-privat.de>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Epox Barton keyboard: HID create error 53
References: <40CDE18C.70703@thomae-privat.de> <1087255678.13792.51.camel@pegasus>
In-Reply-To: <1087255678.13792.51.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-users.lists.sourceforge.net>

Hi Marcel,

Marcel Holtmann wrote:
>>I am trying to connect a Epox Barton Keyboard to a Thinkpad R50 with 
>>internal bluetooth, Kernel 2.6.6-mh3 and debian bluez-utils 2.7-2.
>>
>>But I get:
>> > hidd --connect 00:04:61:XX:XX:XX
>>HID create error 53 (Invalid request descriptor)
>>
>>syslog says:
>>Jun 14 19:24:11 tyron hidd: New HID device 00:04:61:XX:XX:XX (Epox 
>>HIDEngine Keyboard)
>>
>>Tried with and without encryption, both failed. Any ideas?
> 
> 
> this is not an encryption problem. The HID parser can't interpret the
> HID report descriptor. I've seen the same problem with the new HID
> version of the presenter and actually I don't know why this happens. Do
> the mouse works?

Yes, the mouse works perfectly.
The keyboard does work with WinXP.

>> > hciconfig -a
>>hci0:	Type: USB
>>	BD Address: 00:20:E0:XX:XX:XX ACL MTU: 192:8  SCO MTU: 64:8
>>	UP RUNNING PSCAN
>>	RX bytes:2756580 acl:10594 sco:0 events:3821 errors:0
>>	TX bytes:443471 acl:4191 sco:0 commands:110 errors:0
>>	Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
>>	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>>	Link policy: RSWITCH HOLD SNIFF PARK
>>	Link mode: SLAVE ACCEPT
>>	Name: 'BlueTyron'
>>	Class: 0x000100
>>	Service Classes: Unspecified
>>	Device Class: Computer, Uncategorized
>>	HCI Ver: 1.1 (0x1) HCI Rev: 0x222 LMP Ver: 1.1 (0x1) LMP Subver: 0x222
>>	Manufacturer: Cambridge Silicon Radio (10)
> 
> 
> What kind of dongle is this?

This is the built-in bluetooth of the IBM Thinkpad R50, Model Number 
1829-7RG.

>> > hcitool info 00:04:61:XX:XX:XX
>>Requesting information ...
>>	BD Address:  00:04:61:XX:XX:XX
>>	Device Name: Bluetooth-Keyboard 817324
>>	LMP Version: 1.1 (0x1) LMP Subversion: 0x356
>>	Manufacturer: Cambridge Silicon Radio (10)
>>	Features: 0xff 0xff 0x0b 0x00 0x00 0x00 0x00 0x00
>>		<3-slot packets> <5-slot packets> <encryption> <slot offset>
>>		<timing accuracy> <role switch> <hold mode> <sniff mode>
>>		<park state> <RSSI> <channel quality> <SCO link> <HV2 packets>
>>		<HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme>
>>		<transparent SCO>
> 
> 
> Mine is much older, when do you bought it?

I bought it about 3 weeks ago, from www.bauers.com

Regards.
Matthias
