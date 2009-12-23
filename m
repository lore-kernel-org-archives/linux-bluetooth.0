Return-Path: <cyrus@holtmann.org>
Date: Wed, 23 Dec 2009 10:19:13 +0000 (GMT)
To: bluezprofile kernel <bluezprofile@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: service search for headset
In-Reply-To: <ba5648fa0912230200k3aae7de2v920cb00de10cef43@mail.gmail.com>
References: <ba5648fa0912230200k3aae7de2v920cb00de10cef43@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Message-Id: <1261563553.504805.2509.nullmailer@galant.ukfsn.org>
From: Iain Hibbert <plunky@rya-online.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 23 Dec 2009, bluezprofile kernel wrote:

> I have done between two laptops and I am able to see the services available.
> When I do the same for my hands free device, I am not able to get the
> service details of handsfree unit.
> I have debugged this using sdptool application source.
> sdptool application sends the attribute request to the hands free
> device, in the reply I am not getting anything. (sdp_send_req and sdp_read_rsp)

All that a "browse" does is start searching for the "Browse Group Root"
UUID and if the handsfree device doesn't provide that UUID in any of the
records then it will return no results when you search for it.  Many
devices don't provide "Browse Groups" at all (see SDP specification),
probably your handsfree is like that.

Searching for L2CAP will usually suffice to find all of the (relevant)
service records in a Bluetooth environment, as most bluetooth protocols
operate over L2CAP.

iain


