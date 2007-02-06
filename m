Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <5b9417770702061247u4b1d8e70t106fa07a8d220369@mail.gmail.com>
Date: Tue, 6 Feb 2007 14:47:34 -0600
From: "John H." <mistamaila@gmail.com>
To: bluez-users@lists.sourceforge.net, Bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] how to encrypt rfcomm being binded automatically?
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

This all works, on boot, etc, but how to encrypt traffic automatically?

rfcomm0 {
 bind yes;
 device 00:1A:77:ED:D1:97;
 channel 4;
 comment "Motorola Q";
}

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
