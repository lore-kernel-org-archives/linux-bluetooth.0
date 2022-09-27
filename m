Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30592C54EE9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Sep 2022 21:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbiI0Vkm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Sep 2022 17:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbiI0Vkj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Sep 2022 17:40:39 -0400
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [IPv6:2001:4b98:dc4:8::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A5C42AC0
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Sep 2022 14:40:37 -0700 (PDT)
Received: (Authenticated sender: david@beinder.at)
        by mail.gandi.net (Postfix) with ESMTPSA id B26DE200002;
        Tue, 27 Sep 2022 21:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=beinder.at; s=gm1;
        t=1664314836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=62/P9GafbAKMBLYOB9Q+s+PkUfeNdTj/8LGCNLYzpQc=;
        b=fiGJWD2vtLdOKFjgtNtGRC5P37n7+39ofaiZStfbahybDiR2Fh1xpu0zCS8TOAwqil0DzV
        yv3yhK4cjXmbXhjRc2Fr6FgGllM8Y/HS6U7A1JFKkBxrI/RVW6G2Fw99qoRhP097/eCU3t
        yc6oEA6Gc28SNrqh2ZDl6GogU1ew13SmLp37g0FBsUjgZjm/qZTwZ5uSfO6Wj4XhSW2j55
        CmEiSH9pJ17eLw8VezHsC7WgJ/r84PpvL1xvXZBvzLr52cDl3ZgbShnODS9uf8fYLAS0Q0
        ADjDCuJn/NTzadP4yowpgB5LxQ2UL32hzpIpDsh+hDvFx2kZobOJk/z7Qe3g5A==
Message-ID: <c7271a1e-05d8-5806-398a-7141194d3697@beinder.at>
Date:   Tue, 27 Sep 2022 23:40:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] Bluetooth: hci_core: Fix not handling link timeouts
 propertly
Content-Language: en-US
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
References: <20220926225107.3226470-1-luiz.dentz@gmail.com>
From:   David Beinder <david@beinder.at>
In-Reply-To: <20220926225107.3226470-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 2022-09-27 00:51, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> Change that introduced the use of __check_timeout did not account for
> link types properly, it always assumes ACL_LINK is used thus causing
> hdev->acl_last_tx to be used even in case of LE_LINK and then again
> uses ACL_LINK with hci_link_tx_to.
>
> To fix this __check_timeout now takes the link type as parameter and
> then procedure to use the right last_tx based on the link type and pass
> it to hci_link_tx_to.
>
> Fixes: 1b1d29e51499 ("Bluetooth: Make use of __check_timeout on hci_sched_le")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Tested-by: David Beinder <david@beinder.at>

Patch tested on 5.10.136-cip14 (sunxi / armv7l), with a RTL8821CU 
adapter in LE-only mode. Spurious "link tx timeout" errors during LE 
data transfers are now gone.

> ---
>   net/bluetooth/hci_core.c | 34 +++++++++++++++++++++++-----------
>   1 file changed, 23 insertions(+), 11 deletions(-)
>
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 66c7cdba0d32..063fbb8e07ca 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -3485,15 +3485,27 @@ static inline int __get_blocks(struct hci_dev *hdev, struct sk_buff *skb)
>   	return DIV_ROUND_UP(skb->len - HCI_ACL_HDR_SIZE, hdev->block_len);
>   }
>   
> -static void __check_timeout(struct hci_dev *hdev, unsigned int cnt)
> +static void __check_timeout(struct hci_dev *hdev, unsigned int cnt, u8 type)
>   {
> -	if (!hci_dev_test_flag(hdev, HCI_UNCONFIGURED)) {
> -		/* ACL tx timeout must be longer than maximum
> -		 * link supervision timeout (40.9 seconds) */
> -		if (!cnt && time_after(jiffies, hdev->acl_last_tx +
> -				       HCI_ACL_TX_TIMEOUT))
> -			hci_link_tx_to(hdev, ACL_LINK);
> +	unsigned long last_tx;
> +
> +	if (hci_dev_test_flag(hdev, HCI_UNCONFIGURED))
> +		return;
> +
> +	switch (type) {
> +	case LE_LINK:
> +		last_tx = hdev->le_last_tx;
> +		break;
> +	default:
> +		last_tx = hdev->acl_last_tx;
> +		break;
>   	}
> +
> +	/* tx timeout must be longer than maximum link supervision timeout
> +	 * (40.9 seconds)
> +	 */
> +	if (!cnt && time_after(jiffies, last_tx + HCI_ACL_TX_TIMEOUT))
> +		hci_link_tx_to(hdev, type);
>   }
>   
>   /* Schedule SCO */
> @@ -3551,7 +3563,7 @@ static void hci_sched_acl_pkt(struct hci_dev *hdev)
>   	struct sk_buff *skb;
>   	int quote;
>   
> -	__check_timeout(hdev, cnt);
> +	__check_timeout(hdev, cnt, ACL_LINK);
>   
>   	while (hdev->acl_cnt &&
>   	       (chan = hci_chan_sent(hdev, ACL_LINK, &quote))) {
> @@ -3594,8 +3606,6 @@ static void hci_sched_acl_blk(struct hci_dev *hdev)
>   	int quote;
>   	u8 type;
>   
> -	__check_timeout(hdev, cnt);
> -
>   	BT_DBG("%s", hdev->name);
>   
>   	if (hdev->dev_type == HCI_AMP)
> @@ -3603,6 +3613,8 @@ static void hci_sched_acl_blk(struct hci_dev *hdev)
>   	else
>   		type = ACL_LINK;
>   
> +	__check_timeout(hdev, cnt, type);
> +
>   	while (hdev->block_cnt > 0 &&
>   	       (chan = hci_chan_sent(hdev, type, &quote))) {
>   		u32 priority = (skb_peek(&chan->data_q))->priority;
> @@ -3676,7 +3688,7 @@ static void hci_sched_le(struct hci_dev *hdev)
>   
>   	cnt = hdev->le_pkts ? hdev->le_cnt : hdev->acl_cnt;
>   
> -	__check_timeout(hdev, cnt);
> +	__check_timeout(hdev, cnt, LE_LINK);
>   
>   	tmp = cnt;
>   	while (cnt && (chan = hci_chan_sent(hdev, LE_LINK, &quote))) {
