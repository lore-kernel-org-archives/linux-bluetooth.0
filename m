Return-Path: <SRS0=3U9n=EK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA0EC4741F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Nov 2020 21:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05BAB2080D
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Nov 2020 21:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="byJEcqDd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731436AbgKDVDb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Nov 2020 16:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbgKDVDa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Nov 2020 16:03:30 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FFCC0613D3
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2020 13:03:30 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id u127so23663238oib.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2020 13:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eE9d8nlvVO8qmuHS7py/a6wYJyKs26M0XqX6HszSxm0=;
        b=byJEcqDd9u+qktRPBX6NTjgMVgXV21bvpc72G0WemN4Nv9FGciNIw+cXuA1/wX/sDE
         lINxZoW1cHkIiIYJ9Fov1/8VRxKLYHll2jxHDFzNMRy8GcqPKcWiNq6pjtSXRfUnMmDZ
         v412IVgRsheqXM1X4iwtD0q9NjP+Nq9obIhh362eINrQCh81wmPmSgHSID0wFOGxUtb7
         ZzGHpFtCINo58L4Zg9dLJn/4E5uTEFfBXaCE3HaiqEHpXsrLnSV2n7sss8EowPyYLV1Y
         MNeDNZOdqWP0aZG1H3DoqUx8XHpm1O0zC4GNAwN84AWm1vsVTyRyZqDzM4XXiVQuCPIN
         NiHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eE9d8nlvVO8qmuHS7py/a6wYJyKs26M0XqX6HszSxm0=;
        b=eQf6rEOlmjSNiy1C+XsS9SPyWhIuAeyPwqxHVxCG5hkaxCgiD18uarmgrovOJLQ5BR
         7+Ct60YTm852w+FdJG7aLI2djOGvXaScBRsGTRtXwLy+UG2NIPYBNOe13KViyPkCstsy
         AmEKV/EuKuOSOMdKBJMI4KsFSKZ8frlQnmgiuSsQY0uXNkMLII5C7wQH1OLQ/8EM+VcS
         mwT827vV2s6/e3rI8rgOx4Vr6a+J/Mn7QgMo4IOvmvU5BXtepqc7dm8M9Rn+GdKkj6XT
         MuVdFIXId8BJBSA6rhkeA8hUuN2pIY3qFFsmfN8GzP+AaU3WjOEFZwbX5Lp0TjuYaPRU
         FpzA==
X-Gm-Message-State: AOAM530Gi3TSPXOskDlN+fzTpyN+XN6s0wghD1wNgYwYyEA1jdqA9js+
        R4fcxkOKrk0ITNSYrQ0XinntiPKJ/3++UD0Y0U4=
X-Google-Smtp-Source: ABdhPJyW8ZfyeS1DmmpmcD4LF+dbpV9SnlGT/EGQVQ0qNTzWHF/YxRVqEv2jOtInJEta9wuQkvBAF+tdZcRlz3pZlzA=
X-Received: by 2002:aca:c70b:: with SMTP id x11mr3895019oif.58.1604523808488;
 Wed, 04 Nov 2020 13:03:28 -0800 (PST)
MIME-Version: 1.0
References: <20201103073032.4532-1-sathish.narasimman@intel.com>
In-Reply-To: <20201103073032.4532-1-sathish.narasimman@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 4 Nov 2020 13:03:17 -0800
Message-ID: <CABBYNZKYVF+gXS91-DSs8yh6DGcNz6YL0x3Aj8moXoBEzV8pdQ@mail.gmail.com>
Subject: Re: [Bluez PATCH] profile: GOEP Set IMTU to 32k
To:     Sathish Narasimman <nsathish41@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        ravishankar.srivatsa@intel.com,
        Sathish Narasimman <sathish.narasimman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sathish,

On Mon, Nov 2, 2020 at 11:30 PM Sathish Narasimman <nsathish41@gmail.com> wrote:
>
> OPP-RX Throughput is low Due to Low MTU value in case of OBEX
> over L2CAP. Changing the default L2CAP MTU from 672 to 32767.
>
> Signed-off-by: Sathish Narasimman <sathish.narasimman@intel.com>
> ---
>  src/profile.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/src/profile.c b/src/profile.c
> index 5e460b639..99a5e1a4a 100644
> --- a/src/profile.c
> +++ b/src/profile.c
> @@ -41,6 +41,8 @@
>  #include "profile.h"
>  #include "service.h"
>
> +#define BTRX_MTU               32767
> +
>  #define DUN_DEFAULT_CHANNEL    1
>  #define SPP_DEFAULT_CHANNEL    3
>  #define HSP_HS_DEFAULT_CHANNEL 6
> @@ -1358,6 +1360,11 @@ static uint32_t ext_start_servers(struct ext_profile *ext,
>                         l2cap->adapter = btd_adapter_ref(adapter);
>                         ext->servers = g_slist_append(ext->servers, l2cap);
>                         DBG("%s listening on PSM %u", ext->name, psm);
> +                       if (g_strcmp0(ext->name, "Object Push") == 0) {
> +                               if (!bt_io_set(io, NULL, BT_IO_OPT_IMTU, BTRX_MTU,
> +                                   BT_IO_OPT_INVALID))
> +                                       DBG("ERROR bt_io_set Unable to set MTU");
> +                       }
>                 }
>         }
>
> --
> 2.17.1

Perhaps it would be better to have the MTU added to RegisterProfile
options so any user of this API can set the Input MTU.

-- 
Luiz Augusto von Dentz
