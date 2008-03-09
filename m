Return-Path: <cyrus@holtmann.org>
Message-ID: <47D40D4A.6070501@boerkel.de>
Date: Sun, 09 Mar 2008 17:16:10 +0100
From: =?ISO-8859-1?Q?Thomas_B=F6rkel?= <thomas@boerkel.de>
MIME-Version: 1.0
To: Bluez-users@lists.sourceforge.net
Subject: [Bluez-users] HowTo DUN without dund?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

HI!

I was using dund for connecting my Palm via a Bluetooth dongle to the 
Internet.

This was working in Bluez 2.x and 3.23.

Now, with newer versions of 3.x, dund seems to be gone and I can't find 
information on how to enable and configure DUN without dund.

I was configuring the options for DUN in /etc/ppp/options.rfcomm0 like this:
# You usually need this if there is no PAP authentication
noauth
# do not use modem control lines we aren't using a real serial line
local
# do not determinate local ip from hostname
noipdefault
# usefull ARP proxing
proxyarp
# Your own IP Address and the IP Address of the remote system
192.168.0.2:192.168.0.47
# And the netmask
netmask 255.255.255.0
# dns
ms-dns 192.168.0.1
# this is required for the non standard microsoft PPP negotiation
connect "sleep 2; echo -n CLIENTSERVER"

And then I ran dund --listen.

Where can I put this stuff now? I found /etc/bluetooth/rfcomm.conf, but 
it does not seem to understand the keyword if the old config file.

Thanks!

Thomas

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
