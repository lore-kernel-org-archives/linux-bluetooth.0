Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Content-Type: text/plain
Message-Id: <1111660850.1916.49.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] Feature mask retrieval for L2CAP RFC
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 24 Mar 2005 11:40:50 +0100

Hi,

to fully support the L2CAP 1.2 retransmission and flow control (RFC) you
need to send an info request first to request the extended feature mask.
The part of the the specification when to request this information is
quite lame. It actually says only you have to do so before configuring
for any RFC settings (volume 3, part A, chapter 8.1).

The extended feature mask is a global value and thus it should be enough
to request it once for the underlaying ACL link. This means that we may
should request this value before creating any L2CAP channel. The problem
is that older BlueZ L2CAP implementations send wrong responses for an
info request. This may result into problems with L2CAP 1.1 (SEQPACKET)
only connections and so I don't wanna do that until we really need to
configure RFC.

My idea is to send the request for the extended feature mask only once
before we try to open the first L2CAP 1.2 channel. This means before we
send the connection request for that channel. The mask should be stored
in the l2cap_conn structure and then used for further channel requests.
Using such a scheme means that no info requests will be sent if only
L2CAP 1.1 channels are used and using a L2CAP 1.2 channel will result in
only one info request/response transaction from our side. This looks to
me like the most sane approach.

Comments?

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by Microsoft Mobile & Embedded DevCon 2005
Attend MEDC 2005 May 9-12 in Vegas. Learn more about the latest Windows
Embedded(r) & Windows Mobile(tm) platforms, applications & content.  Register
by 3/29 & save $300 http://ads.osdn.com/?ad_id=6883&alloc_id=15149&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
