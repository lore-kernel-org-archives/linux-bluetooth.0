Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Sun, 20 Aug 2006 01:31:54 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20060820003154.GA17093@srcf.ucam.org>
References: <20060817100604.GA3350@srcf.ucam.org>
	<1155819858.4075.134.camel@aeonflux.holtmann.net>
	<20060817114116.GC5118@srcf.ucam.org>
	<20060817115912.GA24906@localhost.localdomain>
	<20060819143608.GA31812@srcf.ucam.org>
	<1156037973.3989.14.camel@aeonflux.holtmann.net>
	<20060819235330.GA16375@srcf.ucam.org>
	<1156040029.3989.22.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
In-Reply-To: <1156040029.3989.22.camel@aeonflux.holtmann.net>
Subject: Re: [Bluez-devel] [PATCH] implement RFCOMM
	Connect	and	Disconnect	methods
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

On Sun, Aug 20, 2006 at 04:13:48AM +0200, Marcel Holtmann wrote:

> I meant exactly that. The method should work out what information got
> passed to it. Of course this might not be easy to implement, but that is
> not the point behind this API. The whole API is designed to make it easy
> for all kind of applications. And the main focus is not the C language.

Ok, cool. Now I know what to aim for, I'll head back to that :)

> I also don't see the problem here. The ASCII service string are a
> predefined list of names that actually match to specific UUID. Since in
> the end we will implement all needed service names for all known
> profiles, we only need to support UUID128. These have a unique form and
> are kinda easy to detect. If the provided UUID128 matches the Bluetooth
> base string, then we can internally use UUID32 or UUID16. As simple as
> that. For the record handles we give them in hex and so they are also
> easy to identify. And I would check the string in this order.

Ok, makes sense.

> And as said, this might require a little bit more code in hcid, but that
> is the price to pay if we wanna have a simple API for the application
> and I am paying it gladly.

Sure. I'll send a new patch tomorrow.

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
