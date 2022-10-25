Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D85C04A95
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Oct 2022 04:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiJYEFL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Oct 2022 00:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiJYEFJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Oct 2022 00:05:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757FF111F
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Oct 2022 21:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666670706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KGQAN5QfmAdIFxH4zxQ7DPOdP0CTozat81OxKPl1IMM=;
        b=SMyS4fuuL4lEN0CPibSS8It5eRCEWO9w4FmiG+eBFbg3hExfWNZUz0wA+eD2WgyxdDs2g+
        sdP6CP+WoDsLI4NIU1BKQ1yHNoxzh2u/bbhDcrfgglTDNdvNNt+4yaeP1A3UC+Dld432Xm
        gEpBSnwmSsWbXygG7OAyBNUlT1yWvuU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-300-ip6t_w31OECkAWaenNi7Kg-1; Tue, 25 Oct 2022 00:05:04 -0400
X-MC-Unique: ip6t_w31OECkAWaenNi7Kg-1
Received: by mail-wr1-f72.google.com with SMTP id m24-20020adfa3d8000000b00236774fd74aso1355259wrb.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Oct 2022 21:05:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KGQAN5QfmAdIFxH4zxQ7DPOdP0CTozat81OxKPl1IMM=;
        b=3yJThXb2lGtz84qp8dahjFPPP5/0vGcxZofZwXBTPmu62tqBkst9AHPDCYM9/LvSxr
         6qjd7OgZ6z9sGA26F0piwPh6JWBtYV+1C48h1s54ln/4gvHMN2dKrp8kzdf58ObDiITn
         kNmKVR8vL62Dl2iaUdhzMhxAelX87VPAbOfRyBDq6jf6gWOLVj8tWbxm1ONQVN8v1lGx
         PQ4Vm4mj+g/O2vuMONongPTPIlH7WbNPDFVkszQqXuyFt6t+SK62uJ7spZk2PV22ATYW
         BBKOPq9A2AiAC3Jhr9GaqbbNtjTImBqfiHFb9IcJgItKSI+1FO0deepD3ndUlZQkKmBP
         QP8g==
X-Gm-Message-State: ACrzQf0kQ1/FwvGTA9kKw0039Ezp9PrwJKooJXDAHCimT4kcsO9cKPvI
        DIXPUGcP3lMkXkWc0Fghk4IuY22Z7yteGIk4nLG5eKBfcP5+kjSgTxBwDd3MHLJEQe2CJoBqLFn
        nLY7SMiQBAv5axP1lCfwPRCGeKbBS
X-Received: by 2002:a05:600c:1822:b0:3c7:103:f9be with SMTP id n34-20020a05600c182200b003c70103f9bemr22816981wmp.195.1666670703040;
        Mon, 24 Oct 2022 21:05:03 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6GrspV0Rv4ooc27M/ZkGRCgHDhw7hvK7fug9mQV9MrYrQcfzp+yqeg/SM+IxYTvSy/l/z7tw==
X-Received: by 2002:a05:600c:1822:b0:3c7:103:f9be with SMTP id n34-20020a05600c182200b003c70103f9bemr22816959wmp.195.1666670702802;
        Mon, 24 Oct 2022 21:05:02 -0700 (PDT)
Received: from redhat.com ([2.52.24.36])
        by smtp.gmail.com with ESMTPSA id r7-20020a1c2b07000000b003c6f3e5ba42sm9660282wmr.46.2022.10.24.21.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 21:05:02 -0700 (PDT)
Date:   Tue, 25 Oct 2022 00:04:58 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Igor Skalkin <Igor.Skalkin@opensynergy.com>
Cc:     virtualization@lists.linux-foundation.org, luiz.dentz@gmail.com,
        marcel@holtmann.org, johan.hedberg@gmail.com, jasowang@redhat.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/1] virtio_bt: Fix alignment in configuration struct
Message-ID: <20221025000433-mutt-send-email-mst@kernel.org>
References: <20221018191911.589564-1-Igor.Skalkin@opensynergy.com>
 <20221024134033.30142-1-Igor.Skalkin@opensynergy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024134033.30142-1-Igor.Skalkin@opensynergy.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, Oct 24, 2022 at 03:40:32PM +0200, Igor Skalkin wrote:
> According to specification [1], "For the device-specific configuration
> space, the driver MUST use 8 bit wide accesses for 8 bit wide fields,
> 16 bit wide and aligned accesses for 16 bit wide fields and 32 bit wide
> and aligned accesses for 32 and 64 bit wide fields.".
> 
> Current version of the configuration structure has non-aligned 16bit
> fields.
> 
> This patch adds a second, aligned  version of the configuration structure
> and a new feature bit indicating that this version is being used.


subject should be v4 but besides that, ok.
Will a spec patch be forthcoming?

> [1] https://docs.oasis-open.org/virtio/virtio/v1.1/virtio-v1.1.pdf
> 
> Changes in v4:
>   v3 was corrupted by our smtp server.
> Changes in v3:
>   v2 had been sent from the wrong address, fixed.
> Changes in v2:
>   The first version of this patch just changed the configuration
>   structure in uapi/linux/virtio_bt.h
>   This can not be done, because it will break the userspace, so the
>   second version offers a less radical approach - it introduces a new
>   feature bit and a new configuration structure that both the device
>   and the driver will use if this bit is negotiated.
> 
> Igor Skalkin (1):
>   virtio_bt: Fix alignment in configuration struct
> 
>  drivers/bluetooth/virtio_bt.c  | 16 +++++++++++++---
>  include/uapi/linux/virtio_bt.h |  8 ++++++++
>  2 files changed, 21 insertions(+), 3 deletions(-)
> 
> -- 
> 2.37.2

