Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Hilzinger <mhilzinger@linuxnewmedia.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Fri, 10 Nov 2006 09:01:16 +0100
References: <200611091102.54282.marcel@hilzinger.hu>
	<20061109104245.GB7085@physik.fu-berlin.de>
	<1163066853.5983.24.camel@grappa>
In-Reply-To: <1163066853.5983.24.camel@grappa>
MIME-Version: 1.0
Message-Id: <200611100901.16410.mhilzinger@linuxnewmedia.de>
Subject: Re: [Bluez-devel] Quality of a2dp sound
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

Am Donnerstag, 9. November 2006 11:07 schrieb Reiner Klenk:
> Hi,
> I'm also using a BT620s and I find the sound quality acceptable using
> the a2dp plugin. I also tested with a2dpd and there wasn't any
> difference in sound quality that I could perceive. =

Then we must have different ears :-) or different versions. I'm using Suse =

Linux 10.1 with kernel 2.6.16.21, alsa-version is 1.0.13

a2dpd produces some noise in the background. If there is silence, you can h=
ear =

it. With a2play there is no noise. I will checkout cvs again and have a loo=
k.

> However, with a2dp, =

> which I'm using with amarok I can actually play mono/stereo sources with
> different sample rates without getting the pitch problem (Frederic has
> submitted patches for a2dpd recently but I haven't tested them yet).
How do you change the sample rate?

> I'm =

> using a 100 mW dongle and there are no drop-outs within my (not too big)
> appartment. It seems to be fairly stable, I have used the headset for
> hours without a glitch.
> What I did notice is that the volume could be higher and there is the
> occasional faint clicking which might be due to clipping. As far as I
> understood these are known issues inside the sbc encoding library.
> Of course, headsets like the BT620s can be connected via SCO as well as
> a2dp. Use SCO to hook it up to your phone or to egika, but definitly use
> a2dp for the connection to amarok or other music/podcast players.
>
> Regards,
> Reiner
>
>
>
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job
> easier Download IBM WebSphere Application Server v.1.0.1 based on Apache
> Geronimo
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=
=3D121642
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel

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
