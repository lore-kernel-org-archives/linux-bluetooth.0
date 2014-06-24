Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH 2/3] Bluetooth: Add a new HCI_USE_DEBUG_KEYS flag
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1403607628-30926-2-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 24 Jun 2014 13:08:28 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <7C7D6135-3B0C-4705-93B3-E3088BCADDB1@holtmann.org>
References: <1403607628-30926-1-git-send-email-johan.hedberg@gmail.com> <1403607628-30926-2-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> To pave the way for actively using debug keys for pairing this patch
> adds a new HCI_USE_DEBUG_KEYS flag for the purpose. When the flag is set
> we issue a HCI_Write_SSP_Debug mode whenever HCI_Write_SSP_Mode(0x01)
> has been issued as well as before issuing a HCI_Write_SSP_Mode(0x00)
> command.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci.h |  1 +
> net/bluetooth/mgmt.c        | 12 ++++++++++--
> 2 files changed, 11 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

