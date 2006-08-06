Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Sun, 6 Aug 2006 17:30:43 -0300
From: redondos <redondos@gmail.com>
To: digitalfredy@debiancolombia.org,
        BlueZ users <bluez-users@lists.sourceforge.net>
Message-ID: <20060806203043.GA17698@refinery.twat.com.ar>
References: <20060803043158.GA13259@refinery.twat.com.ar>
	<1154888079.7923.13.camel@YODA>
Mime-Version: 1.0
In-Reply-To: <1154888079.7923.13.camel@YODA>
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
Content-Type: multipart/mixed; boundary="===============1032548392=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


--===============1032548392==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 06 13:14, digitalfredy wrote:
> El jue, 03-08-2006 a las 01:31 -0300, redondos escribi=F3:
> > Hello, list. This is my first post.
> >=20
> > I just got myself a Bluetooth 1.2 USB dongle, listed by `lsusb' as:
> > Bus 004 Device 005: ID 1131:1001 Integrated System Solution Corp.
> > KY-BT100 Bluetooth Adapter
> >=20
> > I have a Sony Ericsson Z520a phone, which incorporates a bluetooth and
> > infrared adapter.
> >=20
> > I am using BlueZ (libs, utils) version 2.25 on a Gentoo system.
> >=20
> > uname -a:
> > Linux refinery.twat.com.ar 2.6.16-suspend2-r8 #1 PREEMPT Mon Jul
> > 31 19:05:52 ART 2006 i686 AMD Athlon(TM) XP 2400+ GNU/Linux
> >=20
> > I have 3 main goals:
> > 1) Transfer files between my computer and the phone.
> ok in this i think to i can help you.
> sdptool browse 00:16:20:F1:47:68 and review the chanel for and search
> the channel for OBEX File Transfer for use this in the -B option,
> reading your log i see chanel 6
> $ obexftp -b 00:16:20:F1:47:68 -B 6 -l

Unfortunately, that doesn't work. In fact I can get a listing without=20
specifying the channel since obexftp autodetects the channel when you
don't, and that works fine. The problem is with file transfers.

[1038] # obexftp -b 00:16:20:F1:47:68 -B 6 -l
Browsing 00:16:20:F1:47:68 ...
Channel: 6
Connecting...done
Receiving "(null)"... <?xml version=3D"1.0" encoding=3D"UTF-8"?>
<!DOCTYPE folder-listing SYSTEM "obex-folder-listing.dtd">
<!--
 XML Coder, Nov 14 2005, 23:41:10, (C) 2001 Sony Ericsson Mobile Communicat=
ions AB=20
-->
<folder-listing version=3D"1.0"><folder name=3D"Pictures"/>
<folder name=3D"Sounds"/>
<folder name=3D"Themes"/>
<folder name=3D"Videos"/>
<folder name=3D"Other"/>
</folder-listing>
done
Disconnecting...done

[1042] # obexftp -b 00:16:20:F1:47:68 -B 6 -c Other
Browsing 00:16:20:F1:47:68 ...
Channel: 6
Connecting...done
Sending "Other"... done
Disconnecting...done

[1043] # obexftp -b 00:16:20:F1:47:68 -B 6 -p paella.txt=20
Browsing 00:16:20:F1:47:68 ...
Channel: 6
Connecting...done
Sending "paella.txt"...\failed: paella.txt
Disconnecting...failed: disconnect

[1047] # obexftp -b 00:16:20:F1:47:68 -B 6 -c Contacts
Browsing 00:16:20:F1:47:68 ...
Channel: 6
Connecting...done
Sending "Contacts"... failed: Contacts
Disconnecting...done

[1048] # obexftp -b 00:16:20:F1:47:68 -B 6 -p std.vcf=20
Browsing 00:16:20:F1:47:68 ...
Channel: 6
Connecting...done
Sending "std.vcf"...\failed: std.vcf
Disconnecting...failed: disconnect

> If this run write again and i send you my shell script for auto download
> pictures, images ...
> > 2) Synchronize my PIM with the phone.
> you can use evolution and multisync
> more info in
> http://es.wikibooks.org/wiki/Hacks_para_sistemas_operativos_Unix-like/Red=
es/Bluetooth/Linux (spanish but easy to understand reading the comands)

Yeah, thanks. I'm using Opensync with kdepim for this, but also have some c=
onnection=20
problems. This isn't a BlueZ question, so I'll leave it for the Opensync gu=
ys.

--=20
redondos

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)

iD8DBQFE1lFzJZ/yCc25j3IRAi83AJ94ucpIDCZ6RUuo8U6WuNL67BI96wCgrBmO
kDh0wutwcoR+t0VJWp/QJ44=
=khJ9
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--


--===============1032548392==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1032548392==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1032548392==--
