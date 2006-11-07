Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <000601c702a7$68eb6600$0100a8c0@kayleigh>
From: "Olivier Le Pogam" <olepogam@free.fr>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
References: <4550A345.8040809@vasmac.com>	<1162913214.21754.1.camel@aeonflux.holtmann.net>	<4550BF57.4030205@vasmac.com>	<1162923908.4793.2.camel@aeonflux.holtmann.net>	<4550E039.2070400@vasmac.com><1162932072.4793.5.camel@aeonflux.holtmann.net>
	<4550E377.7010007@vasmac.com>
Date: Tue, 7 Nov 2006 21:00:42 +0100
Mime-Version: 1.0
Subject: [Bluez-devel] Role switching
Reply-To: Olivier Le Pogam <olepogam@free.fr>,
        BlueZ development <bluez-devel@lists.sourceforge.net>
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

Hi,

I've tried two concurrent "connect" to 2 remote devices (a mobile
phone and a XP RFCOMM server) and systematically get a errno
110 on the "connect" that goes to the XP box.

I have followed Marcel advice (lm set to master) and I have recompiled
my 2.18.2002 kernel with the MH7 patch.

A "hcidump" shows that XP server is trying to switch master / slave so I
suppose that's the reason of my errno 110 (the mobile remains in slave)

Just in case ... has anybody worked a bit on the MS stack / driver and
could tell me if it's possible to disable role switch so it could remain as 
slave ?

There is a parameter under Windows CE (NoRoleSwitch) but could not
find the same for XP SP2.

Regards,
Oli 



-- 
No virus found in this outgoing message.
Checked by AVG Free Edition.
Version: 7.1.409 / Virus Database: 268.13.30/521 - Release Date: 07/11/2006


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
