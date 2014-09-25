Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] Bluetooth: Rename sco_param_wideband table to esco_param_msbc
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1411627681-540-1-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 25 Sep 2014 10:38:24 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <3D75964E-7786-4DA1-88F9-9E4E896DE4D3@holtmann.org>
References: <1411627681-540-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The sco_param_wideband table represents the eSCO parameters for
> specifically mSBC encoding. This patch renames the table to the more
> descriptive esco_param_msbc name.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_conn.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

