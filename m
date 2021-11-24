Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA8A6C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Nov 2021 15:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234800AbhKXPZe convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 Nov 2021 10:25:34 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:54787 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbhKXPZe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 Nov 2021 10:25:34 -0500
Received: from smtpclient.apple (p5b3d2e91.dip0.t-ipconnect.de [91.61.46.145])
        by mail.holtmann.org (Postfix) with ESMTPSA id BDF77CED24;
        Wed, 24 Nov 2021 16:22:23 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [PATCH v3 1/4] Bluetooth: MGMT: Use
 hci_dev_test_and_{set,clear}_flag
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211120012448.1476960-1-luiz.dentz@gmail.com>
Date:   Wed, 24 Nov 2021 16:22:23 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <317EAEE4-7B9C-4DF6-8968-F93421B85E6F@holtmann.org>
References: <20211120012448.1476960-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This make use of hci_dev_test_and_{set,clear}_flag instead of doing 2
> operations in a row.

I really Fixes: tags for these.

> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> v2: Fix marking Device Privacy Flag even when adapter is not capable of
> handling Set Privacy Mode.
> v3: Add patch for using hci_dev_test_and_{set,clear}_flag and split
> changes reworking how HCI_CONN_FLAG_REMOTE_WAKEUP is set and make use of
> bitmap to store the supported flags.
> 
> net/bluetooth/mgmt.c | 14 +++++++-------
> 1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index f8f74d344297..0f91bf15e260 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -4041,10 +4041,10 @@ static int set_zero_key_func(struct sock *sk, struct hci_dev *hdev,
> #endif
> 
> 	if (hdev && use_ll_privacy(hdev) && !hdev_is_powered(hdev)) {
> -		bool changed = hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY);
> -
> -		hci_dev_clear_flag(hdev, HCI_ENABLE_LL_PRIVACY);
> +		bool changed;
> 
> +		changed = hci_dev_test_and_clear_flag(hdev,
> +						      HCI_ENABLE_LL_PRIVACY);
> 		if (changed)
> 			exp_ll_privacy_feature_changed(false, hdev, sk);
> 	}
> @@ -4139,15 +4139,15 @@ static int set_rpa_resolution_func(struct sock *sk, struct hci_dev *hdev,
> 	val = !!cp->param[0];
> 
> 	if (val) {
> -		changed = !hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY);
> -		hci_dev_set_flag(hdev, HCI_ENABLE_LL_PRIVACY);
> +		changed = !hci_dev_test_and_set_flag(hdev,
> +						     HCI_ENABLE_LL_PRIVACY);
> 		hci_dev_clear_flag(hdev, HCI_ADVERTISING);
> 
> 		/* Enable LL privacy + supported settings changed */
> 		flags = BIT(0) | BIT(1);
> 	} else {
> -		changed = hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY);
> -		hci_dev_clear_flag(hdev, HCI_ENABLE_LL_PRIVACY);
> +		changed = hci_dev_test_and_clear_flag(hdev,
> +						      HCI_ENABLE_LL_PRIVACY);
> 
> 		/* Disable LL privacy + supported settings changed */
> 		flags = BIT(1);

Regards

Marcel

