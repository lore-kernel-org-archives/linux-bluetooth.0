Return-Path: <SRS0=I8IU=AS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FF6C433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jul 2020 06:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C21420578
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jul 2020 06:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgGGGoH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jul 2020 02:44:07 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:43446 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgGGGoH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jul 2020 02:44:07 -0400
Received: from [192.168.1.91] (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id 790BFCECE5;
        Tue,  7 Jul 2020 08:54:02 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v3] Bluetooth: le_simult_central_peripheral experimental
 feature
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200706154449.3828193-1-alainm@chromium.org>
Date:   Tue, 7 Jul 2020 08:43:35 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <0175E6D3-8547-4633-B9A8-2AB15CE25C5B@holtmann.org>
References: <20200706154449.3828193-1-alainm@chromium.org>
To:     Alain Michaud <alainm@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

> This patch adds an le_simult_central_peripheral features which allows a
> clients to determine if the controller is able to support peripheral and
> central connections separately and at the same time.
> 
> Signed-off-by: Alain Michaud <alainm@chromium.org>
> ---
> 
> Changes in v3:
> - Back to the original design of V1 and integrated Marcel's feedback.
> 
> Changes in v2:
> - Slight change of design based on offline feedback
> 
> net/bluetooth/mgmt.c | 24 ++++++++++++++++++++++--
> 1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 5e9b9728eeac..b34e6f3c07ec 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -3753,12 +3753,19 @@ static const u8 debug_uuid[16] = {
> };
> #endif
> 
> +/* 671b10b5-42c0-4696-9227-eb28d1b049d6 */
> +static const u8 le_simult_central_peripheral[16] = {
> +	0xd6, 0x49, 0xb0, 0xd1, 0x28, 0xeb, 0x27, 0x92,
> +	0x96, 0x46, 0xc0, 0x42, 0xb5, 0x10, 0x1b, 0x67,
> +};
> +
> static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
> 				  void *data, u16 data_len)
> {
> -	char buf[42];
> +	char buf[44];
> 	struct mgmt_rp_read_exp_features_info *rp = (void *)buf;
> 	u16 idx = 0;
> +	u32 flags;
> 
> 	bt_dev_dbg(hdev, "sock %p", sk);
> 
> @@ -3766,7 +3773,7 @@ static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
> 
> #ifdef CONFIG_BT_FEATURE_DEBUG
> 	if (!hdev) {
> -		u32 flags = bt_dbg_get() ? BIT(0) : 0;
> +		flags = bt_dbg_get() ? BIT(0) : 0;

I was trying to contain the used variables in the scope here so that we don’t get funny kernel warnings about unused or uninitialized variables when options are not selected and we eventually add more here.

> 
> 		memcpy(rp->features[idx].uuid, debug_uuid, 16);
> 		rp->features[idx].flags = cpu_to_le32(flags);
> @@ -3774,6 +3781,19 @@ static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
> 	}
> #endif
> 
> +	flags = 0;
> +	memcpy(rp->features[idx].uuid, le_simult_central_peripheral,
> +	       sizeof(le_simult_central_peripheral));
> +
> +	if (hdev && test_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks) &&
> +	    (hdev->le_states[4] & 0x08) &&	/* Central */
> +	    (hdev->le_states[4] & 0x40) &&	/* Peripheral */
> +	    (hdev->le_states[3] & 0x10)		/* Simultaneous */)
> +		flags |= BIT(0);
> +
> +	rp->features[idx].flags = cpu_to_le32(flags);
> +	idx++;
> +
> 	rp->feature_count = cpu_to_le16(idx);

You do actually need to wrap this in

	if (hdev) {
	}

so that a) this looks cleanly and b) this is only reported when the <controller-id> is provided.

The experimental feature command is special since it can be used per hdev or globally.

> 
> 	/* After reading the experimental features information, enable
> -- 
> 2.27.0.212.ge8ba1cc988-goog
> 

Regards

Marcel

