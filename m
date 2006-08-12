Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Sat, 12 Aug 2006 01:21:47 -0500
From: digitalfredy <digitalfredy@debiancolombia.org>
In-reply-to: <20060810160526.GC16806@refinery.twat.com.ar>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-id: <1155363708.21165.7.camel@YODA>
MIME-version: 1.0
References: <20060803043158.GA13259@refinery.twat.com.ar>
	<20060810160526.GC16806@refinery.twat.com.ar>
Subject: Re: [Bluez-users] Cannot transfer files via OBEX
Reply-To: digitalfredy@debiancolombia.org,
        BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

El jue, 10-08-2006 a las 13:05 -0300, redondos escribi=F3:
> It's pointless, no matter how many different configurations I try, I     =
   =

> just can't upload anything to the phone. Am I doing something wrong? Is  =
   =

> it supposed to be possible to upload, say, a theme using obexft -b       =
   =

> <device> -B <channel> -c Themes -p <theme-name>?                         =
   =

obexftp -b <device> -B <channel> -p <theme-name>
> =

> The dump always shows a piece of the file (hex dump) and then:
> < ACL data: handle 1 flags 0x02 dlen 8
>     L2CAP(d): cid 0x0040 len 4 [psm 3]
>       RFCOMM(s): DISC: cr 1 dlci 12 pf 1 ilen 0 fcs 0xa2
> > HCI Event: Disconn Complete (0x05) plen 4                              =
   =

>     status 0x00 handle 1 reason 0x08
>     Reason: Connection Timeout
> =

> Fredy: Can I see your scripts for doing such things, please?
> =

> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job ea=
sier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=
=3D121642
> _______________________________________________ Bluez-users mailing list =
Bluez-users@lists.sourceforge.net https://lists.sourceforge.net/lists/listi=
nfo/bluez-users

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
