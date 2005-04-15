Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <12a241ad05041420301f4fd8d7@mail.gmail.com>
From: Bruno Abinader <brunoabinader@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] BlueZ supported packets
In-Reply-To: <d1f423d305041419172d744712@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <12a241ad0504141849381f1667@mail.gmail.com>
	 <d1f423d305041419172d744712@mail.gmail.com>
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
Date: Fri, 15 Apr 2005 03:30:27 +0000

Thanks Anderson! I was looking under an old version of bluez-libs with
an outdated hci.h source file, this new one (2.15) has all I need
(yes, bluez supports all packets types).

2005/4/15, Anderson Rodrigues <rodrigues.anderson@gmail.com>:
> Bruno,
>=20
> I think you will find something about it taking a look at
> /bluez-libs-2.15/include/hci.h. It can be a start for further
> investigations.
>=20
> Regards
>=20
> On 4/14/05, Bruno Abinader <brunoabinader@gmail.com> wrote:
> > Hello guys, i'm searching for some documentation about bluez but I
> > can't find it... and i need to know how many packets does the Bluez
> > protocol stack support (control packets, ACL and SCO/eSCO ones).
> > Thanks!
> >
> > --
> > Bruno de Oliveira Abinader
> > GVoIP - INdT/UFAM
> >
> > -------------------------------------------------------
> > SF email is sponsored by - The IT Product Guide
> > Read honest & candid reviews on hundreds of IT Products from real users=
.
> > Discover which products truly live up to the hype. Start reading now.
> > http://ads.osdn.com/?ad_ide95&alloc_id=14396&opclick
> > _______________________________________________
> > Bluez-users mailing list
> > Bluez-users@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-users
> >
>=20
> --
> Anderson Clayton B. Rodrigues
> Eng. de Software
> Instituto Nokia de Tecnologia - INdT
>=20
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_ide95&alloc_id=14396&opclick
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users

--=20
Bruno de Oliveira Abinader
GVoIP - INdT/UFAM


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
