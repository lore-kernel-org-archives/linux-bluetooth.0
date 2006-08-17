Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20060816214606.GA21719@srcf.ucam.org>
References: <20060816153432.GA13691@srcf.ucam.org>
	<1155770177.4075.102.camel@aeonflux.holtmann.net>
	<20060816214606.GA21719@srcf.ucam.org>
Date: Thu, 17 Aug 2006 14:56:00 +0200
Message-Id: <1155819360.4075.123.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] DBus interface - determining whether
	a	device	exists
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

> > this is a general Bluetooth problem. If you don't have a connection
> > between two devices then there is no radio traffic. This is one of big
> > difference between Bluetooth and WiFi.
> 
> Right. But the DBus interface doesn't seem to provide any mechanism for 
> initiating a connection to the device. GetName and the like appear to 
> provide cached results even if the device is now out of range, which 
> isn't what I want.

the GetName results are cached. That is correct, but they are also
updated every time we get new information about it. For example if hcid
sees a ACL connection, it requests the remote name again. This is a
cheap operation at no costs and keeps the name up-to-date. Also if you
see an extended inquiry or a name resolve itself it will update the
cache and send out a RemoteNameChanged signal. The same applies to other
information like class of device etc.

> There's an obvious use case for having a function that is, effectively, 
> "Can I currently connect to the device with this bluetooth address". The 
> patch I sent provides that, but if that's unacceptable then what should 
> the interface look like?

You must understand that you can't do this with Bluetooth. If you wanna
know if you can connect to a device then the baseband has to page the
other device. This is an expensive operation and it will stall all
ongoing paging or inquiry operations. So in general you don't wanna do
this unless you are in a special environment and know what all users are
doing. For the normal desktop case we simply don't know this. So it is
not a good idea. Not speaking of the higher power consumption of such
operations.

You also have to think about moving targets. For example at an airport
where a lot of devices will pass you. Trying to page them and waiting
for a page timeout is an even more expensive operation.

So what you actually want is to set a device in periodic inquiry mode
and then make it constantly report devices in range. However this should
be an optional operation, because the power consumption argument is here
valid, too. For most Bluetooth 1.2 and 2.0 dongles you then get inquiry
results that also include the RSSI value. From these you can make an
assumption if a device is near enough. There is threshold of RSSI that
indicates a device will not be in range for a connection even if an
inquiry sees it.

So from my part I am happy to see support for periodic inquiry and this
is what you actually should go with. I can't think of an API at the
moment, but I must admit that I didn't put any big effort into it right
now. Feel free to propose something.

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
