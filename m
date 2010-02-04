Return-Path: <cyrus@holtmann.org>
Date: Thu, 4 Feb 2010 18:13:40 +0000 (GMT)
To: "Daniel T\. Cobra" <dcobra@videam.com.br>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Long delay to (re)connect a bluetooth mouse
In-Reply-To: <4B6AF3AB.4080900@videam.com.br>
References: <1260906227.4b27e6f39cc7c@www.fastmail.com.br>  <4B2A4B90.1040009@videam.com.br> <4B2BBF58.4030901@videam.com.br>  <1261173899.4041.96.camel@localhost.localdomain>  <1261176544.4b2c06e0e0eae@www.fastmail.com.br>  <1261177111.4041.99.camel@localhost.localdomain>
  <20091223164841.7070e75d@strolchi.home.s3e.de>  <4B325905.6090103@videam.com.br>  <20091229160135.12d85fe6@strolchi.home.s3e.de>  <4B423816.4060405@videam.com.br>  <20100105115152.506eb191@strolchi.home.s3e.de>  <4B6961A4.5040503@videam.com.br>
 <1265206358.31341.109.camel@localhost.localdomain>  <4B69898E.1070001@videam.com.br> <1265207877.31341.115.camel@localhost.localdomain> <4B69AEAE.4050005@videam.com.br> <1265220271.415099.26064.nullmailer@galant.ukfsn.org> <4B6AF3AB.4080900@videam.com.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Message-Id: <1265307221.374338.22195.nullmailer@galant.ukfsn.org>
From: Iain Hibbert <plunky@rya-online.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 4 Feb 2010, Daniel T. Cobra wrote:

> One last question, though: would this L2CAP timeout happen if I use the
> BT module in HIDP mode, if the module supports it? I tried to do a test
> by setting HID2HCI_ENABLED to 0 in /etc/default/bluetooth (I'm using
> Debian), but I get this message from /etc/init.d/bluetooth saying this
> is deprecated and I should use a udev rule for that, so I'd have to look
> further into it to find out how to do it.

>From what I understand of your request, no this L2CAP timeout would
probably not happen in that case. If you could switch the dongle into HID
mode then the Bluetooth protocol stack in use would be entirely inside the
dongle (and probably not send Info requests) and the Linux kernel would
only see a USB Mouse.

Unless you bought the dongle and mouse together as a pair though, it is
unlikely that the dongle can operate in HID mode..

regards,
iain


