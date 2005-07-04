Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <f16b04cf0507032307413fcef@mail.gmail.com>
From: hariharan veerappan <hariharanneevee@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] H5 3 wire UART connect problem
In-Reply-To: <1120224082.15397.197.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <f16b04cf050630083549f68fef@mail.gmail.com>
	 <1120157509.15397.152.camel@pegasus>
	 <f16b04cf05070102493b480412@mail.gmail.com>
	 <1120213256.15397.187.camel@pegasus>
	 <f16b04cf05070103496a3e64e6@mail.gmail.com>
	 <1120224082.15397.197.camel@pegasus>
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
Date: Mon, 4 Jul 2005 11:37:46 +0530

Hello all,

I am still newer to the development of bluetooth drivers.

Can any body suggest, from where can i get H5 - 3 WIRE Transport
interface protocol
informations.

Thanks and Regards
Hariharan.V

On 7/1/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Hriharan,
>=20
> > If we wish to study some basic fundamentals of development.
> > Can any body advise whether any tutorials available for H5 UART (3 WIRE=
 UART)
> > on bluez. Tell me the any website link for better solution for our deve=
lopment.
>=20
> look at the hci_h4.c and hci_bcsp.c files for examples. They show you
> how to use our HCI UART API. The number of lines of code are very small
> and it should be easy to understand what the callback functions are for.
> The hciattach.c is a little bit more freaky. I need to split it into
> more separate files for each transport or vendor.
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
