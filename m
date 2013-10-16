Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH] Bluetooth: Fix updating the right variable in update_scan_rsp_data()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1381926667-6255-1-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 16 Oct 2013 16:03:11 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <43BDD80F-5A24-41E7-8CA1-D4C694300B01@holtmann.org>
References: <1381926667-6255-1-git-send-email-johan.hedberg@gmail.com>
To: johan.hedberg@gmail.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This function should be operating on scan_rsp_data_len and scan_rsp_data
> and not the advertising data variables.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/mgmt.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)

good catch. Patch has been applied to bluetooth-next tree.

Regards

Marcel

