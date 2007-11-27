Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <e1effdeb0711270618w5e1b6fck4ce0484ea124a155@mail.gmail.com>
Date: Tue, 27 Nov 2007 11:18:39 -0300
From: "Claudio Takahasi" <cktakahasi@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <5c1c70820711141825g6c9e27ecm51c00272bad6d7fd@mail.gmail.com>
MIME-Version: 1.0
References: <5c1c70820711141825g6c9e27ecm51c00272bad6d7fd@mail.gmail.com>
Subject: Re: [Bluez-devel] Serial server problems
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

On Nov 14, 2007 11:25 PM, Pooyan McSporran <duckfreezone@gmail.com> wrote:
> (I'm unclear on which list, either bluez-devel or bluez-users, this
> query should be on.  Let me know if I've sent to the wrong list.)
>
> I'm trying to write an application using BlueZ which will:
> - advertise a service, based on SPP (custom UUID, etc)
> - listen for incoming connections for that service
> - when an inbound connection is requested, create the connection
> - send data to/from on the connection
>
> I'm having problems trying to work out how to do this using the DBus
> interface.  I've browsed through the Wiki (http://wiki.bluez.org) but
> all the examples that I've found seem to be from the client
> perspective, not a server.  (Correct me if I'm wrong.)  The only
> server example I found is for the network service, not the serial
> service.  Similarly, the 'test-serial' python script only implements a
> client.
>
> The approximate sequence of actions that I'm currently
> (unsuccessfully!) using is:
> - Determine the default adapter (DefaultAdapter())
> - add the service (AddServiceRecordFromXML())
> - activate the serial service (ActivateService ("serial"))
>
> The service is then visible to remote devices (so far so good!)
>
> - create a proxy (serial.Manager.CreateProxy (uuid, "/dev/rfcomm0"))
>
> This is where I'm obviously missing some basic stuff, I'm not sure in
> this area (with ports, proxies, etc).  Any help that people might have
> in this regard would be appreciated.
>
> Thank you.

Hi Pooyan,

The address is wrong. Here are some examples:
TTY proxy: "/dev/ttyS0"
Unix socket: "/tmp/gps-data"
Unix socket(abstract namespace): "x00/org/bluez/echo"

I will try update the BlueZ wiki with some unix socket proxy examples.

BR,
Claudio.
-- 
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
