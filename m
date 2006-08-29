Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <20060829180123.GD12634@suse.de>
References: <20060822181532.6fea4851@localhost>
	<20060829110613.49f2a9a4@localhost>  <20060829180123.GD12634@suse.de>
Date: Tue, 29 Aug 2006 22:49:38 +0200
Message-Id: <1156884578.4026.25.camel@aeonflux.holtmann.net>
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

Hi Stefan,

> > I found what was wrong, and it was udev.
> > After following a tutorial I added the following rule to change the permissions upon dev creation:
> > 
> > # cat /etc/udev/rules.d/10-udev.rules 
> > KERNEL="rfcomm[0-9]*", NAME="bluetooth/%k", GROUP="users", MODE="0660"
> > 
> > after commenting it rfcomm started connecting :-D
> 
> i have
> root@susi:/tmp# cat /etc/udev/rules.d/47-rfcomm.rules
> # udev-rules for rfcomm devices
> KERNEL=="rfcomm*", NAME="%k" GROUP="uucp" MODE="0660" OPTIONS="resmgr"

these should be needed at all. The rfcommX devices are TTYs and a

	SUBSYSTEM=="tty", GROUP="dialout"

or similar should take care of the correct permissions and group
assignment.

> The OPTIONS=resmgr is probably SUSE specific, but the rest should be generic
> and works just fine for me.

Yes, it is.

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
