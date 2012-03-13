Return-Path: <cyrus@holtmann.org>
Date: Tue, 13 Mar 2012 09:29:40 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix broken usage of get_unaligned_le16
Message-ID: <20120313072933.GA15895@aemeltch-MOBL1>
References: <1331609468-22906-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1331609468-22906-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Mar 12, 2012 at 08:31:08PM -0700, Marcel Holtmann wrote:
> In case the struct is already __packed, there is no need to use unaligned
> access to the data. So just use __le16_to_cpu in these cases.

One minor comment related to use of __xxx versions. What is the general
rule when to use __le16_to_cpu and when le16_to_cpu? In mgmt.c looks that
mostly in use version without underscore.

Best regards 
Andrei Emeltchenko 

> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/mgmt.c |   12 ++++++------
>  1 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 5aa2c9e..ea2677d 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -862,7 +862,7 @@ static int set_discoverable(struct sock *sk, struct hci_dev *hdev, void *data,
>  
>  	BT_DBG("request for %s", hdev->name);
>  
> -	timeout = get_unaligned_le16(&cp->timeout);
> +	timeout = __le16_to_cpu(cp->timeout);
>  	if (!cp->val && timeout > 0)
>  		return cmd_status(sk, hdev->id, MGMT_OP_SET_DISCOVERABLE,
>  				  MGMT_STATUS_INVALID_PARAMS);
> @@ -1461,7 +1461,7 @@ static int load_link_keys(struct sock *sk, struct hci_dev *hdev, void *data,
>  	u16 key_count, expected_len;
>  	int i;
>  
> -	key_count = get_unaligned_le16(&cp->key_count);
> +	key_count = __le16_to_cpu(cp->key_count);
>  
>  	expected_len = sizeof(*cp) + key_count *
>  					sizeof(struct mgmt_link_key_info);
> @@ -2606,7 +2606,7 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
>  	u16 key_count, expected_len;
>  	int i;
>  
> -	key_count = get_unaligned_le16(&cp->key_count);
> +	key_count = __le16_to_cpu(cp->key_count);
>  
>  	expected_len = sizeof(*cp) + key_count *
>  					sizeof(struct mgmt_ltk_info);
> @@ -2717,9 +2717,9 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
>  	}
>  
>  	hdr = buf;
> -	opcode = get_unaligned_le16(&hdr->opcode);
> -	index = get_unaligned_le16(&hdr->index);
> -	len = get_unaligned_le16(&hdr->len);
> +	opcode = __le16_to_cpu(hdr->opcode);
> +	index = __le16_to_cpu(hdr->index);
> +	len = __le16_to_cpu(hdr->len);
>  
>  	if (len != msglen - sizeof(*hdr)) {
>  		err = -EINVAL;
> -- 
> 1.7.7.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
