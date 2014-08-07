Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH 2/2] Bluetooth: Fix confusion between parent and child channel for 6lowpan
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1407395012-30446-2-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 7 Aug 2014 09:21:49 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <33081918-07FF-497B-9A8E-5DEBA037FC2D@holtmann.org>
References: <1407395012-30446-1-git-send-email-johan.hedberg@gmail.com> <1407395012-30446-2-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The new_connection L2CAP channel callback creates a new channel based on
> the provided parent channel. The 6lowpan code was confusingly naming the
> child channel "pchan" and the parent channel "chan". This patch swaps
> the names.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/6lowpan.c | 10 +++++-----
> 1 file changed, 5 insertions(+), 5 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

