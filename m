Return-Path: <SRS0=I8IU=AS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF89DC433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jul 2020 02:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86E7420719
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jul 2020 02:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OtP26L7U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbgGGCWY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Jul 2020 22:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727976AbgGGCWX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Jul 2020 22:22:23 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A03C061755
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Jul 2020 19:22:23 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id t25so43474191lji.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Jul 2020 19:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nSfJBFlbue3JcAbTaRtLjXjgfXtlC/lcr7gFauiCb5E=;
        b=OtP26L7Uxd23GhSRUM10aexhT6XbVkI6DmxC530QzW8UHH4P3ClEjO1gtUaX08nSxV
         ib+yJg5OuVYJSlXV90Iqk2KMnt/jJa4IVdbo9H7AiHR3GHqjY/xi8zMwPMNcTd8Z2Pjc
         exdp8mLxeuRY9rH7b4Lq69NKexWWgXG/OSLbseP084NBRKVvompJaANDiZo0ltdiUEHF
         EW6vHrzNAaGv18knRg7QM8azO67yPTF5sMHzUMHKe33C5/IakLUE/C8CxeDabOcj9GUR
         ber3ngl/03CUhMmDgJMjrTWkawkxWkfgAM+cuR2kvOgm+Z3DPf9xZTAEnQe8wUaze6k8
         TLAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nSfJBFlbue3JcAbTaRtLjXjgfXtlC/lcr7gFauiCb5E=;
        b=rPuzTM8Jh7VmqXVwo2+n0WSbGKNwQhQkchdKQZzkmmJMwotACp+QbCz0wUTifzCxxW
         7piMM8sKHqtj+u8XA9psgSfX6Rcze4F46OXxioYCr0ieFXLqzzFEpc4bbQBSSUBGDRT7
         Tr0QeBb4+PzfqUnk9oZDzXSX9e1E61dpvZo00loLnOdnMdSwnZCg2GX+mqFTSZvdKbh1
         7zlv+bLpRjXtGKfse9tMzQo7uQ3rmTertVkTE3cv2S9WirmOXo/NlCZDpxyBu87i85mo
         suxudz8YqRK9f+FuOAnh2dtCkA59M6AtvWCwLZ/scbp2lq/vU9yz7ebdoAi4j66ESOhM
         zrJw==
X-Gm-Message-State: AOAM532Tv9OMDyuKVIkin/arJ1IRd78fNq2DkrVgSPSL7yKBXeTEzOkN
        dcd/LbgkAScIoDhWQ6l/Erspr6H6JgfvhbFFBnwiPQ==
X-Google-Smtp-Source: ABdhPJxVjah1LUVYsUEzgOhD4+Z1YyCe+esZN1hn6y2GPJON75KKwVyUNyb2x+2uEFKYzVkFrFYGwV02kru+Ya9nfGk=
X-Received: by 2002:a2e:80cc:: with SMTP id r12mr23072026ljg.344.1594088541541;
 Mon, 06 Jul 2020 19:22:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200707003937.187125-1-alainm@chromium.org>
In-Reply-To: <20200707003937.187125-1-alainm@chromium.org>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Mon, 6 Jul 2020 22:22:09 -0400
Message-ID: <CALWDO_Ut-k0WDTkA-o6uj+S1ctEUQu-mXcC3M0oVgMdczo+mZw@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: create CONFIG_BT_DEBUG_FUNC_NAME
To:     Alain Michaud <alainm@chromium.org>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This feature depends (soft dependency) on the kernel experimental
feature defined in this patch:
https://patchwork.kernel.org/patch/11646081/

On Mon, Jul 6, 2020 at 8:39 PM Alain Michaud <alainm@chromium.org> wrote:
>
> Creates a CONFIG_BT_DEBUG_FUNC_NAME option to include function names in
> debug statements.
>
> Unlike other platforms __func__ isn't a string literal so it cannot be
> automatically concatenated by the pre-processor.  As a result, the
> function name is passed as a parameter to the tracing function.  Since
> pr_debug is a function like macro, the normal expansion of BT_PREFIX_PARAM
> does not work as it gets processed within the first parameter as well,
> for this reason, BT_DBG is split into two versions.
>
> This patch was built tested with all 4 possible combinations of
> CONFIG_BT_DEBUG_FUNC_NAME and CONFIG_BT_FEATURE_DEBUG configurations.
>
> Signed-off-by: Alain Michaud <alainm@chromium.org>
> Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> ---
>
>  include/net/bluetooth/bluetooth.h | 32 +++++++++++++++++++++++--------
>  net/bluetooth/Kconfig             | 11 +++++++++++
>  2 files changed, 35 insertions(+), 8 deletions(-)
>
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> index 7ee8041af803..27ec8f2a7c28 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -162,22 +162,37 @@ void bt_dbg_set(bool enable);
>  bool bt_dbg_get(void);
>  __printf(1, 2)
>  void bt_dbg(const char *fmt, ...);
> +#define BT_DBG_INT     bt_dbg
> +#else
> +#define BT_DBG_INT     pr_debug
>  #endif
>  __printf(1, 2)
>  void bt_warn_ratelimited(const char *fmt, ...);
>  __printf(1, 2)
>  void bt_err_ratelimited(const char *fmt, ...);
>
> -#define BT_INFO(fmt, ...)      bt_info(fmt "\n", ##__VA_ARGS__)
> -#define BT_WARN(fmt, ...)      bt_warn(fmt "\n", ##__VA_ARGS__)
> -#define BT_ERR(fmt, ...)       bt_err(fmt "\n", ##__VA_ARGS__)
> -
> -#if IS_ENABLED(CONFIG_BT_FEATURE_DEBUG)
> -#define BT_DBG(fmt, ...)       bt_dbg(fmt "\n", ##__VA_ARGS__)
> +#if IS_ENABLED(CONFIG_BT_DEBUG_FUNC_NAMES)
> +#define BT_PREFIX "%s() "
> +#define BT_PREFIX_PARAM ,__func__
> +#define BT_DBG(fmt, ...)       \
> +       BT_DBG_INT(BT_PREFIX fmt "\n", __func__, ##__VA_ARGS__)
>  #else
> -#define BT_DBG(fmt, ...)       pr_debug(fmt "\n", ##__VA_ARGS__)
> +#define BT_PREFIX
> +#define BT_PREFIX_PARAM
> +#define BT_DBG(fmt, ...)       \
> +       BT_DBG_INT(fmt "\n", ##__VA_ARGS__)
>  #endif
>
> +#define BT_INFO(fmt, ...)      \
> +       bt_info(BT_PREFIX fmt "\n" BT_PREFIX_PARAM, ##__VA_ARGS__)
> +#define BT_WARN(fmt, ...)      \
> +       bt_warn(BT_PREFIX fmt "\n" BT_PREFIX_PARAM, ##__VA_ARGS__)
> +#define BT_ERR(fmt, ...)       \
> +       bt_err(BT_PREFIX fmt "\n" BT_PREFIX_PARAM, ##__VA_ARGS__)
> +
> +#define BT_ERR_RATELIMITED(fmt, ...) \
> +       bt_err_ratelimited(BT_PREFIX fmt "\n" BT_PREFIX_PARAM, ##__VA_ARGS__)
> +
>  #define bt_dev_info(hdev, fmt, ...)                            \
>         BT_INFO("%s: " fmt, (hdev)->name, ##__VA_ARGS__)
>  #define bt_dev_warn(hdev, fmt, ...)                            \
> @@ -188,7 +203,8 @@ void bt_err_ratelimited(const char *fmt, ...);
>         BT_DBG("%s: " fmt, (hdev)->name, ##__VA_ARGS__)
>
>  #define bt_dev_warn_ratelimited(hdev, fmt, ...)                        \
> -       bt_warn_ratelimited("%s: " fmt, (hdev)->name, ##__VA_ARGS__)
> +       bt_warn_ratelimited("%s: " BT_PREFIX fmt, (hdev)->name  \
> +                           BT_PREFIX_PARAM, ##__VA_ARGS__)
>  #define bt_dev_err_ratelimited(hdev, fmt, ...)                 \
>         bt_err_ratelimited("%s: " fmt, (hdev)->name, ##__VA_ARGS__)
>
> diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
> index 1d6d243cdde9..de31c682c7b0 100644
> --- a/net/bluetooth/Kconfig
> +++ b/net/bluetooth/Kconfig
> @@ -142,4 +142,15 @@ config BT_FEATURE_DEBUG
>           This provides an option to enable/disable debugging statements
>           at runtime via the experimental features interface.
>
> +config BT_DEBUG_FUNC_NAMES
> +       bool "Include function names in debugging statements"
> +       depends on BT
> +       default n
> +       help
> +         Provides an option to include function names in debugging
> +         statements.
> +
> +         When enabled, trace statements will include the function name as a
> +         prefix which may help identify the source code references.
> +
>  source "drivers/bluetooth/Kconfig"
> --
> 2.27.0.212.ge8ba1cc988-goog
>
