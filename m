Return-Path: <SRS0=BM5K=DF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2865DC4727F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Sep 2020 23:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E98F92075F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Sep 2020 23:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="stw8dYFM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbgI1XVk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Sep 2020 19:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgI1XVk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Sep 2020 19:21:40 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC2DC0613D3
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2020 16:21:40 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id b12so786116oop.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2020 16:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P9Tur5SWGWaRfVU82rJKG7Il5mr9qSVjS0s3N0jBcN4=;
        b=stw8dYFMu7tFOasCjw8A6sp2p2IbnpMt7MNFN0WT468iCt1U9OikgNFNpz0qauo+Xy
         ayLoV1VqmSVmZ4o3vErje4KMbz4UgpXYfUr2jmabLUX9J8GXrGLIkV26KhaiTe37VMnT
         PH5visu64U5cX6w0wzajGdC94F498bNjtzC4XdqSON7d3vwwBPTuy3kNXBx3oz0CqnPp
         jGxEObmXeunvbE77vS1tnu8eKkPiLyFpu1c48ZRhQL7DA2b+D/z0aq0hnHGyiYD/0Uvd
         yBpGjGvupGCm6LoIMI7fQcjZHIkuY53F22QKaLUv7JYYPiFC2jTEXcILwp3EUA+Q6KuK
         8skA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P9Tur5SWGWaRfVU82rJKG7Il5mr9qSVjS0s3N0jBcN4=;
        b=HaEsq88l5+Qw+iWOK8oVAxAtM2j6s0ZwCd2J9JrG5Iod1ZpAP7up9lutJboGHMojHc
         9twh8vYEwOIJsVEAe2Ihf9GO6Jg2IixW2WGpXR66BMgCCbH39QP3lGHmHGsSt7dOSc9b
         sC3JvZQyGwVgK4TIklF8+vPP/dSoHnQOUr36UwNSrNPHC3r2Ih4Bc+dV5uy2/Pny2HBV
         o6Bng3RWmtTL3gBk+0+eJXJ64pv2rNXNoMi7Lc+3wzNoJOkFCq4RkLFYbTxApa/nJPQd
         +2onQwsxFLpLb4Mbg2uOn4YhNnxfyulZyQxzKxbdmd7hzk3x3KOYIEwBS5Nqfs2mzG/F
         8jAg==
X-Gm-Message-State: AOAM530IH3VqZnIfjBKySPYAM/CrkcnHU5f6WcthvmyU3e+kEKCkXGIO
        SJ7keNlz6o25qRgpXd8K/vyD4oPeKipvZYbaIr6kIkYM
X-Google-Smtp-Source: ABdhPJw6XYagLb+CwYrQZIuIDXvAp22iXxZZXplxfVpVNSxZEtz/FlHAUrwCNsburVXp9ovndnV2U6xTG7a5mk/zti8=
X-Received: by 2002:a4a:96a3:: with SMTP id s32mr2530184ooi.17.1601335298956;
 Mon, 28 Sep 2020 16:21:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200924161949.Bluez.v2.1.Iedecbb8c8ebb111b14206dddc5bea3c40dfa1771@changeid>
 <5f6e4534.1c69fb81.cb235.0bb6@mx.google.com>
In-Reply-To: <5f6e4534.1c69fb81.cb235.0bb6@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 28 Sep 2020 16:21:26 -0700
Message-ID: <CABBYNZKYct+XCFAiSF9f8-xHheQK8t-2U3kg04nW1RKptmXLoQ@mail.gmail.com>
Subject: Re: [Bluez,v2] device: Disable auto connect for temporary devices
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Yu Liu <yudiliu@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Yu Liu,

On Fri, Sep 25, 2020 at 1:51 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=355131
>
> ---Test result---
>
> ##############################
> Test: CheckPatch - PASS
>
> ##############################
> Test: CheckGitLint - PASS
>
> ##############################
> Test: CheckBuild - PASS
>
> ##############################
> Test: MakeCheck - PASS
>
>
>
> ---
> Regards,
> Linux Bluetooth

Applied, thanks.

-- 
Luiz Augusto von Dentz
