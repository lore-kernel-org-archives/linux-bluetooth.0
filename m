Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <2EB6297382462046A9427D7324788A4801A38CD0@MCLNEXVS06.resource.ds.bah.com>
References: <2EB6297382462046A9427D7324788A4801A3898D@MCLNEXVS06.resource.ds.bah.com>
	<1171308791.11774.6.camel@violet>
	<2EB6297382462046A9427D7324788A4801A38CD0@MCLNEXVS06.resource.ds.bah.com>
Date: Tue, 13 Feb 2007 15:04:53 +0100
Message-Id: <1171375493.23580.22.camel@violet>
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

> When the oops occurs, I lose the keyboard on my PC and I can only reboot
> with the mouse.
> 
> So, the best I can do is to tail -f /var/log/messages in another
> terminal window, and then copy the oops output to send to you. Is there
> another way ??
> 
> So I did 
> hcitool -i hci0 info xx:xx:xx:xx:xx:xx in one window,
> hcitool -i hci1 info xx:xx:xx:xx:xx:xx in a second window,
> 
> Note that the remote BD address is the same, but two USB dongles are
> installed.
> 
> Here is the output from /var/log/messages. I hope this is sufficient for
> what you need.

my guess is that it might be fixed with 2.6.20 kernel. Please try that
kernel.

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
