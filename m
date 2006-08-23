Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-Id: <44EC4CFC.4060400@arcor.de>
Date: Wed, 23 Aug 2006 14:41:32 +0200
From: Simon Siemens <Simon.Siemens@arcor.de>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] Inquiry in Bluetooth 1.2
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

The Bluetooth 1.2 specification has to major improvements to reduce the
inquiry time: Enhanced Inquiry Scan and Interlaced Inquiry Scan
(http://wireless.sys-con.com/read/43887.htm). The article states, that
enhanced inquiry scan reduces the maximum inquiry time from 10 to 5
seconds and improves the reliability. Interlaced inquiry scan should
halve the inquiry time further.

As far as I understood things both mechanisms act on the side of the
listener, not the discoverer. I can also find both names in the feature
section of the Bluetooth 1.2 specification (section 3.2 on page 203).
The interlaced inquiry scan is described in section 8.4.1 "Inquiry scan
substate" (on page 144) as a method, where the scanning device checks
not only one but two frequencies in both trains at once. This halves the
maximum inquiry time.

However I could not find anything further about enhanced inquiry scan.
And tests with two Bluetooth v2.0 +EDR devices did not reduce the
maximum inquiry time (without interlaced inquiry) below 10 seconds.

So what is this enhanced inquiry scan? How is it compared to the old
v1.1 inquiry scan? How can I activate it? (Currently one device is a
Nokia N70 and the other is a Linux computer with a MSI 3X BToes dongle.)

Thanks a lot,

Simon



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
