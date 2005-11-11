Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Michael Mauch <michael.mauch@gmx.de>
To: bluez-users@lists.sourceforge.net
Message-ID: <20051111190417.GA12636@elmicha.333200002251-0001.dialin.t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] OBEX push with ussp-push 0.5 (works, just for info)
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 11 Nov 2005 20:04:17 +0100

Hi,

just a short note that ussp-push 0.5
<http://www.xmailserver.org/ussp-push.html> works for me.

You have to find the channel for OBEX Object Push, e.g. with:

% sdptool search OPUSH

Then either use rfcomm bind, e.g.:

% rfcomm bind /dev/rcomm0 00:11:22:33:44:55 10
% ussp-push /dev/rfcomm0 localfile remotefile

Or use the Bluetooth device name of the remote device (I don't know how
to show that with bluez-utils):

% ussp-push "BTDeviceName"@10 localfile remotefile

There's already a Gentoo ebuild for ussp-push (I copied the examples
from there).

Regards...
		Michael


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
