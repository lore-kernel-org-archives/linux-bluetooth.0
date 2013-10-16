Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH 1/2] Bluetooth: Ignore A2MP data on non-BR/EDR links
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1381912621-10238-1-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 16 Oct 2013 10:42:22 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <52564DD0-92D4-4AF5-B5E3-B1287D4F38D4@holtmann.org>
References: <1381912621-10238-1-git-send-email-johan.hedberg@gmail.com>
To: johan.hedberg@gmail.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The A2MP CID is only valid for BR/EDR transports. We should ignore A2MP
> data on non-BR/EDR links and refuse to create an amp_mgr object.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/a2mp.c | 3 +++
> 1 file changed, 3 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

