Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA25C433DB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Dec 2020 06:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EA6F20449
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Dec 2020 06:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbgLWGWu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Dec 2020 01:22:50 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:55596 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbgLWGWu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Dec 2020 01:22:50 -0500
Received: from [172.20.10.2] (tmo-108-60.customers.d1-online.com [80.187.108.60])
        by mail.holtmann.org (Postfix) with ESMTPSA id 63BB2CECD2;
        Wed, 23 Dec 2020 07:29:25 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.40.0.2.32\))
Subject: Re: [PATCH] Bluetooth: btrtl: Add null check in setup
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20201222184753.1.I9438ef1f79fa1132e74c67b489123291080b9a8c@changeid>
Date:   Wed, 23 Dec 2020 07:22:06 +0100
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Daniel Winkler <danielwinkler@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Transfer-Encoding: 7bit
Message-Id: <2CD614F7-0E7D-4BC2-AF81-50A1962DC760@holtmann.org>
References: <20201222184753.1.I9438ef1f79fa1132e74c67b489123291080b9a8c@changeid>
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
X-Mailer: Apple Mail (2.3654.40.0.2.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Abhishek,

> btrtl_dev->ic_info is only available from the controller on cold boot
> (the lmp subversion matches the device model and this is used to look up
> the ic_info). On warm boots (firmware already loaded),
> btrtl_dev->ic_info is null.
> 
> Fixes: 05672a2c14a4 (Bluetooth: btrtl: Enable central-peripheral role)
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> ---
> 
> drivers/bluetooth/btrtl.c | 23 +++++++++++++----------
> 1 file changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> index 1abf6a4d672734f..978f3c773856b05 100644
> --- a/drivers/bluetooth/btrtl.c
> +++ b/drivers/bluetooth/btrtl.c
> @@ -719,16 +719,19 @@ int btrtl_setup_realtek(struct hci_dev *hdev)
> 	 */
> 	set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
> 
> -	/* Enable central-peripheral role (able to create new connections with
> -	 * an existing connection in slave role).
> -	 */
> -	switch (btrtl_dev->ic_info->lmp_subver) {
> -	case RTL_ROM_LMP_8822B:
> -		set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
> -		break;
> -	default:
> -		rtl_dev_dbg(hdev, "Central-peripheral role not enabled.");
> -		break;
> +	if (btrtl_dev->ic_info) {
> +		/* Enable central-peripheral role (able to create new
> +		 * connections with an existing connection in slave role).
> +		 */
> +		switch (btrtl_dev->ic_info->lmp_subver) {
> +		case RTL_ROM_LMP_8822B:
> +			set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
> +			break;
> +		default:
> +			rtl_dev_dbg(hdev,
> +				    "Central-peripheral role not enabled.");
> +			break;
> +		}
> 	}


	if (!btrtl_dev->ic_info)
		goto done;

> 
> 	btrtl_free(btrtl_dev);

Regards

Marcel

