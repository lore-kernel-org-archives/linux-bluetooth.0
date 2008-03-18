Return-Path: <cyrus@holtmann.org>
From: TJ <bluez@tjworld.net>
To: Bluez-devel@lists.sourceforge.net
Date: Tue, 18 Mar 2008 21:48:41 +0000
Message-Id: <1205876921.25481.34.camel@hephaestion>
Mime-Version: 1.0
Subject: [Bluez-devel] No services discovered by remote devices
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

Problem: Remote devices do not discover services being offered by the
Linux PC.

Apologies if I'm missing something very obvious, but having tried to
solve this for many hours, analysing the logs and searching for a
solution, I only find other people with the same issue and no
explanation.

There's not even any documentation on what to expect which complicates
the issue.

Using Ubuntu Gutsy x86_64 on a Sony Vaio VGN-FE41Z laptop. The standard
bluez-utils version is v3.19. I've also built and tested v3.26 with no
improvement.

All client operations appear to work correctly: Mouse, CUPS printing,
OBEX Object Push.

Remote devices correctly discover the PC device (Class Laptop). Pairing
devices with the laptop works with a PIN being asked for and accepted.

For anything involving a remote device discovering services on the PC
though, results are patchy and not as expected.

bluetoothd-service-serial/audio/network/input are all enabled and
running. gnome-bluetooth properties shows the services enabled.

A Sony Ericsson K800i reports discovering:
Audio remote controller
Audio remote control target

>>From a Toshiba e800 Windows Mobile 2003 Second Edition PDA:
No services discovered.

The PDA discovers all the K800i and HP Deskjet 995c services, and the
K800i discovers the services of the PDA and the printer correctly, so
I'm sure the remote devices are working okay.

This lack of services was initially noticed when I couldn't find out how
to get the laptop to offer the PAN service on pan0 despite checking the
Wiki and creating /etc/bluetooth/network.conf and also trying manually
adding pan0 to /etc/network/interfaces.

Looking at the source for bluetoothd-service-network I noticed in
network/main.c there is what appears to be a command-line switch "-s"
that causes:

if (argc > 1 && !strcmp(argv[1], "-s"))
 register_external_service(conn, "network", "Network service", "");

but from what I can tell, argv[1] is set to NULL by the
hcid/dbus-service.c::service_start() code that starts the service. As
the code isn't commented it's hard to tell if that function is supposed
to register a bluetooth service or just something for dbus.

I did try calling register_external_service() unconditionally but it
didn't appear to make any difference.

So, the question is, should bluetoothd-service-* cause discoverable
services to be visible to remote devices, and if so, what steps can I
take to interrogate/debug this issue?

Thanks.


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
