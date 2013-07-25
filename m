Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Subject: Re: [PATCH] Bluetooth: Fix removing Long Term Key
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1374776057-2618-1-git-send-email-claudio.takahasi@openbossa.org>
Date: Thu, 25 Jul 2013 11:25:33 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <49B341B3-2B08-47DB-BFE7-DA2E2BF55185@holtmann.org>
References: <1374776057-2618-1-git-send-email-claudio.takahasi@openbossa.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

> This patch fixes authentication failure on LE link re-connection when
> BlueZ acts as slave (peripheral). LTK is removed from the internal list
> after its first use causing PIN or Key missing reply when re-connecting
> the link. The LE Long Term Key Request event indicates that the master
> is attempting to encrypt or re-encrypt the link.
> 
> Pre-condition: BlueZ host paired and running as slave.
> How to reproduce(master):
>  1) Establish an ACL LE encrypted link
>  2) Disconnect the link
>  3) Try to re-establish the ACL LE encrypted link

please include a btmon or hcidump trace in the commit message.

> Signed-off-by: Claudio Takahasi <claudio.takahasi@openbossa.org>
> ---
> net/bluetooth/hci_event.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index ae78738..ccb93dd 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -3558,7 +3558,8 @@ static void hci_le_ltk_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
> 
> 	hci_send_cmd(hdev, HCI_OP_LE_LTK_REPLY, sizeof(cp), &cp);
> 
> -	if (ltk->type & HCI_SMP_STK) {
> +	/* Use short term key only once */

I think this comment needs to be a bit verbose and explain why. Also reference the spec if possible.

> +	if (ltk->type == HCI_SMP_STK_SLAVE) {
> 		list_del(&ltk->list);
> 		kfree(ltk);
> 	}

Regards

Marcel

