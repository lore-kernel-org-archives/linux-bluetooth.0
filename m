Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <f16b04cf05070103496a3e64e6@mail.gmail.com>
From: hariharan veerappan <hariharanneevee@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] H5 3 wire UART connect problem
In-Reply-To: <1120213256.15397.187.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <f16b04cf050630083549f68fef@mail.gmail.com>
	 <1120157509.15397.152.camel@pegasus>
	 <f16b04cf05070102493b480412@mail.gmail.com>
	 <1120213256.15397.187.camel@pegasus>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 1 Jul 2005 16:19:31 +0530

Hello all,

If we wish to study some basic fundamentals of development.
Can any body advise whether any tutorials available for H5 UART (3 WIRE UAR=
T)
on bluez. Tell me the any website link for better solution for our developm=
ent.

Thanks and regards
Hariharan.v

On 7/1/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Hariharan,
>=20
> > we wants to develop and implement the 3 WIRE UART support for the
> > Bluez Stack. can any one suggest an idea to develop and implement
> > 3 WIRE UART in BlueZ.
> >
> > May i follow the H4 UART Implementation with Some modifications related=
 with
> > H5 (3 WIRE UART). We came to know that Packets has to be added before a=
nd after
> > the HCI commands according to H4 and H5 UART. Is it right ?.
> >
> > We wish to know that whether it takes major development cycle.
> >
> > As per Silicon wave datasheet the 3 WIRE UART is compatible with BCSP.
> > May we have to follow the H4 UART or BCSP one for our development.
>=20
> create a file drivers/bluetooth/hci_3wire.c and start with BCSP as base.
> In general you can do a driver that supports BCSP and 3-Wire at the same
> time, but actually I really like to have two separate drivers. Try to
> start from scratch and don't copy too much things. The second part is
> adding support for 3-Wire to the hciattach program.
>=20
> Regards
>=20
> Marcel
>=20
>=20
>=20
>=20
> -------------------------------------------------------
> SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
> from IBM. Find simple to follow Roadmaps, straightforward articles,
> informative Webcasts and more! Get everything you need to get up to
> speed, fast. http://ads.osdn.com/?ad_id=3D7477&alloc_id=3D16492&op=3Dclic=
k
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
