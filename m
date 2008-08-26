Return-Path: <cyrus@holtmann.org>
Date: Tue, 26 Aug 2008 17:35:45 +0100
From: martin f krafft <madduck@madduck.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20080826163544.GA5068@lapse.rw.madduck.net>
References: <20080822073628.GA5989@piper.oerlikon.madduck.net>
	<1219394015.7591.441.camel@violet.holtmann.net>
MIME-Version: 1.0
In-Reply-To: <1219394015.7591.441.camel@violet.holtmann.net>
Subject: [Bluez-devel] btusb+sco failing to play sound through Jabra BT500v
	headset (was:	 SCO flowcontrol patch v4.4 on 2.6.25/6
	causes)	hardlocks when connecting to BT device
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1179921524=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--===============1179921524==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Marcel Holtmann <marcel@holtmann.org> [2008.08.22.0933 +0100]:
> what about not using that patch at all? I am using the new audio
> interface without that patch. And you wanna use the btusb driver
> and since 2.6.27-rc4 that one actually has SCO support.

If I had known... :)

Unfortunately, I have not yet succeeded. I modprobed 'sco' and then
ran headsetd as before, but that just prints

  headsetd[9417]: Bluetooth headset daemon version 0.5
  headsetd[9417]: Configuration phase ended: target bdaddr is 00:1A:45:14:E=
E:D7, timeout is 90000 ms
  headsetd[9417]: Changing state: Idle-->Paging
  headsetd[9417]: Changing state: Paging-->Connecting
  headsetd[9417]: Changing state: Connecting-->Ready
  headsetd[9417]: Changing state: Ready-->Opening

At this point, the headset makes the sound it makes when
a connection is established, but there is no sound coming from it.

After about 40 seconds, the client says:

  aplay: main:564: audio open error: Connection timed out

and headsetd writes:

  headsetd[9417]: unable to open SCO channel to headset: Connection timed o=
ut
  headsetd[9417]: Changing state: Opening-->ZombieAppl
  headsetd[9417]: Appli closed socket
  headsetd[9417]: Changing state: ZombieAppl-->Idle

So something's still broken... :(

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
never underestimate the power of human stupidity.
=20
spamtraps: madduck.bogus@madduck.net

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAki0MN0ACgkQIgvIgzMMSnWP2ACgyKFyMkZnyKGU72D3r13hacKT
ZQoAnihtcoyI95JJnCyqFmyMn9Sii3w+
=luzp
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--


--===============1179921524==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============1179921524==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1179921524==--
