Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Thu, 9 Nov 2006 09:53:12 +0100
From: "Chafik Moalem" <Chafik.Moalem@perdictum.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <24517632.1163062392189.JavaMail.root@mail.prologistik.com>
In-Reply-To: <loom.20061108T223826-983@post.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_Part_353_28319187.1163062392188"
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
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

------=_Part_353_28319187.1163062392188
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

follow up:

dear all,

1. pls find attached btsco patch

2. uhhmm ..the Cellink headset is BTST-9000A ...=20
the Cellink dongle is BTA-6030

regards
Chafik
----- Originalnachricht -----
Von: bluez-devel-bounces@lists.sourceforge.net im Auftrag von Chafik Moal=
em=20
Gesendet: Mit, 11/8/2006 11:26pm
An: bluez-devel@lists.sourceforge.net
Betreff: Re: [Bluez-devel] btsco/alsa-plugins Kernel 2.6.18-mh7 (and mh4-=
fch)

Hi Brad,

just prepared a patch to show you the modifications to the actual
CVS version ... the "modified" dir is named btsco-chmo ...
(PLS NOTE :=A0=A0this is preliminary as i could not yet check all other o=
ccurences
of EAGAIN and the effects in alsa-plugins/*.c ... more to come soon ...
BUT THIS makes things already work for me ...)

The timeout i mentioned was the initial one to be defined in .asoundrc ..=
=2E
i understood that this is for connection establishment with the HS ?!
well ... fabien has only nonblocking socket communication ...
i will test further ... i might be mistaken with my previous statement=20
saying "NO effect".

i added a small previous fix to "remote volume control" in btsco.c and
btsco2.c...=A0=A0the BT-core spec defines host_TO_HS RVC commands (+VGS, +=
VGM)
to need prefix \r\n AND postfix the same way!
(This was the only way to make my RVC capable HS REALLY change volume!)
Did you know that there exists NO SINGLE bt-stack for windose that makes r=
eal
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
- AS-Kabel (sweden) (have you ever used a headset in a disco ? :)=20
(NOISECANCELLING with free2move CSR bluecore 1 class 1! BEST one but BULK=
Y)
- new custom design with Lintech-BT audio module

i have to admit that the test matrice might be incomplete (sparse) due to=
 the
fact that i prefer OUR custom design :))

regards
Chafik

p.s.: the patch might not be attached RIGHT NOW ...=20
(will follow tomorrow latest!)




-------------------------------------------------------------------------=

Using Tomcat but need to do more? Need to support web services, security?=

Get stuff done quickly with pre-integrated technology to make your job ea=
sier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronim=
o
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D=
121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------=_Part_353_28319187.1163062392188
Content-Type: application/x-gzip; name="btsco_fixRVC_fix2.6.18mhGT3.patch.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="btsco_fixRVC_fix2.6.18mhGT3.patch.gz"

H4sICJJMUkUAA2J0c2NvX2ZpeFJWQ19maXgyLjYuMThtaEdUMy5wYXRjaADNVltv2jAUfoZf
cVZpKFkSGgcoLB1V6US7agWmwvayVigkTomaC4rDtm7lv892HK7hoqmVZqE4cezjc76LieO5
LmjTuAujhNjRseUTS5v40wcvJMdjbDkEJ84xcSZlO52h2eNg57Sipmn7gxUMXT/RkK4ZJ4Aa
poHMql7WswaKTt8XFUU5cFMRDml6A9CJWauYVbQSDtFw5+egoWpNrYOSdufnRSgUCp4ruXaY
+BLBhHhRqJ2RyH5U4XLYbw8ub1ToDbu97sVN7+NnGT6ALsMfvq7wECURuJbnn/LnWVHj0UAC
yY7CENvJekiJJPHUToA9WY4TwzsZSsRSgXi/ceRKxJJlaDbZHs/PIOE4DiP23G5dta67MshF
5bW3WB287n657V3dtvt9tjmvOsbJNA5BbMtLn9HLrOgcpqXESjA5SE5i5n5FiYkvKKrViKmu
6iaq0V++rmpVrivecV2NLHvyJJUYBeXYHo4cdqeCQxKZYZaN22OL0uhDE8QdfUl1xCheMJzL
aikNKGhlD7KQZ6mUUfhmSTpUtcorxF0dXNKLsIntRwRLhBedaUdDp1wxHLmGzpHjHUcuwAEl
QRJ56GupzMGjFA5dK/D8Jwpe63J4cfO1Pej1Bp9O19BnE1fhfwV8/0d41w3Jr8aq9bKxJZNl
Q0z8NY3pv87EX6ubVWOfnZbXZsYxDGacSv6BXKm+V5EBiujTI1nUobMy3EnshQk9txKH4qDC
0Y/InwYYyARbjzg24a0DgWez/i48UkF4WDtL55Hv+n3OILrniDG+chYwrOfDvkWS4eIdw52e
80Sk5Xshpkkp3676TZpBnJ8B3UzZWHMX34XzddtyT4n9GXsJXmQau3YUBEPXUSGNRWXm45AH
Th1S2JY+bK8sFc0WUNAOUNB2UDpbQUE7QensAAW9MChoOyjofoeTcoy06aPMCsxJVf5tgkyj
cZCNNl2kUxPmuqiuV7iLRC8+bHhzXX9Kxsw+0TT960nbbH7H+PZCNxpN3XLg/cKxKF8YIV//
aVsjrzVY8gH/VMmbtaH7RbKFLXks5S1oj3fQfGh9aLM+tL++zoH1dQ6uD/1bfX8BwYfAObwL
AAA=

------=_Part_353_28319187.1163062392188
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
------=_Part_353_28319187.1163062392188
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------=_Part_353_28319187.1163062392188--
