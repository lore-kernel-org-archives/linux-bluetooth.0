Return-Path: <pmarques@grupopie.com>
Message-ID: <40A4D03D.3060701@grupopie.com>
Date: Fri, 14 May 2004 14:57:17 +0100
From: Paulo Marques <pmarques@grupopie.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Matthias Thomae <bluez@thomae-privat.de>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] PAN and bridge problem when bnep0 disconnects	before bnep1
References: <40A27A5C.4080603@thomae-privat.de> <1084398131.25099.115.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

>>
>>If bnep1 disconnects before bnep0, no problem.
>>

I had a similar problem a while ago (it was a 2.4.xx kernel, didn't try a 2.6 
kernel yet).

The problem was that the bridge interface borrowed the mac address from one of 
the interfaces attached to it.

When this interface disconnected, the bridge would start using the MAC from some 
other interface. Because of this, other computers on the network, relying on 
their arp cache, could not contact the bridge any more.

I tried "arp-pinging" the network to announce the new mac, but couldn't make it 
work. (maybe I was doing something wrong)

I eventually gave up, without finding any solution.

As I said, I didn't try kernel 2.6. I remember reading somewhere that there was 
a new kernel internal API to get a "valid" random MAC address and that the 
bridging code was using it, but I'm not sure I didn't got it wrong.

Just my 2 cents,

-- 
Paulo Marques - www.grupopie.com
"In a world without walls and fences who needs windows and gates?"
