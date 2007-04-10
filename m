Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Thomas Kear <thomas.kear@gmail.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Date: Wed, 11 Apr 2007 08:47:53 +1200
References: <57c68ddc0704071440m7b05678fs5c3bea4d2cf28a4c@mail.gmail.com>
	<2b1fa7660704080119s2275a60dm40655cbf9d6b3ba7@mail.gmail.com>
	<57c68ddc0704100617s3beb9f5cq52cc594522d27d08@mail.gmail.com>
In-Reply-To: <57c68ddc0704100617s3beb9f5cq52cc594522d27d08@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200704110847.58296.thomas.kear@gmail.com>
Subject: Re: [Bluez-users] using class 1 dongle
Reply-To: thomas.kear@gmail.com,
        BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1551579834=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1551579834==
Content-Type: multipart/signed; boundary="nextPart1300689.8HGi3V9zYb";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1300689.8HGi3V9zYb
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wed, 11 Apr 2007, siddhant tewari wrote:
>                  Really great to get a answer ... i think my mobile phone
> has class 2 bt adapter ... but this issue is a real shock for me ... i
> thought if any of the devices has a good range , communication channel wi=
ll
> be established and data transfer will take place , but all this theory go=
es
> in vain .
The problem is as simple as transmit power.  As wikipedia helpfully shows=20
(http://en.wikipedia.org/wiki/Bluetooth#Uses), class 1 devices can have 40=
=20
times the transmit power of class 2 devices, the class 1 connecting to clas=
s=20
2 problem comes down to that past a certain range, the class 2 device does=
=20
not have a high enough transmit power for its signal to reach the reciever=
=20
(2.4GHz signals are eaten particularly fast by everything in their path,=20
including air).

As i outlined before, the higher transmit power in a class 1 device will co=
me=20
coupled to a higher sensitivity reciever, but that's not going to get you=20
100m.  If you had got the 30-40 metres you were attempting in your original=
=20
email you would have been extremely lucky.

The problem is there are very few phones that come with class 1 bluetooth,=
=20
100mW transmit power is a little hard on battery life.  If you want a=20
challenge though, find a class1 bluetooth adapter that has a dipole aerial=
=20
rather than the usual circuit board trace and attach a bigger one.

--nextPart1300689.8HGi3V9zYb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.3 (GNU/Linux)

iD8DBQBGG/f+8/Qi7qeDfygRAh4EAKCkolUP+8SbzkuonzKD6/sXM8ZvvgCbBRhC
KYEBIcY7gdAsagKLRruCztU=
=9moC
-----END PGP SIGNATURE-----

--nextPart1300689.8HGi3V9zYb--


--===============1551579834==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1551579834==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1551579834==--
