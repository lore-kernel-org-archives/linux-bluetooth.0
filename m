Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Fri, 19 Oct 2007 13:23:03 -0600
From: Kevin Fenzi <kevin@scrye.com>
To: Jim Carter <jimc@math.ucla.edu>
Message-ID: <20071019132303.1ababb40@ghistelwchlohm.scrye.com>
In-Reply-To: <Pine.LNX.4.64.0710190839510.16412@simba.math.ucla.edu>
References: <20071018114517.4b6d1850@ghistelwchlohm.scrye.com>
	<Pine.LNX.4.64.0710181052500.28683@simba.math.ucla.edu>
	<20071018124830.58d558be@ghistelwchlohm.scrye.com>
	<Pine.LNX.4.64.0710190839510.16412@simba.math.ucla.edu>
Mime-Version: 1.0
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] bluetooth headset not working
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0655272392=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0655272392==
Content-Type: multipart/signed; boundary="Sig_/rg2=.5d82BW3_FGe65I1U84";
	protocol="application/pgp-signature"; micalg=PGP-SHA1

--Sig_/rg2=.5d82BW3_FGe65I1U84
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 19 Oct 2007 09:03:43 -0700 (PDT)
Jim Carter <jimc@math.ucla.edu> wrote:

> On Thu, 18 Oct 2007, Kevin Fenzi wrote:
>=20
> > On Thu, 18 Oct 2007 10:59:50 -0700 (PDT)
> > Jim Carter <jimc@math.ucla.edu> wrote:
> > > aplay or mplayer are talking to the ALSA device that uses the A2DP
> > > profile. The phone app needs to use the device with the HFP
> > > profile.
> >=20
> > Humm... do all headsets do A2DP? I thought mine did not.=20
>=20
> The ones with 2 earpieces and a mass of about 100 grams invariably
> (?) do A2DP which transmits stereo at 44100 Hz or 48000 Hz,
> compressed with the SBC codec.  The single-ear ones with a mass of
> about 20 grams invariably (?) do HSP/HFP, monaural at 8000 Hz, I
> think uncompressed.  That would be your Jabra BT 250v.  Some but not
> all of the music headsets can switch protocols and have call control
> buttons for HFP; these are advertised as "works with Skype".

Right. Thats my understanding as well.=20

> So the Jabra is capable of doing the HSP protocol, and when the
> message says the protocol is "not available", the problem is likely
> not in the headset.  Not likely that the headset is broken or has
> buggy firmware, but just for paranoia, it would be a good data point
> if the same message were seen with a different headset. =20

I can duplicate it with another headset here later...=20

> I've seen a similar message when I didn't have
> bluetoothd-service-audio configured to autostart and forgot to start
> it manually.  Do you have the corresponding protocol/profile daemon
> running?  I don't have my laptop handy to look up the name of this
> daemon but I think it's bluetoothd-service-sco.  This is in
> bluez-utils-3.19 (3.20 is latest; probably came in at 3.16.)

bluetoothd-service-audio?

Yeah, seems to run fine, but makes no difference in the output. ;(=20

> Unfortunately that's about the limit of my expertise, since I haven't=20
> messed with the HSP/HFP feature of the Motorola HT-820 that I have.

Bummer. Thanks for helping out!

If anyone else has any ideas I would love to get this working...

kevin


--Sig_/rg2=.5d82BW3_FGe65I1U84
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHGQQX3imCezTjY0ERAimmAKCMyOemG9AP+jIqr2fwWre+4bAV8ACePOcE
ZbO7BvLm4BUnAGgrY80pMLk=
=ZSQQ
-----END PGP SIGNATURE-----

--Sig_/rg2=.5d82BW3_FGe65I1U84--


--===============0655272392==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--===============0655272392==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0655272392==--
