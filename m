Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Linking to BlueZ from non-GPL code
From: Fredy P <digitalfredy@debiancolombia.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1117662296.31350.31.camel@pegasus>
References: <EFCD68F7BFDB06468769D4D9EAAA93870774B6D7@scsmsx401.amr.corp.int
	 el.com> <1117662296.31350.31.camel@pegasus>
Content-Type: text/plain;
	charset=iso-8859-1
Message-Id: <1117688464.3908.6.camel@localhost.localdomain>
Mime-Version: 1.0
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
Date: Thu, 02 Jun 2005 00:01:04 -0500

El mi=E9, 01-06-2005 a las 23:44 +0200, Marcel Holtmann escribi=F3:
> Hi Trevor,
>=20
> > I have a question about linking non-GPL code to BlueZ.  This is
> > very much along the lines of the previous conversation at=20
> > http://thread.gmane.org/gmane.linux.bluez.devel/2444 -- the quick
> > summary of which is:=20
> > =20
> > Marcel: Date: 2004-06-28 14:48:48 GMT: "For the BlueZ library and the
> > utilities we can talk about it. Some time ago people asked for a LGPL
> > version of the library and actually I tend to agree with that. However
> > this can't be decided by me alone, because part of the code is copyrigh=
t
> > by Qualcomm and also by Maxim Krasnyansky himself. For the utilities I
> > don't see any need for a different license. I believe in the GPL and
> > from my view releasing the Linux Bluetooth library under LGPL is the
> > only step I wanna make forward to allow closed source products based on
> > BlueZ."
> >=20
> > Is this still the current status of GPL/LGPL for the BlueZ libraries
> > (libbluetooth.so) -- or has there been an update (I haven't found
> > anything more recent on the mailing list about this).
>=20
> nothing has changed at the moment. Ask Max for an update of changing the
> BlueZ library from GPL to LGPL.

For the free software and open source interest is not good idea change
GPL to LGPL, can read this:
http://www.gnu.org/licenses/why-not-lgpl.html
>=20
> > What is the recommended way to write a non-GPL application on top of
> > BlueZ, or is this not currently allowed...? My understanding is that it
> > is OK to use the linux kernel syscall interface from non-GPL code, but
> > that this would not extend to libbluetooth.so...
>=20
> Actually I disagree with the non-GPL use of the syscall interface, but I
> am not lawyer. From my understanding all the bluetooth/*.h include files
> are GPL and you need them for your application. You can't replace them
> without ending up in derived work.
>=20
> Regards
>=20
> Marcel
>=20
>=20
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by Yahoo.
> Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
> Search APIs Find out how you can build Yahoo! directly into your own
> Applications - visit http://developer.yahoo.net/?fr=3Doffad-ysdn-ostg-q22=
005
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users



-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
