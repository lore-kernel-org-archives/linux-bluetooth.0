Return-Path: <cyrus@holtmann.org>
Date: Mon, 11 Feb 2008 09:31:27 -0800 (PST)
From: "Russell A. Bell" <rbell@alumnus.caltech.edu>
Message-Id: <200802111731.m1BHVQ9I009663@alumnus.caltech.edu>
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users]  failed PIN Code Request
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


	Quoth Manuel Naranjo:
	'If I'm not wrong it's not your headset the one that closes the
connection, but rather the kernel.
	Solution:
	ADDR=<SOMETHING> hcitootl cc $ADDR; hcitool auth $ADDR
	Still not the preferred way but it works.'
	I interpret the contents of hcidump to indicate that the
kernel closes the connection.  I wonder why.  What you proposed
doesn't work for me.


russell bell

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
