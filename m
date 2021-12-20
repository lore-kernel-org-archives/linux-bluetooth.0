Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8325C433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Dec 2021 23:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbhLTXSF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Dec 2021 18:18:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45016 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232904AbhLTXSD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Dec 2021 18:18:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640042283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dupHnr1Qrf5/2vVv3UmTvRv7dAC+oVN4XvKLAZ5rPaU=;
        b=W3LhIgSNORLJ34XDqmnl2UMyThhxboyl2sK66IEZlbdrgs32MZFiJVc2pxhzqvcUhbAqR9
        2bxLBED0q2j9MYoS2AXjK5AUNvpWZrUrR5xaUgTd1nVmcWf9W7EYUbJ3k8maRjk9v3Qtzm
        qGUR/4wgvZbI8GW+f1e/HHVGAyo9llY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-348-qryd57MBMASNzoWjOfDHAw-1; Mon, 20 Dec 2021 18:18:02 -0500
X-MC-Unique: qryd57MBMASNzoWjOfDHAw-1
Received: by mail-ed1-f71.google.com with SMTP id s7-20020a056402520700b003f841380832so4426606edd.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Dec 2021 15:18:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dupHnr1Qrf5/2vVv3UmTvRv7dAC+oVN4XvKLAZ5rPaU=;
        b=2L9VCWG8rUoqvyxl3gwL6GR9ZLn28miBhGv3Mahh4R+H9vBUat8N7TanS+Dby/cX52
         V1dhoRt+IRU+n+nMZlUxpVN0BM0cfTHcvtWDfG/VwGii4scvCteTR8iwLhxQNsWlFRTQ
         a5NylsXMuCCN7CxMNSYYyvdEzleFh7q22UzJNbfNAAciTRJp1uKHZNlBUCYkZjK1M2Qn
         h9+hRhCz83MjN2Ukt/PUNACCua2vj7eKmcgB7L7tS2dEjppDLRz888bTIYjMgnXM/rfy
         4T+7Z0eDzTjDWggRmYYveph19b+VeoJUuHYEXWreiIWo1JeR1rFFK+YPUUQGDQvCC/KC
         7Keg==
X-Gm-Message-State: AOAM5325XmTJiCOUbnCurkZvpW1Ur43HGZTeY5bk4ayNZprZz5AlRPlz
        vTubEHxtx5VBIc6Dldt3ofJ6iziY+BTyt8DcwaOF1Ktd8pxUc8MXW601TspFqSMTWim9Tk3ssqd
        KIaXcGCAhnskcQ5WWDMKZk25w0Tfb
X-Received: by 2002:a05:6402:1e8a:: with SMTP id f10mr432446edf.52.1640042280878;
        Mon, 20 Dec 2021 15:18:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwjQ1NiOLIUaKBrs0mEsvhRTd0VTcOiAycGdRQEwXY1ZWGNyFRTnIYiai77LgXzpCRFxu198Q==
X-Received: by 2002:a05:6402:1e8a:: with SMTP id f10mr432432edf.52.1640042280743;
        Mon, 20 Dec 2021 15:18:00 -0800 (PST)
Received: from redhat.com ([2.55.141.192])
        by smtp.gmail.com with ESMTPSA id z7sm137955edb.59.2021.12.20.15.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 15:18:00 -0800 (PST)
Date:   Mon, 20 Dec 2021 18:17:56 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: virtio_bt: fix an error code in probe()
Message-ID: <20211220181751-mutt-send-email-mst@kernel.org>
References: <20211215114644.GC14552@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215114644.GC14552@kili>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, Dec 15, 2021 at 02:46:45PM +0300, Dan Carpenter wrote:
> Return an error code if virtbt_open_vdev() fails.  Don't return success.
> 
> Fixes: 212a6e51a630 ("Bluetooth: virtio_bt: fix device removal")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> 
> This almost certainly goes through Michael's virt tree and not the
> Bluetooth tree.
> 
>  drivers/bluetooth/virtio_bt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
> index 1dd734aef87b..f6d699fed139 100644
> --- a/drivers/bluetooth/virtio_bt.c
> +++ b/drivers/bluetooth/virtio_bt.c
> @@ -362,7 +362,8 @@ static int virtbt_probe(struct virtio_device *vdev)
>  	}
>  
>  	virtio_device_ready(vdev);
> -	if (virtbt_open_vdev(vbt))
> +	err = virtbt_open_vdev(vbt);
> +	if (err)
>  		goto open_failed;
>  
>  	return 0;
> -- 
> 2.20.1

