Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH 2/2] Bluetooth: Add clarifying comment for LE CoC result value
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1409553903-25260-2-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 1 Sep 2014 07:20:17 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <369C246F-6F0A-49CF-8BE1-C90E3BF6D0DE@holtmann.org>
References: <1409553903-25260-1-git-send-email-johan.hedberg@gmail.com> <1409553903-25260-2-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The "pending" L2CAP response value is not defined for LE CoC. This patch
> adds a clarifying comment to the code so that the reader will not think
> there is a bug in trying to use this value for LE CoC.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/l2cap_core.c | 5 +++++
> 1 file changed, 5 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

