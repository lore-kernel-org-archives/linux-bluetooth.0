Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Pierre-Yves Paulus <py@idlum.be>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1151658521.753.38.camel@localhost>
References: <1151590561.753.27.camel@localhost>
	<1151658521.753.38.camel@localhost>
Date: Mon, 03 Jul 2006 08:00:48 +0200
Message-Id: <1151906449.15040.12.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] DBus API and rfcomm crashing hcid
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

Hello,

> However, this obviously does nothing to solve the fact that the
> connection fails at the ioctl call. I still need to figure out how all
> that stuff works...

I just figured out it was failing because of the lack of RFCOMM TTY in
my kernel... I now can get the device created just as expected!

May I suggest the following patch (line numbers are according to the
version of the file patched as explained in my previous message on this
thread), which helps to spot the problem faster than "Operation not
supported" does? This also is the way it is done in
bluez-utils/rfcomm/main.c (at about line 178).


*** orig/dbus-rfcomm.c  Mon Jul  3 07:53:10 2006
--- new/dbus-rfcomm.c   Mon Jul  3 07:53:56 2006
***************
*** 268,273 ****
--- 268,275 ----
        if (node->id < 0) {
                err = errno;
                error("ioctl(RFCOMMCREATEDEV): %s (%d)",
strerror(errno), err);
+               if (err == EOPNOTSUPP)
+                 fprintf(stderr, "RFCOMM TTY support not available\n");
                error_failed(c->conn, c->msg, err);
                goto failed;
        }


(There seem to be a "buggy" line wrap due to the fact it is pasted
inside the e-mail body. Should I better send patches as attachments?)

Any comment very welcome again.

Pierre-Yves Paulus



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
