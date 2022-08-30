Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9792EECAAD4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Aug 2022 13:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiH3NsE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Aug 2022 09:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiH3Nri (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Aug 2022 09:47:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D9811F186
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Aug 2022 06:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661867104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4TQ3D3Ecv0JVJq75Mysm7I94dQGdbTCqUokREWAuRr0=;
        b=BHyByNsBKJTchSpkig9vd3eFeHb5eLRtnQK6warfWLuT2LUEurq9xuUNJFtHjhpWZHX6bJ
        +Y/pxvCKtNqOd/ULpc028vzWrckyC3Kd5uW/JhJd4bKBgYWpWzxgbXxQVN2Rhlo9DWOueO
        7EepWdIxBtV2FVklJ2tmLX3XN4XuK/E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-562-_ihsjzN5OtKrl4Kf6zB5TA-1; Tue, 30 Aug 2022 09:45:03 -0400
X-MC-Unique: _ihsjzN5OtKrl4Kf6zB5TA-1
Received: by mail-wr1-f71.google.com with SMTP id r7-20020adfbb07000000b00225b9579132so1758287wrg.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Aug 2022 06:45:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=4TQ3D3Ecv0JVJq75Mysm7I94dQGdbTCqUokREWAuRr0=;
        b=639YBbkU4Pvg9SNseMUUr3oh/D50NgwYft+9a3uvOeeOP/gqMoJS5pgRq3rZLPJj5G
         WGTjFMFl0LOmMtREkuHXkcxmg2GuD+aUx3Ms4a52V/PGiire0C97xOGX6olNKWpq1Cav
         loJB241tgE5Cw+DQXbmBVZBw+O4d8Mg5znDtl7C6QfLQUUjLBW0Tvzlzx2l+vHH/ofCd
         uo5FyjFUHJYNTUDk7IuqYEtzzv4Mvni0wgS1WCjjC+99T2ykbHj5eLfGTaWUWwV8BOEU
         /xD4xUJz2AbDzuEhA6s6vDKKZct9/4tfSZJb1t1cPXM2zSWZISKErGWlOta2MZuwAj+t
         Pbow==
X-Gm-Message-State: ACgBeo1rAqS8divhyh1VkIkykS0vQOZ9xf8WZ5znejqsTEjF52CocN5A
        iSmKLLiSFduKujJG3qSq928HZkK/rU3tprykZeQTtRlAh5lIAULt5rvFivL07EiNvpjAtU7JTbQ
        dDENrCq/Exw1rFQnBsHPAz82K2N8B
X-Received: by 2002:a05:600c:ace:b0:3a5:b495:854d with SMTP id c14-20020a05600c0ace00b003a5b495854dmr9620576wmr.86.1661867102647;
        Tue, 30 Aug 2022 06:45:02 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7kE0OkvnuES7vDthBiH8iXuZiew08diUgUfwuPstZZgb2cSBtaApqD4FeCYJF2b3SOm8jHEg==
X-Received: by 2002:a05:600c:ace:b0:3a5:b495:854d with SMTP id c14-20020a05600c0ace00b003a5b495854dmr9620557wmr.86.1661867102326;
        Tue, 30 Aug 2022 06:45:02 -0700 (PDT)
Received: from redhat.com ([2.55.191.225])
        by smtp.gmail.com with ESMTPSA id r8-20020a5d6948000000b00226a5187528sm9535421wrw.48.2022.08.30.06.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 06:45:01 -0700 (PDT)
Date:   Tue, 30 Aug 2022 09:44:58 -0400
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
Message-ID: <20220830094441-mutt-send-email-mst@kernel.org>
References: <20220807221152.38948-1-Igor.Skalkin@opensynergy.com>
 <20220807185846-mutt-send-email-mst@kernel.org>
 <02222fcb-eaba-617a-c51c-f939678e3d74@opensynergy.com>
 <20220808081054-mutt-send-email-mst@kernel.org>
 <20220811035817-mutt-send-email-mst@kernel.org>
 <CABBYNZKZGxbt=jdpBL77x1mCeTPdDE-p-Pt8JjZN+KoRgR3Ohw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABBYNZKZGxbt=jdpBL77x1mCeTPdDE-p-Pt8JjZN+KoRgR3Ohw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, Aug 11, 2022 at 10:02:31AM -0700, Luiz Augusto von Dentz wrote:
> Hi Michael,
> 
> On Thu, Aug 11, 2022 at 1:00 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Aug 08, 2022 at 08:16:11AM -0400, Michael S. Tsirkin wrote:
> > > On Mon, Aug 08, 2022 at 02:04:43PM +0200, Igor Skalkin wrote:
> > > > On 8/8/22 01:00, Michael S. Tsirkin wrote:
> > > >
> > > >     On Mon, Aug 08, 2022 at 12:11:52AM +0200, Igor Skalkin wrote:
> > > >
> > > >         According to specification [1], "For the device-specific configuration
> > > >         space, the driver MUST use 8 bit wide accesses for 8 bit wide fields,
> > > >         16 bit wide and aligned accesses for 16 bit wide fields and 32 bit wide
> > > >         and aligned accesses for 32 and 64 bit wide fields.".
> > > >
> > > >         Current version of the configuration structure:
> > > >
> > > >             struct virtio_bt_config {
> > > >                 __u8  type;
> > > >                 __u16 vendor;
> > > >                 __u16 msft_opcode;
> > > >             } __attribute__((packed));
> > > >
> > > >         has both 16bit fields non-aligned.
> > > >
> > > >         This commit fixes it.
> > > >
> > > >         [1] https://ddec1-0-en-ctp.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2fdocs.oasis%2dopen.org%2fvirtio%2fvirtio%2fv1.1%2fvirtio%2dv1.1.pdf&umid=d1786ace-e8ea-40e8-9665-96c0949174e5&auth=53c7c7de28b92dfd96e93d9dd61a23e634d2fbec-39b15885ceebe9fda9357320aec1ccbac416a470
> > > >
> > > >         Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
> > > >
> > > >     This is all true enough, but the problem is
> > > >     1. changing uapi like this can't be done, will break userspace
> > > >     2. the driver has more issues and no one seems to want to
> > > >        maintain it.
> > > >     I posted a patch "Bluetooth: virtio_bt: mark broken" and intend
> > > >     to merge it for this release.
> > > >
> > > > This is very sad. We already use this driver in our projects.
> > >
> > > Really?  Can you step up to maintain it? Then we can fix the issues
> > > and it won't be broken.
> >
> > Just a reminder that I'm waiting for a response on that.
> > I just don't know enough about bluetooth.
> 
> Just a heads up that Marcel is on vacation, he did mention that he had
> done some work to update virtio_bt thus why I didn't apply any of the
> changes yet.

Any update? when does Marcel return?

> > --
> > MST
> >
> 
> 
> -- 
> Luiz Augusto von Dentz

