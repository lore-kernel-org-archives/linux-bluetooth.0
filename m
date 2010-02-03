Return-Path: <cyrus@holtmann.org>
Date: Wed, 3 Feb 2010 18:04:31 +0000 (GMT)
To: "Daniel T\. Cobra" <dcobra@videam.com.br>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Long delay to (re)connect a bluetooth mouse
In-Reply-To: <4B69AEAE.4050005@videam.com.br>
References: <1260906227.4b27e6f39cc7c@www.fastmail.com.br>  <4B2A4B90.1040009@videam.com.br> <4B2BBF58.4030901@videam.com.br>  <1261173899.4041.96.camel@localhost.localdomain>  <1261176544.4b2c06e0e0eae@www.fastmail.com.br>  <1261177111.4041.99.camel@localhost.localdomain>
  <20091223164841.7070e75d@strolchi.home.s3e.de>  <4B325905.6090103@videam.com.br>  <20091229160135.12d85fe6@strolchi.home.s3e.de>  <4B423816.4060405@videam.com.br>  <20100105115152.506eb191@strolchi.home.s3e.de>  <4B6961A4.5040503@videam.com.br>
 <1265206358.31341.109.camel@localhost.localdomain>  <4B69898E.1070001@videam.com.br> <1265207877.31341.115.camel@localhost.localdomain> <4B69AEAE.4050005@videam.com.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Message-Id: <1265220271.415099.26064.nullmailer@galant.ukfsn.org>
From: Iain Hibbert <plunky@rya-online.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 3 Feb 2010, Daniel T. Cobra wrote:

> Basically, do you think the failure to reply to the L2CAP information
> request is a non-compliance to the protocol on the part of this
> particular mouse model, or does it implement an older version of the
> protocol, or something like that? (The delay does not happen under MS
> Windows, if it means anything.)

I think the mouse is non-compliant, as the L2CAP Information request has
been present since at least 1.1 of the specification which says that a
valid response should be sent.

Sending such a request is optional however, and probably the people who
wrote that mouse stack never tested it against anything that sent one.
Even if it didn't understand it, it should reply with a "command not
understood" message..

> From the hci dump, it seems the mouse replies to the HCI Read Remote
> Supported Features:

that is unrelated

regards,
iain


