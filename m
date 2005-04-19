Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0504191448357f24da@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] DBUS service support
In-Reply-To: <1113943613.2469.65.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <e1effdeb05041913007eacbf88@mail.gmail.com>
	 <1113943613.2469.65.camel@pegasus>
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
Date: Tue, 19 Apr 2005 18:48:24 -0300

Hi Marcel,

Sorry, I was not my objective provoke this discussion. I posted in both lis=
t
to try reach all bluez community members and figure out who are researching=
 this
topic in order to share information.

I will contact the Network Manager developers to verify if a bluetooth
dbus service support can be useful.

At BlueZ side,  search, connect, disconnect, security and IP configuration=
=20
functions have be provided by a library. I developed a initial library and=
=20
it is working fine. BlueZ does not need provide a DBUS service, only interf=
aces=20
for a DBUS service daemon are required. The DBUS service=20
daemon must control all media(bluetooth, WLAN, ETH, ...) =20
This is my idea of how DBUS and Bluetooth can work together providing
seamless connections.

Regards,
Claudio.

On 4/19/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Claudio,
>=20
> stop cross-posting. I don't like it and actually I don't tolerate it.
>=20
> > I would like to know if are there plans to develop a
> > library/application to integrate bluez and dbus service
> > to control bluetooth connections?
> >
> > BlueZ provides tools to enable setup Bluetooth PANs. However,
> > an user mode application is not able to control Bluetooth
> > connections (connect, disconnect, assign IP, ...)
> >
> > I found the Network Manager application, developed by Red Hat.
> > There is comments to bluetooth support, however it is not
> > supported at the moment.
> > http://people.redhat.com/dcbw/NetworkManager/
> >
> > Is this topic useful for this project?
>=20
> at some point I think we need full D-Bus support, but I don't think that
> it will be me adding it. I never really got fully into the concept of
> D-Bus and how to program it correctly. However I am not against it, but
> the core work must be done by someone else.
>=20
> > If yes, how can I contribute?
>=20
> Start writing patches and post them on the mailing list for review.
>=20
> Regards
>=20
> Marcel
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by: New Crystal Reports XI.
> Version 11 adds new functionality designed to reduce time involved in
> creating, integrating, and deploying reporting solutions. Free runtime in=
fo,
> new features, or free trial, at: http://www.businessobjects.com/devxi/728
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
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
