Return-Path: <harbaum@beecon.de>
From: Till Harbaum <harbaum@beecon.de>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-devel] L2CAP dropping packets on BlueZ based receiver
Date: Tue, 3 Aug 2004 15:29:40 +0200
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
References: <200408021859.44496.harbaum@beecon.de> <200408031416.46803.harbaum@beecon.de> <1091538562.4259.77.camel@pegasus>
In-Reply-To: <1091538562.4259.77.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200408031529.40100.harbaum@beecon.de>
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel,

On Tuesday 03 August 2004 15:09, Marcel Holtmann wrote:
> the point is that we don't really thought about it when we were writing
> our RFCOMM layer. It worked out, but I never checked the granted credits
> against the receive buffer. Sounds like a work for a diploma thesis ;)
Sorry, i already have a diploma and a ph.d., but we do have some bluetooth 
related projects at the university. I'll propose this to some of the 
professors.

> The checksum stuff is historical and you will only get the sense behind
I know. But they thought enough about it to remove the need to build the 
chechsum over the payload. Why did they still keep a checksum? (i have to 
admit, it helped me a lot, since it found some bugs in my l2cap/rfcomm code). 
I'd really like to talk about the person who made the bluetooth changes to 
rfcomm :-)

> The first time I realized why people asking for host to host controller
> flow control (BlueZ don't supports it btw) I screamed out loud. Then I
You are talking about the buffer management on hci layer for the buffers on 
host side aren't you? As long as you have "enough" buffer space this doesn't 
seem very important. But with my devices having only few bytes buffer space, 
it really is necessary.

> flow control of a lower layer for its own purpose. Implementation
> details must reside inside the layer. This is one of the basics of the
> OSI model.
And the L2CAP start/continuation flags are part of the acl header :-)

Ciao,
  Till

-- 
Dr.-Ing. Till Harbaum                       Tel.:  +49 721 4998963
BeeCon GmbH                                 Fax:   +49 721 4998962
Haid-und-Neu Strasse 7, 76131 Karlsruhe     Mobil: +49 179 9087904
harbaum@beecon.de                           http://www.beecon.de
