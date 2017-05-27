Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABdDuZ0vRS=xkvaXTr7Fax_MxR5hxX4j-mok-ck7c-ZdSv9Vug@mail.gmail.com>
References: <CABdDuZ0vRS=xkvaXTr7Fax_MxR5hxX4j-mok-ck7c-ZdSv9Vug@mail.gmail.com>
From: Barry Byford <31baz66@gmail.com>
Date: Sat, 27 May 2017 07:57:56 +0100
Message-ID: <CAAu3APbVrzjXD9ujbvq7=BinsNKTq46NVHz7gW44jOazcqrJJA@mail.gmail.com>
Subject: Re: Questions about GATT server example in /test/example-gatt-server.py
 - Generice access service can't be overidden
To: Josh Van Tol <josh@afdengineering.com>
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Josh,

On 24 May 2017 at 23:28, Josh Van Tol <josh@afdengineering.com> wrote:
> I'm trying to build a custom device using BlueZ, and have been using
> the examples and tests that are included with BlueZ as a starting
> point.
>
> The problem I'm running into is that I'd like to provide my own
> implementation of the Generic Access Service (UUID '1800') but I get
> the error:
> Failed to register application: org.bluez.Error.Failed: Failed to
> create entry in database

This is a reserved UUID with a specific purpose and you shouldn't need
to redefine it:
https://www.bluetooth.com/specifications/gatt/viewer?attributeXmlFile=org.bluetooth.service.generic_access.xml

On BlueZ I think many of these values are set with values in
/etc/bluetooth/main.conf

>
> I would presume that this is because there's already such a service
> registered. Can anyone give me a pointer as to the proper way to
> un-register the existing service (or prevent it from being installed)?

If you are creating something custom then you might find this an
interesting read:
https://www.bluetooth.com/specifications/profiles-overview/creating-custom-profiles


>
> Regards,
> Josh van Tol
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
