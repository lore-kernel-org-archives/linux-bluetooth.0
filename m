Return-Path: <cyrus@holtmann.org>
Message-ID: <8c7950360809160950m35e259e0r76d1dac49be67d1b@mail.gmail.com>
Date: Tue, 16 Sep 2008 12:50:54 -0400
From: "Shane Volpe" <shanevolpe@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-users] Help with setting up NAP
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

I'm trying to understand the best way to set up a device as a NAP.
The old way I performed this was by using pand with the following
options:
PAND_OPTIONS=" --secure --listen --master --role  NAP
--devup=/etc/bluetooth/pan/dev-up"

Moving forward I want to use dbus commands and configure the NAP the
*right* way.

Here is my current understanding from the wiki you can completely set
up everything via dbus or you can configure the basic settings using
.service files (/etc/bluetooth) and the network.conf file.

Here is what I think I should do:
1.) Set up a service file:
[Bluetooth Service]
Identifier=network
Name=Network service
Description=Bluetooth Personal Area Network service
Autostart=true

2.) It looks like the network.conf default setting are good for what I
want to do.

3.) Issue dbus commands to start NAP.  This is were I'm confused and
NEED HELP, I'm not sure what all needs to be done here to allow a PANU
device to connect to my NAP device.
Once I have the connection (bnepX) I know what to do, just set up a
bridge (pan0) and set up any forwarding/NAT/firewall rules using
standard iptables/masq commands against the pan0.

I believe the example on the wiki
(http://wiki.bluez.org/wiki/HOWTO/NetworkConnections) details how to
have a PANU device connect to a pre-existing NAP but I do not believe
it details how to set up the NAP which is really what I want to
accomplish.
Regards,
Shane

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
