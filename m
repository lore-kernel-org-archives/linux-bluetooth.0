Return-Path: <SRS0=Aqt4=BY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0F1C433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Aug 2020 19:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DCB520675
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Aug 2020 19:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F995vKQT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbgHNTsk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Aug 2020 15:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgHNTsj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Aug 2020 15:48:39 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277B3C061385
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2020 12:48:39 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id b22so9108200oic.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2020 12:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AkiSS7C196rcK+zBhAjxtXjYul49ai89IRKHkJgPUbU=;
        b=F995vKQTNEPsu5A0/o+7LcXSTRllakdBH0deijtTxfBBDjg15XJkAmHaolcqJ+L26F
         uZZyGTOVgcXkSiiI2kYAKsBBso7zzBEnXfZz9EBPP3SpMqnJbIRbNKKM/pL48Hvth5MV
         AZpDW+U7aewo5DAbgdJzY0NxtS5gVIKLwJa2cGTgp0hQySKzCNIfAbcvn7O49IPSRMrg
         4Kp043ACUpY8iXHsWnyaBUur+oZVSI9yOdxt6g2J9D22USOBNtWn+TUDaCzXaGCclNY8
         hNtXpmDJ+w1hWDelpHkWJDny4+xW8jYHYzIhHYXm1mCqvIpgcwXw8Fnkhi6IWHWj2nHA
         H49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AkiSS7C196rcK+zBhAjxtXjYul49ai89IRKHkJgPUbU=;
        b=V19HQEmO/qJ970wqF29dYQ1qswuirc1CtH4rZQ+ryNEQvgws/eFih73JhfC4lvRiZy
         fv+wHszn5ArsAT/VhXALQS15xGw5ZLjDDkQ1MhVT3NgZ0UcMJi2CnVJ8uT3yvqW7fVgf
         d4LVUqYFk1/diiZTIeZ4qXXkH+suNAGxJdLHF2+KSl9oDjuGmAyKbZ2tmCiSNTurcfMM
         xqz/+q7FfcOIyiv78AMfjlm4DQsOmDIhXWy57RsCNGvFFiOYElrRHKQ8q+YFDa6KwUn/
         5A6fNUfZciPv1LRMcyrzxLEYh9e+LppVnQd6VEkLUIIcI34G7JxUDLefgHyzzrRIfMFj
         EvrA==
X-Gm-Message-State: AOAM532T/VphO4vLBHhiXelwwz8Cg3T7bBR1jvp3Jd+EFPJ3/HnBJrkq
        dDGnlCmUqLRYsjbUki65pGjpmZRYsUQSBYbrY7Z9Yk7D
X-Google-Smtp-Source: ABdhPJyz+Qfgy+rw3xgS7YcdmNxLU2je2gXTPgABj0c0dv0PaSc8PnnJhKTw5HbFqKkExHEJIE3Dhc5vRhvevAxKumU=
X-Received: by 2002:aca:f504:: with SMTP id t4mr2624914oih.137.1597434517246;
 Fri, 14 Aug 2020 12:48:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200814100047.11008-1-515672508@qq.com>
In-Reply-To: <20200814100047.11008-1-515672508@qq.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 14 Aug 2020 12:48:27 -0700
Message-ID: <CABBYNZKeMkbqnn1qswaLVcLxuAmc6OFPjVUidTiYSpAGvna=Rw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] adapt:Set property mode failed,memory leak
To:     chengbo <515672508@qq.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Fri, Aug 14, 2020 at 4:40 AM chengbo <515672508@qq.com> wrote:
>
> This patch will fix a memory leak,when set property mode,it will send a msg,
> but if failed,the data'memory do not free

Give a look to HACKING documentation on how to properly format patches
as it looks like you are appending the first version on this one as
well.

> ---
>  ...Set-property-mode-failed-memory-leak.patch | 26 +++++++++++++++++++
>  src/adapter.c                                 |  1 +
>  2 files changed, 27 insertions(+)
>  create mode 100644 0001-adapt-Set-property-mode-failed-memory-leak.patch
>
> diff --git a/0001-adapt-Set-property-mode-failed-memory-leak.patch b/0001-adapt-Set-property-mode-failed-memory-leak.patch
> new file mode 100644
> index 000000000..4994e03a6
> --- /dev/null
> +++ b/0001-adapt-Set-property-mode-failed-memory-leak.patch
> @@ -0,0 +1,26 @@
> +From 62d56bedbd32662b3f33af99dd464d67958e76d6 Mon Sep 17 00:00:00 2001
> +From: chengbo <515672508@qq.com>
> +Date: Fri, 14 Aug 2020 17:09:51 +0800
> +Subject: [PATCH BlueZ] adapt:Set property mode failed,memory leak This patch
> + will fix a memory leak,when set property mode,it will send a msg, but if
> + failed,the data'memory do not free
> +
> +---
> + src/adapter.c | 1 +
> + 1 file changed, 1 insertion(+)
> +
> +diff --git a/src/adapter.c b/src/adapter.c
> +index 5e896a9f0..cb4cd8b75 100644
> +--- a/src/adapter.c
> ++++ b/src/adapter.c
> +@@ -2918,6 +2918,7 @@ static void property_set_mode(struct btd_adapter *adapter, uint32_t setting,
> +
> +       if (mgmt_send(adapter->mgmt, opcode, adapter->dev_id, len, param,
> +                       property_set_mode_complete, data, g_free) > 0)
> ++              g_free(data);
> +               return;
> +
> +       g_free(data);
> +--
> +2.20.1
> +
> diff --git a/src/adapter.c b/src/adapter.c
> index 5e896a9f0..cb4cd8b75 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -2918,6 +2918,7 @@ static void property_set_mode(struct btd_adapter *adapter, uint32_t setting,
>
>         if (mgmt_send(adapter->mgmt, opcode, adapter->dev_id, len, param,
>                         property_set_mode_complete, data, g_free) > 0)
> +               g_free(data);
>                 return;
>
>         g_free(data);
> --
> 2.20.1
>
>
>


-- 
Luiz Augusto von Dentz
