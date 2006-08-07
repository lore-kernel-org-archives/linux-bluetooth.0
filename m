Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Stefan Rompf <stefan@loplof.de>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Date: Mon, 7 Aug 2006 21:14:07 +0200
References: <200608031704.59095.stefan@loplof.de>
	<1154686314.3905.87.camel@aeonflux.holtmann.net>
In-Reply-To: <1154686314.3905.87.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
Message-Id: <200608072114.07923.stefan@loplof.de>
Subject: Re: [Bluez-users] rfcomm-"server" for linux wanted
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

Hi Marcel,

> you can use "rfcomm listen ..." for that and after the connection has
> been established you can copy the data to the TTY. Otherwise you have to
> write such a small program by yourself. Look at rctest for an example.

I also needed to tell sdpd to announce the service with "sdptool add 
--channel=28 SP", but then rfcomm processed the incoming connection nicely. 
Thanks for your help!

Stefan

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
