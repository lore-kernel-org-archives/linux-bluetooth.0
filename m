Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F20C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Jan 2022 12:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238940AbiAFMh6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Jan 2022 07:37:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20255 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238923AbiAFMh5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Jan 2022 07:37:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641472676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jJ4AegNPO6vsl4abN8kyuyyI2P0Z3WaDeYeMCwwoYiM=;
        b=Vs2qLuQQxlkXzZMV/pNkI49uEKH4oJHTZN0LYKPUBOPe/mZC5VWhk2aHz2nDdRpCQz/koz
        CpoLSp2R1Oi/wI8pwGBC/kEJgjuYYzu3to3YpWkv33iNTmOo49cg90VvyOd2ZzJaDkuLkU
        kr+EOiTgi2O++LV7obHJfL5ckXVTEAM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-482-kBJM1fs-Oaa8fFpLjx7xZg-1; Thu, 06 Jan 2022 07:37:55 -0500
X-MC-Unique: kBJM1fs-Oaa8fFpLjx7xZg-1
Received: by mail-wr1-f69.google.com with SMTP id h12-20020adfa4cc000000b001a22dceda69so1192679wrb.16
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Jan 2022 04:37:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jJ4AegNPO6vsl4abN8kyuyyI2P0Z3WaDeYeMCwwoYiM=;
        b=C6q/eJfJSlV4UZyuIysvVyIXdEYqs0GsvoHIz0rbDm+IXuYHN8HcpUfvy0q0gfZkku
         +VzWT2XPpnzZ7O94DuDF5myLxNfAdFJdLO1B0/HN/nXFsOLgsdooeyIuzqPS62BWekj+
         ixCbXuNQKx3CHX4AbaX1ImKUFWFdUSvNYaFvHvE8uoXa3atdoBScUWyxZ0nsk1dfNimv
         gzOTm1rXKkM5RSnyi9GXEuF8Ocdt7IwFfGk1lTZKW9C2GeRzjeT31As2KD6/T/KhKsLm
         I+RPVRTG+to3OjJXceWxTyTPOsxSZ6PJCuErQSWYBRZb/7qoVmjZor8fWwSm3wa7NjNc
         icvQ==
X-Gm-Message-State: AOAM530j802hx8rBlz5hqN816wSVtzbZfvJGyaTHurS5EzDnuL36iHRZ
        EdOJqZJnGoj/e8LjAq7O3Mr6gXB9ivNuCGOEMFf4YBVbpoS3AXrOnvg+cSXn6E/hQ157NRZ9RdQ
        xG6hn5NYI6xs25cBYo//ZBczfjXfT
X-Received: by 2002:a05:6000:1e07:: with SMTP id bj7mr1146114wrb.126.1641472674121;
        Thu, 06 Jan 2022 04:37:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyG/A1BqNVd1haFJ0iTmtQlqq3s/ApDw8YMYUayVU1H5zCFU1DjFGkVukDo66U7gSx2OBM3Fg==
X-Received: by 2002:a05:6000:1e07:: with SMTP id bj7mr1146101wrb.126.1641472673917;
        Thu, 06 Jan 2022 04:37:53 -0800 (PST)
Received: from redhat.com ([2a03:c5c0:207e:991b:6857:5652:b903:a63b])
        by smtp.gmail.com with ESMTPSA id j11sm35455wrx.5.2022.01.06.04.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 04:37:53 -0800 (PST)
Date:   Thu, 6 Jan 2022 07:37:50 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Subject: Re: [PATCH -next] Bluetooth: virtio_bt: fix error return code in
 virtbt_probe()
Message-ID: <20220106073725-mutt-send-email-mst@kernel.org>
References: <20211213082751.745001-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213082751.745001-1-yangyingliang@huawei.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, Dec 13, 2021 at 04:27:51PM +0800, Yang Yingliang wrote:
> Fix to return a negative error code from the error handling
> case in virtbt_probe().
> 
> Fixes: 212a6e51a630 ("Bluetooth: virtio_bt: fix device removal")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

same patch was also posted by Dan Carpenter.

> ---
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
> 2.25.1

