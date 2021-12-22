Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF37C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Dec 2021 16:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237358AbhLVQNy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Dec 2021 11:13:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237382AbhLVQNx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Dec 2021 11:13:53 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5753C061401
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Dec 2021 08:13:53 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id v16so2716756pjn.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Dec 2021 08:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BFGk+wXY2WG7afvEROgA8Vzr9P5EaP9/8caVFzhLkSA=;
        b=KPIAxvXG/nK7mtoxHKJtmhxYY1JxI8FZfbXBE5JDarjZjntn99MFPIUMIePJ5fM9l4
         BIvHhJc+zR1Gmecdm/xoWo2Cj3K5rtCy53e3LQwCw9OGrjfhem3rW0ulCgdb2lPXIk4m
         57l2A92N59ge18B950cG7ZpU7IGcQZvBoVlQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BFGk+wXY2WG7afvEROgA8Vzr9P5EaP9/8caVFzhLkSA=;
        b=Cv/AUy0fE4Ex9ZxrbH3VOoK9D0kvWJXl8KxRslQsflF/3FJKqunYNStE8KqGJZbYW6
         JJjLexMS+3Pnv3DSEboPJ/gB0tzhNNF6ZVwzz698dbi3ep1J4pzSr2QLUYQ/wrglNKSA
         0ahddgWC3r3D8DTu8DpE3oVScORX/jMhsrrUm9Leq7e6e9sEwhvOaigjDijuyPpHM7WP
         UxFE32P6g87F9A+FIBrrd9HdOwmd1Hi0nQfaJl4ndJyW6a0nlBwUetybVEm+u8A9f9V3
         gb4jmPDXuk8XIOxD8TwGB6CeXzLUc8PBtdm3s5As0tiPIWZgkcGOFqn9+ksrsCMVLz2o
         sPsw==
X-Gm-Message-State: AOAM530W1lRVZFvVWFyqFUCVGqOFssvAGQosSmMb9YPuwTidXYz5SVUi
        e3YC3ZYIayPFiX+z1YR7cDl/pA==
X-Google-Smtp-Source: ABdhPJzJthtDcM8o6fnNwW70a8dUfaT9zNNY93DBwhkMDoA9DeR6kxYIymeQ/Nwv6x/WCNqCtRB2CQ==
X-Received: by 2002:a17:902:aa8a:b0:148:a2e7:fb62 with SMTP id d10-20020a170902aa8a00b00148a2e7fb62mr3371252plr.163.1640189633147;
        Wed, 22 Dec 2021 08:13:53 -0800 (PST)
Received: from localhost ([2620:15c:202:201:474e:891f:9d18:9114])
        by smtp.gmail.com with UTF8SMTPSA id f124sm2529843pgc.32.2021.12.22.08.13.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Dec 2021 08:13:52 -0800 (PST)
Date:   Wed, 22 Dec 2021 08:13:50 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Hemantg <hemantg@codeaurora.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Rocky Liao <rjliao@codeaurora.org>, hbandi@codeaurora.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        mcchou@chromium.org, saluvala@codeaurora.org
Subject: Re: [PATCH v4] arm64: dts: qcom: sc7280: Add bluetooth node on
 SC7280 IDP boards
Message-ID: <YcNOvlVQaT80qPsx@google.com>
References: <1639587963-22503-1-git-send-email-bgodavar@codeaurora.org>
 <580E8974-EB7F-4493-BECC-4B09765A954D@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <580E8974-EB7F-4493-BECC-4B09765A954D@holtmann.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, Dec 22, 2021 at 08:54:56AM +0100, Marcel Holtmann wrote:
> Hi Balakrishna,
> 
> > Add bluetooth SoC WCN6750 node for SC7280 IDP boards.
> > 
> > Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> > ---
> > v4:
> >  * updated commit subject
> >  * Removed drive strength for bt_en
> >  * updated swctrl_gpio name to sw_ctrl
> > 
> > v3:
> >  * Addressed reviewers comments
> >  * Added pin config for sw_ctrl line.
> > v2:
> >  * merged two patches into one
> >  * Removed unused comments
> >  * Removed pinmux & pin conf.
> >  * Addressed reviewers comments
> > 
> > v1: initial patch
> > ---
> > arch/arm64/boot/dts/qcom/sc7280-idp.dts  |  4 ++++
> > arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 36 ++++++++++++++++++++++++++++++++
> > arch/arm64/boot/dts/qcom/sc7280-idp2.dts |  4 ++++
> > 3 files changed, 44 insertions(+)
> 
> patch has been applied to bluetooth-next tree.

Thanks!

I would have expected though that a device tree change goes through
the qcom tree. Maybe Bjorn should pick it too to avoid possible
conflicts?
