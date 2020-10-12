Return-Path: <SRS0=4Twx=DT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933D3C433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Oct 2020 17:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 453ED2087E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Oct 2020 17:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxmt3b8F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390201AbgJLR0a (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 12 Oct 2020 13:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389613AbgJLR0a (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 12 Oct 2020 13:26:30 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185F1C0613D0
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2020 10:26:29 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id x62so19443409oix.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2020 10:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jLFqGf11vkaf8jwD3TzffQueHm079mP54p7Th59yBcI=;
        b=jxmt3b8FXM5QVSXGlVy2XgRTDTux3WGX1gIjfP/888svv3xvmcBweWLYoa+f6XHHkz
         Mx94Re8xrcGTguLfKXMjqFAcHDy6spaPeYtP8Q5/HhlcKNLOVabyRiwqkGXoRCfPXprg
         f4Rn8hUiMzy2fsWlomQH02giSa4Wt/k60nHwyXgxeCzgr1l9h6L30NAhFTGMQ/CrsTfc
         vwpaPqsu6StwaZiPNK0KqT+w2bFvsuECygZ4OLHvNlmqkun/ZILLM+qnassi9tTTkW8+
         KzbYsyr9TwHilChsJgIzRKE6gUEs+VhMIHiavblHPRuS51GyUpmG5QVGb8nVrCJI4yns
         SzMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jLFqGf11vkaf8jwD3TzffQueHm079mP54p7Th59yBcI=;
        b=bKz+NDrxdrNcTwzoCBLyoCYfZc37nw9KfC9B8IKzhjzKPWJt8KDk6L8AbbBi0onH+A
         ms82raPd61iPcChJWZiU+f2pzNZeijSNzk19nnNOfmB++NWkTgPloNhIJzwAZ/4uYwoY
         QvPbdXcVt6GT7mRZEEYFN5rdx2ivbXoMytD1s5hW2aIS9Iq6bNnlsm4a7yWDUIUE4P0Q
         n55dRpjeXjuNSpMoo/XC8shh83vYx9M4Xb0rAuIzAIbuR7GVvAICxTBo3g6l7/4KavsC
         OHoHcp37Y3hYF4bxMAm4UZnh508pcaeuL+04+dIVo5NjaStrW6C+ElI0I2jTc/eHtHza
         /kfw==
X-Gm-Message-State: AOAM531rXHzzQyz0XVPUQ41buLH34MQkjCqAQ6G9bPCCMqoylIjDylYQ
        8a3H/T05EeiJIATbvv6YmUSVxpOQWfZSznOWw4Yanu1/4w8=
X-Google-Smtp-Source: ABdhPJzpNavElLv5pTLLaUDdD2p5SiOnOBqYL85E5hhs8FSY9kCjnltt+l+RKFG+SjVu5xe18s9yz4D6V84FOAPHQuM=
X-Received: by 2002:aca:4c7:: with SMTP id 190mr11716927oie.58.1602523587872;
 Mon, 12 Oct 2020 10:26:27 -0700 (PDT)
MIME-Version: 1.0
References: <20201010222719.439956-1-daniel@simko.xyz> <5f8244ae.1c69fb81.ce543.bf05@mx.google.com>
In-Reply-To: <5f8244ae.1c69fb81.ce543.bf05@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 12 Oct 2020 10:26:14 -0700
Message-ID: <CABBYNZK_vjNDO-KbKy0JpbpXqZbBLX_stituMFArWCt-an2GAw@mail.gmail.com>
Subject: Re: [BlueZ] profiles: Fix segfault when using headset controls
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     daniel@simko.xyz
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Daniel,

On Sun, Oct 11, 2020 at 12:32 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=362639
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

Applied, thanks. Note that I did some small cosmetic changes and also
add a call to notify_addressed_player_changed since we are changing
the addressed player in the process.

-- 
Luiz Augusto von Dentz
