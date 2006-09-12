Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.63.0609121038180.17868@redbean.intranet.gw-instruments.de>
References: <450603BA.3090302@vasmac.com>
	<Pine.LNX.4.63.0609121038180.17868@redbean.intranet.gw-instruments.de>
Date: Tue, 12 Sep 2006 10:43:33 +0200
Message-Id: <1158050613.14015.1.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] socket connect returns EAGAIN
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

Hi Peter,

> see my last post on this subject about 4 days ago. From my understanding 
> they shall return EINPROGRESS when the connection to the remote device is 
> pending. Returning EAGAIN looks like a small bug. See also man 2 connect 
> or man 7 socket. 

this has been raised a long time ago. However the Bluetooth core inside
the kernel doesn't sets the wrong error. It is one of the network
functions we use.

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
