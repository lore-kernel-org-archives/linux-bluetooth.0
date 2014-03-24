Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH] Bluetooth: Fix potential NULL pointer dereference in smp_conn_security
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1395675385-4680-1-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 24 Mar 2014 08:41:39 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <04C09C9F-3C22-4014-A47E-AED3C5292D38@holtmann.org>
References: <1395675385-4680-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The smp pointer might not be initialized for jumps to the "done" label
> in the smp_conn_security function. Furthermore doing the set_bit after
> done might "overwrite" a previous value of the flag in case pairing was
> already in progress. This patch moves the call to set_bit before the
> label so that it is only done for a newly created smp context (as
> returned by smp_chan_create).
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/smp.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

