Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Mats Erik Andersson <mats.andersson64@comhem.se>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <1183623040.6351.85.camel@aeonflux.holtmann.net>
References: <1183412947.20815.7.camel@localhost>
	<1183433596.6351.25.camel@aeonflux.holtmann.net>
	<1183462763.4335.17.camel@localhost>
	<1183513706.6351.47.camel@aeonflux.holtmann.net>
	<1183556624.4951.10.camel@localhost>
	<1183623040.6351.85.camel@aeonflux.holtmann.net>
Date: Fri, 06 Jul 2007 11:53:30 +0200
Message-Id: <1183715610.5288.22.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] dbus problem for pand service
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Marcel,

tor 2007-07-05 klockan 10:10 +0200 skrev Marcel Holtmann:
> Hi Mats,
> =

> > > by default pand listens on all attached dongles. So that should work =
out
> > > of the box.
> > > =

> > =

> > I made an addition to the dbus-configuration in bluez-hcid.conf by
> > inserting paths for hci0 and hci1 for root and console like this:
> > =

> > After that a single listening PAN daemon is receptive on both
> > usb-dongles.

> that is non-sense. The pand is not interacting with D-Bus at all. Some
> other changes must have made this working for you.


a harsh word to call it 'non-sense' (zum st=FCtzig machen!). True, pand
does not by itself call upon dbus, but the servicing daemon hcid does
depend on dbus and all the more does passkey-agent for the
authentications of pin codes depend in dbus. The standard code
passkey-agent.c even contains

if (use_default) {
       path =3D "/org/bluez";
       method =3D "RegisterDefaultPasskeyAgent";
} else {
       path =3D "/org/bluez/hci0";
       method =3D "RegisterPasskeyAgent";
}

and the corresponding part for unregistering. It seems to me that =

thus it is absolutely essential to use 'passkey-agent -d OpenUp'
to activate more than one dongle, since individual agents always
tie themselfs to hci0. I do not understand all details yet, but the
above code snippet shows that I will develop my own tailored
passkey-agent for my own application. That is the natural state of
affairs in our trade. Right! One always learn most by the mistakes
and by scrutinizing our source code. =


Regards     Mats E A


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
