Return-Path: <cyrus@holtmann.org>
Message-ID: <5eee8c670802281451i392c0debq7a16286d76d33bfb@mail.gmail.com>
Date: Thu, 28 Feb 2008 22:51:17 +0000
From: "Odysseus Flappington" <deriziotis@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] hciconfig hci0 reset bug
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

So, it turns out that in order for any external usb bluetooth adapters
to re-connect to paired input devices on reboot, you need to issue an
'hciconfig hci0 reset' command after rebooting in order to reconnect.

More info can be found in bug #133690 on Launchpad
(https://bugs.launchpad.net/ubuntu/+source/bluez-utils/+bug/133690).

This bug isn't Ubuntu-specific since I have reproduced in Fedora 8, so
I'm posting here.

Simply adding 'hciconfig hci0 reset' in /etc/default/bluetooth in
source would solve this bug. Is this a reasonable solution?

What is required in order to get a fix implemented?

Thanks,
Alex (Jackflap/OdyTheDog)

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
