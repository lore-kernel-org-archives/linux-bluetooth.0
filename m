Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: [Bluez-users] PANU service search
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <e1effdeb0503280607600d1863@mail.gmail.com>
References: <e1effdeb05032805225cf1b8dd@mail.gmail.com>
	 <1112016560.9016.32.camel@pegasus>
	 <e1effdeb0503280607600d1863@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1112019482.9016.37.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 28 Mar 2005 16:18:02 +0200

Hi Claudio,

> Suppose an UPnP application where a control point(role GN controller)
> needs search for
> services in several servers. The control point is the active member
> and it will search for other devices. It must be the GN controller
> because sometimes foward packet is required.
> 
> The UPnP search takes few seconds therefore connect and search for UPnP service
> on each server is unacceptable.
> 
> Someone can suggest use a search for UPnP service at bluetooth SDP level,
> searching only devices that provide UPnP service. It solve the problem
> for ad hoc
> networks, but can't solve in network access point scenario. This is the reason 
> for establish the PAN and after use the UPnP search.

I have no idea what you are talking about. You need to create a low
level ACL link to do SDP searching, or create the BNEP connection or
whatever. This is the time consuming (and blocking) action. So if you
want to establish a PAN first and then do UPnP over TCP/IP that is fine.
I don't see your problem.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
