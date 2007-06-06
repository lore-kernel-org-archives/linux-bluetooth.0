Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Wed, 6 Jun 2007 19:22:08 +0200
From: Elimar Riesebieter <riesebie@lxtec.de>
To: bluez-users <bluez-users@lists.sourceforge.net>
Message-ID: <20070606172207.GA9419@aragorn.home.lxtec.de>
MIME-Version: 1.0
Subject: [Bluez-users] 2.6.22-rc4: "Device is not available: No such device"
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


Hi all,

I've compiled 2.6.22-rc4 on my Apple pb.
Loaded modules: hci_usb,rfcomm,hidp,l2cap

# hcitool scan
Device is not available: No such device

# rfcomm connect 1 00:11:22:33:44:55 1
Can't connect RFCOMM socket: No route to host

2.6.21 loafed modules: hci_usb,rfcomm,hidp,l2cap
All went fine though.

Any hints?

Elimar

-- 
  Experience is something you don't get until 
  just after you need it!

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
