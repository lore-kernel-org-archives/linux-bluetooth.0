Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Gix, Brian" <brian.gix@intel.com>
To: "Gix, Brian" <brian.gix@intel.com>,
        Lukasz Rymanowski <lukasz.rymanowski@codecoup.pl>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH BlueZ 1/3] mesh: Fix for handling unprovisioned device
Date: Thu, 31 Aug 2017 23:51:01 +0000
Message-ID: <DEBB0CAA2616974FAE35E4B560B9A4373E1D2AFE@ORSMSX103.amr.corp.intel.com>
References: <20170831101257.1644-1-lukasz.rymanowski@codecoup.pl>
 <DEBB0CAA2616974FAE35E4B560B9A4373E1D2A2F@ORSMSX103.amr.corp.intel.com>
In-Reply-To: <DEBB0CAA2616974FAE35E4B560B9A4373E1D2A2F@ORSMSX103.amr.corp.intel.com>
Content-Type: text/plain; charset="iso-8859-2"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a good fix and should be accepted.

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Gix, Brian
> Sent: Thursday, August 31, 2017 4:12 PM
> To: Lukasz Rymanowski <lukasz.rymanowski@codecoup.pl>; linux-
> bluetooth@vger.kernel.org
> Subject: RE: [PATCH BlueZ 1/3] mesh: Fix for handling unprovisioned device
> 
> An unprovisioned device that does not advertise the ServiceData for an
> Unprovisioned Mesh Device does not comply with the specification.  The
> Service Data is the required method for an unprovisioned device to be
> recognized.
> 
> > -----Original Message-----
> > From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> > owner@vger.kernel.org] On Behalf Of Lukasz Rymanowski
> > Sent: Thursday, August 31, 2017 3:13 AM
> > To: linux-bluetooth@vger.kernel.org
> > Cc: £ukasz Rymanowski <lukasz.rymanowski@codecoup.pl>
> > Subject: [PATCH BlueZ 1/3] mesh: Fix for handling unprovisioned device
> >
> > If there is no ServiceData there is no valid provisioning data for
> > PB-GATT
> > ---
> >  mesh/main.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mesh/main.c b/mesh/main.c index b06f4352a..2289d7d10
> > 100644
> > --- a/mesh/main.c
> > +++ b/mesh/main.c
> > @@ -503,7 +503,7 @@ static bool parse_service_data(GDBusProxy *proxy,
> > const char *target_uuid,
> >  	}
> >
> >  	if (!g_dbus_proxy_get_property(proxy, "ServiceData", &iter))
> > -		return true;
> > +		return false;
> >
> >  	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY)
> >  		return false;
> > --
> > 2.11.0
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe
> > linux-bluetooth" in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html
