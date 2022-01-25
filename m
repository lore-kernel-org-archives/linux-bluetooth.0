Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172AFC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Jan 2022 06:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347258AbiAYGaT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Jan 2022 01:30:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345732AbiAYG0n (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Jan 2022 01:26:43 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FDCC034610
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jan 2022 20:49:14 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id u6so22667716lfm.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jan 2022 20:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t5Fu4TSCbARG2mLm13zGvdTuvUr0QZW1RLiG8C79TO4=;
        b=ALObGffeoHvxkSiwET8Xu/lyNFq4JRJID+mFveG6Bc3LlZS7pd3L1dMGJe4ZNRLSpH
         /pM8asQ76V2Iz+fdIUVR5NDb4SsLSmXBjCf+LHc54fNOBxXOzFIUFB/leJNVPFy6q2jC
         LJq3AErof5GERCLLq3x6fM4W221i1NIwaZsvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t5Fu4TSCbARG2mLm13zGvdTuvUr0QZW1RLiG8C79TO4=;
        b=C/7y1jIZV4HJL24OXrskceuEsqD4xFqjNwViy5ELEn6uTfuNwm9vg9ieoF9zbTkvqe
         4Q3VZawtVrj3PoAQeCA2MPnDQ28suE6ThLPcH5eqNt8xF31SpGSe8TsnYQh7Bu0H01fw
         ido//J5zPESccFBfzNMQ03oVVjnG7+WfA+zt3ab2zr1YdtD8fw+SFkb+leljup3ebnxn
         nRA2hGV0vIAe89nCjUzsw/5ZKrRGpDmhreykRieKOToU4r0lTVEHRLIyH5roMZBTJRFz
         prNI+fAfo4wJU56C/mUpNDJV4uBQngoJea1hCYFjzS6W4p5Vhu1KY6BbYncOjnOVgXfs
         Ew1g==
X-Gm-Message-State: AOAM533pxN1UrX2RCVJsFKvkDpusnW4T8Au/EdeAnYKCnIg5W2crB74i
        1gUtArZQYHK4IU1Mt1G3J9MacDd9z8uoFrZ8N8Y0Xw==
X-Google-Smtp-Source: ABdhPJw+fQ0ckcKc3qv7ppFk2Xk6/Um2Yoc2Zv9iQG2zxzejOFnaWR7Al/D6yLftIA4t1oRd32TQpjupUhg8yfOZ3rY=
X-Received: by 2002:a05:6512:1288:: with SMTP id u8mr524232lfs.443.1643086152391;
 Mon, 24 Jan 2022 20:49:12 -0800 (PST)
MIME-Version: 1.0
References: <1639587963-22503-1-git-send-email-bgodavar@codeaurora.org>
 <164036941060.3935440.13095761506560620701.b4-ty@linaro.org> <CAD=FV=Vdjw-6GytO=Rpt==OYbnrNon3pYQnrZtUT4vX11S6ykw@mail.gmail.com>
In-Reply-To: <CAD=FV=Vdjw-6GytO=Rpt==OYbnrNon3pYQnrZtUT4vX11S6ykw@mail.gmail.com>
From:   Miao-chen Chou <mcchou@chromium.org>
Date:   Mon, 24 Jan 2022 20:49:01 -0800
Message-ID: <CABmPvSGOLRKX20WO21P_qvtvDo812QGDr4nYOWE04pjoSGDGcw@mail.gmail.com>
Subject: Re: [PATCH v4] arm64: dts: qcom: sc7280: Add bluetooth node on SC7280
 IDP boards
To:     Doug Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>, rjliao@codeaurora.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        saluvala@codeaurora.org, LKML <linux-kernel@vger.kernel.org>,
        hbandi@codeaurora.org, BlueZ <linux-bluetooth@vger.kernel.org>,
        hemantg@codeaurora.org, Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

Following up on this patch, this patch didn't seem to land anywhere,
what is the plan to land this?

Thanks,
Miao

On Thu, Jan 13, 2022 at 3:59 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Fri, Dec 24, 2021 at 10:10 AM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> >
> > On Wed, 15 Dec 2021 22:36:03 +0530, Balakrishna Godavarthi wrote:
> > > Add bluetooth SoC WCN6750 node for SC7280 IDP boards.
> > >
> > >
> >
> > Applied, thanks!
> >
> > [1/1] arm64: dts: qcom: sc7280: Add bluetooth node on SC7280 IDP boards
> >       commit: 3a89ff3087c03c2295250c07234efa75873c7b51
>
> Just to confirm, this later got dropped, right? I don't see it in the
> Qualcomm git tree, so presumably it'll land once the merge window
> closes.
>
> -Doug
