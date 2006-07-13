Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44B676D6.7030909@palmsource.com>
Date: Thu, 13 Jul 2006 18:37:42 +0200
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_DALLEAU?= <frederic.dalleau@palmsource.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <7A6DA545D7FDCC4B93DB651FDBC1EDDE4E6E85@eumonex01.palmsource.com>	<20060713105346.GA22651@srcf.ucam.org>	<44B63E89.1000403@palmsource.com>
	<20060713125020.GA23616@srcf.ucam.org>
In-Reply-To: <20060713125020.GA23616@srcf.ucam.org>
Subject: Re: [Bluez-devel] RE : A2DP plugin success with
	HP	bluetooth	headphones
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi matthew and Brad

>It looks like it should be running at 44.1KHz. This is on a 1.2GHz 
>Pentium M. A quick play suggests that it hits the "overslept" codepath 
>in a2dpd very frequently - should this be the case?
>
>  
>
I don't see which case you talk about? Is that the "more than on sec"?
I should never pass there unless when debugging.

I've updated the online version, give it a try, there is a change in timing.
http://fdalleau.free.fr/btsco.tar.gz

I also have a hp bluetooth headset, I had good sound, not the best but good.

Brad,
I have excellent quality with iPhono BT420
I also tried the hp on arm (I found one) it is recognisable but not good.
I believe it is a kernel timer issue (usleep resolution), any ideas?

Frederic




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
