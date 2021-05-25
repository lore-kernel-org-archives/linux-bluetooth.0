Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A8EC2B9F8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 May 2021 09:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45E9661378
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 May 2021 09:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbhEYJYm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 May 2021 05:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbhEYJYl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 May 2021 05:24:41 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67575C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 May 2021 02:23:11 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id df21so35331761edb.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 May 2021 02:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=p1dfoj+hgeWyqY+hZ8nGrm7+WYHUPScdLfJBOIdvS9A=;
        b=CRgCOiqnRl4RRcJuUmlKY+rZY9M88g9lKuv+V7rUgQUzRaN+6ebTZBmk9+LMckKYZC
         9hDYI+jvdr2aG3qIE74lbKjPlNzaZYg7yLCD3DOeNet/BeH1cS3I7U9oKnpiMH7OTqXc
         DsKP2sz2t1h8KlFqYdjWp+nvowN5o5n55dKe+JhDZYz6JEPtPpNO9ERgiTznktw8riLx
         hv6haFwN4FIb3o8344spGtfBIbHAwtrYSXvILxxoCX6iOwNynLCVh3fPv1aX7C6FIWNt
         6X+KOLgh76JRA+t7t5I6S/XveVDMOYRbPerFrPxJxZgpX5h+ztd5g3EFqVJaTsDUT9aE
         6KSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p1dfoj+hgeWyqY+hZ8nGrm7+WYHUPScdLfJBOIdvS9A=;
        b=VwCms/q66FfRgwa+YVORgeZGKep41q9gkwBYmvCuo8xWG9EhQI/VfLLdU/0ViDIaWa
         hWxWOy3LbafPe5GnLGFz2lmAQna1bWSV2UtNlHvCbJJWvHmaOMzXVDYlnby5igMZ/Abt
         PaQU8DO+V2yUYKJdcYSEjcmVky9OSkfS/ZLyz/hpYVfzUoXVwWn0V8VDpYNrxqVAJE9j
         G7mHe4gboFRbv6ywicBdQXmA7d5r+j/RjLIKcjvAw6ysBFhuYAT/tS+AAaQx1T9NxVrp
         b02utgWLGVlb/W1WPux7PgEFCQF/4W2LexJzO7pZSe2r8JbByWXxPpX9m1fDkCEYAUXP
         kaCQ==
X-Gm-Message-State: AOAM533fFsba8kjmURUBTdLPv5+eo2Xs+VHJvwkvtQCk55hMmkaJ8oRu
        7tBwuhyZXiTmwW5I1LsBpBmrBN/9sU55aw==
X-Google-Smtp-Source: ABdhPJwgx/c8NmI9bvM+jfYASRpICL7HgrhyLqlpxodP3TYU44FaB5kWQjn0c8vv0CDibnfIXjejRg==
X-Received: by 2002:aa7:cf03:: with SMTP id a3mr30403284edy.314.1621934589998;
        Tue, 25 May 2021 02:23:09 -0700 (PDT)
Received: from myrica (adsl-84-226-106-126.adslplus.ch. [84.226.106.126])
        by smtp.gmail.com with ESMTPSA id g1sm8832463ejf.29.2021.05.25.02.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 02:23:09 -0700 (PDT)
Date:   Tue, 25 May 2021 11:22:52 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Add support for virtio transport driver
Message-ID: <YKzB7HKqjjetjd1M@myrica>
References: <20210406141258.258544-1-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406141258.258544-1-marcel@holtmann.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Tue, Apr 06, 2021 at 04:12:58PM +0200, Marcel Holtmann wrote:
> diff --git a/include/uapi/linux/virtio_bt.h b/include/uapi/linux/virtio_bt.h
> new file mode 100644
> index 000000000000..0cedceaacf88
> --- /dev/null
> +++ b/include/uapi/linux/virtio_bt.h
> @@ -0,0 +1,31 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +
> +#ifndef _UAPI_LINUX_VIRTIO_BT_H
> +#define _UAPI_LINUX_VIRTIO_BT_H
> +
> +#include <linux/virtio_types.h>
> +
> +/* Feature bits */
> +#define VIRTIO_BT_F_VND_HCI	0	/* Indicates vendor command support */
> +#define VIRTIO_BT_F_MSFT_EXT	1	/* Indicates MSFT vendor support */
> +#define VIRTIO_BT_F_AOSP_EXT	2	/* Indicates AOSP vendor support */
> +
> +enum virtio_bt_config_type {
> +	VIRTIO_BT_CONFIG_TYPE_PRIMARY	= 0,
> +	VIRTIO_BT_CONFIG_TYPE_AMP	= 1,
> +};
> +
> +enum virtio_bt_config_vendor {
> +	VIRTIO_BT_CONFIG_VENDOR_NONE	= 0,
> +	VIRTIO_BT_CONFIG_VENDOR_ZEPHYR	= 1,
> +	VIRTIO_BT_CONFIG_VENDOR_INTEL	= 2,
> +	VIRTIO_BT_CONFIG_VENDOR_REALTEK	= 3,
> +};
> +
> +struct virtio_bt_config {
> +	__u8  type;
> +	__u16 vendor;
> +	__u16 msft_opcode;
> +} __attribute__((packed));

Config fields should be naturally aligned, because the virtio spec says
(4.1.3.1 Driver Requirements: PCI Device Layout).

	For device configuration access, the driver MUST use 8-bit wide accesses
	for 8-bit wide fields, 16-bit wide and aligned accesses for 16-bit wide
	fields and 32-bit wide and aligned accesses for 32-bit and 64-bit wide
	fields.

> +
> +#endif /* _UAPI_LINUX_VIRTIO_BT_H */
> diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
> index bc1c0621f5ed..b4f468e9441d 100644
> --- a/include/uapi/linux/virtio_ids.h
> +++ b/include/uapi/linux/virtio_ids.h
> @@ -53,6 +53,7 @@
>  #define VIRTIO_ID_MEM			24 /* virtio mem */
>  #define VIRTIO_ID_FS			26 /* virtio filesystem */
>  #define VIRTIO_ID_PMEM			27 /* virtio pmem */
> +#define VIRTIO_ID_BT			28 /* virtio bluetooth */

ID 28 is already reserved for virtio-rpmb:
https://github.com/oasis-tcs/virtio-spec/issues/58

To avoid major compatibility pains going forward I think this should be
changed to ID 40 before v5.13. It won't be easy to fix afterwards since
it's UAPI.

Probably a good idea to fix or revert virtio_bt.h as well before it's too
late. Patches to the virtio headers should Cc
virtualization@lists.linux-foundation.org and perhaps
virtio-dev@lists.oasis-open.org because they can provide guidance about
this.

Thanks,
Jean

>  #define VIRTIO_ID_MAC80211_HWSIM	29 /* virtio mac80211-hwsim */
>  
>  #endif /* _LINUX_VIRTIO_IDS_H */
> -- 
> 2.30.2
> 
