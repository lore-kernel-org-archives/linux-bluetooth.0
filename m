Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Thu, 17 Aug 2006 12:35:38 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20060817113538.GB5118@srcf.ucam.org>
References: <20060816153432.GA13691@srcf.ucam.org>
	<1155770177.4075.102.camel@aeonflux.holtmann.net>
	<20060816214606.GA21719@srcf.ucam.org>
	<1155819360.4075.123.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
In-Reply-To: <1155819360.4075.123.camel@aeonflux.holtmann.net>
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

On Thu, Aug 17, 2006 at 02:56:00PM +0200, Marcel Holtmann wrote:

> You must understand that you can't do this with Bluetooth. If you wanna
> know if you can connect to a device then the baseband has to page the
> other device. This is an expensive operation and it will stall all
> ongoing paging or inquiry operations. So in general you don't wanna do
> this unless you are in a special environment and know what all users are
> doing. For the normal desktop case we simply don't know this. So it is
> not a good idea. Not speaking of the higher power consumption of such
> operations.

In this specific case, it's done at login time. That's a point where we 
/do/ know whether or not there are any existing connections (I'm 
ignoring the multiple user case, because the DBus API doesn't really 
deal with that at the moment anyway).

> You also have to think about moving targets. For example at an airport
> where a lot of devices will pass you. Trying to page them and waiting
> for a page timeout is an even more expensive operation.

Sorry, possibly I should be clearer about the behaviour I'm talking 
about here.

Imagine the case where a user has bound a set of headphones. They've 
chosen to make them their default audio device. At login time, we wish 
to attempt to reconnect to the headphones. It would be nice to be able 
to do so by checking whether the device exists or not first.

At the moment, the method for doing that would appear to be to store the 
following information:

1) The bluetooth address
2) The fact that it's a set of headphones
3) Whether it uses rfcomm or l2cap

and then at login time do service discovery (because we don't know 
whether the channel may have changed) and attempt to set up a 
connection. The alternative would be to store:

1) The bluetooth address

and then at login time attempt a baseband connection to the device. If 
it exists, then we can do service discovery and worry about the other 
pieces of information. If we can't set up a baseband connection, we 
don't need to bother.

The second approach strikes me as simpler than the first approach, but 
it requires the ability to set up that baseband connection which you're 
clearly unhappy with. Is the first approach how I should be doing this?

> So what you actually want is to set a device in periodic inquiry mode
> and then make it constantly report devices in range. 

Well, no - I don't actually care what happens to the device after that. 
If the user moves the device out of range, or if the user logs in 
without the device being switched on, then it's acceptable to require 
the user to manually reenable the device. But it's entirely reasonable 
for the user to say "If the device is switched on when I log in, please 
automatically connect to it". That's the problem that I'm trying to 
solve. Unlike periodic inquiry, this wouldn't result in any significant 
increase in power consumption. It's a one-shot-per-session thing.

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
