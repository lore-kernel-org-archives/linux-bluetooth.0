Return-Path: <James@superbug.demon.co.uk>
Message-ID: <4043449C.80509@superbug.demon.co.uk>
Date: Mon, 01 Mar 2004 14:11:40 +0000
From: James Courtier-Dutton <James@superbug.demon.co.uk>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] SCO. Some ideas.
References: <40421024.20602@superbug.demon.co.uk>	 <1078074126.1942.31.camel@pegasus> <40423226.8050007@superbug.demon.co.uk>	 <1078087109.1942.54.camel@pegasus> <4042575B.20305@superbug.demon.co.uk>	 <1078092105.1942.93.camel@pegasus>  <404274D0.7040005@superbug.demon.co.uk> <1078097902.1942.120.camel@pegasus>
In-Reply-To: <1078097902.1942.120.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel Holtmann wrote:
> Hi James,
> 
> 
>>So you want me to implement it in such a way that would add 10-20ms of 
>>latency and have no audio/video syncronisation features?
> 
> 
> yes, do it.
> 
> 
>>We might as well stay with the current alsa over network sockets which 
>>is what we have now.
> 
> 
> We will see what the latency really is if we go directly from the ALSA
> driver to the HCI SCO interface.
> 
> Regards
> 
> Marcel
> 
> 
I have started to think of how we might better achieve our goal without 
explicitly having trigger/pointer etc. api calls from the HCI to the SCO 
layer.
The current bluez stack handles HCI SCO receiving ok for now. HCI SCO 
packets can be lost, but that is not so much of a problem.
The current problem is the HCI SCO sending. i.e. CPU to Bluetooth air.
There is no rate limiting in the HCI SCO sending.
Options for rate limiting: -
1) For best sound quality, the rate limiting should be based on the HCI 
hardware, and not any other source.
2) Only send hci sco when one receives an hci sco
This causes problems if received hci sco packets get dropped due to 
missed irqs etc. So it is better to not link the TX rate limiting to any 
RX packet rate.
3) Use the linux system time.
If the user changes the time, the linux system time get changed, so the 
rate limiting will be messed up each time the linux system time is 
changed. So, better not to use the linux system time.

So, we really want to use (1) if we can.
How about?: -

1) Each hci sco packet being send from the sco layer to the hci layer is 
tagged with a sequence number.
We send the hci sco packet from sco layer to hci layer.
When the tx_complete for that hci sco packet happens, the packet is 
returned to the sco layer being taged as complete and then the sco layer 
refills it with new data and sends it down again. As we tagged the hci 
sco packet with a sequence number, when it comes back we know which 
packet was actually send. As it has a sequence number on it, we can 
detect lost packets.
Because the completed packet is send back up to the sco layer, we are 
able to remove one malloc/free from the process.
Currently we have sco layer doing alloc, hci layer doing free.

2) Just use a limited sized queue.
sco layer fills the queue, but when the queue is full, it waits.
the hci layer empties the queue as and when it needs to.
Currently, I think we have a queue, but the size of the queue is not 
controllable from the sco layer.
It might be better if the hci layer reads the first item in the queue, 
schedules it for output. the hci layer only frees the item from the 
queue when it reaches tx_complete.
The tx_complete state is reached when the bluetooth hardware calls the 
interrupt handler.

I think option (2) fits more closely with the current bluez design. All 
I need is the answer to "How does one limit the queue size?".

Any comments?

Cheers
James
