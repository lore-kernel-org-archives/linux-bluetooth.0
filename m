Return-Path: <cyrus@holtmann.org>
Date: Tue, 22 Jan 2008 15:43:04 +0100
From: Miguel <mc354@tid.es>
In-reply-to: <4795F9EC.20509@aircable.net>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-id: <1201012984.21244.9.camel@McM>
MIME-version: 1.0
References: <QiqzmGYI.1201010734.9272710.fma@alezan.org>
	<4795F9EC.20509@aircable.net>
Subject: Re: [Bluez-users] Newbie needs help to start
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

Hi,
what frederic want to do it's something like:

rfcomm connect 0 00:1E:3A:1E:9F:F6 

in this moment the link keys are exchanged.
if it's the first time a pin code will be required in the other side.
After exchanging PIN code, the link key is stored
in /var/lib/bluetooth/<mac>

this is called the pairing phase.

After that you will see a new device in the /dev/rfcomm0

You can send command to this serial port using minicom program.

but How do you do the same using dbus serial??


I 'm using ubuntu feisty with this packages:

ii  bluez-btsco                                0.50-0ubuntu2
Bluez Bluetooth SCO tool
ii  bluez-cups                                 3.9-0ubuntu4
Bluetooth printer driver for CUPS
ii  bluez-gnome                                0.6-1ubuntu3
Bluetooth utilities for GNOME
ii  bluez-hcidump                              1.33-0ubuntu1
Analyses Bluetooth HCI packets
ii  bluez-pin                                  0.30-2.1ubuntu3
Bluetooth PIN helper with D-BUS support
ii  bluez-utils                                3.9-0ubuntu4 

but no all of them are necessary.



On Tue, 2008-01-22 at 12:13 -0200, Manuel Naranjo wrote:
> bus api, not into the old hci lib api ;)


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
