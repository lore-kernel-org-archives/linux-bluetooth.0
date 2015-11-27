Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: [PATCH] Bluetooth: Remove redundant check for req.cmd_q
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1448615512-32120-1-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 27 Nov 2015 04:27:24 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <59CCCD74-21D1-487A-8117-9A7F2E98D26F@holtmann.org>
References: <1448615512-32120-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The hci_req_run() function already checks for empty cmd_q and bails
> out if necessary. Also, req.cmd_q should really be treated as private
> data of the request and not accessed directly.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_request.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

