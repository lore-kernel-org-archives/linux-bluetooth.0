Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Logitech MX900 oddities and solutions
From: Alexandre Ghisoli <alexandre.ghisoli@ycom.ch>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1078917101.2537.21.camel@pegasus>
References: <1078912919.32148.356.camel@metal.cisco.com>
	 <1078915401.2537.14.camel@pegasus>  <1078916559.6886.5.camel@pc-04.ycom.ch>
	 <1078917101.2537.21.camel@pegasus>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1078993556.24004.8.camel@pc-04.ycom.ch>
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
Date: Thu, 11 Mar 2004 09:25:56 +0100

Marcel,

Le mer 10/03/2004 =E0 12:11, Marcel Holtmann a =E9crit :
> Hi Alexandre,
> > > If you start the hcid it will modifiy your link policy settings and=
 it
> > > is important that RSWITCH and SNIFF is on.
> >=20
> > Mine is working fine ... without any mod or blood :-)
>=20
> What does "hciconfig hci0 lp" say?

hci0:   Type: USB
        BD Address: 00:07:61:08:76:70 ACL MTU: 192:8  SCO MTU: 64:8
        Link policy: HOLD SNIFF PARK

And my hcid.conf:
 	lp hold,sniff,hold,park;


So, what is the exact mean for RSWITCH ?

> > Maybe the next thing to do is to have a correct encryption link, of
> > course for the keyboard ( I don't think that mouse mouvements are ver=
y
> > important ...).
>=20
> If the HID device is a keyboard we must simply send and authentication
> request and then activate the encryption. Patches are welcome.

Huh, it's a good job for me, need some spare time ... :-(
Maybe in same time that the modification of bthid parser to have
function keys working for the keyboard.

best regards,=20

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
