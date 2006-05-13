Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <50307.71.109.111.205.1147543317.squirrel@71.109.111.205>
From: charles@thewybles.com
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Subject: [Bluez-devel] bluetooth-alsa compile Issues
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sat, 13 May 2006 11:01:57 -0700 (PDT)

Hello everyone,

   I am attempting to compile bluetooth-alsa from CVS (freshly checked out
before sending this e-mail). It fails. Here are the issues:

1. Missing config.h.in
2. Missing .po files

Is the bluetooth-alsa project still using CVS? Should I be looking
somewhere else other then the SF CVS repository for the code? I would
greatly appreciate if someone could do a fresh checkout and see if they
can reproduce the problem. I am running debian testing. I have the latest
versions of autotools as well as version 1.7 as mentioned on the site. The
compile fails with both.


If I can be of any further assistance please let me know. I am more then
happy to try with autoconf hackery etc. Whatever is needed.

Thanks!



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
