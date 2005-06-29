Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <537e39c905062907433980aa7f@mail.gmail.com>
From: Jordi Jaen Pallares <jordijp@gmail.com>
To: bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_7075_14945350.1120056231664"
Subject: [Bluez-users] Key exchange before pairing
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
Date: Wed, 29 Jun 2005 16:43:51 +0200

------=_Part_7075_14945350.1120056231664
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi @ll !


I would like to know if it is possible to perform a "peer key exchange"=20
prior to the pairing operation, in order to for example, have the peers=20
exchange some extra information about them and be able for example to=20
look-up different PINs for every different service / connection / device.

I have written a little program using rfcomm sockets (although I am planing=
=20
to change them to BNEP ones) which carries out the data exchange without=20
problems as long as the security manager is set to 'none'.

But I would like to be able to replace the normal pairing procedure with=20
this "key exchange between bluetooth peers" procedure:=20

* it is then possible to trigger (maybe via 'pin_helper' ?) a data exchange=
=20
between the two bluetooth sockets (using raw L2CAP sockets, for example)=20
while the devices are _not paired_ and while the security level is set at=
=20
least to authentication ?

* I tried to change the rfcomm "working" sockets program to L2CAP sockets,=
=20
but then I don=B4t know which Protocol Service MUX (psm) value I might have=
 to=20
set for this sockets to have them connect successfully (the one from an=20
already existing service, one of the reserved values?!).=20

I tried different odd values greater than 1 for the psm (using htobs(psm))=
=20
and I get the following error message:=20

Cannot connect to socket: Connection refused (111)

I would really appreciate it if you could help me out or give me some advis=
e=20
on these topics.


Best Regards,


Jordi

------=_Part_7075_14945350.1120056231664
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi @ll !<br>
<br>
<br>
I would like to know if it is possible to perform a &quot;peer key
exchange&quot; prior to
the pairing operation, in order to for example, have the peers exchange
some extra information about them and be able for example to look-up
different PINs for every different service / connection / device.<br>
<br>
I have written a little program using rfcomm sockets (although I am
planing to change them to BNEP ones) which carries out the data
exchange without problems as long as the security manager is set to
'none'.<br>
<br>
But I would like to be able to replace the normal pairing procedure with th=
is &quot;key exchange between bluetooth peers&quot; procedure: <br>
<br>
* it is then possible to trigger (maybe via 'pin_helper' ?) a data exchange
between the two bluetooth sockets (using raw L2CAP sockets, for example)
while the devices are _not paired_ and while the security level is set
at least to authentication ?<br>
<br>
* I tried to change the rfcomm &quot;working&quot; sockets program to L2CAP
sockets, but then I don=B4t know which&nbsp; Protocol Service MUX (psm)
value I might have to set for this sockets to have them connect
successfully (the one from an already existing service, one of the
reserved values?!). <br>
<br>
I tried different odd values greater than 1 for the psm (using htobs(psm)) =
and I get the following error message: <br>
<br>
Cannot connect to socket: Connection refused (111)<br>
<br>
I would really appreciate it if you could help me out or give me some advis=
e on these topics.<br>
<br>
<br>
Best Regards,<br>
<br>
<br>
Jordi<br>



------=_Part_7075_14945350.1120056231664--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
