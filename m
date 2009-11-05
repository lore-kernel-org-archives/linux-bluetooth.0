Return-Path: <cyrus@holtmann.org>
From: =?iso-8859-1?q?Jos=E9_Antonio_Santos_Cadenas?=
	<jcaden@libresoft.es>
Reply-To: jcaden@libresoft.es
To: linux-bluetooth@vger.kernel.org
Subject: Problems opening connections for an HDP implementation.
Date: Thu, 5 Nov 2009 15:51:37 +0100
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2500874.orbuAiIFEr";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <200911051551.40829.jcaden@libresoft.es>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--nextPart2500874.orbuAiIFEr
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi everybody,

I am developing a free/open source implementation of HDP using sancane's MC=
AP=20
implementation. I am using ERTM and STREAMING mode provided by Gustavo's=20
patches from 3th October. I've been testing my implementation between two=20
computers (both of them using the previously mentioned profiles). This test=
=20
seems working correctly but I am also trying to test it against a Nonin Oni=
x=20
II 9560BT PulseOximeter (certified by Continua). This device is using HDP b=
ut=20
when I try to test my HDP implementation I've observed that the MCAP contro=
l=20
channel L2CAP connection is not correctly opened (see trace bellow)

=2E..
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 46 packets 1
> ACL data: handle 46 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 49704 scid 0x0041
< ACL data: handle 46 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0041 result 0 status 0
      Connection successful
=2E...

There is a thread waiting for incoming connections on this psm, but it is=20
never waked up from the recv system call.

=2E....
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 46 packets 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:1C:05:00:19:56
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 00:1C:05:00:19:56 key DD4D176E23CDB1D95334CD8A7D077773
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 00:1C:05:00:19:56
> HCI Event: Encrypt Change (0x08) plen 4
    status 0x00 handle 46 encrypt 0x01
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 46
=2E...
This part of the trace is repeated until local host closes L2CAP connection.
=2E...

< ACL data: handle 46 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0041 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 46 packets 1
> ACL data: handle 46 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0040
=2E...

> HCI Event: Command Complete (0x0e) plen 7
    Read Transmit Power Level (0x03|0x002d) ncmd 1
    status 0x00 handle 46 level 3
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 46 reason 0x13
    Reason: Remote User Terminated Connection
> HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 46 reason 0x16
    Reason: Connection Terminated by Local Host


What am I doing wrong? Why the connection to this socket is not finished?

If you are interested in the complete trace I can send it to you.


Thank you very much.
Regards.

Jose.


=20


--nextPart2500874.orbuAiIFEr
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkry5nkACgkQ35o/gIXgrCeavwCg6eZuAYEBrbAmIOzug/UjCzzN
8nAAn3FSX5W2YHUG+685xpV0HTasN1FP
=HMuG
-----END PGP SIGNATURE-----

--nextPart2500874.orbuAiIFEr--
