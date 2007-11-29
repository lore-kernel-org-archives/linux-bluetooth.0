Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Thu, 29 Nov 2007 08:55:27 -0700
From: Rob Sims <bluez-z@robsims.com>
To: bluez-users@lists.sourceforge.net
Message-ID: <20071129155526.GA17661@robsims.com>
References: <20070522161255.GA9813@robsims.com>
MIME-Version: 1.0
In-Reply-To: <20070522161255.GA9813@robsims.com>
Subject: Re: [Bluez-users] Sharing devices with dual-booted Windows
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1964788384=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


--===============1964788384==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Back in May, I posted a query:

On Tue, May 22, 2007 at 10:12:55AM -0600, Rob Sims wrote:
> I have several devices that I use with both Linux and Windows on the
> same laptop.  The issue is that the remote devices, such as my PDA, see
> the laptop as the same device no matter what OS is running, and pairing
> is broken.
=20
> I need some way to either make the Windows and Linux stacks present a
> unified front in terms of pairing, or alter the adapter address while in
> Linux so that the laptop appears to be a different device.  Altering the
> name alone in hcid.conf is insufficient.
=20
> Currently, when switching OS, I must manually delete the pairing from my
> PDA, then re-pair the device.
=20
> Is there a way to override the preprogrammed address with a user
> specified one, as you can do with network MAC addresses?  The adapter is
> a built-in hci_usb driven device.

and got a response that was more a side comment than an answer.

In July, John Smith posted a similar query, and Brad Midgley responded:
} The problem is both operating systems share the same adapter but don't
} share any of the state that is built up during pairing.

} You could change between two bluetooth adapters on your computer so
} the phone doesn't get confused. There are even hacks where you use
} just one adapter and temporarily change the mac addr on the adapter
} when under linux.

John Smith's followup message asking for such a hack went unanswered.

Is the bdaddr an unchangeable part of the hardware, or is it soft, like
the MAC addresses of virtually all network cards?

If it's soft, how does one assign the desired "fake" bdaddr to the host
adapter?  With network devices, 'ifconfig hw' does the job.

Alternatively, can the pairing info be extracted from the Windows side
and translated to the Linux side?
--=20
Rob

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHTuDunvKppSZW8osRAgu7AKCELtuhF9KTAYtGrq7H6sZKE902SgCeOhEF
DmBr/FD2uizVXI0gnvXlk0o=
=ZUy6
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--


--===============1964788384==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
--===============1964788384==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1964788384==--
