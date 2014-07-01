Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH 1/2] Bluetooth: Add flag to track STK encryption
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1404230529-16137-1-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 1 Jul 2014 18:09:41 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <BA015987-3B05-490C-B2BC-9435DF103D3B@holtmann.org>
References: <1404230529-16137-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> There are certain subtle differences in behavior when we're encrypted
> with the STK, such as allowing re-encryption even though the security
> level stays the same. Because of this, add a flag to track whether we're
> encrypted with an STK or not.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci_core.h | 1 +
> net/bluetooth/hci_event.c        | 3 +++
> net/bluetooth/smp.c              | 4 ++++
> 3 files changed, 8 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index eb0add396595..9078da681f16 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -536,6 +536,7 @@ enum {
> 	HCI_CONN_AUTH,
> 	HCI_CONN_SECURE,
> 	HCI_CONN_FIPS,
> +	HCI_CONN_STK_ENCRYPT,
> };
> 
> static inline bool hci_conn_ssp_enabled(struct hci_conn *conn)
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 8097559ebb48..b0b760dd66a3 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -4365,8 +4365,11 @@ static void hci_le_ltk_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
> 	 * using a distributed LTK.
> 	 */
> 	if (ltk->type == SMP_STK) {
> +		set_bit(HCI_CONN_STK_ENCRYPT, &conn->flags);
> 		list_del(&ltk->list);
> 		kfree(ltk);
> +	} else {
> +		clear_bit(HCI_CONN_STK_ENCRYPT, &conn->flags);
> 	}
> 
> 	hci_dev_unlock(hdev);
> diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> index 6ce7785a2708..de29ad74e571 100644
> --- a/net/bluetooth/smp.c
> +++ b/net/bluetooth/smp.c
> @@ -538,6 +538,7 @@ static u8 smp_random(struct smp_chan *smp)
> 
> 		hci_le_start_enc(hcon, ediv, rand, stk);
> 		hcon->enc_key_size = smp->enc_key_size;
> +		set_bit(HCI_CONN_STK_ENCRYPT, &hcon->flags);
> 	} else {
> 		u8 stk[16], auth;
> 		__le64 rand = 0;
> @@ -856,6 +857,9 @@ static bool smp_ltk_encrypt(struct l2cap_conn *conn, u8 sec_level)
> 	hci_le_start_enc(hcon, key->ediv, key->rand, key->val);
> 	hcon->enc_key_size = key->enc_size;
> 
> +	/* We never store STKs for central, so clear this flag */

this might better say master here.

> +	clear_bit(HCI_CONN_STK_ENCRYPT, &hcon->flags);
> +

Regards

Marcel

