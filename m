Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A91C47083
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Jun 2021 08:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A098613AD
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Jun 2021 08:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbhFDI61 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Jun 2021 04:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbhFDI6Y (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Jun 2021 04:58:24 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7E6C061761
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Jun 2021 01:56:38 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id i9so12914321lfe.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Jun 2021 01:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L/jcUN5Pr1n6HTlXvEq++SAZmvv+rGmd9f5h/IEw88E=;
        b=tCOn0KeYbBXVsEvHdiNoxR3vT/eDT1koFBDlRNjoFv2QoycJwCTN7+WRx2EULW/4R1
         NTgbY3pRxS/EUriSBGmbX4FfLi/zryMPFH6+32FQVKCnKbP2Vy1T12B1Zsa9kHQakT4N
         p5Mgqp10AmtrJdhEQLxeDCAN8Qzq85GlM7JIzYwbtBhe6QsJR9KlnZzgfP6oxPLLIqNY
         It8XLEqaHg/j9DHFOXhGvPes4BrdedLdr5fyfP+VnBsFFFgb0wOvW9gcdk3ObqeFWI9P
         LxTqNsLtd5rCWkw5O8mXbn2n8OrIVZDRrTmsG9VYr8OUgGFeKj0e7xdiSGz81e54lSaw
         4Uow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L/jcUN5Pr1n6HTlXvEq++SAZmvv+rGmd9f5h/IEw88E=;
        b=VsH/B5ziySx3TAVAzA8Z0xv8I7wPI9P98FqLI53L+KxJZyWhlVhNZrY1MmWGuP85OB
         2MrE+CJTHmpSCjyvpz113CA/EhYTrWYbHLXynlV4qCbH3HOC3QZizfr9Asw/u5cBiOpp
         h/ESdxK9eY4EcC3rf6BS4xO4FEaOqasgBqpCqz/b5SiyoicUR1EZ10e5RCIgsld/tOEx
         nejFFFHXhMcFbWEDZFUYznvR+MfWORxxmQrqLT2lfSkwYMq3WDzVs7PsgTQ1PVU7WpJY
         m0GP1JBsjvlHJ+dKmTIgTOfR5syIhaK6/2A8/qoiiXqqSVFhE0wEP9hOTyhTWrgc0PdQ
         riHw==
X-Gm-Message-State: AOAM532rayGeFzAX4E4MwIDTZITDWfr8eCMFNYFL9oKRaKgOu4LwiSrr
        jyFFhbpK05OzZW9fVY/w8TRqMj6ZR1nqmcjmOACk+g==
X-Google-Smtp-Source: ABdhPJxbd+oPaahs3Qal3C/S0gS8W9AkP69zut0KB0EoETyRMpK52iyGNSe6iE0v6qs6gj5V2LOgl5SfvJgA3+rMPEk=
X-Received: by 2002:a19:4cd7:: with SMTP id z206mr2063492lfa.414.1622796996237;
 Fri, 04 Jun 2021 01:56:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210604162616.v3.1.I444f42473f263fed77f2586eb4b01d6752df0de4@changeid>
 <fc36d07a8f148a45c61225fefdd440313ee723d0.camel@hadess.net>
In-Reply-To: <fc36d07a8f148a45c61225fefdd440313ee723d0.camel@hadess.net>
From:   Archie Pusaka <apusaka@google.com>
Date:   Fri, 4 Jun 2021 16:56:08 +0800
Message-ID: <CAJQfnxHtgsCTS5GCTj-p4iqaR=jZVPho1ELgFQ6-UngZcBECig@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] Bluetooth: use inclusive language in HCI role comments
To:     Bastien Nocera <hadess@hadess.net>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Bastien,

Thanks! That was a great input.
I'm not sure though, do we have a standard, proper way to deprecate macros?
Or does a simple /* deprecated */ comment works for now?

Cheers,
Archie


On Fri, 4 Jun 2021 at 16:39, Bastien Nocera <hadess@hadess.net> wrote:
>
> On Fri, 2021-06-04 at 16:26 +0800, Archie Pusaka wrote:
> >
> > The #define preprocessor terms are unchanged for now to not disturb
> > dependent APIs.
>
> Could we add new defines, and deprecate the old ones? Something akin
> to that would help migrate the constants, over time:
> https://gitlab.gnome.org/GNOME/glib/blob/master/glib/gmacros.h#L686-716
>
