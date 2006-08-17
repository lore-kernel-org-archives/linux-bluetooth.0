Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20060817100604.GA3350@srcf.ucam.org>
References: <20060817100604.GA3350@srcf.ucam.org>
Date: Thu, 17 Aug 2006 15:04:18 +0200
Message-Id: <1155819858.4075.134.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Cc: bluez-devel@lists.sf.net
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

Hi Matthew,

> I sent this a couple of weeks ago, but didn't get any feedback. This 
> patch implements the Connect and Disconnect methods in the 
> org.bluez.RFCOMM namespace. I've changed it to use integers for services 
> rather than the string identifiers for a couple of reasons:
> 
> 1) Nothing else seems to actually use the strings right now, even when 
> the docs suggest they do
> 2) The service values don't appear to be complete and don't deal with 
> the case of having multiple services of the same general type on a 
> device
> 
> Based on previous discussion with Marcel, this patch may not be ideal 
> since it doesn't deal with the case of the whether or not cached values 
> are valid. However, if the API is considered correct, then it would be 
> nice to add it with a note that it may not work under certain 
> circumstances and then fix that at some later stage.

I haven't payed much attention to the RFCOMM parts of our D-Bus API
since I declared it as experimental and it might still change. However
one thing is that we wanna use strings. They are more flexible and if
you use languages like Python they can come in handy.

In this case for example you might use "spp" (service name) or
"0x10000" (record handle) to connect to a specific RFCOMM channel.

The SDP caching is still something that needs a lot of thinking before
we will finally solve it. It is not as easy as people thing and always
requesting a SDP record first is not a good idea either. However a lot
of this depends on how broken the SDP records of the remote devices are.

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
