Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B45477E40
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 23:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785454678; cv=none; b=UhTjyesLnxGlxD52/LyxCkwLxoi9vSQv48zGX1WzdB2bDajk+3dlSOt0iLWIi3GcPD/O+/QvWeIEscg7iLYLWl/aWSbhlcfgnC25S1qA6bvzXSlDjNdCwvDsCDGfQsyCVdfld1xN0wd/vYLOa0hmrxR8dWdM1Zq831uWlr06rrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785454678; c=relaxed/simple;
	bh=mfEoOh7OlkRlu5acKyPr/YxBMOBzAf91Z7JV8VqlT8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mwf4srn5qk4Qr9BW/VhEgewOBT4yiv5TKnd5bSMJyKRq6LSHKpRUDqC23igFq6aINWnZd9LpjxatcJqXCn5qtKQclnu518ZBgUq6vQFZYAM6vlzcSiE5NWkGxv+08cUUyUxx+aozLsuenCkmLZTNSlOj4u/pDXcfhLmRO0u5iik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dTLwXRto; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hc0BoW5A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dTLwXRto";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hc0BoW5A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785454675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C45f6c51+m57hpeZ9zwBgTF6eOfqSwMmzmRci27jKDo=;
	b=dTLwXRtogUZikx/NS/gkP2n2lu0rcs7lKc4W2CxW58yzTh0AH0YcrZPGjHnYIVTCFFXz1a
	5ASR6rz4XjkJgDc5l7mHr9w/LrtN6sUlx+9an/2bhCX3tPK/RF0TDO4BnjLLCXG044z8dR
	GhlTn2upoPiCzVnyQr3a54NbVhYhQQk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-uPBtUJQ9MeaYaYw5JOJnpw-1; Thu, 30 Jul 2026 19:37:54 -0400
X-MC-Unique: uPBtUJQ9MeaYaYw5JOJnpw-1
X-Mimecast-MFC-AGG-ID: uPBtUJQ9MeaYaYw5JOJnpw_1785454673
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47f8158485eso191499f8f.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 16:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785454673; x=1786059473; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C45f6c51+m57hpeZ9zwBgTF6eOfqSwMmzmRci27jKDo=;
        b=Hc0BoW5AKkEhZf0wb/Q265d/K5tkIgC/yMnNDzwSDjZBao0aXSZMsTKBimzuvOOux7
         ud7osZMapoAgv43eiR9nu9f9EmDX8eUVaQLwBKTto5o8Zj2isKnEGyhynK2bZhQZ+pmC
         gAemS/m7BdR1mqg11xcpRWRg/PQGiJME9T8WPFldOYAD3JTp0RMeGKDBtjZRvJwKHzcn
         V8/Cbsby/IC8Px3Z5NMG+JhHhrxUv9zVXy65VnbpzYz9sQuY1RFX3AsKdNXIjm8k3PNn
         34k5bxwdp8WOx0YZpNL6tcdgLy9MKZ+kouHID0rC96OJ1yWrTkeU9m3J/1KmR8CJl7RF
         7b2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785454673; x=1786059473;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C45f6c51+m57hpeZ9zwBgTF6eOfqSwMmzmRci27jKDo=;
        b=XZUk73KMRPF1NmcOS0ES4o4G6t+ejkQa79uFoBjgkQ+PO5tBZ2uK17h3XRn4iSwKZH
         Bsma0n3IprEM6Vq8GqT8fNxNCRTzEri+E6Hcn52jOm/XLEazRuFzbQIgsp3Z8aaWSoEd
         ZpR/HrCXVyI9+EAviOhuKPiVsQ4R4kq9++4nbz3Ws7TIIPBkiTJ9zrFaiVlL/YkkWP1R
         uzZmt9WivIh91X0SHszBQIE00P6cjyQNatit0ApPRBsNsRIl6CenuU+ogcLnS+TQBeSL
         NgTClGPAzKmqvQo8KJHgGwIRL8yJq204zzcOarnvIonKCZsrT3vXB/0dJrs2Lo6cn0fm
         jmIA==
X-Forwarded-Encrypted: i=1; AHgh+Rp7fSIbp5p1NXI8Vi/mFM1leB9U8UzwWrehj4gn3V/rdFfjWSgT/LgaQwbndnrDP+mrs+pVp6pGweVAdOhYORY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbFKSPkOjphBGNEyfKYhvu/AxyB+ACSrfhIt5Uxr0GipIcZExt
	zdKkEAad9vBi4UzkpzUC6mXVYd9FhG9yT3oKugUK4Ig8W3t+Yg1+EOJXXAf6rHduvIvFDGbbw6c
	HePm0PBLQvc0zTDsUeTnkCSEcHvODlPevEJ8w8YD+5HzC65iMEix4mHpjB533EGeawDGVyg==
X-Gm-Gg: AR+sD10GtRGJNSLg42E3ccE3DZP1KDQIKa9dIaDAF4ZcRSBbSEAcUqUdkQu4dR+IK8I
	dtWTBOAvMNXz7W+kCng58i7ZbIqALwm8StTA18JOQXjJs7IlScTetPbYuq4gc89F5GpXqJCGxP+
	5bvCv4awf5IFG3Lzje1BJsmLShZVa2C77utLpXHJd7GvjsyOkg+EoYaYpHNy9XPlKqOy/FmUqnZ
	GO0wS37B1VQrz8ISfxTVKNszaEhizUKVnejyPiEQhmrC/cqweTNrjWB76yP/U9k7gQ4Ytxv1iOD
	jyZ6UKHtQaSLLNOpQcztWhx65DWCUjOSWiLUnrZbFL1rS+Sz9sMmuWRNizpocsq3Q8OEClEnoSs
	TTSn+ju4PUriW64Z9rUpeAv4=
X-Received: by 2002:a05:6000:40cd:b0:47f:7129:6e2d with SMTP id ffacd0b85a97d-47fc80cc992mr7021625f8f.17.1785454672632;
        Thu, 30 Jul 2026 16:37:52 -0700 (PDT)
X-Received: by 2002:a05:6000:40cd:b0:47f:7129:6e2d with SMTP id ffacd0b85a97d-47fc80cc992mr7021592f8f.17.1785454672234;
        Thu, 30 Jul 2026 16:37:52 -0700 (PDT)
Received: from redhat.com (ppp-94-66-118-61.home.otenet.gr. [94.66.118.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fc892cc5fsm8222264f8f.24.2026.07.30.16.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 16:37:50 -0700 (PDT)
Date: Thu, 30 Jul 2026 19:37:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Carpenter <error27@gmail.com>
Cc: Haoxiang Li <haoxiang_li2024@163.com>, marcel@holtmann.org,
	luiz.dentz@gmail.com, yangyingliang@huawei.com,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] Bluetooth: virtio: Fix virtbt_probe() init and cleanup
Message-ID: <20260730193717-mutt-send-email-mst@kernel.org>
References: <20260709114745.4030794-1-haoxiang_li2024@163.com>
 <ak-T4SMxr4rw10jP@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ak-T4SMxr4rw10jP@stanley.mountain>

On Thu, Jul 09, 2026 at 03:28:17PM +0300, Dan Carpenter wrote:
> On Thu, Jul 09, 2026 at 07:47:45PM +0800, Haoxiang Li wrote:
> > virtbt_probe() allocates vbt before setting up the virtqueues, but some
> > failure paths return without freeing it.
> > 
> > The probe path also registers the HCI device before the virtio transport
> > is opened. Since hci_register_dev() makes the HCI device visible and queues
> > power_on work, move it after virtio_device_ready() and virtbt_open_vdev()
> > so the transport is ready before the HCI core can use it.
> > 
> > On failures after DRIVER_OK, reset and close the virtio device before
> > deleting the virtqueues and freeing vbt. This also cancels pending rx work
> > before vbt is freed.
> > 
> > Fixes: afd2daa26c7a ("Bluetooth: Add support for virtio transport driver")
> > Fixes: dc65b4b0f90a ("Bluetooth: virtio_bt: fix device removal")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> > ---
> > Changes in v2:
> >  - Rework virtbt_probe() error paths into an unwind ladder.
> >  - Free vbt on probe failures.
> >  - Reset the virtio device and unregister the HCI device before freeing it
> >    when virtbt_open_vdev() fails.
> >  - Close the virtio device before unregistering the HCI device in remove().
> > 
> >    Thanks Dan for the suggestions. The blog is very helpful.
> > 
> > Changes in v3:
> >  - Remove virtio_reset_device() from the virtbt_open_vdev() failure path.
> > 
> > Changes in v4:
> >  - Move hci_register_dev() after virtio_device_ready() and virtbt_open_vdev().
> >  - Reset and close the virtio device on probe failures after DRIVER_OK. Thanks, Luiz!
> 
> These are Sashiko warnings.  To be honest, I would feel really
> uncomfortable blindly applying them without testing.

sashiko is right adding bufffers before driver ok is a spec violation.

>  If someone
> can test, then great.  Otherwise, I would probably apply v3.  The
> stuff that Sashiko complained about was all pre-existing issues
> even though for the last one it said it wasn't but it was.
> 
> regards,
> dan carpenter

