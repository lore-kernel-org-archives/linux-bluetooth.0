Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] Bluetooth: Fix allowing SMP Signing info PDU
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1410304906-20898-1-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 9 Sep 2014 16:46:08 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <98D4EFC0-E1FC-499A-A47A-D2CDE258A462@holtmann.org>
References: <1410304906-20898-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> If the remote side is not distributing its IRK but is distributing the
> CSRK the next PDU after master identification is the Signing
> Information. This patch fixes a missing SMP_ALLOW_CND() for this in the
> smp_cmd_master_ident() function.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/smp.c | 2 ++
> 1 file changed, 2 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

