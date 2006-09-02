Return-Path: <bluez-users-bounces@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Dick <dm@chello.nl>
Date: Sat, 2 Sep 2006 20:41:37 +0000 (UTC)
Message-ID: <loom.20060902T222740-106@post.gmane.org>
References: <loom.20060902T125209-74@post.gmane.org>
	<1157221409.32195.0.camel@aeonflux.holtmann.net>
	<loom.20060902T200908-292@post.gmane.org>
Mime-Version: 1.0
Subject: Re: [Bluez-users]
	=?utf-8?q?adding_a_SDP_attribute_HID=5FDESCRIPTOR?=
	=?utf-8?q?=5FLIST?=
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

Oh boy I've found the segfault :-)

My HID descriptor is too large to fit in SDP_SEQ_PDUFORM_SIZE
... I almost wouldn't dare to ask but ... 
Could it please be increased from 128 to something larger or equal to 168?

It would also be nice to have some range checking ;-)

TIA

Dick


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
