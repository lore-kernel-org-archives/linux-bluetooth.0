Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <44F183CE.5030402@pracucci.com>
References: <44F183CE.5030402@pracucci.com>
Date: Sun, 27 Aug 2006 16:12:37 +0200
Message-Id: <1156687957.5613.6.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Cross compiling bluez-utils dependancies (dbus)
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

Hi Marco,

> I have cross compiled (for ARM) latests bluez-libs and openobex libs,
> but I can't cross compile dbus (required for bluez-utils). I have posted
> a message to dbus mailing list, but I can't get any reply.
> 
> Dbus configure script fails when cross compiling, because it tries to
> compile and *run* several test programs (for example, to check for
> getpwnam_r function).

you might wanna report this on the D-Bus mailing list and not here.

> Did you ever cross compiled dbus and bluez-utils?

Since the Nokia 770 uses D-Bus and BlueZ, it seems that some people did
this and also made a product out of it.

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
