Return-Path: <harbaum@beecon.de>
From: Till Harbaum <harbaum@beecon.de>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-devel] L2CAP dropping packets on BlueZ based receiver
Date: Tue, 3 Aug 2004 14:16:46 +0200
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
References: <200408021859.44496.harbaum@beecon.de> <200408031223.11789.harbaum@beecon.de> <1091532252.4259.38.camel@pegasus>
In-Reply-To: <1091532252.4259.38.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200408031416.46803.harbaum@beecon.de>
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel,

On Tuesday 03 August 2004 13:24, Marcel Holtmann wrote:
> this. We only have to take care of that we don't get more packets than
> our receive buffers can take. So the RFCOMM flow control should be
But this means, that rfcomm has to know about the socket buffers and will have 
to make sure, that it won't give more credits than socket buffers are 
available.

In fact i always wondered what the purpose of rfcomm giving credits on packets 
not on bytes is. But with such an implementation this even makes sense 
(although i still think, that these per-packet-credits are an as bad idea as 
keeping the header checksum behind the rfcomm payload is ...).

> enought to assure this. In general this is a big design mistake in the
> Bluetooth protocol stack itself and only L2CAP with retransmission and
> flow control can fix it.
Yes, you are right.

Wouldn't it be a good idea to use acl flow control at least as long as there's 
only one acl client? This would at least increase the reliability for single 
connection scenarios which are probably the most common case.

This has the disadvantage, that the system behaves differently with single 
connections and with multiple connections. For multiple acl connections it's 
exactly as unrealiable as it is today, but it gives a little advantage to 
single acl connections.

Ciao,
  Till

-- 
Dr.-Ing. Till Harbaum                       Tel.:  +49 721 4998963
BeeCon GmbH                                 Fax:   +49 721 4998962
Haid-und-Neu Strasse 7, 76131 Karlsruhe     Mobil: +49 179 9087904
harbaum@beecon.de                           http://www.beecon.de
