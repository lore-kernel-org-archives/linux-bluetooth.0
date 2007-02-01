Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Paul Brook <paul@codesourcery.com>
To: bluez-devel@lists.sf.net
Date: Thu, 1 Feb 2007 14:54:02 +0000
MIME-Version: 1.0
Message-Id: <200702011454.02418.paul@codesourcery.com>
Subject: [Bluez-devel] Celluon CL800BT laserkey keyboard
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

I've recently obtained a Celluon CL800BT "Laserkey" bluetooth keyboard.
I notice that fakehid.c has partial support for this device. It's initialized, 
but the protocol decoding bits seem to be missing.

Before I start reverse-engineering the protocol, is anyone already wokring on 
this, or have any relevant information? Has anyone asked Celluon for protocol 
documentation?

Paul

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
