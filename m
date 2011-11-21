Return-Path: <cyrus@holtmann.org>
Message-ID: <1321893793.2011.13.camel@aeonflux>
Subject: Re: [PATCH 1/2] Bluetooth: Fix request completion for command
 status events
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 21 Nov 2011 17:43:13 +0100
In-Reply-To: <1321888740-15598-1-git-send-email-johan.hedberg@gmail.com>
References: <1321888740-15598-1-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> If a HCI command triggered by hci_request() fails at the command status
> phase we need to properly inform the request tracking code of the
> completion of the request.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/hci_event.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index dfe6fbc..236f895 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -2055,6 +2055,9 @@ static inline void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb)
>  
>  	opcode = __le16_to_cpu(ev->opcode);
>  
> +	if (ev->status != 0)
> +		hci_req_complete(hdev, opcode, ev->status);
> +

we actually would write it "if (!ev->status)" in the kernel code.

Regards

Marcel


