Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <1152824480.6204.18.camel@anselm.venusberg.augustinnetz.de>
References: <1152824480.6204.18.camel@anselm.venusberg.augustinnetz.de>
Date: Thu, 13 Jul 2006 23:05:44 +0200
Message-Id: <1152824744.4838.83.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] HID device support
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

Hi Anselm,

> my web search about the status of HID support in Bluez did not turn out
> too much. As far as my probing went, boot protocol is supported.
> 
> I did not manage to get non-boot-protocol devices working though, they
> just turn up as "boot protocol device" although their SDP record
> explicitely contains
> 
> Attribute Identifier 0x20e - boot protocol: 0x0
> 
> Should "full HID mode" work, or is that not the case for kernel module
> version 1.1 (2.6.17.4, as from kernel.org)?

use the -mh patch and you get report protocol mode.

Regards

Marcel




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
