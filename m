Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4EAC4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 21:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiKRVcX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 16:32:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiKRVcW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 16:32:22 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD00786C0
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 13:32:20 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id h12so8324028ljg.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 13:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xytzPwZVsyCz6Lq8RyB7dUYbAuvT8b3vgi/qSIlY7lk=;
        b=lAYM2OTWE1WbYSKgQ/tjHFV+bHpmffasIm8+SWOKtKf5xGeZv15yCVOp48nSGV+a4I
         FufkKD3o+JoFylGSmS61jHoNnxoPZPXtSZJD+pxka5Z2MJpX7bx2tT0H9QBGsTXZBaJs
         DdDeNwSQeH+X+op2QALdMLnqZjQabNfq9FLQf1K3VmXIt5QHhuE2caYB4a3xPMB4ltrz
         85/omvEUDOcf1UqvSdMZ1vyONlnE8BvluVLdMjlABmrsXd0yH4J3RTB3PguRV6ONnczM
         dHQl29ssnITnLbYDIVSNQVHXOBLEJvMeNfM+dCSCPJfcD3QZ/aZapuRgZbNXsvFbI4vE
         pXqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xytzPwZVsyCz6Lq8RyB7dUYbAuvT8b3vgi/qSIlY7lk=;
        b=OkCq5WX4KAkKlvPABkeLav26jVAQiduHPw4q8XL1JEIqvILejunkJfamFUIGtQEZu7
         4TdmACFl8ADJ7BLPkcSeV2mvkUPmMX0rvHYNuYPUKqRuUkVDaOIWZfkRX8Mcsho087d1
         ENwPDnIhbN6GQ74s7X57ZRR6ZJcCxcLwvB+3KclZa+ggM6Z9OkvAnei8Odfln1mofbv+
         2DrBvY6kPSJ30rEV0vn+7QDDnc42JZdqxBEIu1plGZm1UKM2AOreFtzD213upKTyCZ0M
         s3mzs6v9dZh/oGWIC9C2PvUEZwjzQgSAkh8gik7r+vSFLy69vtj7KyMvece5PgJY17kc
         CEcg==
X-Gm-Message-State: ANoB5pmAUlxjVfuxZKeBHLf3lSe6nHVmJKkj+1dAiKyK7dWJrcVqpmbS
        fniPfMNgXNl3uf7j4kakE8kVx2ALrAcmgh2gu+21dW8W
X-Google-Smtp-Source: AA0mqf7PwL2ElHtBfx5lGIE2RGklmLVDyBHLBHs8/4gmWSAbt7GQblGTzMRh4xpeKc5ZTbMCaf/h+kqegPOMfisMtUw=
X-Received: by 2002:a05:651c:389:b0:278:f5de:8478 with SMTP id
 e9-20020a05651c038900b00278f5de8478mr2822705ljp.65.1668807138603; Fri, 18 Nov
 2022 13:32:18 -0800 (PST)
MIME-Version: 1.0
References: <f9213307-e4c3-902a-e0b6-aed53f3a1e02@rhrk.uni-kl.de>
In-Reply-To: <f9213307-e4c3-902a-e0b6-aed53f3a1e02@rhrk.uni-kl.de>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 18 Nov 2022 13:32:06 -0800
Message-ID: <CABBYNZLqGxBC-tNAPMyYrHFqF0PR86CY-G+JWYPYE59ia4-i3w@mail.gmail.com>
Subject: Re: LE Advertisement on data channels/ btvirt
To:     Marvin Sinnwell <msinnwel@rhrk.uni-kl.de>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marvin,

On Fri, Nov 18, 2022 at 8:24 AM Marvin Sinnwell <msinnwel@rhrk.uni-kl.de> wrote:
>
> Hello everyone,
>
> TL;DR: Seeking advice on advertising on arbitrary channels + usage of
> btvirt specifically function "send_adv_pkt".
>
> I am currently working on my bachelor thesis and have the following
> problem with I would like to request some advice:
>
> I want to test several algorithms that try to improve the time it takes
> to find an advertisement packet of another device. For this I not only
> want to change the method of advertising, on channels 37-39 in
> sequential order, to something else, but also send advertisement packets
> on other channels.
>
> My main difficulty currently is composed of trying to find out where the
> actual advertisement packets are sent. Currently my best guess is, that
> is is controlled by the firmware of my raspberry pi that I am using
> (specific model below), because I could not find anything within the
> bluez stack. Maybe one of you has more knowledge on where I have to search.
>
> What I was able to find was the btvirt tool, which could help with my
> problem. There I found in the file "le.c" in function
> "adv_timeout_callback" another function called "send_adv_pkt". Sadly
> while trying out btvirt and clever usage of some print statements I
> could not see the function be executed. Maybe someone can give me some
> advice on that, because this function should do exactly what I am
> looking for. It could be that I was just using the tool incorrectly in
> which case it would be great if somebody could tell me how to use it. My
> methodology was: 1. "sudo ./btvirt -L -l2 -d" to create 2 new local LE
> controller. 2. Start advertisement using hcitool "sudo hcitool -i hci2
> cmd 0x08 0x000a 01". The advertisement is correct and the other local
> controller can connect to the first one.

I don't think vhci will help you given it only emulates HCI layer and
the channels are actually controlled by the so called Link Layer which
happens to be under HCI, you might have control over the Link Layer
using Zephyr though.

> My current equipment is:
>
> Device:                Raspberry Pi 3 Model B+
>
> Kernel + OS:       Linux raspberrypi 5.15.61-v7+ #1579 SMP Fri Aug 26
> 11:10:59 BST 2022 armv7l GNU/Linux
>
> Bluez version:     5.65
>
>
> Kind regards
>
> Marvin Sinnwell
>
>
>


-- 
Luiz Augusto von Dentz
