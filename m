Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Thu, 18 Oct 2007 11:45:17 -0600
From: Kevin Fenzi <kevin@scrye.com>
To: Bluez-devel@lists.sourceforge.net
Message-ID: <20071018114517.4b6d1850@ghistelwchlohm.scrye.com>
Mime-Version: 1.0
Subject: [Bluez-devel] bluetooth headset not working
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0230622132=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0230622132==
Content-Type: multipart/signed; boundary="Sig_/GomzaIeIW=+31KgwJDycWT/";
	protocol="application/pgp-signature"; micalg=PGP-SHA1

--Sig_/GomzaIeIW=+31KgwJDycWT/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Greetings.=20

I recently had a chance to look at the new bluez-utils and the setup
for headsets. Very much nicer than any of the old methods. :)=20

However, I can't seem to get my headset working with twinkle (or any
other phone app).=20

I have setup my ~/.asoundrc.=20
I can play audio to my headset via mplayer or aplay fine.=20
When I try and set twinkle to use the ALSA bluetooth device it seems
like it opens the headset, and then it spits out:=20

ALSA lib pcm_bluetooth.c:417:(bluetooth_hsp_hw_params) Protocol not
available (92)=20
ALSA lib pcm_bluetooth.c:417:(bluetooth_hsp_hw_params) Protocol not
available (92)

Then it goes to 100% cpu and unresponsive.=20

ALSA bug? or bluez-utils? Anyone seen this before or have
a work around?=20

twinkle-1.1-3.fc8.x86_64
alsa-lib-1.0.15-0.2.rc2.fc8.x86_64
bluez-utils-3.20-2.fc8.x86_64

I talked with the twinkle developers, and they say it's not an issue
with twinkle. See:=20
http://tech.groups.yahoo.com/group/twinklephone/message/1879?l=3D1

Happy to provide info or debugging... CC me for faster response.=20

kevin

--Sig_/GomzaIeIW=+31KgwJDycWT/
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHF5ut3imCezTjY0ERAnCVAJ4icCGkmyofl76Pq6fqSyHduPRzIgCgjvmX
ejrgHfpnJGnxzr784oSUVXk=
=XEh6
-----END PGP SIGNATURE-----

--Sig_/GomzaIeIW=+31KgwJDycWT/--


--===============0230622132==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--===============0230622132==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0230622132==--
