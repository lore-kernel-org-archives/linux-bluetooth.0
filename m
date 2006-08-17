Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Thu, 17 Aug 2006 12:41:16 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20060817114116.GC5118@srcf.ucam.org>
References: <20060817100604.GA3350@srcf.ucam.org>
	<1155819858.4075.134.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
In-Reply-To: <1155819858.4075.134.camel@aeonflux.holtmann.net>
Subject: Re: [Bluez-devel] [PATCH] implement RFCOMM Connect and
	Disconnect	methods
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

On Thu, Aug 17, 2006 at 03:04:18PM +0200, Marcel Holtmann wrote:

> I haven't payed much attention to the RFCOMM parts of our D-Bus API
> since I declared it as experimental and it might still change. However
> one thing is that we wanna use strings. They are more flexible and if
> you use languages like Python they can come in handy.
> 
> In this case for example you might use "spp" (service name) or
> "0x10000" (record handle) to connect to a specific RFCOMM channel.

I'm not entirely clear on what a service name represents. Is it a 
specific service, or is it the profile implemented by that service? What 
string should represent non-standard services? As an example, my phone 
has a service called "Nokia OBEX PC Suite Services". If I want to use 
that via the DBus interface, I'll presumably need to use the record 
handle anyway?

> The SDP caching is still something that needs a lot of thinking before
> we will finally solve it. It is not as easy as people thing and always
> requesting a SDP record first is not a good idea either. However a lot
> of this depends on how broken the SDP records of the remote devices are.

I agree that always requesting the SDP record first is less than ideal, 
but I'd argue that it's better to have suboptimal functionality than no 
functionality :)

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
