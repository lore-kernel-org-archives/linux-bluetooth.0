Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <445A3789.6010000@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] A2DP and Alsa Plugin
References: <7A6DA545D7FDCC4B93DB651FDBC1EDDE46C090@eumonex01.palmsource.com>
In-Reply-To: <7A6DA545D7FDCC4B93DB651FDBC1EDDE46C090@eumonex01.palmsource.com>
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
Date: Thu, 04 May 2006 11:19:05 -0600

Frederic

> By encapsulation I mean there is a packet_header and a payload_header in
> a2play.c that I do not see in alsa-plugin, at least in my version!
> I'm still waiting to see a2dp_transfer2

i've been meaning to for a while, so i made a 0.42 snapshot. it's
current so you could try that if cvs is giving you trouble.

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
