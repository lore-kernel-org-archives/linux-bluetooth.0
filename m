Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Rene Mayrhofer <rene.mayrhofer@gibraltar.at>
To: Brad Midgley <bmidgley@xmission.com>
Subject: Re: [Bluez-devel] snd-bt-sco module prevents ACPI S3
References: <200510301643.31873.rene.mayrhofer@gibraltar.at> <4365579A.4080709@xmission.com>
In-Reply-To: <4365579A.4080709@xmission.com>
Cc: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1149121.LAYR2Ps9t7";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <200510312323.56036.rene.mayrhofer@gibraltar.at>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 31 Oct 2005 23:23:49 +0000

--nextPart1149121.LAYR2Ps9t7
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Sunday 30 October 2005 23:30 schrieben Sie:
> > 1. It's name in the lsmod list is different from the module name, i.e.
> > modprobe and rmmod must be used with different names.
>
> Do you want to submit a patch (or at least tell us what the different
> names are?)
Checking again, the module file is called snd-bt-sco.ko, but in lsmod it=20
appears as snd_bt_sco. I could probably find the problem in the code and=20
submit a patch, unless anybody here knows already what needs to be changed.

> > 2. It breaks ACPI S3 (suspend to RAM), making it pretty much unusable on
> > laptops where S3 is used (like mine). Unloading snd-bt-sco does not work
> > (I do that with a few other modules); as soon as it has been loaded once
> > (even if it has not been used and/or has been unloaded), the kernel
> > (2.6.14-rc5) is unable to enter ACPI S3.
>
> This may be the result of something we did but it's much more likely to
> be a change in the kernel.
It did not work with previous kernels either. Can anybody confirm that=20
snd-bt-sco and S3 work together?

> What exactly happens when you try & fail to go to S3?
It goes through all the steps until "Stopping all tasks" and then - instead=
 of=20
turning off - just continues as if the wakeup signal had been received=20
immediately. The real wakeup signal (in my case, releasing the lid button)=
=20
tries to suspend again, and fails again, i.e. the system immediately comes =
up=20
again without switching off.

If you need more test data, I'll be able to test it on roughly a daily basi=
s=20
(although this means that I need to reboot that machine for every test, whi=
ch=20
I hardly ever do - therefore my need for a working S3).

regards,
Rene

--nextPart1149121.LAYR2Ps9t7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDZqeLq7SPDcPCS94RAjYBAKDCJFcw0Q97K3MMxQ2pHcaBLECUiQCg7ysk
3M3oPYPFpN7/m1AdbGsu7I4=
=sYpQ
-----END PGP SIGNATURE-----

--nextPart1149121.LAYR2Ps9t7--


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
