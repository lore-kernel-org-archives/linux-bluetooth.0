Return-Path: <pokui@ucu.ac.ug>
Message-ID: <33017.193.108.254.98.1098192097.squirrel@ucu.ac.ug>
In-Reply-To: <1098191809.31395.1.camel@pegasus>
References: <34204.81.199.88.27.1098106921.squirrel@ucu.ac.ug>
    <1098107316.21553.8.camel@pegasus>
    <34318.81.199.88.27.1098107653.squirrel@ucu.ac.ug>
    <1098109156.21553.11.camel@pegasus>
    <32925.193.108.254.98.1098191310.squirrel@ucu.ac.ug>
    <1098191809.31395.1.camel@pegasus>
Date: Tue, 19 Oct 2004 16:21:37 +0300 (EAT)
Subject: Re: [Bluez-users] travelmate c110
From: pokui@ucu.ac.ug
To: "Marcel Holtmann" <marcel@holtmann.org>
Cc: pokui@ucu.ac.ug, "BlueZ Mailing List" <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
List-ID: <bluez-users.lists.sourceforge.net>

> Hi,
>
>> >> a tabletpc... does it still show up as USB device?
>> >
>> > I am not sure. Maybe it is attached through an UART. Is Windows giving
>> > you any kind of extra information about the bus type of your Bluetooth
>> > adapter?
>>
>> Oddly enough, windows reports it as a USB CSR bluetooth device by
>> widcomm.
>> FWIW, this is running SuSE 9.1. I've attached text files that show the
>> output of the commands:
>>
>> 	-lsusb -vv > lsusb.txt
>> 	-cat /proc/bus/usb/devices_please-use-sysfs-instead > proc_bus.txt
>
> there is no CSR dongle in the devices file and so you must find the
> switch to activate it. Maybe it is only a software switch. Is there an
> ACER ACPI module available?

Yes there is. Building it now... will post as soon as it's done - there is
a button above my keyboard I had ignored - probably it'll do the trick.
thanks.

>
> Regards
>
> Marcel
>
>
>
