Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] SCO. Some ideas.
From: Marcel Holtmann <marcel@holtmann.org>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4043449C.80509@superbug.demon.co.uk>
References: <40421024.20602@superbug.demon.co.uk>
	 <1078074126.1942.31.camel@pegasus> <40423226.8050007@superbug.demon.co.uk>
	 <1078087109.1942.54.camel@pegasus> <4042575B.20305@superbug.demon.co.uk>
	 <1078092105.1942.93.camel@pegasus> <404274D0.7040005@superbug.demon.co.uk>
	 <1078097902.1942.120.camel@pegasus>  <4043449C.80509@superbug.demon.co.uk>
Content-Type: text/plain
Message-Id: <1078154913.1942.142.camel@pegasus>
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
Date: Mon, 01 Mar 2004 16:28:33 +0100

Hi James,

> I have started to think of how we might better achieve our goal without 
> explicitly having trigger/pointer etc. api calls from the HCI to the SCO 
> layer.
> The current bluez stack handles HCI SCO receiving ok for now. HCI SCO 
> packets can be lost, but that is not so much of a problem.
> The current problem is the HCI SCO sending. i.e. CPU to Bluetooth air.
> There is no rate limiting in the HCI SCO sending.
> Options for rate limiting: -
> 1) For best sound quality, the rate limiting should be based on the HCI 
> hardware, and not any other source.
> 2) Only send hci sco when one receives an hci sco
> This causes problems if received hci sco packets get dropped due to 
> missed irqs etc. So it is better to not link the TX rate limiting to any 
> RX packet rate.
> 3) Use the linux system time.
> If the user changes the time, the linux system time get changed, so the 
> rate limiting will be messed up each time the linux system time is 
> changed. So, better not to use the linux system time.
> 
> So, we really want to use (1) if we can.
> How about?: -
> 
> 1) Each hci sco packet being send from the sco layer to the hci layer is 
> tagged with a sequence number.
> We send the hci sco packet from sco layer to hci layer.
> When the tx_complete for that hci sco packet happens, the packet is 
> returned to the sco layer being taged as complete and then the sco layer 
> refills it with new data and sends it down again. As we tagged the hci 
> sco packet with a sequence number, when it comes back we know which 
> packet was actually send. As it has a sequence number on it, we can 
> detect lost packets.
> Because the completed packet is send back up to the sco layer, we are 
> able to remove one malloc/free from the process.
> Currently we have sco layer doing alloc, hci layer doing free.
> 
> 2) Just use a limited sized queue.
> sco layer fills the queue, but when the queue is full, it waits.
> the hci layer empties the queue as and when it needs to.
> Currently, I think we have a queue, but the size of the queue is not 
> controllable from the sco layer.
> It might be better if the hci layer reads the first item in the queue, 
> schedules it for output. the hci layer only frees the item from the 
> queue when it reaches tx_complete.
> The tx_complete state is reached when the bluetooth hardware calls the 
> interrupt handler.
> 
> I think option (2) fits more closely with the current bluez design. All 
> I need is the answer to "How does one limit the queue size?".

maybe you should look at hci_send_sco() and you can control everything
by yourself that you wanna send down to the HCI layer and thus to the
driver. Every connection has its own data queue (data_q).

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
