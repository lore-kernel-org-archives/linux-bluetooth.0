Return-Path: <cyrus@holtmann.org>
Date: Mon, 11 May 2015 20:35:32 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Frederic Danis <frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 1/2] Bluetooth: hci_core: return cmd status in
 __hci_cmd_sync()
Message-ID: <20150511173532.GA21779@t440s.P-661HNU-F1>
References: <1431359418-23502-1-git-send-email-frederic.danis@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1431359418-23502-1-git-send-email-frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

On Mon, May 11, 2015, Frederic Danis wrote:
> @@ -234,7 +227,18 @@ EXPORT_SYMBOL(__hci_cmd_sync_ev);
>  struct sk_buff *__hci_cmd_sync(struct hci_dev *hdev, u16 opcode, u32 plen,
>  			       const void *param, u32 timeout)
>  {
> -	return __hci_cmd_sync_ev(hdev, opcode, plen, param, 0, timeout);
> +	struct sk_buff *skb;
> +	int err;
> +
> +	skb = __hci_cmd_sync_ev(hdev, opcode, plen, param, 0, timeout);
> +	if (!IS_ERR(skb) && skb->data[0]) {
> +		err = -bt_to_errno(skb->data[0]);
> +		kfree_skb(skb);
> +
> +		return ERR_PTR(err);
> +	}
> +
> +	return skb;

Are you absolutely sure that this is needed? To my understanding the
__hci_cmd_sync_ev() function should already be returning an error if we
got a non-zero status either through a Command Complete or a Command
Status event.

For both of these events the status is collected up in the event
handlers called by hci_event_packet() and then passed as the second
parameter to req_complete_skb(). The req_complete_skb() callback in turn
is hci_req_sync_complete() for __hci_cmd_sync_ev() which stores the
status in hdev->req_result. The hdev->req_result is then further
converted through bt_to_errno() back in __hci_cmd_sync_ev().

So to me it seems like your addition above should not be needed. What we
do want however is all the code removals in your patches that remove
code that was (incorrectly) assuming that non-zero statuses would be
returned as actual skbs rather than errors.

Johan
