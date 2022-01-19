Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F68C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Jan 2022 09:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352782AbiASJBv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Jan 2022 04:01:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237437AbiASJBv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Jan 2022 04:01:51 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFD4C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Jan 2022 01:01:48 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id h13so991995plf.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Jan 2022 01:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HkJE1ypJqqATEA2dEa2I9wqRDOawHEAXImciHG8Ya1A=;
        b=mXDGCiHAKOqxdyILIteaZ44S5Q2vi80TQVuhefF2XepaolE2t23HrqGpM7Fy+OBucx
         2JIS9YByM2oQjA6m+C4t6L8I8wMdN1EZhixgr9ZjKyEbF6LlOvm2YN8YpLjD35HAj3uc
         mwZl5ntX64Y6xOao53mcWnpFnK8lLBYy9wD9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HkJE1ypJqqATEA2dEa2I9wqRDOawHEAXImciHG8Ya1A=;
        b=HIzRZgMZEk7EmGscIQN38IpcQYmNKVYcPuC7cRDnW9/v/tc7vsctIikJAdZ234prcK
         7pM0ihejO2aYmVBbEghfU15qpIJ+dFirxJ/4PPbX56spc60HpwDNJjc/ctlfx8qePfPi
         fiCT+X1865VL+429PdLRf6maRLy43jrTNv4NM3rTxv/mJvmDLBAZCav3ubZxt32TUkjI
         7zRO3do6VVwTqitD0nZewj1+wJvbHcAzi7vxI4pSmS9B6sxsAxB5pMWQCjjpnLVc6kFz
         egPN+/UpSLcYFZfN6nQnttbSSviPDFNa6os23BDaTA1H62OxfOQ6HHK/6cCIyH7l6Gf0
         /fqg==
X-Gm-Message-State: AOAM533VyyLzlTAfhq3hDksElNt1nAkPGnfbBXO4fYMNyH9a0rLjOpbK
        LyMCbAiGbSHuwTCL2r8dcRlAhQ==
X-Google-Smtp-Source: ABdhPJy5NvmtZXmdrZEyVS4y5lUTxatF0BwaICcsaAEtPGLq5gN9l+5HZ/f84b1PZtfCT1b4nSij3A==
X-Received: by 2002:a17:90a:9204:: with SMTP id m4mr3124332pjo.238.1642582908327;
        Wed, 19 Jan 2022 01:01:48 -0800 (PST)
Received: from 4f18b3450899 ([203.221.136.13])
        by smtp.gmail.com with ESMTPSA id kb2sm6199972pjb.14.2022.01.19.01.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 01:01:47 -0800 (PST)
Date:   Wed, 19 Jan 2022 09:01:40 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Vyacheslav Bocharov <adeep@lexina.in>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] Bluetooth: btrtl: Add support for RTL8822C
 hci_ver 0x08
Message-ID: <20220119090140.GA24@4f18b3450899>
References: <20211027091416.1577668-1-adeep@lexina.in>
 <20211027091416.1577668-2-adeep@lexina.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211027091416.1577668-2-adeep@lexina.in>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, Oct 27, 2021 at 12:14:15PM +0300, Vyacheslav Bocharov wrote:
> Add detection of RTL8822CS controller with hci_ver = 0x08
> 
> Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
> ---
>  drivers/bluetooth/btrtl.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> index c2bdd1e6060e..38d547cc6fcd 100644
> --- a/drivers/bluetooth/btrtl.c
> +++ b/drivers/bluetooth/btrtl.c
> @@ -156,6 +156,13 @@ static const struct id_table ic_id_table[] = {
>  	  .fw_name  = "rtl_bt/rtl8822cs_fw.bin",
>  	  .cfg_name = "rtl_bt/rtl8822cs_config" },
>  
> +	/* 8822C with UART interface */
> +	{ IC_INFO(RTL_ROM_LMP_8822B, 0xc, 0x8, HCI_UART),
> +	  .config_needed = true,
> +	  .has_rom_version = true,
> +	  .fw_name  = "rtl_bt/rtl8822cs_fw.bin",
> +	  .cfg_name = "rtl_bt/rtl8822cs_config" },
> +
>  	/* 8822C with USB interface */
>  	{ IC_INFO(RTL_ROM_LMP_8822B, 0xc, 0xa, HCI_USB),
>  	  .config_needed = false,

Hi Vyacheslav,

Could I make a suggestion rebasing this patch against 5.16 and putting 
the UART hci ver 0008 berore 000a

this has been tested on Tanix TX6.

Before:

[   11.512883] Bluetooth: hci0: RTL: examining hci_ver=08 hci_rev=000c lmp_ver=08 lmp_subver=8822
[   11.512940] Bluetooth: hci0: RTL: unknown IC info, lmp subver 8822, hci rev 000c, hci ver 0008
[   11.512957] Bluetooth: hci0: RTL: no config loaded

After:

[   12.642167] Bluetooth: hci0: RTL: examining hci_ver=08 hci_rev=000c lmp_ver=08 lmp_subver=8822
[   12.671911] Bluetooth: hci0: RTL: rom_version status=0 version=3
[   12.671961] Bluetooth: hci0: RTL: loading rtl_bt/rtl8822cs_fw.bin
[   12.706248] Bluetooth: hci0: RTL: loading rtl_bt/rtl8822cs_config.bin
[   12.730251] Bluetooth: hci0: RTL: cfg_sz 33, total sz 40737
[   13.318832] Bluetooth: hci0: RTL: fw version 0x05a91a4a

Tested-by: Rudi Heitbaum <rudi@heitbaum.com>

---
 drivers/bluetooth/btrtl.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
--- a/drivers/bluetooth/btrtl.c	2022-01-09 22:55:34.000000000 +0000
+++ b/drivers/bluetooth/btrtl.c	2022-01-15 07:12:21.102080089 +0000
@@ -148,7 +148,15 @@
 	  .fw_name  = "rtl_bt/rtl8761bu_fw.bin",
 	  .cfg_name = "rtl_bt/rtl8761bu_config" },
 
+ 	/* 8822C (hci ver 0008) with UART interface */
+	{ IC_INFO(RTL_ROM_LMP_8822B, 0xc, 0x8, HCI_UART),
+	  .config_needed = true,
+	  .has_rom_version = true,
+	  .has_msft_ext = true,
+	  .fw_name  = "rtl_bt/rtl8822cs_fw.bin",
+	  .cfg_name = "rtl_bt/rtl8822cs_config" },
+
-	/* 8822C with UART interface */
+	/* 8822C (hci ver 000a) with UART interface */
 	{ IC_INFO(RTL_ROM_LMP_8822B, 0xc, 0xa, HCI_UART),
 	  .config_needed = true,
 	  .has_rom_version = true,
--
2.25.1

