Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44584C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Sep 2021 17:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29DEE619E5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Sep 2021 17:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352929AbhI3SAm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Sep 2021 14:00:42 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:47060 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352882AbhI3SAl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Sep 2021 14:00:41 -0400
Received: from smtpclient.apple (p5b3d2185.dip0.t-ipconnect.de [91.61.33.133])
        by mail.holtmann.org (Postfix) with ESMTPSA id 12109CED17;
        Thu, 30 Sep 2021 19:58:55 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH] Bluetooth: add quirk disabling query LE tx power
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210930141256.19943-1-redecorating@protonmail.com>
Date:   Thu, 30 Sep 2021 19:58:54 +0200
Cc:     danielwinkler@google.com, Johan Hedberg <johan.hedberg@intel.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        regressions@lists.linux.dev, sonnysasaka@chromium.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <FA02CDD7-CFEC-4481-9940-BA95D81FD3F3@holtmann.org>
References: <4970a940-211b-25d6-edab-21a815313954@protonmail.com>
 <20210930063106.19881-1-redecorating@protonmail.com>
 <20210930141256.19943-1-redecorating@protonmail.com>
To:     Orlando Chamberlain <redecorating@protonmail.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Orlando,

> Querying LE tx power on startup broke Bluetooth on some Broadcom chips
> in Apple computers (at least MacBookPro16,1 and iMac20,1). Added a quirk
> disabling this query for affected devices, based off their common chip
> id 150. Affected devices will not be able to query LE tx power, however
> they were not doing this before.
> 
> Fixes: 7c395ea521e6m ("Bluetooth: Query LE tx power on startup")
> Signed-off-by: Orlando Chamberlain <redecorating@protonmail.com>
> ---
> drivers/bluetooth/btbcm.c   | 4 ++++
> include/net/bluetooth/hci.h | 8 ++++++++
> net/bluetooth/hci_core.c    | 3 ++-
> 3 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
> index e4182acee488..4ecc50d93107 100644
> --- a/drivers/bluetooth/btbcm.c
> +++ b/drivers/bluetooth/btbcm.c
> @@ -353,6 +353,10 @@ static int btbcm_read_info(struct hci_dev *hdev)
> 		return PTR_ERR(skb);
> 
> 	bt_dev_info(hdev, "BCM: chip id %u", skb->data[1]);
> +
> +	if (skb->data[1] == 150)
> +		set_bit(HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER, &hdev->quirks);
> +
> 	kfree_skb(skb);
> 
> 	/* Read Controller Features */
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index b80415011dcd..5e0dd0c39ade 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -246,6 +246,14 @@ enum {
> 	 * HCI after resume.
> 	 */
> 	HCI_QUIRK_NO_SUSPEND_NOTIFIER,
> +
> +	/*
> +	 * When this quirk is set, LE tx power is not queried on startup.
> +	 *
> +	 * This quirk can be set before hci_register_dev is called or
> +	 * during the hdev->setup vendor callback.
> +	 */
> +	HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER,
> };
> 
> /* HCI device flags */
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 8a47a3017d61..16e39739c662 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -742,7 +742,8 @@ static int hci_init3_req(struct hci_request *req, unsigned long opt)
> 			hci_req_add(req, HCI_OP_LE_READ_ADV_TX_POWER, 0, NULL);
> 		}
> 
> -		if (hdev->commands[38] & 0x80) {
> +		if (hdev->commands[38] & 0x80 &&
> +			!test_bit(HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER, &hdev->quirks)) {
> 			/* Read LE Min/Max Tx Power*/
> 			hci_req_add(req, HCI_OP_LE_READ_TRANSMIT_POWER,
> 				    0, NULL);

so I really need the btmon traces from the device init (so unload and reload the module) and we need to see what commands are supported and what commands are failing.

Since you say this is on a MacBook, I assume this is an UART based Broadcom chip. Sometimes Broadcom has been really flaky with their actually implemented commands. However in some cases firmware updates do fix this. So any chance you can boot OS X and check that the latest firmware is loaded.

Regards

Marcel

