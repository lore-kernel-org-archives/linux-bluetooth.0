Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E55C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Nov 2021 21:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbhKYV2c (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 Nov 2021 16:28:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51167 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230209AbhKYV0c (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 Nov 2021 16:26:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637875399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pimlV2lH4TvXP6k8O9RhFaNOCPNxxUOqrc3BdluZm0g=;
        b=ISOL8fWgEnQMv3do/Gjor2buD8wRXbnngusFtHkhrCqOVtUlkc1fXkXCj4AoX4Y6JdDD7t
        Mhk60Y+/s0zhYfF1yaoG7KDODsLRo41FrvQOPbPF2hxs1G2dWNqFy6BX3T8LIHGqJ6HpQ3
        oaVlCz4EPZWi3vr8UN5z3DKbmMdb/fw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-424-6Um86_L8Px2LMTJyYRcqhA-1; Thu, 25 Nov 2021 16:23:18 -0500
X-MC-Unique: 6Um86_L8Px2LMTJyYRcqhA-1
Received: by mail-ed1-f71.google.com with SMTP id n11-20020aa7c68b000000b003e7d68e9874so6305691edq.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Nov 2021 13:23:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pimlV2lH4TvXP6k8O9RhFaNOCPNxxUOqrc3BdluZm0g=;
        b=lZ5nD824muDAWJePdnKNbgsjwFq2N5b/5s/r6C+vTUwc0mk9b2dXnsJVtQIVaHFwM3
         WKjn2YkFAZTIHicuDPbx21frI3fjPGdy+cxXtqV9Yf6pukmadimjutr8TZAykL9RvyVS
         nWomM3SUQpGRd96pgXaoL60HQhfl7F81KOPjAlh7wUeY7qsPkXeEBwJBAmhBt2yAFzKQ
         3hDH8ErRFM13banX/4Aw2mEEtFEi0DBFeETlTcFKs/SrCZxJ7M77lWLR5XCM3GFn8pwK
         Mkcoa5BCRw7OWPFchtVv88VAZsWnkEVR9TguY4W61A8BLk0inymZsGTI8RkunGbIfXsA
         kafg==
X-Gm-Message-State: AOAM533OaOvF7EJ3lfKcH8r/KvmLikc7Jo6ekzbk9BF5l4XQVQS0Es1y
        dO23c1L4eoWk4EmYEZhrT7lEyH467XKE77kbJxepHM6y1GvIf12FCkT2T+r9cwSfDAQPHUodLPF
        ZMNSlFjTsYz7eZFqG42ccDBBdNgZt
X-Received: by 2002:a05:6402:185:: with SMTP id r5mr41305563edv.259.1637875397444;
        Thu, 25 Nov 2021 13:23:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzRnkN9tLkP2cFib+nh4KuSKdGhb+rdlBs95rCLkSJayE9xRjQxSLcWiis9cvGEhBgCQuB7ig==
X-Received: by 2002:a05:6402:185:: with SMTP id r5mr41305537edv.259.1637875397263;
        Thu, 25 Nov 2021 13:23:17 -0800 (PST)
Received: from redhat.com ([2a03:c5c0:207e:e87:2d40:4ed4:5676:5c1a])
        by smtp.gmail.com with ESMTPSA id lv19sm2367409ejb.54.2021.11.25.13.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 13:23:16 -0800 (PST)
Date:   Thu, 25 Nov 2021 16:23:12 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] Bluetooth: virtio_bt: fix device removal
Message-ID: <20211125161434-mutt-send-email-mst@kernel.org>
References: <20211125174200.133230-1-mst@redhat.com>
 <F52F65FE-6A07-486B-8E84-684ED85709E9@holtmann.org>
 <20211125154314-mutt-send-email-mst@kernel.org>
 <C8D84EA4-E9A8-44CC-918F-57640A05C81D@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C8D84EA4-E9A8-44CC-918F-57640A05C81D@holtmann.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, Nov 25, 2021 at 10:01:25PM +0100, Marcel Holtmann wrote:
> Hi Michael,
> 
> >>> Device removal is clearly out of virtio spec: it attempts to remove
> >>> unused buffers from a VQ before invoking device reset. To fix, make
> >>> open/close NOPs and do all cleanup/setup in probe/remove.
> >> 
> >> so the virtbt_{open,close} as NOP is not really what a driver is suppose
> >> to be doing. These are transport enable/disable callbacks from the BT
> >> Core towards the driver. It maps to a device being enabled/disabled by
> >> something like bluetoothd for example. So if disabled, I expect that no
> >> resources/queues are in use.
> >> 
> >> Maybe I misunderstand the virtio spec in that regard, but I would like
> >> to keep this fundamental concept of a Bluetooth driver. It does work
> >> with all other transports like USB, SDIO, UART etc.
> >> 
> >>> The cost here is a single skb wasted on an unused bt device - which
> >>> seems modest.
> >> 
> >> There should be no buffer used if the device is powered off. We also don’t
> >> have any USB URBs in-flight if the transport is not active.
> >> 
> >>> NB: with this fix in place driver still suffers from a race condition if
> >>> an interrupt triggers while device is being reset. Work on a fix for
> >>> that issue is in progress.
> >> 
> >> In the virtbt_close() callback we should deactivate all interrupts.
> >> 
> > 
> > If you want to do that then device has to be reset on close,
> > and fully reinitialized on open.
> > Can you work on a patch like that?
> > Given I don't have the device such a rework is probably more
> > than I can undertake.
> 
> so you mean move virtio_find_vqs() into virtbt_open() and del_vqs() into
> virtbt_close()?

And reset before del_vqs.

> Or is there are way to set up the queues without starting them?
> 
> However I am failing to understand your initial concern, we do reset()
> before del_vqs() in virtbt_remove(). Should we be doing something different
> in virtbt_close() other than virtqueue_detach_unused_buf(). Why would I
> keep buffers attached if they are not used.
> 
> Regards
> 
> Marcel

They are not used at that point but until device is reset can use them.
Also, if you then proceed to open without a reset, and kick,
device will start by processing the original buffers, crashing
or corrupting memory.

-- 
MST

