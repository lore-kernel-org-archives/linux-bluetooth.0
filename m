Return-Path: <ohadbc@gmail.com>
Message-ID: <4f436aae0701181559h63b7d509n5dc73c55353d8c79@mail.gmail.com>
Date: Fri, 19 Jan 2007 01:59:09 +0200
From: "Choi Sonim" <choisonim@gmail.com>
Sender: ohadbc@gmail.com
To: "Marcel Holtmann" <marcel@holtmann.org>
Subject: Re: [Bluez-devel] /sys/devices/platform/bluetooth
Cc: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1169164343.6853.7.camel@violet>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <4f436aae0701172208l7ac85a75tc592fa15d1b57f8@mail.gmail.com>
	 <1169108019.6853.1.camel@violet>
	 <4f436aae0701181523y55ad36bdu9645c786a252c04e@mail.gmail.com>
	 <1169164343.6853.7.camel@violet>
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel,

On 1/19/07, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Choi,
>
> > > > Where is the code that does the platform registration to this device :
> > > > /sys/devices/platform/bluetooth
> > >
> > > you find it in net/bluetooth/hci_sysfs.c in the kernel source code.
> >
> > What is the purpose of the bluetooth platform device (and bus and class..) ?
> >
> > I guess that bluetooth devices would prefer to register themselves as children
> > of their true bus (like USB or PCI or even serial) so when the system goes
> > to suspend, their suspend function will be called before their father's
> > (the true hardware bus of our bluetooth device).
>
> if they do have a physical parent. Some devices like virtual HCI or
> serial based chips don't have a physical parent.

About the serial based chips -
I'm sure they would like their suspend function to be called before the
serial uart driver's suspend, so for them to set device parent to the
serial device
can be a benefit too, no ?

About the virtual HCI - I really don't know what are them, can you please
explain this ?

Thank You Very very Much !
Choi.
>
> Regards
>
> Marcel
>
>
>
