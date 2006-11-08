Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Chafik Moalem <moalem@emporos.de>
Date: Wed, 8 Nov 2006 22:19:16 +0000 (UTC)
Message-ID: <loom.20061108T223826-983@post.gmane.org>
References: <1111743.1162822095031.JavaMail.root@mail.prologistik.com>
	<loom.20061108T184308-176@post.gmane.org>
	<455235ED.4060403@xmission.com>
Mime-Version: 1.0
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

Hi Brad,

just prepared a patch to show you the modifications to the actual
CVS version ... the "modified" dir is named btsco-chmo ...
(PLS NOTE :  this is preliminary as i could not yet check all other occurences
of EAGAIN and the effects in alsa-plugins/*.c ... more to come soon ...
BUT THIS makes things already work for me ...)

The timeout i mentioned was the initial one to be defined in .asoundrc ...
i understood that this is for connection establishment with the HS ?!
well ... fabien has only nonblocking socket communication ...
i will test further ... i might be mistaken with my previous statement 
saying "NO effect".

i added a small previous fix to "remote volume control" in btsco.c and
btsco2.c...  the BT-core spec defines host_TO_HS RVC commands (+VGS, +VGM)
to need prefix \r\n AND postfix the same way!
(This was the only way to make my RVC capable HS REALLY change volume!)
Did you know that there exists NO SINGLE bt-stack for windose that makes real
use of RVC !?
fortunately headsetd (volctl.c) does it already the right way...

now regarding HW:

i have checked 4 different CSR based USB dongles:
- notebook built in IBM R51 BT-dongle (bluecore 2)
- Cellink BT2.0+EDR dongle (bluecore3)
- hama BT2.0+EDR dongle (bluecore3-MM)
- new custom BT-Dongle by Lintech (germany) (bluecore3-MM)

3 headsets with HSprofile (SCO + RVC!):
- Cellink BT-9000ST (only HSProfile tested!)
- AS-Kabel (sweden) (have you ever used a headset in a disco ? :) 
(NOISECANCELLING with free2move CSR bluecore 1 class 1! BEST one but BULKY)
- new custom design with Lintech-BT audio module

i have to admit that the test matrice might be incomplete (sparse) due to the
fact that i prefer OUR custom design :))

regards
Chafik

p.s.: the patch might not be attached RIGHT NOW ... 
(will follow tomorrow latest!)




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
