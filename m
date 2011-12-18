Return-Path: <cyrus@holtmann.org>
Date: Sun, 18 Dec 2011 17:45:11 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 7/7 v2] Bluetooth: Use correct struct for
 user_confirm_neg_reply
Message-ID: <20111218194511.GB2621@joana>
References: <1323902861-15990-1-git-send-email-johan.hedberg@gmail.com>
 <1323902861-15990-8-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1323902861-15990-8-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* johan.hedberg@gmail.com <johan.hedberg@gmail.com> [2011-12-15 00:47:41 +0200]:

> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> This patch fixes user_confirm_neg_reply to use the appropriate struct
> for accessing the call parameters.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> Acked-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/mgmt.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

All patches were applied, I also fixed some places to have them working with
the new workqueue patches. Thanks.

	Gustavo
