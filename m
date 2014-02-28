Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH] Bluetooth: Fix clearing SMP keys if pairing fails
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1393575016-12166-1-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 28 Feb 2014 01:07:52 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <9DBB1AEA-356C-4575-9203-BBA6F7934247@holtmann.org>
References: <1393575016-12166-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> If SMP fails we should not leave any keys (LTKs or IRKs) hanging around
> the internal lists. This patch adds the necessary code to
> smp_chan_destroy to remove any keys we may have in case of pairing
> failure.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/smp.c | 18 ++++++++++++++++++
> 1 file changed, 18 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

