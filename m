Return-Path: <cyrus@holtmann.org>
Message-ID: <4B5EA94B.1000204@gmx.de>
Date: Tue, 26 Jan 2010 09:35:23 +0100
From: Thomas Egerer <hakke_007@gmx.de>
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: Marcel Holtmann <marcel@holtmann.org>,
 linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/1] add configurable support for bridge forward delay
References: <4B5C554D.4030702@gmx.de> <1264343316.11653.0.camel@violet>	 <4B5C6062.4030705@gmx.de> <1264346020.11653.1.camel@violet> <2d5a2c101001241309u6e292a12hfc5c67011d6b77ba@mail.gmail.com>
In-Reply-To: <2d5a2c101001241309u6e292a12hfc5c67011d6b77ba@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Luiz Augusto von Dentz wrote:
> Hi,
> 
> On Sun, Jan 24, 2010 at 5:13 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
>> Hi Thomas,
>>
>>> I get your point, but what's your suggestion? The ioctl is marked
>>> deprecated, too and the problem of setting the forward delay persists.
>>> Would it suffer your needs if I got rid of libsysfs in general and
>>> simply use the ioctl or is there a different replacement strategy you
>>> prefer?
>> if it has an ioctl, then use that one. I really don't understand why
>> everybody things ioctl are bad. They work just fine and are often
>> simpler to handle than sysfs files.
> 
> The documentation on
> http://www.linuxfoundation.org/collaborate/workgroups/networking/bridge
> state:
> 
> "If the bridge is being used standalone (no other bridges near by).
> Then it is safe to turn the forwarding delay off (set it to zero),
> before adding interface to a bridge. Then you can run DHCP client
> right away." Which I guess is what the PAN spec expects for a NAP
> server, so perhaps having another entry in network.conf is not really
> needed or only really useful for a GN server if someone is messing
> with it e.g. mesh network, but even for that purpose it just seems
> wrong to expect that in a fixed amount of time it will be able to
> resolve the topology, so why bother?
Luiz,
let me tell you why I'd like to have an extra config variable. Let's
imagine an admin who want to add the upcoming bnep interfaces to an
_already_ existing bridge (for that matter a test whether the given
interface name already exists would be nice, too) plus he knows about
the infrastructure behind the bridge and decides to set a different
forward delay. He could, of course reset the delay, once the bridge is
up. But ideally he would specify the setting in the network.conf. Hence
the extra config variable (which btw. were actually two variables by the
time I started writing the patch).

Cheers,

Thomas
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEAREKAAYFAkteqUoACgkQ2/ggQBUI/sm6FQCcD8btgzXLig9UD59AE8u753bP
iFAAn1+ZiWlJ1ysVLgIq7jvpxL8u0dPm
=AtT9
-----END PGP SIGNATURE-----
