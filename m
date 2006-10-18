Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <453447B2.000105.05297@bj126app48.126.com>
References: <453447B2.000105.05297@bj126app48.126.com>
Date: Wed, 18 Oct 2006 19:20:19 +0200
Message-Id: <1161192019.30606.20.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] BGB204 Can't init device hci0: Connection
	timed	out (110)
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

> I'm using Philips(NXP)BGB204 bluetooth Sip under the Linux 2.6.9
> kernel and ran into problems now. The scenario was as follows:

I have a BGB208 for testing and have some similar problems. The 2.6.9
should work fine, but I would prefer if you test with a 2.6.18 kernel
instead, because that one is more recent.

However the following line should attach the device correctly.

	./hciattach ttyS1 any 115200 flow

If you use the Ericsson id, it will start with 57600 and then try to
switch into the higher baudrate. As far as I know all BGB from Philips
boot up by default in 115200.

Regards

Marcel



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
