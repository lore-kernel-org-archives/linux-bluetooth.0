Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] Bluetooth: Fix using test_and_clear instead of test_and_set
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1404982227-28321-1-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 10 Jul 2014 10:52:37 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <19CAE4D0-8067-4EFB-A648-B62A70B8B2DD@holtmann.org>
References: <1404982227-28321-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The code for updating the HCI_CONNECTABLE flag was incorrectly using
> test_and_set_bit instead of test_and_clear_bit when HCI_CONNECTABLE is
> to be cleared.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_core.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

