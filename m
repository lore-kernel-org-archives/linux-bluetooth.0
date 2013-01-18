Return-Path: <cyrus@holtmann.org>
Message-ID: <1358527994.5510.4.camel@aeonflux>
Subject: Re: [PATCH 07/10] Bluetooth: Fix checking for valid address type
 values in mgmt commands
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 18 Jan 2013 08:53:14 -0800
In-Reply-To: <1358515558-17861-8-git-send-email-johan.hedberg@gmail.com>
References: <1358515558-17861-1-git-send-email-johan.hedberg@gmail.com>
	 <1358515558-17861-8-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch adds checks for valid address type values passed to mgmt
> commands. If an invalid address type is encountered the code will return
> a proper invalid params response.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |   43 ++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 38 insertions(+), 5 deletions(-)
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 76301a3..3de4bc2 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -1506,7 +1506,7 @@ static int load_link_keys(struct sock *sk, struct hci_dev *hdev, void *data,
>  {
>  	struct mgmt_cp_load_link_keys *cp = data;
>  	u16 key_count, expected_len;
> -	int i;
> +	int i, err;
>  
>  	key_count = __le16_to_cpu(cp->key_count);
>  
> @@ -1540,15 +1540,24 @@ static int load_link_keys(struct sock *sk, struct hci_dev *hdev, void *data,
>  	for (i = 0; i < key_count; i++) {
>  		struct mgmt_link_key_info *key = &cp->keys[i];
>  
> +		if (key->addr.type != BDADDR_BREDR) {
> +			clear_bit(HCI_DEBUG_KEYS, &hdev->dev_flags);
> +			hci_link_keys_clear(hdev);
> +			err = cmd_status(sk, hdev->id, MGMT_OP_LOAD_LINK_KEYS,
> +					 MGMT_STATUS_INVALID_PARAMS);
> +			goto unlock;
> +		}
> +
>  		hci_add_link_key(hdev, NULL, 0, &key->addr.bdaddr, key->val,
>  				 key->type, key->pin_len);
>  	}

I am not a huge fan of doing it this way (same applies to LTKs). You are
introducing a side effect here. An invalid command will clear the keys.

Please check the validity of the key parameters ahead of time and not in
the middle of applying them. Your rollback is broken since it just
clears all keys.

We could add /sys/kernel/debug/bluetooth/hci0/link_keys as a root-only
entry to allow checking this mgmt-tester.

Regards

Marcel


