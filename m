Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1264346020.11653.1.camel@violet>
References: <4B5C554D.4030702@gmx.de> <1264343316.11653.0.camel@violet>
	 <4B5C6062.4030705@gmx.de> <1264346020.11653.1.camel@violet>
Date: Sun, 24 Jan 2010 23:09:54 +0200
Message-ID: <2d5a2c101001241309u6e292a12hfc5c67011d6b77ba@mail.gmail.com>
Subject: Re: [PATCH 1/1] add configurable support for bridge forward delay
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Thomas Egerer <hakke_007@gmx.de>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Sun, Jan 24, 2010 at 5:13 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Thomas,
>
>> I get your point, but what's your suggestion? The ioctl is marked
>> deprecated, too and the problem of setting the forward delay persists.
>> Would it suffer your needs if I got rid of libsysfs in general and
>> simply use the ioctl or is there a different replacement strategy you
>> prefer?
>
> if it has an ioctl, then use that one. I really don't understand why
> everybody things ioctl are bad. They work just fine and are often
> simpler to handle than sysfs files.

The documentation on
http://www.linuxfoundation.org/collaborate/workgroups/networking/bridge
state:

"If the bridge is being used standalone (no other bridges near by).
Then it is safe to turn the forwarding delay off (set it to zero),
before adding interface to a bridge. Then you can run DHCP client
right away." Which I guess is what the PAN spec expects for a NAP
server, so perhaps having another entry in network.conf is not really
needed or only really useful for a GN server if someone is messing
with it e.g. mesh network, but even for that purpose it just seems
wrong to expect that in a fixed amount of time it will be able to
resolve the topology, so why bother?


--=20
Luiz Augusto von Dentz
Engenheiro de Computa=E7=E3o
