Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <44F183CE.5030402@pracucci.com>
Date: Sun, 27 Aug 2006 11:36:46 +0000
From: Marco Pracucci <development@pracucci.com>
MIME-Version: 1.0
To: Bluez Users ML <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] Cross compiling bluez-utils dependancies (dbus)
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

Dear list,

I have cross compiled (for ARM) latests bluez-libs and openobex libs,
but I can't cross compile dbus (required for bluez-utils). I have posted
a message to dbus mailing list, but I can't get any reply.

Dbus configure script fails when cross compiling, because it tries to
compile and *run* several test programs (for example, to check for
getpwnam_r function).

---
./configure --host=arm-linux --prefix=/path --with-expat
[...]
checking for posix getpwnam_r... configure: error: cannot run test
program while cross compiling
---

Did you ever cross compiled dbus and bluez-utils?


Thanks,
Marco Pracucci


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
