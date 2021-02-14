Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_40,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097E2C433E0
	for <linux-bluetooth@archiver.kernel.org>; Sun, 14 Feb 2021 14:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFE7B64DFF
	for <linux-bluetooth@archiver.kernel.org>; Sun, 14 Feb 2021 14:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbhBNOlu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 14 Feb 2021 09:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbhBNOlt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 14 Feb 2021 09:41:49 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88234C061574
        for <linux-bluetooth@vger.kernel.org>; Sun, 14 Feb 2021 06:41:08 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id v15so5521782wrx.4
        for <linux-bluetooth@vger.kernel.org>; Sun, 14 Feb 2021 06:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Vu6bXjuBKG58Q2BMQhYXw8SUU4lQq64u1960wGkEEQU=;
        b=Mqw/eVfKtnZcjVTF5rSjZOkJP78qgb2i0qP3WF05L3qRyvPoLD05YD6YysLBlNc0L+
         wPtvBiwT+jX87V6EUFKGCKoD9GfxQbedWgh56sR/JIMIProDDsKA2Ar4JN3I0GlAmQNQ
         VrOLhBBWRJ8+DBA13J0xdPQ2i3Evt7V9DvlMpG91wctJ7/x5kEM1lVIzAB/99en15hIf
         YvwbRqraZPwrREQLgzU6uE7RIMmL/YjfX4JnUeV9fk+oMjV5OTvrll+AdkHObZSt3X92
         EM53YXj3j+ZjLzg1DuLUcMdIFN+/ZH4xD5+SvWVmg/Ho76T5hhDd35wtLHIAoRUF7ypG
         Jpzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Vu6bXjuBKG58Q2BMQhYXw8SUU4lQq64u1960wGkEEQU=;
        b=QgJBOfLpAe5v+A+Rbtt9GHG15SvPxzSI1lq93+11u4nf4UFC1eKFiPN9Cumyz4OuFu
         1WwIWIZbyFv0NslilvrUlEjYRppLt0bEYWFXAU4PqyJfNKcQPEm+TqnGyKxkFlu9ZmSI
         DdCeGkE5UFvQuRTk1M7Z7bQXFu4+I6WG2/N92wKlCA5E2WpyabPzilWLajh69KX1MSva
         vcNZWKqYgvQWp8Y2cteeCxvvH7iS/tfecy+QAumzDimJCY4CAsjwoJiN6VT6yIJJIu+e
         oir8EQhtTrwBXX51lnlFx0WDGGb61CadQFYzQ1aJLt94R3EyHekmn+zGLuUFL7too+sk
         4l/w==
X-Gm-Message-State: AOAM533lhSLR3syL2QkDm1ge1taF89WU5xOrVePFyu7qxyO616JI0rz+
        zc/vC6xsweBeqC8LpIX6R6T+ABJzMhZOdT4ocAaEatTE1a022w==
X-Google-Smtp-Source: ABdhPJzaqHfAuLqAq81km8kKtT5uVmidyu/C5/RzKcFFKB4SUJ+1UftmR6brXE2ceIgQlefQh5jiZ2QNfgNhmGY17yA=
X-Received: by 2002:a05:6000:1841:: with SMTP id c1mr13830579wri.278.1613313666972;
 Sun, 14 Feb 2021 06:41:06 -0800 (PST)
MIME-Version: 1.0
References: <CAP_L5iNwPcP=-uiSazAczT9c76hMe0Wn1JsnPFVD32_RmiVkLw@mail.gmail.com>
In-Reply-To: <CAP_L5iNwPcP=-uiSazAczT9c76hMe0Wn1JsnPFVD32_RmiVkLw@mail.gmail.com>
From:   Mihai Emilian <be.mihai22@gmail.com>
Date:   Sun, 14 Feb 2021 15:40:56 +0100
Message-ID: <CAP_L5iMCmQ3F5h3QCQ--Nj=0yfvCRriroi69=_iRt6x0NgJsmg@mail.gmail.com>
Subject: Re: Place to ask a bluez api question
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

I was wondering if this was the right place to ask a question about bluez api.

I never used the mailing list platform.

Regards,
Mihai
