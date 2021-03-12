Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E388C4332D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Mar 2021 18:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08B6764F76
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Mar 2021 18:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbhCLS2i (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 Mar 2021 13:28:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbhCLS2Q (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 Mar 2021 13:28:16 -0500
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CFFC061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Mar 2021 10:28:16 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id 125-20020a4a1a830000b02901b6a144a417so1763485oof.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Mar 2021 10:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lzrxZeo2uv2AzGrU5oyo03buci//QyQsqAoim1PK3QY=;
        b=CV3tkc/eQphBTWrJJ7XG+QftZFXJvHicpsjLqrHFO/kHz4rh/WyqT8+4nifpuMbO0r
         YOr00ei55KXBZTAQsB7OKgEl+RLiq4vMOsyNomXNC5M1dPpoM5zXlrABFaZ1zsOawYis
         pzQPjn33oe0v0o2PkD8TcHX2i5a2OW7zg1xGmScqQ8o7vvgkSe2dgaYV3lVUAoAkIql9
         gyZHcuiEd/SdXTsLlXHGxDdjdZEs4oRshGIsCExVWWdFYQtawhZJJnfBi8uP5MOVQ5Vo
         yDf8FrRVGRsTtEQwFpxYKEHxOFJr19RJOIXgvAm4U7+AEtcRRGHuAiVZqJJnr2BFErZc
         q5hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lzrxZeo2uv2AzGrU5oyo03buci//QyQsqAoim1PK3QY=;
        b=uF915q+7HgSAmNLaArp35zhJxngAx3iBhnAupz9H5G02jS5LgzpgjIpD73jiQKLA7c
         Fg026PtkcJdsHXQSrcy/mAWbVljvVx5Zp7qoOX+Sz2TqBi5uWKCvQ37rTeEtyGvC4miW
         +6OErf7CDTgKEbxyu6h4FrpOMxJCMrV1IpRD37Ym0AfZoHt4byHxtbUKe74u24DrwnQX
         6+dv+29LhJZOW/ES/tXLAHLo+ZjPhi5cg63zU/BpOLbKOvmVgKqncbl2Uf2veAFSrKKk
         1Kx9fVU8d0UzGeR46xnDgFAg1loGyBv384ZuorzwQEnp1wtKGEp/UXGzg0L7D9ifb7Tu
         Sd5w==
X-Gm-Message-State: AOAM530W3BNYT/F0ilS1tGXOZZ2qZxqBdlNSWD1af+Dst9moxhSWWdyh
        bpxz92Srw9TtnJp6qzBTtSDz6RPGAt8zSj/kzL1pz4TfOETE+Q==
X-Google-Smtp-Source: ABdhPJxNAtYk2hZXFKJ5xWyLGrGgRNtmekKx4l0Bj7fsO6fN8huIpeuHZ8YN9k0GwUFpb6qmZX4GPRsGDpaA9KJozcA=
X-Received: by 2002:a4a:420d:: with SMTP id h13mr4253399ooj.24.1615573695502;
 Fri, 12 Mar 2021 10:28:15 -0800 (PST)
MIME-Version: 1.0
References: <20210312165017.31829-1-frederic.danis@collabora.com>
In-Reply-To: <20210312165017.31829-1-frederic.danis@collabora.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 12 Mar 2021 10:28:04 -0800
Message-ID: <CABBYNZ+fjE8x6Ba4FJvzb+RUoNgN9i8O8Vn4g0fhLJ+8CbYigg@mail.gmail.com>
Subject: Re: [PATCH Bluez v2] adapter: Fix discovery trigger for 0 second delay
To:     =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Fr=C3=A9d=C3=A9ric,

On Fri, Mar 12, 2021 at 8:53 AM Fr=C3=A9d=C3=A9ric Danis
<frederic.danis@collabora.com> wrote:
>
> When calling `StartDiscovery` the effective start can take around 10 ms o=
r
> up to 700 ms.
> g_timeout_add_seconds() call doesn't ensure the time for the first call o=
f
> the timer if the delay is less or equal to 1 second.

Interesting, I always thought that 0 would be handle just as idle and
not round up to the next timeout.

> ---
> v2: Fix issue founs by CI
>
>  src/adapter.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index cc0849f99..3078ce1a8 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -1797,6 +1797,13 @@ static void trigger_start_discovery(struct btd_ada=
pter *adapter, guint delay)
>         if (!btd_adapter_get_powered(adapter))
>                 return;
>
> +       if (!delay) {
> +               adapter->discovery_idle_timeout =3D g_idle_add(
> +                                               start_discovery_timeout,
> +                                               adapter);
> +               return;
> +       }
> +
>         adapter->discovery_idle_timeout =3D g_timeout_add_seconds(delay,
>                                         start_discovery_timeout, adapter)=
;

Maybe we should have a wrapper function for g_timeout_add_seconds
since I suspect there might be other instances of
g_timeout_add_seconds with 0 delay.

>  }
> --
> 2.18.0
>


--=20
Luiz Augusto von Dentz
