Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52554C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Jun 2022 03:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346194AbiFJDlv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Jun 2022 23:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346186AbiFJDlu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Jun 2022 23:41:50 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC74232BE4
        for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jun 2022 20:41:49 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id a2so34769999lfg.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jun 2022 20:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=l/j0Ay5t+8bqLSl7TACFAtgwxxpLgEeRg+rCxB5aNc4=;
        b=gaIf+Ny/ck+QLx922/dZ7g6ilByOFtkc7L8mNo06zrjbRixWQB1J76YJDQxWnRmMWA
         tU9XxMAMte2dRr6OG+s/nbZaZUc6OON5b6N1YqWkEExD+C/0bsKqSsedQMyYBR3BYd2f
         wSc3r0qiRtEUISMl7iq10Gn6lYKpT8Y9vQe33/Bq8BbkMqudmF0ox7oyzywAfmNoFnip
         FdjAdECvC3gii2G+DFKEUncJTo+25w4abuJX2n0+bQ6/iXNUUn+sA4o9AvVRbBnoAsdz
         ToHLnTw638xDOAF16VP963KrKts7VnqZIQS99DVs/fPUNTLCf/tw6mQkE22k/33nGY4t
         o/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=l/j0Ay5t+8bqLSl7TACFAtgwxxpLgEeRg+rCxB5aNc4=;
        b=tA/jNBudyLhuwCpLhWCX9dUVTPjYCHQHsvEswTFng7Bdc3uMNxRv+gHplL6LBfmtTr
         ewPN47aSIE4V7RIABUwIjaLwUjsgBFJd9BbemaIUGje99M3TnUpzTNDQCr45t/84DOnr
         JiYBrTD/zleE1CcuQEv63syGbOkcChQ9J51hT1vg3L4KJAz9mfR3Nq8tXMJzGZPJkE6Q
         SymyTQnrZoyKpF+3plIG1p8ySG2rnpnJl0sX9E0rAhHKhrbKYTAJSSKdzyUD3Y4LHCJd
         zxQv6Nr77gkQkDqBBvRe9YEqdUNIdispf2GcoKh5/+RMIQAkmgxOWwMS3/eBGMzvJUSd
         T6mA==
X-Gm-Message-State: AOAM533c4d5kVWwVKrWesoV1ARg2tmfdCnuS2diltNDlrbgcQydK1GpX
        8Ul0idsq2bK9yUT9LR42C9uso1YYXnHVgpoijqHE4Grb
X-Google-Smtp-Source: ABdhPJzuMYpt+YFbnIdzYhTu9zMlEU+twPDXdN6BZ6CSeG8njsDX1rXNCUEZjY5/8pVJy/yP43B6rTNGgQudxQCBbuA=
X-Received: by 2002:a05:6512:e94:b0:478:f6ad:c9d7 with SMTP id
 bi20-20020a0565120e9400b00478f6adc9d7mr26438417lfb.198.1654832507467; Thu, 09
 Jun 2022 20:41:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220609190442.74325-1-frederic.danis@collabora.com>
In-Reply-To: <20220609190442.74325-1-frederic.danis@collabora.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 9 Jun 2022 20:41:35 -0700
Message-ID: <CABBYNZKYxefb-OxqCjtsrU9Ws2inXbdSaGiVShuXf6BznzPxgw@mail.gmail.com>
Subject: Re: [PATCH 0/3] test-runner: Add support for audio daemons
To:     =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Fr=C3=A9d=C3=A9ric,

On Thu, Jun 9, 2022 at 12:26 PM Fr=C3=A9d=C3=A9ric Danis
<frederic.danis@collabora.com> wrote:
>
> Those patches add DBus session and an audio card so it should be possible
> to start an audio daemon like PipeWire in the VM.
>
> Fr=C3=A9d=C3=A9ric Danis (3):
>   test-runner: Add DBus session support
>   test-runner: Add audio card support
>   test-runner: Add udevd and trigger events
>
>  doc/test-runner.txt |   5 ++
>  tools/test-runner.c | 197 +++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 189 insertions(+), 13 deletions(-)
>
> --
> 2.25.1

Try sending a v2 since CI tree shall be in sync now.


--=20
Luiz Augusto von Dentz
