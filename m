Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7A5C61DA4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Feb 2023 21:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjBWVAi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Feb 2023 16:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBWVAh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Feb 2023 16:00:37 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08055DCE8
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Feb 2023 13:00:21 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id i34so21759817eda.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Feb 2023 13:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZEJmwoeHBaDnkt9DK/t5JUB9F2Etnru1h6EpHkG56A=;
        b=HGpDWnWLnB/qiTUHcKqAO9w3xAo13SA3wqWPUDHHuEucYhUUIS8s2SDKsqshogc7Hp
         wuEE2qAJixZvh43IbODDFjgg7LwvKXhbWkKX4caFVBj/M7jGNDRtDBwGWMFVDOa+d1B6
         pbn7eVFGCjSSWCCQmpJPS4c2q5VI/5kpRA3K1R6DSHPte7UHMl+Xy9FRYeTGc1kWklkf
         JuLMy82G4J3Av2zwxWg/4UOlqKo75KHtr+NTDcz+SBybrA04atzLAHPJJhX5zj9OZeXf
         37Iyd0cT4HknBzbAOl3QT9s77Z7UANBJ0z/BUU8bxQa3khauS4ce3fyWFJUA5JiipR3l
         Zgww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IZEJmwoeHBaDnkt9DK/t5JUB9F2Etnru1h6EpHkG56A=;
        b=KfyIjbp5g7GwukymH/ikFxONFn5ITkOJEtFPSJrryiFz6Hns3SSlXFcel4SYlChkC8
         YqqN7IDjaggM2cOcPILhUgdRwfZzk8AZelwUfL3/HJqxMpnioIkYhZcG6NtesfZTJP37
         xWojnIvlyahGMm3qBzVlsxcIMYk6u+NRb3lXH4dAxHN8Dy/c8gkXuEEgG6MxBTUq6B3I
         DA8zpoXgXcQf7ECMGYvPhKHeZfAi/zh0Ukuh6XjGIxaul++0Noub0aQYYyixBKXV98xg
         ulk8Th+psHjn8i5Nafa2jZ5qDWYY9+3KkkBHHyL6rHKRZmluhKTFzIfWgBbgaflGqanF
         LHOQ==
X-Gm-Message-State: AO0yUKVsgnhNPCyXxyyMiF+izN1mzop2rjtioIZ1EOvInwjRnv+4aoLh
        rw14KVObl/wvij0fOsoMbrt/hOu16tf6UiBYL+4=
X-Google-Smtp-Source: AK7set/rbJjZ7n4/Qs7cZ044K+isfW1N6nJu2HVaa/sP6x4zWmdWYmhM5CLNVK875PIFr68NfyAfnT4wlf87AuY1zVc=
X-Received: by 2002:a17:906:8295:b0:8b1:3357:b16b with SMTP id
 h21-20020a170906829500b008b13357b16bmr9765097ejx.4.1677186019991; Thu, 23 Feb
 2023 13:00:19 -0800 (PST)
MIME-Version: 1.0
References: <3B9D4DB2-D2CD-44FE-817A-F6EA8A0AD734@gmail.com>
 <CAFBinCBWyiObgbyuT2Xc=FnoTTTUBu3sePpybdrocVZr7SVDWw@mail.gmail.com>
 <7df7bdcad3474791ae69f73f8a761173@realtek.com> <9E1F8017-3F54-416D-9BD3-DF2F1C625094@gmail.com>
 <e4404fcb-69f6-b4c0-7683-69101bbeaa96@lexina.in>
In-Reply-To: <e4404fcb-69f6-b4c0-7683-69101bbeaa96@lexina.in>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 23 Feb 2023 22:00:08 +0100
Message-ID: <CAFBinCDFDv3RJQnydU8_ryFwzT2bevQsciGTsvotjsft4fVmXg@mail.gmail.com>
Subject: Re: Bug/Problem with rtl_bt/rtl8822cs_config.bin
To:     Vyacheslav <adeep@lexina.in>
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Max Chou <max.chou@realtek.com>,
        Hilda Wu <hildawu@realtek.com>,
        Josh Boyer <jwboyer@kernel.org>,
        Linux Firmware <linux-firmware@kernel.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello Vyacheslav,

On Thu, Feb 23, 2023 at 3:14 PM Vyacheslav <adeep@lexina.in> wrote:
[...]
> > The bug report stimulated Martin=E2=80=99s maintainer memory over unfin=
ished improvements
> > to the Amlogic UART used in the g12a and newer SoC families (we are tes=
ting with
> > g12b and sm1 devices) resulting in this series being submitted last nig=
ht:
> >
> > https://patchwork.kernel.org/project/linux-amlogic/list/?series=3D72417=
2
>
> However, this does not fix the problem with rtl8822cs BT on gxl/axg chips=
ets
My understanding is that Meson GXBB and newer can also use XTAL along
with the UART controller's internal divider - without any additional
pre-divider like "XTAL divided by 2" or "XTAL divided by 3".
Using XTAL directly (24MHz) also makes it possible to achieve 1500000
baud without any jitter.

The problem with the Meson UART driver however is that using XTAL
directly is not implemented.
Yu Tu from Amlogic worked on patches last year. v6 of his series made
it into -next briefly, but got reverted due to issues. v7 then
stalled: [0] and only the bare minimum (enabling "XTAL divided by 2")
for the S4 SoC made it upstream in the end.

My suggestion is:
- let's get my small patchset upstreamed which at least fixes the
1500000 baud rate on G12A (and newer) SoCs
- then work on resurrecting Yu Tu's patchset and implement "XTAL
without any pre-dividers" support on top of that. Common Clock
Framework will then choose the correct parent depending on the SoC
generation, hopefully allowing arbitrary baud rates in the end - with
no jitter/as little jitter as possible.

What do you think?


Best regards,
Martin


[0] https://lore.kernel.org/all/20220225073922.3947-1-yu.tu@amlogic.com/
