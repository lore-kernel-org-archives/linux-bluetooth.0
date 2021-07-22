Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4B4C63797
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 17:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A310461249
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 17:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbhGVRB7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Jul 2021 13:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhGVRB6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Jul 2021 13:01:58 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2303CC061575
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jul 2021 10:42:33 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id i18so9478254yba.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jul 2021 10:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Xkl9AJX+plSIRA91PfxNeMRpcle1/PPf33UiHkKjs6E=;
        b=RYHoocQMwAINVAuMqcXBCzeTmt0OJrD4hnno2kPRE4AyaosICeLB1tkio/vb944qD+
         n6gkFG0AY0lvKMYoJQlcq4XR8l8r6IY5GhhBYZWhG77pNLDwVuxsISNx/BA9QTXsW2OV
         s3vC/MW1fDSIVTfyMkkU1B5cjVpy3NSL/Sedt9gn4Y25dLR3rzC1JHdwN5DwWCzWEiW6
         mezL1WjgX3i/+1Jn+Pcnx0taCcE0F7a6rGWTSJ75zQBiUUHBYIwj93T5CQf4T+KtOZAw
         vfhXEPE7UTP/8m59aG8LjWG8sEBPvxjR2SEH8uqhPSOEzZqhU/nTOI/msoFFcekgctsY
         4DHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Xkl9AJX+plSIRA91PfxNeMRpcle1/PPf33UiHkKjs6E=;
        b=Tvp6FBzSDTknI53QlY8VHvgwNW1ehQTWBDzAqJqUwCmf4dkQ+uxZ5yDU0WXq77Hmgv
         nwc0RnAjt9D5W/3hyA7GATkyGp0BPXdMDU6SG0bR6IRJIg+DsqSmHsk2Ps8+bS7FeREA
         rY2pGRJKtN87fixJmbjMFRVDB9AyxW5uPbguXkytGvl1d8TzZEfVPeO0BoJ8qwLrk/dT
         GJ6tVmaV0qgc2f46Hcy+0mdgmvf+mUDabRu01WWxj2mY6/CzaddMcCGcQPwdxMTIgbwt
         7YlB/RD6F91wBnYsz0q2FMzJ2kHQoRqPi8Oepkpe6tfyJKDwSu0pZMxSVxTGQwZZgDBy
         HTrQ==
X-Gm-Message-State: AOAM531IesbwEWJeXUwKGfq3Wk3WbtUsdkVRLUrInnHkCK00YnDBjErh
        UyaoIOyM5veyb2WqQnJUWtZeli9vZk1njSk9ISoat2TZ
X-Google-Smtp-Source: ABdhPJzz1iduS4E27EDHcKgXkRZfMeFE7eewwJi5XaR2FU/xWEL38LcM7IAtUTVrZu3vwzFIcn30ETUxuas7748/opo=
X-Received: by 2002:a25:fc1c:: with SMTP id v28mr937511ybd.408.1626975752280;
 Thu, 22 Jul 2021 10:42:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210630080807.12600-1-kiran.k@intel.com> <20210630080807.12600-10-kiran.k@intel.com>
 <CABBYNZK-bE6vxikRHhxBM_7ucyZqMjxUBY6VEyw_e8C_xxAigA@mail.gmail.com> <B7EC95F8-FFDF-40CE-83B6-85861D530FD5@holtmann.org>
In-Reply-To: <B7EC95F8-FFDF-40CE-83B6-85861D530FD5@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 22 Jul 2021 10:42:21 -0700
Message-ID: <CABBYNZKMrq_6Rb9rJKhMU-w=WjznQsVc=yYfDVuxKtEjvtNLdw@mail.gmail.com>
Subject: Re: [PATCH v10 10/10] Bluetooth: Add offload feature under
 experimental flag
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Kiran K <kiran.k@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Thu, Jul 22, 2021 at 7:01 AM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Luiz,
>
> >> Allow user level process to enable / disable codec offload
> >> feature through mgmt interface. By default offload codec feature
> >> is disabled.
> >>
> >> Signed-off-by: Kiran K <kiran.k@intel.com>
> >> Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> >> Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
> >> ---
> >> * changes in v10:
> >>  - new patch added to place offload codec feature under experimental f=
lag
> >>
> >> include/net/bluetooth/hci.h |   4 ++
> >> net/bluetooth/mgmt.c        | 106 +++++++++++++++++++++++++++++++++++-
> >> net/bluetooth/sco.c         |  10 ++++
> >> 3 files changed, 119 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> >> index e20318854900..5ca98d9f64dd 100644
> >> --- a/include/net/bluetooth/hci.h
> >> +++ b/include/net/bluetooth/hci.h
> >> @@ -331,6 +331,10 @@ enum {
> >>        HCI_CMD_PENDING,
> >>        HCI_FORCE_NO_MITM,
> >>
> >> +#if IS_ENABLED(CONFIG_BT_OFFLOAD_CODECS)
> >> +       HCI_OFFLOAD_CODECS_ENABLED,
> >> +#endif
> >
> > That is probably a bad idea as it could lead the enum to assume
> > different values based on what is enabled, besides we don't gain
> > anything by not having the symbol defined all the time.
>
> While this would work with dev_flags which are internal and not API, I st=
ill don=E2=80=99t like it.
>
> There is really no benefit to make this a compile time option. And as far=
 as I remember I never said this needs to be compile time. Actually I rathe=
r have this as an experimental setting so that it can be switched on at run=
time. Nobody is going to recompile their kernels to test codec offload.

Initially I was with the same opinion, but the problem is the codecs
are read at init sequence and the experimental flags are set at a
later stage thus why I suggested a KConfig option until the feature is
more mature and we can remove the option altogether.

> Regards
>
> Marcel
>


--=20
Luiz Augusto von Dentz
