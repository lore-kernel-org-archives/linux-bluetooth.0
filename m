Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FFC1474B8;
	Tue,  6 May 2025 08:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746521195; cv=none; b=ELze8D3bpm18Dj/pwKod1RLNT/7VbMZ+oe/8r42vepLZg4H92r1uSFPS3ejOqE094JUqEGtZMUdm4eUx5aVTqzohXJhjJ4JUr4eVdOShOFexuzvejbofRJA0DYSqwOWpj7MqstpFYKcBw9D0EZ6k5lkwYXLznki60c3PP+O5L78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746521195; c=relaxed/simple;
	bh=PVPsgcOG043Kdu+Dupo7Lq60xO+Aootenjj+ovUQstY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=enf5d9ffHvy7rNxhpTrgch9yfG7pEkG47xlTSjFz4ydCsyjDqxv5yiysWJHMgOZML3qxrsbIGVd5i8CSh5Iy4K/jL8oxqVHMAuyowjtJsB691jIqE68viDBXZHpOKFLkeH8R6avuBcJdM9TYbvv8GdvtVUnU0kEw8u54phNx9hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.36] (g36.guest.molgen.mpg.de [141.14.220.36])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id EA09A61EA193D;
	Tue, 06 May 2025 10:46:13 +0200 (CEST)
Message-ID: <aa095579-84d3-4157-91fc-23613ae30448@molgen.mpg.de>
Date: Tue, 6 May 2025 10:46:13 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btusb: use skb_pull to avoid unsafe access in
 QCA dump handling
To: En-Wei Wu <en-wei.wu@canonical.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_tjiang@quicinc.com
References: <20250506024822.327776-1-en-wei.wu@canonical.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250506024822.327776-1-en-wei.wu@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear En-Wei,


Thank you for your patch.

Am 06.05.25 um 04:48 schrieb En-Wei Wu:
> Use skb_pull() and skb_pull_data() to safely parse QCA dump packets.
> 
> This avoids direct pointer math on skb->data, which could lead to
> invalid access if the packet is shorter than expected.

Please add a Fixes: tag.

Also, how did you test this?

> Signed-off-by: En-Wei Wu <en-wei.wu@canonical.com>
> ---
>   drivers/bluetooth/btusb.c | 99 ++++++++++++++++-----------------------
>   1 file changed, 41 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 357b18dae8de..17136924a278 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2979,9 +2979,8 @@ static void btusb_coredump_qca(struct hci_dev *hdev)
>   static int handle_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb)
>   {
>   	int ret = 0;
> +	int skip = 0;

`unsigned int`, as the signature is:

     include/linux/skbuff.h:void *skb_pull(struct sk_buff *skb, unsigned 
int len);

>   	u8 pkt_type;
> -	u8 *sk_ptr;
> -	unsigned int sk_len;
>   	u16 seqno;
>   	u32 dump_size;
>   
> @@ -2990,18 +2989,14 @@ static int handle_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb)
>   	struct usb_device *udev = btdata->udev;
>   
>   	pkt_type = hci_skb_pkt_type(skb);
> -	sk_ptr = skb->data;
> -	sk_len = skb->len;
> -
> -	if (pkt_type == HCI_ACLDATA_PKT) {
> -		sk_ptr += HCI_ACL_HDR_SIZE;
> -		sk_len -= HCI_ACL_HDR_SIZE;
> -	}
> +	if (pkt_type == HCI_ACLDATA_PKT)
> +		skip = sizeof(struct hci_acl_hdr) + sizeof(struct hci_event_hdr);
> +	else
> +		skip = sizeof(struct hci_event_hdr);

Maybe write it as below:

     skip = sizeof(struct hci_event_hdr);

     if (pkt_type == HCI_ACLDATA_PKT)
     	skip += sizeof(struct hci_acl_hdr);


Kind regards,

Paul


>   
> -	sk_ptr += HCI_EVENT_HDR_SIZE;
> -	sk_len -= HCI_EVENT_HDR_SIZE;
> +	skb_pull(skb, skip);
> +	dump_hdr = (struct qca_dump_hdr *)skb->data;
>   
> -	dump_hdr = (struct qca_dump_hdr *)sk_ptr;
>   	seqno = le16_to_cpu(dump_hdr->seqno);
>   	if (seqno == 0) {
>   		set_bit(BTUSB_HW_SSR_ACTIVE, &btdata->flags);
> @@ -3021,16 +3016,15 @@ static int handle_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb)
>   
>   		btdata->qca_dump.ram_dump_size = dump_size;
>   		btdata->qca_dump.ram_dump_seqno = 0;
> -		sk_ptr += offsetof(struct qca_dump_hdr, data0);
> -		sk_len -= offsetof(struct qca_dump_hdr, data0);
> +
> +		skb_pull(skb, offsetof(struct qca_dump_hdr, data0));
>   
>   		usb_disable_autosuspend(udev);
>   		bt_dev_info(hdev, "%s memdump size(%u)\n",
>   			    (pkt_type == HCI_ACLDATA_PKT) ? "ACL" : "event",
>   			    dump_size);
>   	} else {
> -		sk_ptr += offsetof(struct qca_dump_hdr, data);
> -		sk_len -= offsetof(struct qca_dump_hdr, data);
> +		skb_pull(skb, offsetof(struct qca_dump_hdr, data));
>   	}
>   
>   	if (!btdata->qca_dump.ram_dump_size) {
> @@ -3050,7 +3044,6 @@ static int handle_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb)
>   		return ret;
>   	}
>   
> -	skb_pull(skb, skb->len - sk_len);
>   	hci_devcd_append(hdev, skb);
>   	btdata->qca_dump.ram_dump_seqno++;
>   	if (seqno == QCA_LAST_SEQUENCE_NUM) {
> @@ -3078,68 +3071,58 @@ static int handle_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb)
>   /* Return: true if the ACL packet is a dump packet, false otherwise. */
>   static bool acl_pkt_is_dump_qca(struct hci_dev *hdev, struct sk_buff *skb)
>   {
> -	u8 *sk_ptr;
> -	unsigned int sk_len;
> -
>   	struct hci_event_hdr *event_hdr;
>   	struct hci_acl_hdr *acl_hdr;
>   	struct qca_dump_hdr *dump_hdr;
> +	struct sk_buff *clone = skb_clone(skb, GFP_ATOMIC);
> +	bool is_dump = false;
>   
> -	sk_ptr = skb->data;
> -	sk_len = skb->len;
> -
> -	acl_hdr = hci_acl_hdr(skb);
> -	if (le16_to_cpu(acl_hdr->handle) != QCA_MEMDUMP_ACL_HANDLE)
> +	if (!clone)
>   		return false;
>   
> -	sk_ptr += HCI_ACL_HDR_SIZE;
> -	sk_len -= HCI_ACL_HDR_SIZE;
> -	event_hdr = (struct hci_event_hdr *)sk_ptr;
> -
> -	if ((event_hdr->evt != HCI_VENDOR_PKT) ||
> -	    (event_hdr->plen != (sk_len - HCI_EVENT_HDR_SIZE)))
> -		return false;
> +	acl_hdr = skb_pull_data(clone, sizeof(*acl_hdr));
> +	if (!acl_hdr || (le16_to_cpu(acl_hdr->handle) != QCA_MEMDUMP_ACL_HANDLE))
> +		goto out;
>   
> -	sk_ptr += HCI_EVENT_HDR_SIZE;
> -	sk_len -= HCI_EVENT_HDR_SIZE;
> +	event_hdr = skb_pull_data(clone, sizeof(*event_hdr));
> +	if (!event_hdr || (event_hdr->evt != HCI_VENDOR_PKT))
> +		goto out;
>   
> -	dump_hdr = (struct qca_dump_hdr *)sk_ptr;
> -	if ((sk_len < offsetof(struct qca_dump_hdr, data)) ||
> -	    (dump_hdr->vse_class != QCA_MEMDUMP_VSE_CLASS) ||
> -	    (dump_hdr->msg_type != QCA_MEMDUMP_MSG_TYPE))
> -		return false;
> +	dump_hdr = skb_pull_data(clone, sizeof(*dump_hdr));
> +	if (!dump_hdr || (dump_hdr->vse_class != QCA_MEMDUMP_VSE_CLASS) ||
> +	   (dump_hdr->msg_type != QCA_MEMDUMP_MSG_TYPE))
> +		goto out;
>   
> -	return true;
> +	is_dump = true;
> +out:
> +	consume_skb(clone);
> +	return is_dump;
>   }
>   
>   /* Return: true if the event packet is a dump packet, false otherwise. */
>   static bool evt_pkt_is_dump_qca(struct hci_dev *hdev, struct sk_buff *skb)
>   {
> -	u8 *sk_ptr;
> -	unsigned int sk_len;
> -
>   	struct hci_event_hdr *event_hdr;
>   	struct qca_dump_hdr *dump_hdr;
> +	struct sk_buff *clone = skb_clone(skb, GFP_ATOMIC);
> +	bool is_dump = false;
>   
> -	sk_ptr = skb->data;
> -	sk_len = skb->len;
> -
> -	event_hdr = hci_event_hdr(skb);
> -
> -	if ((event_hdr->evt != HCI_VENDOR_PKT)
> -	    || (event_hdr->plen != (sk_len - HCI_EVENT_HDR_SIZE)))
> +	if (!clone)
>   		return false;
>   
> -	sk_ptr += HCI_EVENT_HDR_SIZE;
> -	sk_len -= HCI_EVENT_HDR_SIZE;
> +	event_hdr = skb_pull_data(clone, sizeof(*event_hdr));
> +	if (!event_hdr || (event_hdr->evt != HCI_VENDOR_PKT))
> +		goto out;
>   
> -	dump_hdr = (struct qca_dump_hdr *)sk_ptr;
> -	if ((sk_len < offsetof(struct qca_dump_hdr, data)) ||
> -	    (dump_hdr->vse_class != QCA_MEMDUMP_VSE_CLASS) ||
> -	    (dump_hdr->msg_type != QCA_MEMDUMP_MSG_TYPE))
> -		return false;
> +	dump_hdr = skb_pull_data(clone, sizeof(*dump_hdr));
> +	if (!dump_hdr || (dump_hdr->vse_class != QCA_MEMDUMP_VSE_CLASS) ||
> +	   (dump_hdr->msg_type != QCA_MEMDUMP_MSG_TYPE))
> +		goto out;
>   
> -	return true;
> +	is_dump = true;
> +out:
> +	consume_skb(clone);
> +	return is_dump;
>   }
>   
>   static int btusb_recv_acl_qca(struct hci_dev *hdev, struct sk_buff *skb)

