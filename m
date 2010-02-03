Return-Path: <cyrus@holtmann.org>
Subject: Re: Long delay to (re)connect a bluetooth mouse
From: Marcel Holtmann <marcel@holtmann.org>
To: "Daniel T. Cobra" <dcobra@videam.com.br>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <4B6961A4.5040503@videam.com.br>
References: <1260906227.4b27e6f39cc7c@www.fastmail.com.br>
	 <4B2A4B90.1040009@videam.com.br>	<4B2BBF58.4030901@videam.com.br>
	 <1261173899.4041.96.camel@localhost.localdomain>
	 <1261176544.4b2c06e0e0eae@www.fastmail.com.br>
	 <1261177111.4041.99.camel@localhost.localdomain>
	 <20091223164841.7070e75d@strolchi.home.s3e.de>
	 <4B325905.6090103@videam.com.br>
	 <20091229160135.12d85fe6@strolchi.home.s3e.de>
	 <4B423816.4060405@videam.com.br>
	 <20100105115152.506eb191@strolchi.home.s3e.de>
	 <4B6961A4.5040503@videam.com.br>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 03 Feb 2010 06:12:38 -0800
Message-ID: <1265206358.31341.109.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

> For me, this is going to be a shot in the dark, not being familiar with 
> the Bluetooth protocol, but could one of you developers please say if 
> any of what follows makes sense?
> 
> Comparing the hci dumps from my mouse's reconnection and Stefan's, I am 
> suspicious of the first line below:
> 
> [...]                        
> 2010-01-08 00:15:03.136170 < ACL data: handle 42 flags 0x02 dlen 10
>     L2CAP(s): Info req: type 2
> 2010-01-08 00:15:03.144090 > HCI Event: Command Status (0x0f) plen 4
>     Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1

I totally missed this command. Yes, you are on the right track. We have
a timeout for devices not responding to information request.

#define L2CAP_INFO_TIMEOUT      (4000)  /*  4 seconds */

Problem here is that information request is actually needed to determine
the features of the remote L2CAP stack.

Regards

Marcel


