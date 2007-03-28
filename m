Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <20070328152757.62286.qmail@web52302.mail.re2.yahoo.com>
Date: Wed, 28 Mar 2007 08:27:57 -0700 (PDT)
From: Aarti Kumar <akmr2000@yahoo.com>
To: Bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] L2CAP: ECONNRESET is set for every l2cap disconnect.
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

I am sure if this issue has been discussed before or
not. 

Is it necessary to the set the struct sock->err value
to ECONNRESET when l2cap disconnect request is
received from remote device ?

l2cap_disconnect_req function sets the error value in
sock structure by calling l2cap_chan_del(sk,
ECONNRESET) every time l2cap connection is
disconnected.

This might lead to some loss of data at receiver side
in case of fast sender and slow receiver. 

The sender will send l2cap packets and disconnects. 

The receiver side will read the packets, but once
l2cap disconnect is received, even though there is
data in sk_buff, the bt_sock_recvmsg will return 0 as
skb_recv_datagram will return NULL. 

Can we set the value to ECONNRESET only in case of
error condition and for the normal disconnect set it
to 0 by calling l2cap_chan_del(sk,0) from
l2cap_disconnect_req ?

So if error field is not set in sock structure,
bt_sock_recvmsg will return data bytes till sk_buff is
empty and which case 0 will be returned. This will
prevent any data loss.

Also if the user wants to know when socket
disconnected, POLLHUP will be set for sock fd so after
disconnect happens and there is data to be read both
POLLHUP and POLLIN will set.
If we set sock err field then user will not be able to
retrieve data from sk_buff, even if POLLLIN is set.

I am using 2.6 kernel.

Thanks,
Aarti.






 
____________________________________________________________________________________
Finding fabulous fares is fun.  
Let Yahoo! FareChase search your favorite travel sites to find flight and hotel bargains.
http://farechase.yahoo.com/promo-generic-14795097

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
