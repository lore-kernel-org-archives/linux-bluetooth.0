Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Tue, 23 Oct 2007 06:26:42 -0600
From: Rob Sims <bluez-z@robsims.com>
To: bluez-users@lists.sourceforge.net
Message-ID: <20071023122642.GA28699@robsims.com>
MIME-Version: 1.0
Subject: Re: [Bluez-users] ISCAN drop automically ...
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0403102173=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


--===============0403102173==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 23, 2007 at 11:54:27AM +0200, Pierre Savary wrote:
> I have a problem with the hci configuration of my device. On hcid.conf I
> have "iscan enable" but ISCAN flag drop automatically after some timeout
> ...??? Why? It is the same thing when I make " $ hciconfig hci0 iscan" on
> the console.

Check out the discovto option in hcid.conf.  Documentation of this
behavior is relatively scarce.
--=20
Rob

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHHeiCnvKppSZW8osRAi+0AKCM07NV2ZThsNomrOZZA+nBvUbQWACgjGWl
q07GRwY4tsxeCyPlIg05Mss=
=ymMM
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--


--===============0403102173==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--===============0403102173==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0403102173==--
