Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1332775508-32693-6-git-send-email-chen.ganir@ti.com>
References: <1332775508-32693-1-git-send-email-chen.ganir@ti.com>
	<1332775508-32693-6-git-send-email-chen.ganir@ti.com>
Date: Mon, 26 Mar 2012 11:54:49 -0400
Message-ID: <CAJdJm_NWjT=nfHc=rK=U2HMVg0cac4oDfnf2dTLF6h-=vYDmgg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] DeviceInfo: Read PNP ID
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: chen.ganir@ti.com
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,

On Mon, Mar 26, 2012 at 11:25 AM,  <chen.ganir@ti.com> wrote:
> diff --git a/src/device.c b/src/device.c
> index 3b772ee..dad8c26 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -131,6 +131,7 @@ struct btd_device {
>        gchar           *path;
>        char            name[MAX_NAME_LENGTH + 1];
>        char            *alias;
> +       uint16_t        vendor_src;
>        uint16_t        vendor;
>        uint16_t        product;
>        uint16_t        version;
> @@ -377,6 +378,11 @@ static DBusMessage *get_properties(DBusConnection *conn,
>                dict_append_entry(&dict, "Vendor", DBUS_TYPE_UINT16,
>                                                        &device->vendor);
>
> +       /* Vendor Source*/
> +       if (device->vendor_src)
> +               dict_append_entry(&dict, "VendorSource", DBUS_TYPE_UINT16,
> +                                                       &device->vendor_src);
> +

* How does this work for BR/EDR devices (without GATT)? Is zero a
valid value for these devices?

* You need to update doc/device-api.txt

* Vendor Source looks like uint8, but you save it as uint16. Yes, I
know there is no "uint8" for d-bus, but just wondering why "byte"
cannot be used here.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
