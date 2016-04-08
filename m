Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] Bluetooth: Fix setting NO_BREDR advertising flag
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1459937345-30236-1-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 8 Apr 2016 09:53:02 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <4B32DABE-7947-4047-9025-99B6FB3443F3@holtmann.org>
References: <1459937345-30236-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> If we're dealing with a single-mode controller or BR/EDR is disable
> for a dual-mode one, the NO_BREDR flag needs to be unconditionally
> present in the advertising data. This patch moves it out from behind
> an extra condition to be always set in the create_instance_adv_data()
> function if BR/EDR is disabled.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_request.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)

patch has been applied bluetooth-next tree.

Regards

Marcel

