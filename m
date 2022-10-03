Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEFCC433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Oct 2022 15:15:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbiJCPPG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 3 Oct 2022 11:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiJCPPE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 3 Oct 2022 11:15:04 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B770B48B
        for <linux-bluetooth@vger.kernel.org>; Mon,  3 Oct 2022 08:15:01 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5aeede.dynamic.kabel-deutschland.de [95.90.238.222])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 74CF461EA192A;
        Mon,  3 Oct 2022 17:14:58 +0200 (CEST)
Message-ID: <f083fce1-7ad3-0c5c-843a-3e14eb7ff4d6@molgen.mpg.de>
Date:   Mon, 3 Oct 2022 17:14:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [RFC PATCH] Bluetooth: Add a workaround for SCO over USB HCI
 design defect
To:     Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
References: <20221003142558.17914-1-nicolas.cavallari@green-communications.fr>
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
In-Reply-To: <20221003142558.17914-1-nicolas.cavallari@green-communications.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Nicolas,


Thank you for the patch. Just a small suggestion to make the 
summary/title shorter:

Work around SCO over USB HCI design defect

Am 03.10.22 um 16:25 schrieb Nicolas Cavallari:
> The USB interface between the host and the bluetooth adapter used for
> SCO packets uses an USB isochronous endpoint with a fragmentation scheme
> that does not tolerate errors.  Except USB isochronous transfers do
> not provide a reliable stream with guaranteed delivery (There is no
> retry on error, see USB spec v2.0 5.6 and 8.5.5).

I’d put the dot/period after delivery, and inside the brackets after 8.5.5.

> To fragment a packet, the bluetooth HCI simply split it in parts and

split*s*

> transfer them as-is.  The receiver is expected to reconstruct the packet
> by assuming the first fragment contains the header and parsing its size
> field.  There is no error detection either.
> 
> If a fragment is lost, the end result is that the kernel is no longer
> synchronized and will pass malformed data to the upper layers, since it
> has no way to tell if the first fragment is an actual first fragment or
> a continuation fragment.  Resynchronization can only happen by luck and
> requires an unbounded amount of time.
> 
> The typical symptom for a HSP/HFP bluetooth headset is that the
> microphone stops working and dmesg contains piles of rate-limited
> "Bluetooth: hci0: SCO packet for unknown connection handle XXXX"
> errors for an undeterminate amount of time, until the kernel accidently

indeterminate, accidentally

> resynchronize.
> 
> A workaround is to ask the upper layer to prevalidate the first fragment
> header.  This is not possible with user channels so this workaround is
> disabled in this case.

Please document your test setup.

Please excuse my ignorance, but I have a few more questions:

1.  Does that also happen with Android?
2.  Is it possible to reproduce in QEMU for example?


Kind regards,

Paul


> Signed-off-by: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
> ---
>   drivers/bluetooth/btusb.c        |  7 +++++--
>   include/net/bluetooth/hci_core.h | 20 ++++++++++++++++++++
>   2 files changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 15caa6469538..f6256af98233 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -980,9 +980,12 @@ static int btusb_recv_isoc(struct btusb_data *data, void *buffer, int count)
>   
>   		if (skb->len == HCI_SCO_HDR_SIZE) {
>   			/* Complete SCO header */
> -			hci_skb_expect(skb) = hci_sco_hdr(skb)->dlen;
> +			struct hci_sco_hdr *hdr = hci_sco_hdr(skb);
>   
> -			if (skb_tailroom(skb) < hci_skb_expect(skb)) {
> +			hci_skb_expect(skb) = hdr->dlen;
> +
> +			if (skb_tailroom(skb) < hci_skb_expect(skb) ||
> +			    !hci_conn_prevalidate_sco_hdr(data->hdev, hdr)) {
>   				kfree_skb(skb);
>   				skb = NULL;
>   
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index e7862903187d..d589b54e89e6 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1286,6 +1286,26 @@ static inline struct hci_conn *hci_lookup_le_connect(struct hci_dev *hdev)
>   	return NULL;
>   }
>   
> +static inline bool hci_conn_prevalidate_sco_hdr(struct hci_dev *hdev,
> +						struct hci_sco_hdr *hdr)
> +{
> +	__u16 handle;
> +
> +	if (hci_dev_test_flag(hdev, HCI_USER_CHANNEL))
> +		// Can't validate, userspace controls everything.
> +		return true;
> +
> +	handle = hci_handle(__le16_to_cpu(hdr->handle));
> +
> +	switch (hci_conn_lookup_type(hdev, handle)) {
> +	case SCO_LINK:
> +	case ESCO_LINK:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
>   int hci_disconnect(struct hci_conn *conn, __u8 reason);
>   bool hci_setup_sync(struct hci_conn *conn, __u16 handle);
>   void hci_sco_setup(struct hci_conn *conn, __u8 status);
