Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Subject: Re: [PATCH] Bluetooth: Fix sparse warnings in RFCOMM
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1415083545-32629-1-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 3 Nov 2014 23:02:48 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <EB1EA32A-9D67-4B85-97F9-58835F1A297D@holtmann.org>
References: <1415083545-32629-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch fixes the following sparse warnings in rfcomm/core.c:
> 
> net/bluetooth/rfcomm/core.c:391:16: warning: dubious: x | !y
> net/bluetooth/rfcomm/core.c:546:24: warning: dubious: x | !y
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/rfcomm/core.c | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

