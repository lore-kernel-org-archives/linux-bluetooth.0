Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: [PATCH v2 1/3] Bluetooth: Remove unnecessary call to hci_update_background_scan
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1447141495-31126-1-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 10 Nov 2015 18:16:09 +0900
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <F79DFF1E-81FF-4CF2-BCDF-527E9C62FF62@holtmann.org>
References: <1447141495-31126-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The hci_conn_params_clear_all() function is only called from
> hci_unregister_dev() at which point it's completely futile to try to
> do any LE scanning updates. Simply remove this unnecessary function
> call. At the same time we can make the function static since it's only
> accessed from within the same c-file.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci_core.h | 1 -
> net/bluetooth/hci_core.c         | 4 +---
> 2 files changed, 1 insertion(+), 4 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

