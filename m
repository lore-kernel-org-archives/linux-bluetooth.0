Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8DEC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Oct 2021 04:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B4E861248
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Oct 2021 04:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbhJFEQO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Oct 2021 00:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhJFEQN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Oct 2021 00:16:13 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C19AC061749
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Oct 2021 21:14:22 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id r2so1271540pgl.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 Oct 2021 21:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=QB2g/LuMmgWE230SknQt7sQYcYCMaAAhRhHqYKtCFLs=;
        b=ebURxrGOyrs7k3Uh4syCI8IySCnLNiFosbxdPxi4w0bawR8bxR1cy9nmLO9tfJcCcX
         9VvVGJFnOQ1hQRYBPjG6ZWu0PzZ87a+9/0O/jxMIREq/QgFZKi3KI3lpbLo07fK6oVoX
         tFoMXP/MzstqrOdcunQmaog7DTENQuCxwnPTvsanBR9G2OqPqccAH0WGI3/DJQp6EdRz
         gTPuYkQbPv52GAZhLfG20KTpn+CgcGdLLWRFFDMk3hFbrE6msWYNPNPp7J8TQmyAr5pR
         ws+kmAUakYmzNjMxw5jxkB8MFAbMh9z65BMJJ6q+DK5H0dl2filaCg6tZiBi0KGVVpKH
         x21g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=QB2g/LuMmgWE230SknQt7sQYcYCMaAAhRhHqYKtCFLs=;
        b=K15S09Wa7fcT+GLE2x/ON4aWFgzY3kcylktzSD1CkLWV9Bmd8I79yDstqz6abWzg/y
         c28mD3NBWVWBCdhYYZXNo8WxgaUaKeMKznKZPOVwiM9rGaX7udl8j+BbMvXJDid7lARY
         948XsdgTSZyb+xFqg6/apdh7139eFK5+dvUGgXRqgEw9Vl+RjLfnFFYu0cqU7Qt8Rkuk
         TH2Qi41xKcRRFhTtRjVYN39sJr5Kj/bkhjWa9lVg39tzE62ndvHRdrXLw+PptMyUgowZ
         qs2xAAuWepoitistSfYHKCucWgnbPoYIjIYJ0GyXXQgD/TdepJMOJyxkObDoSd/uvgrW
         cyTA==
X-Gm-Message-State: AOAM5308Gn/pKlsRXGQMdJqFzjYq3UCTDyiujQGIP3Zt4Tdb7TmJXNTS
        XSJtBfKqS+HjFB4PK5r2oF8gdEnfu+aUKQ==
X-Google-Smtp-Source: ABdhPJzcVYmxtYOouqMtUX/HsoBpWGunTpX3IC42L1UHNJQmnjVf1xyDgPG02qA55HeORDjBBMD5QQ==
X-Received: by 2002:a63:b341:: with SMTP id x1mr18931774pgt.69.1633493661504;
        Tue, 05 Oct 2021 21:14:21 -0700 (PDT)
Received: from han1-NUC8i7BEH ([2601:1c0:6a01:d830:8e4c:2d64:6206:9120])
        by smtp.gmail.com with ESMTPSA id q14sm3386954pjm.17.2021.10.05.21.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 21:14:21 -0700 (PDT)
Message-ID: <cbe1d2ae745ae380d2819877bb07e5cc8ba56c44.camel@gmail.com>
Subject: Re: [PATCH v1] Bluetooth: btintel: Fix bdaddress comparison with
 garbage value
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     Kiran K <kiran.k@intel.com>, linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        tedd.an@intel.com
Date:   Tue, 05 Oct 2021 21:14:20 -0700
In-Reply-To: <20211005042613.9946-1-kiran.k@intel.com>
References: <20211005042613.9946-1-kiran.k@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, 2021-10-05 at 09:56 +0530, Kiran K wrote:
> Intel Read Verision(TLV) data is parsed into a local structure
> variable
> and it contains a field for bd address. Bd address is returned only
> in
> bootloader mode and hence bd address in TLV structure needs to be
> validated
> only if controller is present in boot loader mode.
> 

Reviewed-by: Tedd Ho-Jeong An <tedd.an@intel.com>

> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
>  drivers/bluetooth/btintel.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/bluetooth/btintel.c
> b/drivers/bluetooth/btintel.c
> index 9359bff47296..d1703cc99705 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -2081,14 +2081,16 @@ static int
> btintel_prepare_fw_download_tlv(struct hci_dev *hdev,
>  	if (ver->img_type == 0x03) {
>  		btintel_clear_flag(hdev, INTEL_BOOTLOADER);
>  		btintel_check_bdaddr(hdev);
> -	}
> -
> -	/* If the OTP has no valid Bluetooth device address, then there
> will
> -	 * also be no valid address for the operational firmware.
> -	 */
> -	if (!bacmp(&ver->otp_bd_addr, BDADDR_ANY)) {
> -		bt_dev_info(hdev, "No device address configured");
> -		set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
> +	} else {
> +		/*
> +		 * Check for valid bd address in boot loader mode.
> Device
> +		 * will be marked as unconfigured if empty bd address
> is
> +		 * found.
> +		 */
> +		if (!bacmp(&ver->otp_bd_addr, BDADDR_ANY)) {
> +			bt_dev_info(hdev, "No device address
> configured");
> +			set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev-
> >quirks);
> +		}
>  	}
>  
>  	btintel_get_fw_name_tlv(ver, fwname, sizeof(fwname), "sfi");
> @@ -2466,6 +2468,7 @@ static int btintel_setup_combined(struct
> hci_dev *hdev)
>  		goto exit_error;
>  	}
>  
> +	memset(&ver_tlv, 0, sizeof(ver_tlv));
>  	/* For TLV type device, parse the tlv data */
>  	err = btintel_parse_version_tlv(hdev, &ver_tlv, skb);
>  	if (err) {

