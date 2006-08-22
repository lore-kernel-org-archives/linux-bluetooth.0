Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Andrew Kohlsmith <akohlsmith-bluez@benshaw.com>
To: bluez-users@lists.sourceforge.net
Date: Tue, 22 Aug 2006 12:27:14 -0400
References: <20060822181532.6fea4851@localhost>
In-Reply-To: <20060822181532.6fea4851@localhost>
MIME-Version: 1.0
Message-Id: <200608221227.15052.akohlsmith-bluez@benshaw.com>
Subject: Re: [Bluez-users] rfcomm hell
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

On Tuesday 22 August 2006 12:15, The Peach wrote:
> # rfcomm bind 0 00:12:62:A8:12:FE

I've given up on rfcomm for the most part.  rfcomm's connect option is just 
plain broken.  Instead of trying to dig in and fix it, I happened upon some 
simple utilities which seem to work much better for my purposes.  I still use 
rfcomm bind to attach pppd, though.

http://auriga.wearlab.de/~andi/smalltools/

look at rfcomm-read, rfcomm-listen and rfcomm-listen-start, specifically.

Hope this helps!

-A.

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
