Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Wed, 16 Aug 2006 16:34:32 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: bluez-devel@lists.sf.net
Message-ID: <20060816153432.GA13691@srcf.ucam.org>
Mime-Version: 1.0
Subject: [Bluez-devel] DBus interface - determining whether a device exists
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

I'd like to use the DBus interface to determine whether or not a 
Bluetooth device is currently in range of the computer in order to work 
out whether or not it's possible to connect to it. Checking through the 
API suggests that there's currently nothing suitable for doing that. 
What would be the best way to implement it?

Thanks,
-- 
Matthew Garrett | mjg59@srcf.ucam.org

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
