Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH 2/2] Bluetooth: Fix redundant encryption request for reauthentication
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1397242952-3997-2-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 11 Apr 2014 14:38:32 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <073B2C9E-23FA-4E22-8D63-E420F0545557@holtmann.org>
References: <1397242952-3997-1-git-send-email-johan.hedberg@gmail.com> <1397242952-3997-2-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> When we're performing reauthentication (in order to elevate the
> security level from an unauthenticated key to an authenticated one) we
> do not need to issue any encryption command once authentication
> completes. Since the trigger for the encryption HCI command is the
> ENCRYPT_PEND flag this flag should not be set in this scenario.
> Instead, the REAUTH_PEND flag takes care of all necessary steps for
> reauthentication.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_conn.c | 9 ++++++---
> 1 file changed, 6 insertions(+), 3 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

