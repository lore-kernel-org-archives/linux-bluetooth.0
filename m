Return-Path: <cyrus@holtmann.org>
Subject: Re: Inquiry_with_RSSI compatible dongles
From: Marcel Holtmann <marcel@holtmann.org>
To: Giedo Mak <giedomak@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <AANLkTinqj=v9CT4RvnekAymtvXL4rFGMGjr5HNjGwUsW@mail.gmail.com>
References: <AANLkTinU4+-Meyz_BmL+Lw-ESCR_NVhdu7esTE8wCWuc@mail.gmail.com>
	 <AANLkTinbYqYrFrJDCEm3U0Mto8fYJyQLDa8s0KB6T3qi@mail.gmail.com>
	 <AANLkTi=uuyRQ-9Qj1THDvOroE3yLU7ZBJS_tX26h0O4y@mail.gmail.com>
	 <1286264216.17473.17.camel@aeonflux>
	 <AANLkTinqj=v9CT4RvnekAymtvXL4rFGMGjr5HNjGwUsW@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 07 Oct 2010 11:42:43 +0200
Message-ID: <1286444563.6145.64.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Giedo,

> I got myself a brandless bluetooth 2.1 dongle (at least, that's what
> is says on the box).
> In hciconfig I got something about HCI version 2.0:
> 
>         HCI Version: 2.0 (0x3)  Revision: 0x44
>         LMP Version: 2.0 (0x3)  Subversion: 0x3
>         Manufacturer: Cambridge Silicon Radio (10)
> 
> Does that mean it is a BT 2.0 device?
> 
> I would like to ask a second question:
> When I put the device in inqmode 1, (the dongle has the feature
> inquiry with rssi; I checked with hciconfig hci0 features)
> 
>         Inquiry mode: Inquiry with RSSI
> 
> I get 'Inquiry result with RSSI'-events. But these events have a
> constant RSSI value.
> I would like know if this is a known bug, or if there is a setting I
> have to set.
> This is a little hcidump output:
> 
> > HCI Event: Inquiry Result with RSSI (0x22) plen 15
>   01 5C 07 D3 D7 23 00 01 02 04 02 5A 7E 70 00
> > HCI Event: Inquiry Result with RSSI (0x22) plen 15
>   01 1C 01 00 81 1F 00 01 02 04 01 02 40 7E 00
> > HCI Event: Inquiry Complete (0x01) plen 1
>   00
> > HCI Event: Inquiry Result with RSSI (0x22) plen 15
>   01 5C 07 D3 D7 23 00 01 02 04 02 5A 7E 70 00
> > HCI Event: Inquiry Result with RSSI (0x22) plen 15
>   01 89 99 66 D0 25 00 01 02 0C 02 5A 61 15 00
> > HCI Event: Inquiry Complete (0x01) plen 1
>   00
> > HCI Event: Inquiry Result with RSSI (0x22) plen 15
>   01 1C 01 00 81 1F 00 01 02 04 01 02 3F 7E 00
> > HCI Event: Inquiry Result with RSSI (0x22) plen 15
>   01 5C 07 D3 D7 23 00 01 02 04 02 5A 7D 70 00
> > HCI Event: Inquiry Result with RSSI (0x22) plen 15
>   01 89 99 66 D0 25 00 01 02 0C 02 5A 61 15 00
> > HCI Event: Inquiry Complete (0x01) plen 1
>   00
> 
> If I'm correct the RSSI value should be the last octet, which is always 0.
> 
> I've tested also with another bluetooth dongle, this was a 2.0 BT
> dongle also with the inquiry with rssi feature. That dongle gave me
> (valid) RSSI values in the returned events between -40 and -90.
> 
> The last dongle is not longer in my possession, so I would like to fix
> the first one.

you just got a bad dongle. Some claim RSSI reporting support, but never
do anything like that. Proper hardware will look like this:

> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:21:86:47:51:B9 mode 1 clkoffset 0x47f6 class 0x00010c rssi -84
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:16:CF:D7:DD:72 mode 1 clkoffset 0x5662 class 0x00010c rssi -85
> HCI Event: Extended Inquiry Result (0x2f) plen 255
    bdaddr D8:54:3A:7E:9C:9A mode 1 clkoffset 0x2d71 class 0x5a020c rssi -57
    Complete local name: 'Nokia'
    Complete service classes: 0x1112 0x111f 0x110a 0x110c 0x110e 0x1103 0x1105 0x1106 0x112f

Regards

Marcel


