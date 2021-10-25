Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29B0C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 13:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA67460F46
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 13:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbhJYN24 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Oct 2021 09:28:56 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:48028 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbhJYN2z (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Oct 2021 09:28:55 -0400
Received: from smtpclient.apple (p4ff9f2d2.dip0.t-ipconnect.de [79.249.242.210])
        by mail.holtmann.org (Postfix) with ESMTPSA id 6242BCED18;
        Mon, 25 Oct 2021 15:26:32 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH v6 3/3] Bluetooth: btusb: enable Mediatek to support AOSP
 extension
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211021230356.v6.3.I257ac5cfaf955d15670479efc311bbab702397f4@changeid>
Date:   Mon, 25 Oct 2021 15:26:32 +0200
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        pali@kernel.org, chromeos-bluetooth-upstreaming@chromium.org,
        josephsih@google.com, Miao-chen Chou <mcchou@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <AB7796C2-6543-43CD-8FA3-DAF57AB68767@holtmann.org>
References: <20211021230356.v6.1.I139e71adfd3f00b88fe9edb63d013f9cd3e24506@changeid>
 <20211021230356.v6.3.I257ac5cfaf955d15670479efc311bbab702397f4@changeid>
To:     Joseph Hwang <josephsih@chromium.org>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Joseph,

> This patch enables Mediatek to support the AOSP extension.
> 
> Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> Signed-off-by: Joseph Hwang <josephsih@chromium.org>
> 
> ---
> 
> (no changes since v5)
> 
> Changes in v5:
> - Let the vendor command in aosp_do_open() to determine what
>  capabilities are supported.
> 
> Changes in v4:
> - Call hci_set_aosp_capable in the driver.
> - This patch is added in this Series-changes 4.
> 
> drivers/bluetooth/btusb.c | 2 ++
> 1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 87b71740fad8..00311ebd7823 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -3876,6 +3876,8 @@ static int btusb_probe(struct usb_interface *intf,
> 		hdev->set_bdaddr = btusb_set_bdaddr_mtk;
> 		set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
> 		data->recv_acl = btusb_recv_acl_mtk;
> +
> +		hci_set_aosp_capable(hdev);

can we get an ACK from Mediatek people that all their firmwares support the AOSP extensions.

Regards

Marcel

