Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45588F4E.7060800@xmission.com>
Date: Mon, 13 Nov 2006 08:29:18 -0700
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <24517632.1163062392189.JavaMail.root@mail.prologistik.com>
In-Reply-To: <24517632.1163062392189.JavaMail.root@mail.prologistik.com>
Subject: Re: [Bluez-devel] btsco/alsa-plugins Kernel 2.6.18-mh7 (and mh4-fch)
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

Chafik

> 1. pls find attached btsco patch

applied by the way.

> 2. uhhmm ..the Cellink headset is BTST-9000A ... 
> the Cellink dongle is BTA-6030

I have not heard of anyone having trouble with these and bluecore is 
supposed to be our best chance of working.

> well ... fabien has only nonblocking socket communication ...
> i will test further ... i might be mistaken with my previous statement 
> saying "NO effect".

Fabien has been making a lot of changes lately that I need to catch up with.

> i added a small previous fix to "remote volume control" in btsco.c and
> btsco2.c...  the BT-core spec defines host_TO_HS RVC commands (+VGS, +VGM)
> to need prefix \r\n AND postfix the same way!
> (This was the only way to make my RVC capable HS REALLY change volume!)
> Did you know that there exists NO SINGLE bt-stack for windose that makes real
> use of RVC !?
> fortunately headsetd (volctl.c) does it already the right way...

I guess we were lucky it worked for any headset.

> i have checked 4 different CSR based USB dongles:
> - notebook built in IBM R51 BT-dongle (bluecore 2)
> - Cellink BT2.0+EDR dongle (bluecore3)
> - hama BT2.0+EDR dongle (bluecore3-MM)
> - new custom BT-Dongle by Lintech (germany) (bluecore3-MM)
> 
> 3 headsets with HSprofile (SCO + RVC!):
> - Cellink BT-9000ST (only HSProfile tested!)
> - AS-Kabel (sweden) (have you ever used a headset in a disco ? :) 
> (NOISECANCELLING with free2move CSR bluecore 1 class 1! BEST one but BULKY)

probably cost someone a fortune if it was made back when bluecore1 was new.

> - new custom design with Lintech-BT audio module
> 
> i have to admit that the test matrice might be incomplete (sparse) due to the
> fact that i prefer OUR custom design :))

well I look forward to seeing it. I hope you can keep us honest whenever 
we do something wrong in the apps.

brad

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
