Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Subject: Re: [PATCH v2 1/2] Bluetooth: Introduce a new HCI_RFKILLED flag
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1378978153-5683-2-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 12 Sep 2013 09:13:53 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <D9301F4C-E433-4296-9F81-B731CE35C6FC@holtmann.org>
References: <1378978153-5683-1-git-send-email-johan.hedberg@gmail.com> <1378978153-5683-2-git-send-email-johan.hedberg@gmail.com>
To: johan.hedberg@gmail.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This makes it more convenient to check for rfkill (no need to check for
> dev->rfkill before calling rfkill_blocked()) and also avoids potential
> races if the RFKILL state needs to be checked from within the rfkill
> callback.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> Cc: stable@vger.kernel.org
> ---
> v2: Explicitly intialize HCI_RFKILLED flag after calling rfkill_register
> 
> include/net/bluetooth/hci.h |  1 +
> net/bluetooth/hci_core.c    | 15 ++++++++++-----
> 2 files changed, 11 insertions(+), 5 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel

