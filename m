Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH 3/3] Bluetooth: Add support for mode 0x02 for mgmt_set_debug_keys
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1403607628-30926-3-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 24 Jun 2014 13:08:43 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <C3F305CF-74BA-4FC1-92CD-5C063FBBA351@holtmann.org>
References: <1403607628-30926-1-git-send-email-johan.hedberg@gmail.com> <1403607628-30926-3-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch adds a new valid mode 0x02 for the mgmt_set_debug_keys
> command. The 0x02 mode sets the HCI_USE_DEBUG_KEYS flag which makes us
> always use debug keys for pairing.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/mgmt.c | 18 ++++++++++++++++--
> 1 file changed, 16 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

