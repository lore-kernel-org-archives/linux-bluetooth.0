Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CDBC433DB
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Mar 2021 16:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 573B464F56
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Mar 2021 16:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbhCDQiM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Mar 2021 11:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233441AbhCDQh4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Mar 2021 11:37:56 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92F8C061574
        for <linux-bluetooth@vger.kernel.org>; Thu,  4 Mar 2021 08:37:15 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id x20so30705313oie.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Mar 2021 08:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1uHz5XKgS6TR6nDhY0p23kxO+LwBs3ylIK5/4l1bSH4=;
        b=EHE7W9+jIlYXOyOs6vq94YNOus/hoVDG2hoioA1UXBgpSC5z0+xwCSH88gpuRpIWiA
         Jvinc4cYdFLZB93WzL6J7bHICJeeTVatwkiv6OS3KjfJLCCO8AEdmZewI5t9qqWLw1yh
         Gr6iIKjt7bzMMO4hRztNmNpZDZQFeqUyRPnZhf1VEq/JgahGqMymY2LN+2pv3pWvAkR4
         rxASS/1rVHOKyIYsCFsgVUxt535OOx2cFVzY4FeEFXQehge+tTSVgKNtOT3qsQNC1MA8
         1Tu/199OfFL0bTUmIL5keUm3xi81wv5h4vK6t+mxQUEWw46lUznMXGUAaEwrNBHamI6D
         puBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1uHz5XKgS6TR6nDhY0p23kxO+LwBs3ylIK5/4l1bSH4=;
        b=D6UskSImordFQa4+4kROAy2oxzslulI0j232NgbofcJjhXiUPHHQAegz2VDe9/awec
         acwwaskajIMJJy/VaNOjxWRwgJZQ0SAYy3kKyEBTZwi5kTju+fhIFVF5zkv5keQhtg7g
         UYQJYyCqGq99eMCiK9s7fn2oMtyyEb93Hw+vPS+HIgGPSDwIfc1tjA6DXDILcOjMAmKh
         6dCKzJC3AuRLsfMWiE+AfilqDVsw3a6eMiSpMNl1MmHLEY9LuY+PCAm5g2r4yShwmCsk
         2Gkoqehp6rml6WWRF3z02dSfhQtjuKJgRFkpIyOQ8pfm8S0bOLkTE7oaizcB61TMZJIs
         QIUw==
X-Gm-Message-State: AOAM5331XpDMpOZBvXallwtXbHxXtracfz23kinNzSyDJviHhmTf5XaA
        YeTYrVckOo9I+Rn/890bGc8TtDjmuhpXzDspO6/JEk5zPCg=
X-Google-Smtp-Source: ABdhPJzp15ZkQZxBmGoS0aLdrEVSt+UxYYysiGB/fhJZjcIZZsbRSpR4JdY+epwnoJl4/GXFr8foLvWciz3ClXiCrtc=
X-Received: by 2002:a54:468f:: with SMTP id k15mr3562875oic.58.1614875835244;
 Thu, 04 Mar 2021 08:37:15 -0800 (PST)
MIME-Version: 1.0
References: <20210303081942.GH7348@in.waw.pl>
In-Reply-To: <20210303081942.GH7348@in.waw.pl>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 4 Mar 2021 08:37:04 -0800
Message-ID: <CABBYNZLYiGwYCQcihs9x-AJ33jS5dmUoY45GM4sk0PbmQW-iLg@mail.gmail.com>
Subject: Re: patch to fix conflict with unistd.h
To:     =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Zbigniew,

On Thu, Mar 4, 2021 at 1:02 AM Zbigniew J=C4=99drzejewski-Szmek
<zbyszek@in.waw.pl> wrote:
>

Can you send it as a proper patch, look at HACKING if you don't know
how to send it using e.g. git send-patch.

--=20
Luiz Augusto von Dentz
