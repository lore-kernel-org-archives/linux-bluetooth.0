Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79436EB64DD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jun 2023 18:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbjF2Sr5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jun 2023 14:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbjF2Srf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jun 2023 14:47:35 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFF830F0;
        Thu, 29 Jun 2023 11:47:34 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b69ea3b29fso16318991fa.3;
        Thu, 29 Jun 2023 11:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688064452; x=1690656452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P71RtlmdN92nQhB4o0ko7vTX4dWH1DeKfxk5mhU/578=;
        b=Vs8MF6KOG4ZNd/gUawXnLay4iwb2SIRd0XTO2w3tutGaG2VUYPo0nt2r5RN4kSiGRF
         PlOQythn8kB2NdTPWKKTlFl3ZDEcNyQMzpLcQZOewvPkSl7G3nXlKFJrOCRMid6MN9Bq
         1cm/zMKolmGqhPVUQ/9u5VYSpw+sG60gYRZT5ThLEfuPjbO5C/5yP3w6QltuDGaOMyMb
         HwdYDWgE5eyM2di5AVFQlSJDUUZBrlTX90qNWgp8j4T7BionyVeCkwGc4VJleMsUAFiO
         fNGtqxtG/YiRQo4qBE5M8I3bz/r/AFKDF1hap88kcBTKoTgru/qJtrOzB9UHTjmwiQ+9
         ARjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688064452; x=1690656452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P71RtlmdN92nQhB4o0ko7vTX4dWH1DeKfxk5mhU/578=;
        b=ZWy63Y4ol0roV2H1DQ9N/g4YhUe+4/v4Hc7AYczim4YHjYKuTjan+tt3nFOobMcAGt
         dcnw9V5TmeFyktX70ZNeL9Xq/YsF0C6Ool0ARX7cUX5eofVDk5V4jLDmcD8A+LdxO49k
         7SiIHtBMV0ytU2X+OdUBevdSpaMBzNgt2dCiVYSMkvytGAcKqb0jk5is+/Y9qK5DAjmQ
         jcc/flXHFJNChQ84mcSsha73W3gTZaVvCVSYDWUNm3iPbWSLcVO2H3BhgOTLKIMw4k88
         KOIN7tNMJURKTspQqnzQbvz9GUJyus1/cnXc3TyZlMlsZifkYEzeXON2THzzFI6kxu+b
         cwdA==
X-Gm-Message-State: ABy/qLbzw41RdjXw3yxH7VvCKgH6QdfwmeBqmwbxJ9Z+a89F/9CXEHLF
        P6z7Lam1tLLfMzTbeRLVKcQK+rMBTtLgYQXY4j4tGRjfe7k=
X-Google-Smtp-Source: APBJJlHEcItpHzYxlS0Gu8KE3LV93d0CMFFr9cV5Hc7PeKWNaMvBP6KDWinrniUTLsEzVXFCzV0Ux7kKv5yZONsy4Ic=
X-Received: by 2002:a2e:3c15:0:b0:2b6:c7f5:65fa with SMTP id
 j21-20020a2e3c15000000b002b6c7f565famr454446lja.20.1688064452156; Thu, 29 Jun
 2023 11:47:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230627191004.2586540-1-luiz.dentz@gmail.com>
 <20230628193854.6fabbf6d@kernel.org> <CABBYNZLBAr72WCysVEFS9hdycYu4JRH2=SiP_SVBh08vukhh4Q@mail.gmail.com>
 <20230629082241.56eefe0b@kernel.org> <20230629105941.1f7fed9c@kernel.org>
 <CABBYNZ+mg1iB_N3-FnVCH8O6j=EAs1BTZjGcG_dwU2oOGk-T+w@mail.gmail.com> <20230629114318.61b46f61@kernel.org>
In-Reply-To: <20230629114318.61b46f61@kernel.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 29 Jun 2023 11:47:19 -0700
Message-ID: <CABBYNZ+5e_60pxCLs1aSKdTb0nrKEhaLCez-3xJi9uyYk8t8zg@mail.gmail.com>
Subject: Re: pull request: bluetooth-next 2023-06-27
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     davem@davemloft.net, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Jakub,

On Thu, Jun 29, 2023 at 11:43=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Thu, 29 Jun 2023 11:34:34 -0700 Luiz Augusto von Dentz wrote:
> > > > Nothing to add to that list?
> > > > Let me see if I can cherry-pick them cleanly.
> > >
> > > I pushed these to net now, hopefully I didn't mess it up :)
> >
> > Great, thanks. I guess I will change the frequency we do pull request
> > to net-next going forward, perhaps something doing it
> > bi-weekly/monthly would be better to avoid risking missing the merge
> > window if that happens to conflict with some event, etc.
>
> Maybe every 3 weeks would be optimal? Basically the week after -rc3,
> the week after -rc6 and then a small catch up right before the merge
> window if needed? Obviously easier said than done as life tends to
> not align with fixed schedules..

Sounds great, will put a calendar reminding me to send pull-requests
every 3 weeks.

--=20
Luiz Augusto von Dentz
