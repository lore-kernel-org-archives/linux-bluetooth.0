Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [RFC] Bluetooth: HCI H5 fast retransmit
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1406911076-8714-1-git-send-email-loic.poulain@intel.com>
Date: Wed, 6 Aug 2014 12:59:40 -0700
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Message-Id: <D672899E-220D-4633-A74A-9C50021C2AE8@holtmann.org>
References: <1406911076-8714-1-git-send-email-loic.poulain@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> HCI H5 protocol is based on timeout to retransmit dropped packets.
> According to the specification, this timeout should be calculated
> based on the baudrate and the maximum packet size.
> 
> In the current implementation, this timeout is set to 250ms.
> Moreover this timer is re-triggered for 250ms at each packet transmission
> without taking care of the previous non acked packet timeout.
> So, in the worst case, the delay before retransmission of a packet is
> tx_win*250ms. Common H5 tx_win is 4.
> 
> These delays are not acceptable in case of "real time".
> Despite buffering, It may lead to audio cuts with A2DP profile.
> 
> Rather than decreasing timeout with a magic value, I propose to implement
> a fast retransmit mechanism:
> If a sender receives a specified number of invalid acks (basically, duplicate
> ACKs), the sender can be reasonably confident that its oldest non-acknowledged
> H5 packet was dropped.
> 
> This mechanism is out of the H5 specification.
> However, without breaking compatibility, it gives good results in practical
> tests.

what do you want me to do with this patch. I do not have a device to verify this and so far nobody else has spoken up to ACK or NAK it.

In general I am fine with such an approach. However you might want to add nice comments in the code for what we are doing and why.

I wonder if this feature is so much out-of-scape of H5 that adding an extra flag for it to enable it might be a good idea? Of is it just that this is something we should be doing anyway since it makes sense?

Regards

Marcel

