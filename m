Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] L2CAP dropping packets on BlueZ based receiver
From: Marcel Holtmann <marcel@holtmann.org>
To: Till Harbaum <harbaum@beecon.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200408021859.44496.harbaum@beecon.de>
References: <200408021859.44496.harbaum@beecon.de>
Content-Type: text/plain
Message-Id: <1091472875.4259.6.camel@pegasus>
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
Date: Mon, 02 Aug 2004 20:57:07 +0200

Hi Till,

> i have been using bluez l2cap for quite some time now. To my BlueMP3 receiver 
> i have streamed gigabytes via l2cap with no problems using bluez as a sender 
> so far.
> 
> A customer of mine now told me, that l2cap under bluez is unrealible. It was 
> hard to believe, but the follwing archive contains to little programs i wrote 
> to verify this. It's a sender and a (artifically slowed down) receiver:
> 
> http://www.harbaum.org/till/l2flow.tgz
> 
> The sender is marking the packets with some sequence number. After about 
> 80kBytes the receiver starts complaining about missing sequence numbers. 
> Since i can stream to my won hardware (and successfully slowing down the 
> transmission, since the receiving mp3 decoder is only taking the data at the 
> appropriate bandwidth) i am sure that sending data with bluez is not the 
> problem. However the receiver seems to fetch all packets from its bluetooth 
> hardware and is dropping packets if it then sees, that it has run out of 
> internal buffers.
> 
> Why is that? Can this be avoided? Is this by purpose?

the L2CAP of the Bluetooth 1.1 specification has no flow control and so
it can't be fully reliable. See the comment the l2cap.c source code:

        /* If socket recv buffers overflows we drop data here
         * which is *bad* because L2CAP has to be reliable.
         * But we don't have any other choice. L2CAP doesn't
         * provide flow control mechanism. */

Some Bluetooth stacks emulate L2CAP flow control with the flow control
of the HCI layer, but this is more bad than dropping a packet. Actually
this is the reason why most mobiles phones don't support more than one
ACL at the same time.

The solution for this is using RFCOMM or L2CAP with retransmission and
flow control from the Bluetooth 1.2 specification.

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
