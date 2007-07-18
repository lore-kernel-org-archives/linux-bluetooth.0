Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <469E6A4A.4000804@krevsbech.dk>
Date: Wed, 18 Jul 2007 21:30:18 +0200
From: Kasper Revsbech <mail@krevsbech.dk>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] BNEP transferrate limitation?
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

Hey we are using BNEP as a part of our student project but we have 
reached a limitation on the transfer speed of approx 8 KB/s. We have 
tried to switch the hardware dongles but it is still the same. We have 
another scheme where we use the L2CAP layer directly trough a socket 
with the the BNEP profile. This gives the same limit. If we use the same 
hardware dongles with a OBEX transfer we can reach much higher limitations.
Therefore we would like to know if it is a known limitation on the BNEP 
profile or if there is known limitations with some of the drivers.

Kind regards:
Kasper Revsbech


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
