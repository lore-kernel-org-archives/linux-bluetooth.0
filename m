Return-Path: <SRS0=Uimr=AD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15F8C433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Jun 2020 07:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 832B4248F2
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Jun 2020 07:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731307AbgFVHHU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Jun 2020 03:07:20 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:60967 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731258AbgFVHHU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Jun 2020 03:07:20 -0400
Received: from marcel-macpro.fritz.box (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id 3D3F5CED25;
        Mon, 22 Jun 2020 09:17:11 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v2] Bluetooth: use configured params for ext adv
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200622021457.156164-1-alainm@chromium.org>
Date:   Mon, 22 Jun 2020 09:07:18 +0200
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Daniel Winkler <danielwinkler@google.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <553474FF-CA57-4506-84E7-3F2EC7174503@holtmann.org>
References: <20200622021457.156164-1-alainm@chromium.org>
To:     Alain Michaud <alainm@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

> When the extended advertisement feature is enabled, a hardcoded min and
> max interval of 0x8000 is used.  This patch fixes this issue by using
> the configured min/max value.
> 
> This was validated by setting min/max in main.conf and making sure the
> right setting is applied:
> 
> < HCI Command: LE Set Extended Advertising Parameters (0x08|0x0036) plen
> 25                                          #93 [hci0] 10.953011
> …
> Min advertising interval: 181.250 msec (0x0122)
> Max advertising interval: 181.250 msec (0x0122)
> …
> 
> Signed-off-by: Alain Michaud <alainm@chromium.org>
> Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> Reviewed-by: Daniel Winkler <danielwinkler@google.com>
> 
> ---
> 
> Changes in v2:
> -fix commit title and typo in description.
> -Moved le24 convertion to  hci_cpu_to_le24
> 
> include/net/bluetooth/hci.h | 8 ++++++++
> net/bluetooth/hci_request.c | 6 ++----
> 2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 16ab6ce87883..1f18f71363e9 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -2516,4 +2516,12 @@ static inline struct hci_sco_hdr *hci_sco_hdr(const struct sk_buff *skb)
> #define hci_iso_data_len(h)		((h) & 0x3fff)
> #define hci_iso_data_flags(h)		((h) >> 14)
> 
> +/* le24 support */
> +static inline void hci_cpu_to_le24(__u32 val, __u8 dst[3])
> +{
> +	dst[0] = val & 0xff;
> +	dst[1] = (val & 0xff00) >> 8;
> +	dst[2] = (val & 0xff0000) >> 16;
> +}
> +
> #endif /* __HCI_H */
> diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
> index 29decd7e8051..9301c1d54936 100644
> --- a/net/bluetooth/hci_request.c
> +++ b/net/bluetooth/hci_request.c
> @@ -1799,8 +1799,6 @@ int __hci_req_setup_ext_adv_instance(struct hci_request *req, u8 instance)
> 	int err;
> 	struct adv_info *adv_instance;
> 	bool secondary_adv;
> -	/* In ext adv set param interval is 3 octets */
> -	const u8 adv_interval[3] = { 0x00, 0x08, 0x00 };
> 
> 	if (instance > 0) {
> 		adv_instance = hci_find_adv_instance(hdev, instance);
> @@ -1833,8 +1831,8 @@ int __hci_req_setup_ext_adv_instance(struct hci_request *req, u8 instance)
> 
> 	memset(&cp, 0, sizeof(cp));
> 
> -	memcpy(cp.min_interval, adv_interval, sizeof(cp.min_interval));
> -	memcpy(cp.max_interval, adv_interval, sizeof(cp.max_interval));

please add the comment from above here. The le24 might be obvious, but I think it is still a good comment to remind ourselves later.

> +	hci_cpu_to_le24(hdev->le_adv_min_interval, cp.min_interval);
> +	hci_cpu_to_le24(hdev->le_adv_max_interval, cp.max_interval);

Regards

Marcel

