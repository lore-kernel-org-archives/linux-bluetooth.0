Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39C11E0DCB
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 May 2025 06:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746079534; cv=none; b=lJz2PAXGq9+0sQxWFq45x5yOB768XDyCvbgM6/K9BqV/gpCEYdyE4mE8fZDVIoK2tYAdE5wFbybixX434EUjfB5u5UtvQBHXfbe32bbnEIc9v2ZLVN1425jhOXi3g33mkav2klqNyhk5eVcaMeV4JYE9MXR1mU7+9e/Q1j8Wst8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746079534; c=relaxed/simple;
	bh=wk6p/POoAuDqVMcDdJ9x/Q9gs2MpPxPTvX88lap2vwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=Njb1sPI486tvaTy9Q/FChDsExdWDeixVcdbbVS8skP89h311HnLVE9ZrmR72BHmShVTgIZbJ9ncSY27PKKJ+yqQevxep1O0WOT3vEMrSuS6ueJyHgMLimjDKQEC72ttCVQ14SFSpyYKrpKcbIIsQco2sOPrxDUqXg4qbzOIhIsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.224] (ip5f5aea87.dynamic.kabel-deutschland.de [95.90.234.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id EBFD461E6479A;
	Thu, 01 May 2025 08:05:19 +0200 (CEST)
Message-ID: <47aa4db5-346e-4811-8e20-94d1157aaae0@molgen.mpg.de>
Date: Thu, 1 May 2025 08:05:19 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: hci_event: Fix not using key encryption
 size when its known
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <20250430192448.2386611-1-luiz.dentz@gmail.com>
Content-Language: en-US
Cc: linux-bluetooth@vger.kernel.org,
 =?UTF-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis@collabora.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250430192448.2386611-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Luiz,


Thank you for your patch.

Am 30.04.25 um 21:24 schrieb Luiz Augusto von Dentz:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Maybe start by stating, that currently some devices fail to pair.

> If the key encryption size is known, due previously reading it using
> HCI_OP_READ_ENC_KEY_SIZE, then store it as part of link_key/smp_ltk
> structures so the next time the encryption is changed their values are
> used as conn->enc_key_size thus avoiding the racing against
> HCI_OP_READ_ENC_KEY_SIZE.
> 
> Now that the enc_size is stored as part of key the information the code
> then attempts to check that there is no downgrade of security if
> HCI_OP_READ_ENC_KEY_SIZE returns a value smaller than what has been
> previously stored.
> 
> Fixes: 50c1241e6a8a ("Bluetooth: l2cap: Check encryption key size on incoming connection")

This hash is not in Linus’ git archive. There it is commit 
522e9ed157e3c21b4dd623c79967f72c21e45b78.

> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

I guess this is related to the regression reports. Could you add the 
tags below?

Link: https://bugzilla.kernel.org/show_bug.cgi?id=220061
Link: https://bugzilla.kernel.org/show_bug.cgi?id=220063

One minor comment below.

> ---
>   include/net/bluetooth/hci_core.h |  2 +
>   net/bluetooth/hci_conn.c         | 24 ++++++++++
>   net/bluetooth/hci_event.c        | 75 +++++++++++++++++++-------------
>   3 files changed, 70 insertions(+), 31 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 965ca1ca841c..683e9de1180c 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -221,6 +221,7 @@ struct link_key {
>   	u8 type;
>   	u8 val[HCI_LINK_KEY_SIZE];
>   	u8 pin_len;
> +	u8 enc_size;
>   };
>   
>   struct oob_data {
> @@ -1801,6 +1802,7 @@ struct hci_conn_params *hci_pend_le_action_lookup(struct list_head *list,
>   void hci_uuids_clear(struct hci_dev *hdev);
>   
>   void hci_link_keys_clear(struct hci_dev *hdev);
> +u8 *hci_conn_key_enc_size(struct hci_conn *conn);
>   struct link_key *hci_find_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr);
>   struct link_key *hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn,
>   				  bdaddr_t *bdaddr, u8 *val, u8 type,
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index d8f6aaf14703..364de56ae7fb 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -3058,3 +3058,27 @@ int hci_ethtool_ts_info(unsigned int index, int sk_proto,
>   	hci_dev_put(hdev);
>   	return 0;
>   }
> +
> +u8 *hci_conn_key_enc_size(struct hci_conn *conn)
> +{
> +	if (conn->type == ACL_LINK) {
> +		struct link_key *key;
> +
> +		key = hci_find_link_key(conn->hdev, &conn->dst);
> +		if (!key)
> +			return NULL;
> +
> +		return &key->enc_size;
> +	} else if (conn->type == LE_LINK) {
> +		struct smp_ltk *ltk;
> +
> +		ltk = hci_find_ltk(conn->hdev, &conn->dst, conn->dst_type,
> +				   conn->role);
> +		if (!ltk)
> +			return NULL;
> +
> +		return &ltk->enc_size;
> +	}
> +
> +	return NULL;
> +}
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 105d1446c9dc..71f0c5650b8d 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -739,10 +739,17 @@ static u8 hci_cc_read_enc_key_size(struct hci_dev *hdev, void *data,
>   			   handle);
>   		conn->enc_key_size = 0;
>   	} else {
> +		u8 *key_enc_size = hci_conn_key_enc_size(conn);
> +
>   		conn->enc_key_size = rp->key_size;
>   		status = 0;
>   
> -		if (conn->enc_key_size < hdev->min_enc_key_size) {
> +		/* Attempt to check if the key size is too small or if it has
> +		 * been donwgraded from the last time it was stored as part of

downgraded

> +		 * the link_key.
> +		 */
> +		if (conn->enc_key_size < hdev->min_enc_key_size ||
> +		    (key_enc_size && conn->enc_key_size < *key_enc_size)) {
>   			/* As slave role, the conn->state has been set to
>   			 * BT_CONNECTED and l2cap conn req might not be received
>   			 * yet, at this moment the l2cap layer almost does
> @@ -755,6 +762,10 @@ static u8 hci_cc_read_enc_key_size(struct hci_dev *hdev, void *data,
>   			clear_bit(HCI_CONN_ENCRYPT, &conn->flags);
>   			clear_bit(HCI_CONN_AES_CCM, &conn->flags);
>   		}
> +
> +		/* Update the key encryption size with the connection one */
> +		if (key_enc_size && *key_enc_size != conn->enc_key_size)
> +			*key_enc_size = conn->enc_key_size;
>   	}
>   
>   	hci_encrypt_cfm(conn, status);
> @@ -3065,6 +3076,36 @@ static void hci_inquiry_result_evt(struct hci_dev *hdev, void *edata,
>   	hci_dev_unlock(hdev);
>   }
>   
> +static int hci_read_enc_key_size(struct hci_dev *hdev, struct hci_conn *conn)
> +{
> +	struct hci_cp_read_enc_key_size cp;
> +	u8 *key_enc_size = hci_conn_key_enc_size(conn);
> +	int err;
> +
> +	if (!read_key_size_capable(hdev)) {
> +		conn->enc_key_size = HCI_LINK_KEY_SIZE;
> +		return -EOPNOTSUPP;
> +	}
> +
> +	bt_dev_dbg(hdev, "hcon %p", conn);
> +
> +	memset(&cp, 0, sizeof(cp));
> +	cp.handle = cpu_to_le16(conn->handle);
> +
> +	/* If the key enc_size is already known, use it as conn->enc_key_size */
> +	if (key_enc_size && *key_enc_size)
> +		conn->enc_key_size = *key_enc_size;
> +
> +	err = hci_send_cmd(hdev, HCI_OP_READ_ENC_KEY_SIZE, sizeof(cp), &cp);
> +	if (err) {
> +		bt_dev_err(hdev, "sending read key size failed");
> +		if (!conn->enc_key_size)
> +			conn->enc_key_size = HCI_LINK_KEY_SIZE;
> +	}
> +
> +	return err;
> +}
> +
>   static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
>   				  struct sk_buff *skb)
>   {
> @@ -3157,23 +3198,11 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
>   		if (ev->encr_mode == 1 && !test_bit(HCI_CONN_ENCRYPT, &conn->flags) &&
>   		    ev->link_type == ACL_LINK) {
>   			struct link_key *key;
> -			struct hci_cp_read_enc_key_size cp;
>   
>   			key = hci_find_link_key(hdev, &ev->bdaddr);
>   			if (key) {
>   				set_bit(HCI_CONN_ENCRYPT, &conn->flags);
> -
> -				if (!read_key_size_capable(hdev)) {
> -					conn->enc_key_size = HCI_LINK_KEY_SIZE;
> -				} else {
> -					cp.handle = cpu_to_le16(conn->handle);
> -					if (hci_send_cmd(hdev, HCI_OP_READ_ENC_KEY_SIZE,
> -							 sizeof(cp), &cp)) {
> -						bt_dev_err(hdev, "sending read key size failed");
> -						conn->enc_key_size = HCI_LINK_KEY_SIZE;
> -					}
> -				}
> -
> +				hci_read_enc_key_size(hdev, conn);
>   				hci_encrypt_cfm(conn, ev->status);
>   			}
>   		}
> @@ -3612,24 +3641,8 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, void *data,
>   
>   	/* Try reading the encryption key size for encrypted ACL links */
>   	if (!ev->status && ev->encrypt && conn->type == ACL_LINK) {
> -		struct hci_cp_read_enc_key_size cp;
> -
> -		/* Only send HCI_Read_Encryption_Key_Size if the
> -		 * controller really supports it. If it doesn't, assume
> -		 * the default size (16).
> -		 */
> -		if (!read_key_size_capable(hdev)) {
> -			conn->enc_key_size = HCI_LINK_KEY_SIZE;
> +		if (hci_read_enc_key_size(hdev, conn))
>   			goto notify;
> -		}
> -
> -		cp.handle = cpu_to_le16(conn->handle);
> -		if (hci_send_cmd(hdev, HCI_OP_READ_ENC_KEY_SIZE,
> -				 sizeof(cp), &cp)) {
> -			bt_dev_err(hdev, "sending read key size failed");
> -			conn->enc_key_size = HCI_LINK_KEY_SIZE;
> -			goto notify;
> -		}
>   
>   		goto unlock;
>   	}


Kind regards,

Paul
