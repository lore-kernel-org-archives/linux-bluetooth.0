Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH] Bluetooth: Set HCI_QUIRK_STRICT_DUPLICATE_FILTER for BTUSB_ATH3012
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1422556714-12493-1-git-send-email-jpawlowski@google.com>
Date: Thu, 29 Jan 2015 11:14:07 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <C231CA08-72E1-4518-953C-A2EADE09AE6D@holtmann.org>
References: <1422556714-12493-1-git-send-email-jpawlowski@google.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

> The Bluetooth controllers from Atheros use a strict scanning filter
> policy that filters based on Bluetooth device addresses and not on
> RSSI. So tell the core about this.
> 
> Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
> ---
> drivers/bluetooth/btusb.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

