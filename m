Return-Path: <pokui@ucu.ac.ug>
Message-ID: <34318.81.199.88.27.1098107653.squirrel@ucu.ac.ug>
In-Reply-To: <1098107316.21553.8.camel@pegasus>
References: <34204.81.199.88.27.1098106921.squirrel@ucu.ac.ug>
    <1098107316.21553.8.camel@pegasus>
Date: Mon, 18 Oct 2004 16:54:13 +0300 (EAT)
Subject: Re: [Bluez-users] travelmate c110
From: pokui@ucu.ac.ug
To: "Marcel Holtmann" <marcel@holtmann.org>
Cc: pokui@ucu.ac.ug, "BlueZ Mailing List" <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
List-ID: <bluez-users.lists.sourceforge.net>

> Hi,
>
>> The chipset on my acer travelmate c110 doesn't seem to be supported
>> because typing "hcitool dev" gives me:
>> Devices:
>> #
>>
>> 1. Is there anyway I can tell what chipset this laptop is using (and
>> cross-check against the h/w list).
>>
>> 2. Given that the chipset may not be supported (if I can find out what
>> the
>> answer to 1 is), what would I need to add support for this chipset (in
>> terms of what major parts of the code do I need to modify etc)
>
> use "hciconfig -a" to look for your local adapter, but first check any
> hardware switch on your machine. Maybe you have to activate it first.
> You can also use "lsusb" and check "/proc/bus/usb/devices".

Hi there,

hciconfig -a just returns my prompt... FWIW, this is an inbuilt chipset on
a tabletpc... does it still show up as USB device?

>
> Regards
>
> Marcel
>
>
>
