Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CA+GuLwdbSoT-iZg9EjTbxidr+fEE-KU8qgOZAyr_h05Gq9Xrgg@mail.gmail.com>
References: <CA+GuLwdbSoT-iZg9EjTbxidr+fEE-KU8qgOZAyr_h05Gq9Xrgg@mail.gmail.com>
Date: Thu, 18 Aug 2011 20:28:27 +0200
Message-ID: <CAPGrrxXH4YD3ACuTvH+_JjJ1UZUnAues1cBs7qDZZgCSN_JYJA@mail.gmail.com>
Subject: Re: need help with bluez pairing/connecting device
From: Bartosz Szatkowski <bulislaw@linux.com>
To: Ram Bhamidipaty <rambham@gmail.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Aug 18, 2011 at 7:53 PM, Ram Bhamidipaty <rambham@gmail.com> wrote:
> I am writing some new software that talks to bluez-4.96.
>
> I have some how gotten a device into a weird state. When I make
> a dbus call to org.bluez.Adapter.GetProperties
> I see my target device in the list:
>
>       dict entry(
>         string "Devices"
>         variant             array [
>               object path "/org/bluez/8090/hci0/dev_00_22_48_85_50_1D"
>            ]
>      )
>
>
> When a device is listed here - what does it mean? I am guessing that
> at this point the pairing process is over. Or does it mean something else?
>
> However the device is not yet connected. So I next try to connect:
>
> dbus-send --system --type=method_call --print-reply --dest=org.bluez
> /org/bluez/8090/hci0/dev_00_22_48_85_50_1D org.bluez.Input.Connect
>
> This fails with a cryptic:
>
> Error org.bluez.Error.Failed: Host is down (112)
>
> Any help is appreciated.
> -Ram
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

You may find usesful looking at bluez/test/*
(http://git.kernel.org/?p=bluetooth/bluez.git;a=tree;f=test;h=071a5b5ef0ccb29aa607d5d60089b7aa6c349e98;hb=HEAD),
there is lots of examples how to use dbus api.

-- 
Pozdrowienia,
Bartosz Szatkowski
