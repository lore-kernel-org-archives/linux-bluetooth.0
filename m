Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1AC6C43334
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jun 2022 06:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbiFMG7I (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Jun 2022 02:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbiFMG7D (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Jun 2022 02:59:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 940C515FFC
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jun 2022 23:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655103541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oVRFLE7RGwK5y8lRXbnI7Xv89WxvPuxuOeVilE+WukU=;
        b=Gf7rcEpGIzd9NPyctYiiKt/PT9+QWioMW8dZPLLcDLOfzmnIQ3T3yQyPFm7Uw91Nnj4N9I
        Ic2aaPm8OjmGL0xf4nk8hMvIHmizQDA2ZswQdMZeia2oQbmyfHvDsu+guhuDh730D0z8/E
        /DWfmqv2V6hTueX4F8TfUTPCnGIg0SI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-331-W92Bqzh5Nni1GWUh1nCQpA-1; Mon, 13 Jun 2022 02:59:00 -0400
X-MC-Unique: W92Bqzh5Nni1GWUh1nCQpA-1
Received: by mail-ed1-f69.google.com with SMTP id j4-20020aa7ca44000000b0042dd12a7bc5so3364904edt.13
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jun 2022 23:59:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=oVRFLE7RGwK5y8lRXbnI7Xv89WxvPuxuOeVilE+WukU=;
        b=IrD3dj5ca3eb2IZ6CEMvCDcrsI2NEXJ4Q5k9RfkXEFBeOqVci/dh5N6HtuOrCWBL1Z
         fvYEBI09a8FA6o4YLTE1iZDoc2giXxjz146rq5A7/EmJ183cMAls3U6HF5uWTWzFDDho
         CzDYWYiLErCY3hnI/JL6JX4Q2dkn+ei7PkqXucHn5rrCjz+RlChi/OE3U2+m0eYy8FIX
         OuQiDzx7T0g1fZk+YWoOdGsltmulgoZ19x3x+yyZIbySpwgCj4DYycu+RW+UcdihjaGR
         4e4bpMIs5PJTfeifcAoE8LvQSTQd+M4chnsTb0lzK1Q/YckRsTd6VHEuIiLkknC6VLgQ
         ueGg==
X-Gm-Message-State: AOAM530Eok1qvL/d1PA/qm6OGhZ6SRqfH9Wf9agj77zeVLB7+0dNxsCd
        Yb1btHHs+Dmr1agg+Tj9Pm1cI3rLJ1sGWnwpi4qK1S0zTCWsmpduKDrUXtNVCc1Vw0k5BUoqAr/
        GE+n/LiWnMZLZwvo/XRQ4Jkb55EZd
X-Received: by 2002:a17:906:73cc:b0:715:76d0:861f with SMTP id n12-20020a17090673cc00b0071576d0861fmr7737526ejl.279.1655103539079;
        Sun, 12 Jun 2022 23:58:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyKr+VY6PAYpH+B8olrglxv2z4tvg1IqCD623zp9Wy7HhMX5YZn9U2e/hO9mTyMzbfA9vuToA==
X-Received: by 2002:a17:906:73cc:b0:715:76d0:861f with SMTP id n12-20020a17090673cc00b0071576d0861fmr7737519ejl.279.1655103538884;
        Sun, 12 Jun 2022 23:58:58 -0700 (PDT)
Received: from redhat.com ([2a03:c5c0:107c:be5a:1a30:9f6d:4400:4adc])
        by smtp.gmail.com with ESMTPSA id 14-20020a170906328e00b006fee961b9e0sm3405436ejw.195.2022.06.12.23.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 23:58:58 -0700 (PDT)
Date:   Mon, 13 Jun 2022 02:58:54 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] Bluetooth: virtio_bt: fix device removal
Message-ID: <20220613025539-mutt-send-email-mst@kernel.org>
References: <20211125174200.133230-1-mst@redhat.com>
 <F52F65FE-6A07-486B-8E84-684ED85709E9@holtmann.org>
 <20211209162149-mutt-send-email-mst@kernel.org>
 <20211213054357-mutt-send-email-mst@kernel.org>
 <20211213185620-mutt-send-email-mst@kernel.org>
 <FF8BA713-6DD2-485B-9ADC-02006126BC60@holtmann.org>
 <20220114151142-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220114151142-mutt-send-email-mst@kernel.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, Jan 14, 2022 at 03:12:47PM -0500, Michael S. Tsirkin wrote:
> On Thu, Dec 16, 2021 at 08:58:31PM +0100, Marcel Holtmann wrote:
> > Hi Michael,
> > 
> > >>>>> Device removal is clearly out of virtio spec: it attempts to remove
> > >>>>> unused buffers from a VQ before invoking device reset. To fix, make
> > >>>>> open/close NOPs and do all cleanup/setup in probe/remove.
> > >>>> 
> > >>>> so the virtbt_{open,close} as NOP is not really what a driver is suppose
> > >>>> to be doing. These are transport enable/disable callbacks from the BT
> > >>>> Core towards the driver. It maps to a device being enabled/disabled by
> > >>>> something like bluetoothd for example. So if disabled, I expect that no
> > >>>> resources/queues are in use.
> > >>>> 
> > >>>> Maybe I misunderstand the virtio spec in that regard, but I would like
> > >>>> to keep this fundamental concept of a Bluetooth driver. It does work
> > >>>> with all other transports like USB, SDIO, UART etc.
> > >>>> 
> > >>>>> The cost here is a single skb wasted on an unused bt device - which
> > >>>>> seems modest.
> > >>>> 
> > >>>> There should be no buffer used if the device is powered off. We also don’t
> > >>>> have any USB URBs in-flight if the transport is not active.
> > >>>> 
> > >>>>> NB: with this fix in place driver still suffers from a race condition if
> > >>>>> an interrupt triggers while device is being reset. Work on a fix for
> > >>>>> that issue is in progress.
> > >>>> 
> > >>>> In the virtbt_close() callback we should deactivate all interrupts.
> > >>>> 
> > >>>> Regards
> > >>>> 
> > >>>> Marcel
> > >>> 
> > >>> So Marcel, do I read it right that you are working on a fix
> > >>> and I can drop this patch for now?
> > >> 
> > >> ping
> > > 
> > > 
> > > If I don't hear otherwise I'll queue my version - it might not
> > > be ideal but it at least does not violate the spec.
> > > We can work on not allocating/freeing buffers later
> > > as appropriate.
> > 
> > I have a patch, but it is not fully tested yet.
> > 
> > Regards
> > 
> > Marcel
> 
> ping
> 
> it's been a month ...
> 
> I'm working on cleaning up module/device removal in virtio and bt
> is kind of sticking out.

I am inclined to make this driver depend on BROKEN for now.
Any objections?


> -- 
> MST

