Return-Path: <cyrus@holtmann.org>
Subject: Re: AddCablePairedDevice (was Re: [PATCHes] Add sixpair)
From: Bastien Nocera <hadess@hadess.net>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1235861062.6074.43.camel@localhost.localdomain>
References: <1224083727.5268.3149.camel@cookie.hadess.net>
	 <1224114777.28173.41.camel@californication>
	 <1224116918.5268.3845.camel@cookie.hadess.net>
	 <1235857725.7310.797.camel@cookie.hadess.net>
	 <1235861062.6074.43.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 28 Feb 2009 23:47:54 +0000
Message-Id: <1235864874.7310.919.camel@cookie.hadess.net>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, 2009-02-28 at 23:44 +0100, Marcel Holtmann wrote:
> Hi Bastien,
>=20
> > > We could solve the data loss, and update problem by having an interna=
l,
> > > root only, dbus method available for cable pairing of that sort. For
> > > example, on org.bluez.Adapter:
> > > void AddCablePairedDevice (string name,
> > >                            string address,
> > >                            unsigned int vendor_id,
> > >                            unsigned int product_id,
> > >                            string pnp_record);
> > >=20
> > > The function would just need to do all the storage work sixpair
> > > currently does, and create the device internally similarly to
> > > create_stored_device_from_profiles().
> >=20
> > Patch to do that attached.
> >=20
> > After setting the master bdaddr on the sixaxis using sixpair, I ran:
> > dbus-send --system --type=3Dmethod_call --print-reply --dest=3D"org.blu=
ez" /org/bluez/11043/hci0 org.bluez.Adapter.AddCablePairedDevice string:Foo=
bar string:00:19:C1:61:D6:62 uint32:0x054c uint32:0x0268 string:36019209000=
00A000100000900013503191124090004350D35061901000900113503190011090006350909=
656E09006A0901000900093508350619112409010009000D350F350D3506190100090013350=
31900110901002513576972656C65737320436F6E74726F6C6C65720901012513576972656C=
65737320436F6E74726F6C6C6572090102251B536F6E7920436F6D707574657220456E74657=
27461696E6D656E740902000901000902010901000902020800090203082109020428010902=
052801090206359A35980822259405010904A101A102850175089501150026FF00810375019=
513150025013500450105091901291381027501950D0600FF8103150026FF0005010901A100=
75089504350046FF0009300931093209358102C005017508952709018102750895300901910=
2750895300901B102C0A1028502750895300901B102C0A10285EE750895300901B102C0A102=
85EF750895300901B102C0C0090207350835060904090901000902082800090209280109020=
A280109020B09010009020C093E8009020D280009020E2800
> >=20
> > Which created the device in bluez. I'd leave it up to sixpair to remove
> > the device from other adapters, and setting the device as trusted
> > (though this didn't seem necessary for the pad to work).
>=20
> can this be made a little bit more generic. For example Bluetooth 2.1
> has the out-of-band (OOB) ways for Simple Pairing and if we can design
> something generic here that would help a lot.

What does it need for SP to work?
