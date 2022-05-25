Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB508C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 May 2022 20:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344625AbiEYUJY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 May 2022 16:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344136AbiEYUJW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 May 2022 16:09:22 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E12558D
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 May 2022 13:09:17 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id ob14-20020a17090b390e00b001dff2a43f8cso4412710pjb.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 May 2022 13:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XQim5f8Blg6wTtRzA92Ny0+Y3tYyPf6lm60zU6/FcB8=;
        b=SNitO6aPA76xIkyWfbHiU2IdEzt236uieAcl0waAMAc/7bF4+rE8nYR7XKRQTB2i95
         6ZuMdHiy2kANhveXFHmPY5DmYEtqyyEPwCs7uL5MchatdGCwXHG5Cp54F3p/WNmAVUW4
         YDiALEKi1tI1L/p5zx4pPIfZp9E9nt7Ntr7phabZj+oWTxeghzeH+GSRCWZ6ajYOqQnE
         6+9ins2MC5jM/JhPcg5dmBTTKWqgmbjiX9Xj5HY7MXf+1ikk4BQnVtyz6qrUEgvlTGAT
         8s22nngIMWH92nZ0Sux4DHlhl3iaXnmszWJU9mmATIfGC/GniiHtGidInqqbWuOnexFd
         OlKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XQim5f8Blg6wTtRzA92Ny0+Y3tYyPf6lm60zU6/FcB8=;
        b=lXazZP7PfHoAsi1ptnYOXjLNUiX2ZQpSnbbWOsB55I43bzfDZsQqoBG1cHT6qS4Slg
         CWB4KkDlJRTasGuJuB1pN5MhLDX9N61Jt9VA2col463QfgWoamBCnscSNdDXL/MlcVh2
         dKGnkjCm3WMmnzWKZ6qw6UFKTN+/YNjD8qMthSe0hDhaD3lqbn7RDk8/sZpUkUY6KrVl
         YASOAe329eqiy0mC07Sfs9DwmbKYiAngw3oW1rZpKYaeP7ZdOmZvD9vptFO7lz0FxSsC
         hgR+g1Xqq4ihU7t0/ICg+H132tQRRy4fwE3s/jnLDP4jn5feJlC2hfcTNVCArZHejEnq
         NE0g==
X-Gm-Message-State: AOAM531Bq/tMkrn7avN3bkHulW0a27Y0sE2exgJDq/wFNCAqvHRaEtmB
        TgI8qHBeHIia5Md53q/3bzhcajd6Yd+CK2Ibwm7ozMhiWG8=
X-Google-Smtp-Source: ABdhPJxNH/OIUM3d3jIVUxSzneZk24ViUZAUir2YPnXGUSjN2vvKVs1XykgnpoCO96NfnuLfxnr1/6ya7Mku++tEmvU=
X-Received: by 2002:a17:903:244f:b0:162:4daf:f8bb with SMTP id
 l15-20020a170903244f00b001624daff8bbmr8440437pls.20.1653509356644; Wed, 25
 May 2022 13:09:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220524202630.3569412-1-luiz.dentz@gmail.com>
 <CABBYNZKZajJyuenwyv+1T6Gt1SYyLz39yMJF9_LYdTubk+e_rw@mail.gmail.com>
 <20220524142128.01acb75a@hermes.local> <CABBYNZLs-1Pkf=qKwt7t5b6_wxiZiF4Xzr+K2jMFr_WEDpfaQw@mail.gmail.com>
In-Reply-To: <CABBYNZLs-1Pkf=qKwt7t5b6_wxiZiF4Xzr+K2jMFr_WEDpfaQw@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 25 May 2022 13:09:05 -0700
Message-ID: <CABBYNZ+gQf-YfT5Kiq6GRFsjhyyF7k0vtEc=Zzkc1O-_dExFVg@mail.gmail.com>
Subject: Re: [PATCH-stable] Bluetooth: eir: Fix using strlen with hdev->{dev_name,short_name}
To:     tomu1@verifone.com
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tom,

On Tue, May 24, 2022 at 4:42 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Stephen,
>
> On Tue, May 24, 2022 at 2:21 PM Stephen Hemminger
> <stephen@networkplumber.org> wrote:
> >
> > On Tue, 24 May 2022 13:55:57 -0700
> > Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> >
> > > Here is a tentative fix, I do wonder though why you were trying to set
> > > the name directly and not using the likes of bluetoothctl/btmgmt?
> > > bluetoothd don't seem to bother setting a shortname so it is probably
> > > not reproducible with it but btmgmt does:
> >
> > Not me. I just forward reports from bugzilla.
> > Any networking related bug reports end up going to me, and I filter/forward them.
>
> Sorry, I guess we should forward this to Tom then.

Could you please check if the following change does fix the problem:

https://patchwork.kernel.org/project/bluetooth/patch/20220524202630.3569412-1-luiz.dentz@gmail.com/


-- 
Luiz Augusto von Dentz
