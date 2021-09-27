Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51905C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Sep 2021 22:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3494B60FED
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Sep 2021 22:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237635AbhI0Wa4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Sep 2021 18:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237575AbhI0Waz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Sep 2021 18:30:55 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A0DC061575
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Sep 2021 15:29:17 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id u8so19955099vsp.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Sep 2021 15:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GBUV6iTxsPoOJnlFwxjgMOseUMpEumqYnnDgOtycjlM=;
        b=bAH//b7eAMGGCz96l56ciktOe9ZN8pTysbeYuM9Mw5UlSfXFMZyUEpRcNth/8CorNz
         ADb80uPBlWfLzBxg3M3U1/IV0xmzcovU6FRfkF8FDk9zzMmMT5wfRX0g3gPreYgl/k/t
         3u25aZRqxhyCBTB/Zs2bV6SLT/wbdAyPi2teWI96EiXIQDk/S3FCVYZdxHvd6okyUi/P
         prrxX5V+z0nnuch3QGAZ9B5ek2d06viHdJKe3Z+IcLVb2HttkgwYiXxZiYJDMl65Gh9Q
         RqHk2cPQcbD7CwVrFmxS2gc1AIjDbLGd+j0iCTRR44xXVYuN5rrxzrMiy/D8hOg87hYe
         WtVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GBUV6iTxsPoOJnlFwxjgMOseUMpEumqYnnDgOtycjlM=;
        b=KR7DUtAm0a+JYMc5dbLMm3r9RUXdZ9b25bq5I3d9UUIrxvCbSCmNLQ2X5LE3NqoezQ
         gdegaQuf67ig5tg9HMcWDxzX8JcjfD29Lks5kN8pmiRqeFDyeFD9ZG+RAg0+X+Vld9Y4
         bmUpZfywkVdzF6kulLoTEpGFJlb5I/RLTy1jN4T6OS+nlefTTEB8w+bcSvPAHp42lAQL
         dKdsAsRVCc7dJ37CX4flqc9kCUDg8qoGWkhWGH0UmAenhsG0ljNP7jwT/dZDdgQfMxUC
         0iIG41RyS13MXb/mSFic7V9s31SDG3i0gYxurirrfJYrlQN3KS9MH6ciStns7uoYUIlK
         Q8RQ==
X-Gm-Message-State: AOAM531bctYXr1l5uMfRZTstg+7Fg+yVngVp3DGdYv8eQXaKSwo3CnL2
        8nZLhnlvLfFtIn7tAobUcks9D485PeG3bP5HrCE=
X-Google-Smtp-Source: ABdhPJx7J26aoSX8dHQ/VU8mU8YRQSduwaIcPwe2hVkRJonYLbAJJGEUNSscoXwwbeyEj+umefX6xZUlDoK8InEtrVQ=
X-Received: by 2002:a05:6102:2757:: with SMTP id p23mr2427995vsu.61.1632781756230;
 Mon, 27 Sep 2021 15:29:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210927221307.211767-1-hj.tedd.an@gmail.com>
In-Reply-To: <20210927221307.211767-1-hj.tedd.an@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 27 Sep 2021 15:29:04 -0700
Message-ID: <CABBYNZKt=7zUcj8sCQ4C1EjuoQZt5FQMEHhw8J3k3gTWGt-9iA@mail.gmail.com>
Subject: Re: [BlueZ PATCH] doc/tester-config: Enable Microsoft Extension
To:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

On Mon, Sep 27, 2021 at 3:14 PM Tedd Ho-Jeong An <hj.tedd.an@gmail.com> wrote:
>
> From: Tedd Ho-Jeong An <tedd.an@intel.com>
>
> This patch adds Microsoft Extension in tester config.
> ---
>  doc/tester.config | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/doc/tester.config b/doc/tester.config
> index 850fb6a38..1f912cfc8 100644
> --- a/doc/tester.config
> +++ b/doc/tester.config
> @@ -30,6 +30,7 @@ CONFIG_BT_BNEP=y
>  CONFIG_BT_HIDP=y
>  CONFIG_BT_LE=y
>  CONFIG_BT_HS=y
> +CONFIG_BT_MSFTEXT=y
>
>  CONFIG_BT_HCIVHCI=y
>
> --
> 2.25.1

Applied, Ive also enabled AOSPEXT and KASAN to detect memory problems.

-- 
Luiz Augusto von Dentz
