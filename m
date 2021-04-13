Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E2FC433B4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Apr 2021 19:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1AE761249
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Apr 2021 19:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbhDMTO7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 13 Apr 2021 15:14:59 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:49980 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbhDMTO5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 13 Apr 2021 15:14:57 -0400
Received: from marcel-macbook.holtmann.net (p5b3d235a.dip0.t-ipconnect.de [91.61.35.90])
        by mail.holtmann.org (Postfix) with ESMTPSA id 7E41ACECCD;
        Tue, 13 Apr 2021 21:22:18 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH v2 1/3] Bluetooth: add support to enumerate codec
 capabilities
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210412083538.18600-1-kiran.k@intel.com>
Date:   Tue, 13 Apr 2021 21:14:33 +0200
Cc:     "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <3434AC21-8C36-435D-9D0F-3597FE434D54@holtmann.org>
References: <20210412083538.18600-1-kiran.k@intel.com>
To:     Kiran K <kiran.k@intel.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran,

> add support to enumerate local supported codec capabilities
> 
> < HCI Command: Read Local Suppor.. (0x04|0x000e) plen 7
>        Codec: mSBC (0x05)
>        Logical Transport Type: 0x00
>        Direction: Input (Host to Controller) (0x00)
>> HCI Event: Command Complete (0x0e) plen 12
>      Read Local Supported Codec Capabilities (0x04|0x000e) ncmd 1
>        Status: Success (0x00)
>        Number of codec capabilities: 1
>         Capabilities #0:
>        00 00 11 15 02 33
> 
> Signed-off-by: Kiran K <kiran.k@intel.com>
> Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> Signed-off-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
> ---
> * changes in v2
>  add skb->len check before accessing event data
> 
> include/net/bluetooth/hci.h |  7 ++++
> net/bluetooth/hci_event.c   | 68 +++++++++++++++++++++++++++++++++++++
> 2 files changed, 75 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index ea4ae551c426..e3f7771fe84f 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -1314,6 +1314,13 @@ struct hci_rp_read_local_pairing_opts {
> 	__u8     max_key_size;
> } __packed;
> 
> +#define HCI_OP_READ_LOCAL_CODEC_CAPS	0x100e
> +struct hci_op_read_local_codec_caps {
> +	__u8	codec_id[5];
> +	__u8	transport;
> +	__u8	direction;
> +} __packed;
> +
> #define HCI_OP_READ_PAGE_SCAN_ACTIVITY	0x0c1b
> struct hci_rp_read_page_scan_activity {
> 	__u8     status;
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 5e99968939ce..a4b905a76c1b 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -887,6 +887,70 @@ static void hci_cc_read_data_block_size(struct hci_dev *hdev,
> 	       hdev->block_cnt, hdev->block_len);
> }
> 
> +static void hci_cc_read_local_codecs(struct hci_dev *hdev,
> +				     struct sk_buff *skb)
> +{
> +	__u8 num_codecs;
> +	struct hci_op_read_local_codec_caps caps;
> +
> +	if (skb->len < sizeof(caps))
> +		return;
> +
> +	bt_dev_dbg(hdev, "status 0x%2.2x", skb->data[0]);
> +
> +	if (skb->data[0])
> +		return;
> +
> +	/* enumerate standard codecs */
> +	skb_pull(skb, 1);
> +
> +	if (skb->len < 1)
> +		return;
> +
> +	num_codecs = skb->data[0];
> +
> +	bt_dev_dbg(hdev, "Number of standard codecs: %u", num_codecs);
> +
> +	skb_pull(skb, 1);
> +
> +	if (skb->len < num_codecs)
> +		return;
> +
> +	while (num_codecs--) {
> +		caps.codec_id[0] = skb->data[0];
> +		caps.transport = 0x00;
> +		caps.direction = 0x00;
> +
> +		hci_send_cmd(hdev, HCI_OP_READ_LOCAL_CODEC_CAPS, sizeof(caps),
> +			     &caps);
> +
> +		skb_pull(skb, 1);
> +	}
> +
> +	/* enumerate vendor specific codecs */
> +	if (skb->len < 1)
> +		return;
> +
> +	num_codecs = skb->data[0];
> +	skb_pull(skb, 1);
> +
> +	bt_dev_dbg(hdev, "Number of vendor specific codecs: %u", num_codecs);
> +
> +	if (skb->len < (num_codecs * 4))
> +		return;
> +
> +	while (num_codecs--) {
> +		caps.codec_id[0] = 0xFF;
> +		memcpy(&caps.codec_id[1], skb->data, 4);
> +		caps.transport = 0x00;
> +		caps.direction = 0x00;
> +
> +		hci_send_cmd(hdev, HCI_OP_READ_LOCAL_CODEC_CAPS, sizeof(caps),
> +			     &caps);
> +		skb_pull(skb, 4);
> +	}

instead of sending hci_send_cmd here, I rather do this in a separate init stage. Since you want to cache the codec values anyway, start doing it now.

Regards

Marcel

