Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E543C7EE29
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Jun 2023 15:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242005AbjFIP6N (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 9 Jun 2023 11:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242004AbjFIP6L (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 9 Jun 2023 11:58:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1F53588
        for <linux-bluetooth@vger.kernel.org>; Fri,  9 Jun 2023 08:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686326243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+y+aveIxA7jLi8Qb8e+Oc4pjTAYvwXvNOc23v+nQ9Dc=;
        b=NerPZvO4grO/Fuju0J6ewWh5D8IyuYOWdNrgV3C2wnx7My57QcMv8zs1u0ugmDXPfA0fOY
        u4GjakLTV1WzLS71ycnuhR/fr63dY2Gft/UMT51Q5yw8F6/3bzRKsAg3rS9XKFb3oEbkuV
        YEjZPe3Yj+4jpDk2IziTVIQfyYmJSIQ=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-BLbJY18qMyy3J-EnJQoPvA-1; Fri, 09 Jun 2023 11:57:21 -0400
X-MC-Unique: BLbJY18qMyy3J-EnJQoPvA-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-4f624a4ea72so1406883e87.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Jun 2023 08:57:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686326240; x=1688918240;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+y+aveIxA7jLi8Qb8e+Oc4pjTAYvwXvNOc23v+nQ9Dc=;
        b=BFTuDN3BXcEjdYuAMSDcub4pY3vsOdJm3tozOjAGJG5vkfF+9AEsYOhyzMFc0gLOjC
         7XxOlIlP6pE631XQLnozrSq+d7WaAI8IOFv2aUSkh295SmsQwaKJbv79Ez61PUAXQssq
         WrkTrRNirG8LOng39HhBMGg5+2Mpm72ygCpf1Q3LagraH3BQWUFrn3ZhV3B+IOdxzSNC
         nFhyqjN5WkcOggqFmVLWxZXD5T8MzHQEimelCJJIe926XoJ7hdvt11BxbabMv2EGoGcw
         gPenT5W1zoeOPtrTBnIcr+ObNS3jUoCYheP/O6GSsvwd4tIm4v1v0zd6K41fdZXnk/sR
         83Sg==
X-Gm-Message-State: AC+VfDwHJwS5ugICUeI2KrYlQIy8WsTRxoG0ogRO/tY2vZlSi2s+E/MU
        qNWO86OGncwsVr6Myvxwvs0gjgHZkFyL5zfhsluO8PPJe/PovX/wH44dzqygrFn/qWZQwCHYq/6
        HKR9b2WKVnfjnEM89fKaak+KMZzYX
X-Received: by 2002:a19:f24f:0:b0:4f5:f736:cb9f with SMTP id d15-20020a19f24f000000b004f5f736cb9fmr989544lfk.67.1686326240279;
        Fri, 09 Jun 2023 08:57:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4/T5/nSOeffmIMMxsU83CU4sVcwwjp3dmRwDnOHHwbrP+YSlBuBwmQ6CY/6oW8GCAvWshWtA==
X-Received: by 2002:a19:f24f:0:b0:4f5:f736:cb9f with SMTP id d15-20020a19f24f000000b004f5f736cb9fmr989534lfk.67.1686326239964;
        Fri, 09 Jun 2023 08:57:19 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7403:2800:22a6:7656:500:4dab])
        by smtp.gmail.com with ESMTPSA id m7-20020a7bca47000000b003f80b96097esm415596wml.31.2023.06.09.08.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 08:57:19 -0700 (PDT)
Date:   Fri, 9 Jun 2023 11:57:16 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xianting Tian <xianting.tian@linux.alibaba.com>
Cc:     arei.gonglei@huawei.com, jasowang@redhat.com,
        xuanzhuo@linux.alibaba.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, amit@kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xianting Tian <tianxianting.txt@alibaba-inc.com>
Subject: Re: [PATCH 1/3] virtio-crypto: fixup potential cpu stall when free
 unused bufs
Message-ID: <20230609115617-mutt-send-email-mst@kernel.org>
References: <20230609131817.712867-1-xianting.tian@linux.alibaba.com>
 <20230609131817.712867-2-xianting.tian@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609131817.712867-2-xianting.tian@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, Jun 09, 2023 at 09:18:15PM +0800, Xianting Tian wrote:
> From: Xianting Tian <tianxianting.txt@alibaba-inc.com>
> 
> Cpu stall issue may happen if device is configured with multi queues
> and large queue depth, so fix it.

What does "may happen" imply exactly?
was this observed?

> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
> ---
>  drivers/crypto/virtio/virtio_crypto_core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/crypto/virtio/virtio_crypto_core.c b/drivers/crypto/virtio/virtio_crypto_core.c
> index 1198bd306365..94849fa3bd74 100644
> --- a/drivers/crypto/virtio/virtio_crypto_core.c
> +++ b/drivers/crypto/virtio/virtio_crypto_core.c
> @@ -480,6 +480,7 @@ static void virtcrypto_free_unused_reqs(struct virtio_crypto *vcrypto)
>  			kfree(vc_req->req_data);
>  			kfree(vc_req->sgs);
>  		}
> +		cond_resched();
>  	}
>  }
>  
> -- 
> 2.17.1

