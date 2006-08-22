Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Andrew Kohlsmith <akohlsmith-bluez@benshaw.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Date: Tue, 22 Aug 2006 13:57:31 -0400
References: <20060822181532.6fea4851@localhost>
	<200608221227.15052.akohlsmith-bluez@benshaw.com>
	<20060822195219.7cef2680@localhost>
In-Reply-To: <20060822195219.7cef2680@localhost>
MIME-Version: 1.0
Message-Id: <200608221357.31980.akohlsmith-bluez@benshaw.com>
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

On Tuesday 22 August 2006 13:52, The Peach wrote:
> really nice tools and they all work flawless! :)
> The problem now is another: if I want to connect to a GPS reciever to use
> gpsd and gpsdrive I do need a physical device: can I accompilsh this task
> with any of these tools?

I'd imagine you could use rfcomm-listen-start and tell gpsd to look at stdin.  
If not, just use rfcomm --bind; I've never had issue with that.  it's 
--connect that gets my goat.

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
