Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <9CFEE4B0-5A6B-4153-BB3B-2CDF13955E2C@gmail.com>
References: <CAM4OqtDier-LrdJymk5npiGvZcvj7rsaGsrJwv+tz1o+kCoFcw@mail.gmail.com>
 <1BE3F300-B719-44E3-971F-5015C5F65A78@holtmann.org> <CAM4OqtDb6cm18Eqs=+rJrt7a-h0N=j+s-jPEUc1c4rHwGDbYqQ@mail.gmail.com>
 <49A36183-9C83-43B4-B462-3838E28E21C9@holtmann.org> <CAO1O6scU_WUU5KVVnUuC8YD5CWa+Spn24_7f_s8O3b2rLDBnAw@mail.gmail.com>
 <9AE508C4-7C2E-4126-AF76-DC551C6142D4@holtmann.org> <9CFEE4B0-5A6B-4153-BB3B-2CDF13955E2C@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 12 Jan 2017 14:44:08 +0200
Message-ID: <CABBYNZL7mrxJfx_R0bi1ZyDwtFNMA09gXMGtX8VbmSKmunK9Hw@mail.gmail.com>
Subject: Re: 5.43 Experimental Status?
To: Travis Griggs <travisgriggs@gmail.com>
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Travis,

On Thu, Jan 12, 2017 at 12:38 AM, Travis Griggs <travisgriggs@gmail.com> wr=
ote:
> I=E2=80=99m trying to bring my linux SBC acting as a peripheral up to deb=
ian stretch. I had been running on jessie, with my own build of bluez 5.41.=
 I had been modifying the bluetooth.service to execute:
>
>     /usr/lib/bluetooth/bluetoothd -d -E --noplugin=3D*
>
> The latest stretch/testing bluez seems to be 5.43 though:
>
>     dpkg -l | grep bluez
>     ii  bluez                         5.43-1                   armhf     =
   Bluetooth tools and daemons
>
> I thought the -E flag was supposed to no longer be necessary after 5.42. =
So I removed it. I updated my own python code to match the small changes I =
found in example-advertisement. But I=E2=80=99m getting the following error=
:
>
>     ERROR:dbus.connection:Unable to set arguments (dbus.ObjectPath('/nels=
on_irrigation/twig_pilot'), {}) according to signature None: <class 'ValueE=
rror'>: Unable to guess signature from an empty dict

Well RegisterAdvertisement is still using
GDBUS_EXPERIMENTAL_ASYNC_METHOD, what has been marked as stable is the
GATT APIs so for advertisement you still need -E.

> Which after googling, was the same error I found a while back when I had =
forgotten to turn -E on with 5.40.
>
> So I added the -E back in and it started working as hoped.
>
> Can someone explain why the -E is still needed with 5.43, for dbus code l=
ike that found in the test/examples? Did it not really get promoted after a=
ll? Or did I misunderstand the semantics of what was changing?--
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Luiz Augusto von Dentz
