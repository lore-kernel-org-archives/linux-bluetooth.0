Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Tue, 6 Feb 2007 18:16:54 +0100
From: Stefan Seyfried <seife@suse.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20070206171654.GJ6131@suse.de>
References: <200702061513.32173.denis.kenzior@trolltech.com>
MIME-Version: 1.0
In-Reply-To: <200702061513.32173.denis.kenzior@trolltech.com>
Subject: Re: [Bluez-devel] [PATCH] Minor issues with sdp-xml
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

On Tue, Feb 06, 2007 at 03:13:32PM +1000, Denis KENZIOR wrote:
> Marcel,
> =

> This patch fixes up a couple of minor bugs I found.

Thanks. Parts of this were also reported today:
https://bugzilla.novell.com/show_bug.cgi?id=3D242030

> Index: sdp-xml.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> RCS file: /cvsroot/bluez/utils/common/sdp-xml.c,v
> retrieving revision 1.7
> diff -u -r1.7 sdp-xml.c
> --- sdp-xml.c	20 Jan 2007 21:28:02 -0000	1.7
> +++ sdp-xml.c	6 Feb 2007 05:12:31 -0000
> @@ -603,7 +603,7 @@
>  			buf[0] =3D data[i];
>  			buf[1] =3D data[i + 1];
>  =

> -			val.data[i] =3D strtoul(buf, 0, 16);
> +			val.data[i >> 1] =3D strtoul(buf, 0, 16);
>  		}

This is the part that was reported as generating a compiler warning.
-- =

Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, N=FCrnberg  | "Well, surrounding them's out." =


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
