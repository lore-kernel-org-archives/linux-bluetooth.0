Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC75BC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Sep 2021 07:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9080061153
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Sep 2021 07:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbhIJHfB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Sep 2021 03:35:01 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:38777 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbhIJHfA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Sep 2021 03:35:00 -0400
Received: from smtpclient.apple (p5b3d2185.dip0.t-ipconnect.de [91.61.33.133])
        by mail.holtmann.org (Postfix) with ESMTPSA id 5973CCED3D;
        Fri, 10 Sep 2021 09:33:46 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH -next] Bluetooth: btusb: Fix the application of sizeof to
 pointer
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1630653392-45523-1-git-send-email-yang.lee@linux.alibaba.com>
Date:   Fri, 10 Sep 2021 09:33:45 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <AE0FD6C9-75DA-49E3-91F9-6F095284BCB2@holtmann.org>
References: <1630653392-45523-1-git-send-email-yang.lee@linux.alibaba.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Yang,

> sizeof() when applied to a pointer typed expression gives the size of
> the pointer.
> 
> Clean up coccicheck warning:
> ./drivers/bluetooth/btusb.c:2210:36-42: ERROR: application of sizeof to
> pointer
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
> drivers/bluetooth/btusb.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 928cbfa..5bf479e 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2207,7 +2207,7 @@ static int btusb_set_bdaddr_mtk(struct hci_dev *hdev, const bdaddr_t *bdaddr)
> 	struct sk_buff *skb;
> 	long ret;
> 
> -	skb = __hci_cmd_sync(hdev, 0xfc1a, sizeof(bdaddr), bdaddr, HCI_INIT_TIMEOUT);
> +	skb = __hci_cmd_sync(hdev, 0xfc1a, sizeof(*bdaddr), bdaddr, HCI_INIT_TIMEOUT);

lets just do 0xfc1a, 6, bdaddr like the other functions do as well.

Regards

Marcel

