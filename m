Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Pierre-Yves Paulus <py@idlum.be>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1163421730.8561.75.camel@localhost>
References: <loom.20061113T113030-503@post.gmane.org>
	<1163421730.8561.75.camel@localhost>
Date: Mon, 13 Nov 2006 14:08:45 +0100
Message-Id: <1163423326.8561.79.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Asynchronous call
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

Hello again,

> > Is there opportunity of asynchronous call of inquiry 
> > (if one device is found, i will get info about it and will not waiting while
> > other devices will be found)
> 
> It seems that the D-Bus API works that way.

To be more clear, the D-Bus API works asynchronously, eg the call to
start inquiry is non-blocking. I didn't intend to tell that it was
possible to block until first device is discovered, and then return. 

Hope it makes more sense now.

Pierre-Yves


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
