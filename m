Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4550EC62.2050708@vasmac.com>
Date: Tue, 07 Nov 2006 15:28:18 -0500
From: Jose Vasconcellos <jose@vasmac.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <4550A345.8040809@vasmac.com>	<1162913214.21754.1.camel@aeonflux.holtmann.net>	<4550BF57.4030205@vasmac.com>	<1162923908.4793.2.camel@aeonflux.holtmann.net>	<4550E039.2070400@vasmac.com>	<1162932072.4793.5.camel@aeonflux.holtmann.net>	<4550E377.7010007@vasmac.com>
	<1162933029.4793.7.camel@aeonflux.holtmann.net>
In-Reply-To: <1162933029.4793.7.camel@aeonflux.holtmann.net>
Subject: [Bluez-devel] Case handling (was: Bonding)
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

Hi Marcel,

Looking at this code I find the logic a bit convoluted.
I don't see the point of the case checking. Wouldn't
be easier to convert any address coming from the dbus
to upper case once?

Jose


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
