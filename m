Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <44DCF45E.8010502@freemail.hu>
Date: Fri, 11 Aug 2006 23:19:26 +0200
From: Mate Soos <msoos@freemail.hu>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <c5cec3110608110427m6669470bt629c145b717a1a1e@mail.gmail.com>
In-Reply-To: <c5cec3110608110427m6669470bt629c145b717a1a1e@mail.gmail.com>
Subject: Re: [Bluez-users] hcid problem
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-2"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

I had the same *really annoying* problem. There is a cache for the
library in some obscure place like
/usr/lib/libbluetooth/something_or_other - delete the cache and it will
work. BTW, to the developers: this is a BUG. Take care of it, please.

M=E1t=E9

bees wrote:
> Hi All
>  =

>     when I modified the /etc/bluetooth/hcid.conf, the output of
> "hciconfig -a" keep unchanged. Why???
>  =

> Regards
>  =

> Bees
> ------------------------------------------------------------------------
>
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job ea=
sier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=
=3D121642
> ------------------------------------------------------------------------
>
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>   =



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
