Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <2de46576050110025214118b21@mail.gmail.com>
From: Manjunath Prabhu <manjunath.mp@gmail.com>
To: bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [Bluez-users] l2test error
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
Date: Mon, 10 Jan 2005 16:22:47 +0530

Hi marcel,
i am running the l2test with some modifications to the code, the
connection reset  i am getting after 512 packets is because of this
new code,

You suggested that it could be an endian bug and asked me to check the
hardware.
so this is not the problem.....I have added a new function to measure
RSSI values along with the throughput l2test measures. The RSSI part
of the code is the same as used in 'hcitool'. The 'connection reset by
peer' is because on the receiver side i see another error in this RSSI
fuction, which resets the connection.

the error i get is ,
"HCI device open failed:Too many open files"...

This is because to get dd i use hci_open_dev (dev_id) fuction, and at
the end of the function i close(dd) or hci_close_dev(dd)....but i
still get the same error. After 512 packets i don't get the dev_id or
dd and hence the error.
Hope you can help me.

Thanx,
regards,
Manjunath


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
