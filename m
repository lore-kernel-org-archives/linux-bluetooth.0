Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFC/PATCH] Bluetooth: SMP: Fail gracefully if device doesn't
 support pairing
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170601153550.1578-1-john@metanate.com>
Date: Fri, 9 Jun 2017 19:02:53 +0200
Cc: linux-bluetooth@vger.kernel.org,
        "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Message-Id: <B397B494-6BB4-4068-96DB-276EA821C983@holtmann.org>
References: <20170601153550.1578-1-john@metanate.com>
To: John Keeping <john@metanate.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi John,

> If a device does not support pairing, we have no way of knowing this
> except by trying and seeing if it returns a "pairing not supported"
> error.
> 
> Handle this response specially so that we don't drop the connection when
> an attempt at pairing fails because the device doesn't support pairing.
> Also pass a specific failure value back to userspace to allow detection
> of this case as distinct from an authentication failure during pairing.
> 
> Signed-off-by: John Keeping <john@metanate.com>
> ---
> I'm not particularly happy with the use of
> HCI_ERROR_PAIRING_NOT_SUPPORTED here since this is actually "pairing
> with unit key is not supported" so I don't think it's technically the
> right thing to return here.  But I can't see a more appropriate HCI
> error to which to map the SMP_PAIRING_NOTSUPP reason.
> 
> include/net/bluetooth/hci.h |  1 +
> net/bluetooth/smp.c         | 23 ++++++++++++++++++++---
> 2 files changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index fe98f0a5bef0..0917385a95eb 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -463,6 +463,7 @@ enum {
> #define HCI_ERROR_PAIRING_NOT_ALLOWED	0x18
> #define HCI_ERROR_INVALID_LL_PARAMS	0x1e
> #define HCI_ERROR_UNSPECIFIED		0x1f
> +#define HCI_ERROR_PAIRING_NOT_SUPPORTED	0x29
> #define HCI_ERROR_ADVERTISING_TIMEOUT	0x3c
> 
> /* Flow control modes */
> diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> index 14585edc9439..41f246a69178 100644
> --- a/net/bluetooth/smp.c
> +++ b/net/bluetooth/smp.c
> @@ -813,7 +813,10 @@ static void smp_failure(struct l2cap_conn *conn, u8 reason)
> 		smp_send_cmd(conn, SMP_CMD_PAIRING_FAIL, sizeof(reason),
> 			     &reason);
> 
> -	mgmt_auth_failed(hcon, HCI_ERROR_AUTH_FAILURE);
> +	if (reason == SMP_PAIRING_NOTSUPP)
> +		mgmt_auth_failed(hcon, HCI_ERROR_PAIRING_NOT_SUPPORTED);
> +	else
> +		mgmt_auth_failed(hcon, HCI_ERROR_AUTH_FAILURE);

actually this is a bug. This should have been always MGMT_STATUS_AUTH_FAILED. Handing the ev->status to mgmt_auth_failed is something we should have never done. Luckily HCI_ERROR_AUTH_FAILURE and MGMT_STATUS_AUTH_FAILED are the same error code number. And the Core spec defines usage of error code Authentication Failure (0x05) in Simple Pairing Complete cases.

So I propose that first we fix the usage of HCI_ERROR_AUTH_FAILURE and replace it with MGMT_STATUS_ versions.

And then we use a new MGMT_STATUS_ code or use MGMT_STATUS_NOT_SUPPORTED to indicate the different error.

Regards

Marcel

