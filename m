Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBE3C25B0C
	for <linux-bluetooth@archiver.kernel.org>; Sun,  7 Aug 2022 23:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbiHGXBF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 7 Aug 2022 19:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiHGXBD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 7 Aug 2022 19:01:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0340CEA1
        for <linux-bluetooth@vger.kernel.org>; Sun,  7 Aug 2022 16:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659913261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wk/43vXNo+gPgeJbUofxRngA+x+b00pdU9F/OSmIEJg=;
        b=d4Haw93S6P+Ob9vovI0K6YtUK1YMS9QUndcebBQFJuXycWL4zFfmnmZ5m8I6RT0bag5vZQ
        SnI/ujRH5rTCulYGcc7eXwvBo9hZjkm4q1ytuL05Xn444tD5aS5CEPl0AjMfI1fHoY9Gc8
        sEMiIhQ5I+isPuw1QKQUui1aC7JxJkM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-oklUo8uCNoOyZx1kk-J4YQ-1; Sun, 07 Aug 2022 19:00:59 -0400
X-MC-Unique: oklUo8uCNoOyZx1kk-J4YQ-1
Received: by mail-wm1-f70.google.com with SMTP id n1-20020a7bcbc1000000b003a4e8c818f5so1086127wmi.6
        for <linux-bluetooth@vger.kernel.org>; Sun, 07 Aug 2022 16:00:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=Wk/43vXNo+gPgeJbUofxRngA+x+b00pdU9F/OSmIEJg=;
        b=TbmI/p/qOHgRzkw47IfQ5KOzYzjCpZRF0nG5kXFDu1KSeq1EqlL8to7U39902p9P9n
         ZT2O2Eot4HaBDJconDYlThF3evNm7z6liEb2cRrkR2PXazB9hsVsblBiacfAKueRALpV
         kF5ZEoo73yFkf3V1kWI+Sr00VGqYlEfRmEqF7S5+fuVtvuX8XY5zWCFli9VxiL4RSuT4
         rbuoclnW/IG8xxKd0YJ1EXHhroNNF/+SdiuiepEq4aMcNGzRvcvn+5iHw8hlUX+LhJUy
         egCT+bFVzQ6O6oDHmrRq7RIW+7vgErW71YPJRDoTMy8glfgXWJP3Yogy7NkdKdspeBUc
         17dA==
X-Gm-Message-State: ACgBeo2rH/6rA4Tx57pnhmNDKD9Nyak0f9MunaerIKdqFtus96W0CXt3
        19s564gqpedRgZvxdQwCtuHC6Ih6Fhs844+PbsTQvvjmH8ZgLiH/4clb5B1Tn3XR/hUZ7W7h5QQ
        oSCSAeiE8H0C63y4t0awQVejcfFWb
X-Received: by 2002:adf:e111:0:b0:21d:665e:2fa5 with SMTP id t17-20020adfe111000000b0021d665e2fa5mr10319218wrz.652.1659913258546;
        Sun, 07 Aug 2022 16:00:58 -0700 (PDT)
X-Google-Smtp-Source: AA6agR77jXqn3s6KfigLdRwFaDgPm/WuGZ/eUbqehSUKychxT4mkfEwdiEmUEE/nolidYa5kAcIEuw==
X-Received: by 2002:adf:e111:0:b0:21d:665e:2fa5 with SMTP id t17-20020adfe111000000b0021d665e2fa5mr10319205wrz.652.1659913258316;
        Sun, 07 Aug 2022 16:00:58 -0700 (PDT)
Received: from redhat.com ([2.52.21.123])
        by smtp.gmail.com with ESMTPSA id u7-20020a05600c210700b003a3561d4f3fsm916915wml.43.2022.08.07.16.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Aug 2022 16:00:57 -0700 (PDT)
Date:   Sun, 7 Aug 2022 19:00:54 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Igor Skalkin <Igor.Skalkin@opensynergy.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] virtio_bt: Fix alignment in configuration struct
Message-ID: <20220807185846-mutt-send-email-mst@kernel.org>
References: <20220807221152.38948-1-Igor.Skalkin@opensynergy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220807221152.38948-1-Igor.Skalkin@opensynergy.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, Aug 08, 2022 at 12:11:52AM +0200, Igor Skalkin wrote:
> According to specification [1], "For the device-specific configuration
> space, the driver MUST use 8 bit wide accesses for 8 bit wide fields,
> 16 bit wide and aligned accesses for 16 bit wide fields and 32 bit wide
> and aligned accesses for 32 and 64 bit wide fields.".
> 
> Current version of the configuration structure:
> 
>     struct virtio_bt_config {
>         __u8  type;
>         __u16 vendor;
>         __u16 msft_opcode;
>     } __attribute__((packed));
> 
> has both 16bit fields non-aligned.
> 
> This commit fixes it.
> 
> [1] https://docs.oasis-open.org/virtio/virtio/v1.1/virtio-v1.1.pdf
> 
> Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>

This is all true enough, but the problem is
1. changing uapi like this can't be done, will break userspace
2. the driver has more issues and no one seems to want to
   maintain it. 
I posted a patch "Bluetooth: virtio_bt: mark broken" and intend
to merge it for this release.


> ---
>  include/uapi/linux/virtio_bt.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/virtio_bt.h b/include/uapi/linux/virtio_bt.h
> index a7bd48daa9a9..adc03709cc4f 100644
> --- a/include/uapi/linux/virtio_bt.h
> +++ b/include/uapi/linux/virtio_bt.h
> @@ -23,9 +23,9 @@ enum virtio_bt_config_vendor {
>  };
>  
>  struct virtio_bt_config {
> -	__u8  type;
>  	__u16 vendor;
>  	__u16 msft_opcode;
> +	__u8  type;
>  } __attribute__((packed));
>  
>  #endif /* _UAPI_LINUX_VIRTIO_BT_H */
> -- 
> 2.34.1

