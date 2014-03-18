Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH v2 1/2] Bluetooth: Fix const declaration for swap function src parameter
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1395140304-15747-1-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 18 Mar 2014 10:19:23 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <AFC7C382-70BE-4DD7-BCD0-120E384F78D9@holtmann.org>
References: <1395140304-15747-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> To make it possible to (correctly) pass data declared as const as the
> src parameter to the swap56 and swap128 functions declare this parameter
> also as const.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/smp.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

