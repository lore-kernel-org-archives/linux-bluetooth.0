Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD2AC4743C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Jun 2021 18:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33A3A61042
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Jun 2021 18:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbhFUS1Y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Jun 2021 14:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbhFUS1X (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Jun 2021 14:27:23 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1FBC061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jun 2021 11:25:09 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id j184so32950578qkd.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jun 2021 11:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5f/ax12MXeFVFbZu7aGsJGdBqm+HWHBYKwh4bMxbF/A=;
        b=njciv8m3W2EN2xYwD65LZXqUA5MTqT6sWEIT/y+fCgJVxQaeGwyY38mEvdjW2nwW90
         CjTA2NK+KxKlCoNyA4ovEfCK9o0oPoe02ZdtTqys7OfB3SdILL944J6lThZPj213xgMJ
         VKYNYiSe0y30x7D0eNPVQusCKadYDlT8k8kTh5IFNphnSZKlFAfx5gsvHrTQQ89SEln3
         QrkHcZ3Nah8FVsqj3wMhcKuI9OthfQWulUwrePE9q0kuvlljZ8rNnAeSU41KYHISxi5y
         sc0/XvwWVeEHT6sDUQtbL+fjDkKZ/mU94XWP7SPO70AmIvRD5aFyXquoHr14PN4Nftcj
         1FlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5f/ax12MXeFVFbZu7aGsJGdBqm+HWHBYKwh4bMxbF/A=;
        b=UDtphfCIW2/Wf39z395QgueMFOqrXnvCbQEvzCkOa2QdGnz+xzHsY1gHxqzWXPB9FA
         dMzi8CSIscfQC58mk1DYGfBdd8/I+tPa+JjuVQzg9KcgikxC/75lfKkqfKjRP0aIVFk8
         nPyRocVs1iivcpllh3B29HPGgLTj2qEZV37G+rAOb7JlYiB3VrKRM2xMfQsLyrIH6CgU
         3xCuozgsiv1yIXzjKJYqBCJ1//skoQS2ZKSh/TEdZQV1aOmQwLQGscQPjSR7oGExy7sI
         3mppm0RDvh0vSAc/2Q/jeXEVi/zbXmMzFMWeoU7N1Xj1VE6eSkQ4VqZ8l5ROP5BOgM7T
         7p6g==
X-Gm-Message-State: AOAM531LrE/it9r7HjIAn76P3NWcLuhlwRmECgPDWkUxqVPtk0YaQCff
        2o8/lUQUIZthWbGxiKLskBDv3OKzc3yviroVh+E=
X-Google-Smtp-Source: ABdhPJx++Wq+cAH4dYuBvSePa2StZ5lQ+K+Sj1NqT4c5F9gRehHoYdB2jdIrgXw7ALmmT+3dBRkgG81WxQsDqdGys3U=
X-Received: by 2002:a05:6902:102d:: with SMTP id x13mr36190249ybt.408.1624299908357;
 Mon, 21 Jun 2021 11:25:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210621182149.BlueZ.v2.1.I832f2d744fe2cff0d9749e24c9ec27071fa0b4ed@changeid>
 <20210621182149.BlueZ.v2.3.I5b72c623fb8b002a5e1f000149b362af3c01ab98@changeid>
In-Reply-To: <20210621182149.BlueZ.v2.3.I5b72c623fb8b002a5e1f000149b362af3c01ab98@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 21 Jun 2021 11:24:57 -0700
Message-ID: <CABBYNZL3sWvzC9je7_MnuxftJyo9iUOshsXHBtaNAKgAar7XHA@mail.gmail.com>
Subject: Re: [BlueZ PATCH v2 3/3] adapter: set quality report feature
To:     Joseph Hwang <josephsih@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Joseph Hwang <josephsih@google.com>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Joseph,

On Mon, Jun 21, 2021 at 3:23 AM Joseph Hwang <josephsih@chromium.org> wrote:
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

It doesn't seem this is being used anywhere, in the patch description
it mentions a plugin is handling this via a signal but we could
actually make the core do that directly, in fact having a plugin
handling posix signals might be a bad idea. If this is something we
don't need to change at runtime I would expect it to be configurable
over main.conf, or are there legitimate reasons to not have the
controller generating these events all the time?

> --
> 2.32.0.288.g62a8d224e6-goog
>


-- 
Luiz Augusto von Dentz
