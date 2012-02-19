Return-Path: <cyrus@holtmann.org>
Message-ID: <1329653590.2246.6.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: Fix hci_connect error return values
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Sun, 19 Feb 2012 13:13:10 +0100
In-Reply-To: <1329653463-29799-1-git-send-email-johan.hedberg@gmail.com>
References: <1329653463-29799-1-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The hci_connect function should either return a valid hci_conn pointer
> or a ERR_PTR() but never NULL. This patch fixes the two places where
> hci_conn_add failures would have caused a NULL return. The only reason
> for failure with hci_conn_add is memory allocation so ENOMEM seems to be
> a good choice here.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/hci_conn.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


