Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Craig Shelley <craig@microtron.org.uk>
To: bluez-users@lists.sourceforge.net
Date: Sun, 13 Aug 2006 20:26:10 +0100
Message-Id: <1155497170.5142.24.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [Bluez-users] Problems using Zoom 4310 USB Bluetooth Dongle
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1114128928=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


--===============1114128928==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-GFqNaKeKIS7m7sukPsw5"


--=-GFqNaKeKIS7m7sukPsw5
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

After upgrading bluez-utils from version 2.25 to version 3.1, my
bluetooth has stopped working.

I get the following error in syslog:
Aug 13 19:48:07 localhost hcid[5991]: Bluetooth HCI daemon
Aug 13 19:48:07 localhost hcid[5991]: Register path:/org/bluez
fallback:1
Aug 13 19:48:07 localhost hcid[5991]: Device hci0 has been added
Aug 13 19:48:07 localhost hcid[5991]: Can't write inquiry mode for hci0:
Input/output error (5)
Aug 13 19:48:07 localhost hcid[5991]: Register path:/org/bluez/hci0
fallback:0
Aug 13 19:48:07 localhost hcid[5991]: HCI dev 0 up
Aug 13 19:48:07 localhost hcid[5991]: Starting security manager 0
Aug 13 19:48:08 localhost hcid[5991]: Can't write inquiry mode for hci0:
Input/output error (5)

If I downgrade to version 2.25 everything works again.
I have also tried the latest CVS, and although the error message does
not appear, my phone is still unable to find my PC when searching for
devices.

"hcitool scan" does however return positive results:

I have two systems is running debian etch, one (desktop) with 2.6.17.8
and the other (laptop) with 2.6.16.2.
I am using a Zoom 4310 USB dongle, as described on the following
datasheet:
http://www.zoom.com/graphics/datasheets/bluetooth/BT_4310BF_BT_4312AF_1716.=
pdf

Any help/advice is greatly appreciated. I am willing to help diagnose
what is going wrong, I just need pointing in the right direction.

Many Thanks,

PS - I am not on this list so please CC me.

--=20
Craig Shelley
EMail: craig@microtron.org.uk
Jabber: shell@jabber.earth.li

--=-GFqNaKeKIS7m7sukPsw5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBE33zS5OI9vmOoVqERAq3WAKCItKARcS9DuKN8IQq8aixIFdxbRACeNUbC
/CCs4FmGVeymSRPod08NF2E=
=OTzo
-----END PGP SIGNATURE-----

--=-GFqNaKeKIS7m7sukPsw5--



--===============1114128928==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1114128928==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1114128928==--
