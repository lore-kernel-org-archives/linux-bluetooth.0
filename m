Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] dd - device descriptor HELP :)
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <de33c8be050211121066edf6c1@mail.gmail.com>
References: <de33c8be05021107172b943a1e@mail.gmail.com>
	 <1108149073.18099.50.camel@pegasus>
	 <de33c8be050211121066edf6c1@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1108155254.18099.62.camel@pegasus>
Mime-Version: 1.0
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
Date: Fri, 11 Feb 2005 21:54:14 +0100

Hi Flavio,

> Ok, this is the important part of my program:
> i give 2 arguments in the line command (example: program hci0 bdaddr)
> ***********************************************************************=
*********************************
>        int ptype =3D HCI_DM1 | HCI_DM3 | HCI_DM5 | HCI_DH1 | HCI_DH3 |
> HCI_DH5; protocol
>        uint8_t role=3D 0x01;
>=20
> 	str2ba(argv[2], &bdaddr);
> 	dev_id =3D atoi ( argv[1] + 3 );     // hciX (X=3Ddev_id)
> 	printf("dev_id=3D%i\n",dev_id);
> 	dd =3D hci_open_dev(dev_id);     // device descriptor (dd)
> 	if (dd < 0) {
> 		perror("HCI device open failed");
> 		exit(1);
> 	}
> 	printf("dd=3D%i\n",dd);
> 	if (hci_create_connection(dd, &bdaddr, htobs(ptype),0, role, &handle,
> 25000) < 0)
> 		perror("");
> ***********************************************************************=
*********************************
>=20
> I have 2 dongles in my computer (hci0 and hci1) when i try to connect
> with the 2 at the "same time" to a third bluetooth test (isn=B4t in my
> computer), give me an error of connection!
> I tryied debugging and think that the problem is because the device
> discriptor that hci_open_device returns is the same even the dev_id is
> diferente!
> In my test the dev_id was 0 and 1, and the function in cause return
> the same device descriptor!
> The device descriptor shouldn=B4t be different(for different dev_id)?

this is fine, because it is a socket descriptor. For the reason you may
look at a Unix handbook.


> Note that when i connect with only one (example hci0), the program
> works well,the problem is when i try the second connection(example
> hci1). Both (hci0 and hci1)is in master mode!
> Why isn=B4t work?

And this means that your third device must create a scatternet (slave in
two different piconets). Check the error codes with hcidump.

> One more thing, in the hci_create_connection the "role" argument is
> oX01, what is purpuse and the values that sould have?

Come on. Look it up in the Bluetooth specification.

> The last argument of hci_create_connection is diferent depending of
> the situations how can i know the values that sould be used, what is
> purpuse?

Do you mean the timeout parameter? It is what it says.

> I hope that this time i was more specific!=20

And here is my advice. Don't create HCI connections by yourself. It is
possible to do it, but for what do you wanna use them? The kernel L2CAP
and RFCOMM socket create all underlaying links and you don't have to
worry about things like clock offsets and connection handles.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
