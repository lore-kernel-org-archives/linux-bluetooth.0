Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4521B775.6040001@gmail.com>
References: <4521B775.6040001@gmail.com>
Date: Wed, 04 Oct 2006 10:33:46 +0200
Message-Id: <1159950826.1601.11.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] SCO packet processing
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

Hi Jose,

> I've been studying the SCO packet processing to understand how it works.
> There are a few things that I noticed that don't seem quite right. I'll 
> attempt
> to explain.
> 
> In the SCO transmit path, data gets put in a skb and then queued. There's
> a tasklet that will dequeue and send the skb to the hci driver. This tasklet
> is scheduled when data needs to be sent or when there's a HCI event
> HCI_EV_NUM_COMP_PKTS. This works fine for an ACL link and it could work
> for a non-USB SCO transport. However, for USB HCI, the SCO data is carried
> by the isochronous transport that doesn't require explicit flow control. The
> problem is that the current code (hci_sched_sco in hci_core.c) will send all
> packets to the hci layer with no flow control. That explains why application
> kludges have been introduced to avoid loosing packets.
> 
> Note that for non-USB links (i.e. UART), the current code is not correct
> either as it doesn't enable HCI_EV_NUM_COMP_PKTS anywhere. Also,
> the value of hdev->sco_cnt is never decremented.
> 
> Last May, Fabien Chevalier posted some patches to avoid this problem.
> His approach of using timers didn't work for me but I think this is the 
> wrong
> way to go about it. What is needed is a proper flow control mechanism 
> between
> the bluetooth module and the hci layer for the case of USB HCI transport.
> I'm thinking that a callback is necessary that is invoked by hci_usb to
> kickstart the process.
> 
> I also have issues with hci_sched_sco. I think it should interleave skb from
> different active SCO sockets. Currently, it sends too many skbs from the
> same socket flooding the dongle's buffers and potentially starving other
> SCO channels.
> 
> I realize SCO handling has not been a priority and it sort of works.
> Is there much interest in getting it right?

I am not actively gonna work on it, but I am going to review and test
your patches to make it better.

First of all, the HCI drivers are stupid and that is meant to be,
because they are only transport drivers. This means if the scheduling of
SCO packets in the core is wrong, then we should fix it there. However
no driver should overflood the Bluetooth core with too many packets
anyway, but the core should be able to handle it and maybe simple drop
some packets.

For the actual improvement, I don't seen any need of another callback in
the core or the drivers. If SCO packets need a different sending path,
then we are have too implement one. So please go ahead and propose
something.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
