Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <20070419150753.z9s8rdwzc0koogwc@tern.doc.ic.ac.uk>
Date: Thu, 19 Apr 2007 15:07:53 +0100
From: ps104@doc.ic.ac.uk
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] PSMs
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

I am writing a program using bluez l2cap connections however if I set  
the PSM to anything
apart from 0x1001 (ie. loc_addr.l2_psm = htobs(0x1001)) I constantly  
receive blank
messages of length 0 across the connection. Any ideas?

Thanks,
Phil


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
