Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH v2] Bluetooth: Fix encryption key size handling for LTKs
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1433776479-20712-1-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 9 Jun 2015 00:20:37 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <CC159BEB-80C3-4ED9-BD3A-64D5C5E78669@holtmann.org>
References: <1433776479-20712-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The encryption key size for LTKs is supposed to be applied only at the
> moment of encryption. When generating a Link Key (using LE SC) from
> the LTK the full non-shortened value should be used. This patch
> modifies the code to always keep the full value around and only apply
> the key size when passing the value to HCI.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci_core.h |  2 +-
> net/bluetooth/hci_conn.c         |  4 ++--
> net/bluetooth/hci_event.c        |  3 ++-
> net/bluetooth/smp.c              | 15 +++------------
> 4 files changed, 8 insertions(+), 16 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index a056c2bfeb81..24c0e4577a93 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1408,7 +1408,7 @@ void mgmt_smp_complete(struct hci_conn *conn, bool complete);
> u8 hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max, u16 latency,
> 		      u16 to_multiplier);
> void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __le64 rand,
> -							__u8 ltk[16]);
> +		      __u8 ltk[16], __u8 key_size);
> 
> void hci_copy_identity_address(struct hci_dev *hdev, bdaddr_t *bdaddr,
> 			       u8 *bdaddr_type);
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index ee5e59839b02..2c48bf0b5afb 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -276,7 +276,7 @@ u8 hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max, u16 latency,
> }
> 
> void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __le64 rand,
> -		      __u8 ltk[16])
> +		      __u8 ltk[16], __u8 key_size)
> {
> 	struct hci_dev *hdev = conn->hdev;
> 	struct hci_cp_le_start_enc cp;
> @@ -288,7 +288,7 @@ void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __le64 rand,
> 	cp.handle = cpu_to_le16(conn->handle);
> 	cp.rand = rand;
> 	cp.ediv = ediv;
> -	memcpy(cp.ltk, ltk, sizeof(cp.ltk));
> +	memcpy(cp.ltk, ltk, key_size);
> 
> 	hci_send_cmd(hdev, HCI_OP_LE_START_ENC, sizeof(cp), &cp);
> }
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 7b61be73650f..fcbfa4138eb1 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -4955,7 +4955,8 @@ static void hci_le_ltk_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
> 			goto not_found;
> 	}
> 
> -	memcpy(cp.ltk, ltk->val, sizeof(ltk->val));
> +	memcpy(cp.ltk, ltk->val, ltk->enc_size);
> +	memset(cp.ltk + ltk->enc_size, 0, sizeof(cp.ltk) - ltk->enc_size);
> 	cp.handle = cpu_to_le16(conn->handle);

you did test that a size of 16 - 16 = 0 is not causing memset to go bezerk and crash?

Regards

Marcel

