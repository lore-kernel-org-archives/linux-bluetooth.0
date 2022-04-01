Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0198DC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Apr 2022 17:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349860AbiDARcW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Apr 2022 13:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350095AbiDARcV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Apr 2022 13:32:21 -0400
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 514341AAA4E
        for <linux-bluetooth@vger.kernel.org>; Fri,  1 Apr 2022 10:30:30 -0700 (PDT)
Received: from smtpclient.apple (p4ff9fa3c.dip0.t-ipconnect.de [79.249.250.60])
        by mail.holtmann.org (Postfix) with ESMTPSA id A0512CED02;
        Fri,  1 Apr 2022 19:30:29 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH v3 3/3] Bluetooth: btusb: Set
 HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN for QCA
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220330182552.2613523-3-luiz.dentz@gmail.com>
Date:   Fri, 1 Apr 2022 19:30:29 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <00F602DF-EA8C-47C5-8F13-31F8D2DD0D42@holtmann.org>
References: <20220330182552.2613523-1-luiz.dentz@gmail.com>
 <20220330182552.2613523-3-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This sets HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN for QCA controllers
> since SCO appear to not work when using HCI_OP_ENHANCED_SETUP_SYNC_CONN.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=215576
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> drivers/bluetooth/btusb.c | 3 +++
> 1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 50df417207af..2470c3d4ef0f 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -3335,6 +3335,9 @@ static int btusb_setup_qca(struct hci_dev *hdev)
> 			msleep(QCA_BT_RESET_WAIT_MS);
> 	}
> 
> +	/* https://bugzilla.kernel.org/show_bug.cgi?id=215576 */

I dislike having a link here. Just describe what is going on.

> +	set_bit(HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN, &hdev->quirks);
> +
> 	return 0;
> }

Regards

Marcel

