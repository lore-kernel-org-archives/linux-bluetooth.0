Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80923C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Nov 2021 08:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242072AbhK2IPB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Nov 2021 03:15:01 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:52384 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbhK2IM7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Nov 2021 03:12:59 -0500
Received: from smtpclient.apple (p5b3d2e91.dip0.t-ipconnect.de [91.61.46.145])
        by mail.holtmann.org (Postfix) with ESMTPSA id 530F7CED22;
        Mon, 29 Nov 2021 09:09:41 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [PATCH v1] Bluetooth: btmtksdio: enable msft opcode
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211126221034.21331-1-lukasz.bartosik@semihalf.com>
Date:   Mon, 29 Nov 2021 09:09:40 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>, upstream@semihalf.com
Content-Transfer-Encoding: 8BIT
Message-Id: <427566CC-B8E1-4B0F-A163-33609F4920A1@holtmann.org>
References: <20211126221034.21331-1-lukasz.bartosik@semihalf.com>
To:     Lukasz Bartosik <lb@semihalf.com>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Lukasz,

> Enable msft opcode for btmtksdio driver.
> 
> Signed-off-by: Łukasz Bartosik <lb@semihalf.com>
> ---
> drivers/bluetooth/btmtksdio.c | 1 +
> 1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
> index d9cf0c492e29..2a7a615663b9 100644
> --- a/drivers/bluetooth/btmtksdio.c
> +++ b/drivers/bluetooth/btmtksdio.c
> @@ -887,6 +887,7 @@ static int btmtksdio_setup(struct hci_dev *hdev)
> 	if (enable_autosuspend)
> 		pm_runtime_allow(bdev->dev);
> 
> +	hci_set_msft_opcode(hdev, 0xFD30);
> 	bt_dev_info(hdev, "Device setup in %llu usecs", duration);

can we get someone from Mediatek to sign off on this and that all SDIO based device support the MSFT extension.

Regards

Marcel

