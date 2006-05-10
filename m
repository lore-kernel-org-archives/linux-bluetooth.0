Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4462279A.8010002@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] A2DP and Alsa Plugin
References: <7A6DA545D7FDCC4B93DB651FDBC1EDDE46C1E3@eumonex01.palmsource.com>
In-Reply-To: <7A6DA545D7FDCC4B93DB651FDBC1EDDE46C1E3@eumonex01.palmsource.com>
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
Date: Wed, 10 May 2006 11:49:14 -0600

Frederic

> You're right brad! It's my day job. As you know, PalmSource announced
> recently that its next platform release called ALP will use BlueZ (BT
> 2.0 compliant) : see
> http://www.palmsource.com/press/2006/021406_accesslinuxplatform.html.
> Currently, we are still in the development phase of the ALP platform. In
> this context, I will work on the a2dp profile.

I've read about ALP. It looks exciting. I was glad to see ALP will
include gstreamer as part of the foundation. You should help me write
proper gstreamer plugins.

alsa plugins use an api that is too simple for complete headset
support... also there have been complaints about libalsa not scaling
down for embedded systems.

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
