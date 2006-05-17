Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Dbus and RemoteDeviceFound API
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <7A6DA545D7FDCC4B93DB651FDBC1EDDE46C733@eumonex01.palmsource.com>
References: 
	 <7A6DA545D7FDCC4B93DB651FDBC1EDDE46C733@eumonex01.palmsource.com>
Content-Type: text/plain
Message-Id: <1147884880.14106.30.camel@localhost>
Mime-Version: 1.0
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
Date: Wed, 17 May 2006 18:54:40 +0200

Hi Renaud,

>  The LIMITED_DISCOVERABLE_MODE service class is missing and minor
> classes for other major classes than Computer and Phone are not listed
> in "constant definition" (ie: uncategorized, keyboard, pointing, combo
> for Peripheral major class).
>  I use the "class of device" to filter and/or display specific icon for
> all couple of major and minor in an embedded device.

we happily accept patches for fixing this. I must admit that in the
beginning we needed to concentrate on other things and I told people not
to focus on this. We will fix it later.

Are you really using LIMITED_DISCOVERABLE_MODE service class.

>  Perhaps a new set of APIs could be better ?

Why? And what advantages would you gain?

Regards

Marcel




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
