Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <446028BE.1050006@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re:Advanced Audio Distribution Profile for BlueZ
References: <20060508153458.88001.qmail@web26908.mail.ukl.yahoo.com>
In-Reply-To: <20060508153458.88001.qmail@web26908.mail.ukl.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 08 May 2006 23:29:34 -0600

javier

>     I've visited bluetooth-alsa.sf.net and the project is very
>     interesting but I think that the profile's implementation is based
>     on SCO channels. If I'm making a mistake I apologize for it. On the
>     other hand, I've read the A2DP profile specification and I think
>     that an implementation should uses ACL channels

it may not be all that clear but the project has two parts, sco and a2dp.

an a2dp stream can be sent to a stereo headset using the application
a2play. there are also some test apps for avrcp in av*.c in case that's
interesting to you.

brad


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
