Return-Path: <SRS0=kmT4=B7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B57C433E1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 17:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7DA120702
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 17:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAY3R/2R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbgHURih (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Aug 2020 13:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgHURid (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Aug 2020 13:38:33 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D482C061573
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2020 10:38:33 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id x24so2201312otp.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2020 10:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YJmswrb/1hl1zCBlFoKUJMBSjl/y77PLsJckIS2x4MU=;
        b=lAY3R/2R1JkSdonBYRdHszJGrQJwmY96kCd/JOejJkUKFnwFHxo+MvpcM2+KiL6D/h
         gXOmIjOsACBGEOqbYUCpexfJPn8CYxqvpyCZ/rGS1hqDeoMlTsNLjroZBTO71TmWhFzI
         PEOEf6qMeMGNFJYO260Ktu5wilQ3Gua0PLvr3GiKxbP6bHV5YjqU0MFPCB3cWhnzewY7
         mbVLkt6w3+A6o1imNtRBJ1yhQnv/l8QUqOfIDLbBaQQwZDtJGDfF8yOBAFkMcsQBvErz
         jp/CrxRjd/BBB7zVfzLCgI8iH30f8dXw2daUI5l2nEdnaxFZo9T6TI/dtRfO6luYaCpF
         6i5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YJmswrb/1hl1zCBlFoKUJMBSjl/y77PLsJckIS2x4MU=;
        b=som+qkkQaGddiikTxoxsRKlqSwA1yoFdncgEVm4G6bfjhnpGG/rtSBK5+UO2q1AX1w
         eJr0eb/FPsEiABqsVHRXpDg4UocM08cVoqPNSsYcagfPGYleWqCh+XlxuKrwvEsPyPXW
         hjkYATZzZ0IV+baEbI8SfWeyjFKIupDEzYl29PnVri1X0wpTd3w9Cug/3gLAH3sPlq7r
         lpVM9u7M3pDOC+UaEUqF6H8qOttB3cTD82OLv+fxrjm76SvQgL7UEALhzK/3cl6jzztk
         neA1rstlvneg5qbra7uLOupyqTyBH0qDsE84dNm77amWWiRAr1Zm3xaSkA/9pcmxXIvn
         SCug==
X-Gm-Message-State: AOAM531iiZiBwwj9fJT3rjsBbS8ugR4HO6fPohexSiRsaTiawTLRLl/I
        fbhhtHk95NPea9nbbsp7Joiz8T0Cxt6RHc/wta7EmlM+
X-Google-Smtp-Source: ABdhPJzhBud82cP1NfvwrwpAXnFji/UBgjJkzKY9o7W8wzj2O+cKzFK+a+bww0jvA17sCyMfELLiRnjEjQShyHlr9z4=
X-Received: by 2002:a9d:429:: with SMTP id 38mr2660925otc.88.1598031512441;
 Fri, 21 Aug 2020 10:38:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200821073714.19626-1-sonnysasaka@chromium.org>
In-Reply-To: <20200821073714.19626-1-sonnysasaka@chromium.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 21 Aug 2020 10:38:22 -0700
Message-ID: <CABBYNZJN0V5iPkJgbh3Xc8cF4Qdp0azcoPM7bjsto4VeVjrzFA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] adapter: Fix crash in discovery_disconnect
To:     Sonny Sasaka <sonnysasaka@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

On Fri, Aug 21, 2020 at 12:42 AM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
>
> discovery_disconnect crashed because the adapter pointer has been freed
> before. This patch makes sure that discovery list is cleaned up before
> adapter pointer is freed.
>
> Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
>
> ---
>  src/adapter.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index 5e896a9f0..c0b02bf3f 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -5316,12 +5316,25 @@ static void free_service_auth(gpointer data, gpointer user_data)
>         g_free(auth);
>  }
>
> +static void remove_discovery_list(struct btd_adapter *adapter)
> +{
> +       g_slist_free_full(adapter->set_filter_list, discovery_free);
> +       adapter->set_filter_list = NULL;
> +
> +       g_slist_free_full(adapter->discovery_list, discovery_free);
> +       adapter->discovery_list = NULL;
> +}
> +
>  static void adapter_free(gpointer user_data)
>  {
>         struct btd_adapter *adapter = user_data;
>
>         DBG("%p", adapter);
>
> +       // Make sure the adapter's discovery list is cleaned up before freeing
> +       // the adapter.

Please use C style comments.

> +       remove_discovery_list(adapter);
> +
>         if (adapter->pairable_timeout_id > 0) {
>                 g_source_remove(adapter->pairable_timeout_id);
>                 adapter->pairable_timeout_id = 0;
> @@ -6846,11 +6859,7 @@ static void adapter_stop(struct btd_adapter *adapter)
>
>         cancel_passive_scanning(adapter);
>
> -       g_slist_free_full(adapter->set_filter_list, discovery_free);
> -       adapter->set_filter_list = NULL;
> -
> -       g_slist_free_full(adapter->discovery_list, discovery_free);
> -       adapter->discovery_list = NULL;
> +       remove_discovery_list(adapter);
>
>         discovery_cleanup(adapter, 0);
>
> --
> 2.26.2

Otherwise it looks good.

-- 
Luiz Augusto von Dentz
