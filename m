Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: [PATCH v3] Bluetooth: Fix incorrect removing of IRKs
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1453836691-10342-1-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 27 Jan 2016 16:26:13 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <20E5B8D9-13C4-4E0D-8F05-7FB3F89E180C@holtmann.org>
References: <1453836691-10342-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The commit cad20c278085d893ebd616cd20c0747a8e9d53c7 was supposed to
> fix handling of devices first using public addresses and then
> switching to RPAs after pairing. Unfortunately it missed a couple of
> key places in the code.
> 
> 1. When evaluating which devices should be removed from the existing
> white list we also need to consider whether we have an IRK for them or
> not, i.e. a call to hci_find_irk_by_addr() is needed.
> 
> 2. In smp_notify_keys() we should not be requiring the knowledge of
> the RPA, but should simply keep the IRK around if the other conditions
> require it.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> Cc: stable@vger.kernel.org # 4.4+
> ---
> net/bluetooth/hci_request.c | 28 ++++++++++++++++++----------
> net/bluetooth/smp.c         | 16 ----------------
> 2 files changed, 18 insertions(+), 26 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

