Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E25C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Jan 2021 10:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34AAC2310E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Jan 2021 10:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbhAFKoF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Jan 2021 05:44:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbhAFKoE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Jan 2021 05:44:04 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3009C06134D
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Jan 2021 02:43:23 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id h22so5587441lfu.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Jan 2021 02:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8bWNSAJHVPw3ksclCNcfY36eDMMiepI0sXb94wm9wcU=;
        b=QiaLrRpg3dHzEGmaLbJV4YBphPMtK1YLRdQHDItGOAfhGJg9vqIUSr28wvrFRClKPD
         YeRGPHCvFabU2gCnxbwa4crM47B4ZpCrNnuPqC0c+6I376haJKdmCApeDzo77/ohVcHf
         wKLUUDY7RAGx9IX2uaXXWSFt6SU3qMYKFf493NHxVgtLiMl6pco1lMJMlTqcsaSvEGcj
         yWHjiLyeLzAdrl9CLztqnzXUWc87cZbDJv50giq9pHzBjyTWa06nUC0q8oR3qjXMLYg+
         iVFP0H4w49yt6DPQbQ4+OhYTqBLVwyLyPlfpR8nLxaKIjgGLLoRWpCuzL0g9FYMuGawX
         ldlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8bWNSAJHVPw3ksclCNcfY36eDMMiepI0sXb94wm9wcU=;
        b=YfrHrM5xEjY+XA3PzZgmiFGFlwvLDVGkkzmagqXqq2NjtX//NzxJBT4oZAX6VvEmzI
         0LUKFN63IM+KJOYdb4WeOdKYxoH7Ea1yFyZoXy/ozdLzfWgrK+H5UMhbsUxPbJeB0R/c
         SnL3+M5HO/mU5mJGgHkt/IC95gANfZZugVnQOz2dc2U4uJwHuo+6n7zWT991rye4ypMF
         3qYZlVd6S7c2+8i7FGaF51P4JbEEQHTUjTPuciLH5L4p6dUaZL/Y3/zFZCDaaLVpY+Ds
         Hmqlyov0+gZFyKxulgGRTxRTFcH/Vs30mDHzY5y5XlFdFEGGH/LX9gEAfZjkJpAkogFw
         aTWA==
X-Gm-Message-State: AOAM532bAv99pU0ihdqefBbKTfmRfeLsTVCyO+FPXkkRhG8mlQfmomJ+
        uSzephBx1ERniF1QoJVx48VZkuwyba/LifJJVZRKg0maDjk=
X-Google-Smtp-Source: ABdhPJzLMACM2wivoDBXCajzcABSKZeaxzmKLxAbFK+HF2AirAVPAu15NpJI7Fk0v7756AITwtno9WBipiy34cya/fI=
X-Received: by 2002:a19:690d:: with SMTP id e13mr1607810lfc.82.1609929801915;
 Wed, 06 Jan 2021 02:43:21 -0800 (PST)
MIME-Version: 1.0
References: <20201216114231.Bluez.v3.1.Iab784797733f28413e9de4f0d7fc0d4e1a00d9ef@changeid>
 <20201216114231.Bluez.v3.2.I90bb4b25451e7f726fc2c8771cfe642b16312ce3@changeid>
In-Reply-To: <20201216114231.Bluez.v3.2.I90bb4b25451e7f726fc2c8771cfe642b16312ce3@changeid>
From:   Archie Pusaka <apusaka@google.com>
Date:   Wed, 6 Jan 2021 18:43:11 +0800
Message-ID: <CAJQfnxE3NiqK61N2v164ZFWravB_pxrWkH_mwx5sGGD3e3V+DQ@mail.gmail.com>
Subject: Re: [Bluez PATCH v3 2/2] lib/mgmt: Adding Add Adv Patterns Monitor
 RSSI opcode
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Manish Mandlik <mmandlik@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Yun-Hao Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Bluez maintainers,

I just noticed that only patch 1/2 of the series is applied, and this
one has not.
Could you re-check this one please?
Or is it expected that I also submit the code which uses this API in
the same patch series?

Thanks,
Archie

On Wed, 16 Dec 2020 at 11:43, Archie Pusaka <apusaka@google.com> wrote:
>
> From: Archie Pusaka <apusaka@chromium.org>
>
> The new op is to utilize RSSI in advertisement monitor
>
> Reviewed-by: Manish Mandlik <mmandlik@chromium.org>
> Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> Reviewed-by: Yun-Hao Chung <howardchung@google.com>
> ---
>
> Changes in v3:
> * Flip the order of rssi data and pattern count
>
> Changes in v2:
> * Remove the trailing period on the commit title
>
>  lib/mgmt.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/lib/mgmt.h b/lib/mgmt.h
> index f37f7e6540..76a03c9c24 100644
> --- a/lib/mgmt.h
> +++ b/lib/mgmt.h
> @@ -738,6 +738,21 @@ struct mgmt_rp_add_ext_adv_data {
>         uint8_t instance;
>  } __packed;
>
> +struct mgmt_adv_rssi_thresholds {
> +       int8_t   high_threshold;
> +       uint16_t high_threshold_timeout;
> +       int8_t   low_threshold;
> +       uint16_t low_threshold_timeout;
> +       uint8_t  sampling_period;
> +} __packed;
> +
> +#define MGMT_OP_ADD_ADV_PATTERNS_MONITOR_RSSI  0x0056
> +struct mgmt_cp_add_adv_patterns_monitor_rssi {
> +       struct mgmt_adv_rssi_thresholds rssi;
> +       uint8_t pattern_count;
> +       struct mgmt_adv_pattern patterns[0];
> +} __packed;
> +
>  #define MGMT_EV_CMD_COMPLETE           0x0001
>  struct mgmt_ev_cmd_complete {
>         uint16_t opcode;
> --
> 2.29.2.684.gfbc64c5ab5-goog
>
