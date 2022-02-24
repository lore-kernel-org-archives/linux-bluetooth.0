Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1861C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Feb 2022 13:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235170AbiBXNk1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Feb 2022 08:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233714AbiBXNk0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Feb 2022 08:40:26 -0500
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 60EFD25F36C
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Feb 2022 05:39:56 -0800 (PST)
Received: from smtpclient.apple (p4fefc101.dip0.t-ipconnect.de [79.239.193.1])
        by mail.holtmann.org (Postfix) with ESMTPSA id 157C2CED12;
        Thu, 24 Feb 2022 14:39:55 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [PATCH] Bluetooth: hci_sync: Fix hci_update_accept_list_sync
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220224080219.38653-1-luiz.dentz@gmail.com>
Date:   Thu, 24 Feb 2022 14:39:54 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <2D0784C9-C413-43EC-91F5-35C47AA31BBC@holtmann.org>
References: <20220224080219.38653-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> hci_update_accept_list_sync is returning the filter based on the error
> but that gets overwritten by hci_le_set_addr_resolution_enable_sync
> return instead of using the actual result of the likes of
> hci_le_add_accept_list_sync which was intended.
> 
> Fixes: ad383c2c65a5b ("Bluetooth: hci_sync: Enable advertising when LL privacy is enabled")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> net/bluetooth/hci_sync.c | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index b66a2271c433..ca51d6138540 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -1844,7 +1844,7 @@ static u8 hci_update_accept_list_sync(struct hci_dev *hdev)
> 	struct bdaddr_list *b, *t;
> 	u8 num_entries = 0;
> 	bool pend_conn, pend_report;
> -	int err;
> +	int err, ret;
> 
> 	/* Pause advertising if resolving list can be used as controllers are
> 	 * cannot accept resolving list modifications while advertising.
> @@ -1930,6 +1930,8 @@ static u8 hci_update_accept_list_sync(struct hci_dev *hdev)
> 		err = -EINVAL;
> 
> done:
> +	ret = err ? 0x00 : 0x01;
> +
> 	/* Enable address resolution when LL Privacy is enabled. */
> 	err = hci_le_set_addr_resolution_enable_sync(hdev, 0x01);
> 	if (err)
> @@ -1940,7 +1942,7 @@ static u8 hci_update_accept_list_sync(struct hci_dev *hdev)
> 		hci_resume_advertising_sync(hdev);
> 
> 	/* Select filter policy to use accept list */
> -	return err ? 0x00 : 0x01;
> +	return ret;
> }

hmmmmm. I dislike the usage of err and ret together. That makes for some hard to read code (and the return value is u8 and not int).

Maybe doing

	u8 filter_policy = 0x00;

	...

And then

done:
	/* select filter policy to use accept list */
	filter_policy = 0x01;

	...

	return filter_policy;
}

Regards

Marcel

