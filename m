Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Sebastian =?iso-8859-15?q?Clau=DF?= <sc2@inf.tu-dresden.de>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Encrypted and unencrypted connections at the same time
References: <200502141659.45030.sc2@inf.tu-dresden.de> <200502150854.03601.sc2@inf.tu-dresden.de> <1109028529.7626.51.camel@pegasus>
In-Reply-To: <1109028529.7626.51.camel@pegasus>
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200502251745.50101.sc2@inf.tu-dresden.de>
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
Date: Fri, 25 Feb 2005 17:45:45 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am Dienstag, 22. Februar 2005 00:28 schrieb Marcel Holtmann:
> Hi Sebastian,
>
> > > > I have a MS optical desktop elite (mouse and keyboard).
> > > > The keyboard supports an encrypted connection, but the mouse doesn't.
> > > > So, I want to enable encryption and authentication by default,
> > > > but want to disable it for the mouse.
> > > > When I enable authentication/encryption, the laptop wants to make a
> > > > secure connection also to the mouse, but obviously this does not
> > > > work. So, I have to switch authentication/encryption off temporarily
> > > > to connect to the mouse, and then enable it again.
> > >
> > > you switch into security mode 3 and don't know what it is.
> >
> > Hmm, my description was not really correct: I start with security mode 3
> > (encryption/authentication), wait until the keyboard is connected, then
> > switch off encryption/authentication, wait until the mouse is connected,
> > then switch back to security mode 3. So, the keyboard connection is
> > encrypted, but the mouse connection not.
>
> haven't you thought that this might be a wrong thing and that we have a
> better solution for it ;)
>
Of course my "solution" might be wrong, I just was not sure, whether my 
initial explanation described this "solution" correctly. 

> > > > Is there a way configure hcid or hidd in a way, e.g. by hcid.conf,
> > > > so that this setting is recognized automatically (i.e. a special
> > > > configuration for the mouse)?
> > >
> > > Try to start the hidd --server with the --encrypt switch. It should
> > > then request encryption for the keyboards.
> >
> > This does not work (hidd: unrecognized option `--encrypt').
> > (I use bluez-utils 2.10).
>
> The latest release is bluez-utils-2.15.
>
Sorry, I was not aware of it. Now it works as expected, your solution, I 
mean :-)

best regards

Sebastian

- -- 
- ----------------------------------------------------
Sebastian Clauﬂ
E-Mail: sc2@inf.tu-dresden.de
- ----------------------------------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCH1Y+SVQ1ElZ3E0oRApDDAKDkZzDEF5mMX167Jcf8b619Ta5s/ACdFWIX
DztzJ8pBHxNKnYcFj5qxPh4=
=3Xmy
-----END PGP SIGNATURE-----


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
