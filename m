Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD96913D61B;
	Thu, 28 Nov 2024 05:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732773329; cv=none; b=tuPYJpTkBf9eVohcYn7zqQayY0IQlK9H8rvae+Flpc9PU7mMoJweWg6gfjItctFORKFv+6WuL0lvloaA+pf/3muLMDMbLd0WM5EaHiVzPdBj7aybULgl//yS/HQii5A9m8HURvGNDDnsBCEN+EyjBZrigddv3wGwqw+ZEYR+viE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732773329; c=relaxed/simple;
	bh=kkNJait5I2LB/hBvCpklFsI0uKskiOctwkK67l/pNFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ju4uVlDd7SnsjCMJb5FXwGMY2NzrRbmCV7TxhEhV9PuSp7tfRQmL/8caVVXEYKWSPLRCYJPh00QT89C4v0bJPomtGnkW9Xs/qEUfCnxiP8Nl3nuEsMRnIyFjyCiuOEAkX8viFSU8HmefheKBRnfQG4/BFPBxL9f12V1nqzMTYf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.224] (ip5f5aeb13.dynamic.kabel-deutschland.de [95.90.235.19])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id D2B3461E5FE05;
	Thu, 28 Nov 2024 06:55:06 +0100 (CET)
Message-ID: <ce455385-2000-4da3-aaa1-a3b292220130@molgen.mpg.de>
Date: Thu, 28 Nov 2024 06:55:05 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btusb: avoid NULL pointer defereference in
 skb_dequeue()
To: En-Wei Wu <en-wei.wu@canonical.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 anthony.wong@canonical.com, kuan-ying.lee@canonical.com,
 Tim Jiang <quic_tjiang@quicinc.com>
References: <20241128030807.270581-1-en-wei.wu@canonical.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20241128030807.270581-1-en-wei.wu@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

[Cc: +Tim]

Dear En-Wei,


Thank you for the patch. There is a typo in the summary/title/subject:

dereference

Am 28.11.24 um 04:08 schrieb En-Wei Wu:
> The WCN7851 (0489:e0f3) Bluetooth controller supports firmware crash dump
> collection through devcoredump. During this process, the crash dump data
> is queued to a dump queue as skb for further processing.
> 
> A NULL pointer dereference occurs in skb_dequeue() when processing the
> dump queue due to improper return value handling:
> 
> [ 93.672166] Bluetooth: hci0: ACL memdump size(589824)
> 
> [ 93.672475] BUG: kernel NULL pointer dereference, address: 0000000000000008
> [ 93.672517] Workqueue: hci0 hci_devcd_rx [bluetooth]
> [ 93.672598] RIP: 0010:skb_dequeue+0x50/0x80
> 
> The issue stems from handle_dump_pkt_qca() returning the wrong value on
> success. It currently returns the value from hci_devcd_init() (0 on success),
> but callers expect > 0 to indicate successful dump handling. This causes
> hci_recv_frame() to free the skb while it's still queued for dump
> processing, leading to the NULL pointer dereference when hci_devcd_rx()
> tries to dequeue it.
> 
> Fix this by:
> 
> 1. Extracting dump packet detection into new is_dump_pkt_qca() function
> 2. Making handle_dump_pkt_qca() return 0 on success and negative errno
>     on failure, consistent with other kernel interfaces
> 
> This prevents premature skb freeing by ensuring proper handling of dump packets.

Re-flow this line for 75/72 characters per line?

How can I force the the firmware crash dump selection?

> Fixes: 20981ce2d5a5 ("Bluetooth: btusb: Add WCN6855 devcoredump support")
> Signed-off-by: En-Wei Wu <en-wei.wu@canonical.com>
> ---
>   drivers/bluetooth/btusb.c | 75 ++++++++++++++++++++++++---------------
>   1 file changed, 47 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 279fe6c115fa..8926f8f60e5c 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2930,22 +2930,16 @@ static void btusb_coredump_qca(struct hci_dev *hdev)
>   		bt_dev_err(hdev, "%s: triggle crash failed (%d)", __func__, err);
>   }
>   
> -/*
> - * ==0: not a dump pkt.
> - * < 0: fails to handle a dump pkt
> - * > 0: otherwise.
> - */
> +/* Return: 0 on success, negative errno on failure. */
>   static int handle_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb)
>   {
> -	int ret = 1;
> +	int ret = 0;
>   	u8 pkt_type;
>   	u8 *sk_ptr;
>   	unsigned int sk_len;
>   	u16 seqno;
>   	u32 dump_size;
>   
> -	struct hci_event_hdr *event_hdr;
> -	struct hci_acl_hdr *acl_hdr;
>   	struct qca_dump_hdr *dump_hdr;
>   	struct btusb_data *btdata = hci_get_drvdata(hdev);
>   	struct usb_device *udev = btdata->udev;
> @@ -2955,30 +2949,14 @@ static int handle_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb)
>   	sk_len = skb->len;
>   
>   	if (pkt_type == HCI_ACLDATA_PKT) {
> -		acl_hdr = hci_acl_hdr(skb);
> -		if (le16_to_cpu(acl_hdr->handle) != QCA_MEMDUMP_ACL_HANDLE)
> -			return 0;
>   		sk_ptr += HCI_ACL_HDR_SIZE;
>   		sk_len -= HCI_ACL_HDR_SIZE;
> -		event_hdr = (struct hci_event_hdr *)sk_ptr;
> -	} else {
> -		event_hdr = hci_event_hdr(skb);
>   	}
>   
> -	if ((event_hdr->evt != HCI_VENDOR_PKT)
> -		|| (event_hdr->plen != (sk_len - HCI_EVENT_HDR_SIZE)))
> -		return 0;
> -
>   	sk_ptr += HCI_EVENT_HDR_SIZE;
>   	sk_len -= HCI_EVENT_HDR_SIZE;
>   
>   	dump_hdr = (struct qca_dump_hdr *)sk_ptr;
> -	if ((sk_len < offsetof(struct qca_dump_hdr, data))
> -		|| (dump_hdr->vse_class != QCA_MEMDUMP_VSE_CLASS)
> -	    || (dump_hdr->msg_type != QCA_MEMDUMP_MSG_TYPE))
> -		return 0;
> -
> -	/*it is dump pkt now*/
>   	seqno = le16_to_cpu(dump_hdr->seqno);
>   	if (seqno == 0) {
>   		set_bit(BTUSB_HW_SSR_ACTIVE, &btdata->flags);
> @@ -3052,17 +3030,58 @@ static int handle_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb)
>   	return ret;
>   }
>   
> +/* Return: true if packet is a dump packet, false otherwise. */
> +static bool is_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb)
> +{
> +	u8 pkt_type;
> +	u8 *sk_ptr;
> +	unsigned int sk_len;
> +
> +	struct hci_event_hdr *event_hdr;
> +	struct hci_acl_hdr *acl_hdr;
> +	struct qca_dump_hdr *dump_hdr;
> +
> +	pkt_type = hci_skb_pkt_type(skb);
> +	sk_ptr = skb->data;
> +	sk_len = skb->len;
> +
> +	if (pkt_type == HCI_ACLDATA_PKT) {
> +		acl_hdr = hci_acl_hdr(skb);
> +		if (le16_to_cpu(acl_hdr->handle) != QCA_MEMDUMP_ACL_HANDLE)
> +			return false;
> +		sk_ptr += HCI_ACL_HDR_SIZE;
> +		sk_len -= HCI_ACL_HDR_SIZE;
> +		event_hdr = (struct hci_event_hdr *)sk_ptr;
> +	} else {
> +		event_hdr = hci_event_hdr(skb);
> +	}
> +
> +	if ((event_hdr->evt != HCI_VENDOR_PKT)
> +		|| (event_hdr->plen != (sk_len - HCI_EVENT_HDR_SIZE)))
> +		return false;
> +
> +	sk_ptr += HCI_EVENT_HDR_SIZE;
> +	sk_len -= HCI_EVENT_HDR_SIZE;
> +
> +	dump_hdr = (struct qca_dump_hdr *)sk_ptr;
> +	if ((sk_len < offsetof(struct qca_dump_hdr, data))
> +		|| (dump_hdr->vse_class != QCA_MEMDUMP_VSE_CLASS)
> +	    || (dump_hdr->msg_type != QCA_MEMDUMP_MSG_TYPE))
> +		return false;
> +
> +	return true;
> +}

Add a blank line here?

>   static int btusb_recv_acl_qca(struct hci_dev *hdev, struct sk_buff *skb)
>   {
> -	if (handle_dump_pkt_qca(hdev, skb))
> -		return 0;
> +	if (is_dump_pkt_qca(hdev, skb))
> +		return handle_dump_pkt_qca(hdev, skb);
>   	return hci_recv_frame(hdev, skb);
>   }
>   
>   static int btusb_recv_evt_qca(struct hci_dev *hdev, struct sk_buff *skb)
>   {
> -	if (handle_dump_pkt_qca(hdev, skb))
> -		return 0;
> +	if (is_dump_pkt_qca(hdev, skb))
> +		return handle_dump_pkt_qca(hdev, skb);
>   	return hci_recv_frame(hdev, skb);
>   }

The rest looks good.


Kind regards,

Paul
