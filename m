Return-Path: <cyrus@holtmann.org>
Date: Thu, 5 Apr 2012 13:23:17 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC v2 4/5] Bluetooth: Use address type info from User-space
Message-ID: <20120405102317.GD32212@x220>
References: <1333570570-1288-1-git-send-email-andre.guedes@openbossa.org>
 <1333570570-1288-5-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1333570570-1288-5-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Wed, Apr 04, 2012, Andre Guedes wrote:
>  	err = l2cap_chan_connect(chan, la.l2_psm, __le16_to_cpu(la.l2_cid),
> -				&la.l2_bdaddr);
> +				&la.l2_bdaddr, la.l2_bdaddr_type);

Same alignment issue here. Since you're modifying the line you might as
well fix the alignment too.

Johan
