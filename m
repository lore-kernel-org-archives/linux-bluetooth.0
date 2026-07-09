Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C4742B749
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jul 2026 12:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783600601; cv=none; b=pw9kadEy2tCaFy8Kk3cIrejfCGUpRIh4qo7tJtJgwcPUXHCagTNNpo1FxmBJXEy6A3KGOGTTNkq4oE13KMHa6nZelU04jwNW8onLZSvRnv/lv6NEiIw9kbDTLu8SxUyE7X7y/zrTjXINxqInQHQB58U6UISs8Qzeq1GH7WE85yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783600601; c=relaxed/simple;
	bh=CdLOGrLsX4K4SEZ10SMqCGElMKDoLo6fIagv31h55LA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ApPriaNX0Z1C/ha6eRKAOBpWC9iXc1yO1f08YjBf4Rlig21FNOhjKVFXY6QZEGFMi2aX/PEcmFyjjboSRwwl9riuAwM0RwWBovhCH8dAQLCZ019bPWdubqSDV/IfbFgy66m50mQTRfwvmxk+DEsyXOHcwBvkd2U1r/I9y+ZfcbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uc8HcZX/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fgg3s5D9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uc8HcZX/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fgg3s5D9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783600598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KavkeeVI7BmP8QSeokBd+WQVOIUMBshHyo5uj4Thjyw=;
	b=Uc8HcZX/7EyCdX/Bu/6+h050DYjVLcsrWz721Padpi18f4M5Cl0VpMQx5ZFP3G46l21USo
	y3YdvMfRHQ9Jp/Mdwc1tk+n2VWz/6qNpRgk9VkJanR9LDiqJFDJnzPXGxin0Sd6bplQFEn
	X4tV0P7LpOdsH8QPfmMXP7bQUUh/Ick=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-8k8R30AMNOa_KlUB-jJLKA-1; Thu, 09 Jul 2026 08:36:37 -0400
X-MC-Unique: 8k8R30AMNOa_KlUB-jJLKA-1
X-Mimecast-MFC-AGG-ID: 8k8R30AMNOa_KlUB-jJLKA_1783600596
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47dee73fdc7so763350f8f.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jul 2026 05:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783600596; x=1784205396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KavkeeVI7BmP8QSeokBd+WQVOIUMBshHyo5uj4Thjyw=;
        b=fgg3s5D957zD8AHoeXv264kTnVOdE0WBXNaxMgh1ftvGLQLU+GBvXB9Gl2XhhWDsIY
         FcHyQMy8BJRk9DLU7qbTvFNb0Xw0rTD/u0eC46EgiAgQz9ItBBQwJ73N/DpXs2TYolDc
         baarJiwdHWluZzThNP4TtUmx444SDqN62Hem/trddGR8M29bvJoDNOPhK8qPiVEzpcS5
         kGxObrAghuoKmNq9VobvbJos/T81V1oHWR27qY93hGn55WsbTq430YGH1RiXXqF+mZ0s
         yjPV6X1rHV+tUqW0fxFblG85aqhwbqTZ1WBr+rnRzbHfZKDEEv9fGzN9UbYBzLr7D0B9
         BJKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783600596; x=1784205396;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KavkeeVI7BmP8QSeokBd+WQVOIUMBshHyo5uj4Thjyw=;
        b=P6BGq2d8lGPKVuWeE2QR4TUxJji+gqhRgpTlkcH3Kea+sHFgDgkEHVfzT/0gCk5BAM
         suJ7BCr/losbpWtoP6U3p5Q+nPFTgFC3owpxBwXJpu+Otxe0cDsmFF57iAki/CcVO5co
         JnuxsN5V8B2GaAqci8Cy3uyfx5qpuE3WriORu5Ay7a698tsQZpF/Qhin79P9gAaooZBE
         CFPg1TltIvBrJ9Ms4Jl0cVIvZkHHcIxZDAepe+WQuLngtVu03S4g/MgDeL0oeJvovGKm
         UMcUxztRy5uwGV8Z4yHcdYXTcNB0AFyI0/gGi9xiCzYHLWxAAi2vD8Jobmj/6SEfD04/
         NEiw==
X-Forwarded-Encrypted: i=1; AHgh+RrIr0b285+HT+uSfF+Iq4NdW5830UFk2eHY1I1lJIxCAvgEJQOuZFHtPmzVvcMiwPq0mTwPB/q6fMPSWo5gOJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMScVTUUNv+6M/RfEXmNlJaqPaY09rwOsKSxAuuGfD7Swft45n
	Spd2X4mJ1WnGxtcKpnOjEIED5ynUHPUDzO3n9KYY9q2xyFutlqdsNd0wjYJdnWGTSVoPg658kxT
	eQESfyYvPyYx979JaCkDre+bWRQaqVfDaKlapyFRsaykvqrDLf1PLpgPju8ZAQj7+e6Twhg==
X-Gm-Gg: AfdE7ck9q7voa3L7iCO18J37rTQQm9Vnw0hEkWYHqyTvtIGmKA6+ExUtgXySbqCg0HU
	9HhCaKeFKwygRHNeGDKqDamBU8DxaXNbjnoq5RF1ib05X6rY2YXWv6gB6oL8lUeMTbJWp6CY36E
	cxy1QRBIUwxnLag3QE42Ok6X+4nNjkgwlXaTOsxfq2qKi/n7MfidLyiqTiEJaeF/OLj1h+eWrr8
	1hySs34//6bg8IGGkuu6EE1oilVc8R9aI4CC+dQQUDWlVfTwQkieI6KzBzQBNxl23YN76Mkh3CP
	7PZNbm2VX6EUqK0sMBVXeK7rTIoX+BZ7NHVeDc3PWZtAwe7DNWlBUmnq6BrNaX23mUkSNwQL/Zr
	lIGMRTE0Vzx+QASdp7O9rIpRFTi+1PD22
X-Received: by 2002:a5d:584c:0:b0:472:ec66:274a with SMTP id ffacd0b85a97d-47df074e24amr7671052f8f.7.1783600596109;
        Thu, 09 Jul 2026 05:36:36 -0700 (PDT)
X-Received: by 2002:a5d:584c:0:b0:472:ec66:274a with SMTP id ffacd0b85a97d-47df074e24amr7670997f8f.7.1783600595551;
        Thu, 09 Jul 2026 05:36:35 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0a558easm51266922f8f.27.2026.07.09.05.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 05:36:35 -0700 (PDT)
Date: Thu, 9 Jul 2026 08:36:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Carpenter <error27@gmail.com>
Cc: Haoxiang Li <haoxiang_li2024@163.com>, marcel@holtmann.org,
	luiz.dentz@gmail.com, yangyingliang@huawei.com,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] Bluetooth: virtio: Fix virtbt_probe() init and cleanup
Message-ID: <20260709083606-mutt-send-email-mst@kernel.org>
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
> uncomfortable blindly applying them without testing.  If someone
> can test, then great.  Otherwise, I would probably apply v3.  The
> stuff that Sashiko complained about was all pre-existing issues
> even though for the last one it said it wasn't but it was.
> 
> regards,
> dan carpenter

why make changes at all if no one can test. in fact, why have a driver
then.

-- 
MST

