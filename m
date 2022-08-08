Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 075E7C00140
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Aug 2022 12:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242421AbiHHMQR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Aug 2022 08:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235719AbiHHMQP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Aug 2022 08:16:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A3B2A62C5
        for <linux-bluetooth@vger.kernel.org>; Mon,  8 Aug 2022 05:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659960973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KQglINn5qIliFhQxdXnssuNFpnHg6itQvnE5dnSG+xE=;
        b=FP1n6iFyjMAzd1nqUb8NLw9Lt4Rndo7fzS+J+5s70Dog01aZwPTVMeRJVjZiNcVBDZ32eu
        7PgKkfEyzZ3xk42sBa8Wcm2YT6W02oHxAlmrZciQRqWCRdhCTWwdPH/9wfqmhMmyTCbahk
        IajlHigGVgG7I5noxW1u0y2gEO+Uf+8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-615-Oucb125RNd6NAQcilAmy6g-1; Mon, 08 Aug 2022 08:16:12 -0400
X-MC-Unique: Oucb125RNd6NAQcilAmy6g-1
Received: by mail-wm1-f70.google.com with SMTP id h126-20020a1c2184000000b003a4f57eaeaaso2885637wmh.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Aug 2022 05:16:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=KQglINn5qIliFhQxdXnssuNFpnHg6itQvnE5dnSG+xE=;
        b=g/03HfpPOhNrF2EbX5DZgg037CfTn+ZIJ7bIhxQkTePMXtY/kZ2T2QhCr9UxSAO/+w
         f1EZ1RghOB3/c7xxDzI87TIfsVY7RM1j+OCeQj/OqER8v/x/wLcStcl/8+iQycR7a5Cc
         JIQ6A+GIVnov7R2CQiEUPfdd3j793CFrmiLpOlCqwAU+Jo8xkfLP9dK2p2ogzYs1O1ZG
         soGmmjkFJR337e4Xa2zMKefj8iqbmxiFV+5Cb5qGTYYC9tR56uyyRNF1n5r1qAit6F2s
         m6DEHK8PPysbIZaaYp43+mkIjZ7kKkdYNPBBdtmnsXSNT5KQp2QRPMcEQP8+GuZ26zfy
         LoIg==
X-Gm-Message-State: ACgBeo3jQawkDbER5BNrDUJSqQNedcl2yT/JWdsBwlXhA3eMhlyxB8nh
        f+C9DdhKAmntgQKzHnazPSykbNy1sEWmXlCsE0hQ/8Rbfp0hzmjs2efzVBgTMu1qYrwYekho/sl
        KXzeT7YUBnL0TRuNz/3VckT8d31P0
X-Received: by 2002:adf:ecc7:0:b0:220:5fef:6d40 with SMTP id s7-20020adfecc7000000b002205fef6d40mr11346423wro.5.1659960971201;
        Mon, 08 Aug 2022 05:16:11 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4zU6VHrKnAMD/aDkLqilJynNkwCVR51Kx58+rPxKSAaPZ1EV8m5UjTlEMZZCTPAQylrfDvzg==
X-Received: by 2002:adf:ecc7:0:b0:220:5fef:6d40 with SMTP id s7-20020adfecc7000000b002205fef6d40mr11346410wro.5.1659960970977;
        Mon, 08 Aug 2022 05:16:10 -0700 (PDT)
Received: from redhat.com ([2.52.21.123])
        by smtp.gmail.com with ESMTPSA id c24-20020a7bc018000000b003a53731f273sm5898667wmb.31.2022.08.08.05.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 05:16:10 -0700 (PDT)
Date:   Mon, 8 Aug 2022 08:16:06 -0400
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
Message-ID: <20220808081054-mutt-send-email-mst@kernel.org>
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

Really?  Can you step up to maintain it? Then we can fix the issues
and it won't be broken.

> Our virtio bluetooth device has two backends - HCI_USER socket backend for one
> platform and uart backend for the other, and works well (after applying your
> "[PATCH] Bluetooth: virtio_bt: fix device remove") patch, so this "device
> removal" problem can probably be considered solved .

Can you post a Tested-by tag for that?

I need to go back and review it, I think I saw some issues but must be
fixable.

> We could help with the rest of the problems you listed that can be solved
> (specification, QEMU support).
> And the only problem that is difficult to solve (because of the need to change
> UAPI header files) is just this one with unaligned configuration fields.
> At the moment, it does not reproduce, because without VIRTIO_BT_F_VND_HCI
> (Indicates vendor command support) feature negotiated, the driver does not
> read the non-aligned configuration fields.


Hmm. So how about this:
- add a new feature flag
- add new aligned format
- mark the old memory reserved in the spec


> So, what would you advise us to do? Continuing to use the "marked broken"
> driver, start writing a specification for a new from scratch, better one?
> Or is there any way to bring this one back to life?

If someone is prepared to work on this we can bring it back.



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

