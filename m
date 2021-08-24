Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8D1C4320A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Aug 2021 09:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08E936135F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Aug 2021 09:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235542AbhHXJMr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Aug 2021 05:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235465AbhHXJMq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Aug 2021 05:12:46 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F7BC061764
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Aug 2021 02:12:02 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id h1so7952081pjs.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Aug 2021 02:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Er4YNjBc1rFmFqd3Av/AcvBAykcXzU4G4ouPUnYIVpc=;
        b=JfjPAfP7F0EP0oEH7hj6QbWGVgpzdohE3/ff5qvHH9r2ZxsrHiHzfexuU7hQTkzAY/
         UKUy/W/GGgjBnnwxZsTvALApXd7HF78F1GJa0Jt6b0goljcH7bwgqi0JoGgk6ADHkxP/
         eoqwfSHvsCJOicF2ceG4qJ2GjEq91gKAd3EWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Er4YNjBc1rFmFqd3Av/AcvBAykcXzU4G4ouPUnYIVpc=;
        b=k9au1F4eTBaNe9TiJYtiQQy7ehgNwW55o+U62H0undA0grSdKhuaOW7/7aqJvDqRdP
         l6GgJLUP1trX2ck7yw5UE6TmonKut9jyWiH/V4yGq4fuw9XM8xTUTttf1XgUay0nGkoP
         7zIpXZU62PNRTVgeA5iEQ66yt0gMj8G46/bT10yl8PaFKMK7BoUn0zFN7DBKNzx5d/h5
         OCeqcEp7aoc8JtB61z9lQSn3iW0a4RhLijWG/a0ZEeVJTrd2sCesHiCVDMd8CQeCT8vw
         muTxt7TjkxvHarKrEgfZmeKlOw1w5g5BKzox+GQQvQr41ZfHh9apyGVgZfBBq/p1XUrg
         sO/w==
X-Gm-Message-State: AOAM533Ywd7wHSpOB/g+P1RcOuCh7NK5r7xgtqho/XCGYEERl7T7k7DU
        BslFTZPJ6gNkN3W0z+YQrfGm/g==
X-Google-Smtp-Source: ABdhPJyv6E42dsA3S9P3VWEIZmzmRItriSmwgYIihLdl3Ik3hB6giDYWmWqJZSaGbOe5kp/YpBw4JQ==
X-Received: by 2002:a17:90a:9285:: with SMTP id n5mr3290670pjo.29.1629796322219;
        Tue, 24 Aug 2021 02:12:02 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:6b46:820f:610b:67c7])
        by smtp.gmail.com with UTF8SMTPSA id gl12sm1794005pjb.40.2021.08.24.02.12.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 02:12:01 -0700 (PDT)
Date:   Tue, 24 Aug 2021 02:12:00 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Zijun Hu <zijuhu@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        c-hbandi@codeaurora.org, hemantg@codeaurora.org,
        rjliao@codeaurora.org, tjiang@codeaurora.org
Subject: Re: [PATCH v5] Bluetooth: btusb: Add support using different nvm for
 variant WCN6855 controller
Message-ID: <YSS34JcZcoZwWg5D@google.com>
References: <1629793683-28770-1-git-send-email-zijuhu@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1629793683-28770-1-git-send-email-zijuhu@codeaurora.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, Aug 24, 2021 at 04:28:03PM +0800, Zijun Hu wrote:
> From: Tim Jiang <tjiang@codeaurora.org>
> 
> we have variant wcn6855 soc chip from different foundries, so we should
> use different nvm file with suffix to distinguish them.

Similar question as on v4: why is it necessary to know where a chip was
manufactured? Is the hardware different? Should the FW behave differently
for some reason (e.g. regulatory differences)?

> 
> Signed-off-by: Tim Jiang <tjiang@codeaurora.org>
> ---
>  drivers/bluetooth/btusb.c | 57 +++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 45 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 60d2fce59a71..ad7734f8917c 100644
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
> @@ -3326,27 +3330,56 @@ static int btusb_setup_qca_load_rampatch(struct hci_dev *hdev,
>  	return err;
>  }
>  
> -static int btusb_setup_qca_load_nvm(struct hci_dev *hdev,
> -				    struct qca_version *ver,
> -				    const struct qca_device_info *info)
> +static void btusb_generate_qca_nvm_name(char **fwname,
> +					int max_size,
> +					struct qca_version *ver,
> +					char *foundry)
>  {
> -	const struct firmware *fw;
> -	char fwname[64];
> -	int err;
> +	char *separator;
> +	u16 board_id;
> +	u32 rom_version;
> +
> +	separator = (foundry == NULL) ? "" : "_";
> +	board_id = le16_to_cpu(ver->board_id);
> +	rom_version = le32_to_cpu(ver->rom_version);

Make the above assignments in the declaration.

>  
>  	if (((ver->flag >> 8) & 0xff) == QCA_FLAG_MULTI_NVM) {
>  		/* if boardid equal 0, use default nvm without surfix */
>  		if (le16_to_cpu(ver->board_id) == 0x0) {
> -			snprintf(fwname, sizeof(fwname), "qca/nvm_usb_%08x.bin",
> -				 le32_to_cpu(ver->rom_version));
> +			snprintf(fwname, sizeof(fwname), "qca/nvm_usb_%08x%s%s.bin",
> +				 rom_version,
> +				 separator,
> +				 foundry);

the last three parameters could be in a single line.

>  		} else {
> -			snprintf(fwname, sizeof(fwname), "qca/nvm_usb_%08x_%04x.bin",
> -				le32_to_cpu(ver->rom_version),
> -				le16_to_cpu(ver->board_id));
> +			snprintf(fwname, sizeof(fwname), "qca/nvm_usb_%08x%s%s%04x.bin",
> +				rom_version,
> +				separator,
> +				foundry,
> +				board_id);

the last four parameters could be in a single line.

Besides the minor comments above this looks good to me in terms of code, but
I'd like to have a better understanding of why the origin of the chip is
important.
