Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Hilzinger <mhilzinger@linuxnewmedia.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Mon, 13 Nov 2006 14:24:05 +0100
References: <200611091102.54282.marcel@hilzinger.hu>
	<7A6DA545D7FDCC4B93DB651FDBC1EDDE4E6EA3@eumonex01.palmsource.com>
	<200611101117.30944.mhilzinger@linuxnewmedia.de>
In-Reply-To: <200611101117.30944.mhilzinger@linuxnewmedia.de>
MIME-Version: 1.0
Message-Id: <200611131424.06615.mhilzinger@linuxnewmedia.de>
Subject: Re: [Bluez-devel] RE :  Quality of a2dp sound
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Am Freitag, 10. November 2006 11:17 schrieb Marcel Hilzinger:
> Am Freitag, 10. November 2006 09:41 schrieb Frederic Dalleau:
> > Hi,
> >
> > > a2dpd produces some noise in the background. If there is silence, you
> > > can hear it. With a2play there is no noise. I will checkout cvs again
> > > and have a look.
>
> One more (maybe last :-) feedback
Never say never again...

I'm now testing the 3th day, whole day with bt phones on my head. A new =

problem, which appears at least with amarok, maybe also with xmms: The spee=
d =

of the played sound is not constant. It's like augmenting the speed on a =

oldstyle turntable from 33 1/2 to 35, back to 31 and back to 33 1/2 again. =

First I thought it's due to heavy CPU load, but it seems to appear randomly=
. =

I decreased the sbcbitpool=3D value from 64 to 32 and it's seems to be bett=
er, =

but perhaps it's only because I restartet a2dpd. =


It seems to be a caching problem.

In my first tests I had the same, when I went far away from the dongle, so =

playback stopped and then came back. Sound was played very quickly, and the=
n =

normal again. But I then had no up-and-down-effects like today.


-- =

Mit freundlichen Gr=FC=DFen,
Marcel Hilzinger

Linux New Media AG
S=FCskindstr. 4
D-81929 M=FCnchen
Tel: +49 (89) 99 34 11 0
Fax: +49 (89) 99 34 11 99

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
