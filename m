Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <5307d89f0706301124p2326b5d9k34a95779fccc0248@mail.gmail.com>
Date: Sat, 30 Jun 2007 20:24:00 +0200
From: "Patrick Libert" <patrick.libert@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] Info Dinovo
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

Hello,

I'm using Dinovo keyboard and mouse for a long time now with ubuntu.
With ubuntu Dapper it worked perfect.
All I did is modify /etc/init.d/bluetooth:
I changed HIDD_ENABLED=1
and I added HIDD_OPTIONS="-i xx:xx:xx:xx:xx:xx --connect
XX:XX:XX:XX:XX:XX  --master --server  "
Then I did "sudo hidd --search" and pressed the pairing button on the
keyboard and it works perfectly, even when I reboot.

Now, with the latest editions from ubuntu this doesn' work anymore.
When I reboot my computer, or wait to long, my keyboard is lost.
A lot of people are complaining about this on ubuntuforums.org.
Could you tell me what I should change?

Now I have the Laser version and still the same problem.

The LCD works fine with the new patch.

I appreciate your help

Kind regards,

Patrick

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
