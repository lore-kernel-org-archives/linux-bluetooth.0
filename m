Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <de33c8be050211121066edf6c1@mail.gmail.com>
From: =?ISO-8859-1?Q?Fl=E1vio?= <flavio.henriques@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] dd - device descriptor HELP :)
In-Reply-To: <1108149073.18099.50.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <de33c8be05021107172b943a1e@mail.gmail.com>
	 <1108149073.18099.50.camel@pegasus>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 11 Feb 2005 20:10:15 +0000

Hi Marcel, sorry if i wasn=B4t specific!
Ok, this is the important part of my program:
i give 2 arguments in the line command (example: program hci0 bdaddr)
***************************************************************************=
*****************************
       int ptype =3D HCI_DM1 | HCI_DM3 | HCI_DM5 | HCI_DH1 | HCI_DH3 |
HCI_DH5; protocol
       uint8_t role=3D 0x01;

=09str2ba(argv[2], &bdaddr);
=09dev_id =3D atoi ( argv[1] + 3 );     // hciX (X=3Ddev_id)
=09printf("dev_id=3D%i\n",dev_id);
=09dd =3D hci_open_dev(dev_id);     // device descriptor (dd)
=09if (dd < 0) {
=09=09perror("HCI device open failed");
=09=09exit(1);
=09}
=09printf("dd=3D%i\n",dd);
=09if (hci_create_connection(dd, &bdaddr, htobs(ptype),0, role, &handle,
25000) < 0)
=09=09perror("");
***************************************************************************=
*****************************

I have 2 dongles in my computer (hci0 and hci1) when i try to connect
with the 2 at the "same time" to a third bluetooth test (isn=B4t in my
computer), give me an error of connection!
I tryied debugging and think that the problem is because the device
discriptor that hci_open_device returns is the same even the dev_id is
diferente!
In my test the dev_id was 0 and 1, and the function in cause return
the same device descriptor!
The device descriptor shouldn=B4t be different(for different dev_id)?
Note that when i connect with only one (example hci0), the program
works well,the problem is when i try the second connection(example
hci1). Both (hci0 and hci1)is in master mode!
Why isn=B4t work?

One more thing, in the hci_create_connection the "role" argument is
oX01, what is purpuse and the values that sould have?

The last argument of hci_create_connection is diferent depending of
the situations how can i know the values that sould be used, what is
purpuse?

I hope that this time i was more specific!=20
Thanks for the time!
Regards Fl=E1vio



On Fri, 11 Feb 2005 20:11:13 +0100, Marcel Holtmann <marcel@holtmann.org> w=
rote:
> Hi Flavio,
>=20
> > I have two USB dongles connected to my pc. Using both of them in
> > MASTER mode, when i do one connection to another bluetooth device (i
> > was testing with a cell phone) for both dongles (hci1 and hci0) the
> > device descriptor for both connections is the same!!! Shouldn't they
> > be different?
> > And, apparently, because of this, when i try to set up the second
> > connection (connet my hci1 to the cell phone, when the hci0 is
> > allready conneted), it fails.
> > function used: dd =3D hci_open_dev(dev_id);
>=20
> what are you doing? I don't understand what's your problem. Be more
> specific. Show more code or commands.
>=20
> Regards
>=20
> Marcel
>=20
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>=20


--=20
Cumprimentos de Fl=E1vio!


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
