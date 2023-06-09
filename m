Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBDCC7EE29
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Jun 2023 16:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbjFIQGg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 9 Jun 2023 12:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjFIQGe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 9 Jun 2023 12:06:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A003830CD
        for <linux-bluetooth@vger.kernel.org>; Fri,  9 Jun 2023 09:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686326756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+M7az6Jbp6Oqou6iuD63oUNoAb5aXxDturRi9Hwe0gE=;
        b=fVDQ1EQQ7MRcF7UQYQb+moorGNHLddwoUZbME7I3Z9x2490NtoZLjp9K8hXA0KamUnSUED
        XejCYheOQYeoBIC/pBtHHLCF7ZziBdlE7ZenuiEjRfRl9Vpfyz353W2bPbVfjzH08ZyI6A
        ZLnkj/dzO5WzMpXHFFHz93OCLsezdsA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-TSJ0guvUMoSPG2AWQtrrXQ-1; Fri, 09 Jun 2023 12:05:55 -0400
X-MC-Unique: TSJ0guvUMoSPG2AWQtrrXQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-30b218c0bbbso749310f8f.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Jun 2023 09:05:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686326754; x=1688918754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+M7az6Jbp6Oqou6iuD63oUNoAb5aXxDturRi9Hwe0gE=;
        b=Olopw3J71NcIc544cbVB806rZCbyCi7qZyqYpJwPcLN+AcCzh1iSQzLOARMMgYQnCR
         QX57hcnSxOx76eQTpq2gOPBy9aXmgXEVK/iLjWZ8VEOJjUfZOhZATouHHIHnoIS6BJpY
         +Wmo/iSD6OI9G3sMu5QwDJW1NBQGYt/BzWqorU2gU1RM+nEBWOnE+cebThoYlWcEXQkU
         rSN4r0TMXYCZo0bXEMrtzsGFyJSnelqw1PSX2bHuTCmp7Vixoi1wiNeYwz0FBDx1Icw1
         odKGYwZEg0YYlSywQhWqGBmD7f1342ULqR8y+sjA4OXh9q5R7KWsOCLsdNZq5fvvUEcE
         ct4A==
X-Gm-Message-State: AC+VfDzOMMdnMYvGObNEVaW3pVse45YBKhlRzmy4y2+cFJNHEPi/zzKd
        p4nxKPDGiLII3DJPWO70NUme72FyPDRAad0zB59wC6mw9W1m38oVkySKAzwfZFIE/C0HOY9mc2i
        tw9Uq2E6Oy/QRZTBv6UtY34zxSKy/jB+POykt
X-Received: by 2002:a5d:4e88:0:b0:309:41d8:eec4 with SMTP id e8-20020a5d4e88000000b0030941d8eec4mr1062148wru.39.1686326754291;
        Fri, 09 Jun 2023 09:05:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ70iwfwN+298k3OOZDF7xlgm6Z2CMUhRp6FaLoDmzGdsg4L4C82nksLMOKVyP8jx0VshOn9wQ==
X-Received: by 2002:a5d:4e88:0:b0:309:41d8:eec4 with SMTP id e8-20020a5d4e88000000b0030941d8eec4mr1062133wru.39.1686326753971;
        Fri, 09 Jun 2023 09:05:53 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7403:2800:22a6:7656:500:4dab])
        by smtp.gmail.com with ESMTPSA id p13-20020a5d4e0d000000b002fb60c7995esm4841314wrt.8.2023.06.09.09.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 09:05:53 -0700 (PDT)
Date:   Fri, 9 Jun 2023 12:05:50 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xianting Tian <xianting.tian@linux.alibaba.com>
Cc:     arei.gonglei@huawei.com, jasowang@redhat.com,
        xuanzhuo@linux.alibaba.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, amit@kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] virtio_console: fixup potential cpu stall when free
 unused bufs
Message-ID: <20230609120332-mutt-send-email-mst@kernel.org>
References: <20230609131817.712867-1-xianting.tian@linux.alibaba.com>
 <20230609131817.712867-3-xianting.tian@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609131817.712867-3-xianting.tian@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, Jun 09, 2023 at 09:18:16PM +0800, Xianting Tian wrote:
> Cpu stall issue may happen if device is configured with multi queues
> and large queue depth, so fix it.

"may happen" is ambigous.

So is this: "for virtio-net we were getting
stall on CPU was observed message, this driver is similar
so theoretically the same logic applies"

or is this

"the following error occured: ..... "

?


> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
> ---
>  drivers/char/virtio_console.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index b65c809a4e97..5ec4cf4ea919 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -1935,6 +1935,7 @@ static void remove_vqs(struct ports_device *portdev)
>  		flush_bufs(vq, true);
>  		while ((buf = virtqueue_detach_unused_buf(vq)))
>  			free_buf(buf, true);
> +		cond_resched();
>  	}
>  	portdev->vdev->config->del_vqs(portdev->vdev);
>  	kfree(portdev->in_vqs);
> -- 
> 2.17.1

