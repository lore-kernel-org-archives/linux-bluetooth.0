Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1157355863.18992.42.camel@localhost>
References: <1157355863.18992.42.camel@localhost>
Date: Mon, 04 Sep 2006 12:38:13 +0200
Message-Id: <1157366293.32195.41.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] What's going on here? RFCOMM on OPP always
	gets	disconnected
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Pierre-Yves,

> After getting a java OBEX implementation to work last week, it suddenly
> stopped  working. Now, every time I try, the RFCOMM connection gets
> disconnected shortly. It seems that for some reason the target (n-gage
> cell phone) is disconnecting. My code is virtually untouched (I reverted
> back to a backup revision, but due to some mistake on my part I'm only
> 95% positive it is exactly the version which was working previoulsy).
> 
> Just before it stopped working, my usb HUB fried (got lots of error on
> the bus). Now this bad device is out of the game, and no more errors
> have been reported in the system logs. Maybe it damaged my dongles,

in case please to "hcidump -X -V --obex=9". I am not going to decide
OBEX by hand if I don't have to.

Regards

Marcel



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
