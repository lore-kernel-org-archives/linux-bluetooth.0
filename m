Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <7aabaf0e0610230427m2f8bfa5ekcfe2ce2fc9f165f1@mail.gmail.com>
Date: Mon, 23 Oct 2006 17:27:19 +0600
From: "Valentine Sinitsyn" <valentine.sinitsyn@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] Pin for an outgoing connection
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

Hi all,

I'm currently trying bluez-utils 3.7 (D-BUS interface is really sweet
thing and a must for all so called desktop Linux components) but
unfortunately I've came across the following problem: pin code I
specify in hcid.conf via "passphrase" option is never used for
outgoing connections. It's clear from the code in hcid/security.c but
man pages are somewhat misleading at this point - they state pin code
specified in hcid.conf will be used if I set security to "auto".

Apparently, "if" condition at security.c:386 will never be true -
pinlen is read from "pincodes" file in storage at line 364 but this
file is never created or stored through all the bluez-utils code.

The question is: is it intended behaviour or it's a bug and should be fixed?

Thanks in advance.

Regards,
Valentine

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
