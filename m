Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <2EB6297382462046A9427D7324788A4801A3898D@MCLNEXVS06.resource.ds.bah.com>
References: <2EB6297382462046A9427D7324788A4801A3898D@MCLNEXVS06.resource.ds.bah.com>
Date: Mon, 12 Feb 2007 20:33:11 +0100
Message-Id: <1171308791.11774.6.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Oops with multiple hcitool commands
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

Hi Richard,

> I am building a project that will use multiple HCI devices on a single
> Linux PC. I have a USB hub, and several Linksys Bluetooth dongles. On
> my PC I open two terminal windows and then run the following commands:
>  
> window 1#  hcitool -i hci0 info 00:18:C5:2C:5E:C2
> window 2#  hcitool -i hci1 info 00:18:C5:2C:5E:C2
>  
> The two commands must run simultaneously. Just these two commands run
> quickly one after the other will almost always cause the oops. The
> problem does not occur if the two hcitool info commands are examining
> different remote devices. You must go after the same remote device.

please post the oops message from the kernel.

Regards

Marcel



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
