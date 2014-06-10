Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH 1/3] Bluetooth: Fix indicating discovery state when canceling inquiry
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1402398359-1602-1-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 10 Jun 2014 13:59:01 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <F947AF91-6A40-41C1-9F3C-9FCA95748091@holtmann.org>
References: <1402398359-1602-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> When inquiry is canceled through the HCI_Cancel_Inquiry command there is
> no Inquiry Complete event generated. Instead, all we get is the command
> complete for the HCI_Inquiry_Cancel command. This means that we must
> call the hci_discovery_set_state() function from the respective command
> complete handler in order to ensure that user space knows the correct
> discovery state.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_event.c | 4 ++++
> 1 file changed, 4 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

