Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH 1/3] Bluetooth: Fix ignoring debug keys in mgmt_load_link_keys
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1403607628-30926-1-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 24 Jun 2014 13:08:10 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <F9ABE195-491C-43D4-B1C5-FC6CA869BB97@holtmann.org>
References: <1403607628-30926-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> We should never allow user space to feed back debug keys to the kernel.
> If the user desires to use debug keys require setting the appropriate
> debug keys mode and performing a new pairing.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/mgmt.c | 6 ++++++
> 1 file changed, 6 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

