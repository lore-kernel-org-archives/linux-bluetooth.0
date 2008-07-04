Return-Path: <cyrus@holtmann.org>
To: bluez-users@lists.sourceforge.net
From: Norbert Unterberg <nunterberg@gmail.com>
Date: Fri, 04 Jul 2008 22:55:23 +0200
Message-ID: <g4m2nu$j88$1@ger.gmane.org>
Mime-Version: 1.0
Subject: [Bluez-users] Override default inquiry mode?
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

I have got one of those tiny bluetooth USB adapters
(http://www.anycom.com/products/bluetooth_it_pc_accessoires/?id=102&group_id=3,
Broadcom chipset) and want to use it on my EEE PC. However, it does not work as
I hoped.

The adapter only works after setting the inquiry mode from RSSI/Extended to
standard mode using
hciconfig hcio reset
hciconfig hci0 inqmode 0

Is there any way to tell the bluetooth stack (i.e. in one of its config files)
to always use the standard mode for this adapter, or even for all adapters?

Norbert


-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
