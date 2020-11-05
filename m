Return-Path: <SRS0=JOhI=EL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E11C4741F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Nov 2020 18:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B4372078E
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Nov 2020 18:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwmW4aj0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbgKESxo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Nov 2020 13:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbgKESxo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Nov 2020 13:53:44 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7961CC0613CF
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 Nov 2020 10:53:44 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id n15so2394204otl.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Nov 2020 10:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FPEbf7S2u/2Zv6e/kNFdEUPt9P0iZfzML0Ghh790GjI=;
        b=dwmW4aj0ApmBD1r215OtfS1KIqWrBwURPjlSSbyBSmta9TZBLg0DU/qiRXgxYPCj5V
         dslLf/DfDvWeOXWPCsJuCNaVf5UQPi3kWFAd6BJcyUCAjZw8zZMkRx8/35ejxIiHDcXC
         LXbvjQUFlVuLRehIPKnrZ5ZwU3VcnqQPKLGeIl5Jruoz3yiEUR7dwUivLpvB5TwS9o/y
         /jBxFqZ4n39XmPrfOp+poM2H6QUDcIaWN3Um8diqI/yxFmzaDnFxOabZZuR8A00B4dxx
         nJlCxlInHaXC2A7oy3106VvTVBsSEJP3n1jjZXGM1lPzLTanNF5pgTV1bwqclrTlE2i5
         38Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FPEbf7S2u/2Zv6e/kNFdEUPt9P0iZfzML0Ghh790GjI=;
        b=YLiO6iAU8z0CQD457cUJUviZbbqwbrAKhwZZ50B6lV6CDLC8WGfPrI0cMC6dMNONLk
         392dctoPLA7MIiDc4+kgwTaOcU4IT0yLr2mjqLNYKNPb87QiMcENdddb6vYcL+Q4uZHf
         4yFGgWqNP6JGF2Y5xlSK8uUaTWWbmN82s3O95UL92DSsRM2Jeg2s4FyDtVmuByI60y+w
         rHzZscQJoUFscig6sD3MVXp94GAKlvFZW/JFaWZ36xkrxD0fWrxmJSnmdRGkYdt6wL/+
         RtdmGov5qsKHM1pXSp19faTGMFaF4ZodL5+8G7373EEKewe6GokmFSkFiap85XIeI7sV
         0YsQ==
X-Gm-Message-State: AOAM532S5yVyUcJj62d0okaOafhkmAX9uU/k1v81UayPZ0W2WpWMwU9s
        Bna+Nt8BEJVUlpoqkqQcpu9ECqiUQFeCi/nldqiltTGC9x0=
X-Google-Smtp-Source: ABdhPJzCdA67Qv+6SXiSGOg0UA+OpTLdwLK2VPgDabVWhqO8Kr31vHzzuGtuGjjszCcLURi5fkKyRi9GZXeDimIwOow=
X-Received: by 2002:a05:6830:400d:: with SMTP id h13mr2730543ots.371.1604602423589;
 Thu, 05 Nov 2020 10:53:43 -0800 (PST)
MIME-Version: 1.0
References: <20201105144005.Bluez.v3.1.Ibb93fb0188187d11151855d2dcc737640b2b81da@changeid>
 <5fa3a01b.1c69fb81.6a162.1904@mx.google.com>
In-Reply-To: <5fa3a01b.1c69fb81.6a162.1904@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 5 Nov 2020 10:53:32 -0800
Message-ID: <CABBYNZKoFMtnMFuiwpXwTun9d2d32XmEyKicf3p_QMRvm6h+fQ@mail.gmail.com>
Subject: Re: [Bluez,v3,1/3] service: add adapter powered check before connecting
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Archie Pusaka <apusaka@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

On Wed, Nov 4, 2020 at 10:49 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=377913
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
