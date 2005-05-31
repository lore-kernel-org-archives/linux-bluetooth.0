Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <12a241ad05053113413231b427@mail.gmail.com>
From: Bruno Abinader <brunoabinader@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] bluez-utils-2.17 -- Error compiling dbus.o
In-Reply-To: <1117468405.7072.191.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <12a241ad05052907591c593c6@mail.gmail.com>
	 <1117379509.7072.95.camel@pegasus>
	 <12a241ad050529081764ef7ed1@mail.gmail.com>
	 <e1effdeb0505300532fe36918@mail.gmail.com>
	 <1117456782.7072.141.camel@pegasus>
	 <12a241ad050530083423a9205f@mail.gmail.com>
	 <1117468405.7072.191.camel@pegasus>
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
Date: Tue, 31 May 2005 16:41:14 -0400

Thanks Marcel, i made a checkout on the files in the CVS and compiled
it, and now both bluez-libs and bluez-pin are working fine with the
new DBUS version.

2005/5/30, Marcel Holtmann <marcel@holtmann.org>:
> Hi Bruno,
>=20
> > That's fine, Claudio and Marcel. I have read about the changes on
> > D-BUS and it affected a lot of programs that i use on my distro, so i
> > can't change it back to 0.23 version. I'll try to look at the code and
> > make the changes myself. If i suceed on that, i'll send the patch for
> > the list.
>=20
> for hcid the change is in the CVS and so you should use that patch
> instead of trying to write something by yourself.
>=20
> Regards
>=20
> Marcel
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
>=20


--=20
Bruno de Oliveira Abinader
10LE/INdT - GVoIP/UFAM


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
