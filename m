Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8613812AAF6
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Mar 2024 14:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711376354; cv=none; b=a72sl7XgXS6BbfMUnxo+UWfKFE+kr/DPaE2otLjHt40cHccst6v96lg+0pdMCsQHtgTnH7S0W0QF2w9o2GIVwnvewFs6isao5sJGb11yiRZvtyRcKPnoJ1+RgEi6kV1s7GrhhODqKMcX7lPRHcCOqsvOKYrhWKJsWhlZRhgnxKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711376354; c=relaxed/simple;
	bh=gqg16l7FUt7SDXmmWfgEpwoXg114vpvofRLn+JAHhxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=NFktZL7xXqVNOWr97jhVGTLd9gMWKvJB/6I+i4v+7uQxuA1n2zEyNnrgK3rzcGGMH+l2kIggsDVk4r+KuweeMdyPYOmTEX2DDtT+FKtajmBhsUudC0sGcOTsQCd1TRZbfVgPcYNKti8cySr3rPl5NVIGbKLORsSyGYTcux0e/2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [10.0.45.140] (unknown [62.214.191.67])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 77EDF61E5FE01;
	Mon, 25 Mar 2024 15:18:54 +0100 (CET)
Message-ID: <bedd53fd-e034-4038-9180-5ee378460e09@molgen.mpg.de>
Date: Mon, 25 Mar 2024 15:18:51 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: hci_event: conn is already encryped before
 conn establishes
To: Hui Wang <hui.wang@canonical.com>
References: <20240325061841.22387-1-hui.wang@canonical.com>
Content-Language: en-US
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 marcel@holtmann.org, johan.hedberg@gmail.com
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240325061841.22387-1-hui.wang@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Hui,


Thank you for your patch. Some minor nits from my side.

Regarding the summary (encryp*t*ed), please describe the action of the 
change and not the issue.

Am 25.03.24 um 07:18 schrieb Hui Wang:
> We have a BT headset (Lenovo Thinkplus XT99), the pairing and
> connecting has no problem, once this headset is paired, bluez will
> remember this device and will auto re-connect it whenever the device
> is power on. The auto re-connecting works well with Windows and

power*ed*

> Android, but with Linux, it always fails. Through debugging, we found
> at the rfcomm connection stage, the bluetooth stack reports
> "Connection refused - security block (0x0003)".
> 
> For this device, the re-connecting negotiation process is different
> from other BT headsets, it sends the Link_KEY_REQUEST command before
> the CONNECT_REQUEST completes, and it doesn't send ENCRYPT_CHANGE
> command during the negotiation. When the device sends the "connect
> complete" to hci, the ev->encr_mode is 1.

Is that in accordance with the specification or a violation?

> So here in the conn_complete_evt(), if ev->encr_mode is 1, link type
> is ACL and HCI_CONN_ENCRYPT is not set, we set HCI_CONN_ENCRYPT to
> this conn, and update conn->enc_key_size accordingly.
> 
> After this change, this BT headset could re-connect with Linux
> successfully.

Despite this being a generic issue, could you please document with what 
controller you tested this?

Do you have any bug/issue tracker URL, you can reference?

> Signed-off-by: Hui Wang <hui.wang@canonical.com>
> ---
> This is the btmon log for auto re-connecting negotiation:
> Before applying this patch:
> https://pastebin.com/NUa9RJv8
> 
> After applying the patch:
> https://pastebin.com/GqviChTC
> 
> net/bluetooth/hci_event.c | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 4ae224824012..0c45beb08cb2 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -3208,6 +3208,32 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
>   		if (test_bit(HCI_ENCRYPT, &hdev->flags))
>   			set_bit(HCI_CONN_ENCRYPT, &conn->flags);
>   
> +		/* "Link key request" completed ahead of "connect request" completes */
> +		if (ev->encr_mode == 1 && !test_bit(HCI_CONN_ENCRYPT, &conn->flags) &&
> +		    ev->link_type == ACL_LINK) {
> +			struct link_key *key;
> +			struct hci_cp_read_enc_key_size cp;
> +
> +			key = hci_find_link_key(hdev, &ev->bdaddr);
> +			if (key) {
> +				set_bit(HCI_CONN_ENCRYPT, &conn->flags);
> +
> +				if (!(hdev->commands[20] & 0x10)) {
> +					conn->enc_key_size = HCI_LINK_KEY_SIZE;
> +					goto notify;
> +				}
> +
> +				cp.handle = cpu_to_le16(conn->handle);
> +				if (hci_send_cmd(hdev, HCI_OP_READ_ENC_KEY_SIZE,
> +						 sizeof(cp), &cp)) {
> +					bt_dev_err(hdev, "sending read key size failed");
> +					conn->enc_key_size = HCI_LINK_KEY_SIZE;
> +				}
> +notify:
> +				hci_encrypt_cfm(conn, ev->status);


Is goto and labels necessary?

> +			}
> +		}
> +
>   		/* Get remote features */
>   		if (conn->type == ACL_LINK) {
>   			struct hci_cp_read_remote_features cp;


Kind regards,

Paul
