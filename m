Return-Path: <cyrus@holtmann.org>
From: "Ganir, Chen" <chen.ganir@ti.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH v2 5/5] DeviceInfo: Read PNP ID
Date: Tue, 27 Mar 2012 10:42:20 +0000
Message-ID: <F0070FBC0FB3174D8D11444EB2D5B0260B4647FC@DNCE02.ent.ti.com>
References: <1332775508-32693-1-git-send-email-chen.ganir@ti.com>
	<1332775508-32693-6-git-send-email-chen.ganir@ti.com>
	<CAJdJm_NWjT=nfHc=rK=U2HMVg0cac4oDfnf2dTLF6h-=vYDmgg@mail.gmail.com>
	<F0070FBC0FB3174D8D11444EB2D5B0260B4636CE@DNCE02.ent.ti.com>
 <CAJdJm_NFFcwFVWombYco49CCu-Y7gugB5Eg0dBSjDTm8PvpHog@mail.gmail.com>
In-Reply-To: <CAJdJm_NFFcwFVWombYco49CCu-Y7gugB5Eg0dBSjDTm8PvpHog@mail.gmail.com>
Content-Type: text/plain; charset="windows-1255"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Lizardo, 

> -----Original Message-----
> From: Anderson Lizardo [mailto:anderson.lizardo@openbossa.org]
> Sent: Tuesday, March 27, 2012 12:39 PM
> To: Ganir, Chen
> Cc: linux-bluetooth@vger.kernel.org
> Subject: Re: [PATCH v2 5/5] DeviceInfo: Read PNP ID
> 
> Hi Chen,
> 
> 2012/3/27 Ganir, Chen <chen.ganir@ti.com>:
> >> > +       /* Vendor Source*/
> >> > +       if (device->vendor_src)
> >> > +               dict_append_entry(&dict, "VendorSource",
> >> DBUS_TYPE_UINT16,
> >> > +                                                       &device-
> >> >vendor_src);
> >> > +
> >>
> >> * How does this work for BR/EDR devices (without GATT)? Is zero a
> >> valid value for these devices?
> >
> > For BR/EDR, you may have either DID or DIS. None of the specs define
> what is the relationship between those on BR/EDR (since in theory you
> may have both at the same time), so no special code was added to handle
> such a situation. As far as I can see, in a GATT capable device, the
> DIS should replace the DID since it extends its capabilities, but this
> is totally vendor dependant.
> >
> > Regarding default values, the spec does not specify valid range for
> product id and product version. Both for DID in BR/EDR and DIS in LE,
> those values are totally dependent on vendor implementation and have no
> limits.
> >
> > For the Vendor ID Source, 0x0000 is a reserved for future use, and
> currently should not be used.
> > A default value for nonexistent VID according to the DID spec is
> 0xFFF (the DIS spec does not define such a value).
> >
> > The current device.c implementation was not changed, meaning that for
> the D-BUS interface, having a 0 value will remove the property from the
> dbus dictionary.
> >
> > Do we want to change this behavior ? Maybe add a short bitmask field
> for existing fields ? What do you think ?
> 
> I was more worried about what happens on BR/EDR case (with GATT
> disabled), but with your explanation, I believe there is no issue on
> this part.
> 
> Regarding DID vs. DIS, I think at least the information needs to be
> stored/managed on a single place. It is very unlikely that some vendor
> will use conflicting information on these services.
> 
This will not happen, since I'm using the same mechanism for storing the PNP_ID data both for DID and DIS (in btd_device and in the persistent storage) using the existing API's. I also added a new API specific for DIS, which uses the existing DID API internally.


> Regards,
> --
> Anderson Lizardo
> Instituto Nokia de Tecnologia - INdT
> Manaus - Brazil



Thanks,
Chen Ganir

