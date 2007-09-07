Return-Path: <bluez-users-bounces@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Dick <dick@mrns.nl>
Date: Fri, 7 Sep 2007 14:33:34 +0000 (UTC)
Message-ID: <loom.20070907T162203-609@post.gmane.org>
Mime-Version: 1.0
Subject: [Bluez-users] input service leaking l2cap connections
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

I still have some trouble with the input service and I think I've found
something related which is reproduceable.

If a device is reconnecting a lot the l2cap table in /sys/class/bluetooth/l2cap
is growing with connections (which aren't closed).

Try the following with a HID input device:

1. Start and configure the input service for the device
2. Start hcidump
3. Power off the input device
4. Wait until "Disconn complete" appear in hcidump
5. Power on the input device
6. Repeat from step 3

If you look at:
sort /sys/class/bluetooth/l2cap |uniq -c

You will see a huge number of connections from the input device.

greetings,
Dick


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
