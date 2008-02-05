Return-Path: <cyrus@holtmann.org>
Date: Tue, 5 Feb 2008 13:08:19 -0800 (PST)
From: "Russell A. Bell" <rbell@alumnus.caltech.edu>
Message-Id: <200802052108.m15L8JgM007877@alumnus.caltech.edu>
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] failed PIN Code Request
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

	When I try to connect to my headset (00:13:17:DD:D0:86) does
this hcidump:

	> HCI Event: PIN Code Request (0x16) plen 6
	    bdaddr 00:13:17:DD:D0:86
	> HCI Event: Connect Complete (0x03) plen 11
	    status 0x22 handle 0 bdaddr 00:13:17:DD:D0:86 type ACL encrypt 0x00
	    Error: LMP Response Timeout

reveal that the headset has asked my computer for a PIN Code and not
received one in time?

	20945 tty6     S      0:00 /usr/local/lib/bluetooth/add-passkey 00:13:17:DD:D0:86

is in the process list.  Does this mean that add-passkey isn't
working?

russell bell

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
