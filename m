Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Logitech MX900 oddities and solutions
From: Alexandre Ghisoli <alexandre.ghisoli@ycom.ch>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1078915401.2537.14.camel@pegasus>
References: <1078912919.32148.356.camel@metal.cisco.com>
	 <1078915401.2537.14.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1078916559.6886.5.camel@pc-04.ycom.ch>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 10 Mar 2004 12:02:39 +0100

Le mer 10/03/2004 =E0 11:43, Marcel Holtmann a =E9crit :

> > Second problem is that hid2hci needs to pass multibyte commands to th=
e
> > USB-BT hub and the -mh4 patch does not support that. I had to manuall=
y
> > overpatch the kernel with instructions found here:
> >=20
> > http://sourceforge.net/mailarchive/forum.php?thread_id=3D3803086&foru=
m_id=3D1883
> >=20
> > I would have expected this patch to be part of -mh4 (that is what I
> > remember having read) but it was not there. It should! :-) I can't wa=
it
> > to have the patches synced to the 2.6 kernel tree.
>=20
> I never said that I include the multi-byte patch into -mh4. It seems
> that some people assume this, but this is not true. Use diffstat to
> check the patch and you will see that it only changes Bluetooth stuff.

Strange ... with my 2.6.3 I don't use any other path for this .. :-)

> > Third problem is that hid2hci did not recognize my Logitech hub. Look=
ing
> > through the code showed that the vendor/product id's are hardcoded
> > (that's fair) but my device was not in the list. Here is an excerpt o=
f
> > lsusb:
> >=20
> > Bus 001 Device 009: ID 046d:c705 Logitech, Inc.
> >                                ^
> >                                |
> >      culprit ------------------+
> >=20
> > So I patched hid2hci to recognize 046d:c705 as a Logitech thingy. Bew=
are
> > that I bought the mouse in Belgium and there may be more unknown ID's=
 in
> > the world wild wireless mess (wireMess?).
>=20
> I add your device ID to the CVS.

Huh, Logitech has many device ID for same hardware ?
Maybe we need some clarification from Logitech .. :-)


> > Well... I stopped and restarted bthid (both versions) a gazillion tim=
es
> > with various options, disconnected all my wireless stuff at home to r=
ule
> > out interferences, re-paired the mouse,... without success; the mouse
> > was still jumpy. Until this morning when I compiled hcid (from util2
> > compat), launched it and restarted bthid. The mouse movement was supe=
r
> > fine! I am dumb wrt/ Bluetooth but I did not understand. So I stopped
> > hcid and bthid and restarted bthid alone (the Bluez one) and the mous=
e
> > still worked perfectly.
> >=20
> > Sounds like spraying chicken blood on the keyboard or doing the magic
> > dance. I am looking for an explanation... what has hcid got to do wit=
h
> > that ?
>=20
> If you start the hcid it will modifiy your link policy settings and it
> is important that RSWITCH and SNIFF is on.
>=20

Mine is working fine ... without any mod or blood :-)

Maybe the next thing to do is to have a correct encryption link, of
course for the keyboard ( I don't think that mouse mouvements are very
important ...).

regards,=20

	--Alexandre




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
