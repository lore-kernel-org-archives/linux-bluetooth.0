Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <200609132256.43426.cijoml@volny.cz>
References: <200609032015.51210.cijoml@volny.cz>
	<200609062040.14856.cijoml@volny.cz>
	<1157588855.30159.49.camel@aeonflux.holtmann.net>
	<200609132256.43426.cijoml@volny.cz>
Date: Wed, 13 Sep 2006 23:27:52 +0200
Message-Id: <1158182872.4485.16.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] bluez utils debian package
	doesn't	autoswith	dongle on?
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

Hi Michal,

> can you help with that dbus thing? I can't get it work and there is probably 
> no howto :(
> 
> hcid still fails for me saying that annoying dbus error

I have tested this on Debian Unstable, Ubuntu Dapper and Fedora Core 5
and I don't have any problems. However you need to install the D-Bus
packages and make sure the system has been started. It is also a good
idea to follow the configure options from the README file.

Regards

Marcel



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
