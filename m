Return-Path: <robh@kernel.org>
MIME-Version: 1.0
In-Reply-To: <09cdab76-ee1a-45da-699f-a66bf7148579@gmail.com>
References: <20170116225436.17505-1-robh@kernel.org> <20170116225436.17505-8-robh@kernel.org>
 <09cdab76-ee1a-45da-699f-a66bf7148579@gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 18 Jan 2017 15:26:03 -0600
Message-ID: <CAL_JsqJCg9wXA8hvo1TDPtyRN+ydMs1_S7yzwggvZAnq1aRgag@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] serdev: Introduce new bus for serial attached devices
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis.oss@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>,
	Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	"Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Peter Hurley <peter@hurleysoftware.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
	Loic Poulain <loic.poulain@intel.com>, Pavel Machek <pavel@ucw.cz>, NeilBrown <neil@brown.name>,
	Linus Walleij <linus.walleij@linaro.org>,
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stephen Boyd <stephen.boyd@linaro.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Jan 18, 2017 at 5:53 AM, Fr=C3=A9d=C3=A9ric Danis
<frederic.danis.oss@gmail.com> wrote:
> Hello,
>
> Le 16/01/2017 =C3=A0 23:54, Rob Herring a =C3=A9crit :
>>
>> ---
>> v2:
>> - Add modalias sysfs attr and uevent hook
>
> ...
>>
>> +static int serdev_uevent(struct device *dev, struct kobj_uevent_env *en=
v)
>> +{
>> +       /* TODO: ACPI and platform modalias */
>> +       return of_device_uevent_modalias(dev, env);
>> +}
>
> ...
>>
>> +static ssize_t modalias_show(struct device *dev,
>> +                            struct device_attribute *attr, char *buf)
>> +{
>> +       ssize_t len =3D of_device_get_modalias(dev, buf, PAGE_SIZE - 2);
>> +       buf[len] =3D '\n';
>> +       buf[len+1] =3D 0;
>> +       return len+1;
>> +}
>
>
> This prevents from building serdev as a module with following errors:
>   ERROR: "of_device_uevent_modalias" [drivers/tty/serdev/serdev.ko]
> undefined!
>   ERROR: "of_device_get_modalias" [drivers/tty/serdev/serdev.ko] undefine=
d!

Turns out, there's a fix already[1] that should be going in via Greg's tree=
.

Rob

[1] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1299121.ht=
ml
