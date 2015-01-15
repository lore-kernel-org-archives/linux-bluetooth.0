Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH 1/2] Bluetooth: Add helpers for src/dst bdaddr type conversion
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1421320005-26037-1-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 15 Jan 2015 07:58:59 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <9B28AC56-7E2F-4FCC-A4B5-083C52085C4A@holtmann.org>
References: <1421320005-26037-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The current bdaddr_type() usage in l2cap_core.c is a bit funny in that
> it's always passed a hci_conn + a hci_conn member. Because of this only
> the hci_conn is really needed. Since the second parameter is always
> either hcon->src_type or hcon->dst type this patch adds two helper
> functions for each purpose: bdaddr_src_type() and bdaddr_dst_type().
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/l2cap_core.c | 34 ++++++++++++++++++++++------------
> 1 file changed, 22 insertions(+), 12 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

