Return-Path: <SRS0=p1bJ=U7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED2FFC06510
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Jul 2019 19:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C569421852
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Jul 2019 19:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uI3os6/C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfGBTWj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 Jul 2019 15:22:39 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:46282 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbfGBTWj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Jul 2019 15:22:39 -0400
Received: by mail-ot1-f52.google.com with SMTP id z23so18362511ote.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jul 2019 12:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fi62SFA1si7wJ3y5KVsmEnWdEJ30bS62Jt3Mc4SRsjU=;
        b=uI3os6/C/t+vM+B++XwsUfIofaXLjsk0xLi9xSzBZCn8ZfS3oZJe9dXjBmnNlrk9dK
         gt5WxoLeOwinNQsZND7Ei0jOdPIaSok90wFoclsx3q9Zu7CkYqW81wY8Ul2i6MsAoXPo
         wThbIFej/BHaQWcBsjry/CFVvt0b/rTiMg1GPLk07YAdj4/sD14rQqDDXg7W/fDvvGer
         SywuFq3gLV6p4TVXc7qXyN+0Tn22p9/kCEpZ7mNMkadZ88yoJ0lq4yMB0xkyeNKRmM5T
         8UoB/ogtZFb5s6GIrYT2FNZ/TlXad7VKNormso1qdEPoty1WoPcRk3j961mRwz05DgLN
         shZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fi62SFA1si7wJ3y5KVsmEnWdEJ30bS62Jt3Mc4SRsjU=;
        b=fdSbV4xzcMmwXGchAW5KJcOGJCDplS2iEjSEPcTBGVAVyUHdMG8ow/8iuSl3TV+zu7
         ogPE/dnTbw/J7TBbdVd3vmVufTnuyxeXsuAZEKhjGT5M8CT7gZJHVJIueUYugZT+hAyE
         86D+7YsoBR0S74YRZHQY5Fw+yoA2nFCB3Icdg6CQFk+IbJbjXRTF8rCxYX0BCQNqoE0s
         xoPEPRo11ljkNE51Q+SfmAMyzz/qvGV0aS3/p+syyOfESTrBhxpMdU+iDeT9nlgpiNIK
         gtDyR5jwFWFhtAGlZrEH80WxNAFvdMbl57q0cOQvk1F1T9seqnm0m1W+rBkSBBKJgaTF
         o7hA==
X-Gm-Message-State: APjAAAXrb0JM8mx3DPmVP3K5oYkFXu5idrXrBDSKet/QJCx7YzESyzPu
        tqES6o7LD0F099zj8i4G7+uzN3o1CQRLCNhkYxA=
X-Google-Smtp-Source: APXvYqwDnAKavJ3s8Xg6uXoUd26fBPzvw+/uv9bHdiib3Iv/wz/EztQY0lvpeMSiYEssOmwfIoavBahsGINxpq8Uf3U=
X-Received: by 2002:a05:6830:199:: with SMTP id q25mr24012958ota.79.1562095358224;
 Tue, 02 Jul 2019 12:22:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzhej0YJ6b+=nFXHiiZPJnSdOm=F_OaXR5kWFjvbw2107X94Q@mail.gmail.com>
In-Reply-To: <CAEzhej0YJ6b+=nFXHiiZPJnSdOm=F_OaXR5kWFjvbw2107X94Q@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 2 Jul 2019 22:22:26 +0300
Message-ID: <CABBYNZL-0mXtoQ1vUs=SWcBywET1y6A_xfd4KjTVLoE5gyp8vA@mail.gmail.com>
Subject: Re: BlueZ Central to Peripheral latency issue
To:     Mathias Baert <mathiasrobaert@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        subhoshankar.basu@ugent.be, Jeroen.Hoebeke@ugent.be
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Mathias,

On Tue, Jul 2, 2019 at 3:33 PM Mathias Baert <mathiasrobaert@gmail.com> wrote:
>
> Hi,
>
> We are using the BlueZ 5.48 version on a Raspberry PI with Raspbian Stretch 9.1.
>
> The setup is this PI connected with a Nordic Semiconductor nRF52840
> device, via an IPv6 over BLE connection. The connection is using a
> connection interval of 7.5 ms. Via throughput measurements with iperf,
> both ways (central to peripheral and peripheral to central), we are
> able to achieve maximally ~ 100 kbps (using the 1 Mbps PHY).
>
> However, when looking into individual packet exchanges, we notice a
> significant delay (up to 1 sec) in the RTT when pinging from the
> peripheral to the BlueZ central and back. We also see a huge
> fluctuation in this value and it also depends on the intervals at
> which the pings are fired (lower throughput gives a much higher
> average individual latency). When firing ping packets at a 1 sec
> interval, it is definitely visible.
>
> When looking into this, we found that the latency between the
> peripheral and the central is quite stable and low enough. But the
> latency between the central and peripheral is fluctuating a lot and is
> generally quite high. Is this something you have noticed before? We
> think that it could be a scheduling issue on the kernel, where higher
> throughput gives more priority to Bluetooth communication?

So I assume this is using the experimental IPSP support with Zephyr as
peripheral? Usually, the Linux side is quite a bit more complex so it
is not surprising it can take more time but not 1 sec. so it got to be
something that is causing the extra lag, perhaps you can paste the
actual commands you are using to ping one another.

-- 
Luiz Augusto von Dentz
