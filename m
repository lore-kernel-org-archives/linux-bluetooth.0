Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 426E7EB64D8
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jun 2023 12:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbjFVMBe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Jun 2023 08:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjFVMBZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Jun 2023 08:01:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DECB211D
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jun 2023 05:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687435152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fTTkA2sp2q9Z2LAXZ1QDFqA4SF11T5ulFHu3zl8eY5M=;
        b=Zs/GUfo98eRLNy4QFq7qvth/ytd7t2S7DgfpYjlCfcR+TBSkpOgISvc/sbsyY8NeuHsmJX
        SjoYCrrakHVw5RMlXfsNsMP3OfzbXgrqWTOmLkwO2qOGcPBaJa8PpLTVT+0EvyKckUojOt
        RUYLA4LMuxyTk+MULNTyfBWaoz5ASZs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-xf4GoCphPNKeU107iaeFug-1; Thu, 22 Jun 2023 07:59:10 -0400
X-MC-Unique: xf4GoCphPNKeU107iaeFug-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9885a936d01so362607366b.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jun 2023 04:59:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687435149; x=1690027149;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fTTkA2sp2q9Z2LAXZ1QDFqA4SF11T5ulFHu3zl8eY5M=;
        b=XY4PZDp/tDJfHjrTIp83HdDhLS7ID7ygU1ovq3nu7IaqkGb6v77a2xEsO5wLJHAiV7
         4GvX/8x3562As8D1/tGIcoAz1+7C5tmzxR35AXQMlM7OGJM5MCujvl8XNCg+yvB1LZ/H
         oBXq7c1cbX8r7lzWCQB7R6KvjsWpxbYCdvQYpHbm2RjoPIAKakxvPtSGWbM36ZqKcBJC
         Re0YZQW5CgHT30FY6/xnLiuBzgyFS196n992p0W2rzWwKl55ZmEHRxrogw/84e7QDiav
         uPvqaSmDUTosWWaGPpluVjOmVmimiNREcF+mu2QjlIh51pURDN5pfXPKWHkeWfbKbDPQ
         aD7g==
X-Gm-Message-State: AC+VfDwMwNvdQ/2dlL57suToT2+QqQ6Duu3kSd/EjuPo1xCFzbFFP+l1
        viKhKVyBY13GF0l6Sy2sawLUXDBy46V2Y+MLm72ET6ETc59JhqEkJyEux9Sq6FQWGeT/S8HEwBw
        73bSJHjlea/t4MoRREk2e9FgDkxdZ
X-Received: by 2002:a17:907:da2:b0:988:e8e1:6360 with SMTP id go34-20020a1709070da200b00988e8e16360mr8670199ejc.8.1687435149349;
        Thu, 22 Jun 2023 04:59:09 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ60H5p6tlUuyW+YXWTMB9vjFrAWl14WNSb9PT+fUHAJkRDpLgoKLJFf4fBEpXMrE8mEIpD8PQ==
X-Received: by 2002:a17:907:da2:b0:988:e8e1:6360 with SMTP id go34-20020a1709070da200b00988e8e16360mr8670182ejc.8.1687435149020;
        Thu, 22 Jun 2023 04:59:09 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1ef:2a1f:ee44:7b4f:4310:5b81])
        by smtp.gmail.com with ESMTPSA id x17-20020a170906711100b009884f015a44sm4484108ejj.49.2023.06.22.04.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 04:59:08 -0700 (PDT)
Date:   Thu, 22 Jun 2023 07:59:03 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xianting Tian <xianting.tian@linux.alibaba.com>
Cc:     arei.gonglei@huawei.com, jasowang@redhat.com,
        xuanzhuo@linux.alibaba.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, amit@kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] fixup potential cpu stall
Message-ID: <20230622075819-mutt-send-email-mst@kernel.org>
References: <20230609131817.712867-1-xianting.tian@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609131817.712867-1-xianting.tian@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, Jun 09, 2023 at 09:18:14PM +0800, Xianting Tian wrote:
> Cpu stall issue may happen if device is configured with multi queues
> and large queue depth, so fix it.


I applied this after tweaking commit log to address Greg's comments.
In the future I expect you guys to do such tweaks yourself.

> Xianting Tian (3):
>   virtio-crypto: fixup potential cpu stall when free unused bufs
>   virtio_console: fixup potential cpu stall when free unused bufs
>   virtio_bt: fixup potential cpu stall when free unused bufs
> 
>  drivers/bluetooth/virtio_bt.c              | 1 +
>  drivers/char/virtio_console.c              | 1 +
>  drivers/crypto/virtio/virtio_crypto_core.c | 1 +
>  3 files changed, 3 insertions(+)
> 
> -- 
> 2.17.1

