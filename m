Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <9a119b3c0711220304w352b42ads21eb25f021c2ed80@mail.gmail.com>
Date: Thu, 22 Nov 2007 12:04:09 +0100
From: "=?ISO-8859-1?Q?Csillag_Krist=F3f?=" <csillag.kristof@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] integrating BlueZ into remote session
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

Hi there!

I am maintaining a system with thin-client terminals,
which are running X locally, and remote gnome sessions
on the server. (This works pretty good.)

I would like to configure BlueZ on the clients, so
that they can use local Bluetooth devices.

I can install the necessary software on the client
computers, but since the desktop application run
on the server (and thus they are connected to the D-Bus
of the server computer), and the BlueZ core is
connected to ths D-Bus System Bus on the client,
the messages won't go through

(Ie. for the PIN requests arriving to the client,
the passkey agen on the server can not be invoked
automatically, etc.)

What is the best way to solve this?

Should I try to configure a bridge between the two D-Buses?
(Does D-bus support this already?)

Or should I try to run the relevant GUI applications locally on
the client, and integrate them into the desktop running remotely
on the server? (Does the gnome panel accept applets running on
different hosts than the desktop?)

I have already in place the needed infrastructure for transferring
the actual content of Bluetooth services (obex, audio, etc.)
between the client and the server; the only part still missing is
the d-bus level.

Can I make this work somehow?

Thank you for your help:

     Kristof Csillag

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
