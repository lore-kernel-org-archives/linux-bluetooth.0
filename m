Return-Path: <cyrus@holtmann.org>
Date: Thu, 12 Nov 2009 10:16:30 +0000 (GMT)
To: Susanne Goldammer <susanne.goldammer@gmx.de>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Make bluetoothd start w/o SDP Server
In-Reply-To: <4AFBD3B6.6020706@gmx.de>
References: <4AF9721B.3010405@gmx.de> <1257861916.10888.1372.camel@localhost.localdomain> <4AF97659.2050807@gmx.de> <4AFBD3B6.6020706@gmx.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Message-Id: <1258020990.988942.3883.nullmailer@galant.ukfsn.org>
From: Iain Hibbert <plunky@rya-online.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 12 Nov 2009, Susanne Goldammer wrote:

> I would like to explain in more detail why I use this option to start
> bluetoothd without its own SDP-Server.
>
> The goal is to test the SDP implementation of bluetooth-capable Daimler
> headunits. For this i need my own SDP-Server implementation running,
> cause this SDP Server answers with predefined and invalid SDP Responses
> to special Requests from headunit.

I guess that a "Daimler headunit" is something to do with the Daimler car,
is that some kind of builtin radio with integrated handsfree capability?

I would be interested to find out why you need to use proprietary SDP
requests?  They would only be accessible from a proprietary device and as
there are no vendor-specific PDU IDs defined in the SDP specification
there is a chance of conflict with future extensions. (I admit its
unlikely, but the ID is only 8-bit).

The Bluetooth specifications allow numerous ways to provide proprietary
services, and IMO the proper way to advertise such is to create your own
UUID describing the service class, your own UUID describing the protocol
(if any), search for that in the standard way and connect to the service
in the same way as you would any other. The attribute values are defined
by the service class so you can provide as much information as you want in
this way, no secret handshakes required at all.

regards,
iain

(please note, I don't even run BlueZ/Linux and thus can't object to this
specific implementation in any meaningful way. I'm just interested :)



