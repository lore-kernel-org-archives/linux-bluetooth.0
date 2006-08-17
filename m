Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <66dc03c80608161821pda00e42ra69e3775814614de@mail.gmail.com>
Date: Wed, 16 Aug 2006 22:21:19 -0300
From: "=?ISO-8859-1?Q?Cezar_S=E1_Espinola?=" <cezarsa@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20060816214606.GA21719@srcf.ucam.org>
MIME-Version: 1.0
References: <20060816153432.GA13691@srcf.ucam.org>
	<1155770177.4075.102.camel@aeonflux.holtmann.net>
	<20060816214606.GA21719@srcf.ucam.org>
Subject: Re: [Bluez-devel] DBus interface - determining whether a device
	exists
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

> Right. But the DBus interface doesn't seem to provide any mechanism for
> initiating a connection to the device. GetName and the like appear to
> provide cached results even if the device is now out of range, which
> isn't what I want.
Hi Matthew,

What about RFCOMM ConnectByChannel? Wouldn't it do the job?

Best Regards,
Cezar

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
