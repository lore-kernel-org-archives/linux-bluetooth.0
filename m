Return-Path: <SRS0=y5DB=AA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BECAC433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Jun 2020 07:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CDC02080C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Jun 2020 07:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730880AbgFSHp6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Jun 2020 03:45:58 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:50376 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730830AbgFSHp6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Jun 2020 03:45:58 -0400
Received: from marcel-macbook.fritz.box (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id 08BF4CECF0;
        Fri, 19 Jun 2020 09:55:47 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v1] bluetooth: use configured params for ext adv
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200618210659.142284-1-alainm@chromium.org>
Date:   Fri, 19 Jun 2020 09:45:55 +0200
Cc:     linux-bluetooth@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Daniel Winkler <danielwinkler@google.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <C5D30F5E-B50F-4DE7-A909-F48F6C555661@holtmann.org>
References: <20200618210659.142284-1-alainm@chromium.org>
To:     Alain Michaud <alainm@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

please use “Bluetooth: “ prefix for the subject.

> When the extended advertisement feature is enabled, a hardcoded min and
> max interval of 0x8000 is used.  This patches fixes this issue by using
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
> Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> Reviewed-by: Daniel Winkler <danielwinkler@google.com>
> 
> Signed-off-by: Alain Michaud <alainm@chromium.org>

The Reviewed-by lines go after your Signed-off-by.

> ---
> 
> net/bluetooth/hci_request.c | 10 ++++++----
> 1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
> index 29decd7e8051..08818b9bf89f 100644
> --- a/net/bluetooth/hci_request.c
> +++ b/net/bluetooth/hci_request.c
> @@ -1799,8 +1799,9 @@ int __hci_req_setup_ext_adv_instance(struct hci_request *req, u8 instance)
> 	int err;
> 	struct adv_info *adv_instance;
> 	bool secondary_adv;
> -	/* In ext adv set param interval is 3 octets */
> -	const u8 adv_interval[3] = { 0x00, 0x08, 0x00 };
> +	/* In ext adv set param interval is 3 octets in le format */
> +	const __le32 min_adv_interval = cpu_to_le32(hdev->le_adv_min_interval);
> +	const __le32 max_adv_interval = cpu_to_le32(hdev->le_adv_max_interval);

Scrap the const here.

And it is wrong since your hdev->le_adv_{min,max}_interval is actually __u16. So that first needs to be extended to a __u16 value.

That said, if we have this in the Load Default System Configuration list, we should extended it to __le32 there as well.

> 	if (instance > 0) {
> 		adv_instance = hci_find_adv_instance(hdev, instance);
> @@ -1833,8 +1834,9 @@ int __hci_req_setup_ext_adv_instance(struct hci_request *req, u8 instance)
> 
> 	memset(&cp, 0, sizeof(cp));
> 
> -	memcpy(cp.min_interval, adv_interval, sizeof(cp.min_interval));
> -	memcpy(cp.max_interval, adv_interval, sizeof(cp.max_interval));
> +	/* take least significant 3 bytes */
> +	memcpy(cp.min_interval, &min_adv_interval, sizeof(cp.min_interval));
> +	memcpy(cp.max_interval, &max_adv_interval, sizeof(cp.max_interval));

This is dangerous and I think it actually break in case of unaligned access platforms.

In this case I prefer to actually do this manually.

		/* In ext adv min interval is 3 octets */
		cp.min_interval[0] = cp.min_interval & 0xff;
		cp.min_interval[1] = (cp.min_interval & 0xff00) >> 8;
		cp.min_interval[2] = (cp.min_interval & 0xff0000) >> 12;

Regards

Marcel

