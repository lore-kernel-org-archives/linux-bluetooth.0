Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <4688E10E.3080907@csr.com>
Date: Mon, 02 Jul 2007 12:27:10 +0100
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <c49421c50706291727w109e0ecbx28635ddbb630421e@mail.gmail.com>
In-Reply-To: <c49421c50706291727w109e0ecbx28635ddbb630421e@mail.gmail.com>
Subject: Re: [Bluez-users] how to get maximum throughput with Bluetooth 2.0?
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

Loreno Oliveira wrote:
> USB-250). For my tests I wrote a program that opens a l2cap socket with a
> second host and continuously writes a message of 1200 bytes.

1200 is a bad number.

1200 byte L2CAP payloads become 1204 bytes over the air. Multiple L2CAP
PDUs can not be aggregated into an air packet. 3-DH5 packets can hold
only 1021 bytes.

This means that, even in ideal circumstances, your payload will split into
one 1021 byte 3-DH5 packet and one 183 byte 2-DH3 packet. This will
take 10 slots to send (5+1+3+1).

So, the absolute best you could hope for is to send 1200 bytes in
6.25 ms. That's 1.5 Mbps.

>                                                              Befores opening
> the socket connection I change the connection packet type to 3-DH5 with
> hcitool utility.

This is generally a bad idea and is extremely bad in this case.

Now, even under ideal circumstances, the 183 byte trailer has to go into
a 3-DH5. You're now looking at 12 slots or 7.5 ms per L2CAP PDU. This
reduces your theoretical maximum data rate to 1.3 Mbps.

Make the following changes to your test.

  * Increase your L2CAP PDU size to 2033 bytes (that's 2037 over the
    air).

  * Don't restrict the choice of packet types.

This should be optimal for real world throughput as 2037 not only splits
nicely into 1021 byte 3-DH5 packets but also splits nicely into 679 byte
2-DH5 packets. This means that when your link starts to degrade - as it
will do in the real world - your bandwidth will fall to 1.4 Mbps. If you
used, say, 1017 byte packets to get optimal 3-DH5 performance your 2-DH5
bandwidth would be worse.

Restricting to 3-DH5 in the real world is bad. 2-DH5 packets are much
more robust than 3-DH5 packets so when the link starts to degrade,
2-DH5 packets will give much higher bandwidth than 3-DH5. Note also that
you can't prevent the baseband from using DM1 packets so restricting you
may get worse results than you expect if the baseband decides that 3-DH5
packets aren't getting through and it needs to fall back. It'll have to
go all the way to DM1 packets which would be bad.

	- Steven
-- 


To access the latest news from CSR copy this link into a web browser:  http://www.csr.com/email_sig.php

To get further information regarding CSR, please visit our Investor Relations page at http://ir.csr.com/csr/about/overview

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
