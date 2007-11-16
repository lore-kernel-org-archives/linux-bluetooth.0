Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <5c1c70820711152155s3557856aja583f4c02a6f1d71@mail.gmail.com>
Date: Fri, 16 Nov 2007 16:25:48 +1030
From: "Pooyan McSporran" <duckfreezone@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] Serial server problems
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

(I'm unclear on which list, either bluez-devel or bluez-users, this
query should be on.  Let me know if I've sent to the wrong list.
Also, I'm having some erratic email issues, so my apologies if this
appears twice.)

I'm trying to write an application using BlueZ which will:
- advertise a service, based on SPP (custom UUID, etc)
- listen for incoming connections for that service
- when an inbound connection is requested, create the connection
- send data to/from on the connection

I'm having problems trying to work out how to do this using the DBus
interface.  I've browsed through the Wiki (http://wiki.bluez.org) but
all the examples that I've found seem to be from the client
perspective, not a server.  (Correct me if I'm wrong.)  The only
server example I found is for the network service, not the serial
service.  Similarly, the 'test-serial' python script only implements a
client.

The approximate sequence of actions that I'm currently
(unsuccessfully!) using is:
- Determine the default adapter (DefaultAdapter())
- add the service (AddServiceRecordFromXML())
- activate the serial service (ActivateService ("serial"))

The service is then visible to remote devices (so far so good!)

- create a proxy (serial.Manager.CreateProxy (uuid, "/dev/rfcomm0"))
- Enable the proxy (proxy.Enable ())

This is where I'm obviously missing some basic stuff, I'm not sure in
this area (with ports, proxies, etc).  In this scenario I end up with
'invalid address' on the CreateProxy() call.  Looking at the API,
CreateProxy expects either a socket or a character device, but I'm
unsure what I should use here in my scenario.  Should I be using
rfcomm0 in this manner, or some other approach?  Any help would be
appreciated.

Thanks.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
