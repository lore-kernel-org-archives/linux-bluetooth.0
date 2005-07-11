Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <ef9938ec0507111231318ab208@mail.gmail.com>
From: Albert Huang <ashuang@gmail.com>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Strange hci_get_route() result
In-Reply-To: <1121109721.5934.17.camel@notepaq>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20050710224918.A15613CE@arbetsmyra.dyndns.org>
	 <1121094313.6158.9.camel@notepaq>
	 <20050711180747.C34033A4@arbetsmyra.dyndns.org>
	 <1121109721.5934.17.camel@notepaq>
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
Date: Mon, 11 Jul 2005 15:31:48 -0400

Looks like I'm wrong. =20

just to make sure i understand - hci_get_route will return the first
dev_id that doesn't have the same bluetooth address as ba?

-albert

On 7/11/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Albert,
>=20
> > > check the CVS. I changed the hci_get_route() lately.
> >
> > My lib is up to date with CVS so that's not the problem.
>=20
> please try again. What happens if you use NULL as address argument.
>=20
> > > And the ba is
> > > the address of the remote system.
> >
> > Really? umm, ok. The "manual" by Albert Huang
> > http://people.csail.mit.edu/albert/pubs/ashuang-sm-thesis-2005.pdf
> > states the opposite. If you happen to already know the bdaddr of a
> > *local* adapter you can look up its device id with hci_get_rotue(). I
> > guess there is no such handy utility function then?
>=20
> It is really the remote address. Otherwise this function wouldn't make
> any sense. We need to find a local adapter that can connect to the
> remote one. This is the reason why it is called *_route().
>=20
> Use hci_devid() if you wanna get the dev_id of a local adapter when you
> know its address.
>=20
> Regards
>=20
> Marcel
>=20
>=20
>


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
