Return-Path: <cyrus@holtmann.org>
Message-ID: <1351816363.1828.22.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: Fix parameter order of hci_get_route
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 02 Nov 2012 01:32:43 +0100
In-Reply-To: <1351769246-28854-1-git-send-email-johan.hedberg@gmail.com>
References: <1351769246-28854-1-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The actual parameter order of hci_get_route is (dst, src) and not (src,
> dst). All current callers use the right order but the header file shows
> the parameters in the wrong order.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I trust you that you triple checked this.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


