Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH] Bluetooth: Use hci_copy_identity_addr() helper for SMP chan creation
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1424432904-5217-1-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 20 Feb 2015 09:16:50 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <5778CBF1-CB97-4A91-B416-64246638BA75@holtmann.org>
References: <1424432904-5217-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The only reason the SMP code is essentially duplicating the
> hci_copy_identity_addr() function is that the helper returns the address
> type in the HCI format rather than the three-value format expected by
> l2cap_chan. This patch converts the SMP code to use the helper and then
> do a simple conversion from one address type to another.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/smp.c | 24 +++++++-----------------
> 1 file changed, 7 insertions(+), 17 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

