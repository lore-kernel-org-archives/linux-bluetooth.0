Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E015C07E96
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Jul 2021 11:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78CB461436
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Jul 2021 11:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbhGHLki (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 8 Jul 2021 07:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbhGHLki (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 8 Jul 2021 07:40:38 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3FCC061760
        for <linux-bluetooth@vger.kernel.org>; Thu,  8 Jul 2021 04:37:56 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id q190so5303973qkd.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Jul 2021 04:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N/qY52HtEnySw8oiOqnCY6Vr04Y1zPZsw52TSvRcqL0=;
        b=X3Au6Pi/gZuIKEizEtZpkpNYlgIbyi0G/awOjci961zqy8EYfCIrI09IB45E8MZzkn
         7AVSU1L4UzvADeoHy3cJPWyN+BKIqrka7aQLlq0dTLu0v8Bd4yKSpQyb3T6Vsjf1cqC9
         pbP9wWK6juYmhotjALZkdmH+dl8zKezlghv4zvCXvk0FunQYEervgRw4wCYkBksuC557
         JGt2vEAgIUA5PDhK0O0Fhmslq7U4Av3gNG21p9JwL0p0HFzVXt93DVGB8IfThBaAfAFA
         N49Jy+lJPz3i9tWnQoQk+O0Zv5Y8rD1iMixULgWhqGkhJInmouQgldcAyfIqcTqB44ID
         9UbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N/qY52HtEnySw8oiOqnCY6Vr04Y1zPZsw52TSvRcqL0=;
        b=mp3uVbHk3aGmSvfWZUrcyXnNQqnUz3h7/fupiNj9gFfFjlZPhalFg08wMg9E3LY6Id
         oy9G6ltefsYG01rsdXbdvT6zhZjZL0Kn44b7N4Au5zgGgjvZZ3vxqdSpygk3V1n2kg3X
         CD+2lDxHWgsLiUWU6lW8QNb/U/Hp90Eu9lssyGNawKyZPtGDyQhDuM2MsR/rhHxF9khG
         1Gfp27bp3eNdiGtoeqxSnqbI4OzKK56isCyVqtT3QAFuc9HRT5vuWdRVf7yLpdmNoKRV
         Okg8ltMWzFdbiD/rBZTkIsyikR+Cn25P0r8Td9i6yFVYNpk2Pal9ys7qMMAEyUzQjAaP
         TxNQ==
X-Gm-Message-State: AOAM530gK0Giyo8c/35YPl2M6dNL3nJYpQdB9Q4BJAi3Ou+7AJYhcU8D
        YP4zgeZcLTn0P8ThDAKL0bUEFq22Y3/TJYzjahaFQA==
X-Google-Smtp-Source: ABdhPJzLaw+Ocua2+xY6AepEwv2jQPUmOKbSjrNWV4ZgDNgxv4FrDkLyxft2BVw+2yuajvOMGGJpZ4Sga0z4xviKWRM=
X-Received: by 2002:a05:620a:13ec:: with SMTP id h12mr14862220qkl.217.1625744275692;
 Thu, 08 Jul 2021 04:37:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210621223141.1638189-1-dmitry.baryshkov@linaro.org>
 <20210621223141.1638189-3-dmitry.baryshkov@linaro.org> <CAPDyKFo6dmjw0TnaK7=35dq5Si_6YYpeeSa=gU++1od7WkQZ7A@mail.gmail.com>
 <20210706115517.GB4529@sirena.org.uk> <CAPDyKFr=8spZBD+bTe3SjS=nATL-ByFu_epnT2Z4chSuQNke2w@mail.gmail.com>
In-Reply-To: <CAPDyKFr=8spZBD+bTe3SjS=nATL-ByFu_epnT2Z4chSuQNke2w@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 8 Jul 2021 14:37:44 +0300
Message-ID: <CAA8EJppSV--TBjnGxGhaTHeKWdpM6uz70bg7diU3_K7OHoka4g@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] regulator: qca6390: add support for QCA639x
 powerup sequence
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Chen <peter.chen@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Thu, 8 Jul 2021 at 13:10, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> - Peter (the email was bouncing)

+ Peter's kernel.org address

>
> On Tue, 6 Jul 2021 at 13:55, Mark Brown <broonie@kernel.org> wrote:
> >
> > On Tue, Jul 06, 2021 at 09:54:03AM +0200, Ulf Hansson wrote:
> > > On Tue, 22 Jun 2021 at 00:32, Dmitry Baryshkov
> >
> > > > Qualcomm QCA6390/1 is a family of WiFi + Bluetooth SoCs, with BT part
> > > > being controlled through the UART and WiFi being present on PCIe
> > > > bus. Both blocks share common power sources. Add device driver handling
> > > > power sequencing of QCA6390/1.
> >
> > > Power sequencing of discoverable buses have been discussed several
> > > times before at LKML. The last attempt [1] I am aware of, was in 2017
> > > from Peter Chen. I don't think there is a common solution, yet.
> >
> > This feels a bit different to the power sequencing problem - it's not
> > exposing the individual inputs to the device but rather is a block that
> > manages everything but needs a bit of a kick to get things going (I'd
> > guess that with ACPI it'd be triggered via AML).  It's in the same space
> > but it's not quite the same issue I think, something that can handle
> > control of the individual resources might still struggle with this.
>
> Well, to me it looks very similar to those resouses we could manage
> with the mmc pwrseq, for SDIO. It's also typically the same kind of
> combo-chips that moved from supporting SDIO to PCIe, for improved
> performance I guess. More importantly, the same constraint to
> pre-power on the device is needed to allow it to be discovered/probed.

In our case we'd definitely use pwrseq for PCIe bus and we can also
benefit from using pwrseq for serdev and for platform busses also (for
the same story of WiFi+BT chips).

I can take a look at rewriting pwrseq code to also handle the PCIe
bus. Rewriting it to be a generic lib seems like an easy task,
plugging it into PCIe code would be more fun.

Platform and serdev... Definitely even more fun.

> Therefore, I think it would be worth having a common solution for
> this, rather than a solution per subsystem or even worse, per device.
>
> Unfortunately, it looks like Peter's email is bouncing so we can't get
> an update from him.

Let's see if the kernel.org email will get to him.

-- 
With best wishes
Dmitry
