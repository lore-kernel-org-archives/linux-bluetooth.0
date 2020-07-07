Return-Path: <SRS0=I8IU=AS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21EBC433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jul 2020 17:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A1222075B
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jul 2020 17:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WU2bb6Pf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbgGGRPs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jul 2020 13:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728208AbgGGRPq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jul 2020 13:15:46 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C990DC061755
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2020 10:15:45 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id m26so25194093lfo.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jul 2020 10:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sJDZPklgLSz+bMRCtm1xi8y9hsWb4olH788+hzSKmpc=;
        b=WU2bb6PfdBoznpT00kQbPfsp33gzKy0a5KqENwSsU/gVoWIvE49o5u2I+6Sez81hbH
         w5fYuOus/0PYiDWA+RkRzY9ezg1OhuCGxVUfNf85Cv4g/29s/FhS8WbIKh4jDMEbOp1p
         B5+ZVSvp2WtzIfDvCw5QXs9NwbWsSKpo7YNPIf2U5Zy+yrNV6y4Q+NNmp3SotlKVaNUH
         r5QFHef5Xni4w6CsBCC3IXFE0lAPQQcnVZ4ocsC06VpM0PTLBNMCU7NeKu79Pdg/JpXg
         wDr/Ihr7cZ17ygR3kCgN0P1uAdg2sltX4LAirT86NQdzYfI+ZhbKAymYDj/OGLHeqn7n
         1LZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sJDZPklgLSz+bMRCtm1xi8y9hsWb4olH788+hzSKmpc=;
        b=uMavb3GhOSRaQ5M9fyEEHAxkxCF4cieza5NFukAZ540TQZbTwalqDYRpmOOFGKZVfz
         coIiSt2/G0oTPkbe+B7HBNomsL9WCml8+VkVz7NAWLCWL/nSd8YoOtt8toRkctwb8lUS
         42394t4CcEImyQ/ObIoPjQNXwEtgGXde9q6vkL/qyD7dVNOL2hvc0uFqIsws0BJjwzxn
         8KkzxYxPFu90pyCXQzwn7IPBLgkqErHgid0KA936uu3y8ZVQd/LGdUkCTvmyFkcUYIdc
         aIbD+FNxpbamyqaRLy8SJM+nn4rG8VknJTp8nDkEsEge3eZiR3cjfJGgP8G8ikF1p+py
         YDAg==
X-Gm-Message-State: AOAM531++kN+P9l7IaoEKoLu6/aYBBkAEn9Q0kLOH6eA3Yzam7bnzbVU
        SacybgqufV3exFqQ6O5+OyUvmxHYjdjMoWHE0xtyiw==
X-Google-Smtp-Source: ABdhPJw0O/NQ9Ttp8qPZtYIS6Gf/pmCpEN6ZaMZtLnMb2C0HbUS0zh7XzrX5OjjGaDJ11wyJklRuNze8RLtFhwec+f4=
X-Received: by 2002:a19:ad41:: with SMTP id s1mr17609418lfd.191.1594142143948;
 Tue, 07 Jul 2020 10:15:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200707141628.368748-1-alainm@chromium.org> <67268C4E-674E-4DE9-B642-E1CAE8748E28@holtmann.org>
In-Reply-To: <67268C4E-674E-4DE9-B642-E1CAE8748E28@holtmann.org>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Tue, 7 Jul 2020 13:15:32 -0400
Message-ID: <CALWDO_UDxA3maSxKr_wc_VKo3bXuT+GtSmSrMAJ5u4640cyKxw@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: create CONFIG_BT_DEBUG_FEATURE_FUNC_NAME
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, Jul 7, 2020 at 11:53 AM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Alain,
>
> > Creates a CONFIG_BT_DEBUG_FEATURE_FUNC_NAME option to include function =
names in
> > debug statements.
> >
> > Unlike other platforms __func__ isn't a string literal so it cannot be
> > automatically concatenated by the pre-processor.  As a result, the
> > function name is passed as a parameter to the tracing function.  Since
> > pr_debug is a function like macro, the normal expansion of BT_PREFIX_PA=
RAM
> > does not work as it gets processed within the first parameter as well,
> > for this reason, BT_DBG is split into two versions.
> >
> > This patch was built tested with all 4 possible combinations of
> > CONFIG_BT_DEBUG_FUNC_NAME and CONFIG_BT_FEATURE_DEBUG configurations.
> >
> > Signed-off-by: Alain Michaud <alainm@chromium.org>
> > Reviewed-by: Archie Pusaka <apusaka@chromium.org>
> > ---
> >
> > Changes in v2:
> > - Making CONFIG_BT_DEBUG_FEATURE_FUNC_NAME dependent on
> > CONFIG_BT_DEBUG_FEATURE
> >
> > include/net/bluetooth/bluetooth.h | 32 +++++++++++++++++++++++--------
> > net/bluetooth/Kconfig             | 11 +++++++++++
> > 2 files changed, 35 insertions(+), 8 deletions(-)
> >
> > diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/=
bluetooth.h
> > index 7ee8041af803..8506dd268d4b 100644
> > --- a/include/net/bluetooth/bluetooth.h
> > +++ b/include/net/bluetooth/bluetooth.h
> > @@ -162,22 +162,37 @@ void bt_dbg_set(bool enable);
> > bool bt_dbg_get(void);
> > __printf(1, 2)
> > void bt_dbg(const char *fmt, ...);
> > +#define BT_DBG_INT   bt_dbg
> > +#else
> > +#define BT_DBG_INT   pr_debug
> > #endif
> > __printf(1, 2)
> > void bt_warn_ratelimited(const char *fmt, ...);
> > __printf(1, 2)
> > void bt_err_ratelimited(const char *fmt, ...);
> >
> > -#define BT_INFO(fmt, ...)    bt_info(fmt "\n", ##__VA_ARGS__)
> > -#define BT_WARN(fmt, ...)    bt_warn(fmt "\n", ##__VA_ARGS__)
> > -#define BT_ERR(fmt, ...)     bt_err(fmt "\n", ##__VA_ARGS__)
> > -
> > -#if IS_ENABLED(CONFIG_BT_FEATURE_DEBUG)
> > -#define BT_DBG(fmt, ...)     bt_dbg(fmt "\n", ##__VA_ARGS__)
> > +#if IS_ENABLED(BT_FEATURE_DEBUG_FUNC_NAMES)
>
> are you sure you tested this?

This was tested on chromeos using this patch chain which also sets the
configuration and revert our original patch:
https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/=
2279613

>
>
> And frankly I don=E2=80=99t get the point for the new Kconfig option. It =
is rather useless in this patch. Tell me one thing, do you prefer that FEAT=
URE_DEBUG prints the function names or not. Because if dynamic debug is use=
d, we don=E2=80=99t need it since that is all configurable via dynamic debu=
g itself and we don=E2=80=99t need it there (and I also don=E2=80=99t want =
it in the dynamic debug case).
I'd be ok if we unconditionally print function names if
CONFIG_BT_FEATURE_DEBUG is set.  what I want to avoid is to overly
complicate the debug macros to have the function names configurable at
runtime.

>
> Regards
>
> Marcel
>
