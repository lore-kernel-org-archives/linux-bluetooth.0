Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Wed, 16 Aug 2006 22:46:06 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20060816214606.GA21719@srcf.ucam.org>
References: <20060816153432.GA13691@srcf.ucam.org>
	<1155770177.4075.102.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
In-Reply-To: <1155770177.4075.102.camel@aeonflux.holtmann.net>
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

On Thu, Aug 17, 2006 at 01:16:17AM +0200, Marcel Holtmann wrote:

> this is a general Bluetooth problem. If you don't have a connection
> between two devices then there is no radio traffic. This is one of big
> difference between Bluetooth and WiFi.

Right. But the DBus interface doesn't seem to provide any mechanism for 
initiating a connection to the device. GetName and the like appear to 
provide cached results even if the device is now out of range, which 
isn't what I want.

There's an obvious use case for having a function that is, effectively, 
"Can I currently connect to the device with this bluetooth address". The 
patch I sent provides that, but if that's unacceptable then what should 
the interface look like?

Thanks,
-- 
Matthew Garrett | mjg59@srcf.ucam.org

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
