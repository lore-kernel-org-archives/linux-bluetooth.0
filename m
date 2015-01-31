Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH] Bluetooth: Set HCI_QUIRK_STRICT_DUPLICATE_FILTER for BTUSB_INTEL
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1422672958-17279-1-git-send-email-jpawlowski@google.com>
Date: Fri, 30 Jan 2015 20:04:07 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <58104EC7-E179-4F67-969F-E637E31952C1@holtmann.org>
References: <1422672958-17279-1-git-send-email-jpawlowski@google.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

> The Bluetooth controllers from Intel use a strict scanning filter
> policy that filters based on Bluetooth device addresses and not on
> RSSI. So tell the core about this.
> 
> Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
> ---
> drivers/bluetooth/btusb.c | 1 +
> 1 file changed, 1 insertion(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

