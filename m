Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH] Bluetooth: Fix authentication check for FIPS security level
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1401450319-14615-1-git-send-email-johan.hedberg@gmail.com>
Date: Sat, 31 May 2014 06:25:56 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <7387B35C-00BE-43D5-94FE-85DDE7625C01@holtmann.org>
References: <1401450319-14615-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> When checking whether we need to request authentication or not we should
> include HCI_SECURITY_FIPS to the levels that always need authentication.
> This patch fixes check for it in the hci_outgoing_auth_needed()
> function.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_event.c | 1 +
> 1 file changed, 1 insertion(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

