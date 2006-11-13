Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Mon, 13 Nov 2006 17:49:04 +0100
From: "Chafik Moalem" <Chafik.Moalem@perdictum.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <22011516.1163436544368.JavaMail.root@mail.prologistik.com>
In-Reply-To: <45588F4E.7060800@xmission.com>
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
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Brad,



Am Montag, den 13.11.2006, 08:29 -0700 schrieb Brad Midgley:

> Chafik

> =


> > 1. pls find attached btsco patch

> =


> applied by the way.

cool !



> =


> > 2. uhhmm ..the Cellink headset is BTST-9000A ... =


> > the Cellink dongle is BTA-6030

> =


> I have not heard of anyone having trouble with these and bluecore is =


> supposed to be our best chance of working.

well ... thats why i chose my test components to all have CSR INSIDE :)

and yes ... technically it's all working

what i'm looking for is a POST BETA status ... with flow control,

reliable links, no chopping (or dropped packets) in no circumstances,

SIMPLY A RELIABLE REPLACEMENT to a wired headset for voice

applications ...

(actually we are specialized in speech recognition and our speaker

independant ASR engine proved to perform very well with the Cellink

class 1 AND the AS-Kabel class 1 headset despite the limitation to 8

KHz!! even under "noisy" CeBIT conditions with distances up to 50m )

Why we are going for a newer solution : class 1 sco connections are

permanently consuming too much power (~100 mw on each side) ... not the

best for "wearable computing" !

when we went down to class 2 or 3 the collisions with 802.11 were more

"obvious"! Therefore AFH and all other (optional) BT1.2 features really

required! AFH seems to work in bluez (the AFH masks keep changing) BUT i

found flow control, sco packet retransmission and EVn packets are alpha

status (or not implemented at all, not even DVn packets :( )
i will try to contribute to eSCO implementation (if possible)...



BTW: all that DYNAMIC_COMPRESSION and AUTO_FIXUP_BYTESHIFT stuff in

kernel/btsco.c (for snd_bt_sco module) is sometimes more disturbing than

anything else ... i had the best results disabling (commenting out) this

stuff ... no kernel lockups nor annoying messages in the logs ... but

probably still dropped packages ... best to observe when playing a

constant freq wav file (e.g. 400Hz)





> =


> > well ... fabien has only nonblocking socket communication ...

> > i will test further ... i might be mistaken with my previous statement =


> > saying "NO effect".

> =


> Fabien has been making a lot of changes lately that I need to catch up wi=
th.

> =


> > i added a small previous fix to "remote volume control" in btsco.c and

> > btsco2.c...=A0 the BT-core spec defines host_TO_HS RVC commands (+VGS, =
+VGM)

> > to need prefix \r\n AND postfix the same way!

> > (This was the only way to make my RVC capable HS REALLY change volume!)

> > Did you know that there exists NO SINGLE bt-stack for windose that make=
s real

> > use of RVC !?

> > fortunately headsetd (volctl.c) does it already the right way...

> =


> I guess we were lucky it worked for any headset.

:) ... some headsets seemed to be more tolerant to "contaminated"

commands, some were not ... like e.g. Internet-Explorer swallows all

crappy non-HTML pages any script kiddy has hacked (with a graphical

WYSIWYG crap editor)! =


> =


> > i have checked 4 different CSR based USB dongles:

> > - notebook built in IBM R51 BT-dongle (bluecore 2)

> > - Cellink BT2.0+EDR dongle (bluecore3)

> > - hama BT2.0+EDR dongle (bluecore3-MM)

> > - new custom BT-Dongle by Lintech (germany) (bluecore3-MM)

> > =


> > 3 headsets with HSprofile (SCO + RVC!):

> > - Cellink BT-9000ST (only HSProfile tested!)

> > - AS-Kabel (sweden) (have you ever used a headset in a disco ? :) =


> > (NOISECANCELLING with free2move CSR bluecore 1 class 1! BEST one but BU=
LKY)

> =


> probably cost someone a fortune if it was made back when bluecore1 was ne=
w.

well ... some heavy duty users are ready to pay for such good headsets

(like fire fighters, air field workers etc...)

they use them with their new generation walky talkies

(or ... very soon with our newest "move-by-voice" device :) )



> > - new custom design with Lintech-BT audio module

> > =


> > i have to admit that the test matrice might be incomplete (sparse) due =
to the

> > fact that i prefer OUR custom design :))

> =


> well I look forward to seeing it. I hope you can keep us honest whenever =


> we do something wrong in the apps.

i will try my best :) ... but i admit that i'm not the BT Expert at all ... =


i have to catch up, to be able to contribute in a more productive way ... =


so there might be "silly" or "annoying" questions from me sometimes ;)



> brad

> =


> -------------------------------------------------------------------------

> Using Tomcat but need to do more? Need to support web services, security?

> Get stuff done quickly with pre-integrated technology to make your job ea=
sier

> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo

> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=
=3D121642

> _______________________________________________

> Bluez-devel mailing list

> Bluez-devel@lists.sourceforge.net

> https://lists.sourceforge.net/lists/listinfo/bluez-devel

-- =


Chafik Moalem



------------------------

perdictum GmbH + Co KG

Fallgatter 1

D - 44369 Dortmund

Tel.: +49 231 51944-10

Fax:=A0 +49 231 5194-99

mailto:Chafik.Moalem@perdictum.com=A0<mailto:Chafik.Moalem@perdictum.com>

http://www.perdictum.com=A0<http://www.perdictum.com/>=A0 =








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
