Return-Path: <cyrus@holtmann.org>
From: "Ganir, Chen" <chen.ganir@ti.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH v2 5/5] DeviceInfo: Read PNP ID
Date: Tue, 27 Mar 2012 06:36:21 +0000
Message-ID: <F0070FBC0FB3174D8D11444EB2D5B0260B4636CE@DNCE02.ent.ti.com>
References: <1332775508-32693-1-git-send-email-chen.ganir@ti.com>
	<1332775508-32693-6-git-send-email-chen.ganir@ti.com>
 <CAJdJm_NWjT=nfHc=rK=U2HMVg0cac4oDfnf2dTLF6h-=vYDmgg@mail.gmail.com>
In-Reply-To: <CAJdJm_NWjT=nfHc=rK=U2HMVg0cac4oDfnf2dTLF6h-=vYDmgg@mail.gmail.com>
Content-Type: text/plain; charset="windows-1255"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Lizardo,

> -----Original Message-----
> From: Anderson Lizardo [mailto:anderson.lizardo@openbossa.org]
> Sent: Monday, March 26, 2012 5:55 PM
> To: Ganir, Chen
> Cc: linux-bluetooth@vger.kernel.org
> Subject: Re: [PATCH v2 5/5] DeviceInfo: Read PNP ID
> 
> Hi Chen,
> 
> On Mon, Mar 26, 2012 at 11:25 AM,  <chen.ganir@ti.com> wrote:
> > diff --git a/src/device.c b/src/device.c
> > index 3b772ee..dad8c26 100644
> > --- a/src/device.c
> > +++ b/src/device.c
> > @@ -131,6 +131,7 @@ struct btd_device {
> >        gchar           *path;
> >        char            name[MAX_NAME_LENGTH + 1];
> >        char            *alias;
> > +       uint16_t        vendor_src;
> >        uint16_t        vendor;
> >        uint16_t        product;
> >        uint16_t        version;
> > @@ -377,6 +378,11 @@ static DBusMessage
> *get_properties(DBusConnection *conn,
> >                dict_append_entry(&dict, "Vendor", DBUS_TYPE_UINT16,
> >                                                        &device-
> >vendor);
> >
> > +       /* Vendor Source*/
> > +       if (device->vendor_src)
> > +               dict_append_entry(&dict, "VendorSource",
> DBUS_TYPE_UINT16,
> > +                                                       &device-
> >vendor_src);
> > +
> 
> * How does this work for BR/EDR devices (without GATT)? Is zero a
> valid value for these devices?

For BR/EDR, you may have either DID or DIS. None of the specs define what is the relationship between those on BR/EDR (since in theory you may have both at the same time), so no special code was added to handle such a situation. As far as I can see, in a GATT capable device, the DIS should replace the DID since it extends its capabilities, but this is totally vendor dependant.

Regarding default values, the spec does not specify valid range for product id and product version. Both for DID in BR/EDR and DIS in LE, those values are totally dependent on vendor implementation and have no limits.

For the Vendor ID Source, 0x0000 is a reserved for future use, and currently should not be used. 
A default value for nonexistent VID according to the DID spec is 0xFFF (the DIS spec does not define such a value).

The current device.c implementation was not changed, meaning that for the D-BUS interface, having a 0 value will remove the property from the dbus dictionary.

Do we want to change this behavior ? Maybe add a short bitmask field for existing fields ? What do you think ?
> 
> * You need to update doc/device-api.txt
> 
The only addition to the doc/device-api.txt is the addition of Vendroid ID Source. I'll add that and send a revised patch set.

> * Vendor Source looks like uint8, but you save it as uint16. Yes, I
> know there is no "uint8" for d-bus, but just wondering why "byte"
> cannot be used here.
> 
This is a difference between DID and DIS. DID defines the VID Source as 2 bytes, and DIS defines it as 1 byte. Anyway, I'll need to change the propery VendorID Source from byte to uint16 to allow both to be sent to the user. The btd_device_get_vendor_src already returns a uint16_t.

> Regards,
> --
> Anderson Lizardo
> Instituto Nokia de Tecnologia - INdT
> Manaus - Brazil
