Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BECC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Oct 2021 18:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B34C61260
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Oct 2021 18:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbhJSSbm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Oct 2021 14:31:42 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:53923 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbhJSSbm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Oct 2021 14:31:42 -0400
Received: from smtpclient.apple (p54899aa7.dip0.t-ipconnect.de [84.137.154.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 3A778CED07;
        Tue, 19 Oct 2021 20:29:28 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH 1/2] Bluetooth: btrtl: Add support for RTL8822C hci_ver
 0x08
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211019095738.2098486-2-adeep@lexina.in>
Date:   Tue, 19 Oct 2021 20:29:27 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        chbgdn <chbgdn@gmail.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <F99878E7-51E7-48B0-921B-8CDD53693E04@holtmann.org>
References: <20211019095738.2098486-1-adeep@lexina.in>
 <20211019095738.2098486-2-adeep@lexina.in>
To:     Vyacheslav Bocharov <adeep@lexina.in>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Vyacheslav,

> Add detection of RTL8822CS controller with hci_ver = 0x08
> 
> Signed-off-by: chbgdn <chbgdn@gmail.com>

clear name please.

> Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
> ---
> drivers/bluetooth/btrtl.c | 7 +++++++
> 1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> index 1f8afa0244d8..60c4a9976d5a 100644
> --- a/drivers/bluetooth/btrtl.c
> +++ b/drivers/bluetooth/btrtl.c
> @@ -152,6 +152,13 @@ static const struct id_table ic_id_table[] = {
> 	  .fw_name  = "rtl_bt/rtl8822cs_fw.bin",
> 	  .cfg_name = "rtl_bt/rtl8822cs_config" },
> 
> +	/* 8822C with UART interface */
> +	{ IC_INFO(RTL_ROM_LMP_8822B, 0xc, 0x8, HCI_UART),
> +	  .config_needed = true,
> +	  .has_rom_version = true,
> +	  .fw_name  = "rtl_bt/rtl8822cs_fw.bin",
> +	  .cfg_name = "rtl_bt/rtl8822cs_config" },
> +

what about the .has_msft_ext here. Does this one support the Microsoft extension?

Regards

Marcel

