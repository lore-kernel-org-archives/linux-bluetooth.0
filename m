Return-Path: <Lutz.Pressler@SerNet.DE>
Date: Thu, 27 May 2004 22:36:05 +0200 (CEST)
From: Lutz Pressler <Lutz.Pressler@SerNet.DE>
To: Marcel Holtmann <marcel@holtmann.org>
cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] packet types / speed (USB dongles)?
In-Reply-To: <1085687369.8896.50.camel@pegasus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Message-Id: <E1BTRbh-0005QP-00@intern.SerNet.DE>
List-ID: <bluez-users.lists.sourceforge.net>

> every CSR based that I have seen so far supports every packet type from
> the Bluetooth 1.1 specification. However you can set the used packet
> types by yourself, but this makes no sense. Simply enable them all and
> let the link manager decide what's the best to use. The HVx packets for
> SCO audio links and don't matter for the data transfers over ACL.
Is it normal than that file transfer with obexftp to the phone is
not faster than 1 MB per minute?

Thanks,
  Lutz

-- 
  _              |  Lutz Pressler          |  Tel: ++49-551-3700002
 |_     |\ |     |  Service Network GmbH   |  FAX: ++49-551-3700009
 ._|ER  | \|ET   |  Bahnhofsallee 1b       |   mailto:lp@SerNet.DE
Service Network  |  D-37081 Goettingen     |  http://www.SerNet.DE/
