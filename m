Return-Path: <cyrus@holtmann.org>
Message-ID: <4B69AEAE.4050005@videam.com.br>
Date: Wed, 03 Feb 2010 15:13:18 -0200
From: "Daniel T. Cobra" <dcobra@videam.com.br>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: Long delay to (re)connect a bluetooth mouse
References: <1260906227.4b27e6f39cc7c@www.fastmail.com.br>	 <4B2A4B90.1040009@videam.com.br>	<4B2BBF58.4030901@videam.com.br>	 <1261173899.4041.96.camel@localhost.localdomain>	 <1261176544.4b2c06e0e0eae@www.fastmail.com.br>	 <1261177111.4041.99.camel@localhost.localdomain>	 <20091223164841.7070e75d@strolchi.home.s3e.de>	 <4B325905.6090103@videam.com.br>	 <20091229160135.12d85fe6@strolchi.home.s3e.de>	 <4B423816.4060405@videam.com.br>	 <20100105115152.506eb191@strolchi.home.s3e.de>	 <4B6961A4.5040503@videam.com.br>	 <1265206358.31341.109.camel@localhost.localdomain>	 <4B69898E.1070001@videam.com.br> <1265207877.31341.115.camel@localhost.localdomain>
In-Reply-To: <1265207877.31341.115.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel:

> that is the wrong place. You need to look into net/bluetooth/l2cap.c.
> The LMP features are mandatory at all costs. Otherwise hell breaks loose
> if you don't do the right.

I looked into l2cap.c but I'd need to know the protocol better to make 
sense of what's going on in there.

Basically, do you think the failure to reply to the L2CAP information 
request is a non-compliance to the protocol on the part of this 
particular mouse model, or does it implement an older version of the 
protocol, or something like that? (The delay does not happen under MS 
Windows, if it means anything.)

 From the hci dump, it seems the mouse replies to the HCI Read Remote 
Supported Features:

2010-01-08 00:15:03.144090 > HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
2010-01-08 00:15:03.144103 < HCI Command: Remote Name Request 
(0x01|0x0019) plen 10
    bdaddr 00:16:38:E2:A5:57 mode 2 clkoffset 0x0000
2010-01-08 00:15:03.146089 > HCI Event: Number of Completed Packets 
(0x13) plen 5
    handle 42 packets 2
2010-01-08 00:15:03.149092 > HCI Event: Read Remote Supported Features 
(0x0b) plen 11
    status 0x00 handle 42
    Features: 0xbc 0x02 0x04 0x28 0x08 0x08 0x00 0x00

Is this unrelated to the L2CAP information request? Why would one work 
and not the other? Perhaps one is related to the device's features and 
the other to the connection's features?

In short, can anything be done to avoid this L2CAP timeout on the 
information request (something that, in addition to solving my problem, 
would result in a small improvement to bluez, in terms of device 
compatibility), or should I just forget about it and get a new BT mouse? 
What do you think?

Regards,

Daniel
