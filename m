Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH 2/4] Bluetooth: Refactor ioctl scan state update to its own function
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1404983349-6105-2-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 10 Jul 2014 11:16:56 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <C933794D-B2B9-430F-8B2F-51726B656174@holtmann.org>
References: <1404983349-6105-1-git-send-email-johan.hedberg@gmail.com> <1404983349-6105-2-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> With subsequent patches we'll also need to update the discoverable
> state. As the code grows bigger it's better to move this out from the
> switch statement into its own function.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_core.c | 35 ++++++++++++++++++++++-------------
> 1 file changed, 22 insertions(+), 13 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

