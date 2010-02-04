Return-Path: <cyrus@holtmann.org>
Message-ID: <4B6AF3AB.4080900@videam.com.br>
Date: Thu, 04 Feb 2010 14:19:55 -0200
From: "Daniel T. Cobra" <dcobra@videam.com.br>
MIME-Version: 1.0
To: Iain Hibbert <plunky@rya-online.net>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: Long delay to (re)connect a bluetooth mouse
References: <1260906227.4b27e6f39cc7c@www.fastmail.com.br>  <4B2A4B90.1040009@videam.com.br> <4B2BBF58.4030901@videam.com.br>  <1261173899.4041.96.camel@localhost.localdomain>  <1261176544.4b2c06e0e0eae@www.fastmail.com.br>  <1261177111.4041.99.camel@localhost.localdomain>  <20091223164841.7070e75d@strolchi.home.s3e.de>  <4B325905.6090103@videam.com.br>  <20091229160135.12d85fe6@strolchi.home.s3e.de>  <4B423816.4060405@videam.com.br>  <20100105115152.506eb191@strolchi.home.s3e.de>  <4B6961A4.5040503@videam.com.br>  <1265206358.31341.109.camel@localhost.localdomain>  <4B69898E.1070001@videam.com.br> <1265207877.31341.115.camel@localhost.localdomain> <4B69AEAE.4050005@videam.com.br> <1265220271.415099.26064.nullmailer@galant.ukfsn.org>
In-Reply-To: <1265220271.415099.26064.nullmailer@galant.ukfsn.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Iain:

> I think the mouse is non-compliant, as the L2CAP Information request has
> been present since at least 1.1 of the specification which says that a
> valid response should be sent.
>
> Sending such a request is optional however, and probably the people who
> wrote that mouse stack never tested it against anything that sent one.
> Even if it didn't understand it, it should reply with a "command not
> understood" message..
>   

O.k., from what you say, this is a quirk of this particular mouse model 
and it is not justifiable to change bluez in any way to fix it. If this 
had become clear earlier on, I wouldn't even have wasted you guys' time 
with this problem!

One last question, though: would this L2CAP timeout happen if I use the 
BT module in HIDP mode, if the module supports it? I tried to do a test 
by setting HID2HCI_ENABLED to 0 in /etc/default/bluetooth (I'm using 
Debian), but I get this message from /etc/init.d/bluetooth saying this 
is deprecated and I should use a udev rule for that, so I'd have to look 
further into it to find out how to do it.

Regards,

Daniel

