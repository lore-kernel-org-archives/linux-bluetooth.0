Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Mon, 8 Jan 2007 14:37:27 -0700
From: Kevin Fenzi <kevin@scrye.com>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20070108143727.5d5f9b01@ningauble.scrye.com>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] 2 plugz issues
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0449508485=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0449508485==
Content-Type: multipart/signed; boundary=Sig_YxVLK305es8bx09CR1ikrca;
	protocol="application/pgp-signature"; micalg=PGP-SHA1

--Sig_YxVLK305es8bx09CR1ikrca
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

>Kevin,
>>=20
>>> 2. Once I comment out that code from 1 above, my headset works fine
>>> and sounds ok. However, if I do anything that sends a DTMF from my
>>> sip phone (I am using twinkle) it causes twinkle to go into a 100%
>>> cpu spin, and once to totally lock up my machine. Any idea why DTMF
>>> would cause that? Is there any way I can test or get more info to
>>> track down the problem?
>>=20
>> please try it with plugz/patches/sco-flowcontrol-v3.0.diff applied.
>>=20

>I would second Brad remark. With an unpatched kernel you will
>experience kernel crashes. The test you removed from the code was
>supposed to check for the above kernel patch !! ;-)

Yeah, ok. You may want to change that message from the generic sounding=20

Unable to set number of SCO buffers : please upgrade your Kernel!

to something like:=20

Unable to set number of SCO buffers: Please apply kernel patches from
patches directory in the plugz source to your kernel and reboot with
that kernel.=20

I'll try and find time to build a custom kernel and test it, but that
might take a while. I try and avoid building custom kernels these
days. ;(=20

>
>Btw, i would like to update the project documentation, to explicitely
>say the kernel patch is mandatory.

If this patch is needed, is there any move to get it pushed to
upstream? One of the reasons I was very happy about this new setup was
that I didn't need to compile an out of tree module with every kernel
update, but now it's worse if I have to make a new kernel with this
patch. ;(=20

>
>Cheers,
>
>Fabien

kevin

--Sig_YxVLK305es8bx09CR1ikrca
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFFormZ3imCezTjY0ERAjsRAJ9E6M1naa5QsZvWmgl97g45IS8vQgCfUlGn
xOR2uraBg0ukX8xiiXSRpEI=
=uJpO
-----END PGP SIGNATURE-----

--Sig_YxVLK305es8bx09CR1ikrca--


--===============0449508485==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0449508485==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0449508485==--
