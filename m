Return-Path: <cyrus@holtmann.org>
Subject: Re: Running "putkey" for keyboards and mice
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <AANLkTim3SSZhhJOB0DfaOsxMEzsaNKe-dkEf59p-7UQv@mail.gmail.com>
References: <1283767613.7529.6.camel@localhost.localdomain>
	 <AANLkTim3SSZhhJOB0DfaOsxMEzsaNKe-dkEf59p-7UQv@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Mon, 06 Sep 2010 13:19:55 +0100
Message-ID: <1283775595.7529.21.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 2010-09-06 at 14:51 +0300, Luiz Augusto von Dentz wrote:
> Hi,
> 
> On Mon, Sep 6, 2010 at 1:06 PM, Bastien Nocera <hadess@hadess.net> wrote:
> > Heya,
> >
> > Did a small test this week-end on my Macbook, and running "hciconfig"
> > with putkey works, adding the just paired keyboards' linkkey into the
> > Bluetooth adapter.
> >
> > This meant that even though I paired the device in Linux, it was still
> > available in MacOS X, without any more pairing.
> >
> > My question is whether we should, for all the adapters listed in the
> > hid2hci rules, copy the linkkeys for keyboards and (paired) mice[1] to
> > the adapter itself.
> >
> > How would you like to see this implemented? Would a device plugin be
> > good enough to track newly paired devices?
> 
> Im not sure this is going to work the other way round, when you pair
> in some other SO and than save the key in the chip we would need to
> load this device as it is already paired.

Some Windows drivers support doing this, though not all of them. MacOS X
clearly supports this, as the recommended way to make sure a keyboard
will be available in Windows, when dual-booting with BootCamp, is to
boot into MacOS X, which will write the linkkeys to the device. So the
Windows Apple Bluetooth drivers know how to read the linkkeys, but not
write them.

>  If that can be done than
> IMOH this should be integrated directly in core, perhaps adding
> .putkey/.delkey/.getkeys to hciops so we can properly use the keys
> stored on chip, but I guess we need to maintain our own storage too
> since chips normally have very limited space for storing keys.

Johan mentioned that we could implement this using a boolean property
for whether to store the linkkey on the device or not. When TRUE, should
we store the linkkey on both the device and on the local filesystem, or
just on the device?

hci_read_stored_link_key() is not currently used in the code at all, so
it's possible that a device will be paired, but not marked as such in
the interface.

Cheers

