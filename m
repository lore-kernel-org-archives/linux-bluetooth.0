Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9DAC11F67
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Jun 2021 20:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8D5861DA6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Jun 2021 20:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235233AbhF2U1o (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Jun 2021 16:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233801AbhF2U1m (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Jun 2021 16:27:42 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C099C061760
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jun 2021 13:25:14 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id i18so935615yba.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jun 2021 13:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L7AbbAbaZz43i7sv1H4l16IhYXIFrDz8xbRFAkERY/A=;
        b=spLWIwqDSeifKc6USDHRU34VlHGXuHvYJxgARFWFD2Td+AnfH84GTsAmz1s+LzZAU3
         /Uk3lkoIrkRXi3bdbIfJCCJOwRT/9QKZIO2voiDuCaJhgg/kjDQ/n4tdFmgLav43qixg
         i8N1AJkcHvxoNLMfwnfyMxIPvUuMXQzfKrOrzs+3qUaypYaG4+gv6lDFmsTWAxNzXSvf
         ZOxwHhjDGDEObeqeUvkuKE93CzEO0AgPa13vmDISBX29O3MAvrQQhdRCbB8hwPFYIi56
         bn/X7vb4Ye4QbvqRMHXYIjPyMLBUCcvjNjA/aUqlvjAAUxxWmWh1MVtmtV+4DlsKRcqU
         80IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L7AbbAbaZz43i7sv1H4l16IhYXIFrDz8xbRFAkERY/A=;
        b=seRw2vQzBmh2f6mCttlaYdF4jvCSRijPu9N65QzAT8N4ar3YBustQe75Ay2H46pKVV
         6cQaJ/isYWIvsB2r/MfgreAkPkXbMuuDiJCXaFaQB/2jg4GWEl+eRVOSuoW/Y3CYHRaH
         al2liUmloqogwJSrYWGKuwZOl79EmaGQ57IO3wikTnIdNgK06Rd14c3edtq+0QeVZW7T
         EAploOd8F/Gs9jfbj87lDz0b/R2+HZY04PVqbBjCUI0FytthDPvbJJ7jHkK8wE2/yTzd
         ejKlZJK+11GyR73aOfbtK1g1ganvLlpMmvpul0NjwmrIpvvlgEPPzoMTUK3fZKqQ0Idq
         G21w==
X-Gm-Message-State: AOAM533IDY7JnT/tQ+qMgz6R8IaLwlQQzmenUN74dbqYoPJ3fsVzM0mn
        JsrBcsDfNGDfJZYDRjjVHrz/PfhR4LsMS+9B1JI=
X-Google-Smtp-Source: ABdhPJyygs/L2j7H/gkL0CQ9fj0e4quATA9/jWxETFXfl0giQGmXt3rJxVToGSs63f/sGvDDe1F+q8+zHv1UVcRRJ5Q=
X-Received: by 2002:a25:b216:: with SMTP id i22mr12554629ybj.264.1624998312675;
 Tue, 29 Jun 2021 13:25:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210629154652.BlueZ.v5.1.I832f2d744fe2cff0d9749e24c9ec27071fa0b4ed@changeid>
 <20210629154652.BlueZ.v5.3.I5b72c623fb8b002a5e1f000149b362af3c01ab98@changeid>
In-Reply-To: <20210629154652.BlueZ.v5.3.I5b72c623fb8b002a5e1f000149b362af3c01ab98@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 29 Jun 2021 13:25:01 -0700
Message-ID: <CABBYNZJH3Lih+yNdxdre_5zXp4CuNAzek73cTVub0h0rno3YCA@mail.gmail.com>
Subject: Re: [BlueZ PATCH v5 3/3] adapter: set quality report feature
To:     Joseph Hwang <josephsih@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Joseph Hwang <josephsih@google.com>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Joseph,

On Tue, Jun 29, 2021 at 12:47 AM Joseph Hwang <josephsih@chromium.org> wrote:
>
> This patch adds the function to enable/disable the quality report
> experimental feature in the controller through MGMT_OP_SET_EXP_FEATURE.
>
> A user space process can enable/disable the quality report feature
> by sending a property changed signal to the bluetoothd. The bluetoothd
> can set up the signal handlers to handle the signal in a file under
> plugins/ to call this function.
>
> Note that the bluetoothd calls the experimental feature only when
> the quality_report_supported flag is true.
>
> Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> ---
>
> (no changes since v1)
>
>  src/adapter.c | 36 ++++++++++++++++++++++++++++++++++++
>  src/adapter.h |  2 ++
>  2 files changed, 38 insertions(+)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index e2873de46..829d9806b 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -9332,6 +9332,42 @@ static const struct exp_feat {
>         EXP_FEAT(rpa_resolution_uuid, rpa_resolution_func),
>  };
>
> +/* A user space process can enable/disable the quality report feature
> + * by sending a property changed signal to the bluetoothd. The bluetoothd
> + * can set up the signal handlers in a file under plugins/ to call
> + * this function.
> + */
> +void btd_adapter_update_kernel_quality_report(uint8_t action)
> +{
> +       struct mgmt_cp_set_exp_feature cp;
> +       struct btd_adapter *adapter;
> +
> +       adapter = btd_adapter_get_default();
> +       if (!adapter) {
> +               info("No default adapter. Skip enabling quality report.");
> +               return;
> +       }
> +
> +       if (!adapter->quality_report_supported) {
> +               info("quality report feature not supported.");
> +               return;
> +       }
> +
> +       memset(&cp, 0, sizeof(cp));
> +       memcpy(cp.uuid, quality_report_uuid, 16);
> +
> +       cp.action = action;
> +       if (cp.action > 1) {
> +               error("Unexpected quality report action %u", cp.action);
> +               return;
> +       }
> +
> +       mgmt_send(adapter->mgmt, MGMT_OP_SET_EXP_FEATURE, adapter->dev_id,
> +                       sizeof(cp), &cp, NULL, NULL, NULL);
> +       info("update kernel quality report default adapter %d enable %d",
> +               adapter->dev_id, cp.action);
> +}
> +
>  static void read_exp_features_complete(uint8_t status, uint16_t length,
>                                         const void *param, void *user_data)
>  {
> diff --git a/src/adapter.h b/src/adapter.h
> index 60b5e3bcc..001f784e4 100644
> --- a/src/adapter.h
> +++ b/src/adapter.h
> @@ -240,3 +240,5 @@ enum kernel_features {
>  };
>
>  bool btd_has_kernel_features(uint32_t feature);
> +
> +void btd_adapter_update_kernel_quality_report(uint8_t action);

I rather not have these function exposed if there is no upstream code
using it because this may appear on the likes of static analyzer as
something that is never used, also the current policy is that all
experimental features are to be enabled with -E or if experimental is
set on main.conf, also note that experimental features do persist so I
think in the long run we might want to have an interface in the core
to expose the controls of each experimental feature separately, with
that we could replace the current policy of -E to enable all
experimental features to actually enable the interface and then
persist the features that upper layer would like to have enabled in
the storage.

> --
> 2.32.0.93.g670b81a890-goog
>


-- 
Luiz Augusto von Dentz
