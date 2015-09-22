Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAEZxfGPDdgjcSwS6vK46Q4tMwdoD=SjV-te8chiERM-wnEP00w@mail.gmail.com>
References: <CAEZxfGPDdgjcSwS6vK46Q4tMwdoD=SjV-te8chiERM-wnEP00w@mail.gmail.com>
Date: Tue, 22 Sep 2015 13:05:40 +0300
Message-ID: <CABBYNZ+GMyT8z8ujGGu3oMK1ffkdAuX21ZRu7Cf7eFpqS0jHuw@mail.gmail.com>
Subject: Re: Disabling deviceinfo plugin on chromebooks?
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?UTF-8?Q?Fran=C3=A7ois_Beaufort?= <beaufort.francois@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi François,

On Tue, Sep 22, 2015 at 11:41 AM, François Beaufort
<beaufort.francois@gmail.com> wrote:
> As the chromium team is building and testing the Web Bluetooth API to
> let websites discover and interact with nearby Bluetooth devices
> (https://developers.google.com/web/updates/2015/07/interact-with-ble-devices-on-the-web)
> I would love to be able to access the Device Information Service
> characteristics such as Serial Number String, Hardware Revision String
> and so forth.

Looks like we don't parse these characteristics just PnP ID which is
expose via Modalias property that has the information of product id
and vendor id, etc.

> Sadly, from what I understood, this is not achievable for now on
> Chromeboooks since Bluez comes with the deviceinfo plugin enabled by
> default. I do wonder now what would be the implications of disabling
> the deviceinfo plugin?

The way it works is that the plugin claims this service which prevent
it to be accessible over D-Bus, you could in theory disable the plugin
but I think we would benefit more if we add support for the missing
information directly in BlueZ saving each application the trouble to
read this information themselves.

If I would do it in BlueZ Id probably add them as properties to
org.bluez.Device1 and make sure we store them as we do with PnP ID.

> You will find more information at
> https://code.google.com/p/chromium/issues/detail?id=532930
>
> Thank you in advance,
> Francois - a daily Bluez user.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
