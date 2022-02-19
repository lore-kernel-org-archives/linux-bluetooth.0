Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218BAC433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 19 Feb 2022 23:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbiBSXTH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 19 Feb 2022 18:19:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbiBSXTG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 19 Feb 2022 18:19:06 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B39D42A17
        for <linux-bluetooth@vger.kernel.org>; Sat, 19 Feb 2022 15:18:45 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id u20so11933271lff.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 19 Feb 2022 15:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=sYlfUvmASJJE7FL9eryicNemduu1ELetHdlq51J+iJw=;
        b=c8z65IeoakXJDU0SI70tF82/noCHWnq7Dc364CxnZckG4eDWLt5E23S7QzS06vXd86
         MMgEsNlaQ/VJW6nW/JBynjvE7b8ZSeyOuwSUKvRbfhqStNI3mGnqBZ+Qlc/mz0LvAQP3
         0uJ0T4vQMnwNfmGJma9tfu9oAgBUg208dZnfmV64lejJTvt07nENcLYeJv860mLzADp6
         oRSubzCY47TYS6PtneB8/LX8hUAlF8G2yb6cOrhiycqH/qVUiATb9/OeN6KbCBopxzSj
         mF4uaTUP16Q78SzkhnmcKfvdL9YTbT0NoOgFmppmmm0qJJn0wR8yRt4FHmqzoee+Ryzw
         nYjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=sYlfUvmASJJE7FL9eryicNemduu1ELetHdlq51J+iJw=;
        b=lGoo1HCWVfOs/mRNfgUvCksrsYLWyGWS61Kk00uOSBHnkxoMDtb9DOLS5+fJ9xCj7g
         wicnjo5vcQwmUm2IC3ZmSeMpZB39jbDDdMnobvQqAF7rPfMmaCqmuyJYb4F60eYsfunq
         eike4HYQtbgoICERpnbBFoNBu+jTIjOOjadnKI4BurkcYZ1hn+qOwrSNrhyC3ItAZ4V8
         mChsQSDmklMoDzu36bNxnaQTF38A4XXjt0Yj67eaaszG5qm1Kt7Wih9a2CNNXt+z7nip
         fFdBqtPFR/UlQUFDeS4uashuv5LVmyoP9RB5siDRub0Glp84qrlRTn6buKGGdqhkWsJN
         pt6A==
X-Gm-Message-State: AOAM533one5zpD69bv4bqJtmQEiZBi6jgA4uDFLOgstA7Nj4ftWG/IiO
        NtyjotTHW/EAf1oNH/60+2I=
X-Google-Smtp-Source: ABdhPJxIwexDOzZblKOB8PT9m432DtMVJXVt1z8ILBZgT4zhiRKcOHSlVnUGIM8/0oSwOXnhHskZQw==
X-Received: by 2002:a05:6512:3884:b0:443:c530:78bc with SMTP id n4-20020a056512388400b00443c53078bcmr4425755lft.411.1645312723521;
        Sat, 19 Feb 2022 15:18:43 -0800 (PST)
Received: from ?IPV6:2a02:2168:8737:3600:57b8:cdf6:2169:b497? ([2a02:2168:8737:3600:57b8:cdf6:2169:b497])
        by smtp.gmail.com with ESMTPSA id g19sm815446ljm.7.2022.02.19.15.18.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Feb 2022 15:18:42 -0800 (PST)
Message-ID: <6de28c0c-82d5-648d-efb5-a483ede899e1@gmail.com>
Date:   Sun, 20 Feb 2022 02:18:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <f610b069-07ab-1004-e8f1-b84533593c92@gmail.com>
 <CABBYNZLA6bRCxd=Tse_XbUT8ReBo4QjvstSassfQAcTX+Fk9_g@mail.gmail.com>
 <b50b9b75-96ea-0d93-3687-3a79cdec5419@gmail.com>
 <CABBYNZKAUMOZ8vhk2ATPOaVHbcqCTg-DMD2vypkx_CTOjeVg2g@mail.gmail.com>
 <6bec2be7-a411-c5bf-6e5d-b3efee33b834@gmail.com>
 <CABBYNZLAZGoB1JKW63SNJuFB-4raDvHjjEk4w8y0K1MLwe4b7A@mail.gmail.com>
 <b7a2b073-fd69-36a4-6ce0-cb1b942ccde6@gmail.com>
 <CABBYNZKjUYAqctfpap2f36TcBuJFk0wX5P8jkUjpw1qqupeb0A@mail.gmail.com>
 <72b3b0ee-cca0-3804-ce78-1345c4590963@gmail.com>
 <CABBYNZJL4YCpXHL8ihSFh04fEGAqcB7K8a9aR22E6TwB2Wj0Tg@mail.gmail.com>
 <12462d5d-b140-6b08-2e72-d8fd77105086@gmail.com>
 <CABBYNZJg0qHO4gvLh8O44um68CzRMM4PE3OymRhGfiQ1kDZO1w@mail.gmail.com>
From:   Andrey Butirsky <butirsky@gmail.com>
Subject: Re: Lenovo Legion M600 wireless bluetooth mouse connected and paired
 yet not working
In-Reply-To: <CABBYNZJg0qHO4gvLh8O44um68CzRMM4PE3OymRhGfiQ1kDZO1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On 19.02.2022 00:38, Luiz Augusto von Dentz wrote:
> Hi Andrey,
> Did you manage to test with latest git? Note that windows does seem to
> handle composite HoG device:
>
> https://github.com/bluez/bluez/issues/258

I built bluetooth kernel modules from bluetooth-next, tag v5.13. Not 
sure if it made any sense or my distro kernel already included them..

Anyway, there was no any difference in mouse behavior.


> Btw, it could be due to:
>
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?id=aa699cb762a02ec7409940ddcfe65b788de8270d
>
> There were some systems (afaik 32bits) with a problem with the header
> copy we had.
Can I check it somehow?
