Return-Path: <SRS0=YdAw=6E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5B8C3815B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Apr 2020 18:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB6EC206F6
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Apr 2020 18:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oQ6T8BYf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgDTSBE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Apr 2020 14:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726398AbgDTSBE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Apr 2020 14:01:04 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41196C061A0C
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2020 11:01:04 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id m18so8912298otq.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2020 11:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=COQCED9qoy4taO5gtDmTcVSSTRPAqHL4EuOVZzKjp2k=;
        b=oQ6T8BYf1fTFnHFORIcNAXfXQVxNDjxyS/1tU6dtV1A8D+cDD9ddbEn//rLMzC+2kP
         BIAJ63aMHThvcJv7QT4dqOsjGJL3p2Jh4NraGNWI4yNb9DUv9gk36efOHjTPjc2VQEVl
         xFkmUHYybUu5rePyrSunE2UdfRCmkIzQ9OdbeHobmXI6IMutSzVYHEfvqRx8iCx+At9S
         p68MMMA6pmb4nxWhZAd459LnGTiAURMR4V8yJnXu8UkLLJbUUKWTdRrVEyZcRQe2fVVj
         qI/6U651fUUh7AT1rurmP65M57DUDeRduR9tiNfsbWi+bB+HsBWQ+NRi1ERspSfBheHF
         18UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=COQCED9qoy4taO5gtDmTcVSSTRPAqHL4EuOVZzKjp2k=;
        b=IA4AwQ9ogPF9V8rxnkSaPrScy2KBAgprMfTW7krF4rhpp3MdxmJKyE8lcrRajhdpIf
         eAX3/6QSZQuMI9eb96WCgH1tAWVnKPWtf9kSh7cmErfV1ayK2IPMPt1FX6RDBThE4Smp
         8ZCt/lQrf3Mzj1+e1P1kLtQ9XmxZvUzXcmp8QtarhfRNCR4N4kgIJM88vhEY0f/ddgPy
         7i2t8j/fupJEkNA1Dn1u4ErsKfle2fHI8l/ejXR4Sy+7jUhvDbMqEhwY/9nnmbEYCyw0
         gCooNNQNYYXd6fKVDKF4BtvT/3Qz54KvXVfJVG3YXgcLLH5nuMWn3TkvwQsuzoe+3Sda
         NE9Q==
X-Gm-Message-State: AGi0PuZYwmQbfedagUeivFB3E5CkpWNLH/QnlSnwFcqUW+j1EdifHYvv
        AmEXQCZ1Kgw5SacUZQPd0tsUwwrweZ3HC0qK90s=
X-Google-Smtp-Source: APiQypLtE4fCDndQYPX18JFKUyrYMJCaBaDppnvSGMirGfyizKLilaJ+iczu/kqSzrJCGI2O1kuxLkRhSt9G201gttI=
X-Received: by 2002:a9d:7a98:: with SMTP id l24mr11061262otn.79.1587405662640;
 Mon, 20 Apr 2020 11:01:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200420120705.89691-1-szymon.janc@codecoup.pl> <d73bac9fdec3a002478cc1a15da1385e1cd6ce12.camel@intel.com>
In-Reply-To: <d73bac9fdec3a002478cc1a15da1385e1cd6ce12.camel@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 20 Apr 2020 11:00:51 -0700
Message-ID: <CABBYNZKV3_1DWHEUUB0pXzeeVQdOJq7qrf_nV5=KPp8DCWkE+w@mail.gmail.com>
Subject: Re: [PATCH 1/4] android: Fix build with GCC 10
To:     "Gix, Brian" <brian.gix@intel.com>
Cc:     "szymon.janc@codecoup.pl" <szymon.janc@codecoup.pl>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Szymon,

On Mon, Apr 20, 2020 at 9:42 AM Gix, Brian <brian.gix@intel.com> wrote:
>
> Hi Luiz,
>
> Modulo my question about nul termination on patch 3/4,  This patchset resolves all of the GCC 10 build
> error/warnings and, I think, should be applied.
>
> On Mon, 2020-04-20 at 14:07 +0200, Szymon Janc wrote:
> > status and state are used to hold various enum types depending on test
> > and callback passed. Define them as int to avoid warnings about enum
> > assignment from invalid type.
> > ---
> >  android/tester-main.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/android/tester-main.h b/android/tester-main.h
> > index 8a7384c57..6bdfdbcdb 100644
> > --- a/android/tester-main.h
> > +++ b/android/tester-main.h
> > @@ -653,8 +653,8 @@ struct map_inst_data {
> >   * matching with expected step data.
> >   */
> >  struct bt_callback_data {
> > -     bt_state_t state;
> > -     bt_status_t status;
> > +     int state;
> > +     int status;
> >       int num_properties;
> >       bt_property_t *properties;
> >       bt_uuid_t *uuid;

Applied, thanks.

-- 
Luiz Augusto von Dentz
