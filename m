Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Dbus and RemoteDeviceFound API
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <7A6DA545D7FDCC4B93DB651FDBC1EDDE46C720@eumonex01.palmsource.com>
References: 
	 <7A6DA545D7FDCC4B93DB651FDBC1EDDE46C720@eumonex01.palmsource.com>
Content-Type: text/plain
Message-Id: <1147881784.14106.26.camel@localhost>
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
Date: Wed, 17 May 2006 18:03:04 +0200

Hi Renaud,

>  I just discover that new API, and I have a remark.
> 
>  Is it to possible to add to that message the class of device (as an
> uint32) ?
>  With this we can have complete information about discovered device even
> if major or minor are not in "constant definition" of dbus API.
>  This can also simplify programation in C (ie: filtering, displaying
> icons,...) 

we did it this way on purpose. If definitions are missing, then this is
a bug and needs to be fixed. What types are you missing?

Another basic design idea behind the D-Bus API for BlueZ is not to use
weird integer constants at all. We have clear text attributes which make
it very easy to use them from scripting languages like Python. However
this makes it harder for application written in C, but we accepted this
disadvantage.

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
