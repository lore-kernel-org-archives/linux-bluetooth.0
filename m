Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Wed, 6 Sep 2006 11:12:18 +0800
Message-ID: <554C5F4C5BA7384EB2B412FD46A3BAD10135633A@pdsmsx411.ccr.corp.intel.com>
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
Content-Type: multipart/mixed; boundary="===============0616580447=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0616580447==
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

Yes. I prefer modifying alsa_transfer_raw(), which makes the framework =
logic consistent. How do you think about it?=20

=20
Thanks,
Lea
=20

-----Original Message-----
From: bluez-devel-bounces@lists.sourceforge.net =
[mailto:bluez-devel-bounces@lists.sourceforge.net] On Behalf Of Brad =
Midgley
Sent: 2006=C4=EA9=D4=C26=C8=D5 11:06
To: BlueZ development
Subject: Re: [Bluez-devel] Big patch to a2dpd

Lea

You seem to be proposing two different changes below. Do we need to
discuss which one is best?

thanks
Brad

> I've tried it on my XScale board. It is perfect but only one line to =
be modified to make default alsa device work smoothly. See below patch:=20
> The better way is to modify the code in alsa_transfer_raw(), I think, =
as below:=20
>=20
> 	case -EPIPE:
> 		// To manage underrun, we will try to recover from error state
> 		if(xrun_recovery(alsa->playback_handle, result) =3D=3D 0)
> 			result =3D 0;
> 		DBG("EPIPE(%d)", result);
> 		break;
> 	case -ESTRPIPE:
> 		if(xrun_recovery(alsa->playback_handle, result) =3D=3D 0)
> 			result=3D0;
> 		DBG("ESTRPIPE(%d)", result);
> 		break;
> 	}
>=20
> =3D=3D=3D=3D=3D=3D=3D=3Dpatch begin=3D=3D=3D=3D=3D=3D=3D=3D
> --- a2dpd.c.old	2006-09-02 13:53:31.601040096 +0800
> +++ a2dpd.c	2006-09-02 13:14:53.065511072 +0800
> @@ -716,7 +716,7 @@
>  								blockstart +=3D blocksize;
>  								ibytespersecond +=3D transfer;
>  								a2dp_timer_notifyframe(&TimerInfos);
> -							} else {
> +							} else if (! (lpDevice->bredirectalsa)){
>  								printf("Error in a2dp_transfer_raw\n");
>  								bError =3D 1;
>  							}
> =3D=3D=3D=3D=3D=3D=3D=3Dpatch end=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> Thanks,
> Lea

-------------------------------------------------------------------------=

Using Tomcat but need to do more? Need to support web services, =
security?
Get stuff done quickly with pre-integrated technology to make your job =
easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache =
Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D=
121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel


--===============0616580447==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0616580447==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0616580447==--
