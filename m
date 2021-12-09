Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6180DC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Dec 2021 21:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbhLIV0g (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Dec 2021 16:26:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28772 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229446AbhLIV0f (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Dec 2021 16:26:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639084980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vgwc1magvMzj/8M1W9pAQzQB7+9j3HSAE2K13KoLOiQ=;
        b=c5HRpZ9WpXnyIi+S8G4za/TvPuxJ03qccnwJZx7ISTmt+DOEDFDe3BdUsd6kftXo7wpf5M
        4hWSbOH7XcWtWww3Nl1XoMXRQLnwfZMPwP45fmuO17icaLKlzq6lLWJliHB5qWghzH9tuG
        w4o+QyViF1aZ1s0uuXZ+ubaKROkALM8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-366-Gn_1WxE4M_eAqCiwCzGlIA-1; Thu, 09 Dec 2021 16:22:59 -0500
X-MC-Unique: Gn_1WxE4M_eAqCiwCzGlIA-1
Received: by mail-wm1-f70.google.com with SMTP id p12-20020a05600c1d8c00b0033a22e48203so2880140wms.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Dec 2021 13:22:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Vgwc1magvMzj/8M1W9pAQzQB7+9j3HSAE2K13KoLOiQ=;
        b=QPhcBnRXCEUyE0j2jmDVpGn2hXkf/LwtmTG9beTNI5VCP1gLMH3a90x4E+cfcqkFwH
         TBMg9c3Hh2gixAACRoWu6DBkU3G2aVbWUerJvsbg/JLA19Uzjn7ZugK6O/Cx3t5G6Tud
         SemOj37nzwGSa3CGpJgRr5tXibkCq7sQiVetIGZfYwpQG76Rehoc1Oa4WqYEPVCvEfyQ
         BrGPVidC8mEhRRgXcmOyS9U+YtPr7gQKffim62wWvVk5UWc4u0g/XtMR5c6+e72rMSbw
         NZxkqG/KsZ2tKFSMm3LLTTIi7/h1lkHaKCXYTi//wgMbDVHbmheXD6i7RGriHZ7W5Yys
         tD8A==
X-Gm-Message-State: AOAM533qlIdo+BqYJ2SFWsRYVMj+qAO+2PSoDa3WrZWk1NMWAHBQOeTS
        Vzs11uxyZcNcTKYLCIzZVVGgiF+e41HzwgHE46XS2Pp8AS8ijGPw+Rss4pDT30gmjP9E9EmJN54
        aRacrJquICLRbGxWhiPWTNK39m7nx
X-Received: by 2002:a5d:4d8b:: with SMTP id b11mr9190190wru.393.1639084978497;
        Thu, 09 Dec 2021 13:22:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzEhH9zXTTqyJyrSWANNFF5+2UsCUnbJ3IhG7hh2poI6YaxLYQDArU+ddIxOhcq+6xvoWFlHQ==
X-Received: by 2002:a5d:4d8b:: with SMTP id b11mr9190171wru.393.1639084978284;
        Thu, 09 Dec 2021 13:22:58 -0800 (PST)
Received: from redhat.com ([2.55.18.120])
        by smtp.gmail.com with ESMTPSA id g13sm1214316wrd.57.2021.12.09.13.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 13:22:56 -0800 (PST)
Date:   Thu, 9 Dec 2021 16:22:52 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] Bluetooth: virtio_bt: fix device removal
Message-ID: <20211209162149-mutt-send-email-mst@kernel.org>
References: <20211125174200.133230-1-mst@redhat.com>
 <F52F65FE-6A07-486B-8E84-684ED85709E9@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F52F65FE-6A07-486B-8E84-684ED85709E9@holtmann.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, Nov 25, 2021 at 09:02:01PM +0100, Marcel Holtmann wrote:
> Hi Michael,
> 
> > Device removal is clearly out of virtio spec: it attempts to remove
> > unused buffers from a VQ before invoking device reset. To fix, make
> > open/close NOPs and do all cleanup/setup in probe/remove.
> 
> so the virtbt_{open,close} as NOP is not really what a driver is suppose
> to be doing. These are transport enable/disable callbacks from the BT
> Core towards the driver. It maps to a device being enabled/disabled by
> something like bluetoothd for example. So if disabled, I expect that no
> resources/queues are in use.
> 
> Maybe I misunderstand the virtio spec in that regard, but I would like
> to keep this fundamental concept of a Bluetooth driver. It does work
> with all other transports like USB, SDIO, UART etc.
> 
> > The cost here is a single skb wasted on an unused bt device - which
> > seems modest.
> 
> There should be no buffer used if the device is powered off. We also don’t
> have any USB URBs in-flight if the transport is not active.
> 
> > NB: with this fix in place driver still suffers from a race condition if
> > an interrupt triggers while device is being reset. Work on a fix for
> > that issue is in progress.
> 
> In the virtbt_close() callback we should deactivate all interrupts.
> 
> Regards
> 
> Marcel

So Marcel, do I read it right that you are working on a fix
and I can drop this patch for now?

-- 
MST

