Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7430C432BE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Aug 2021 13:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6CD1610A7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Aug 2021 13:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238171AbhHRN7V (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Aug 2021 09:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237811AbhHRN7V (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Aug 2021 09:59:21 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C67C061764
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Aug 2021 06:58:46 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id x4so2322694pgh.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Aug 2021 06:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8eTIrpUwCcoVWpiClp3PfK5lef5iVWeNyYRBUeKnbn4=;
        b=glWQkiloBvZ44LNsEm5CSRvH4pOBlB0HBvut001xnKn+KtKmn7kPgj965E5iw+O/HD
         TBeYHW4R283mZoo4VOZHqEyzkk10Vta4AUgrNRP7TZPj/UUMf5HwSIqEg2jpMsCWHhMK
         9xKnDoX9bgg1vvSvVYb4a6yRt1/ecBQsq6dnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8eTIrpUwCcoVWpiClp3PfK5lef5iVWeNyYRBUeKnbn4=;
        b=SKFdhUYLPiRWr8YObbntdhbGZ0q48yYtYOjSUuoYbuHklOrGAvHqT4oDJ1/RgKQzZR
         /wsTI8xqGMUsQ2HaVKITUbxqeem2Fujb29KAwvOa6DPktBn8BQAAO7Bd2tx7d/DtqvmK
         TaArDlKHji8HaF/wFAzIFdp+83hdUqaVeimPjf9DJ1brWbATF5sZ5jUue+oKJZs2hteq
         ssa5fodgnSPql4OiH+l5hD0g0ek9IqbQiw9YIq4rHLpo11BV6lo57kXBNox3zEnoZ6do
         4ZZYqfR1dNnutILmhAT+jb2DU1KrehavAfytwjl4LgxEmI8WaecGPIfbZ/opmfgX8sqV
         Bb7A==
X-Gm-Message-State: AOAM5328pMKQo+lpyiRJKMJuNjEVpNNpHGNkhJcFK4j2JZKjrwEq1ir2
        YFGFCEpa46r090DojbQuO4u8+UpPJhBoLA==
X-Google-Smtp-Source: ABdhPJwCX91c0YhZeWnEa7qdnrBPZTZv387TJHo+PHBYowhWjOsn76mc1EmB0f4kZTtGTknH12EJBQ==
X-Received: by 2002:a05:6a00:140e:b029:38b:c129:9f2f with SMTP id l14-20020a056a00140eb029038bc1299f2fmr9316352pfu.75.1629295125763;
        Wed, 18 Aug 2021 06:58:45 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:413e:a1f9:e45b:4fe7])
        by smtp.gmail.com with UTF8SMTPSA id p21sm5984266pfo.8.2021.08.18.06.58.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Aug 2021 06:58:45 -0700 (PDT)
Date:   Wed, 18 Aug 2021 06:58:43 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Zijun Hu <zijuhu@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        c-hbandi@codeaurora.org, hemantg@codeaurora.org,
        rjliao@codeaurora.org, tjiang@codeaurora.org
Subject: Re: [PATCH v3] Bluetooth: btusb: Add support different nvm to
 distinguish different factory for WCN6855 controller
Message-ID: <YR0SEwGzgQaKAHYC@google.com>
References: <1628758216-3201-1-git-send-email-zijuhu@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1628758216-3201-1-git-send-email-zijuhu@codeaurora.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, Aug 12, 2021 at 04:50:16PM +0800, Zijun Hu wrote:
> From: Tim Jiang <tjiang@codeaurora.org>
> 
> we have different factory to produce wcn6855 soc chip, so we should
> use different nvm file with suffix to distinguish them.

What exactly does factory mean in this context, different production
facilities? Could this be just treated as a variant of the chip instead
of introducing the concept of 'factory'?

> 
> Signed-off-by: Tim Jiang <tjiang@codeaurora.org>
> ---
>  drivers/bluetooth/btusb.c | 60 ++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 51 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index b1a05bb9f4bf..d7b4e0f1c3e3 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -4013,6 +4013,9 @@ static int btusb_set_bdaddr_wcn6855(struct hci_dev *hdev,
>  #define QCA_DFU_TIMEOUT		3000
>  #define QCA_FLAG_MULTI_NVM      0x80
>  
> +#define WCN6855_2_0_RAM_VERSION_GF 0x400c1200
> +#define WCN6855_2_1_RAM_VERSION_GF 0x400c1211
> +
>  struct qca_version {
>  	__le32	rom_version;
>  	__le32	patch_version;
> @@ -4044,6 +4047,7 @@ static const struct qca_device_info qca_devices_table[] = {
>  	{ 0x00000302, 28, 4, 16 }, /* Rome 3.2 */
>  	{ 0x00130100, 40, 4, 16 }, /* WCN6855 1.0 */
>  	{ 0x00130200, 40, 4, 16 }, /* WCN6855 2.0 */
> +	{ 0x00130201, 40, 4, 16 }, /* WCN6855 2.1 */
>  };
>  
>  static int btusb_qca_send_vendor_req(struct usb_device *udev, u8 request,
> @@ -4198,6 +4202,39 @@ static int btusb_setup_qca_load_rampatch(struct hci_dev *hdev,
>  	return err;
>  }
>  
> +static int btusb_setup_qca_form_nvm_name(char **fwname,

How about btusb_generate/get_qca_fw_name()?

> +					int max_size,
> +					struct qca_version *ver,
> +					char *factory)
> +{
> +	/* if boardid equal 0, use default nvm without suffix */
> +	switch (le16_to_cpu(ver->board_id)) {
> +	case 0x0:
> +		/* we add suffix factory to distinguish with different factory. */
> +		if (factory != NULL) {
> +			snprintf(*fwname, max_size, "qca/nvm_usb_%08x_%s.bin",
> +				 le32_to_cpu(ver->rom_version),
> +				 factory);
> +		} else {
> +			snprintf(*fwname, max_size, "qca/nvm_usb_%08x.bin",
> +				 le32_to_cpu(ver->rom_version));
> +		}

how about:

	snprintf(*fwname, max_size, "qca/nvm_usb_%08x%s.bin",
		 le32_to_cpu(ver->rom_version),
		 factory);

And you either pass the 'factory' including the underscore to the function, or
an empty string (potentially with a suitable define). That would eliminate the
need for the if/else construct here and below.

Or alternatively:

	snprintf(*fwname, max_size, "qca/nvm_usb_%08x%s%s.bin",
		 le32_to_cpu(ver->rom_version),
		 separator, factory);

With separator defaulting to an empty string and being assigned to '_' when
'factory' is set.

> +		break;
> +	default:
> +		if (factory != NULL) {
> +			snprintf(*fwname, max_size, "qca/nvm_usb_%08x_%s_%04x.bin",
> +				le32_to_cpu(ver->rom_version),
> +				factory,
> +				le16_to_cpu(ver->board_id));
> +		} else {
> +			snprintf(*fwname, max_size, "qca/nvm_usb_%08x_%04x.bin",
> +				le32_to_cpu(ver->rom_version),
> +				le16_to_cpu(ver->board_id));
> +		}
> +		break;
> +	}
> +}

In case you keep the if/else constructs you should probably use local
variables to do the conversion of rom version and board id from LE to CPU
format once, instead of doing it 4 times (in terms of code, not execution).

> +
>  static int btusb_setup_qca_load_nvm(struct hci_dev *hdev,
>  				    struct qca_version *ver,
>  				    const struct qca_device_info *info)
> @@ -4206,19 +4243,24 @@ static int btusb_setup_qca_load_nvm(struct hci_dev *hdev,
>  	char fwname[64];
>  	int err;
>  
> -	if (((ver->flag >> 8) & 0xff) == QCA_FLAG_MULTI_NVM) {
> -		/* if boardid equal 0, use default nvm without surfix */
> -		if (le16_to_cpu(ver->board_id) == 0x0) {
> +	switch (ver->ram_version) {
> +	case WCN6855_2_0_RAM_VERSION_GF:
> +	case WCN6855_2_1_RAM_VERSION_GF:
> +		if (((ver->flag >> 8) & 0xff) == QCA_FLAG_MULTI_NVM) {
> +			btusb_setup_qca_form_nvm_name(&fwname, sizeof(fwname), ver, "gf");
> +		} else {
>  			snprintf(fwname, sizeof(fwname), "qca/nvm_usb_%08x.bin",
>  				 le32_to_cpu(ver->rom_version));
> +		}

The addition of a function to generate the firmware names makes sense IMO if
that gets more complex, to separate it from the actual firmware loading. However
it seems odd to only outsource part of it. Wouldn't it make more sense to hide
the entire complexity in btusb_setup_qca_form_nvm_name()?

> +		break;
> +	default:
> +		if (((ver->flag >> 8) & 0xff) == QCA_FLAG_MULTI_NVM) {
> +			btusb_setup_qca_form_nvm_name(&fwname, sizeof(fwname), ver, NULL);
>  		} else {
> -			snprintf(fwname, sizeof(fwname), "qca/nvm_usb_%08x_%04x.bin",
> -				le32_to_cpu(ver->rom_version),
> -				le16_to_cpu(ver->board_id));
> +			snprintf(fwname, sizeof(fwname), "qca/nvm_usb_%08x.bin",
> +				 le32_to_cpu(ver->rom_version));
>  		}
> -	} else {
> -		snprintf(fwname, sizeof(fwname), "qca/nvm_usb_%08x.bin",
> -			 le32_to_cpu(ver->rom_version));
> +		break;
>  	}
>  
>  	err = request_firmware(&fw, fwname, &hdev->dev);
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project
> 
