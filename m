Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <62123.80.109.89.243.1177094931.squirrel@webmail.uni-ak.ac.at>
Date: Fri, 20 Apr 2007 20:48:51 +0200 (CEST)
From: gerhard.ramsebner@uni-ak.ac.at
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] piconet routing
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

How do I set up routing for my piconet master?

I set up a dhcp daemon.
As a new network interface foreach( slaves ) is created I set up host routes.
Communication from master to slave and the other way round is working so far.

To make a slave reachable from another slave the master has to be a
router, right?

echo 1 > /proc/sys/net/ipv4/ip_forward
echo 1 > /proc/sys/net/ipv4/conf/all/forwarding

But I still can't get through.
What else do I have to watch out for?


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
