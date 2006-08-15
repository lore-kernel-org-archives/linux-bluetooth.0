Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Mon, 14 Aug 2006 23:05:21 -0300
From: redondos <redondos@gmail.com>
To: bluez-users@lists.sourceforge.net
Message-ID: <20060815020521.GE15576@refinery.twat.com.ar>
References: <20060803043158.GA13259@refinery.twat.com.ar>
MIME-Version: 1.0
In-Reply-To: <20060803043158.GA13259@refinery.twat.com.ar>
Subject: Re: [Bluez-users] Cannot transfer files via OBEX
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0514292309=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


--===============0514292309==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fWddYNRDgTk9wQGZ"
Content-Disposition: inline


--fWddYNRDgTk9wQGZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Just to remind you all of my problem, here's a short log that makes it crys=
tal=20
clear.                                                                     =
              =20
                                                           =20
Summary: Can *always* download, can *never* upload.=20

redondos@injector redondos $ obexftp -b 00:16:20:F1:47:68 -B 6 -c Sounds -l
Browsing 00:16:20:F1:47:68 ...
Channel: 6
Connecting...done
Sending "Sounds"... done
Receiving "(null)"...\<?xml version=3D"1.0" encoding=3D"UTF-8"?>
<!DOCTYPE folder-listing SYSTEM "obex-folder-listing.dtd">
<!--
 XML Coder, Nov 14 2005, 23:41:10, (C) 2001 Sony Ericsson Mobile Communicat=
ions AB=20
-->
<folder-listing version=3D"1.0"><parent-folder/>
<file name=3D"Wake Up.mp3" size=3D"28212"/>
<file name=3D"Up&apos;N&apos;Away.mp3" size=3D"115992"/>
<file name=3D"Storytelling.mp3" size=3D"41404"/>
<file name=3D"Sony Ericsson.mid" size=3D"1060"/>
<file name=3D"Robot Groove.mp3" size=3D"43494"/>
<file name=3D"Phone Party.mp3" size=3D"41535"/>
<file name=3D"Overdub.mp3" size=3D"95040"/>
<file name=3D"Nueva Instrm.mp3" size=3D"386996"/>
<file name=3D"Jungle Calling.mp3" size=3D"33567"/>
<file name=3D"Greeting.mid" size=3D"5950"/>
<file name=3D"Itch Ni San.mp3" size=3D"95472"/>
<file name=3D"Industrial Alert.mp3" size=3D"51069"/>
<file name=3D"Cruisin.mp3" size=3D"53943"/>
<file name=3D"Choo-Choo.mp3" size=3D"47020"/>
<file name=3D"Bounce.mp3" size=3D"95084"/>
<file name=3D"Block Party.mp3" size=3D"57208"/>
<file name=3D"Bells of Joy.mp3" size=3D"48718"/>
<file name=3D"@The Place.mp3" size=3D"103943"/>
<file name=3D"MusicDJ Demo.mid" size=3D"10796"/>
<file name=3D"9PM-1.mp3" size=3D"443535"/>
<file name=3D"My melody.mid" size=3D"2231"/>
<file name=3D"Train (free) - Free .dcf" size=3D"82150"/>
<file name=3D"eurotrip - mail moth.mp3" size=3D"25913"/>
<folder name=3D"Videodj"/>
<folder name=3D"Ringtones"/>
</folder-listing>
done
Disconnecting...done
redondos@injector redondos $ obexftp -b 00:16:20:F1:47:68 -B 6 -c Sounds -g=
 Overdub.mp3
Browsing 00:16:20:F1:47:68 ...
Channel: 6
Connecting...done
Sending "Sounds"... done
Receiving "Overdub.mp3"...|done
Disconnecting...done
redondos@injector redondos $ mv Overdub.mp3 Overdub2.mp3
redondos@injector redondos $ obexftp -b 00:16:20:F1:47:68 -B 6 -c Sounds -p=
 Overdub2.mp3
Browsing 00:16:20:F1:47:68 ...
Channel: 6
Connecting...done
Sending "Sounds"... done
Sending "Overdub2.mp3"...\failed: Overdub2.mp3
Disconnecting...failed: disconnect
redondos@injector redondos $ obexftp -b 00:16:20:F1:47:68 -B 6 -p Overdub2.=
mp3
Browsing 00:16:20:F1:47:68 ...
Channel: 6
Connecting...done
Sending "Overdub2.mp3"...\failed: Overdub2.mp3
Disconnecting...failed: disconnect

--=20
redondos

--fWddYNRDgTk9wQGZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)

iD8DBQFE4SvhJZ/yCc25j3IRAsBOAKCOZvOTQrSgIyetqudurK6Fb8bPWgCeNrtS
farkZ+lJ2LQ4cGViaREDRBk=
=pVoa
-----END PGP SIGNATURE-----

--fWddYNRDgTk9wQGZ--


--===============0514292309==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0514292309==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0514292309==--
