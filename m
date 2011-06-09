Return-Path: <cyrus@holtmann.org>
Subject: Re: Support for 0489:e031 Foxconn / Hon Hai
From: Marcel Holtmann <marcel@holtmann.org>
To: thilo@cestona.ro
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 09 Jun 2011 12:21:55 +0200
In-Reply-To: <e129a66.cdc6126ce9358686b94e118b08a130aa@1oca1host.de>
References: <e129a66.cdc6126ce9358686b94e118b08a130aa@1oca1host.de>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1307614916.2589.34.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Thilo,

> This does look better now, right?
> T:  Bus=02 Lev=02 Prnt=02 Port=03 Cnt=03 Dev#= 11 Spd=12  MxCh= 0
> D:  Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=0489 ProdID=e031 Rev=01.12
> S:  Manufacturer=Broadcom Corp
> S:  Product=BCM20702A0
> S:  SerialNumber=EC55F9EADE09
> C:  #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=0mA
> I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
> I:  If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
> I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
> I:  If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)
> 
> but the two last lines still have no driver. Is this a problem?

that is fine. They are some Broadcom specific endpoint and the firmware
update endpoint. No need to have the btusb driver attach to it. It only
uses the first two endpoints.

> Here is the output of hciconfig hci0 -a:
> $ hciconfig hci0 -a
> hci0:	Type: BR/EDR  Bus: USB
> 	BD Address: EC:55:F9:EA:DE:09  ACL MTU: 1021:8  SCO MTU: 64:1
> 	UP RUNNING PSCAN ISCAN 
> 	RX bytes:5947 acl:0 sco:0 events:198 errors:0
> 	TX bytes:1986 acl:0 sco:0 commands:117 errors:0
> 	Features: 0xff 0xff 0x8f 0xfe 0xdb 0xff 0x7b 0x87
> 	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
> 	Link policy: RSWITCH HOLD SNIFF PARK 
> 	Link mode: SLAVE ACCEPT 
> 	Name: 'abg4858n-lnx'
> 	Class: 0x4a0100
> 	Service Classes: Networking, Capturing, Telephony
> 	Device Class: Computer, Uncategorized
> 	HCI Version: 4.0 (0x6)  Revision: 0x0
> 	LMP Version: 4.0 (0x6)  Subversion: 0x2118
> 	Manufacturer: Broadcom Corporation (15)
> 
> Looks ok isn't it?

Yes, and getting a nice Low-Energy capable dongle is great. Where did
you get this from? I like to get a bunch of these for testing.

> But I can't add any devices. When I search for devices VERY long, I can find one or two. But only devices which I can't pair with.
> e.g. I never found my headset, altought it is in pairing mode when I start searching.
> 
> During search, hcidump -v shows only this:
> > HCI Event: Inquiry Complete (0x01) plen 1
>     status 0x00
> > HCI Event: Inquiry Complete (0x01) plen 1
>     status 0x00
> > HCI Event: Inquiry Complete (0x01) plen 1
>     status 0x00
> > HCI Event: Inquiry Complete (0x01) plen 1
>     status 0x00
> > HCI Event: Inquiry Complete (0x01) plen 1
>     status 0x00
> > HCI Event: Inquiry Complete (0x01) plen 1
>     status 0x00
> > HCI Event: Inquiry Complete (0x01) plen 1
>     status 0x00
> > HCI Event: Inquiry Complete (0x01) plen 1
>     status 0x00
> > HCI Event: Inquiry Complete (0x01) plen 1
>     status 0x00
> 
> so no problem here too.
> 
> Any suggestions what I could try next? Anything which could give me informations whats going wrong here?

Maybe the antenna is kinda wrongly calibrated, but I can't tell any
details here. That is hardware specific.

Regards

Marcel


