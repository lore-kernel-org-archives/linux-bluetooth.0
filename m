Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Fri, 18 Aug 2006 21:14:01 +0100 (BST)
To: bluez-devel@lists.sf.net
MIME-Version: 1.0
Message-Id: <1155932042.213626.26343.nullmailer@galant.ukfsn.org>
From: Iain Hibbert <plunky@rya-online.net>
Subject: [Bluez-devel] bluez-firmware-1.2.tar.gz licence
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

Hi,
   I was wondering what the licence terms were on the bluez-firmware
tarball, can anybody say?

   The only 'licence' I see there is a GPLv2 file but surely that does not
cover the firmware files?

   What I have done is create a program to load the broadcom firmware for
NetBSD, and have created a pkgsrc package to bind it all together, so I'm
wondering if I should limit the redistribution of

	a) the bluez-firmware-1.2.tar.gz file, and

	b) the binary package which will contain BCM2033-MD.hex,
	BCM2033-FW.bin and BCM-LEGAL.txt

since it is possible that either could end up on mirror sites.

thanks,
iain
(I'm not subscribed to this list, please include me in replies)

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
