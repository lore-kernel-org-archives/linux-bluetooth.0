Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZL_DjeOGbbFKmavUY1QRMNb1V2KrBbNHZ2bH=hZ6q5vNg@mail.gmail.com>
References: <CAEZxfGPDdgjcSwS6vK46Q4tMwdoD=SjV-te8chiERM-wnEP00w@mail.gmail.com>
 <CABBYNZ+GMyT8z8ujGGu3oMK1ffkdAuX21ZRu7Cf7eFpqS0jHuw@mail.gmail.com>
 <CAEZxfGMY5L=gcDczjUoM6Yg3m9z+LObByFgnAy0u7duyu+v-tg@mail.gmail.com> <CABBYNZL_DjeOGbbFKmavUY1QRMNb1V2KrBbNHZ2bH=hZ6q5vNg@mail.gmail.com>
From: =?UTF-8?Q?Fran=C3=A7ois_Beaufort?= <beaufort.francois@gmail.com>
Date: Wed, 30 Sep 2015 16:43:59 +0200
Message-ID: <CAEZxfGMNJKc3kW+isa8LofrLCuWFBaPvyAiiw5X_0ZBLsrTDgQ@mail.gmail.com>
Subject: Re: Disabling deviceinfo plugin on chromebooks?
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Sep 30, 2015 at 4:24 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi François,
>
> On Wed, Sep 30, 2015 at 4:54 PM, François Beaufort
> <beaufort.francois@gmail.com> wrote:
>> Thanks for your answer Luiz!
>
> Please comment inline in the ml.
>
>> From what I can see, Android and iOS Bluetooth Stack libraries don't
>> claim the device_information service.
>> Could it be possible to make it so that the plugin doesn't block other
>> clients (such as the Web Bluetooth API) from interacting with that
>> service.
>
> That probably a bad behavior in their own because it can only cause
> more traffic as this information can be cached and made available
> without causing any extra traffic, as I said I think we just need to
> expose the extra information over the device API, so we just have to
> add them here:
>
> https://webbluetoothcg.github.io/web-bluetooth/#bluetoothdevice (note
> that it already contains part of device information)
>

As these characteristics might not be useful to everyone, I'm not sure
about the benefit of caching all these device_information service
characteristics in Bluez and exposing them to the bluetooth device
object.
>From a web developer point of view, I think I want to get back as
quick as possible the bluetooth device object and get characteristics
afterwards when I need to.

>> Also, do you know if other services (like device_information) are
>> blocked/claimed by other plugins?
>
> iirc GAP, GATT and HoG services are claimed by bluetoothd, and the
> fact that we claim these services is on purpose so applications cannot
> make conflicting changes or cause unnecessary traffic.
>

Thank you!

>> On Tue, Sep 22, 2015 at 12:05 PM Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>>>
>>> Hi François,
>>>
>>> On Tue, Sep 22, 2015 at 11:41 AM, François Beaufort
>>> <beaufort.francois@gmail.com> wrote:
>>> > As the chromium team is building and testing the Web Bluetooth API to
>>> > let websites discover and interact with nearby Bluetooth devices
>>> > (https://developers.google.com/web/updates/2015/07/interact-with-ble-devices-on-the-web)
>>> > I would love to be able to access the Device Information Service
>>> > characteristics such as Serial Number String, Hardware Revision String
>>> > and so forth.
>>>
>>> Looks like we don't parse these characteristics just PnP ID which is
>>> expose via Modalias property that has the information of product id
>>> and vendor id, etc.
>>>
>>> > Sadly, from what I understood, this is not achievable for now on
>>> > Chromeboooks since Bluez comes with the deviceinfo plugin enabled by
>>> > default. I do wonder now what would be the implications of disabling
>>> > the deviceinfo plugin?
>>>
>>> The way it works is that the plugin claims this service which prevent
>>> it to be accessible over D-Bus, you could in theory disable the plugin
>>> but I think we would benefit more if we add support for the missing
>>> information directly in BlueZ saving each application the trouble to
>>> read this information themselves.
>>>
>>> If I would do it in BlueZ Id probably add them as properties to
>>> org.bluez.Device1 and make sure we store them as we do with PnP ID.
>>>
>>> > You will find more information at
>>> > https://code.google.com/p/chromium/issues/detail?id=532930
>>> >
>>> > Thank you in advance,
>>> > Francois - a daily Bluez user.
>>> > --
>>> > To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>>> > the body of a message to majordomo@vger.kernel.org
>>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>>>
>>> --
>>> Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz
