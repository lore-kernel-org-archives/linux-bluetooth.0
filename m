Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690D2C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Oct 2021 19:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 426F86008E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Oct 2021 19:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234335AbhJSTcK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Oct 2021 15:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbhJSTcJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Oct 2021 15:32:09 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E650EC061746
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Oct 2021 12:29:56 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id v8so831745pfu.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Oct 2021 12:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rfcO7m570cVuA/+Db71WdJTCayi39VVzxp2McfxCX74=;
        b=B7Z9r9zCyfmJ619PtenNpaQGb6qmcF4yoCj76L8uwEDsm4NkXnSyI2EiwoHO9r2/ly
         G/gHBXShpzddrPltdGZyEelGpaaJMFi+cCZZIBQqK2MR4AstD1vJwJ8+F//rPA62T6gE
         pbmc3pNFNPDP7+Ypxq5jK9F7zebdWalWyC39c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rfcO7m570cVuA/+Db71WdJTCayi39VVzxp2McfxCX74=;
        b=H/RKPr9U3SLSA+TaIfr17MaWtqaMmly7pUUtwUlOyoCwyGIi57KO8IjN5aVaYEEW3D
         KJxXQapfI8EkzoGGvm2+dg1E9IN1oK4MhoJmmR1WFk7sQve6FA5ztpfjqZz4W4uVHR3X
         Z+c93eGTvRuP1+fPr1O2d3e+tlWyGbH25/wNNn+UqlO8qpzXiqWNL2Mlzup6zVaj2hoL
         4BkQu0HhQGBCLQpKA7qpRMcSfRg4yNUa9t0jBKiMv0Jehhh8+5Y+l2c7mTaHTLbivxCC
         gudCPW9wC/ySyqb37Hu0TRwDi2tvyf2OhNPPUkjf5bGCY2WXgz+aAWBQsjioFLlmLus/
         Y2Ug==
X-Gm-Message-State: AOAM5317peacf0+e9rECiSjuQ6XuuIoQyGxxhluykQ2dMvMLOi7jKThz
        f/41vKbPnpU8na3yvlzcgvytrQ==
X-Google-Smtp-Source: ABdhPJx5yIg+YlwtgRdehYGb3XeBfLuwpZPey4QJAE352AvMl6Jb4rurpfHyp4NKVQlduw0Kgn0kUw==
X-Received: by 2002:a63:8bca:: with SMTP id j193mr27225596pge.213.1634671796405;
        Tue, 19 Oct 2021 12:29:56 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:6c1f:a561:f56:7d16])
        by smtp.gmail.com with UTF8SMTPSA id u74sm24063pfc.87.2021.10.19.12.29.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 12:29:55 -0700 (PDT)
Date:   Tue, 19 Oct 2021 12:29:53 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     tjiang@codeaurora.org
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        c-hbandi@codeaurora.org, hemantg@codeaurora.org,
        rjliao@codeaurora.org, zijuhu@codeaurora.org
Subject: Re: [PATCH v2] Bluetooth: btusb: Add support for variant WCN6855 by
 using different nvm
Message-ID: <YW8csSr/I1IRgAaT@google.com>
References: <81add00a4a038008e9f734c5f5e5b712@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <81add00a4a038008e9f734c5f5e5b712@codeaurora.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, Oct 12, 2021 at 03:55:56PM +0800, tjiang@codeaurora.org wrote:
> the RF performance of wcn6855 soc chip from different foundries will be
> difference, so we should use different nvm to configure them.
> 
> Signed-off-by: Tim Jiang <tjiang@codeaurora.org>
> ---
>  drivers/bluetooth/btusb.c | 56
> +++++++++++++++++++++++++++++++++++------------
>  1 file changed, 42 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 75c83768c257..f352ff351b61 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -3190,6 +3190,9 @@ static int btusb_set_bdaddr_wcn6855(struct hci_dev
> *hdev,
>  #define QCA_DFU_TIMEOUT		3000
>  #define QCA_FLAG_MULTI_NVM      0x80
> 
> +#define WCN6855_2_0_RAM_VERSION_GF 0x400c1200
> +#define WCN6855_2_1_RAM_VERSION_GF 0x400c1211
> +
>  struct qca_version {
>  	__le32	rom_version;
>  	__le32	patch_version;
> @@ -3221,6 +3224,7 @@ static const struct qca_device_info
> qca_devices_table[] = {
>  	{ 0x00000302, 28, 4, 16 }, /* Rome 3.2 */
>  	{ 0x00130100, 40, 4, 16 }, /* WCN6855 1.0 */
>  	{ 0x00130200, 40, 4, 16 }, /* WCN6855 2.0 */
> +	{ 0x00130201, 40, 4, 16 }, /* WCN6855 2.1 */
>  };
> 
>  static int btusb_qca_send_vendor_req(struct usb_device *udev, u8 request,
> @@ -3375,6 +3379,43 @@ static int btusb_setup_qca_load_rampatch(struct
> hci_dev *hdev,
>  	return err;
>  }
> 
> +static void btusb_generate_qca_nvm_name(char *fwname,
> +					size_t max_size,
> +					struct qca_version *ver)

=> const struct qca_version *ver

> +{
> +	u32 rom_version = le32_to_cpu(ver->rom_version);
> +	u16 flag = le16_to_cpu(ver->flag);
> +
> +	if (((flag >> 8) & 0xff) == QCA_FLAG_MULTI_NVM) {
> +		u16 board_id = le16_to_cpu(ver->board_id);
> +		u32 ram_version = le32_to_cpu(ver->ram_version);
> +		const char *variant;
> +
> +		switch (ram_version) {
> +		case WCN6855_2_0_RAM_VERSION_GF:
> +		case WCN6855_2_1_RAM_VERSION_GF:
> +			variant = "_gf";
> +			break;
> +		default:
> +			variant = "";

instead of the default branch you could assign a default to 'variant' at
declaration time, but it's fine either way.

> +			break;
> +		}
> +
> +		/* if boardid equal 0, use default nvm without suffix */

delete the comment, it just states the obvious

> +		if (board_id == 0x0) {

nit: is there really any value in using a hex number here instead of a
plain decimal 0?

> +			snprintf(fwname, max_size, "qca/nvm_usb_%08x%s.bin",
> +				rom_version, variant);
> +		} else {
> +			snprintf(fwname, max_size, "qca/nvm_usb_%08x%s_%04x.bin",
> +				rom_version, variant, board_id);
> +		}
> +	} else {
> +		snprintf(fwname, max_size, "qca/nvm_usb_%08x.bin",
> +			rom_version);
> +	}
> +
> +}
> +
>  static int btusb_setup_qca_load_nvm(struct hci_dev *hdev,
>  				    struct qca_version *ver,
>  				    const struct qca_device_info *info)
> @@ -3383,20 +3424,7 @@ static int btusb_setup_qca_load_nvm(struct hci_dev
> *hdev,
>  	char fwname[64];
>  	int err;
> 
> -	if (((ver->flag >> 8) & 0xff) == QCA_FLAG_MULTI_NVM) {
> -		/* if boardid equal 0, use default nvm without surfix */
> -		if (le16_to_cpu(ver->board_id) == 0x0) {
> -			snprintf(fwname, sizeof(fwname), "qca/nvm_usb_%08x.bin",
> -				 le32_to_cpu(ver->rom_version));
> -		} else {
> -			snprintf(fwname, sizeof(fwname), "qca/nvm_usb_%08x_%04x.bin",
> -				le32_to_cpu(ver->rom_version),
> -				le16_to_cpu(ver->board_id));
> -		}
> -	} else {
> -		snprintf(fwname, sizeof(fwname), "qca/nvm_usb_%08x.bin",
> -			 le32_to_cpu(ver->rom_version));
> -	}
> +	btusb_generate_qca_nvm_name(fwname, sizeof(fwname), ver);
> 
>  	err = request_firmware(&fw, fwname, &hdev->dev);
>  	if (err) {
