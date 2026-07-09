Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82601423784
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jul 2026 12:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783600564; cv=none; b=MMSAxZQgrD+P74hYzkxoAycI8qUUIibfb/a8DirS0Uw1BKfk1XWMSj7ltMTo5VONLCo3OSOzp5Vv+Nq01hqSO9IyZF7r17RIbUgay/fpA9nOAWhMhvGuTskmzj7wozl5q8ZMDlu/OGyLBDMS6pUuo21b/Qe991HxHnNO/tAwEBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783600564; c=relaxed/simple;
	bh=NSo38pDc1eVh2/8p7VPNDCyMGIBx7hC/7KIx3fE8Cm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kbSCqL9UANjHEqF2RAVSjj969reBMR0pOP1oRuvuL8X81WDnrzRJIk+E3ZCNSaPLV2C6zra1BFd1WI1wsnxWtY/D7j4hwWzya2xhXblHY6IRfSr/SjL60JruT1gpKd7CtQwk3yrWmuB/zDN9gxL1ojN/X3BDV7FmosyVTRU/Fq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ASSTiXRu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lDynUwvn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ASSTiXRu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lDynUwvn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783600560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9TRaYW74lwvjeB0Mjr9azQ+EOAQDWI3D3JYBl5wHMsY=;
	b=ASSTiXRuYwu84IGwYNXMngC+gZV7K+xdzE3C/CXZ3re4IQWfx0qRuLDVCR34HhzQWZ4TQo
	s/jWXfV7N5NeOmT7XBwb71e+bX9CT5XHLzufaEnMULRIB/4cxfHtI9ZLKv/hoZP1+Ca8st
	TN/ykVxTbdZbSE0FXXSOI0E+qfx/KI4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-BCZOKl8cPJ-1cM_i48kjMg-1; Thu, 09 Jul 2026 08:35:57 -0400
X-MC-Unique: BCZOKl8cPJ-1cM_i48kjMg-1
X-Mimecast-MFC-AGG-ID: BCZOKl8cPJ-1cM_i48kjMg_1783600556
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4926fa2cb17so7519225e9.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jul 2026 05:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783600556; x=1784205356; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9TRaYW74lwvjeB0Mjr9azQ+EOAQDWI3D3JYBl5wHMsY=;
        b=lDynUwvnGY7hMSFej5zMMOSaoSkHbHpwEudWDqsngDbc33F3zJ1L+NymtiEVOrQC5H
         2qgaC/IwlxBQ0AF2qC8OP4JB/LkUiVgj3cLkN4exTvDAHfQRgNrqKoN31BYTvGqpeuW6
         AMuyG7igYprftK2uq5eIt1fhKmW1jVImHdPvEWVERJnSZAT9JRsh7+ogfAmcq3mw/Cvp
         BXpS3/YI3QgxNDweRFyQ+XXXkMy7ffkPyg+QJx2x3WP9SyGt1WJ9sPPHx6xLoNXdIInP
         fEsGPmQIT3T5XhhVimaOIskFKhbsjTBMGSrgbiwyQ+I4MPpoZ7PGyEJWngdryV8awAyt
         VCiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783600556; x=1784205356;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9TRaYW74lwvjeB0Mjr9azQ+EOAQDWI3D3JYBl5wHMsY=;
        b=r6p6DIEno6+QCHgbJLClwn6dh1e1o26OWqcuDjWZU3xaMqdmcWlIUiyfasGFQrWWOq
         sFun73D8wqZxMCNpDxqKoTVDyiwskcRcamcndEfAuD1IVUd7IE3I4n5BP4gGoDiIoEzj
         r1JVqIJfQnhbLhLDpnMR2Cu/3KQxy9x9t9ECbjCyK7MOB9Vw7pYNkAhq1xj08yuE/ZRs
         la1SK5OfPUMX24No59Wsoz+drd6qNd9WdFUpaXtGPjcGcxcVy744kUNeUC4r8n69jR+V
         mIten3yBYcasBjx1vki4Fe0reVlyPy50q2+alVAcOLIu5PkLNCM+Njao0RxeV2zmVhZP
         PhSg==
X-Forwarded-Encrypted: i=1; AHgh+Ro/5XqTmsMNhq4Y2mGpbWTJHJe+LIeWh12XRmm7imj8tQoyeO6Ji/lKNhgejcUexGGfJD2pNiw2fIK+IryuIb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNMGpc0bHJqJq5bQgfy36UpuGePtfHV1UBrFdFzaqBao5tISZw
	IZBpYtbt46R3J3uwN4Yi4I9X4LRvh2dU2rvJqgCZfwkPUfMqFxRI1W+V0gMOocaAZS+3Ixuw4Pa
	sCFggzpdbSuWaFXGp8YygVldQk9mQ+1Ir7wuxLLu3l/l4w4Nx8IduD5KUHh0+a0+H9jHfaQ==
X-Gm-Gg: AfdE7cm5ynJXPXkFDw9tZ3EhZVKYPOcEj/sTdgYf35aKAzV/T6l1AGSXfsSIOyX6cEm
	OjXlH8ZxbXM1zwqV0qTq5Oa1KjTz4Mj+a8EASW++QSPcOQl5tMWkaJO10dQ8azGrbyQ67zrxeIq
	nkWcGRDn+kW38pP8l/EfBJ389kcdWZKIzKGrfxlxaa8auZFv7yHwMUqPoL2mOs0gyLte2XbHWeL
	JsHTFAQDi85Dip+IFD+G/obnJ/hqTDNMENtsV3u6aV7Vij3uiQwt+S2pa0m8SZK/Ox/CNj69Yg6
	2Tc6uBvgVi3kz3LftFALqxaH2cPlyRoeBLJOMLORSWPKOZaMinuK+lqAKsSSdANWm+EV2hWTRQE
	rhabjoSAIbAl842C/sgYGVz1Uz3Da+WPa
X-Received: by 2002:a05:600c:8b23:b0:493:c991:8e56 with SMTP id 5b1f17b1804b1-493ec561498mr27273215e9.4.1783600555607;
        Thu, 09 Jul 2026 05:35:55 -0700 (PDT)
X-Received: by 2002:a05:600c:8b23:b0:493:c991:8e56 with SMTP id 5b1f17b1804b1-493ec561498mr27272735e9.4.1783600555065;
        Thu, 09 Jul 2026 05:35:55 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6df417sm58554585e9.8.2026.07.09.05.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 05:35:54 -0700 (PDT)
Date: Thu, 9 Jul 2026 08:35:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, yangyingliang@huawei.com,
	error27@gmail.com, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4] Bluetooth: virtio: Fix virtbt_probe() init and cleanup
Message-ID: <20260709083103-mutt-send-email-mst@kernel.org>
References: <20260709114745.4030794-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709114745.4030794-1-haoxiang_li2024@163.com>

Thanks for the patch! one question:

On Thu, Jul 09, 2026 at 07:47:45PM +0800, Haoxiang Li wrote:
> virtbt_probe() allocates vbt before setting up the virtqueues, but some
> failure paths return without freeing it.
> 
> The probe path also registers the HCI device before the virtio transport
> is opened. Since hci_register_dev() makes the HCI device visible and queues
> power_on work, move it after virtio_device_ready() and virtbt_open_vdev()
> so the transport is ready before the HCI core can use it.

Sounds good, and yes it is a spec violation to kick vq before virtio_device_ready

> On failures after DRIVER_OK, reset and close the virtio device before
> deleting the virtqueues and freeing vbt. This also cancels pending rx work
> before vbt is freed.

what "this" cancels pending work? And how can we have work since device was
not registered?

> Fixes: afd2daa26c7a ("Bluetooth: Add support for virtio transport driver")
> Fixes: dc65b4b0f90a ("Bluetooth: virtio_bt: fix device removal")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
> Changes in v2:
>  - Rework virtbt_probe() error paths into an unwind ladder.
>  - Free vbt on probe failures.
>  - Reset the virtio device and unregister the HCI device before freeing it
>    when virtbt_open_vdev() fails.
>  - Close the virtio device before unregistering the HCI device in remove().
> 
>    Thanks Dan for the suggestions. The blog is very helpful.
> 
> Changes in v3:
>  - Remove virtio_reset_device() from the virtbt_open_vdev() failure path.
> 
> Changes in v4:
>  - Move hci_register_dev() after virtio_device_ready() and virtbt_open_vdev().
>  - Reset and close the virtio device on probe failures after DRIVER_OK. Thanks, Luiz!
> ---
>  drivers/bluetooth/virtio_bt.c | 27 ++++++++++++++++-----------
>  1 file changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
> index 140ab55c9fc5..e7e79ba3c1f7 100644
> --- a/drivers/bluetooth/virtio_bt.c
> +++ b/drivers/bluetooth/virtio_bt.c
> @@ -311,12 +311,12 @@ static int virtbt_probe(struct virtio_device *vdev)
>  
>  	err = virtio_find_vqs(vdev, VIRTBT_NUM_VQS, vbt->vqs, vqs_info, NULL);
>  	if (err)
> -		return err;
> +		goto err_free_vbt;
>  
>  	hdev = hci_alloc_dev();
>  	if (!hdev) {
>  		err = -ENOMEM;
> -		goto failed;
> +		goto err_del_vqs;
>  	}
>  
>  	vbt->hdev = hdev;
> @@ -383,23 +383,28 @@ static int virtbt_probe(struct virtio_device *vdev)
>  	if (virtio_has_feature(vdev, VIRTIO_BT_F_AOSP_EXT))
>  		hci_set_aosp_capable(hdev);
>  
> -	if (hci_register_dev(hdev) < 0) {
> -		hci_free_dev(hdev);
> -		err = -EBUSY;
> -		goto failed;
> -	}
> -
>  	virtio_device_ready(vdev);
>  	err = virtbt_open_vdev(vbt);
>  	if (err)
> -		goto open_failed;
> +		goto err_close_vdev;
> +
> +	err = hci_register_dev(hdev);
> +	if (err < 0) {
> +		err = -EBUSY;
> +		goto err_close_vdev;
> +	}
>  
>  	return 0;
>  
> -open_failed:
> +err_close_vdev:
> +	virtio_reset_device(vdev);
> +	virtbt_close_vdev(vbt);
>  	hci_free_dev(hdev);
> -failed:
> +err_del_vqs:
>  	vdev->config->del_vqs(vdev);
> +err_free_vbt:
> +	vdev->priv = NULL;
> +	kfree(vbt);
>  	return err;
>  }
>  
> -- 
> 2.25.1

