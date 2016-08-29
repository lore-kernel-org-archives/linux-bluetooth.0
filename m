Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] Bluetooth: mgmt: Fix sending redundant event for Advertising Instance
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1472406814-25388-1-git-send-email-johan.hedberg@gmail.com>
Date: Sun, 28 Aug 2016 21:26:24 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <CA430032-1FDD-45AB-977C-670D13A83A4B@holtmann.org>
References: <1472406814-25388-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> When an Advertising Instance is removed, the Advertising Removed event
> shouldn't be sent to the same socket that issued the Remove
> Advertising command (it gets a command complete event instead). The
> mgmt_advertising_removed() function already has a parameter for
> skipping a specific socket, but there was no code to propagate the
> right value to this parameter. This patch fixes the issue by making
> sure the intermediate hci_req_clear_adv_instance() function gets the
> socket pointer.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_request.c | 11 ++++++-----
> net/bluetooth/hci_request.h |  5 +++--
> net/bluetooth/mgmt.c        |  6 +++---
> 3 files changed, 12 insertions(+), 10 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

