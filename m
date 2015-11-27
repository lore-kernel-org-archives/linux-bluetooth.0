Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: [PATCH] Bluetooth: Fix updating wrong instance's scan_rsp data
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1448614359-27089-1-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 27 Nov 2015 04:27:11 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <4F3A00CF-2D8D-4BFC-9EF3-0C6346A55BCA@holtmann.org>
References: <1448614359-27089-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The __hci_req_update_scan_rsp_data gets the instance to be updated
> which should get passed to update_inst_scan_rsp_data() instead of
> always enabling the current instance.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_request.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

