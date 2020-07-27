Return-Path: <SRS0=Hv/D=BG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F063C433E1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Jul 2020 23:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED39C208E4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Jul 2020 23:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJ0md3Km"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbgG0XVw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Jul 2020 19:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgG0XVw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Jul 2020 19:21:52 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093DFC061794
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2020 16:21:52 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id p26so3465623oos.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2020 16:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Czxsi1VLXDgZxl/6xdZpf6T03KJMWWKGdnz2cw9JQjA=;
        b=DJ0md3KmCxQU0G1sQfXHC1CzY72SBjgLd6ggNhcocKbdQq33FtSFRBy/Sc8xrF8HTW
         hi4hjm4AhxrW8cn4EJDN6u6x0grShYwGyFIkBEJaz3EGkwt1O7zrcELFqcAiu8DXIEr5
         fVexlO04+IJJXaFr2dpaMaStzbWzOPkCZ8SdHcaAVjBIcMJ2WGwWCaWS1CHd1cjM4gRx
         1tNKhobY6Z9kKePL4oBHJ7TPk2Q7GPaUjNRpvcg2JcPgf+cKvUi/80rffPVXSex3KNlw
         f3jaLV+B/F8/SbbPKWmnWLYxIWDO3Zs7X5WUnIHGWxj3HXNyRTEkLFkIgYZKn/FbXoH9
         njag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Czxsi1VLXDgZxl/6xdZpf6T03KJMWWKGdnz2cw9JQjA=;
        b=hxwb3vtuJ2S6yOZ8xlO5KLe4I2xEhqrX2fEgxcPN6xYZFpXLVcyP0ZZ0GpXSDLSrhB
         nVzGo0+jaGmqwibSCk6ljmpC4PTZVvcL4edfluUYTKt07WAqYwHr85zCA9sRl+rbykus
         CsLBVbBBODnYb00w7O8Cj3psawfIYtWnxBrC6vHv5IqJdditGH2vK4s6/ZWx9aAHc75N
         4Pm65p3XdH3r5P8WaXAqdqEaRedOT+gi77ceZj2h2ea/JiaXojzrVNLl1OtS+hswpg1L
         bjpWQzvB4oZk4eKYUnf0K6i38yzWAwBL4mzSPhryksXdZcqam86wUWi9nID4Efmy8azj
         nVPQ==
X-Gm-Message-State: AOAM5322ltu9Bsbtm3YSCRUzoDxQQbSkiOZdJmRsiSBmedzN+B7x4fU8
        YYzFOIDkM7yLn1B/wwetHB7TAMWpB04W7V8084o=
X-Google-Smtp-Source: ABdhPJzsmn8MPvl+4kEstmiHxkwTXAAQW8e/lSK2Yy5KFSHDAGmYoCtFTCIGJdWIH+LEBGpsr/QUbpqrsSyUDokAsuU=
X-Received: by 2002:a4a:924b:: with SMTP id g11mr726214ooh.9.1595892111409;
 Mon, 27 Jul 2020 16:21:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200724122507.27671-1-454728735@qq.com>
In-Reply-To: <20200724122507.27671-1-454728735@qq.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 27 Jul 2020 16:21:40 -0700
Message-ID: <CABBYNZ+7DuiuNZQ8AZnvSoGPQXD8pG0sVMqwy=xoGp2EWYQLPw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/1] src/agent.c : parse_io_capability Function optimization
To:     luokai <454728735@qq.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        luokai <luokai@uniontech.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Fri, Jul 24, 2020 at 5:27 AM luokai <454728735@qq.com> wrote:
>
> From: luokai <luokai@uniontech.com>
>
> ---
>  src/agent.c | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)
>
> diff --git a/src/agent.c b/src/agent.c
> index e0ffcd22f..82baf608f 100644
> --- a/src/agent.c
> +++ b/src/agent.c
> @@ -957,20 +957,24 @@ static void agent_destroy(gpointer data)
>         agent_unref(agent);
>  }
>
> +static struct capability g_cap[]  = {
> +       {"", IO_CAPABILITY_KEYBOARDDISPLAY},
> +       {"DisplayOnly", IO_CAPABILITY_DISPLAYONLY},
> +       {"DisplayYesNo", IO_CAPABILITY_DISPLAYYESNO},
> +       {"KeyboardOnly", IO_CAPABILITY_KEYBOARDONLY},
> +       {"NoInputNoOutput", IO_CAPABILITY_NOINPUTNOOUTPUT},
> +       {"KeyboardDisplay", IO_CAPABILITY_KEYBOARDDISPLAY}

We usually spaces after { and before }.

> +};
> +
>  static uint8_t parse_io_capability(const char *capability)
>  {
> -       if (g_str_equal(capability, ""))
> -               return IO_CAPABILITY_KEYBOARDDISPLAY;
> -       if (g_str_equal(capability, "DisplayOnly"))
> -               return IO_CAPABILITY_DISPLAYONLY;
> -       if (g_str_equal(capability, "DisplayYesNo"))
> -               return IO_CAPABILITY_DISPLAYYESNO;
> -       if (g_str_equal(capability, "KeyboardOnly"))
> -               return IO_CAPABILITY_KEYBOARDONLY;
> -       if (g_str_equal(capability, "NoInputNoOutput"))
> -               return IO_CAPABILITY_NOINPUTNOOUTPUT;
> -       if (g_str_equal(capability, "KeyboardDisplay"))
> -               return IO_CAPABILITY_KEYBOARDDISPLAY;
> +       size_t count = sizeof(g_cap) / sizeof(g_cap[0]);

If I recall correctly we do have macros for ARRAY_SIZE, check
src/shared/util.h, btw there also seems to be a problem with the
formatting on the above line:

Applying: src/agent.c : parse_io_capability Function optimization
.git/rebase-apply/patch:36: trailing whitespace.
size_t count = sizeof(g_cap) / sizeof(g_cap[0]);
error: 1 line adds whitespace errors.


> +       for (size_t i = 0; i < count; i++)
> +       {
> +               if(g_str_equal(capability, g_cap[i].cap)) {
> +                       return g_cap[i].parse_capability;
> +               }
> +       }
>         return IO_CAPABILITY_INVALID;
>  }
>
> --
> 2.20.1
>
>
>


-- 
Luiz Augusto von Dentz
