Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <4532DBA4.5060009@gmail.com>
References: <4531BD65.1020107@gmail.com>
	<1160917860.23675.7.camel@localhost> <453233F5.3030302@gmail.com>
	<4532DBA4.5060009@gmail.com>
Date: Mon, 16 Oct 2006 09:35:27 +0200
Message-Id: <1160984127.5498.0.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] PIN Authentication Problems on MDV 2007
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

Hi Manuel,

> >> starting with bluez-utils-3.x the PIN helper concept has been replaced
> >> with a passkey agent interface. You need to run a passkey agent to get
> >> you PIN request dialog. One example would be bt-applet from the
> >> bluez-gnome package
> >
> I could fix it. How do I tell BlueZ to always use the same passkey 
> agent? Like it was done in the pass with the pin stuff?

you install a default passkey agent and have no device specific passkey
agent running at the same time.

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
