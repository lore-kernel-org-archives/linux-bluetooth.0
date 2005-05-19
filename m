Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Tobias Lang <tobias-lang@gmx.de>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Hama BT1000 Headset Problems
Message-ID: <20050519143928.340d4b22@localhost.localdomain>
In-Reply-To: <428BBFD2.7040304@xmission.com>
References: <20050515145042.70745815.tobias-lang@gmx.de>
	<428761F9.7070805@xmission.com>
	<20050515192044.659654d3.tobias-lang@gmx.de>
	<4287A0A1.80309@xmission.com>
	<20050515223523.639551bf.tobias-lang@gmx.de>
	<4287BCAB.8050600@xmission.com>
	<20050518163116.149369f3@localhost.localdomain>
	<428BBFD2.7040304@xmission.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary="Signature_Thu__19_May_2005_14_39_28_+0200_qL48Zthbz8RE/Qh1";
 protocol="application/pgp-signature"; micalg=pgp-sha1
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
Date: Thu, 19 May 2005 14:39:28 +0200

--Signature_Thu__19_May_2005_14_39_28_+0200_qL48Zthbz8RE/Qh1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 May 2005 16:21:06 -0600
Brad Midgley <bmidgley@xmission.com> wrote:

> i don't know how solid our command-line processing is, so try btsco with 
> the -v before the address.
> 

Still makes no difference.
Userland output in Normal-Mode:

$~:   btsco -v <headset>
	btsco v0.4b
	Device is 1:0
	Error: Failed to connect to SDP server: Function not implemented
	Assuming channel 2

	Voice setting: 0x0060
	Can't connect RFCOMM channel: Resource temporarily unavailable

And in Pairing-Mode:

~$ btsco -v <headset>
	btsco v0.4b
	Device is 1:0
	Voice setting: 0x0060
	Can't connect RFCOMM channel: Permission denied

Regards, Tobi
--Signature_Thu__19_May_2005_14_39_28_+0200_qL48Zthbz8RE/Qh1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCjIkIjxmcDuHlx5oRAureAJ4pOS4KJTMNgV1GL6yJNVMB35BG7ACeM2Ve
1JY/NUx4XgYvEn73WUuPWHE=
=bIe1
-----END PGP SIGNATURE-----

--Signature_Thu__19_May_2005_14_39_28_+0200_qL48Zthbz8RE/Qh1--


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
