Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0503280607600d1863@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: [Bluez-users] PANU service search
In-Reply-To: <1112016560.9016.32.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <e1effdeb05032805225cf1b8dd@mail.gmail.com>
	 <1112016560.9016.32.camel@pegasus>
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
Date: Mon, 28 Mar 2005 11:07:13 -0300

Hi Marcel,

Suppose an UPnP application where a control point(role GN controller)
needs search for
services in several servers. The control point is the active member
and it will search for other devices. It must be the GN controller
because sometimes foward packet is required.

The UPnP search takes few seconds therefore connect and search for UPnP service
on each server is unacceptable.

Someone can suggest use a search for UPnP service at bluetooth SDP level,
searching only devices that provide UPnP service. It solve the problem
for ad hoc
networks, but can't solve in network access point scenario. This is the reason 
for establish the PAN and after use the UPnP search.

Regards,
Claudio.



On Mon, 28 Mar 2005 15:29:20 +0200, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Claudio,
> 
> > The sdptool doesn't provide search for PANU service. Is there plans
> > for implement this?
> 
> you can do it by "sdptool search --bdaddr <bdaddr> 0x1115".
> 
> > A PANU device can be started with the following command:
> > pand --listen --role PANU
> >
> > This scenario can be usefull when there are a lot of servers and a
> > client device works as a GN connecting these servers. eg: UPnP applications.
> 
> The pand client can search for PANU by itself and I don't see any real
> use for it. However send in a patch for it.
> 
> Regards
> 
> Marcel
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
