Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Hilzinger <mhilzinger@linuxnewmedia.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Fri, 10 Nov 2006 11:04:13 +0100
References: <006f01c704ae$fb6ace90$9d0cc70a@dlh.st.com>
In-Reply-To: <006f01c704ae$fb6ace90$9d0cc70a@dlh.st.com>
MIME-Version: 1.0
Message-Id: <200611101104.13827.mhilzinger@linuxnewmedia.de>
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
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Am Freitag, 10. November 2006 10:59 schrieb Mayank BATRA:
> Hi Marcel,
>
> > I also tried to call mpg123 --au -file.mp3 | a2play 00:0D:44:58:11:CA
> >
> > without calling btsco before, and it's works, too. But here i
> > have the effects
> > other user described with speedup and very noisy sound. So
> > maybe this is a
> > pairing problem? See logs at the end of my email.
>
> Why don't you try running a2play with -p option?
> Something like:
> mpg123 --au - file.mp3 | a2play -p 00:0D:44:58:11:CA
>
> This surely will correct the speedup.

No, it doesn't. But this is not the way to go anyway. a2dpd is the future, =

yeah ;-) =


I also tried different sampling rates. But the result is alwas the same noi=
se, =

only played at a different octave :-)

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
