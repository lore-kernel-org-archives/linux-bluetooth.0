Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Reply-To: ironyman13@gmail.com
In-Reply-To: <CABBYNZKk_D1mMAgWGCFB8WtTdWPPf01i4uBqd=8rSPf-fZde=Q@mail.gmail.com>
References: <CALEhDxQULJEJJO+gFvy6jK-sfKHcxa0gOJqn_r5AOZHr_O2pJA@mail.gmail.com>
 <CABBYNZKk_D1mMAgWGCFB8WtTdWPPf01i4uBqd=8rSPf-fZde=Q@mail.gmail.com>
From: changyu li <ironyman13@gmail.com>
Date: Tue, 26 Dec 2017 23:48:36 -0500
Message-ID: <CALEhDxR_PhncvFb-Woq_KQYu8ymSJ022uiu+HGtVAmaqgFgZYQ@mail.gmail.com>
Subject: Re: Question about HOG input devices
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I'm not customizing the report handling, rather customizing what
report is generated (if any is generated at all) from the mouse for
some keys. This is accomplished by sending a write request to some
attribute to the device, which is rather easy to do if it were not for
the restriction. Isn't it reasonable to expose some characteristics
used for configuration?

If I must create a driver for this, what kind do you mean? Do you mean
something like the wiimote driver in drivers/hid? Is there a way to
get the bluetooth socket associated with HID device (I have to send a
write request after all)?

Thank you

On Tue, Dec 26, 2017 at 8:20 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi,
>
> On 24 Dec 2017 04:45, "changyu li" <ironyman13@gmail.com> wrote:
>
> Hi,
>
> I would like to be able to configure my Bluetooth HOG mouse but its
> GATT characteristic used for configuration has no DBus interface
> associated with it.
>
> HOG services are not "external" and are marked as claimed in
> add_gatt_service. This prevents the characteristic from being
> exported.
>
>
> It is no external to prevent leaking user input over D-Bus, so it is working
> as intended. If you want to customize the report handling you will need to
> create a kernel driver.
>
>
>   if (!profile->external) {
>     /* Mark the service as claimed by the existing profile. */
>     gatt_db_service_set_claimed(attr, true);
>   }
>
> So I have a few questions,
>
> 1. What does external mean?
> 2. Is there another way to access the characteristic and configure the
> device?
> 3. If not, can we make the input-hog profile external?
>
> Thank you
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
