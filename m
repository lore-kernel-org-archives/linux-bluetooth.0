Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb05051014407d4d3b0a@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Dealing with the bluez-utils dependencies
In-Reply-To: <1115739962.12058.19.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1115722824.8949.242.camel@pegasus> <4280D256.1000804@xmission.com>
	 <1115739962.12058.19.camel@pegasus>
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
Date: Tue, 10 May 2005 18:40:02 -0300

Hi Marcel,

Regarding D-Bus support for pand and hcid.
DBUS is under development and there is backward compatibility problem.
Some APIs changed, I suggest check the dbus version at build time
and fix the code to support this. The latest version(0.33) is not compatibl=
e
with 0.23.

Regards,
Claudio


On 5/10/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Brad,
>=20
> > > So lets talk about the other packages we need and use. The first one =
is
> > > the USB library that we need. It is used by hid2hci
> > ...
> > > really needed for all of you using HID Proxy dongles. So do you think=
 a
> > > general dependency on the USB library is fine for a bluez-utils binar=
y
> > > package?
> >
> > yes, this seems unavoidable unless you wanted to move hid2hci into a ne=
w
> > package or make it an optional build. it seems best where it is now.
>=20
> I agree and creating an own package for it sounds like too much
> overhead.
>=20
> So keeping the USB library dependency for a binary package is ok. The
> embedded people need to recompile with USB support.
>=20
> > on a related note, what is happening with utils2 and libs2 in cvs?
>=20
> They are meant to be the next generation, but then I started to backport
> features and we still have the 2.x generation. The API breakage is too
> big and I will only work on it again, when we get clarification about
> LGPL for the Bluetooth library from Qualcomm.
>=20
> > > enable it. The bluez-utils binary package then simply depends on the
> > > D-Bus library?
> >
> > some of the hcid pin stuff would have to be rewritten around no d-bus,
> > right? but that seems like a low priority.
>=20
> All the PIN stuff is also working without D-Bus support.
>=20
> > > With configure we also check for OpenOBEX and ALSA. The OpenOBEX part=
 is
> > > not ready at the moment and still part of its own in the CVS. For ALS=
A
> > > we now have the first draft of an A2DP plugin. However I think most
> > > packages maintainers will create a bluez-alsa package for it and this
> > > looks like a sane thing to me.
> >
> > right, so it's not a core dependency.
>=20
> However the ALSA library 1.0.9 must be released first.
>=20
> > > PIN helper will add the GTK+ libraries. Also the KDE Bluetooth projec=
t
> > > has its own PIN helper. I personal like to go with the SuSE idea to
> > > provide a general PIN helper script that checks the installed tools
> >
> > the helper script sounds reasonable. would the gnome folks be willing t=
o
> > maintain the gtk helper like kde does their own? It seems like kde is
> > doing more to make bluez easy to use--gnome devels should take this as =
a
> > challenge.
> >
> > bluez could have a package that contains just the gtk pin tool just for
> > gnome users with the idea that gnome should adopt it.
>=20
> It is already an own package called bluez-pin and not maintained by me.
> The problem is that for example the Debian bluez-utils package depends
> on bluez-pin and thus the dependency chain increases.
>=20
> Regards
>=20
> Marcel
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by Oracle Space Sweepstakes
> Want to be the first software developer in space?
> Enter now for the Oracle Space Sweepstakes!
> http://ads.osdn.com/?ad_id=3D7393&alloc_id=3D16281&op=3Dclick
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
