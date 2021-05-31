Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE9EC47082
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 May 2021 08:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1A3361248
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 May 2021 08:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbhEaIqS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 May 2021 04:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhEaIqR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 May 2021 04:46:17 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12A5C06174A
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 May 2021 01:44:37 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id a4so7274864ljq.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 May 2021 01:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qSiHm2x0VYis9oHGnKO3wH7svcL5++yEAOjW2BWiBYU=;
        b=lUxQ/k0n1JapZZYTm69WFnp1eyRdyBv9rIpg5Qh78uGFcJwW9zj0JcGANNe5jNTAFG
         ozbtZ19Nc+BI3pdHuSh+/AHWTjfLNx+jpgL2KiYFpm5juWP8Q+fXbywiRAarGYsAFa66
         n5Lmmdf6u0AfEvUhf/zjjSwkd4PUgWkBeSrNEGIKth9VCi0zGtBuhxe4oAhERKzc18wf
         IIi4BH9yYkES5wS/298ydjGJp8UFleI9hGUBoL9WweIR1jYeZDqGgHYcl/D6UNXQyOR8
         MNiFxe6hNyYGtsi2S9uF7/N7aDogN7+HMo7wS1+aCdcMz53ZnOoS5VHUytvp03Gppzzc
         XM2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qSiHm2x0VYis9oHGnKO3wH7svcL5++yEAOjW2BWiBYU=;
        b=Pqo4BDjZ+mpsUD2JZ2Pkv3CPnMTf/XeBJ5vh7lpTCeFy65RdiwuhvsTejt/wM9aC0s
         K2/6NJjhZpXk6RN17D5Jz2rch3yC+ynBRiho5/rHuXk/zW11VlNK1ctaoVdBPnR6IHLd
         yIwRGoh+lud0NuQfH47sCdYB2Wb5XfATIhkL3OPMq0DrZ1paEIp3l/3ME1czS7xYR7N3
         4vFEhdnGyT0zsuN4WzObMGr+RjWT9mIh+D3aUEmXuibJaUI/ZDKwaWsnhkx69OpffL0N
         nhJ5CrgHNJ618hhJbJQPzBske5L6fvHvC5T0lxjyTRY0EXk0rOVmViLrP110KgPakjb+
         GU7Q==
X-Gm-Message-State: AOAM533QieFTEbt5vyErA7iBcA2gULMlByZJWEj4owIMRX1TZfEDNPWj
        6zHsjX4t4oyhVW9WMxHhfzVY+Lpqo49+MsAoCALozA==
X-Google-Smtp-Source: ABdhPJx9Ta1DFU72yZxzmXeXZOHH/mxW2HUJNM4rOxP7dcdz3+l3k6YcFpfBLmsFpnqUgnCpq0TZ4Q5SQiQ1fLRuA1Q=
X-Received: by 2002:a2e:154a:: with SMTP id 10mr15435817ljv.133.1622450676013;
 Mon, 31 May 2021 01:44:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210525102941.3958649-1-apusaka@google.com> <20210525182900.6.Id35872ce1572f18e0792e6f4d70721132e97a480@changeid>
 <42C641C9-2EAC-4A47-9FF7-8A079DF278E0@holtmann.org>
In-Reply-To: <42C641C9-2EAC-4A47-9FF7-8A079DF278E0@holtmann.org>
From:   Archie Pusaka <apusaka@google.com>
Date:   Mon, 31 May 2021 16:44:25 +0800
Message-ID: <CAJQfnxHf1FEe-TWgSj7rJ=h4+_=LXm0QPXHoJUn3tpWnm6mvtw@mail.gmail.com>
Subject: Re: [PATCH 06/12] Bluetooth: use inclusive language in RFCOMM
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

Thanks for the reply. I have sent v2 which omits this patch. Please take a look.

I am not familiar with the libbluetooth API. Could you tell me more about it?
Beside this and the L2CAP change, are there any other terms
replacement which can't be accepted due to the libbluetooth API?

Cheers,
Archie


On Wed, 26 May 2021 at 23:07, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Archie,
>
> > Use "central" and "peripheral".
> >
> > Signed-off-by: Archie Pusaka <apusaka@chromium.org>
> > Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> >
> > ---
> >
> > include/net/bluetooth/rfcomm.h | 2 +-
> > net/bluetooth/rfcomm/sock.c    | 4 ++--
> > 2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/net/bluetooth/rfcomm.h b/include/net/bluetooth/rfcomm.h
> > index 99d26879b02a..6472ec0053b9 100644
> > --- a/include/net/bluetooth/rfcomm.h
> > +++ b/include/net/bluetooth/rfcomm.h
> > @@ -290,7 +290,7 @@ struct rfcomm_conninfo {
> > };
> >
> > #define RFCOMM_LM     0x03
> > -#define RFCOMM_LM_MASTER     0x0001
> > +#define RFCOMM_LM_CENTRAL    0x0001
> > #define RFCOMM_LM_AUTH                0x0002
> > #define RFCOMM_LM_ENCRYPT     0x0004
> > #define RFCOMM_LM_TRUSTED     0x0008
>
> I am not planning to accept this change any time soon since this is also in the libbluetooth API.
>
> Regards
>
> Marcel
>
