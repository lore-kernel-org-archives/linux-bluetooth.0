Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: [Bluez-devel] PAN Attributes
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <42397A0E.6050001@indt.org>
References: <4238804C.4070607@indt.org> <1111058131.11792.65.camel@pegasus>
	 <42397A0E.6050001@indt.org>
Content-Type: text/plain
Message-Id: <1111068451.11792.81.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 17 Mar 2005 15:07:31 +0100

Hi Claudio,

> Currently, I think that PAN attributes are not being exported(registered)
> at server side. Therefore, I need add to NAP/GN and retrieve from PANU.

the pand creates the SDP record if it is executes in server mode.

> I didn't find references for them. "pan_attrib_names" structure is used
> only in the uuid16_names and at the moment I don't know how change
> the code to make these information available.
> 
> My objective is try enhance/make easy the PAN setup. Currently, the
> user has to be aware of the PAN role and setup the IP address in
> both side(master and slave).
> 
> In the PAN Profile, Zeroconf is one of  suggested standard to solve
> the IP assigment problem. Zeroconf generates a pseudo random IP.
> However, this approach is NOT feasible for Bluetooth PAN. For NAP
> scenario, a route must be added in the PANU to reach the gateway.
> But the PANU doesn't know the NAP IP address!!!
> 
> Using the IPv4Subnet attribute and using a rule for gateway IP
> assigment the PANU can be able to get the NAP IP. Another aproach
> is add one attribute like "gateway address", but this implies in PAN
> profile changes and I think that this is not a simple process.

Why don't you create a bridge and put a DHCP server on the bridge
interface? This is working fine on my systems.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
