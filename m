Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <453B9F4D.7080504@free.fr>
Date: Sun, 22 Oct 2006 18:41:49 +0200
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <452E84DA.9090307@free.fr>	<452E99E8.6070406@vasmac.com>	<452FBC82.1080901@free.fr>	<452FDC44.90803@vasmac.com>	<45310A24.1000604@free.fr>
	<453114A0.50503@vasmac.com>
In-Reply-To: <453114A0.50503@vasmac.com>
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

> Hi Fabien,
> 
> It's my understanding from reading the IEEE spec that Bluetooth

Could you point me to what you refer to ?
I had a look to the following document
http://www.bluetooth.com/NR/rdonlyres/24C24181-5B5D-4566-BB4F-D4C302910B9D/1766/Volume4_SPEC.pdf
which describes bt transport over uart, but did not find any mention of 
synchronous flow control beeing mandatory :-(

> compliant devices with UART interface must support synchronous
> flow control if they support SCO channels. But I have no experience
> with such devices. Has anyone else used such a device?

I don't either :-(

Cheers,

Fabien

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
