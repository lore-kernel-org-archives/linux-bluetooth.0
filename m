Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B0CC7EE2F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Jun 2023 16:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242045AbjFIQDd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 9 Jun 2023 12:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240763AbjFIQDc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 9 Jun 2023 12:03:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264F735A3
        for <linux-bluetooth@vger.kernel.org>; Fri,  9 Jun 2023 09:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686326564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bDPqvNvCKDaRoxVabZXpCEaO3eFktyKlsug6+VBWhkY=;
        b=TS5lR0pwT5sVkhMT0975sqVmndER2hi2pDGO5KDgZEh1bhonwrm+BrINJH9nff79IrExgX
        vS2Me79M+hFxbHqQeG0tTO1ScAZrZDR+GxYs0VRXCi1cf1m7lvIicW53p2K7FQwA/Sekb2
        MWyy2UiEXyzFY6tUwBZWY19l8jT+9ec=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-TSc-1ImGPM-Gimfvp1KoaQ-1; Fri, 09 Jun 2023 12:02:43 -0400
X-MC-Unique: TSc-1ImGPM-Gimfvp1KoaQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f611d31577so13443155e9.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Jun 2023 09:02:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686326560; x=1688918560;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bDPqvNvCKDaRoxVabZXpCEaO3eFktyKlsug6+VBWhkY=;
        b=PIljz9jjHbhWZoKdONlOft2aWZKsxG3PbS3hHuVYmv6VhE+/oZ9cJSKFdHzaqJgbrw
         BoEtZBROEYH0i9VaH31XLfZBi0/QFicR9i36alD4QvpTUNtNlc5MwRqgq/I3c86jEMYZ
         MkTL0xDXfqHzabaJH+E37aokdors0oNfuPDFwgC/7FKKYjCNnqQmWTwBP/aRLrH84bNi
         A+jxitRcsjcP3SqZsGx7tpDuGos7ogYQJ/yD7iVPzZt85mvv7vaTBDRMBHcPeG2v0p6l
         4tq4UPmLEQgdKJ2eXDqi8VGAVmkP0oUsvmtDtlfrI2bzmpWHp1fmbUjWKcrll6xbpoNw
         qeAA==
X-Gm-Message-State: AC+VfDzXsHEbrKqIGm8SW66oy4XTASnskFJwTlcy26p1yg1tUILMCrIS
        jBj0N8TQPdXbqW0wVmrgWCuLjPVkUMEq61Q3X4j4V91b7C49gqIasJWfK2tLhVQ+9+e8HNzkLHS
        NXQf+XHhc9pYOKLbJqNwIj1HxuxQ4
X-Received: by 2002:a05:600c:2041:b0:3f6:1b7:11f0 with SMTP id p1-20020a05600c204100b003f601b711f0mr1872752wmg.7.1686326560746;
        Fri, 09 Jun 2023 09:02:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6+cTGEsumPbrhQKIm8DZ1NuiAlUbhAlNIbDxc4Q5231NUq4aWWlHrRMiiaodCaJ/J+lriS5Q==
X-Received: by 2002:a05:600c:2041:b0:3f6:1b7:11f0 with SMTP id p1-20020a05600c204100b003f601b711f0mr1872735wmg.7.1686326560330;
        Fri, 09 Jun 2023 09:02:40 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7403:2800:22a6:7656:500:4dab])
        by smtp.gmail.com with ESMTPSA id f16-20020a1c6a10000000b003f60fb2addbsm3062327wmc.44.2023.06.09.09.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 09:02:39 -0700 (PDT)
Date:   Fri, 9 Jun 2023 12:02:36 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Xianting Tian <xianting.tian@linux.alibaba.com>,
        arei.gonglei@huawei.com, jasowang@redhat.com,
        xuanzhuo@linux.alibaba.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, amit@kernel.org, arnd@arndb.de,
        marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xianting Tian <tianxianting.txt@alibaba-inc.com>
Subject: Re: [PATCH 1/3] virtio-crypto: fixup potential cpu stall when free
 unused bufs
Message-ID: <20230609115840-mutt-send-email-mst@kernel.org>
References: <20230609131817.712867-1-xianting.tian@linux.alibaba.com>
 <20230609131817.712867-2-xianting.tian@linux.alibaba.com>
 <2023060924-skinning-reset-e256@gregkh>
 <2023060940-wrongdoer-wince-5701@gregkh>
 <91aa6ce0-e8a3-21ac-d29e-b2a47f6386d1@linux.alibaba.com>
 <2023060924-onion-armhole-803e@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2023060924-onion-armhole-803e@gregkh>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, Jun 09, 2023 at 04:05:57PM +0200, Greg KH wrote:
> On Fri, Jun 09, 2023 at 09:49:39PM +0800, Xianting Tian wrote:
> > 
> > 在 2023/6/9 下午9:41, Greg KH 写道:
> > > On Fri, Jun 09, 2023 at 03:39:24PM +0200, Greg KH wrote:
> > > > On Fri, Jun 09, 2023 at 09:18:15PM +0800, Xianting Tian wrote:
> > > > > From: Xianting Tian <tianxianting.txt@alibaba-inc.com>
> > > > > 
> > > > > Cpu stall issue may happen if device is configured with multi queues
> > > > > and large queue depth, so fix it.
> > > > > 
> > > > > Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
> > > > > ---
> > > > >   drivers/crypto/virtio/virtio_crypto_core.c | 1 +
> > > > >   1 file changed, 1 insertion(+)
> > > > > 
> > > > > diff --git a/drivers/crypto/virtio/virtio_crypto_core.c b/drivers/crypto/virtio/virtio_crypto_core.c
> > > > > index 1198bd306365..94849fa3bd74 100644
> > > > > --- a/drivers/crypto/virtio/virtio_crypto_core.c
> > > > > +++ b/drivers/crypto/virtio/virtio_crypto_core.c
> > > > > @@ -480,6 +480,7 @@ static void virtcrypto_free_unused_reqs(struct virtio_crypto *vcrypto)
> > > > >   			kfree(vc_req->req_data);
> > > > >   			kfree(vc_req->sgs);
> > > > >   		}
> > > > > +		cond_resched();
> > > > that's not "fixing a stall", it is "call the scheduler because we are
> > > > taking too long".  The CPU isn't stalled at all, just busy.
> > > > 
> > > > Are you sure this isn't just a bug in the code?  Why is this code taking
> > > > so long that you have to force the scheduler to run?  This is almost
> > > > always a sign that something else needs to be fixed instead.
> > > And same comment on the other 2 patches, please fix this properly.
> > > 
> > > Also, this is a tight loop that is just freeing memory, why is it taking
> > > so long?  Why do you want it to take longer (which is what you are doing
> > > here), ideally it would be faster, not slower, so you are now slowing
> > > down the system overall with this patchset, right?
> > 
> > yes, it is the similar fix with one for virtio-net
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/net/virtio_net.c?h=v6.4-rc5&id=f8bb5104394560e29017c25bcade4c6b7aabd108 <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/net/virtio_net.c?h=v6.4-rc5&id=f8bb5104394560e29017c25bcade4c6b7aabd108>

Well that one actually at least describes the configuration:


	For multi-queue and large ring-size use case, the following error
	occurred when free_unused_bufs:
	rcu: INFO: rcu_sched self-detected stall on CPU.

So a similar fix but not a similar commit log, this one lacks Fixes tag and
description of what the problem is and when does it trigger.

> I would argue that this too is incorrect, because why does freeing
> memory take so long?

You are correct that even that one lacks detailed explanation
why does the patch help.

And the explanation why it takes so long is exactly that
we have very deep queues and a very large number of queues.
What the patch does is gives scheduler a chance
to do some work between the queues.





>  And again, you are making it take longer, is that
> ok?
> 
> thanks,
> 
> greg k-h

