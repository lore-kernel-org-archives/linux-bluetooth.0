Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C020EC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Feb 2022 18:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234415AbiBJSk0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Feb 2022 13:40:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbiBJSkZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Feb 2022 13:40:25 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8514F10C2
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Feb 2022 10:40:25 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id da4so12451433edb.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Feb 2022 10:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=fgRzixamvpR48amk1YiH/CSolWJUEMxdGnC43ZwS8mM=;
        b=kF3/ei6POhmPwCUANnWEkJT12mJ3QSFYDB6nVxapvWe6vdvDw9jVO+lrtInFL/emIi
         8ZlGA2KrfYIsVmZwOhNfwdfm/0K74uHwlACv11B2VFiL9BwOXqgyCZ1z9IXJtYDrBLdC
         vcxE5rtAqj12k11+diNoMPQ3T6KfKWR7GZ2Qg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=fgRzixamvpR48amk1YiH/CSolWJUEMxdGnC43ZwS8mM=;
        b=QuhhK5vFeI9a32oh/cHxoJeeOI/CvsNAru0cxqtCanf9E0wyr7NX7FiJkZKU//sW6s
         /iLuuoIyLSbrybbuMLpspU5XqPNEJi5UvWkpyGC3WM46YGNL/6WMiN7G8yqidoQhH4Q/
         M4UVI+aJW1hP+LMbbTAns/o+ntXvNXHdxZhTz3qEWjpSvLgu0IYlWsE68toLMn+wYUgT
         KVGP+7X+wVeEbAoXX6z55rCZ97/C7uQINQi4Bqsmy6J092f7Hhk88Dgbjy5sX2HYNud/
         eCx6qQB657eVU+D+s9YunMm/RKShf5Bvu0e6VMm+RPMVScnXRRO9F50sMY5KKO8lYORV
         aNtQ==
X-Gm-Message-State: AOAM530rP4Jh0fOtuHAprY/loZ7HqGDjelLIEX6hFdAQRJJiqnIBccrW
        FawfGv0uT7q2BsUQKqr9p6CFtyzI8t+roA==
X-Google-Smtp-Source: ABdhPJyz8NK36t8CPkPzdQMx7fSSKRmJ7+sxGxuxdwJ5yceD0yyb/p+T3M8H6UgKDFJASmHDsUo0ew==
X-Received: by 2002:a05:6402:50d1:: with SMTP id h17mr9498572edb.286.1644518423744;
        Thu, 10 Feb 2022 10:40:23 -0800 (PST)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id bm4sm8363656edb.21.2022.02.10.10.40.23
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 10:40:23 -0800 (PST)
Received: by mail-wr1-f45.google.com with SMTP id d27so11181571wrc.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Feb 2022 10:40:23 -0800 (PST)
X-Received: by 2002:a05:6000:38e:: with SMTP id u14mr7255876wrf.638.1644518422579;
 Thu, 10 Feb 2022 10:40:22 -0800 (PST)
MIME-Version: 1.0
References: <CAO271mmuMDoqNdXUUuPpyz3VyuLWrZUr1K=Jry+H9mGEtz-Z4Q@mail.gmail.com>
In-Reply-To: <CAO271mmuMDoqNdXUUuPpyz3VyuLWrZUr1K=Jry+H9mGEtz-Z4Q@mail.gmail.com>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Thu, 10 Feb 2022 10:40:12 -0800
X-Gmail-Original-Message-ID: <CAO271m=vQsGwRvpe2tUUMuqB7r2z2cAut27U1LY6bQ_sHAk3NA@mail.gmail.com>
Message-ID: <CAO271m=vQsGwRvpe2tUUMuqB7r2z2cAut27U1LY6bQ_sHAk3NA@mail.gmail.com>
Subject: Re: Question about Trusted property
To:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear maintainers,

Friendly ping on this question. Does adding "Bonded" property to
org.bluez.Device1 make sense?

On Fri, Feb 4, 2022 at 4:02 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
>
> Hi Luiz/BlueZ maintainers,
>
> What is the purpose of the Trusted property on org.bluez.Device1
> interface? Does it mean whether the device is bonded? My experiment
> with BlueZ shows that sometimes a device with "Trusted" property set
> is not bonded (does not have pairing key stored) and also vice versa,
> so I am assuming that the Trusted property means something else. What
> is an example use case of the Trusted property?
>
> Eventually, what I am trying to achieve is for BlueZ clients to find
> out whether a device is Bonded or not. Using the Paired property is
> not very accurate because it is set to true during connection although
> the device is not bonded (pairing key does not persist after
> disconnection). For this purpose, I am about to propose adding
> "Bonded" property to org.bluez.Device1. Some use cases include when
> there is a temporary pairing with a peer device we don't want UI to
> show that the device is in the Bonded device list. What do you think
> about exposing the Bonded state via D-Bus? I will do the
> implementation if this idea makes sense.
>
> Thanks!
