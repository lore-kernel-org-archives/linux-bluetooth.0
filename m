Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <2de4657604123007015c2c9461@mail.gmail.com>
From: Manjunath Prabhu <manjunath.mp@gmail.com>
To: bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [Bluez-users] MTU in l2test
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
Date: Thu, 30 Dec 2004 20:31:15 +0530

Hi Marcel,
I am varying the mtu and data size variables in the l2test program.
>From the docs, I learnt that maximum L2CAP payload is 65535 bytes. I
am unable to set the data size above 45000 bytes inspite of setting my
MTU to 65535 (both on the sender and the receiver).
I get an error saying "Send failed. Resource temporarily unavailable".
 Hope you can help me with this one.

Also, in the l2test, is the data channel connectionless(6 byte L2CAP
header) or connection oriented(4 byte L2CAP header).I am asking this
because the code seems to have a 6-byte offset for the header which
means the data channel might be connectionless but i am also able to
see the "connection request" and "configuration request" which is a
feature of connection oriented data channels.

Also, how is that I am able to see the packet size of ACL Data in "HCI
dump", say a 339 byte packet for DH5 packets. Isn't this supposed to
happen at the Baseband?

thanks,
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
