Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506EE145B3F;
	Tue,  7 Apr 2026 07:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775546117; cv=none; b=kDNYHmlzG5tp18p0KtxVXCYR1xivrW0m44pKchxanFODHhBLRLnaipz+z8yr6Ctkb0JuNlrJd3g+ENS3GpRB7g8yMMbe6K8MolDDxHHfXiqvtUrBg3Df2doSAjbarz4X9XSlk5dq50ZcDY7PmhzBTgCretxEpW167onD1cn1cXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775546117; c=relaxed/simple;
	bh=lF+ijmtXIsNwy3xPpOBGwdy/F4psjobzs+8c4hB7TW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lALXi6d7x0rk8NQunRvJPUbqjsjQXi0xGIiFor4iB9bSF+upMJfjIy3dxs++3EYPWKpdrxPhKo5ajkoG7E5/5nzdClc2D+PFAlyWciA08xp2oMof6I5NDBu1gTHD9VShAV6HBWJnITE6SKVavuFqqVWz8bUGPQyf7/4iqa0iWRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.44.15] (unknown [185.238.219.34])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 49A204C2C37D7A;
	Tue, 07 Apr 2026 09:14:33 +0200 (CEST)
Message-ID: <abdf652a-f7e1-4641-bfd9-c0cfc20cca6d@molgen.mpg.de>
Date: Tue, 7 Apr 2026 09:14:29 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: btmtk: add event filter to filter specific
 event
To: Chris Lu <chris.lu@mediatek.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Von Dentz <luiz.dentz@gmail.com>, Sean Wang <sean.wang@mediatek.com>,
 Will Lee <will-cy.Lee@mediatek.com>, SS Wu <ss.wu@mediatek.com>,
 Steve Lee <steve.lee@mediatek.com>, linux-bluetooth@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, linux-mediatek@lists.infradead.org
References: <20260407064759.3036650-1-chris.lu@mediatek.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260407064759.3036650-1-chris.lu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Chris,


Thank you for the patch.

Am 07.04.26 um 08:47 schrieb Chris Lu:
> Due to some Bluetooth hosts have mechanism to detect invalid events,
> causing abnormal behavior.

Sorry, this description is much too short and general. Please elaborate, 
and document details.

> Add a event filter to prevent debugging events from being sent to host.

a*n*

What are debugging events, and how can they be detected?

> Signed-off-by: Chris Lu <chris.lu@mediatek.com>

Should there be a Fixes: tag, so it gets backported?

> ---
>   drivers/bluetooth/btmtk.c | 22 ++++++++++++++++++++++
>   drivers/bluetooth/btmtk.h |  7 +++++++
>   drivers/bluetooth/btusb.c |  2 ++
>   3 files changed, 31 insertions(+)
> 
> diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
> index 55516b4602db..302d6ddf9062 100644
> --- a/drivers/bluetooth/btmtk.c
> +++ b/drivers/bluetooth/btmtk.c
> @@ -1503,6 +1503,28 @@ int btmtk_usb_shutdown(struct hci_dev *hdev)
>   	return 0;
>   }
>   EXPORT_SYMBOL_GPL(btmtk_usb_shutdown);
> +
> +int btmtk_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
> +{
> +	struct hci_event_hdr *hdr = (void *)skb->data;
> +
> +	if (hdr->evt == HCI_EV_CMD_COMPLETE) {
> +		struct hci_ev_cmd_complete *ec;
> +		u16 opcode;
> +
> +		ec = (void *)(skb->data + HCI_EVENT_HDR_SIZE);
> +		opcode = __le16_to_cpu(ec->opcode);
> +
> +		/* Filter vendor opcode */
> +		if (opcode == 0xfc5d) {
> +			kfree_skb(skb);
> +			return 0;
> +		}
> +	}
> +
> +	return hci_recv_frame(hdev, skb);
> +}
> +EXPORT_SYMBOL_GPL(btmtk_recv_event);
>   #endif
>   
>   MODULE_AUTHOR("Sean Wang <sean.wang@mediatek.com>");
> diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
> index adaf385626ee..08b73927c8f3 100644
> --- a/drivers/bluetooth/btmtk.h
> +++ b/drivers/bluetooth/btmtk.h
> @@ -218,6 +218,8 @@ int btmtk_usb_suspend(struct hci_dev *hdev);
>   int btmtk_usb_setup(struct hci_dev *hdev);
>   
>   int btmtk_usb_shutdown(struct hci_dev *hdev);
> +
> +int btmtk_recv_event(struct hci_dev *hdev, struct sk_buff *skb);
>   #else
>   
>   static inline int btmtk_set_bdaddr(struct hci_dev *hdev,
> @@ -296,4 +298,9 @@ static inline int btmtk_usb_shutdown(struct hci_dev *hdev)
>   {
>   	return -EOPNOTSUPP;
>   }
> +
> +static inline int btmtk_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
> +{
> +	return -EOPNOTSUPP;
> +}
>   #endif
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index f9d515ee9124..daf8a387e660 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -4150,6 +4150,8 @@ static int btusb_probe(struct usb_interface *intf,
>   	} else if (id->driver_info & BTUSB_MEDIATEK) {
>   		/* Allocate extra space for Mediatek device */
>   		priv_size += sizeof(struct btmtk_data);
> +
> +		data->recv_event = btmtk_recv_event;
>   	}
>   
>   	data->recv_acl = hci_recv_frame;


Kind regards,

Paul
