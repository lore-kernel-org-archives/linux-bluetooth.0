Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Wed, 23 Aug 2006 01:22:31 +0200
From: The Peach <smartart@tiscali.it>
To: bluez-users@lists.sourceforge.net
Message-ID: <20060823012231.1f6ce777@localhost>
In-Reply-To: <200608221357.31980.akohlsmith-bluez@benshaw.com>
References: <20060822181532.6fea4851@localhost>
	<200608221227.15052.akohlsmith-bluez@benshaw.com>
	<20060822195219.7cef2680@localhost>
	<200608221357.31980.akohlsmith-bluez@benshaw.com>
Mime-Version: 1.0
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

On Tue, 22 Aug 2006 13:57:31 -0400
Andrew Kohlsmith <akohlsmith-bluez@benshaw.com> wrote:

> I'd imagine you could use rfcomm-listen-start and tell gpsd to look at stdin.  
> If not, just use rfcomm --bind; I've never had issue with that.  it's 
> --connect that gets my goat.

it's getting me more errors than expected:
if I use the rfcomm-listen I get a timeout (is there no association
with the device? no pin input or such things? I cannot disable it on the GPS device).
if I use the rfcomm-read I get a 

connect: : Resource temporarily unavailable

probably I start it the right way... any hint about it?

instead if I try to just bind the interface with rfcomm I get an hardlock and I must reboot when I start gpsdrive.

is there no other solution to `rfcomm connect` to work than not using it?


thanks,
-- 
Matteo 'Peach' Pescarin

ICQ UIN = 71110111
Jabber ID = smartart@unstable.nl
Web Site = http://www.smartart.it
GeCHI = http://www.gechi.it

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
