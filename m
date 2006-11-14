Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4559D573.2020102@palmsource.com>
Date: Tue, 14 Nov 2006 15:40:51 +0100
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_DALLEAU?= <frederic.dalleau@palmsource.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <947020.38780.qm@web31012.mail.mud.yahoo.com>
In-Reply-To: <947020.38780.qm@web31012.mail.mud.yahoo.com>
Subject: Re: [Bluez-devel] python a2dp
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

Hi Sergey,

This is interesting!
I don't know much about python so I'm having a few problems to make it run.
I just installed the ctypes my ubuntu provides (0.9.6) but I get the =

following error :

Traceback (most recent call last):
  File "./avdtp.py", line 49, in ?
    from ctypes import Structure,c_uint8,c_uint16,c_ulong,c_uint32,c_void_p
ImportError: cannot import name c_uint8

Any ideas?

Thank you,
Fr=E9d=E9ric.

Sergey Krivov a =E9crit :
> Hi,
>
> this is a partial realization of AVDTP, A2DP and AVRCP
> profiles in python with simple example of a2dp-avrcp
> server. it is probably far from a2dp alsa-plugin theme
> since it is not written in C, but it might be useful
> for prototype development. Anyway, have a look.
>
> All the feedback is welcome.
>   =



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
