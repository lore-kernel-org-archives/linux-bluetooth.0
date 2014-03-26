Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH] Bluetooth: Fix RSSI value in device found event from disabling scan
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1395836232-10425-1-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 26 Mar 2014 09:24:58 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <24333F67-4520-4ECD-99F3-3E8EA9760788@holtmann.org>
References: <1395836232-10425-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> When sending a pending device found event triggered by disabling LE
> scanning we should use the stored RSSI instead of sending a zero value.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_event.c | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

