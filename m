Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20060817081503.GA1086@srcf.ucam.org>
References: <20060816153432.GA13691@srcf.ucam.org>
	<1155770177.4075.102.camel@aeonflux.holtmann.net>
	<20060816214606.GA21719@srcf.ucam.org>
	<66dc03c80608161821pda00e42ra69e3775814614de@mail.gmail.com>
	<20060817081503.GA1086@srcf.ucam.org>
Date: Thu, 17 Aug 2006 14:57:55 +0200
Message-Id: <1155819475.4075.126.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] DBus interface - determining whether a
	device	exists
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

Hi Matthew,

> > > Right. But the DBus interface doesn't seem to provide any mechanism for
> > > initiating a connection to the device. GetName and the like appear to
> > > provide cached results even if the device is now out of range, which
> > > isn't what I want.
> > Hi Matthew,
> > 
> > What about RFCOMM ConnectByChannel? Wouldn't it do the job?
> 
> Well, it's not necessarily an RFCOMM connection. I'd prefer to just be 
> able to store the fact that a device exists rather than what sort of 
> connection and on what channels, especially since Marcel mentioned that 
> the channel may well have changed if the Bluetooth device has been 
> rebooted.

what you actually want is something like l2ping so see if a device is
alive or not. At the moment I am not considering such an extension,
because we shouldn't page devices to see if they are active or not.

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
