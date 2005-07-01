Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <f16b04cf05070102493b480412@mail.gmail.com>
From: hariharan veerappan <hariharanneevee@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] H5 3 wire UART connect problem
In-Reply-To: <1120157509.15397.152.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <f16b04cf050630083549f68fef@mail.gmail.com>
	 <1120157509.15397.152.camel@pegasus>
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
Date: Fri, 1 Jul 2005 15:19:49 +0530

Hello all,

we wants to develop and implement the 3 WIRE UART support for the=20
Bluez Stack. can any one suggest an idea to develop and implement
3 WIRE UART in BlueZ.=20

May i follow the H4 UART Implementation with Some modifications related wit=
h=20
H5 (3 WIRE UART). We came to know that Packets has to be added before and a=
fter
the HCI commands according to H4 and H5 UART. Is it right ?.=20

We wish to know that whether it takes major development cycle.

As per Silicon wave datasheet the 3 WIRE UART is compatible with BCSP.
May we have to follow the H4 UART or BCSP one for our development.

Advise us.

Thanks and regards
Hariharan.V

On 7/1/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Hariharan,
>=20
> > We are presently working on Silicon wave Serial Port Bluetooth module
> > with Linux version 2.4.20.
> > When we try to attach the UART with HCI layer.
> >
> > Bluetooth module : Silicon Wave bluetooth module. (H5 3 Wire interface)
> > Linux Kernel : 2.4.20.
> >
> > We have done different trial with the module. Below we have given two
> > of them major, that we have noticed in our experiment.
> >
> > Experiment 1:
> > When we connect Bluetooth module with the full functional serial port
> > (thatr contains Hard ware flow control)
> > The HCI layer is attached with UART layer.
> > But when we try to UP the HCI0 it returns
> > cannot Init Device hci0.
> >
> > Experiment 2:
> > When we connect the Bluetooth module with 3 WIRE serial cable (consist
> > of TXD, RXD and GND)
> >
> > hciattach /dev/ttyS0 swave 115200 noflow
> >
> > Actually our plan is to work the bluetooth with 3WIRE (H5) Bluetooth in=
terface.
> > Kindly confirm whether the HCI_UART_3WIRE functionality is included in
> > the linux kernel.
>=20
> actually nobody implemented the 3-Wire UART support for BlueZ.
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
