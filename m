Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27743C433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Mar 2022 15:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242507AbiCNPTj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Mar 2022 11:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236465AbiCNPTh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Mar 2022 11:19:37 -0400
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D9C1513EBA;
        Mon, 14 Mar 2022 08:18:24 -0700 (PDT)
Received: from smtpclient.apple (p5b3d2183.dip0.t-ipconnect.de [91.61.33.131])
        by mail.holtmann.org (Postfix) with ESMTPSA id 893CCCECC5;
        Mon, 14 Mar 2022 16:18:23 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [PATCH] Bluetooth: btbcm: Support per-board firmware variants
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220311001746.480163-1-linus.walleij@linaro.org>
Date:   Mon, 14 Mar 2022 16:18:23 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        phone-devel@vger.kernel.org,
        Markuss Broks <markuss.broks@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>
Content-Transfer-Encoding: 8BIT
Message-Id: <D9F12453-41D5-4F31-8A15-293D708D5875@holtmann.org>
References: <20220311001746.480163-1-linus.walleij@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Linus,

> There are provedly different firmware variants for the different
> phones using some of these chips. These were extracted from a few
> Samsung phones:
> 
> 37446 BCM4334B0.samsung,codina-tmo.hcd
> 37366 BCM4334B0.samsung,golden.hcd
> 37403 BCM4334B0.samsung,kyle.hcd
> 37366 BCM4334B0.samsung,skomer.hcd
> 
> This patch supports the above naming schedule with inserting
> [.board_name] between the firmware name and ".hcd". This scheme
> is the same as used by the companion BRCM wireless chips
> as can be seen in
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
> or just by looking at the firmwares in linux-firmware/brcm.
> 
> Currently we only support board variants using the device
> tree compatible string as board type, but other schemes are
> possible.
> 
> This makes it possible to successfully load a few unique
> firmware variants for some Samsung phones.
> 
> Cc: phone-devel@vger.kernel.org
> Cc: Markuss Broks <markuss.broks@gmail.com>
> Cc: Stephan Gerhold <stephan@gerhold.net>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> drivers/bluetooth/btbcm.c | 55 ++++++++++++++++++++++++++++++++++++++-
> 1 file changed, 54 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
> index d9ceca7a7935..9d1a8d80a8cd 100644
> --- a/drivers/bluetooth/btbcm.c
> +++ b/drivers/bluetooth/btbcm.c
> @@ -9,6 +9,7 @@
> #include <linux/module.h>
> #include <linux/firmware.h>
> #include <linux/dmi.h>
> +#include <linux/of.h>
> #include <asm/unaligned.h>
> 
> #include <net/bluetooth/bluetooth.h>
> @@ -29,7 +30,7 @@
> #define BDADDR_BCM43341B (&(bdaddr_t) {{0xac, 0x1f, 0x00, 0x1b, 0x34, 0x43}})
> 
> #define BCM_FW_NAME_LEN			64
> -#define BCM_FW_NAME_COUNT_MAX		2
> +#define BCM_FW_NAME_COUNT_MAX		4
> /* For kmalloc-ing the fw-name array instead of putting it on the stack */
> typedef char bcm_fw_name[BCM_FW_NAME_LEN];
> 
> @@ -476,6 +477,45 @@ static const struct bcm_subver_table bcm_usb_subver_table[] = {
> 	{ }
> };
> 
> +/*
> + * This currently only looks up the device tree board appendix,
> + * but can be expanded to other mechanisms.
> + */
> +#ifdef CONFIG_OF
> +static const char *btbcm_get_board_name(struct device *dev)
> +{
> +	struct device_node *root;
> +	char *board_type;
> +	const char *tmp;
> +	int len;
> +	int i;
> +
> +	root = of_find_node_by_path("/");
> +	if (!root)
> +		return NULL;
> +
> +	if (of_property_read_string_index(root, "compatible", 0, &tmp))
> +		return NULL;
> +
> +	/* get rid of any '/' in the compatible string */
> +	len = strlen(tmp) + 1;
> +	board_type = devm_kzalloc(dev, len, GFP_KERNEL);
> +	strscpy(board_type, tmp, len);
> +	for (i = 0; i < board_type[i]; i++) {
> +		if (board_type[i] == '/')
> +			board_type[i] = '-';
> +	}
> +	of_node_put(root);
> +
> +	return board_type;
> +}
> +#else
> +static const char *btbcm_get_board_name(struct device *dev)
> +{
> +	return NULL;
> +}
> +#endif
> +

can we please do the #ifdef magic inside the function.

static const char *btbcm_get_board_name(struct device *dev)
{
#ifdef
	..
	return board_type;
#else
	return NULL;
#endif
}


> int btbcm_initialize(struct hci_dev *hdev, bool *fw_load_done)
> {
> 	u16 subver, rev, pid, vid;
> @@ -483,12 +523,15 @@ int btbcm_initialize(struct hci_dev *hdev, bool *fw_load_done)
> 	struct hci_rp_read_local_version *ver;
> 	const struct bcm_subver_table *bcm_subver_table;
> 	const char *hw_name = NULL;
> +	const char *board_name = NULL;
> 	char postfix[16] = "";
> 	int fw_name_count = 0;
> 	bcm_fw_name *fw_name;
> 	const struct firmware *fw;
> 	int i, err;
> 
> +	board_name = btbcm_get_board_name(&hdev->dev);
> +

There is no point in assigning board_name to NULL at variable declaration.

> 	/* Reset */
> 	err = btbcm_reset(hdev);
> 	if (err)
> @@ -549,11 +592,21 @@ int btbcm_initialize(struct hci_dev *hdev, bool *fw_load_done)
> 		return -ENOMEM;
> 
> 	if (hw_name) {
> +		if (board_name) {
> +			snprintf(fw_name[fw_name_count], BCM_FW_NAME_LEN,
> +				 "brcm/%s%s.%s.hcd", hw_name, postfix, board_name);
> +			fw_name_count++;
> +		}
> 		snprintf(fw_name[fw_name_count], BCM_FW_NAME_LEN,
> 			 "brcm/%s%s.hcd", hw_name, postfix);
> 		fw_name_count++;
> 	}
> 
> +	if (board_name) {
> +		snprintf(fw_name[fw_name_count], BCM_FW_NAME_LEN,
> +			 "brcm/BCM%s.%s.hcd", postfix, board_name);
> +		fw_name_count++;
> +	}
> 	snprintf(fw_name[fw_name_count], BCM_FW_NAME_LEN,
> 		 "brcm/BCM%s.hcd", postfix);
> 	fw_name_count++;

Regards

Marcel

