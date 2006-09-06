Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44FE8C5B.8060306@palmsource.com>
Date: Wed, 06 Sep 2006 10:52:43 +0200
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_DALLEAU?= <frederic.dalleau@palmsource.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <44EC8877.8050200@palmsource.com>	<44F5A472.30003@xmission.com>	<44F7088F.6090606@palmsource.com>	<44F9ABCF.1020706@xmission.com>	<7A6DA545D7FDCC4B93DB651FDBC1EDDE4E6E91@eumonex01.palmsource.com>
	<44FE477D.9090307@xmission.com>
In-Reply-To: <44FE477D.9090307@xmission.com>
Subject: Re: [Bluez-devel] RE :  Big patch to a2dpd
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

> Have you looked into using dbus for communicating with the running
> a2dpd? I think I read that ALP is going to use dbus for things like this.
>   =

We still need data persistency, so It would need to
1) listen dbus
2) rewrite the file

> enablereversestereo=3D1 fixes audio so it comes out of both speakers. I've
> made this the default in sample.a2dprc.
>   =

It seems that the reverse code is a bit buggy :D which explains why you =

have no sound.
Look at this in a2dpd.c
        } else {
            //FIXME We have a reverse stereo I don't know why
            // The following line corrects the problem but I miss the =

cause so
            pBuffer[j] =3D =

(((channel_2&0x0000FFFF)<<16)|(channel_1&0x0000FFFF));
            //pBuffer[j] =3D ( (channel_1 & 0xFFFF0000) | (channel_2 & =

0x0000FFFF) );        // ------------------  remove this line
        }

> fyi, if interference makes the stream get behind, the rate of the stream
> gets a little wacky for a while and the pitch wanders around for a few
> seconds before settling down. fwiw, this is on a machine with intel i810
> graphics which seems to "behave" better than nvidia with regard to
> interrupt masking.
>   =

What do you call interference?


Fr=E9d=E9ric


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
