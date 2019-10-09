Return-Path: <SRS0=7chU=YC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B20C47404
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Oct 2019 15:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1C5720B7C
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Oct 2019 15:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B788pNha"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731434AbfJIPBu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Oct 2019 11:01:50 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:47097 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731382AbfJIPBu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Oct 2019 11:01:50 -0400
Received: by mail-ot1-f67.google.com with SMTP id 89so1961843oth.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Oct 2019 08:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nCuHNXWY93DU8QXNIgmtcuv4VdpBRvJRhSXmnBHqFcY=;
        b=B788pNhaz22rdR6HSJnLaq0hgCftPaurUR3OTUWwhs1gtzKOgUwVYBdlh6b5uIbu+O
         8FV3w3jLaOsm26rl0poXrySDOHrJGTIzLtO6+2CVB68efvZPrmAEZftfAFBjVjP5mTYw
         oiQ7MLPieLA+O362KBhshC3zHfzcMTPdXtRNf3pYUdSBrpeba95nu9e4g1vkk5HdQChW
         lWnSRfDtZAIQC3xjEApNvDWDzWAaLf0T8ifj6il1tMC6DnCO3lNeId0NjpXpCj8dae8s
         5LtRrPFwCfdlZtLchYaFjKZwvNVuV8WeLN3zXQSdHCNnb0L8g04JFCgmgX+9MRcvht8N
         gG9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nCuHNXWY93DU8QXNIgmtcuv4VdpBRvJRhSXmnBHqFcY=;
        b=eGHq1P7pl/kZEim0eS+Z/yNgWC0mhJUHvqFjnuZjJtbYUBhSfOVHj1UJPGWttf8jwT
         ENc5wGDy5tAtfFWsyENGVvu1M+ZU07gFmy6HKYv1wMafncZ8wKCxw4PuCluQz5j86N5u
         pei6xbqe27vGRcVsrd304JXGHoVMtiedsDsyNEiw61AZH7ct8ug1Vydqxoq5s58QUzRO
         wEIPyAR3e8JEeTucQsTo3JXIbSYP0Ag0CLMxFWsIogn0U1NT3GX4gy66t9vBQgBlu1ZS
         nwa4zAdf5mTNG+Evbvcg4Xk8n30QVp9FtGyS7rNOkUtbMKd8eXbDAkaV3Rq+eEDc3Hbv
         tPSA==
X-Gm-Message-State: APjAAAWnEs5+VKdRKx71ez4kSAi43qCDMtn34nxehHX7BvAxVmlV0dO/
        o/0EVnkdnIYIBKlsFNQi9081tAf370fLGDt5OFUTk+GfDwk=
X-Google-Smtp-Source: APXvYqyEX9aGWIo3P8/CCLkvz2E3Tud/5bHPE1J7t5RvVkWn1ChnOc/UzqR5Zrljew3ncgZMS7KdA0iOpib4OmzPlW0=
X-Received: by 2002:a9d:197:: with SMTP id e23mr3475445ote.28.1570633307683;
 Wed, 09 Oct 2019 08:01:47 -0700 (PDT)
MIME-Version: 1.0
References: <20191008100156.3813-1-ross.burton@intel.com>
In-Reply-To: <20191008100156.3813-1-ross.burton@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 9 Oct 2019 18:01:35 +0300
Message-ID: <CABBYNZJCwvSRL_AotOSaiEwSg7=8ZCUC=wEvrmtQrh9BUQ+pGQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2] Makefile.am: add missing mkdir in rules generation
To:     Ross Burton <ross.burton@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Ross,

On Tue, Oct 8, 2019 at 1:04 PM Ross Burton <ross.burton@intel.com> wrote:
>
> In parallel out-of-tree builds it's possible that tools/*.rules are
> generated before the target directory has been implicitly created. Solve this by
> creating the directory before writing into it.
> ---
>  Makefile.am | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Makefile.am b/Makefile.am
> index 2ac28b23d..e7bcd2366 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -589,6 +589,7 @@ src/builtin.h: src/genbuiltin $(builtin_sources)
>         $(AM_V_GEN)$(srcdir)/src/genbuiltin $(builtin_modules) > $@
>
>  tools/%.rules:
> +       $(AM_V_at)$(MKDIR_P) tools
>         $(AM_V_GEN)cp $(srcdir)/$(subst 97-,,$@) $@
>
>  $(lib_libbluetooth_la_OBJECTS): $(local_headers)
> --
> 2.20.1

Applied, thanks.

-- 
Luiz Augusto von Dentz
