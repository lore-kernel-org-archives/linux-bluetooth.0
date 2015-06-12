Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH] Bluetooth: Remove redundant check for ACL_LINK
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1434103487-9296-1-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 12 Jun 2015 12:10:05 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <A106C7DC-C921-415E-9575-B4A8684DD9B6@holtmann.org>
References: <1434103487-9296-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The encryption key size is read only for BR/EDR (ACL_LINK) connections
> so there's no need to check for it in the read_enc_key_size_complete()
> callback.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_event.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

