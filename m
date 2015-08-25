Return-Path: <cyrus@holtmann.org>
Message-ID: <55DC22C4.8070302@intel.com>
Date: Tue, 25 Aug 2015 10:09:40 +0200
From: Loic Poulain <loic.poulain@intel.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Johan Hedberg <johan.hedberg@gmail.com>,
 linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_h4: Fix zero len data packet reception
 issue
References: <1440435477-25188-1-git-send-email-loic.poulain@intel.com> <6CD3A286-2B0E-4D93-A31B-49336A8AC37C@holtmann.org>
In-Reply-To: <6CD3A286-2B0E-4D93-A31B-49336A8AC37C@holtmann.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,


> please give me an example of such a packet. I am currently failing to see what is wrong with the code and how this patch would actually help.
>
> Is this for vendor packet types or does this actually happen with standard H:4 packet types?


Yes, this is for some vendor specific packets.
For example, I have to deal with LPM packet with the following format:

|0xf1|opcode|dlen|data|

This kind of packet can be easily added to the h4_recv_pkt list.
However, some of these packets don't have any data (just PM ack packet):
0xf1|0x03|0x00

If we receive this packet, the h4_recv_buf function will retrieve the 
dlen (0) and just wait for more data. As long as there is not new data 
received (new packet), the LPM packet is not transmitted to the bt core.

Regards,
Loic


-- 
Intel Open Source Technology Center
http://oss.intel.com/
