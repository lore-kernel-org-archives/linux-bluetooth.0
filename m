Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb050328110339a02eb7@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: [Bluez-users] PANU service search
In-Reply-To: <1112019482.9016.37.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <e1effdeb05032805225cf1b8dd@mail.gmail.com>
	 <1112016560.9016.32.camel@pegasus>
	 <e1effdeb0503280607600d1863@mail.gmail.com>
	 <1112019482.9016.37.camel@pegasus>
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
Date: Mon, 28 Mar 2005 16:03:05 -0300

Hi Marcel,


I will try explain my problem more deeply.

Bluetooth Extended Service Discovery Profile (ESDP) for Universal Plug
and Play(UPnP)
defines how devices with Bluetooth wireless communications can use the
Bluetooth
Service Discovery Protocol (SDP) initially to discover other devices
that support UPnP
services and retrieve information about these services.
For more details see http://www.bluetooth.org  document: ESDP_for_UPnP_V0.95.pdf

According with this profile three approach can be implemented:
1. L2CAP -based Solution: focus on layering UPnP services 
   over the L2CAP layer of the Bluetooth protocol stack for use by 
   devices that lack IP support.
2. IP-based Solution using PAN Profile: focus on layering UPnP
services over the Bluetooth Personal Area Networking (PAN) Profile.
3. IP-based Solution using LAN Access Profile : focus on layering UPnP
services over the Bluetooth Local Area Network (LAN) Access Profile.

I choose the SECOND because I have to address ad hoc and NAP scenarios. The 3th
option doesn't support multiple connections. The first option is not
feasible for me
because a UPnP service can be available in a server that belong to a
LAN. Therefore,
using  L2CAP -based Solution I will not be able to search UPnP service
in a device
that doesn't belongs directly to the PAN.


After select the SECOND approach two scenarios exist:
- Ad Hoc scenario
  The Control Point* device(role GN) will establish a PAN with PANUs
devices(listen enabled), assign IP to the nodes and after search for
UPnP services. The Control Point is the active member, it search for other
devices and must foward packet to all devices that belongs to the PAN.

- NAP scenario
  If a NAP(listen enabled) is available, the Control Point(role PANU)
will connect to
the NAP and search for UPnP service in the LAN

I implemented the search for PANU service and tested. Now, what is the
procedure to
submit a new patch. I am not sure if this small enhancement can be
usefull for the
bluez community.

Regards,
Claudio.

* A control point initiates discovery and communication with UPnP
devices, and receives events from UPnP devices.



On Mon, 28 Mar 2005 16:18:02 +0200, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Claudio,
> 
> > Suppose an UPnP application where a control point(role GN controller)
> > needs search for
> > services in several servers. The control point is the active member
> > and it will search for other devices. It must be the GN controller
> > because sometimes foward packet is required.
> >
> > The UPnP search takes few seconds therefore connect and search for UPnP service
> > on each server is unacceptable.
> >
> > Someone can suggest use a search for UPnP service at bluetooth SDP level,
> > searching only devices that provide UPnP service. It solve the problem
> > for ad hoc
> > networks, but can't solve in network access point scenario. This is the reason
> > for establish the PAN and after use the UPnP search.
> 
> I have no idea what you are talking about. You need to create a low
> level ACL link to do SDP searching, or create the BNEP connection or
> whatever. This is the time consuming (and blocking) action. So if you
> want to establish a PAN first and then do UPnP over TCP/IP that is fine.
> I don't see your problem.
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
