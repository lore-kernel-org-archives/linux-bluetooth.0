Return-Path: <SRS0=4cRj=6N=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2E8C83004
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Apr 2020 17:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 397DC20787
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Apr 2020 17:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/24ZhT4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgD2RSH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Apr 2020 13:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726456AbgD2RSG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Apr 2020 13:18:06 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8486DC03C1AE
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2020 10:18:05 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id e26so2388760otr.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2020 10:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yizcrPnuTUo9XzTItgK/uX3qkCGPVHanUOoZbdcXP8s=;
        b=S/24ZhT4oacpqa49Mcijpi+6z54wkfHIOY4sqM6odF8m9pw/MF9Gfm5Pwkx5h3Irhc
         JS7LRxh38ozRGuOGHHedDMhrsZqfn0DF7JHelX6gDW07x1V2fsoV3UGKvtKCa/sFtaXF
         TgBQeRfhCWEqBUTbAYHeMQO1FeiBsqS4P6op6z4ES+LwqG3iOQZOJRnurih0qX+bxtnp
         6CMEJuK8meLy5pgcq3KGABEK18bJI5e9cQic2199R9wWhOK0n4qzXrUCfVVGUf8X+whR
         pxPy6iapTrVgytdEpmcCa91V5KOAbgmSCpjm2D9Zsj/9WoNfo+S1XTxTUVtBHhd1qW2S
         jQtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yizcrPnuTUo9XzTItgK/uX3qkCGPVHanUOoZbdcXP8s=;
        b=PewkOaUqwdJKXrfp943v7bY9+mbdsmwcA0tG78sl/Pa0nmTLSl7HgxPWHvJSJDoz0J
         VWIY+CtZTdY8iWo3yK3KZXPoMnmNs1uVbMfujjmtTPX1S609ycLfMjdFyQuqmb1asYJV
         lElbZoSWsYZfkkZjnnI7GGtR8ktnscCe5lrysNCk8MQZegt34+6IpoBOGmSlLLNLPMhT
         xj3ZI/Ro6ui2JmpMCP7AXK/7iRBxFYNFUK5yth8xvogUH+aOTgDDSdJyQUTa60gIyEpe
         yxzF+NtDDqd1i6NCWlP9hqB96g3N9nOjO6k6bEF6hsTP/vIw4mNCvJtqfB2/TkbdOARN
         T/2Q==
X-Gm-Message-State: AGi0PuawIhwxZ1bo8cqOzV/G8R94IGgGbdJhXbPLdBA7/GpARyf0kVKz
        7GNG1cz6cOXdmLq7aTGOLH1zpIFJH4ouU4Rq2xg8Z6Bn
X-Google-Smtp-Source: APiQypK+pYzO29zL8EBx9VaNCbYGR01/94ASHgkcS/WdHWDkZtXBsAT2C/y7qjfCoOXWuBazu88K6+dj8LUMVQie+PI=
X-Received: by 2002:a9d:7a98:: with SMTP id l24mr28423203otn.79.1588180684786;
 Wed, 29 Apr 2020 10:18:04 -0700 (PDT)
MIME-Version: 1.0
References: <77b02337bc404dea9fa88a286c091b83@peiker-cee.de>
 <08f0a119cfa0481fbf49d7fde47a08fc@bshg.com> <cc33f16c2e164328b8248fc3967ebed5@peiker-cee.de>
 <2723effa610a46a8a9343be31bcffc71@peiker-cee.de>
In-Reply-To: <2723effa610a46a8a9343be31bcffc71@peiker-cee.de>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 29 Apr 2020 10:17:53 -0700
Message-ID: <CABBYNZ+eXJJSoQ7CGj9canfQ1eHDMzEKcY6o9GBKzAaErQs6LQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: L2CAP: Fix errors during L2CAP_CREDIT_BASED_CONNECTION_REQ
 (0x17)
To:     "CEE Forostyan, Konstantin" <Konstantin.Forostyan@peiker-cee.de>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Konstantin,

On Wed, Apr 29, 2020 at 9:52 AM CEE Forostyan, Konstantin
<Konstantin.Forostyan@peiker-cee.de> wrote:
>
> Hi All,
>
> During Bluetooth qualification tests I found out that Bluetooth stack responds with an error to a correct L2CAP_CREDIT_BASED_CONNECTION_REQ. Please review the 2 bugfixes I made in kernel in order to correct this problem.
>
> Best regards
> Konstantin
>
>
> --- a/net/bluetooth/l2cap_core.c        2020-04-28 18:19:10.481887583 +0200
> +++ b/net/bluetooth/l2cap_core.c        2020-04-28 18:21:41.000000000 +0200
> @@ -5817,7 +5817,7 @@
>         if (!enable_ecred)
>                 return -EINVAL;
>
> -       if (cmd_len < sizeof(*req) || cmd_len - sizeof(*req) % sizeof(u16)) {
> +       if (cmd_len < sizeof(*req) || (cmd_len - sizeof(*req)) % sizeof(u16)) {
>                 result = L2CAP_CR_LE_INVALID_PARAMS;
>                 goto response;
>         }
> @@ -5855,7 +5855,7 @@
>         }
>
>         result = L2CAP_CR_LE_SUCCESS;
> -       cmd_len -= sizeof(req);
> +       cmd_len -= sizeof(*req);
>         num_scid = cmd_len / sizeof(u16);
>
>         for (i = 0; i < num_scid; i++) {

Weird that I didn't run into this when creating the test for
l2cap-tester, they look correct though so please send them as proper
patches so we can apply to bluetooth-next, also please ensure
l2cap-tester is working.

-- 
Luiz Augusto von Dentz
