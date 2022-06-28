Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BC8C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Jun 2022 04:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244556AbiF1E7Z (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Jun 2022 00:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244539AbiF1E7X (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Jun 2022 00:59:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 300CC2BFD
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jun 2022 21:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656392361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rZNQqZ1BHUSITCdYmtKN1bf6mH2E51IBmEGFR1jGCIs=;
        b=fS5moFwYRj7tYD42Izf1dxCh6jajjagrufmowXuRQ8XQaQtcIvd0v3Y29ygolmxGG6Kcg2
        I3o7iRzDL2ul66qkfHLV5dgqI2KHgJE4iYLiHv6w9A6HPYztkmE2MfpEqzZe8KcLPtaHEU
        m/1NVp0fOBeawqXOKTaB0uyBLJ9aeZs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-187-vMU-72u3OhWbWlpEzw8CkA-1; Tue, 28 Jun 2022 00:59:15 -0400
X-MC-Unique: vMU-72u3OhWbWlpEzw8CkA-1
Received: by mail-wr1-f70.google.com with SMTP id o1-20020adfba01000000b0021b90bd28d2so1438799wrg.14
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jun 2022 21:59:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=rZNQqZ1BHUSITCdYmtKN1bf6mH2E51IBmEGFR1jGCIs=;
        b=hRfQBBCl2TxM0/E8VK4UvX+LMl8ldz34K1jIjUgDp/ch7lRmbjcHERgYpRD+DZnEGG
         IxO5aEbl9p7NFmIiDIjyZobj6dbrLH27MdYFikC6MR7vq5SZwSS2G68qMc1soAD5clgT
         eZcFABmx8VIrjn/N9c/D/CyFSb1Zgd9+mVMSWfqbPifAsf7U+dsr39USij8qWckXOl1d
         JNO7BUjDsJhQOksXLPQBnGyIHALvK5tzqIe4C7JtD+qBjDgie/xmuVUmam0zVrh7TQpL
         iF1MZt7AJlw4+lA//l9bpsnoj4xKsrRl1XgVkjTNvH48UqthuUl9ZXXzwUGS0PvAK/2f
         E2Mg==
X-Gm-Message-State: AJIora9jhnrhF9BxaQRfF6KycPSe05ofJroYEeQOzZMSKK+kn02u6eK6
        yxYQq76fBHAC/zz4rw2skHHoDa8SfKRODhYvqhviuPUsQ9VihGG/YS/cK9hS67NiRVSHztHHOes
        ZMZH9YuGKtrmFT7czo5xErJZpllA6
X-Received: by 2002:a5d:6d46:0:b0:21b:933d:7950 with SMTP id k6-20020a5d6d46000000b0021b933d7950mr15613696wri.679.1656392354608;
        Mon, 27 Jun 2022 21:59:14 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tyGGHEzmhFr36J5MuQpBJ//xCFRhKGBlqfoxm4YRVwOh1Ip5cEC8bLfCjZ0wmo1x6Rb/zEWA==
X-Received: by 2002:a5d:6d46:0:b0:21b:933d:7950 with SMTP id k6-20020a5d6d46000000b0021b933d7950mr15613676wri.679.1656392354311;
        Mon, 27 Jun 2022 21:59:14 -0700 (PDT)
Received: from redhat.com ([2.52.23.204])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c4f5400b0039747cf8354sm16024450wmq.39.2022.06.27.21.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 21:59:13 -0700 (PDT)
Date:   Tue, 28 Jun 2022 00:59:10 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] Bluetooth: virtio_bt: fix device removal
Message-ID: <20220628005837-mutt-send-email-mst@kernel.org>
References: <20211125174200.133230-1-mst@redhat.com>
 <F52F65FE-6A07-486B-8E84-684ED85709E9@holtmann.org>
 <20211209162149-mutt-send-email-mst@kernel.org>
 <20211213054357-mutt-send-email-mst@kernel.org>
 <20211213185620-mutt-send-email-mst@kernel.org>
 <FF8BA713-6DD2-485B-9ADC-02006126BC60@holtmann.org>
 <20220114151142-mutt-send-email-mst@kernel.org>
 <20220613025539-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220613025539-mutt-send-email-mst@kernel.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, Jun 13, 2022 at 02:58:59AM -0400, Michael S. Tsirkin wrote:
> On Fri, Jan 14, 2022 at 03:12:47PM -0500, Michael S. Tsirkin wrote:
> > On Thu, Dec 16, 2021 at 08:58:31PM +0100, Marcel Holtmann wrote:
> > > Hi Michael,
> > > 
> > > >>>>> Device removal is clearly out of virtio spec: it attempts to remove
> > > >>>>> unused buffers from a VQ before invoking device reset. To fix, make
> > > >>>>> open/close NOPs and do all cleanup/setup in probe/remove.
> > > >>>> 
> > > >>>> so the virtbt_{open,close} as NOP is not really what a driver is suppose
> > > >>>> to be doing. These are transport enable/disable callbacks from the BT
> > > >>>> Core towards the driver. It maps to a device being enabled/disabled by
> > > >>>> something like bluetoothd for example. So if disabled, I expect that no
> > > >>>> resources/queues are in use.
> > > >>>> 
> > > >>>> Maybe I misunderstand the virtio spec in that regard, but I would like
> > > >>>> to keep this fundamental concept of a Bluetooth driver. It does work
> > > >>>> with all other transports like USB, SDIO, UART etc.
> > > >>>> 
> > > >>>>> The cost here is a single skb wasted on an unused bt device - which
> > > >>>>> seems modest.
> > > >>>> 
> > > >>>> There should be no buffer used if the device is powered off. We also don’t
> > > >>>> have any USB URBs in-flight if the transport is not active.
> > > >>>> 
> > > >>>>> NB: with this fix in place driver still suffers from a race condition if
> > > >>>>> an interrupt triggers while device is being reset. Work on a fix for
> > > >>>>> that issue is in progress.
> > > >>>> 
> > > >>>> In the virtbt_close() callback we should deactivate all interrupts.
> > > >>>> 
> > > >>>> Regards
> > > >>>> 
> > > >>>> Marcel
> > > >>> 
> > > >>> So Marcel, do I read it right that you are working on a fix
> > > >>> and I can drop this patch for now?
> > > >> 
> > > >> ping
> > > > 
> > > > 
> > > > If I don't hear otherwise I'll queue my version - it might not
> > > > be ideal but it at least does not violate the spec.
> > > > We can work on not allocating/freeing buffers later
> > > > as appropriate.
> > > 
> > > I have a patch, but it is not fully tested yet.
> > > 
> > > Regards
> > > 
> > > Marcel
> > 
> > ping
> > 
> > it's been a month ...
> > 
> > I'm working on cleaning up module/device removal in virtio and bt
> > is kind of sticking out.
> 
> I am inclined to make this driver depend on BROKEN for now.
> Any objections?

OK patch incoming.

> 
> > -- 
> > MST

