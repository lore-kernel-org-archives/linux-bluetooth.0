Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F72DC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Dec 2021 18:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353408AbhLXSKi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Dec 2021 13:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbhLXSKi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Dec 2021 13:10:38 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3C0C061401
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Dec 2021 10:10:37 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id r10-20020a056830080a00b0055c8fd2cebdso11829794ots.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Dec 2021 10:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fLFVp95LvwfjyR+KbQEFvb9sj3HyMK7EBdO7Z8mOWJ4=;
        b=moFRveX0iHUjFFgrslSifCTpmVDUF7jars4wCTBHstuwpYkAr2DkS7C1UnNUb2z89V
         Omd7PJg8D45AXjX7nfOFUAkoKBKrKbZfgb22EtEyRi4oN0KP3vwc27e78DXvIKBy+EqI
         h3AVRZX/+HHL1H5nARZ037d4mDc7Dk9ZrBqIP95eAA5U4TeAy2HizIrNnEji3ozvQwLf
         e36hUeQvS2rRwLqx/UF0OrgIj4hMpQXuJcMjjwTqfY6WCrprP1erJmzjCgvyUN47pIW/
         MaQ+Dp7ElNJUAowXwDHTqEcnK7gRWzFAe5I3blrbNEuaJrX7+oeKZ8w/FiOQQGsi2JOR
         70/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fLFVp95LvwfjyR+KbQEFvb9sj3HyMK7EBdO7Z8mOWJ4=;
        b=Mix6VUyJwZcFlafJvnBbu4BXX2ifCSOEVQNPcj7+XpUHJ/lyl7NDVYcMB0ItrMlFCB
         bT2A/SqDxbT695Y5k88+YXV3gqfVxRHUxfTbh8YioeP+l9AUqq6ZnoMrEZLb+btYvAxW
         +w0Od4Ls8qBSX0urGYMjtpp81/omCKBC9cLtN5GX8RLuvGiD3FmwCKqbStf/d4xTlwca
         D4e4/jfLqvBTW4mz12co6ztQtbdrLtLL/U7pz7aRv2ySfdKZxTsdzIPE01vytPsipYPC
         DSlOZefhhF97uI6tCXxn1pTGTUyiI5xxQ6s2VCud8gZQZ4jdbz4xJ4I3mTNYd5GkPUVn
         rLnA==
X-Gm-Message-State: AOAM531XnWn+rHvXWlSEYJsjm1vqQF2m8vrNpg7NH1Dq4rR8G6+CHFHl
        UpmajyywfxSu+ARfPy3nOp9UAA==
X-Google-Smtp-Source: ABdhPJwt8ZpC0gO3Hj/CsSjentOytlb/CCiNa8BQo4TVDmOwQ+Of3Ht85zvz/BJgtCE/KscYd3VVmw==
X-Received: by 2002:a05:6830:314b:: with SMTP id c11mr5294889ots.178.1640369437101;
        Fri, 24 Dec 2021 10:10:37 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id o19sm1785949oiw.22.2021.12.24.10.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Dec 2021 10:10:36 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        johan.hedberg@gmail.com, marcel@holtmann.org
Cc:     rjliao@codeaurora.org, linux-arm-msm@vger.kernel.org,
        abhishekpandit@chromium.org, saluvala@codeaurora.org,
        linux-kernel@vger.kernel.org, hbandi@codeaurora.org,
        linux-bluetooth@vger.kernel.org, mcchou@chromium.org,
        hemantg@codeaurora.org, mka@chromium.org
Subject: Re: [PATCH v4] arm64: dts: qcom: sc7280: Add bluetooth node on SC7280 IDP boards
Date:   Fri, 24 Dec 2021 12:10:31 -0600
Message-Id: <164036941060.3935440.13095761506560620701.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <1639587963-22503-1-git-send-email-bgodavar@codeaurora.org>
References: <1639587963-22503-1-git-send-email-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, 15 Dec 2021 22:36:03 +0530, Balakrishna Godavarthi wrote:
> Add bluetooth SoC WCN6750 node for SC7280 IDP boards.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sc7280: Add bluetooth node on SC7280 IDP boards
      commit: 3a89ff3087c03c2295250c07234efa75873c7b51

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
