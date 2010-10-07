Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1286264216.17473.17.camel@aeonflux>
References: <AANLkTinU4+-Meyz_BmL+Lw-ESCR_NVhdu7esTE8wCWuc@mail.gmail.com>
 <AANLkTinbYqYrFrJDCEm3U0Mto8fYJyQLDa8s0KB6T3qi@mail.gmail.com>
 <AANLkTi=uuyRQ-9Qj1THDvOroE3yLU7ZBJS_tX26h0O4y@mail.gmail.com> <1286264216.17473.17.camel@aeonflux>
From: Giedo Mak <giedomak@gmail.com>
Date: Thu, 7 Oct 2010 11:34:16 +0200
Message-ID: <AANLkTinqj=v9CT4RvnekAymtvXL4rFGMGjr5HNjGwUsW@mail.gmail.com>
Subject: Re: Inquiry_with_RSSI compatible dongles
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

2010/10/5 Marcel Holtmann <marcel@holtmann.org>
>
> Hi Giedo,
>
> > I'm working on a bluetooth program with some sort of distance sensing/tracking.
> > To make this easier I came across a feature called inquiry_with_RSSI.
> > Could somebody tell me what kind of dongles support this feature. I
> > mean, does every 2.1 BT dongle support it, or can you only find out
> > once you get one in your hands?
>
> in general every Bluetooth 1.2 dongle and later should support Inquiry
> with RSSI. I still have to come across a 2.1 dongle that doesn't.
>
> Regards
>
> Marcel
>

Hello Marcel,

Thanks for your fast response.

I got myself a brandless bluetooth 2.1 dongle (at least, that's what
is says on the box).
In hciconfig I got something about HCI version 2.0:

        HCI Version: 2.0 (0x3)  Revision: 0x44
        LMP Version: 2.0 (0x3)  Subversion: 0x3
        Manufacturer: Cambridge Silicon Radio (10)

Does that mean it is a BT 2.0 device?

I would like to ask a second question:
When I put the device in inqmode 1, (the dongle has the feature
inquiry with rssi; I checked with hciconfig hci0 features)

        Inquiry mode: Inquiry with RSSI

I get 'Inquiry result with RSSI'-events. But these events have a
constant RSSI value.
I would like know if this is a known bug, or if there is a setting I
have to set.
This is a little hcidump output:

> HCI Event: Inquiry Result with RSSI (0x22) plen 15
  01 5C 07 D3 D7 23 00 01 02 04 02 5A 7E 70 00
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
  01 1C 01 00 81 1F 00 01 02 04 01 02 40 7E 00
> HCI Event: Inquiry Complete (0x01) plen 1
  00
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
  01 5C 07 D3 D7 23 00 01 02 04 02 5A 7E 70 00
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
  01 89 99 66 D0 25 00 01 02 0C 02 5A 61 15 00
> HCI Event: Inquiry Complete (0x01) plen 1
  00
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
  01 1C 01 00 81 1F 00 01 02 04 01 02 3F 7E 00
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
  01 5C 07 D3 D7 23 00 01 02 04 02 5A 7D 70 00
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
  01 89 99 66 D0 25 00 01 02 0C 02 5A 61 15 00
> HCI Event: Inquiry Complete (0x01) plen 1
  00

If I'm correct the RSSI value should be the last octet, which is always 0.

I've tested also with another bluetooth dongle, this was a 2.0 BT
dongle also with the inquiry with rssi feature. That dongle gave me
(valid) RSSI values in the returned events between -40 and -90.

The last dongle is not longer in my possession, so I would like to fix
the first one.

Regards,
Giedo
