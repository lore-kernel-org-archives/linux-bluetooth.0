Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Sat, 2 Sep 2006 14:21:34 +0800
Message-ID: <554C5F4C5BA7384EB2B412FD46A3BAD1012FED83@pdsmsx411.ccr.corp.intel.com>
From: "Li, Lea" <lea.li@intel.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Big patch to a2dpd
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1894627063=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1894627063==
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

It's really a great patch - which is the right patch I am looking for. =
:)

I've tried it on my XScale board. It is perfect but only one line to be =
modified to make default alsa device work smoothly. See below patch:=20
The better way is to modify the code in alsa_transfer_raw(), I think, as =
below:=20

	case -EPIPE:
		// To manage underrun, we will try to recover from error state
		if(xrun_recovery(alsa->playback_handle, result) =3D=3D 0)
			result =3D 0;
		DBG("EPIPE(%d)", result);
		break;
	case -ESTRPIPE:
		if(xrun_recovery(alsa->playback_handle, result) =3D=3D 0)
			result=3D0;
		DBG("ESTRPIPE(%d)", result);
		break;
	}

=3D=3D=3D=3D=3D=3D=3D=3Dpatch begin=3D=3D=3D=3D=3D=3D=3D=3D
--- a2dpd.c.old	2006-09-02 13:53:31.601040096 +0800
+++ a2dpd.c	2006-09-02 13:14:53.065511072 +0800
@@ -716,7 +716,7 @@
 								blockstart +=3D blocksize;
 								ibytespersecond +=3D transfer;
 								a2dp_timer_notifyframe(&TimerInfos);
-							} else {
+							} else if (! (lpDevice->bredirectalsa)){
 								printf("Error in a2dp_transfer_raw\n");
 								bError =3D 1;
 							}
=3D=3D=3D=3D=3D=3D=3D=3Dpatch end=3D=3D=3D=3D=3D=3D=3D=3D
=20
Thanks,
Lea
=20

-----Original Message-----
From: bluez-devel-bounces@lists.sourceforge.net =
[mailto:bluez-devel-bounces@lists.sourceforge.net] On Behalf Of =
Fr=A8=A6d=A8=A6ric DALLEAU
Sent: 2006=C4=EA9=D4=C21=C8=D5 0:05
To: BlueZ development
Subject: [Bluez-devel] Big patch to a2dpd

Hi Brad,
>
> I looked over Matthew's patches and applied them. I applied your =
"small
> patch" which turns out to be bigger than it sounds :)
>  =20
This one is more than bigger!
Reindent,
Alsa output redirection,
New on-the-fly in-play switch from bt to alsa and reverse
Changing bdaddr in play too.
More options described in sample.a2dprc

I removed the line LIBS=3D from Makefile.am as suggested. This line was=20
making tons of compilation problems. As a2dpd finally links to alsa, it=20
is no longer needed.
Please give it a try before submitting (Matthew and RUI if you read =
that).

Wrote a doc : http://fdalleau.free.fr/a2dp_doc.pdf ideas welcome!

Fr=A8=A6d=A8=A6ric


--===============1894627063==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1894627063==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1894627063==--
