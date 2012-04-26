Return-Path: <cyrus@holtmann.org>
Message-ID: <1335423399.16897.432.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: Fix Inquiry with RSSI event mask
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 26 Apr 2012 08:56:39 +0200
In-Reply-To: <1335422866-15474-1-git-send-email-johan.hedberg@gmail.com>
References: <1335422866-15474-1-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The right bit for "Inquiry with RSSI" is 0x02 and not 0x04 (which means
> "Read Remote Extended Features Complete").
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/hci_event.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth and bluetooth-next trees.

Regards

Marcel


