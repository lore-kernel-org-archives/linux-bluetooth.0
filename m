Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
In-Reply-To: <45007741.8020506@xmission.com>
References: <554C5F4C5BA7384EB2B412FD46A3BAD10135633A@pdsmsx411.ccr.corp.intel.com>	<44FE42C7.7030100@xmission.com>
	<44FE95CE.1090502@palmsource.com>
	<1157647703.16404.2.camel@localhost>
	<45007741.8020506@xmission.com>
Message-Id: <1CA2256D-7196-4EE3-AFA5-7EF0BD526D2B@pepper.com>
From: Michael Frey <mfrey@pepper.com>
Date: Thu, 7 Sep 2006 16:36:01 -0400
To: BlueZ development <bluez-devel@lists.sourceforge.net>
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
Content-Type: text/plain; charset="windows-1252"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This new version works great.  Has anyone been able to watch a movie  =

with mplayer?  Playing audio is just fine.  Playing a movie -- the  =

video can not keep up.  Any hints?

Michael

On Sep 7, 2006, at 3:47 PM, Brad Midgley wrote:

> Andrew
>
>> Since Brad applied the Big patch to a2dpd i'm getting
>>
>> a2dpd.c:40:21: error: alsalib.h: No such file or directory
>> a2dpd.c: In function =91bt_handler=92:
>> a2dpd.c:695: warning: implicit declaration of function =91alsa_new=92
>
> doh. forgot to add newly-created files to cvs. it's in cvs now so it
> should propogate to anon cvs shortly
>
> brad
>
> ---------------------------------------------------------------------- =

> ---
> Using Tomcat but need to do more? Need to support web services,  =

> security?
> Get stuff done quickly with pre-integrated technology to make your  =

> job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache  =

> Geronimo
> http://sel.as-us.falkag.net/sel? =

> cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D121642
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
