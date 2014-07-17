Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH 3/3] Bluetooth: Fix allowing initiating pairing when not pairable
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1405600540-28292-3-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 17 Jul 2014 14:42:23 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <A40779A3-5CAB-4AE4-80E3-E487A6DB5866@holtmann.org>
References: <1405600540-28292-1-git-send-email-johan.hedberg@gmail.com> <1405600540-28292-3-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> When we're not pairable we should still allow us to act as initiators
> for pairing, i.e. the HCI_PAIRABLE flag should only be affecting
> incoming pairing attempts. This patch fixes the relevant checks for the
> hci_io_capa_request_evt() and hci_pin_code_request_evt() functions.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_event.c | 9 +++++++--
> 1 file changed, 7 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

