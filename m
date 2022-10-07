Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEA2C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Oct 2022 13:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiJGNDp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Oct 2022 09:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiJGNDW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Oct 2022 09:03:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD193748D6
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Oct 2022 06:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665147791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/Wu7zkDvh9Y7YMMhVMehTcCNW6maACM0iCCQHnBi68g=;
        b=SGq47a75Zlw/jWHNEoptaPYL1iY9zRewXe/Z8UwPtU0JytoxfSzlxARDksQ1LLQieg9eh9
        5Dr/51iAHzN455vPna9eBOKoMrKLlDnOS5BRgzPb0DsR3D17qnGpCroaldQd/m3guTawST
        lruWtjOsVvCbvSgNRY31mQ/rGnpiwDg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-48-UwWC6JIGO2eQOMmmG_pBPA-1; Fri, 07 Oct 2022 09:03:09 -0400
X-MC-Unique: UwWC6JIGO2eQOMmmG_pBPA-1
Received: by mail-wr1-f72.google.com with SMTP id n8-20020adf8b08000000b0022e4d3dc8d2so1396185wra.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Oct 2022 06:03:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Wu7zkDvh9Y7YMMhVMehTcCNW6maACM0iCCQHnBi68g=;
        b=ve2+5rue4c83QCD7fuQ3OTrKy4P0VdhV8l7JesvhiqzPZjjUSaVs34qKyIlXsYF2QT
         nSm+Vu3A+OzwrWsXuNu88DdsKv3ihnrbgmXGM9m9gfh9dWgBii3t8nmzoyoNNec0Efly
         cBe7GeSV5ihlQyYGFhHOsHvCM+gefzmmGTDo91cE3AQcZ47Pz/0tJYpM7DBRegzJfDsS
         hGzsM3rtjnpU+fZjOI0tW+SmevlfmDFNMZ4CRg+nh1d6rnI170RhUnFFuL3zQraNPVJR
         gnMVf3bxDoacHGMIMGQaIIETSwSvAJWeuLbSdJoL0KZwwiesSk6Jl3ue39JMQvAj5dbb
         bgyA==
X-Gm-Message-State: ACrzQf2FLbPo9uiYdSgYk2s9SGYudLJ8lH/ausrCJSDbq4Wqd0m0AUTo
        gqsGOwKeDmGub66/dd0+6cKkNIc/Agl/0agwnvQXVir8MyuzTIUAKArTKau7HfgeJ7ySQB8uPBj
        XyxSrRWxeNu43IZJiPQ7r4VEpzN/I
X-Received: by 2002:a5d:6f17:0:b0:22e:33e7:6f6c with SMTP id ay23-20020a5d6f17000000b0022e33e76f6cmr3084360wrb.201.1665147788492;
        Fri, 07 Oct 2022 06:03:08 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6VJmA4yooQeEP6AWSZxrXCNMZ+Dd6ecWo+EA97vi7kYl5IewCjyra5zBCUEt/PMfgtrGiKeg==
X-Received: by 2002:a5d:6f17:0:b0:22e:33e7:6f6c with SMTP id ay23-20020a5d6f17000000b0022e33e76f6cmr3084320wrb.201.1665147788101;
        Fri, 07 Oct 2022 06:03:08 -0700 (PDT)
Received: from redhat.com ([2.55.183.131])
        by smtp.gmail.com with ESMTPSA id f10-20020a7bcd0a000000b003a5c999cd1asm2822460wmj.14.2022.10.07.06.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 06:03:07 -0700 (PDT)
Date:   Fri, 7 Oct 2022 09:03:02 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Igor Skalkin <igor.skalkin@opensynergy.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, mgo@opensynergy.com
Subject: Re: [PATCH] virtio_bt: Fix alignment in configuration struct
Message-ID: <20221007090223-mutt-send-email-mst@kernel.org>
References: <20220807221152.38948-1-Igor.Skalkin@opensynergy.com>
 <20220807185846-mutt-send-email-mst@kernel.org>
 <02222fcb-eaba-617a-c51c-f939678e3d74@opensynergy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02222fcb-eaba-617a-c51c-f939678e3d74@opensynergy.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, Aug 08, 2022 at 02:04:43PM +0200, Igor Skalkin wrote:
> On 8/8/22 01:00, Michael S. Tsirkin wrote:
> 
>     On Mon, Aug 08, 2022 at 12:11:52AM +0200, Igor Skalkin wrote:
> 
>         According to specification [1], "For the device-specific configuration
>         space, the driver MUST use 8 bit wide accesses for 8 bit wide fields,
>         16 bit wide and aligned accesses for 16 bit wide fields and 32 bit wide
>         and aligned accesses for 32 and 64 bit wide fields.".
> 
>         Current version of the configuration structure:
> 
>             struct virtio_bt_config {
>                 __u8  type;
>                 __u16 vendor;
>                 __u16 msft_opcode;
>             } __attribute__((packed));
> 
>         has both 16bit fields non-aligned.
> 
>         This commit fixes it.
> 
>         [1] https://ddec1-0-en-ctp.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2fdocs.oasis%2dopen.org%2fvirtio%2fvirtio%2fv1.1%2fvirtio%2dv1.1.pdf&umid=d1786ace-e8ea-40e8-9665-96c0949174e5&auth=53c7c7de28b92dfd96e93d9dd61a23e634d2fbec-39b15885ceebe9fda9357320aec1ccbac416a470
> 
>         Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
> 
>     This is all true enough, but the problem is
>     1. changing uapi like this can't be done, will break userspace
>     2. the driver has more issues and no one seems to want to
>        maintain it.
>     I posted a patch "Bluetooth: virtio_bt: mark broken" and intend
>     to merge it for this release.
> 
> This is very sad. We already use this driver in our projects.

Ping. If we still have no maintainer I'm marking it broken, users
should at least be warned.


> Our virtio bluetooth device has two backends - HCI_USER socket backend for one
> platform and uart backend for the other, and works well (after applying your
> "[PATCH] Bluetooth: virtio_bt: fix device remove") patch, so this "device
> removal" problem can probably be considered solved .
> We could help with the rest of the problems you listed that can be solved
> (specification, QEMU support).
> And the only problem that is difficult to solve (because of the need to change
> UAPI header files) is just this one with unaligned configuration fields.
> At the moment, it does not reproduce, because without VIRTIO_BT_F_VND_HCI
> (Indicates vendor command support) feature negotiated, the driver does not
> read the non-aligned configuration fields.
> 
> So, what would you advise us to do? Continuing to use the "marked broken"
> driver, start writing a specification for a new from scratch, better one?
> Or is there any way to bring this one back to life?
> 
> 
> 
>         ---
>          include/uapi/linux/virtio_bt.h | 2 +-
>          1 file changed, 1 insertion(+), 1 deletion(-)
> 
>         diff --git a/include/uapi/linux/virtio_bt.h b/include/uapi/linux/virtio_bt.h
>         index a7bd48daa9a9..adc03709cc4f 100644
>         --- a/include/uapi/linux/virtio_bt.h
>         +++ b/include/uapi/linux/virtio_bt.h
>         @@ -23,9 +23,9 @@ enum virtio_bt_config_vendor {
>          };
> 
>          struct virtio_bt_config {
>         -       __u8  type;
>                 __u16 vendor;
>                 __u16 msft_opcode;
>         +       __u8  type;
>          } __attribute__((packed));
> 
>          #endif /* _UAPI_LINUX_VIRTIO_BT_H */
>         --
>         2.34.1
> 
> --
> 
> Best regards,
> 
> Igor Skalkin
> Software Engineer
> 
> OpenSynergy GmbH
> Rotherstr. 20, 10245 Berlin
> 
> igor.skalkin@opensynergy.com
> www.opensynergy.com
> 
> registered: Amtsgericht Charlottenburg, HRB 108616B
> General Management: Rolf Morich, Stefaan Sonck Thiebaut
> 
> 
> Please mind our privacy notice pursuant to Art. 13 GDPR. // Unsere Hinweise zum
> Datenschutz gem. Art. 13 DSGVO finden Sie hier.

