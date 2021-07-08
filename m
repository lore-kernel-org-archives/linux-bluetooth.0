Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342CDC11F66
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Jul 2021 10:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19C04619B6
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Jul 2021 10:10:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbhGHKMo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 8 Jul 2021 06:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbhGHKMn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 8 Jul 2021 06:12:43 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745FAC061762
        for <linux-bluetooth@vger.kernel.org>; Thu,  8 Jul 2021 03:10:01 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id h5so3257611vsg.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Jul 2021 03:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8XkfH9+fTTan24v4bvoti+pLXgKwMSUgTJQx2o0Bllo=;
        b=gVmQ9nGXksd1SX9wHOHv2tLAo7F7JUgz0O1xj5BfEkwI9cnxv4Ts62oSThPZ6D6wCO
         ZgUTmFBeNQYsuF2cVN6u9NWRyNeouHi1kaXG2xoT3wrXl9C/j6PC3badxUTUigGqAw0J
         VC02TiDBaRv8k0IBH9yBV4KG9UUI/w25RN5OEZ3po6WJuAkuqyF23eLJwn9mqmWmO6np
         RFcpWgayy7jKRBATf1fAY8oh4tpxVDdEFf3o+om1R1a7WhscmFLKNykB6rKxAuCXpVr9
         hskxkSIgU2PxMaoL0dg07cHH8uymm3r2i2X7pEhreyex/UIqliMN5ob/EVG6kzz0xzNj
         e1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8XkfH9+fTTan24v4bvoti+pLXgKwMSUgTJQx2o0Bllo=;
        b=lE4uzBk9Aag62xJulCxxOYbbmD3yN7pX2o0U1+7/L/EOwvIBYU7DybTGRvGRI/aaUd
         K2WO0fRlOc0Fczqx24GkqUuTXxgpA0k8Z8usvnk1cOCA9YzK2tLgKeXFjznhjEHv4Sbl
         3x4IpVJI20BjTJcOxZG9we8Am+7IURmMJFZyO/uOxsU4IviuYGWDC6gdiQT/7FWQmOBI
         HavIpOFdr1Iqf3IAOVvHa+lWH7UOqc75xF+kZPUpLtBFZONCAT8ytIftd1yL5pYr1Jg7
         /Oj9my+7FRTbBUd9KIp/Zb9eiYmXYBcVznaBpz2H9qhgpepveBZyjoNNvi+XlGHmgjn/
         La0g==
X-Gm-Message-State: AOAM531eo+qtB3r5lbfgEptuiEFYuZB2g7LvrrJgKHUEsYHAKp4XAVvO
        /XtYbPQga5IeYs6riptm7B7S/3ynNMKui5XUGQLWWw==
X-Google-Smtp-Source: ABdhPJwHgh40ete+mWshNgBzlFotTAKewBYMMJyK7LdPKgcW1MKGOya9/zroMMERxNBQ9ffFUG/OviGrGS35sgyMGLQ=
X-Received: by 2002:a05:6102:2324:: with SMTP id b4mr3247152vsa.48.1625739000496;
 Thu, 08 Jul 2021 03:10:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210621223141.1638189-1-dmitry.baryshkov@linaro.org>
 <20210621223141.1638189-3-dmitry.baryshkov@linaro.org> <CAPDyKFo6dmjw0TnaK7=35dq5Si_6YYpeeSa=gU++1od7WkQZ7A@mail.gmail.com>
 <20210706115517.GB4529@sirena.org.uk>
In-Reply-To: <20210706115517.GB4529@sirena.org.uk>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 8 Jul 2021 12:09:24 +0200
Message-ID: <CAPDyKFr=8spZBD+bTe3SjS=nATL-ByFu_epnT2Z4chSuQNke2w@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] regulator: qca6390: add support for QCA639x
 powerup sequence
To:     Mark Brown <broonie@kernel.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
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

- Peter (the email was bouncing)

On Tue, 6 Jul 2021 at 13:55, Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Jul 06, 2021 at 09:54:03AM +0200, Ulf Hansson wrote:
> > On Tue, 22 Jun 2021 at 00:32, Dmitry Baryshkov
>
> > > Qualcomm QCA6390/1 is a family of WiFi + Bluetooth SoCs, with BT part
> > > being controlled through the UART and WiFi being present on PCIe
> > > bus. Both blocks share common power sources. Add device driver handling
> > > power sequencing of QCA6390/1.
>
> > Power sequencing of discoverable buses have been discussed several
> > times before at LKML. The last attempt [1] I am aware of, was in 2017
> > from Peter Chen. I don't think there is a common solution, yet.
>
> This feels a bit different to the power sequencing problem - it's not
> exposing the individual inputs to the device but rather is a block that
> manages everything but needs a bit of a kick to get things going (I'd
> guess that with ACPI it'd be triggered via AML).  It's in the same space
> but it's not quite the same issue I think, something that can handle
> control of the individual resources might still struggle with this.

Well, to me it looks very similar to those resouses we could manage
with the mmc pwrseq, for SDIO. It's also typically the same kind of
combo-chips that moved from supporting SDIO to PCIe, for improved
performance I guess. More importantly, the same constraint to
pre-power on the device is needed to allow it to be discovered/probed.

Therefore, I think it would be worth having a common solution for
this, rather than a solution per subsystem or even worse, per device.

Unfortunately, it looks like Peter's email is bouncing so we can't get
an update from him.

Kind regards
Uffe
