Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <445B8A4D.7000403@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] A2DP and Alsa Plugin
References: <7A6DA545D7FDCC4B93DB651FDBC1EDDE46C0D2@eumonex01.palmsource.com>
In-Reply-To: <7A6DA545D7FDCC4B93DB651FDBC1EDDE46C0D2@eumonex01.palmsource.com>
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
Date: Fri, 05 May 2006 11:24:29 -0600

Frederic

> It works!
> 
> I have lots of glitch using mpg123|a2play but none with alsa-plugin!
> It's cool :D
> There were minor build problems though (sbc.h and libsbc.a not
> reachable)
> Retried cvs but I couldn't get latest, anonymous login is not allowed.

I'm glad to hear it works out. Is this totally a hobby thing or does it
have anything to do with your day job? :)

I assume you changed the sbc.h path and linked to libsbc.a. I'm trying
to move the sbc library out of btsco and link properly with libsbc.so;
that's why it is pointed to the system versions.

Brad


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
