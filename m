Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Thu, 18 Oct 2007 12:48:30 -0600
From: Kevin Fenzi <kevin@scrye.com>
To: Jim Carter <jimc@math.ucla.edu>
Message-ID: <20071018124830.58d558be@ghistelwchlohm.scrye.com>
In-Reply-To: <Pine.LNX.4.64.0710181052500.28683@simba.math.ucla.edu>
References: <20071018114517.4b6d1850@ghistelwchlohm.scrye.com>
	<Pine.LNX.4.64.0710181052500.28683@simba.math.ucla.edu>
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
Content-Type: multipart/mixed; boundary="===============0007582842=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0007582842==
Content-Type: multipart/signed; boundary="Sig_/kutvuOGsU/q2mE51Hy/IrVs";
	protocol="application/pgp-signature"; micalg=PGP-SHA1

--Sig_/kutvuOGsU/q2mE51Hy/IrVs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 18 Oct 2007 10:59:50 -0700 (PDT)
Jim Carter <jimc@math.ucla.edu> wrote:

> On Thu, 18 Oct 2007, Kevin Fenzi wrote:
>=20
> > I have setup my ~/.asoundrc.=20
> > I can play audio to my headset via mplayer or aplay fine.=20
> > When I try and set twinkle to use the ALSA bluetooth device it seems
> > like it opens the headset, and then it spits out:=20
> >=20
> > ALSA lib pcm_bluetooth.c:417:(bluetooth_hsp_hw_params) Protocol not
> > available (92)=20
>=20
> aplay or mplayer are talking to the ALSA device that uses the A2DP
> profile. The phone app needs to use the device with the HFP profile.

Humm... do all headsets do A2DP? I thought mine did not.=20

> It looks like you got that set up in .asoundrc since a plausible
> subroutine is reporting the error.  Next question: does your headset
> do HFP, or is it purely a music headset (A2DP)?  Some headsets,
> including the Motorola HT820, will auto-switch, but I think not every
> music headset will do so.  Hope this helps!

I am using a jabra BT 250v headset.=20
It's not a music headset.=20

I have a few more headsets I can dig up here to test with if you think
it's something with the jabra.=20

kevin

--Sig_/kutvuOGsU/q2mE51Hy/IrVs
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHF6p+3imCezTjY0ERAnE7AJ9IvBmXdrA/RudQx/NzPXBsYDRgpgCfbPHr
NYqHAwjtV9yLD/c50CB7gWw=
=MdwI
-----END PGP SIGNATURE-----

--Sig_/kutvuOGsU/q2mE51Hy/IrVs--


--===============0007582842==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--===============0007582842==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0007582842==--
