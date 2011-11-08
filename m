Return-Path: <cyrus@holtmann.org>
Date: Tue, 8 Nov 2011 10:52:56 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Brian Gix <bgix@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/3] Bluetooth: Add address type fields to mgmt messages
 that need them
Message-ID: <20111108085256.GA9733@fusion.localdomain>
References: <1320700419-4665-1-git-send-email-johan.hedberg@gmail.com>
 <1320700419-4665-3-git-send-email-johan.hedberg@gmail.com>
 <4EB86A27.1030403@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4EB86A27.1030403@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

On Mon, Nov 07, 2011, Brian Gix wrote:
> >+#define MGMT_ADDR_BREDR			0x00
> >+#define MGMT_ADDR_LE			0x01
> >+#define MGMT_ADDR_BREDR_LE		0x02
> >+#define MGMT_ADDR_INVALID		0xff
> 
> What would you think about overloading this Address type with the
> Public/Random flag?
> 
> We are already seeing devices in the marketplace with Random
> Addresses, effectively giving LE addresses 7 significant octets of
> address information, rather than the standard 6 octet "MAC"
> addresses.
> 
> 
> >+
> >+struct mgmt_addr_info {
> >+	bdaddr_t bdaddr;
> >+	__u8 type;
> 
> I would also support adding an additional octet here, which would be
> essentially the "Address Type" as used in the HCI LE Connect
> Command, and in the SMP LE Pairing protocol.
> 
> I have stated elsewhere, that I think this to be crucial information
> to store with Long Term KEYs (LTKs) as well as future LE Signing
> keys, and in future Address Resolution solutions. The earlier we get
> this bit of information into the MGMT interface, the better IMO.

This is the same impression I got also when looking into this several
months ago. Thanks for reminding me!

The BREDR_LE option is there for the updated start_discovery command.
You'll be able to specify whether you want BR/EDR-only, LE-only or
interleaved discovery. I wouldn't add a completely new octet for public
vs random information though but reuse the existing one instead. To be
able to reuse our address type definitions for all purposes, how about
making each value orthogonal to the others, e.g.:

	ADDR_BREDR	0x01
	ADDR_LE_PUBLIC	0x02
	ADDR_LE_RANDOM	0x04

For events like connected, found, etc you'd only have one of the bits
set whereas for the start_discovery you could have any (but at least
one).

Johan
