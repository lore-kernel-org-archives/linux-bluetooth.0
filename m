Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88599C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Feb 2022 22:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387206AbiBHWVw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Feb 2022 17:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386798AbiBHVOD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Feb 2022 16:14:03 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04617C0612B8
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Feb 2022 13:14:02 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id c6so390830ybk.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Feb 2022 13:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EfhQVP4OmmgPYo7hoJcK+/enNvSS3MtX1yOJquPjA/c=;
        b=FEBI0rX/F5aGY7qQRHHlEL9mjXUCrLd2e3Yrq11s/kXQXcaZhZYwIz0vg5AdNgeO8W
         Es3i0QyedTdz32ziMvvP5kUpWmDsRih0OQdp+OEgKvq/TBMVWHvhG89VON5ovxDCvDDd
         GO2zoXHgh+Q+cX+WNIBKgSTS5vjedqpxtFutuIn1B+toMPhKSOx8XCjvcDgHC6mvEJaQ
         r2OQZb19+o8xe+6jGfEEKdzlU0IDIpAv20u6astTmYPhmevQT5s7UCjQaBp24rgo6Qvs
         SoMm2aAYsfI2Jzic+S88m7bPGlnyHLH6nYySN/wjn/aU2nv6H9bGantEzIS44vSqQBXK
         ugig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EfhQVP4OmmgPYo7hoJcK+/enNvSS3MtX1yOJquPjA/c=;
        b=tQRVRX5Xnp1ELSqN7K2hcW5c3L806XQGOqsSf58PspV6QtxqMaj4uhUpyvHDfgFaCR
         Du88OSCszekoIgFls7LQjw1Uf9oFKqcyIIYNQaYrzQK8OtxS1DXeFKHmYPGc4G3jsWZm
         w33LsX1MW4aBBg+aeBcv99WHCOwxYz/ZtZtfb69K+0ZM2LZQmDotdcvFyyfKioSvmEuN
         an4J//RQYHH8BH3U6v4Cjb2BEuK9HTaCisp5pDSOzHK8Uhk2sJWEf2JNZTKLMsnyXhno
         7CkeFPgtDEV+UeWkUb0EnUYzKRzpU3pjdiLQN70tGXdLv4ZgBL2jLv0uEYypbHmENxPS
         z6XA==
X-Gm-Message-State: AOAM530t3d4n++GC+klUrSo4kjMwbDIs+mHbW/Kualfn0SH0N+dPr1qj
        ojnG4Bm6n1Lxgyr4LxgfaG/0QAht8H542Xje5c1Rqb+TG4U=
X-Google-Smtp-Source: ABdhPJylkgDfnDZKVMphD8mWEYJ5UTNNO02lgT1JAqVveREUbyTT4XrgTuGlJnkzXI5nWQwWbtCBeF5yfIU6Y3kr6Xg=
X-Received: by 2002:a81:c40c:: with SMTP id j12mr6892531ywi.37.1644354841006;
 Tue, 08 Feb 2022 13:14:01 -0800 (PST)
MIME-Version: 1.0
References: <20220208210541.3883437-1-luiz.dentz@gmail.com>
In-Reply-To: <20220208210541.3883437-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 8 Feb 2022 13:13:50 -0800
Message-ID: <CABBYNZLLm=H5ejxPOLmNsG5jRj5jnUMTys-i9Y+Zs3HgBd6yoQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] adv_monitor: Fix spamming errors
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Manish Mandlik <mmandlik@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Manish,

On Tue, Feb 8, 2022 at 1:05 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> If advertising manager is not enabled don't log any error on
> btd_adapter_update_found_device, also change
> btd_adv_monitor_offload_supported to btd_adv_monitor_offload_enabled
> since that is checking if the features has been enabled rather than it
> is just supported.
>
> Fixes: https://github.com/bluez/bluez/issues/286
> ---
>  src/adapter.c     | 2 +-
>  src/adv_monitor.c | 6 ++----
>  src/adv_monitor.h | 2 +-
>  3 files changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index e59b16328..b15b5021f 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -6899,7 +6899,7 @@ void btd_adapter_update_found_device(struct btd_adapter *adapter,
>         bool duplicate = false;
>         struct queue *matched_monitors = NULL;
>
> -       if (!btd_adv_monitor_offload_supported(adapter->adv_monitor_manager)) {
> +       if (!btd_adv_monitor_offload_enabled(adapter->adv_monitor_manager)) {

Could you please confirm this is actually correct, I have the filling
there shouldn't be ! in the above statement.

>                 if (bdaddr_type != BDADDR_BREDR)
>                         ad = bt_ad_new_with_data(data_len, data);
>
> diff --git a/src/adv_monitor.c b/src/adv_monitor.c
> index 602830e30..33f4d9619 100644
> --- a/src/adv_monitor.c
> +++ b/src/adv_monitor.c
> @@ -1844,12 +1844,10 @@ void btd_adv_monitor_manager_destroy(struct btd_adv_monitor_manager *manager)
>         manager_destroy(manager);
>  }
>
> -bool btd_adv_monitor_offload_supported(struct btd_adv_monitor_manager *manager)
> +bool btd_adv_monitor_offload_enabled(struct btd_adv_monitor_manager *manager)
>  {
> -       if (!manager) {
> -               error("Manager is NULL, get offload support failed");
> +       if (!manager)
>                 return false;
> -       }
>
>         return !!(manager->enabled_features &
>                                 MGMT_ADV_MONITOR_FEATURE_MASK_OR_PATTERNS);
> diff --git a/src/adv_monitor.h b/src/adv_monitor.h
> index bed6572d0..c6bb8a68a 100644
> --- a/src/adv_monitor.h
> +++ b/src/adv_monitor.h
> @@ -27,7 +27,7 @@ struct btd_adv_monitor_manager *btd_adv_monitor_manager_create(
>                                                 struct mgmt *mgmt);
>  void btd_adv_monitor_manager_destroy(struct btd_adv_monitor_manager *manager);
>
> -bool btd_adv_monitor_offload_supported(struct btd_adv_monitor_manager *manager);
> +bool btd_adv_monitor_offload_enabled(struct btd_adv_monitor_manager *manager);
>
>  struct queue *btd_adv_monitor_content_filter(
>                                 struct btd_adv_monitor_manager *manager,
> --
> 2.34.1
>


-- 
Luiz Augusto von Dentz
