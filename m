Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC196C4320A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Aug 2021 07:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B50B961076
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Aug 2021 07:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238928AbhHRHim (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Aug 2021 03:38:42 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:63214 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238482AbhHRHil (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Aug 2021 03:38:41 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629272287; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=d0yXr/T2VW4S7hBEk5V/ACcxbZ3MzyH062yZu9AHnlE=;
 b=awdU0otB2G0MzS3EnLykMR0rmvG5M6UNuZo97mJaKsb2RTiJ5db2wm2mZyNEZL7mvLYsZ0+U
 c/uyfEXibWRFHgor/NBGatfSuLEAXegUqKzwzCy82s53/E2uEagSTkwmvfUnp0PDWFiXUkNv
 3oNP6KlEwl2tf2KVxlRj329Os8s=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI2MTA3ZSIsICJsaW51eC1ibHVldG9vdGhAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 611cb8d2454b7a558fc7fa5c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 18 Aug 2021 07:37:54
 GMT
Sender: tjiang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D9588C43616; Wed, 18 Aug 2021 07:37:53 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: tjiang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A7317C43460;
        Wed, 18 Aug 2021 07:37:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 18 Aug 2021 15:37:51 +0800
From:   tjiang@codeaurora.org
To:     Zijun Hu <zijuhu@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        c-hbandi@codeaurora.org, hemantg@codeaurora.org, mka@chromium.org,
        rjliao@codeaurora.org
Subject: Re: [PATCH v3] Bluetooth: btusb: Add support different nvm to
 distinguish different factory for WCN6855 controller
In-Reply-To: <1628758216-3201-1-git-send-email-zijuhu@codeaurora.org>
References: <1628758216-3201-1-git-send-email-zijuhu@codeaurora.org>
Message-ID: <fcd7e83c3cd39ea89c94345ec00b5c6c@codeaurora.org>
X-Sender: tjiang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


marcel:
   could you help review this patch ? thank you.
tjiang

On 2021-08-12 16:50, Zijun Hu wrote:
> From: Tim Jiang <tjiang@codeaurora.org>
> 
> we have different factory to produce wcn6855 soc chip, so we should
> use different nvm file with suffix to distinguish them.
> 
> Signed-off-by: Tim Jiang <tjiang@codeaurora.org>
> ---
>  drivers/bluetooth/btusb.c | 60 
> ++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 51 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index b1a05bb9f4bf..d7b4e0f1c3e3 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -4013,6 +4013,9 @@ static int btusb_set_bdaddr_wcn6855(struct 
> hci_dev *hdev,
>  #define QCA_DFU_TIMEOUT		3000
>  #define QCA_FLAG_MULTI_NVM      0x80
> 
> +#define WCN6855_2_0_RAM_VERSION_GF 0x400c1200
> +#define WCN6855_2_1_RAM_VERSION_GF 0x400c1211
> +
>  struct qca_version {
>  	__le32	rom_version;
>  	__le32	patch_version;
> @@ -4044,6 +4047,7 @@ static const struct qca_device_info
> qca_devices_table[] = {
>  	{ 0x00000302, 28, 4, 16 }, /* Rome 3.2 */
>  	{ 0x00130100, 40, 4, 16 }, /* WCN6855 1.0 */
>  	{ 0x00130200, 40, 4, 16 }, /* WCN6855 2.0 */
> +	{ 0x00130201, 40, 4, 16 }, /* WCN6855 2.1 */
>  };
> 
>  static int btusb_qca_send_vendor_req(struct usb_device *udev, u8 
> request,
> @@ -4198,6 +4202,39 @@ static int btusb_setup_qca_load_rampatch(struct
> hci_dev *hdev,
>  	return err;
>  }
> 
> +static int btusb_setup_qca_form_nvm_name(char **fwname,
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
> +
>  static int btusb_setup_qca_load_nvm(struct hci_dev *hdev,
>  				    struct qca_version *ver,
>  				    const struct qca_device_info *info)
> @@ -4206,19 +4243,24 @@ static int btusb_setup_qca_load_nvm(struct
> hci_dev *hdev,
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
