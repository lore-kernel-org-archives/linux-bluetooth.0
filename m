Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9722C38145
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Sep 2022 16:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiIHQkv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 8 Sep 2022 12:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbiIHQku (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 8 Sep 2022 12:40:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DC8F3426
        for <linux-bluetooth@vger.kernel.org>; Thu,  8 Sep 2022 09:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662655247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pkfsc+Qd/gwYAug2VWPkSKKYrJX5Z5R+zOqDD2izm4g=;
        b=CN0WctdZCN9KIa1PXewYuTDwMMsEkFiaB/EB3ScffMXiFnO2B06FL51uCSc1hWaVUl8Y7l
        KHThGe/JcBdUW8qOkB/TBVWIQG+IPPaN+meojzfCZ8QVpKwkrVfqD7UuLBYajZt9pVPczh
        JQNBoNW7o1uuJyR89krM7QKUMGP4EL8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-373-meGcHBO4PAenpuopQEQQcA-1; Thu, 08 Sep 2022 12:40:46 -0400
X-MC-Unique: meGcHBO4PAenpuopQEQQcA-1
Received: by mail-qt1-f200.google.com with SMTP id fy12-20020a05622a5a0c00b00344569022f7so14944409qtb.17
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Sep 2022 09:40:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=pkfsc+Qd/gwYAug2VWPkSKKYrJX5Z5R+zOqDD2izm4g=;
        b=ui19032SKTMj6aZ4LQ2cSvswYl7E/H7p984PE6aj1zHh5FZPdYw/PLcmeAyFse7GFP
         iuYXVLJrSAG2vR9P3pJwPuv5kWxM5EnMWfK1sTLRIb/CH9NUrO3IKRkGM+jYHTjMENev
         ZD13abc26sPg+ONbJitrr6a/1CMk82GxyE79Dhct21qZzPouTVHJ+GqWHwi2f9/cjHvG
         tZwjvBEyLsxWGTnAguBCPgOzdnq1N3lkvkUZsi0gf4uvMeLsQ5e8nneKjLms5P5DHc37
         zKnWH9mIFYQKMUGRsMZ3lGEKOTexFUetJXY9f5WowOM6uzKtIqgX9iGzQtzDbf5F08Hk
         lAxQ==
X-Gm-Message-State: ACgBeo0iF9hfniaT1J5CIXF4Z3IZsEaN9zZ9T9OOOlM2deb/25Ba7sRH
        c8aLoK5FMRWohX1w0niNxllaAdJngJcMAhIVphFMvhpZGQdJKdL4ILx/tn8PzBTZosaV8/dJSc9
        oF5bvUSATqYm8I6EcAodRUKZznTYD
X-Received: by 2002:a05:620a:14aa:b0:6cb:e3a2:311b with SMTP id x10-20020a05620a14aa00b006cbe3a2311bmr904223qkj.266.1662655245504;
        Thu, 08 Sep 2022 09:40:45 -0700 (PDT)
X-Google-Smtp-Source: AA6agR53cNBgQZY4hEhzYVT/VkqEs1YXNR9ifPFn0pnI+C10iK7Hb4Aw/802twYiNtloEdpZjdtoJg==
X-Received: by 2002:a05:620a:14aa:b0:6cb:e3a2:311b with SMTP id x10-20020a05620a14aa00b006cbe3a2311bmr904197qkj.266.1662655245128;
        Thu, 08 Sep 2022 09:40:45 -0700 (PDT)
Received: from redhat.com ([45.144.113.243])
        by smtp.gmail.com with ESMTPSA id v38-20020a05622a18a600b0035a7070e909sm701989qtc.38.2022.09.08.09.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 09:40:44 -0700 (PDT)
Date:   Thu, 8 Sep 2022 12:40:35 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Igor Skalkin <igor.skalkin@opensynergy.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        mgo@opensynergy.com
Subject: Re: [PATCH] virtio_bt: Fix alignment in configuration struct
Message-ID: <20220908123911-mutt-send-email-mst@kernel.org>
References: <20220807221152.38948-1-Igor.Skalkin@opensynergy.com>
 <20220807185846-mutt-send-email-mst@kernel.org>
 <02222fcb-eaba-617a-c51c-f939678e3d74@opensynergy.com>
 <20220808081054-mutt-send-email-mst@kernel.org>
 <20220811035817-mutt-send-email-mst@kernel.org>
 <CABBYNZKZGxbt=jdpBL77x1mCeTPdDE-p-Pt8JjZN+KoRgR3Ohw@mail.gmail.com>
 <20220830094441-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830094441-mutt-send-email-mst@kernel.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, Aug 30, 2022 at 09:45:02AM -0400, Michael S. Tsirkin wrote:
> On Thu, Aug 11, 2022 at 10:02:31AM -0700, Luiz Augusto von Dentz wrote:
> > Hi Michael,
> > 
> > On Thu, Aug 11, 2022 at 1:00 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Mon, Aug 08, 2022 at 08:16:11AM -0400, Michael S. Tsirkin wrote:
> > > > On Mon, Aug 08, 2022 at 02:04:43PM +0200, Igor Skalkin wrote:
> > > > > On 8/8/22 01:00, Michael S. Tsirkin wrote:
> > > > >
> > > > >     On Mon, Aug 08, 2022 at 12:11:52AM +0200, Igor Skalkin wrote:
> > > > >
> > > > >         According to specification [1], "For the device-specific configuration
> > > > >         space, the driver MUST use 8 bit wide accesses for 8 bit wide fields,
> > > > >         16 bit wide and aligned accesses for 16 bit wide fields and 32 bit wide
> > > > >         and aligned accesses for 32 and 64 bit wide fields.".
> > > > >
> > > > >         Current version of the configuration structure:
> > > > >
> > > > >             struct virtio_bt_config {
> > > > >                 __u8  type;
> > > > >                 __u16 vendor;
> > > > >                 __u16 msft_opcode;
> > > > >             } __attribute__((packed));
> > > > >
> > > > >         has both 16bit fields non-aligned.
> > > > >
> > > > >         This commit fixes it.
> > > > >
> > > > >         [1] https://ddec1-0-en-ctp.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2fdocs.oasis%2dopen.org%2fvirtio%2fvirtio%2fv1.1%2fvirtio%2dv1.1.pdf&umid=d1786ace-e8ea-40e8-9665-96c0949174e5&auth=53c7c7de28b92dfd96e93d9dd61a23e634d2fbec-39b15885ceebe9fda9357320aec1ccbac416a470
> > > > >
> > > > >         Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
> > > > >
> > > > >     This is all true enough, but the problem is
> > > > >     1. changing uapi like this can't be done, will break userspace
> > > > >     2. the driver has more issues and no one seems to want to
> > > > >        maintain it.
> > > > >     I posted a patch "Bluetooth: virtio_bt: mark broken" and intend
> > > > >     to merge it for this release.
> > > > >
> > > > > This is very sad. We already use this driver in our projects.
> > > >
> > > > Really?  Can you step up to maintain it? Then we can fix the issues
> > > > and it won't be broken.
> > >
> > > Just a reminder that I'm waiting for a response on that.
> > > I just don't know enough about bluetooth.
> > 
> > Just a heads up that Marcel is on vacation, he did mention that he had
> > done some work to update virtio_bt thus why I didn't apply any of the
> > changes yet.
> 
> Any update? when does Marcel return?


Annnnnnd ... this is falling between the chairs again?
Guys if anyone wants to use this driver it needs a maintainer.

> > > --
> > > MST
> > >
> > 
> > 
> > -- 
> > Luiz Augusto von Dentz

