Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CA7C25B0F
	for <linux-bluetooth@archiver.kernel.org>; Sun, 14 Aug 2022 14:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238682AbiHNOOt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 14 Aug 2022 10:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiHNOOr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 14 Aug 2022 10:14:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 867E29FEC
        for <linux-bluetooth@vger.kernel.org>; Sun, 14 Aug 2022 07:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660486485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JLz/nkWkuOhJogoO/pArSt/pc8MAMXUnTi0JWcjLAlE=;
        b=I5TILedL9V7H2UfajKx/4qJlWxVXagvRsc6v67/XVBP3C/d/sItvRW20rQQf35PP9ZeWpK
        iOjWXpmgGD/VMx02uTkzhOotBkp+nUFMvSM1yQnMiS0o2hbNFbfFZXtSl23MBdv9qwbkEo
        mlFjjVt3phAxr2kwoI3ZV1nf340mh3s=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-529-8ErMLHY0MhqgrCSp9gIn_A-1; Sun, 14 Aug 2022 10:14:42 -0400
X-MC-Unique: 8ErMLHY0MhqgrCSp9gIn_A-1
Received: by mail-qk1-f199.google.com with SMTP id bi22-20020a05620a319600b006b92f4b2ebbso4991605qkb.22
        for <linux-bluetooth@vger.kernel.org>; Sun, 14 Aug 2022 07:14:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=JLz/nkWkuOhJogoO/pArSt/pc8MAMXUnTi0JWcjLAlE=;
        b=BVHAO6WKpGKNOBT8ROocAj8z/y3DGWKf8+jQ2Lmc5NfTaXZQkLPvjbR5GqBTCQPDyU
         YP6YEx88Rkzn69rUWgHZyyXc2uGDBoimeePoiIhf+U8ZEc6M9VLLQx7KWp7DkE6sntOM
         Z/iBRPcU+Egkzf9Rg9V1J7b2/KaNKiK5ZkrVEDOhXoDSSuiEJmubRO2uis4u04yBRipl
         LEVmHyTTy8TUrU8lZubdSEKDa9x01VIGgk3j94HgTdm5mV2u+MQ2THVCPTz/dHcVm7nQ
         slNwlQ8h2e7k9LIZJ8RTZk8YbJ1tVl5V4aikV0OEzll+WFRUT1sRIIggDqNksCmYpY64
         X1Vw==
X-Gm-Message-State: ACgBeo1y4Yjc1qoApdW2wPk6ERWCsrOZ3sFp1NpxkFh+bm9t5h4x6lfw
        65V6ZH3Z2tdzGk34+jFIrYkfTlsxsWz83AKpQuABiCyShEP3P6lDe2sdfmdROPdTxa8so71qwJa
        H02o2FenKQh3EVMAlixqPIQBZgEt0vRcDUI39jpINlgb4
X-Received: by 2002:a05:622a:4cd:b0:343:65a4:e212 with SMTP id q13-20020a05622a04cd00b0034365a4e212mr10506025qtx.526.1660486481851;
        Sun, 14 Aug 2022 07:14:41 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5du35rQz9qs9g1n7nJMCVW9riJK9azlzbwtkicC2TL+kP73rs++J7+K+9j1Ne6HJ9siqIA2kDGIObKYxbew1g=
X-Received: by 2002:a05:622a:4cd:b0:343:65a4:e212 with SMTP id
 q13-20020a05622a04cd00b0034365a4e212mr10506009qtx.526.1660486481583; Sun, 14
 Aug 2022 07:14:41 -0700 (PDT)
MIME-Version: 1.0
References: <3a3904c4-1bf9-ef1b-3d03-b5c3e1e2f8c5@desertmonitor.com>
 <CAK-6q+gBUHaR5njKHJJnONW41duVafMA-6R8jKMtN=7M1mg6rA@mail.gmail.com>
 <f1dcf16f-938c-0768-4c88-754a0ea7c2d0@desertmonitor.com> <CAK-6q+hfJ=oUHx0t7ueaNxg8NVsQZ2oJZ9wzj1PoP1fhHwpMrg@mail.gmail.com>
 <1d51db1a-746c-db67-99ec-cfe5c5a43616@desertmonitor.com>
In-Reply-To: <1d51db1a-746c-db67-99ec-cfe5c5a43616@desertmonitor.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Sun, 14 Aug 2022 10:14:30 -0400
Message-ID: <CAK-6q+iM-UCL_CCgpVOMB3UqYf+1BJQLrP4+1cxwNoCyJuE9dg@mail.gmail.com>
Subject: Re: 6LoWPAN (IPv6 over BLE) neighbor discovery
To:     Philipp Blum <philipp-blum@desertmonitor.com>
Cc:     linux-wpan - ML <linux-wpan@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Wed, Aug 10, 2022 at 7:12 PM Philipp Blum
<philipp-blum@desertmonitor.com> wrote:
>
> Hi,
>
> sorry, just realized I used the info@ email ^^
>
>  > What kind of workarounds? I am curious...
>
> The radvd workaround to distribute a PD.
> Ideally I would like it to be as plug & and play as possible.
> Connecting the sensors to my router and passing down the PD
> automatically. At the end of the day, not everyone is a dev.
>

Setting up a router is considered to be at least an "administrator"
level. You need to at least provide a prefix. The RA message is from
the Linux kernel networking branch considered as a user space message
(on the transmit side, the receive side it's different), I doubt that
this will ever be changed. At the end the user needs to configure
something in any case.

>  > Okay, if you like you could also try [0] on bluetooth networks... I
>  > never did it on bluetooth. Although I think it does not make any sense
>  > because it makes only sense on a mesh network and so far I understand
>  > this is the difference between bluetooth 4.x vs 5.x/upwards and
>  > currently there is no mesh bluetooth 6lowpan support here (but mesh
>  > bluetooth on link-layer is there). It's a star topology. I guess what
>  > you could try out is ndisc-proxy setup which is mostly the same but no
>  > routing involved and they share the same prefix.
>
> Btw, I am on Bluetooth 4.2. I had a hard time to even find non audio
> only Bluetooth 5.x USB sticks. Yes, it's only star topology so far. Even
> though, from my understanding, you could theoretically run a RPL network
> behind it.
> There are more powerful MCUs that would be able to act as a RPL root.
> Even though it probably would be better to use the linux border router
> as root. Puts less pressure on the sensor nodes.
> I am not familiar with ndisc-proxy. If you could point me to some
> resources, that would be very helpful. Going to take a look into it.
> Sharing the same prefix would be fine for now, since I only run it in a
> star topology anyway.

It's also known as arp proxy on IPv4. Just google it, but for IPv6 you
need to have a daemon in the background to make it automatically
configured. Although I recommend at first to try it with a manual
setup by using iproute2.

> RPL should be, from my understanding, also work on BLE. RIOT allows
> three concurrent connections for BLE, as I remember.
>

Sure it works on BLE, but here you have a star topology where RPL
makes really no sense. It is just one parent with leaf-nodes and radvd
will do the same for you. From my point Bluetooth mesh topology is
supported by the kernel right now as link-layer but there is no
6LoWPAN adaptation (speaking on Linux kernel level, IETF has standards
for it) to run 6LoWPAN on BLE mesh topology. What we currently support
is the star topology one which is how Bluetooth works for decades.
Only on a mesh RPL becomes interesting.

> I don't really understand why rpld only works in a mesh network.
> When it runs on 6LoWPAN, it should also run on BLE, or am I missing
> something?
>

I did not say that it does not work, I said it makes no sense to run
it on a link-layer star topology. If it's a mesh it looks different.

Another thing to test would be a 6CO option [0] which will allow
6lowpan to compress non link-layer prefixes. It makes sense to add one
like your prefix destination option in RA. For the arp/ndisc solution
you could simply reach all neighbors by its link-local address. To be
more clear, the arp/ndisc proxy needs to be configured on the device
which was before your "router", then magically all neighbors behind it
can be reachable by its link-local... if you want to access it behind
your local area network, then you indeed need a global prefix and
routing/gateway/etc..

Note that [0] never came upstream (except one patch) because the UAPI
in Linux kernel is not stable, I am working on it right now and my
progress is at about 25% to make the UAPI stable. :)

- Alex

[0] https://github.com/linux-wpan/radvd/commit/562e1b3264ac1f352dcc3521f6256d16057775ba

