Return-Path: <cyrus@holtmann.org>
From: Antti =?ISO-8859-1?Q?Kaijanm=E4ki?= <antti@kaijanmaki.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1214527364.4435.14.camel@cookie.hadess.net>
References: <1214310088.6643.87.camel@peura.elisa-laajakaista.fi>
	<1214527364.4435.14.camel@cookie.hadess.net>
Date: Fri, 27 Jun 2008 09:34:08 +0300
Message-Id: <1214548448.6624.61.camel@peura.elisa-laajakaista.fi>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Making library out of bluez-gnome
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1819843093=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--===============1819843093==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-jz8dx/73CsNMYjt133cg"


--=-jz8dx/73CsNMYjt133cg
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

pe, 2008-06-27 kello 01:42 +0100, Bastien Nocera kirjoitti:=20
> On Tue, 2008-06-24 at 15:21 +0300, Antti Kaijanm=C3=A4ki wrote:
> > Hello list!
> >=20
> > I'm developing a project[1] that needs to provide the user a way to
> > select=EF=BB=BF[2] a Bluetooth device from a list of discovered devices=
.
> >=20
> > I noticed that gnome-bluez applet has a very nice device selector and
> > that got me browsing though the code. Unfortunately I discovered that
> > bluez-gnome creates only a static library libcommon.a that contains the
> > device selector (common/bluetooth-device-selection.c) for private use.
> >=20
> > Now there is two options the way I see it. Either I have a private copy
> > of bluez-gnome package or bluez-gnome is made to be a shared library.
> <snip>
>=20
> The whole problem is making sure the API is good enough for applications
> to use. For example, Marcel wants to allow searching of devices by UUID.
>=20
> And I'd like to fix up the API to allow adding filters that encompass
> more than a single type of device (eg. input devices would be keyboards,
> mice, joysticks, and other input devices).

I understand all this and as I said the shared library approach is not
the easiest, but it would be the right thing to do. You have done a very
good job and I just wanted to let you know what I'm up to. For now I
will use a private copy of the files and someday when a shared library
is released I will switch to that.


> > Here are some wishes from top of my head regarding the device selector:
> >  1. remove the caption of the list
> >     - let the developer provide a caption best suited for
> >       his application
>=20
> That's already possible, you set it when calling
> bluetooth_device_selection_new().

I'm now talking about the "Select a device from the following list:"
caption. And calling bluetooth_device_selection_new(""); will only set
the boldface title to be an empty string that is still getting widget
space allocated to it.


> >  2. put the filter in GtkExpander
> >     - Filters are not used for by the most of the users, thus it's
> >       convenient to have them hidden by default.=20
>=20
> Why?

It was just a thought. GtkExpander lets you hide these "Advanced"
options so that Aunt Tillie does not get confused by them, but it's
clearly visible where they can be found when someone needs them. At
least I got the idea from your blog post[1] that this is truly needed
for a marginal use case.


> >  3. make the filter completely hidden
> >    - this combined with the 1. would make the widget appear just
> >      like GtkTreeView
> >    - this is already achievable, but there seems to be a bug. If both o=
f
> >      the filter fields are hidden the caption is still shown.
> >      See an attached patch.
>=20
> I don't see what the problem is here.

=EF=BB=BFYou don't see why the widget should appear just like GtkTreeView o=
r you
don't see what's the problem that my patch addresses?

If the widget can be made to look just like an ordinary GtkTreeView then
the application developer could embed it where ever he wants and make it
fit to his GUI design better. Those additional captions and titles can
brake the integrity of the GUI if there is no option to remove them.

By caption I mean the "Show Only Bluetooth Devices With..."
Without my patch this caption is still visible even though there are no
filters visible.


> >  4. have alternative filters in right-click pop-up menu
> >     - very handy for tight places
>=20
> I'm not sure that's useful.

I mean this would be for situations where there is no room for filters
below the treeview, but the pop-up menu would provide the user an access
to them.


> >  5. add property for selected device name. It's always nice to be able
> >     to show the user a nice name instead of bluetooth address.
> >     - see an attached patch.
>=20
> That's useful, as it allows us to avoid another lookup, although it's
> close to free as hcid would have cached it.

True, but then yet another API must be used to make the lookup.=20


> FYI, you're leaking a copy of the name though, as gtk_tree_model_get()
> will make a copy of the value, as well as g_value_set_string(). Use
> g_value_take_string().

Yes, true. thanks! I thought that g_value_set_string() would not make a
copy of the string. I just adapted the "device-selected" property so I
suppose it's also leaking memory.=20


Br,
Antti

[1] http://www.hadess.net/2007/11/gnome-bluetooth-kill-kill.html


--=-jz8dx/73CsNMYjt133cg
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Digitaalisesti allekirjoitettu viestin osa

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIZIngxyyCWWVycu8RAij9AJ9Be4NgRTEU4v6glDdTANy6VZZ7iwCfUGsh
NCTvH7EYtJ7V+UTpPFIbpA0=
=2qBK
-----END PGP SIGNATURE-----

--=-jz8dx/73CsNMYjt133cg--



--===============1819843093==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
--===============1819843093==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1819843093==--
