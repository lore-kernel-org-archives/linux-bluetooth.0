Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] L2CAP dropping packets on BlueZ based receiver
From: Marcel Holtmann <marcel@holtmann.org>
To: Till Harbaum <harbaum@beecon.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200408031223.11789.harbaum@beecon.de>
References: <200408021859.44496.harbaum@beecon.de>
	 <1091472875.4259.6.camel@pegasus>  <200408031223.11789.harbaum@beecon.de>
Content-Type: text/plain
Message-Id: <1091532252.4259.38.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 03 Aug 2004 13:24:12 +0200

Hi Till,

> > The solution for this is using RFCOMM or L2CAP with retransmission and
> > flow control from the Bluetooth 1.2 specification.
> It's been some time since i wrote my rfcomm layer, but i didn't remember 
> rfcomm having a sequence number or the like and IMHO it does not have a 
> mechanism for retransmission. Or have i really missed something that 
> important?
> 
> IMHO you can use rfcomm to make the whole transmission reliable, but this 
> means, that you have to use acl flow control and make sure, that l2cap/acl 
> won't block via rfcomms credit based flow control. Are there other options?

you are still right that RFCOMM uses no sequence numbers and this is
only because it depends on a reliable L2CAP. This said makes my previous
statement looking like non-sense, but actually the RFCOMM credit based
flow control is enough to not screw up the receiver. This is what I've
seen in practice, but I don't have a full proof for it. We know that our
packets will arrive in correct order. The ACL link will take care of
this. We only have to take care of that we don't get more packets than
our receive buffers can take. So the RFCOMM flow control should be
enought to assure this. In general this is a big design mistake in the
Bluetooth protocol stack itself and only L2CAP with retransmission and
flow control can fix it.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
