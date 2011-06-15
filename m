Return-Path: <cyrus@holtmann.org>
Date: Wed, 15 Jun 2011 22:48:49 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Antti Julku <antti.julku@nokia.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Bluetooth: Add blacklisting support for mgmt
 interface
Message-ID: <20110615194849.GA8047@dell.ger.corp.intel.com>
References: <1308128475-11670-1-git-send-email-antti.julku@nokia.com>
 <1308128475-11670-2-git-send-email-antti.julku@nokia.com>
 <20110615175739.GA23248@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110615175739.GA23248@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Wed, Jun 15, 2011, Gustavo F. Padovan wrote:
> > +#define MGMT_OP_BLOCK_DEVICE		0x001D
> > +struct mgmt_cp_block_device {
> > +	bdaddr_t bdaddr;
> > +} __packed;
> > +
> > +#define MGMT_OP_UNBLOCK_DEVICE		0x001E
> 
> To make hci code consistent call replace _DEVICE by _ADDR in both macros.

I think Antti was just taking example from MGMT_OP_PAIR_DEVICE. To me
"device" sounds better than "addr" as far as the management interface is
concerned, but I'm not gonna object if you wanna change these
occurrences to addr.

Johan
Johan
