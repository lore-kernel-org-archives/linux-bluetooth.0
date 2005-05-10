Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb05051006043be12b4a@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Dealing with the bluez-utils dependencies
In-Reply-To: <1115722824.8949.242.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1115722824.8949.242.camel@pegasus>
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
Date: Tue, 10 May 2005 10:04:30 -0300

Hi Marcel,

Regarding D-Bus support for pand and hcid.=20
DBUS is under development and there is backward compatibility problem.
Some APIs changed, I suggest check the dbus version at build time=20
and fix the code to support this. The latest version(0.33) is not compatibl=
e
with 0.23.


Regards,
Claudio




On 5/10/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Folks,
>=20
> the dependency list of bluez-utils is going to be crazy and I think we
> need to work on some parts. I can't be possible that if you install
> bluez-utils that GTK+ and Python will be installed in some cases.
>=20
> The base dependency is the C library and bluez-libs or libbluetooth and
> this will not change of course ;)
>=20
> So lets talk about the other packages we need and use. The first one is
> the USB library that we need. It is used by hid2hci, bcm203x and dfutool
> programs. While bcm203x is only needed for the 2.4 kernel series and
> should be always kept as a separate package, I don't consider this a
> problem. Most modern distributions won't need this tool. The dfutool is
> only needed by developers and people that play with firmware upgrades.
> However it might be handy to create a bluez-devel packages that depends
> on the Bluetooth library header files and gives you special tools for
> the developers. Such a package may also contain the *test applications.
> However I think that people who wants to play with firmware upgrades
> should maybe better compile dfutool by themself. So at least it is not
> that easy to screw a Bluetooth device and then try to blame others. My
> only problematic tool left with USB dependency is hid2hci and this is
> really needed for all of you using HID Proxy dongles. So do you think a
> general dependency on the USB library is fine for a bluez-utils binary
> package?
>=20
> Next big thing is the D-Bus library. We use D-Bus in hcid and it seems
> that people are working on D-Bus support for pand. Personal I am not a
> big believer in D-Bus anymore, but it gets used and so we can't avoid
> it. So should we leave that a compile time option and by default we
> enable it. The bluez-utils binary package then simply depends on the
> D-Bus library?
>=20
> With configure we also check for OpenOBEX and ALSA. The OpenOBEX part is
> not ready at the moment and still part of its own in the CVS. For ALSA
> we now have the first draft of an A2DP plugin. However I think most
> packages maintainers will create a bluez-alsa package for it and this
> looks like a sane thing to me.
>=20
> And now the really ugly part. The PIN helper support. This is the real
> pain and we should find a nice solution for it. The original Python
> script is not an option, because it depends on Python and even the GTK
> PIN helper will add the GTK+ libraries. Also the KDE Bluetooth project
> has its own PIN helper. I personal like to go with the SuSE idea to
> provide a general PIN helper script that checks the installed tools and
> then executes the right PIN helper or provides a default PIN (or no PIN)
> if nothing has been setup. We can also add more config options, where we
> provide a list of PIN helpers that will tried one after the other. Maybe
> also a default PIN option would be a good idea. Comments please.
>=20
> Regards
>=20
> Marcel
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
>=20


--=20
_______________________________________
Claudio Takahasi
INdT - Nokia Technology Institute
Phone: +55 81 21223034
Recife - Pernambuco - Brazil


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
