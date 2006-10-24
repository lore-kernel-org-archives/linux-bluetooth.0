Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <453D2170.8010600@vasmac.com>
References: <452E84DA.9090307@free.fr>	<452E99E8.6070406@vasmac.com>
	<452FBC82.1080901@free.fr>	<452FDC44.90803@vasmac.com>
	<45310A24.1000604@free.fr>	<453114A0.50503@vasmac.com>
	<453B9F4D.7080504@free.fr>	<453BAAFC.1090206@vasmac.com>
	<453D0CFD.1030909@free.fr>  <453D2170.8010600@vasmac.com>
Date: Tue, 24 Oct 2006 09:34:40 +0200
Message-Id: <1161675280.10866.127.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] Updated sco flow control feature
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

Hi Jose,

> Very interesting. I interpreted this to mean that if synchronous
> channels are supported, then synchronous flow control is required.
> Some form of feedback from the HCI device is required to main
> synchronization. If you use timers you run occasional the risk of
> getting out of sync.

that shouldn't be such a problem. It is only audio data.

> All this speculation can be clarified if someone with an actual UART
> dongle can speak up. The patch that I posted should work as long
> as the device implements synchronous  flow control. Maybe the
> solution is to not support SCO on UART until someone can take
> responsibility.

I have a couple of UART based development kits at home and I can
actually test it. However you shouldn't think about the actual transport
at all. This is the job of the driver and not the Bluetooth core. So it
must work with SCO flow control enabled and disabled.

> BTW, the IEEE spec is the base for bluetooth.

That is wrong. The IEEE specification was written based on the Bluetooth
specification. What gets released by the Bluetooth SIG at bluetooth.com
is the specification that counts.

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
