Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Message-ID: <70c3591.c7ad04bfd88fbba33e950f8f2a7c3fd4@1oca1host.de>
From: thilo@cestona.ro
To: "Marcel Holtmann" <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: AW: Re: Support for 0489:e031 Foxconn / Hon Hai
Date: Thu, 9 Jun 2011 13:45:44 +0200 (CEST)
Content-Type: text/plain;
	charset="utf-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hey Marcel,

>> Here is the output of hciconfig hci0 -a:
>> $ hciconfig hci0 -a
>> hci0:=09Type: BR/EDR  Bus: USB
>> =09BD Address: EC:55:F9:EA:DE:09  ACL MTU: 1021:8  SCO MTU: 64:1
>> =09UP RUNNING PSCAN ISCAN 
>> =09RX bytes:5947 acl:0 sco:0 events:198 errors:0
>> =09TX bytes:1986 acl:0 sco:0 commands:117 errors:0
>> =09Features: 0xff 0xff 0x8f 0xfe 0xdb 0xff 0x7b 0x87
>> =09Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
>> =09Link policy: RSWITCH HOLD SNIFF PARK 
>> =09Link mode: SLAVE ACCEPT 
>> =09Name: 'abg4858n-lnx'
>> =09Class: 0x4a0100
>> =09Service Classes: Networking, Capturing, Telephony
>> =09Device Class: Computer, Uncategorized
>> =09HCI Version: 4.0 (0x6)  Revision: 0x0
>> =09LMP Version: 4.0 (0x6)  Subversion: 0x2118
>> =09Manufacturer: Broadcom Corporation (15)
>> 
>> Looks ok isn't it?
>
>Yes, and getting a nice Low-Energy capable dongle is great. Where did
>you get this from? I like to get a bunch of these for testing.

It's build-in into the Lifebook E751 of Fujitsu (when ordered with Bluet=
ooth).
The product page for the E751: http://lifebook.uk.ts.fujitsu.com/Product=
s/Performance/LIFEBOOK-E751.htm
More an advertisment page ;) ... and the only thing about Bluetooth is t=
his sentence: "Ultimate connectivity with optional embedded 3G/UMTS, WLA=
N and Bluetooth=C2=AE"

>> But I can't add any devices. When I search for devices VERY long, I c=
an find one or two. But only devices which I can't pair with.
>> e.g. I never found my headset, altought it is in pairing mode when I =
start searching.
>> 
>> During search, hcidump -v shows only this:
>> > HCI Event: Inquiry Complete (0x01) plen 1
>>     status 0x00
>> > HCI Event: Inquiry Complete (0x01) plen 1
>>     status 0x00
>> > HCI Event: Inquiry Complete (0x01) plen 1
>>     status 0x00
>> > HCI Event: Inquiry Complete (0x01) plen 1
>>     status 0x00
>> > HCI Event: Inquiry Complete (0x01) plen 1
>>     status 0x00
>> > HCI Event: Inquiry Complete (0x01) plen 1
>>     status 0x00
>> > HCI Event: Inquiry Complete (0x01) plen 1
>>     status 0x00
>> > HCI Event: Inquiry Complete (0x01) plen 1
>>     status 0x00
>> > HCI Event: Inquiry Complete (0x01) plen 1
>>     status 0x00
>> 
>> so no problem here too.
>> 
>> Any suggestions what I could try next? Anything which could give me i=
nformations whats going wrong here?
>
>Maybe the antenna is kinda wrongly calibrated, but I can't tell any
>details here. That is hardware specific.

So you think it's not connected correctly or what means wrongly calibrat=
ed?
Perhaps I can give it a try via Virtualbox under windows ... 

Ciao
Thilo
