Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <449C0CEB.1020805@hasborg.com>
Date: Fri, 23 Jun 2006 11:46:51 -0400
From: Joshua Wright <jwright@hasborg.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <E2C96E1D-1581-40B1-84F6-C7528EEA2007@pepper.com>
In-Reply-To: <E2C96E1D-1581-40B1-84F6-C7528EEA2007@pepper.com>
Subject: Re: [Bluez-devel] CSR hci continuous transmit mode?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Michael Frey wrote:
> Does anyone know how to put a CSR Bluecore chip into continuous  
> transmit mode using hcitool?

Not with hcitool, check bccmd in the bluez-utils package.

- -Josh
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEnAzqTS8i9jZYpL8RAm/YAJ9/3kIXLQwUZROKoJuQbFNtyC4UswCg3w3D
Z1sDtxlYvpX8qNf7sa7O3Vk=
=3/G+
-----END PGP SIGNATURE-----

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
