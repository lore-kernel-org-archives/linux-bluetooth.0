Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Key exchange before pairing
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <537e39c905062907433980aa7f@mail.gmail.com>
References: <537e39c905062907433980aa7f@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1120067870.15397.134.camel@pegasus>
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
Date: Wed, 29 Jun 2005 19:57:50 +0200

Hi Jordi,

> I would like to know if it is possible to perform a "peer key
> exchange" prior to the pairing operation, in order to for example,
> have the peers exchange some extra information about them and be able
> for example to look-up different PINs for every different service /
> connection / device.
>=20
> I have written a little program using rfcomm sockets (although I am
> planing to change them to BNEP ones) which carries out the data
> exchange without problems as long as the security manager is set to
> 'none'.
>=20
> But I would like to be able to replace the normal pairing procedure
> with this "key exchange between bluetooth peers" procedure:=20
>=20
> * it is then possible to trigger (maybe via 'pin_helper' ?) a data
> exchange between the two bluetooth sockets (using raw L2CAP sockets,
> for example) while the devices are _not paired_ and while the security
> level is set at least to authentication ?
>=20
> * I tried to change the rfcomm "working" sockets program to L2CAP
> sockets, but then I don=B4t know which  Protocol Service MUX (psm) valu=
e
> I might have to set for this sockets to have them connect successfully
> (the one from an already existing service, one of the reserved
> values?!).=20
>=20
> I tried different odd values greater than 1 for the psm (using
> htobs(psm)) and I get the following error message:=20
>=20
> Cannot connect to socket: Connection refused (111)
>=20
> I would really appreciate it if you could help me out or give me some
> advise on these topics.

actually I have no idea what you are trying to achieve. Try to include
examples, because I can't follow you.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
