Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <436F49BB.4060200@csr.com>
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Protocols over Bluetooth Baseband and disabiling
 Retransmissions
References: <436BBCE5.60505@masaka.cs.ohiou.edu>
In-Reply-To: <436BBCE5.60505@masaka.cs.ohiou.edu>
Content-Type: text/plain; charset=us-ascii
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
Date: Mon, 07 Nov 2005 12:34:03 +0000

Jim Wyllie wrote:
> [include/]net/bluetooth/l2cap.[hc] and the Bluetooth spec, and I could 
> easily set the default flush_to to 0x0001 (.625 milliseconds should be 
> effectively 0, and with no packet to retransmit, it should timeout the 
> retransmission).  Am I on the right track, and would just changing all 
> flush_to assignments to 0x0001 (including the default) work like I think 
> it would?  If I'm not on the right track, could someone point me to a 
> good way to achieve this?

With BT 1.2 devices this probably won't do what you want. In 1.2, the
flush timeout starts at the point at which the packet is received over
the host transport. A 625 us timeout will probably expire before the
packet makes it as far as the radio.

A 1.1 device might do the right thing as the timeout starts at the
point at which the packet is first sent on the radio.

Note, however, that the flush timeout applies to all the packets on a
given ACL handle, not just to a single L2CAP CID. This means that the
L2CAP signalling is affected by the flush timeout. This is usually
highly undersirable.

You may have to switch to the HCI interface to get the level of
control you want which means JSR-82 probably won't be sufficient.

	- Steven
-- 


This message has been scanned for viruses by BlackSpider MailControl - www.blackspider.com


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
