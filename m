Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30B4C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Mar 2022 15:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239999AbiCNPWj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Mar 2022 11:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239722AbiCNPWg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Mar 2022 11:22:36 -0400
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 22FE8140F1;
        Mon, 14 Mar 2022 08:21:25 -0700 (PDT)
Received: from smtpclient.apple (p5b3d2183.dip0.t-ipconnect.de [91.61.33.131])
        by mail.holtmann.org (Postfix) with ESMTPSA id 3F406CECC5;
        Mon, 14 Mar 2022 16:21:24 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [PATCH] Bluetooth: btrtl: btmrvl: Fix firmware filename for rtl
 chipset
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220311032620.28362-1-tangmeng@uniontech.com>
Date:   Mon, 14 Mar 2022 16:21:23 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <6FCDA0C9-59CD-44F1-B31A-27DDB7FB8D25@holtmann.org>
References: <20220311032620.28362-1-tangmeng@uniontech.com>
To:     Meng Tang <tangmeng@uniontech.com>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Meng,

> Firmware for rtl chipset is as part of the linux-firmware repository
> in dir linux-firmware/rtl_bt. Today, the rtl8761a_config,
> rtl8821a_config, rtl8723b_config and rtl8723bs_config files are used
> in btrtl, but it doesn't actually exist, which causes errors like:
> 
> bluetooth: Direct firmware load for rtl_bt/rtl8821a_config.bin
>           failed with error -2
> 
> According to the files in the rtl_bt directory in the Linux firmware,
> fixes the driver to load correct firmware file for rtl.
> 
> Signed-off-by: Meng Tang <tangmeng@uniontech.com>
> ---
> drivers/bluetooth/btrtl.c | 13 +++++--------
> 1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> index c2030f7e25b4..e3cfe0dff07d 100644
> --- a/drivers/bluetooth/btrtl.c
> +++ b/drivers/bluetooth/btrtl.c
> @@ -88,14 +88,14 @@ static const struct id_table ic_id_table[] = {
> 	  .config_needed = true,
> 	  .has_rom_version = true,
> 	  .fw_name  = "rtl_bt/rtl8723bs_fw.bin",
> -	  .cfg_name = "rtl_bt/rtl8723bs_config" },
> +	  .cfg_name = "rtl_bt/rtl8723bs_config-OBDA8723" },

this change is not explained.

> 
> 	/* 8723B */
> 	{ IC_INFO(RTL_ROM_LMP_8723B, 0xb, 0x6, HCI_USB),
> 	  .config_needed = false,
> 	  .has_rom_version = true,
> 	  .fw_name  = "rtl_bt/rtl8723b_fw.bin",
> -	  .cfg_name = "rtl_bt/rtl8723b_config" },
> +	  .cfg_name = NULL },

.config_needed is set to false. Then we better use a request_firmware version where the existence of the file is optional.

And even if we wanted to remove it (which would make the .config_needed obsolute), we are not doing a NULL assignment, we just remove the line.

> 
> 	/* 8723D */
> 	{ IC_INFO(RTL_ROM_LMP_8723B, 0xd, 0x8, HCI_USB),
> @@ -116,7 +116,7 @@ static const struct id_table ic_id_table[] = {
> 	  .config_needed = false,
> 	  .has_rom_version = true,
> 	  .fw_name  = "rtl_bt/rtl8821a_fw.bin",
> -	  .cfg_name = "rtl_bt/rtl8821a_config" },
> +	  .cfg_name = NULL },
> 
> 	/* 8821C */
> 	{ IC_INFO(RTL_ROM_LMP_8821A, 0xc, 0x8, HCI_USB),
> @@ -131,7 +131,7 @@ static const struct id_table ic_id_table[] = {
> 	  .config_needed = false,
> 	  .has_rom_version = true,
> 	  .fw_name  = "rtl_bt/rtl8761a_fw.bin",
> -	  .cfg_name = "rtl_bt/rtl8761a_config" },
> +	  .cfg_name = NULL },
> 
> 	/* 8761B */
> 	{ IC_INFO(RTL_ROM_LMP_8761A, 0xb, 0xa, HCI_UART),
> @@ -921,15 +921,12 @@ MODULE_VERSION(VERSION);
> MODULE_LICENSE("GPL");
> MODULE_FIRMWARE("rtl_bt/rtl8723a_fw.bin");
> MODULE_FIRMWARE("rtl_bt/rtl8723b_fw.bin");
> -MODULE_FIRMWARE("rtl_bt/rtl8723b_config.bin");
> MODULE_FIRMWARE("rtl_bt/rtl8723bs_fw.bin");
> -MODULE_FIRMWARE("rtl_bt/rtl8723bs_config.bin");
> +MODULE_FIRMWARE("rtl_bt/rtl8723bs_config-OBDA8723.bin");
> MODULE_FIRMWARE("rtl_bt/rtl8723ds_fw.bin");
> MODULE_FIRMWARE("rtl_bt/rtl8723ds_config.bin");
> MODULE_FIRMWARE("rtl_bt/rtl8761a_fw.bin");
> -MODULE_FIRMWARE("rtl_bt/rtl8761a_config.bin");
> MODULE_FIRMWARE("rtl_bt/rtl8821a_fw.bin");
> -MODULE_FIRMWARE("rtl_bt/rtl8821a_config.bin");
> MODULE_FIRMWARE("rtl_bt/rtl8822b_fw.bin");
> MODULE_FIRMWARE("rtl_bt/rtl8822b_config.bin");
> MODULE_FIRMWARE("rtl_bt/rtl8852au_fw.bin");

Regards

Marcel

