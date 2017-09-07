Return-Path: <robh@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1BC8D5B0-EC18-4F20-9CBC-D73CB1765683@holtmann.org>
References: <1504786214-1866-1-git-send-email-frederic.danis.oss@gmail.com>
 <1504786214-1866-2-git-send-email-frederic.danis.oss@gmail.com> <1BC8D5B0-EC18-4F20-9CBC-D73CB1765683@holtmann.org>
From: Rob Herring <robh@kernel.org>
Date: Thu, 7 Sep 2017 12:54:14 -0500
Message-ID: <CAL_JsqK9ucGbg=_0Uu8Pugxd7N4gCYHrb4W3PyKaBq_12TdNYA@mail.gmail.com>
Subject: Re: [RFC 1/3] serdev: Add ACPI support
To: Marcel Holtmann <marcel@holtmann.org>
Cc: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis.oss@gmail.com>,
	Sebastian Reichel <sre@kernel.org>, Loic Poulain <loic.poulain@gmail.com>,
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Sep 7, 2017 at 12:21 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Fred,
>
>> Signed-off-by: Fr=C3=A9d=C3=A9ric Danis <frederic.danis.oss@gmail.com>
>> ---
>> drivers/tty/serdev/core.c | 99 +++++++++++++++++++++++++++++++++++++++++=
+++---
>> 1 file changed, 94 insertions(+), 5 deletions(-)

[...]

>> @@ -404,9 +488,14 @@ int serdev_controller_add(struct serdev_controller =
*ctrl)
>>       if (ret)
>>               return ret;
>>
>> -     ret =3D of_serdev_register_devices(ctrl);
>> -     if (ret)
>> +     ret_of =3D of_serdev_register_devices(ctrl);
>> +     ret_acpi =3D acpi_serdev_register_devices(ctrl);
>> +     if (ret_of && ret_acpi) {
>> +             dev_dbg(&ctrl->dev, "serdev%d no devices registered: of:%d=
 acpi:%d\n",
>> +                     ctrl->nr, ret_of, ret_acpi);
>> +             ret =3D -ENODEV;
>>               goto out_dev_del;
>> +     }
>>
>>       dev_dbg(&ctrl->dev, "serdev%d registered: dev:%p\n",
>>               ctrl->nr, &ctrl->dev);
>
> Shouldn=E2=80=99t we just consider to always register the controller? Eve=
n if there are no devices attached to it.

You argued for the opposite at least in regards to a serdev ldisc. :)
The problem is we use the success or failure here to decide if we
create a tty char dev or not. I guess we could move that decision out
of the core and let the tty code check for devices and decide.

Rob
