Return-Path: <vogl@soft.uni-linz.ac.at>
Message-ID: <404370F0.7040802@soft.uni-linz.ac.at>
Date: Mon, 01 Mar 2004 18:20:48 +0100
From: Simon Vogl <vogl@soft.uni-linz.ac.at>
MIME-Version: 1.0
To: "Williams, Richard" <Richard.Williams@VITRONICS.com>
CC: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-devel] SCO. Some ideas.
References: <A1F0D47583A2D711919F00600819B3A4028B8C@goofy.vitronics.com>
In-Reply-To: <A1F0D47583A2D711919F00600819B3A4028B8C@goofy.vitronics.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

BTW,
I am have written two small programs that try to conform to the 
headset/handsfree profile.
They are not finished yet, but I'd like to donate the source code :) 
They are small, command-line
and use only alsa (with suboptimal quality at the moment). If anyone 
wants to have a look
at the code, drop me a note.
Marcel, would you like to integrate them into the repository, or should 
I start a separate project?
Simon

Williams, Richard wrote:

>Hi Guys,
>
>Your discussion is very relevant to me, since I'm building a small
>wearable computer system that will have several Bluetooth devices - 
>among them will be a headset. I was planning to use standard rfcomm
>to send data among the other devices and use SCO for the interface 
>from my computer to the BT headset.
>
>It sounds from your discussion that SCO is really not ready to be used.
>In my case, since I'm building an embedded system, I want simple
>and low power. For my system I'd really like a socket interface to SCO.
>If I MUST use a large audio package like ALSA, then I'll do that, but
>I really want something small and simple.
>
>Is there a bluez SCO that I can use ? 
>Do you have any idea when a stable SCO package will be available ?
>
>I'm currently using linux-2.4.19 on an Intel Xscale processor.
>
>thank you very much,
>
>Regards,
>
>Rich
>
>Richard B. Williams
>Vitronics, Inc.
>3 Corbett Way
>Eatontown, NJ 07724-2262
>732-389-0244 x29
>Richard.Williams@vitronics.com
>
>
>-----Original Message-----
>From: Marcel Holtmann [mailto:marcel@holtmann.org]
>Sent: Monday, March 01, 2004 10:29 AM
>To: James Courtier-Dutton
>Cc: BlueZ Mailing List
>Subject: Re: [Bluez-devel] SCO. Some ideas.
>
>
>Hi James,
>
>  
>
>>I have started to think of how we might better achieve our goal without 
>>explicitly having trigger/pointer etc. api calls from the HCI to the SCO 
>>layer.
>>The current bluez stack handles HCI SCO receiving ok for now. HCI SCO 
>>packets can be lost, but that is not so much of a problem.
>>The current problem is the HCI SCO sending. i.e. CPU to Bluetooth air.
>>There is no rate limiting in the HCI SCO sending.
>>Options for rate limiting: -
>>1) For best sound quality, the rate limiting should be based on the HCI 
>>hardware, and not any other source.
>>2) Only send hci sco when one receives an hci sco
>>This causes problems if received hci sco packets get dropped due to 
>>missed irqs etc. So it is better to not link the TX rate limiting to any 
>>RX packet rate.
>>3) Use the linux system time.
>>If the user changes the time, the linux system time get changed, so the 
>>rate limiting will be messed up each time the linux system time is 
>>changed. So, better not to use the linux system time.
>>
>>So, we really want to use (1) if we can.
>>How about?: -
>>
>>1) Each hci sco packet being send from the sco layer to the hci layer is 
>>tagged with a sequence number.
>>We send the hci sco packet from sco layer to hci layer.
>>When the tx_complete for that hci sco packet happens, the packet is 
>>returned to the sco layer being taged as complete and then the sco layer 
>>refills it with new data and sends it down again. As we tagged the hci 
>>sco packet with a sequence number, when it comes back we know which 
>>packet was actually send. As it has a sequence number on it, we can 
>>detect lost packets.
>>Because the completed packet is send back up to the sco layer, we are 
>>able to remove one malloc/free from the process.
>>Currently we have sco layer doing alloc, hci layer doing free.
>>
>>2) Just use a limited sized queue.
>>sco layer fills the queue, but when the queue is full, it waits.
>>the hci layer empties the queue as and when it needs to.
>>Currently, I think we have a queue, but the size of the queue is not 
>>controllable from the sco layer.
>>It might be better if the hci layer reads the first item in the queue, 
>>schedules it for output. the hci layer only frees the item from the 
>>queue when it reaches tx_complete.
>>The tx_complete state is reached when the bluetooth hardware calls the 
>>interrupt handler.
>>
>>I think option (2) fits more closely with the current bluez design. All 
>>I need is the answer to "How does one limit the queue size?".
>>    
>>
>
>maybe you should look at hci_send_sco() and you can control everything
>by yourself that you wanna send down to the HCI layer and thus to the
>driver. Every connection has its own data queue (data_q).
>
>Regards
>
>Marcel
>
>
>
>
>-------------------------------------------------------
>SF.Net is sponsored by: Speed Start Your Linux Apps Now.
>Build and deploy apps & Web services for Linux with
>a free DVD software kit from IBM. Click Now!
>http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
>_______________________________________________
>Bluez-devel mailing list
>Bluez-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
>
>-------------------------------------------------------
>SF.Net is sponsored by: Speed Start Your Linux Apps Now.
>Build and deploy apps & Web services for Linux with
>a free DVD software kit from IBM. Click Now!
>http://ads.osdn.com/?ad_id56&alloc_id438&op=click
>_______________________________________________
>Bluez-devel mailing list
>Bluez-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-devel
>  
>


-- 
_______________________________________________________________________
Dr. Simon Vogl
Institut für Pervasive Computing, Johannes Kepler Universität Linz
Altenberger Straße 69, A-4040 Linz, Austria

Tel: +43 732 2468-8517, Fax: +43 732 2468-8426
mailto: vogl@soft.uni-linz.ac.at,  http://www.soft.uni-linz.ac.at/
