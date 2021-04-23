Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384B8C433ED
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Apr 2021 06:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0902961181
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Apr 2021 06:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240648AbhDWG47 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Apr 2021 02:56:59 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:36885 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbhDWG46 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Apr 2021 02:56:58 -0400
Received: from marcel-macbook.holtmann.net (p4fefc624.dip0.t-ipconnect.de [79.239.198.36])
        by mail.holtmann.org (Postfix) with ESMTPSA id CA66CCECFA;
        Fri, 23 Apr 2021 09:04:08 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH v3 1/2] Bluetooth: btrtl: Adjust the position of strcut
 definition
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210423035229.27513-2-hildawu@realtek.com>
Date:   Fri, 23 Apr 2021 08:56:21 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        apusaka@chromium.org, tientzu@chromium.org, max.chou@realtek.com,
        alex_lu@realsil.com.cn, kidman@realtek.com
Content-Transfer-Encoding: 8BIT
Message-Id: <8AA44691-FFB2-4755-B7F2-6ABFCAAAEAA7@holtmann.org>
References: <20210423035229.27513-1-hildawu@realtek.com>
 <20210423035229.27513-2-hildawu@realtek.com>
To:     Hilda Wu <hildawu@realtek.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Hilda,

> Adjust the position of strcut definition for btrtl and hci_h5.
> The purpose is to avoid re-defining some chip features and let UART devices
> get relevant information too.
> 
> Signed-off-by: hildawu <hildawu@realtek.com>
> ---
> drivers/bluetooth/btrtl.c | 36 ------------------------------------
> drivers/bluetooth/btrtl.h | 36 +++++++++++++++++++++++++++++++++++-
> 2 files changed, 35 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> index e7fe5fb22753..94d1e7885aee 100644
> --- a/drivers/bluetooth/btrtl.c
> +++ b/drivers/bluetooth/btrtl.c
> @@ -38,42 +38,6 @@
> 	.hci_ver = (hciv), \
> 	.hci_bus = (bus)
> 
> -enum btrtl_chip_id {
> -	CHIP_ID_8723A,
> -	CHIP_ID_8723B,
> -	CHIP_ID_8821A,
> -	CHIP_ID_8761A,
> -	CHIP_ID_8822B = 8,
> -	CHIP_ID_8723D,
> -	CHIP_ID_8821C,
> -	CHIP_ID_8822C = 13,
> -	CHIP_ID_8761B,
> -	CHIP_ID_8852A = 18,
> -};
> -
> -struct id_table {
> -	__u16 match_flags;
> -	__u16 lmp_subver;
> -	__u16 hci_rev;
> -	__u8 hci_ver;
> -	__u8 hci_bus;
> -	bool config_needed;
> -	bool has_rom_version;
> -	char *fw_name;
> -	char *cfg_name;
> -};
> -
> -struct btrtl_device_info {
> -	const struct id_table *ic_info;
> -	u8 rom_version;
> -	u8 *fw_data;
> -	int fw_len;
> -	u8 *cfg_data;
> -	int cfg_len;
> -	bool drop_fw;
> -	int project_id;
> -};
> -
> static const struct id_table ic_id_table[] = {
> 	/* 8723A */
> 	{ IC_INFO(RTL_ROM_LMP_8723A, 0xb, 0x6, HCI_USB),
> diff --git a/drivers/bluetooth/btrtl.h b/drivers/bluetooth/btrtl.h
> index 2a582682136d..08bda0597c0c 100644
> --- a/drivers/bluetooth/btrtl.h
> +++ b/drivers/bluetooth/btrtl.h
> @@ -12,7 +12,41 @@
> #define rtl_dev_info(dev, fmt, ...) bt_dev_info(dev, "RTL: " fmt, ##__VA_ARGS__)
> #define rtl_dev_dbg(dev, fmt, ...) bt_dev_dbg(dev, "RTL: " fmt, ##__VA_ARGS__)
> 
> -struct btrtl_device_info;
> +enum btrtl_chip_id {
> +	CHIP_ID_8723A,
> +	CHIP_ID_8723B,
> +	CHIP_ID_8821A,
> +	CHIP_ID_8761A,
> +	CHIP_ID_8822B = 8,
> +	CHIP_ID_8723D,
> +	CHIP_ID_8821C,
> +	CHIP_ID_8822C = 13,
> +	CHIP_ID_8761B,
> +	CHIP_ID_8852A = 18,
> +};
> +
> +struct id_table {
> +	__u16 match_flags;
> +	__u16 lmp_subver;
> +	__u16 hci_rev;
> +	__u8 hci_ver;
> +	__u8 hci_bus;
> +	bool config_needed;
> +	bool has_rom_version;
> +	char *fw_name;
> +	char *cfg_name;
> +};
> +
> +struct btrtl_device_info {
> +	const struct id_table *ic_info;
> +	u8 rom_version;
> +	u8 *fw_data;
> +	int fw_len;
> +	u8 *cfg_data;
> +	int cfg_len;
> +	bool drop_fw;
> +	int project_id;
> +};

I really doubt that you need to expose all of these. Provide access function if needed.

Regards

Marcel

