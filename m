Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F00C433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Jan 2022 23:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238332AbiAMX7W (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Jan 2022 18:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238329AbiAMX7V (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Jan 2022 18:59:21 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B403C061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jan 2022 15:59:21 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id v6so10549503iom.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jan 2022 15:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=swIc/YWTqbGW2vcyyUIZkfdZFHgU9akpO8dYNy7F6xA=;
        b=EjkzCDcgo7ZyV4PO+uVAMn4JDhGaueEGmMc0OYkIWH9ILkxltTpF196jvdmKTwXb23
         zPjjQSH4wOpZI+g7y9bFKClM7qYSMvCWUjTpWBvOQC1nL1yR3g/W4TE6JfpBNqjHilgH
         /X/v4HdHgMmjH310RdfzAadJNFuKbntDv2xP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=swIc/YWTqbGW2vcyyUIZkfdZFHgU9akpO8dYNy7F6xA=;
        b=iVxPfgEgkVFMdyPqzf2QYIaWLwMpzHtGCR+RL8nIKrXBcw3G6RDXCQqp9siziv2FZb
         f9QcXMh2Ju/+f9b0BvHysXaRzkrGvABWEBXXYvqCdmnus7ek5KIeQawWKqHVp/Ez3oYo
         BseptfPhBDnTJn87PpSk7F+Xkr7nu5LaSNrTz+NGXhCVmiXz0natDtk88Xav80EGBgOj
         ehX9ho5iXL0w7ug9QHo0Uhp19Q/2xbRUbY7QVnp4R2lGcZvW9xjzUyXlzkUjYUIDQz+y
         1u58FSXHu3jZdLUhPJKHJjBNWEKoKJjymoJc8ASnvW0rREGHqQ7bRuyv4PxHjvOMCeEy
         yBHA==
X-Gm-Message-State: AOAM531RgEPBnDx2KgErKW8/97ZyUdOQ/2HzMWRJd4pAnJL8dPA1ZigY
        6zKSOz+9SDDwG+NzZRHZ1E4WlYF+gglKeA==
X-Google-Smtp-Source: ABdhPJxk46gU438gm5dulri8TJYMYsX6ji8krWJvAJfqc4OHKx6fCbFT0foOSjSaa6zU33i+IfOAJQ==
X-Received: by 2002:a05:6638:2204:: with SMTP id l4mr2716134jas.142.1642118360327;
        Thu, 13 Jan 2022 15:59:20 -0800 (PST)
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com. [209.85.166.172])
        by smtp.gmail.com with ESMTPSA id j3sm3662023ilu.64.2022.01.13.15.59.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jan 2022 15:59:18 -0800 (PST)
Received: by mail-il1-f172.google.com with SMTP id a2so1196414ilr.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jan 2022 15:59:17 -0800 (PST)
X-Received: by 2002:a92:c202:: with SMTP id j2mr3338009ilo.165.1642118357532;
 Thu, 13 Jan 2022 15:59:17 -0800 (PST)
MIME-Version: 1.0
References: <1639587963-22503-1-git-send-email-bgodavar@codeaurora.org> <164036941060.3935440.13095761506560620701.b4-ty@linaro.org>
In-Reply-To: <164036941060.3935440.13095761506560620701.b4-ty@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 13 Jan 2022 15:59:05 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Vdjw-6GytO=Rpt==OYbnrNon3pYQnrZtUT4vX11S6ykw@mail.gmail.com>
Message-ID: <CAD=FV=Vdjw-6GytO=Rpt==OYbnrNon3pYQnrZtUT4vX11S6ykw@mail.gmail.com>
Subject: Re: [PATCH v4] arm64: dts: qcom: sc7280: Add bluetooth node on SC7280
 IDP boards
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>, rjliao@codeaurora.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        saluvala@codeaurora.org, LKML <linux-kernel@vger.kernel.org>,
        hbandi@codeaurora.org, BlueZ <linux-bluetooth@vger.kernel.org>,
        mcchou@chromium.org, hemantg@codeaurora.org,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Fri, Dec 24, 2021 at 10:10 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Wed, 15 Dec 2021 22:36:03 +0530, Balakrishna Godavarthi wrote:
> > Add bluetooth SoC WCN6750 node for SC7280 IDP boards.
> >
> >
>
> Applied, thanks!
>
> [1/1] arm64: dts: qcom: sc7280: Add bluetooth node on SC7280 IDP boards
>       commit: 3a89ff3087c03c2295250c07234efa75873c7b51

Just to confirm, this later got dropped, right? I don't see it in the
Qualcomm git tree, so presumably it'll land once the merge window
closes.

-Doug
