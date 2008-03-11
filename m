Return-Path: <cyrus@holtmann.org>
Message-ID: <47D6F3BF.5060802@verticon.com>
Date: Tue, 11 Mar 2008 16:03:59 -0500
From: "John E. Conlon" <jconlon@verticon.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] make problem bluez-utils 3.28
Reply-To: jconlon@verticon.com,
	BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


I am attempting to update my Centos 4.6 to bluez 3.28.   Since I could 
not find pre - compiled packages for Centos 4.6 I have been trying to 
compile both bluez-libs and bluez-utils.  Encountered no problem with 
bluez-libs.

On my first attempt to make the bluez-utils I encountered an error with 
Configure stating I needed to upgrade the d-bus lib, did this (upgrade 
to 1.0.2) but now

'make all' is failing to compile bluez-utils and exiting with the error:

gcc -DHAVE_CONFIG_H -I. -I.. -I../common   -I/usr/include/dbus-1.0 
-I/usr/lib/dbus-1.0/include    -I../eglib -Wall -O2 -D_FORTIFY_SOURCE=2 
-MT bridge.o -MD -MP -MF .deps/bridge.Tpo -c -o bridge.o bridge.c
bridge.c: In function `bridge_create':
bridge.c:78: error: `SIOCBRADDBR' undeclared (first use in this function)
bridge.c:78: error: (Each undeclared identifier is reported only once
bridge.c:78: error: for each function it appears in.)
bridge.c: In function `bridge_remove':
bridge.c:94: error: `SIOCBRDELBR' undeclared (first use in this function)
bridge.c: In function `bridge_add_interface':
bridge.c:117: error: `SIOCBRADDIF' undeclared (first use in this function)
make[2]: *** [bridge.o] Error 1

I am a complete make file novice, (probably evident from the question)  
how shall I precede to resolve this (configuration issue)?

Thanks in advance for any suggestions,

John Conlon

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
