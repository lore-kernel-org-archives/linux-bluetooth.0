Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Thor Egil Skaug" <paxtonrd@hotmail.com>
To: <bluez-users@lists.sourceforge.net>
Message-ID: <000101c402dd$9f3316d0$9349edc7@thores>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: [Bluez-users] Broadcast and reassembly
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 5 Mar 2004 10:13:55 -0800

I am experiencing some problems when reassembling active broadcast
messages when the
(hci) num_broadcast_retransmissions is set > 0 (at the sender), and with
a decent L2CAP message size,
> 100 bytes.

I constantly get start_fragments and continuing_fragments that are out
of order, and since
the l2cap header is the only way I can know when I am done reading one
message and can expect
another, this is troublesome. I thought the device was supposed to
deliver messages in order?

Has anyone ever implemented this, and hopefully had the same
experiences?

Thanks,

Thor


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
