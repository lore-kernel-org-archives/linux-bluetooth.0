Return-Path: <cyrus@holtmann.org>
Subject: Re: AddCablePairedDevice (was Re: [PATCHes] Add sixpair)
From: Marcel Holtmann <marcel@holtmann.org>
To: Bastien Nocera <hadess@hadess.net>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1235857725.7310.797.camel@cookie.hadess.net>
References: <1224083727.5268.3149.camel@cookie.hadess.net>
	 <1224114777.28173.41.camel@californication>
	 <1224116918.5268.3845.camel@cookie.hadess.net>
	 <1235857725.7310.797.camel@cookie.hadess.net>
Content-Type: text/plain; charset=US-ASCII
Date: Sat, 28 Feb 2009 23:44:22 +0100
Message-Id: <1235861062.6074.43.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

> > We could solve the data loss, and update problem by having an internal,
> > root only, dbus method available for cable pairing of that sort. For
> > example, on org.bluez.Adapter:
> > void AddCablePairedDevice (string name,
> >                            string address,
> >                            unsigned int vendor_id,
> >                            unsigned int product_id,
> >                            string pnp_record);
> > 
> > The function would just need to do all the storage work sixpair
> > currently does, and create the device internally similarly to
> > create_stored_device_from_profiles().
> 
> Patch to do that attached.
> 
> After setting the master bdaddr on the sixaxis using sixpair, I ran:
> dbus-send --system --type=method_call --print-reply --dest="org.bluez" /org/bluez/11043/hci0 org.bluez.Adapter.AddCablePairedDevice string:Foobar string:00:19:C1:61:D6:62 uint32:0x054c uint32:0x0268 string:3601920900000A000100000900013503191124090004350D35061901000900113503190011090006350909656E09006A0901000900093508350619112409010009000D350F350D350619010009001335031900110901002513576972656C65737320436F6E74726F6C6C65720901012513576972656C65737320436F6E74726F6C6C6572090102251B536F6E7920436F6D707574657220456E7465727461696E6D656E740902000901000902010901000902020800090203082109020428010902052801090206359A35980822259405010904A101A102850175089501150026FF00810375019513150025013500450105091901291381027501950D0600FF8103150026FF0005010901A10075089504350046FF0009300931093209358102C0050175089527090181027508953009019102750895300901B102C0A1028502750895300901B102C0A10285EE750895300901B102C0A10285EF750895300901B102C0C0090207350835060904090901000902082800090209280109020A280109020B09010009020C093E8009020D280009020E2800
> 
> Which created the device in bluez. I'd leave it up to sixpair to remove
> the device from other adapters, and setting the device as trusted
> (though this didn't seem necessary for the pad to work).

can this be made a little bit more generic. For example Bluetooth 2.1
has the out-of-band (OOB) ways for Simple Pairing and if we can design
something generic here that would help a lot.

Regards

Marcel


