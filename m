Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <2621d9af0504250729e34a2aa@mail.gmail.com>
From: "N. I." <neutralidea@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] auto pairing between client & server
In-Reply-To: <426ABEBD.5060701@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <2621d9af05042213064d0df1dc@mail.gmail.com>
	 <426ABEBD.5060701@gmx.ch>
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
Date: Mon, 25 Apr 2005 10:29:28 -0400

In the hcid.conf file, I have:
security auto;
auth enable;

Is that what you meant I should change to be off?



On 4/23/05, Marco Trudel <mtrudel@gmx.ch> wrote:
> N. I. wrote:
> > I have a laptop which runs my application as server, and another
> > cellphone as client. Both of them communicate to each other using
> > Bluetooth (Bluez implementation).
>=20
> do you really mean the mobile phone is using bluez?
> what for a mobilephone is this?
>=20
> > What should I do in order to perform automatic pairing between these 2
> > devices (knowing the BD_ADDR) inside my application?
> >
> > How can I detect if the pairing had been done between these
> > client-server devices inside my application? And from that, how to do
> > pairing using the "givepin" script?
> >
> > I want to avoid the pop-ups window asking for entering the PIN.
>=20
> disable authentication/encryption. you won't be asked for a pin because n=
o
> one is needed. you haven't to change the default bluez configuration to
> reach this.
> if you use java on your mobile phone, be shure to program the security
> correctly.
>=20
> regards
> Marco
>=20
> > Please help,
> >
> > Thanks
> >
> > N.I.
> >
> >
> > -------------------------------------------------------
> > SF email is sponsored by - The IT Product Guide
> > Read honest & candid reviews on hundreds of IT Products from real users=
.
> > Discover which products truly live up to the hype. Start reading now.
> > http://ads.osdn.com/?ad_ide95&alloc_id=14396&op=3Dclick
> > _______________________________________________
> > Bluez-users mailing list
> > Bluez-users@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-users
> >
> >
>=20
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
