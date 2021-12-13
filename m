Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CDFC433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Dec 2021 10:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235125AbhLMKoR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Dec 2021 05:44:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:54778 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232531AbhLMKoQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Dec 2021 05:44:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639392255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SHL+BcRj/pmK+hyLHDbkPYvC+IuJaADgZcfi3kBucvo=;
        b=h+4xhvn2Yf8Aw0eWkec0n7DaCcXWEQ81uxTmlFfv33AygtMbduNRw078wHp3RAQHKWnfb+
        5HV/EbONHtnoA02Z9PfEOgFYAIBXgtiO03DthJTGSRIc73cz6/lGRrxGTD8YIzz2FNkM8J
        U9WS2QbZuNymCfmGk60TQjEJA7gp9to=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-319-XTjHzduxMF6-tFtTbc_Emg-1; Mon, 13 Dec 2021 05:44:14 -0500
X-MC-Unique: XTjHzduxMF6-tFtTbc_Emg-1
Received: by mail-ed1-f70.google.com with SMTP id m17-20020aa7d351000000b003e7c0bc8523so13563480edr.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Dec 2021 02:44:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=SHL+BcRj/pmK+hyLHDbkPYvC+IuJaADgZcfi3kBucvo=;
        b=g4msH4RmZAQI2nSIs39d5iVA+0oiUbuY04st+T9ep7em01Vv6UcKHuBc1mi/q+CLwQ
         mOo1s8Wpnt2SDIBpnkEV2nDdvGo7gxj1IX8ATMkclPpj8pLj8Wk7GRA7VcDibeZcZsDa
         Ae9n9up0L2wIiKIu6DMD8CXfWBubcdYzrWOVtBYXoSMC4eeV3dPkVL76uYpcDaP3OZ9x
         UJOreVzov5uB1HNrPihJTOzVkaWiICA0quqkJ9TLKWPPHZXLFbCB2hAEpkWzcElpHy+m
         I5Z8oMp6XJlUv65THYnHuN0OZCBd3GSjPK+cZ+r5vtJocFKCG6RmaLCKfhA24xnu0h85
         twZw==
X-Gm-Message-State: AOAM532UaN292qMrfn7LEPilfyILQ22Fkqg3MxRpicIYGcCErbQHoc48
        1qpNJe1ICYsLNWpK8Q70Kqu5BjySHbwctrRSU8YX6lAOOk6abxP9RqXg79rKJPtiLH/660agsnR
        CMkW64JZXFJv1oztsj6Kv7BovbpVs
X-Received: by 2002:a05:6402:3459:: with SMTP id l25mr64590533edc.137.1639392253444;
        Mon, 13 Dec 2021 02:44:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxNOaEpqXN+b3HAuKmJouNEtF+PGIf4t0ZSl55UBSuLUkEDHpoVO/YC9kejLGFYbRvvWZpNHg==
X-Received: by 2002:a05:6402:3459:: with SMTP id l25mr64590503edc.137.1639392253233;
        Mon, 13 Dec 2021 02:44:13 -0800 (PST)
Received: from redhat.com ([2.55.148.125])
        by smtp.gmail.com with ESMTPSA id cw5sm5741448ejc.74.2021.12.13.02.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 02:44:12 -0800 (PST)
Date:   Mon, 13 Dec 2021 05:44:09 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] Bluetooth: virtio_bt: fix device removal
Message-ID: <20211213054357-mutt-send-email-mst@kernel.org>
References: <20211125174200.133230-1-mst@redhat.com>
 <F52F65FE-6A07-486B-8E84-684ED85709E9@holtmann.org>
 <20211209162149-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211209162149-mutt-send-email-mst@kernel.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, Dec 09, 2021 at 04:22:58PM -0500, Michael S. Tsirkin wrote:
> On Thu, Nov 25, 2021 at 09:02:01PM +0100, Marcel Holtmann wrote:
> > Hi Michael,
> > 
> > > Device removal is clearly out of virtio spec: it attempts to remove
> > > unused buffers from a VQ before invoking device reset. To fix, make
> > > open/close NOPs and do all cleanup/setup in probe/remove.
> > 
> > so the virtbt_{open,close} as NOP is not really what a driver is suppose
> > to be doing. These are transport enable/disable callbacks from the BT
> > Core towards the driver. It maps to a device being enabled/disabled by
> > something like bluetoothd for example. So if disabled, I expect that no
> > resources/queues are in use.
> > 
> > Maybe I misunderstand the virtio spec in that regard, but I would like
> > to keep this fundamental concept of a Bluetooth driver. It does work
> > with all other transports like USB, SDIO, UART etc.
> > 
> > > The cost here is a single skb wasted on an unused bt device - which
> > > seems modest.
> > 
> > There should be no buffer used if the device is powered off. We also don’t
> > have any USB URBs in-flight if the transport is not active.
> > 
> > > NB: with this fix in place driver still suffers from a race condition if
> > > an interrupt triggers while device is being reset. Work on a fix for
> > > that issue is in progress.
> > 
> > In the virtbt_close() callback we should deactivate all interrupts.
> > 
> > Regards
> > 
> > Marcel
> 
> So Marcel, do I read it right that you are working on a fix
> and I can drop this patch for now?

ping

> -- 
> MST

