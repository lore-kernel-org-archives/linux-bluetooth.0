Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA9DC432BE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Aug 2021 17:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 343796138B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Aug 2021 17:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbhHWRoL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 23 Aug 2021 13:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbhHWRoH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 23 Aug 2021 13:44:07 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A69DC06175F
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Aug 2021 10:43:24 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 17so17313940pgp.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Aug 2021 10:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jUMI2mAG4R9LnHQpnRE5DR1oPyyV5kDf5OFsC5UACnk=;
        b=nFzDzjR5ORm93otsTnXy+IEXrg0Gr01AeJ/uFOAMS5IBm61ryWBODapvX1MGME16Ub
         uTHbN8D0czZUjwkcItOBUOG3tUhdt73XrRZVdM+PcgvoyXg2hLQsTMfntKzMY/UZ4URi
         O8ISzHvOkicBBgx/9UiQBOr7hUsVFahysNcJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jUMI2mAG4R9LnHQpnRE5DR1oPyyV5kDf5OFsC5UACnk=;
        b=d5t5E4nSeSl1nemJl+kxAhS+ZLAHICGb3G2H3eS91HVOUQlBbCzyDUBViN4Maj7lyi
         y2D4EqHVBw5flz7UydpjwWQ11CH0TUjpuZ2JRntsV1ikc122QRZT1qM+CjjO6UEgNjal
         Xpxpc+cJWBcVMDlRnYLcaSIwes3Usiay5iv42BqJwRR7EDG0M9UeYOINm555/gvO9qx8
         cbBL8EDsLKQiz/OCzgQIjNz1kdR4HpuAXq+foxGGXhGzKn70PTxTqDchm3lE3vof/EWM
         RkuOfNkW5tWwkuOhHBltOswr09vKw6Wc/VtgdTJ8c9q+V8ivFHbkWLoP9UjE0JsWtkEn
         BC9A==
X-Gm-Message-State: AOAM533ux07z/CUQEfvo6wH6TfAY9TSQ38E/engtcglBEnHNg73cxzUN
        JChuuMBz2KPXgVS6sn1x1ecAXw==
X-Google-Smtp-Source: ABdhPJzL0KEU0pOwUkwj9F/mOHOikqnm6wbClikUMYBgMs45dpqN/EFjzH8XWXtr5pXlglodEaHxrw==
X-Received: by 2002:a05:6a00:1245:b029:30f:2098:fcf4 with SMTP id u5-20020a056a001245b029030f2098fcf4mr35007446pfi.66.1629740603849;
        Mon, 23 Aug 2021 10:43:23 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:6b46:820f:610b:67c7])
        by smtp.gmail.com with UTF8SMTPSA id v15sm16532255pff.105.2021.08.23.10.43.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 10:43:23 -0700 (PDT)
Date:   Mon, 23 Aug 2021 10:43:21 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Zijun Hu <zijuhu@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        c-hbandi@codeaurora.org, hemantg@codeaurora.org,
        rjliao@codeaurora.org, tjiang@codeaurora.org
Subject: Re: [PATCH v4] Bluetooth: btusb: Add support using different nvm for
 variant WCN6855 controller
Message-ID: <YSPeOYuQHnZRONte@google.com>
References: <1629709100-9099-1-git-send-email-zijuhu@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1629709100-9099-1-git-send-email-zijuhu@codeaurora.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, Aug 23, 2021 at 04:58:20PM +0800, Zijun Hu wrote:
> From: Tim Jiang <tjiang@codeaurora.org>
> 
> we have variant wcn6855 soc chip from different vendors, so we should
> use different nvm file with suffix to distinguish them.

I think the concept of 'vendor' (or 'factory' as it was named earlier) needs
more clarification.

Are we talking about USB BT modules with a the wcn6855 that are marketed by
the 'vendor'? If so, could the USB vendor it be used to determine the vendor?
Could modules from different vendors use the same firmware, even though it's
not the same for all vendors?.

> Signed-off-by: Tim Jiang <tjiang@codeaurora.org>

Please also add your own Signed-off-by tag, even when sending unmodified
patches on behalf of others. In this case you are making changes to the
original patch and are effectively a co-author, which is another important
reason for adding the tag.

> ---
>  drivers/bluetooth/btusb.c | 46 ++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 36 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 60d2fce59a71..9b4408307138 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -3141,6 +3141,9 @@ static int btusb_set_bdaddr_wcn6855(struct hci_dev *hdev,
>  #define QCA_DFU_TIMEOUT		3000
>  #define QCA_FLAG_MULTI_NVM      0x80
>  
> +#define WCN6855_2_0_RAM_VERSION_GF 0x400c1200
> +#define WCN6855_2_1_RAM_VERSION_GF 0x400c1211
> +
>  struct qca_version {
>  	__le32	rom_version;
>  	__le32	patch_version;
> @@ -3172,6 +3175,7 @@ static const struct qca_device_info qca_devices_table[] = {
>  	{ 0x00000302, 28, 4, 16 }, /* Rome 3.2 */
>  	{ 0x00130100, 40, 4, 16 }, /* WCN6855 1.0 */
>  	{ 0x00130200, 40, 4, 16 }, /* WCN6855 2.0 */
> +	{ 0x00130201, 40, 4, 16 }, /* WCN6855 2.1 */
>  };
>  
>  static int btusb_qca_send_vendor_req(struct usb_device *udev, u8 request,
> @@ -3326,22 +3330,24 @@ static int btusb_setup_qca_load_rampatch(struct hci_dev *hdev,
>  	return err;
>  }
>  
> -static int btusb_setup_qca_load_nvm(struct hci_dev *hdev,
> -				    struct qca_version *ver,
> -				    const struct qca_device_info *info)
> +static void btusb_generate_qca_nvm_name(char **fwname,
> +					int max_size,
> +					struct qca_version *ver,
> +					char *separator,

'separator' is part of the internal logic of this function, the caller
shouldn't have to care about it. Define it as a local variable instead
and initialize it to ''. If 'vendor' (or whatever it is called) is not
NULL assign 'separator' to '_'.

> +					char *vendor)
>  {
> -	const struct firmware *fw;
> -	char fwname[64];
> -	int err;
> -

	u16 board_id = le16_to_cpu(ver->board_id);
	u32 rom_version = le32_to_cpu(ver->rom_version));

Then use these local variable instead of doing the endianness conversion
over and over again.

>  	if (((ver->flag >> 8) & 0xff) == QCA_FLAG_MULTI_NVM) {
>  		/* if boardid equal 0, use default nvm without surfix */
>  		if (le16_to_cpu(ver->board_id) == 0x0) {
> -			snprintf(fwname, sizeof(fwname), "qca/nvm_usb_%08x.bin",
> -				 le32_to_cpu(ver->rom_version));
> +			snprintf(fwname, sizeof(fwname), "qca/nvm_usb_%08x%s%s.bin",
> +				 le32_to_cpu(ver->rom_version),
> +				 separator,
> +				 vendor);
>  		} else {
> -			snprintf(fwname, sizeof(fwname), "qca/nvm_usb_%08x_%04x.bin",
> +			snprintf(fwname, sizeof(fwname), "qca/nvm_usb_%08x%s%s%04x.bin",
>  				le32_to_cpu(ver->rom_version),
> +				separator,
> +				vendor,
>  				le16_to_cpu(ver->board_id));
>  		}
>  	} else {
> @@ -3349,6 +3355,26 @@ static int btusb_setup_qca_load_nvm(struct hci_dev *hdev,
>  			 le32_to_cpu(ver->rom_version));
>  	}
>  
> +}
> +
> +static int btusb_setup_qca_load_nvm(struct hci_dev *hdev,
> +				    struct qca_version *ver,
> +				    const struct qca_device_info *info)
> +{
> +	const struct firmware *fw;
> +	char fwname[64];
> +	int err;
> +
> +	switch (ver->ram_version) {
> +	case WCN6855_2_0_RAM_VERSION_GF:
> +	case WCN6855_2_1_RAM_VERSION_GF:
> +			btusb_generate_qca_nvm_name(&fwname, sizeof(fwname), ver, "_", "gf");
> +		break;
> +	default:
> +			btusb_generate_qca_nvm_name(&fwname, sizeof(fwname), ver, NULL, NULL);
> +		break;
> +	}
> +
>  	err = request_firmware(&fw, fwname, &hdev->dev);
>  	if (err) {
>  		bt_dev_err(hdev, "failed to request NVM file: %s (%d)",
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project
> 
