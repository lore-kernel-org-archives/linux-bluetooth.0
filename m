Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2212013FEE;
	Tue,  7 Oct 2025 16:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759853798; cv=none; b=sscJLI1+hdCRw7EzyRDunrYX0TK0jGfPLP4ZgBvSOzLPup9NbVSUvk6vuZQ3i7wcfztVJKbH+MDaDI7/WllgeAWRwh9MGFtX0Tla1DES1hBMeyAaAJdXNUrBKmwJ1De2QRC7uTmEdRw+zvfaLjGBkcJzibbSOhkXlV2OHskXsqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759853798; c=relaxed/simple;
	bh=RW3CmbJB3FsnKhjV2vpj9diarNh4oefsbTL08hP5j1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T7pNGCOumDbk2QgAS1jjS/z5XU7qQLJSCTk7IiuGRjuGokZUBCq2mPpbTXZrC48yAtIbMuyeMjrdFTj2pQ/d3MldHsLR60VdZvNdpGnhSIUkHHuF3aFHqigpW+P5ziuNlF+cQRv3cwjUDwW8ZN06959iCXCDab3xJl6kzB/mLHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.5] (ip5f5af0e1.dynamic.kabel-deutschland.de [95.90.240.225])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 011E76028F369;
	Tue, 07 Oct 2025 18:16:21 +0200 (CEST)
Message-ID: <a91cf69c-e9d9-40b6-9bba-0308855c3014@molgen.mpg.de>
Date: Tue, 7 Oct 2025 18:16:19 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] Bluetooth: btusb: Reclassify Qualcomm WCN6855
 debug packets
To: Pascal Giard <evilynux@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 Pascal Giard <pascal.giard@etsmtl.ca>
References: <20251007153315.72565-1-pascal.giard@etsmtl.ca>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20251007153315.72565-1-pascal.giard@etsmtl.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Pascal,


Thank you for your patch.

Am 07.10.25 um 17:33 schrieb Pascal Giard:
> Some Qualcomm Bluetooth controllers, e.g., QCNFA765 with WCN6855
> chip, send debug packets as ACL frames with header 0x2EDC.
> The kernel misinterprets these as malformed ACL packets, causing
> repeated errors:
> 
>    Bluetooth: hci0: ACL packet for unknown connection handle 3804
> 
> This can occur hundreds of times per minute, greatly cluttering logs.
> On my computer, I am observing approximately 7 messages per second
> when streaming audio to a speaker.
> 
> For Qualcomm controllers exchanging over UART, hci_qca.c already
> filters out these debug packets. This patch is for controllers
> not going through UART, but USB.
> 
> This patch uses the classify_pkt_type callback to reclassify the
> packets with handle 0x2EDC as HCI_DIAG_PKT before they reach the
> HCI layer. This change is only applied to Qualcomm devices marked
> as BTUSB_QCA_WCN6855.
> 
> Tested on: Thinkpad T14 gen2 (AMD) with QCNFA765 (0489:E0D0)
> Signed-off-by: Pascal Giard <pascal.giard@etsmtl.ca>
> ---
> Changes in v2:
> - Address reviewer feedback about 0x2EDC being a valid HCI handle
> - Use classify_pkt_type callback instead of filtering in recv_acl
> - Only apply to devices with BTUSB_QCA_WCN6855 quirk

Outstanding commit message!

> ---
>   drivers/bluetooth/btusb.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 5e9ebf0c5312..256179ace853 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -1131,6 +1131,24 @@ static void btusb_qca_reset(struct hci_dev *hdev)
>   	btusb_reset(hdev);
>   }
>   
> +static u8 btusb_classify_qca_pkt_type(struct hci_dev *hdev, struct sk_buff *skb)
> +{
> +	/* Some Qualcomm controllers, e.g., QCNFA765 with WCN6855 chip, send debug
> +	 * packets as ACL frames with connection handle 0x2EDC. These are not real
> +	 * ACL packets and should be reclassified as HCI_DIAG_PKT to prevent
> +	 * "ACL packet for unknown connection handle 3804" errors.
> +	 */
> +	if (skb->len >= 2) {
> +		u16 handle = get_unaligned_le16(skb->data);
> +
> +		if (handle == 0x2EDC)
> +			return HCI_DIAG_PKT;
> +	}
> +
> +	/* Use default packet type for other packets */
> +	return hci_skb_pkt_type(skb);
> +}
> +
>   static inline void btusb_free_frags(struct btusb_data *data)
>   {
>   	unsigned long flags;
> @@ -4201,6 +4219,7 @@ static int btusb_probe(struct usb_interface *intf,
>   		data->recv_acl = btusb_recv_acl_qca;
>   		hci_devcd_register(hdev, btusb_coredump_qca, btusb_dump_hdr_qca, NULL);
>   		data->setup_on_usb = btusb_setup_qca;
> +		hdev->classify_pkt_type = btusb_classify_qca_pkt_type;
>   		hdev->shutdown = btusb_shutdown_qca;
>   		hdev->set_bdaddr = btusb_set_bdaddr_wcn6855;
>   		hdev->reset = btusb_qca_reset;

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
