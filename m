Return-Path: <SRS0=Zhcm=6P=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE44C47254
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 May 2020 22:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD1FF2166E
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 May 2020 22:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tDqje9Ni"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgEAWFy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 May 2020 18:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgEAWFx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 May 2020 18:05:53 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65235C061A0C
        for <linux-bluetooth@vger.kernel.org>; Fri,  1 May 2020 15:05:52 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id z25so3683999otq.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 May 2020 15:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=RrNJPK3OeGp0riY/ip6ewydq3MkrCS0m1k7+xPmS2Kg=;
        b=tDqje9Ni4Q1THQVI1vtUTj0JbVfMjl+4uPueKB/gnlQPCM5eKPsq2S/KWCEknXH1Yz
         sJzl73Ml/uDP4U7tLB4+sAHONDC1o7svGDZ8uBsUmUaq88Ycsl2k3TqHembIu6XfwU3k
         aWeu7y/SXv/lZkqALb34uRj0HsI4FvUM7tqo/zjpfDELhMohTSWcxFoqZbELmQnN7iuO
         oYuwLbni58WtnkFgwS5TtP79TosUexc136IlLgdm0WFSgjJmldJSf1aA5aMNjDxaJuHY
         MP7PkzyFQgFcWClEn8vIDiJhgK8sqec9lwQI/QvqNac8W5hZmVReoM9jYhk5lfJ2+dHy
         3CNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=RrNJPK3OeGp0riY/ip6ewydq3MkrCS0m1k7+xPmS2Kg=;
        b=Te7q9UEgOeWAbuanZ5td5fvefx5fw1lSkWh+KEyypvkdN8WfxINcCMQXaOTpz/iwKX
         Cc1fLRf9lfjTj/r2aJiEOCq3503U//VvC9p3n/4jNxNCLEI1qxEPmRLqtQD91hd9FgZR
         Eyo5s2Z1ybTzE7QVbyrz7QzSabyfV0t1Gm92DDjWnja3j5TKOaGkTXvSTMWLmlG6WYzc
         e6Oy5nzjNH+HA4U9jpHJ5rSVJAp+8gyLSQoUqmzMnEoV76II6ROY11HsLzW88tfOn8Ap
         0wFL+YeSqT3//j0pGBA9nUiaahB3eXLi+yi7s2xvkShf7eA5bsv+YGDpW/so2SIM6pMm
         BTnQ==
X-Gm-Message-State: AGi0PuaPaF41qCeZHLJAPZUo1BMEFaLjhq4ZsiDGDNJNTjb9R2Refkkt
        iNGaM7z84tC2rVWMAMDtiVSvGeNLhUN1/uy6uDl5873A
X-Google-Smtp-Source: APiQypKvopxN9YP+Nzk3VxrBMFi2AVKP0Z2x0NKsLdn9TY9aPz7sttX4aVKLTEDLvCRrG6yv5PNDrY3vlYuvlPUUWAM=
X-Received: by 2002:a9d:7a98:: with SMTP id l24mr5503223otn.79.1588370751403;
 Fri, 01 May 2020 15:05:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200429221613.1574274-1-luiz.dentz@gmail.com>
In-Reply-To: <20200429221613.1574274-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 1 May 2020 15:05:39 -0700
Message-ID: <CABBYNZ+sjXMydrToaMzRzKHpSCZrLMXDM75Rt5_TL5mOaTidGw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] log: Make error and warn log file and function information
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Wed, Apr 29, 2020 at 3:16 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This makes it a lot simpler to find out where errors/warnings come from
> and also remove the possibility of clashes when having multiple places
> where the message would be exactly the same.
> ---
>  src/log.c | 26 --------------------------
>  src/log.h |  6 ++++--
>  2 files changed, 4 insertions(+), 28 deletions(-)
>
> diff --git a/src/log.c b/src/log.c
> index 11d26d508..a42c5941d 100644
> --- a/src/log.c
> +++ b/src/log.c
> @@ -53,32 +53,6 @@ static void monitor_log(uint16_t index, int priority,
>         bt_log_vprintf(index, LOG_IDENT, priority, format, ap);
>  }
>
> -void error(const char *format, ...)
> -{
> -       va_list ap;
> -
> -       va_start(ap, format);
> -       vsyslog(LOG_ERR, format, ap);
> -       va_end(ap);
> -
> -       va_start(ap, format);
> -       monitor_log(HCI_DEV_NONE, LOG_ERR, format, ap);
> -       va_end(ap);
> -}
> -
> -void warn(const char *format, ...)
> -{
> -       va_list ap;
> -
> -       va_start(ap, format);
> -       vsyslog(LOG_WARNING, format, ap);
> -       va_end(ap);
> -
> -       va_start(ap, format);
> -       monitor_log(HCI_DEV_NONE, LOG_WARNING, format, ap);
> -       va_end(ap);
> -}
> -
>  void info(const char *format, ...)
>  {
>         va_list ap;
> diff --git a/src/log.h b/src/log.h
> index 0d243ceca..e83431151 100644
> --- a/src/log.h
> +++ b/src/log.h
> @@ -23,8 +23,6 @@
>
>  #include <stdint.h>
>
> -void error(const char *format, ...) __attribute__((format(printf, 1, 2)));
> -void warn(const char *format, ...) __attribute__((format(printf, 1, 2)));
>  void info(const char *format, ...) __attribute__((format(printf, 1, 2)));
>
>  void btd_log(uint16_t index, int priority, const char *format, ...)
> @@ -71,3 +69,7 @@ void __btd_enable_debug(struct btd_debug_desc *start,
>  } while (0)
>
>  #define DBG(fmt, arg...) DBG_IDX(0xffff, fmt, ## arg)
> +#define error(fmt, arg...) \
> +       btd_error(0xffff, "%s:%s() " fmt, __FILE__, __func__, ## arg)
> +#define warn(fmt, arg...) \
> +       btd_warn(0xffff, "%s:%s() " fmt, __FILE__, __func__, ## arg)
> --
> 2.25.3

Pushed.

-- 
Luiz Augusto von Dentz
