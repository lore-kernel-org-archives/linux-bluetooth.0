Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED19C4361B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Dec 2020 17:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D29152255F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Dec 2020 17:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731434AbgLORz5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Dec 2020 12:55:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731373AbgLORzq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Dec 2020 12:55:46 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B9DC06179C
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Dec 2020 09:55:05 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id q25so24250811oij.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Dec 2020 09:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TKHxnOCK1jEarQkJQ7zIa27yf6GJB+bxRruPlIz8CSU=;
        b=AzLMmzsy3pgdIOhDmMaUZUUN6RRNcpVhx/7AcACovYQIj9ZtTjkyI+/H3tz5UtHkVx
         nWfPQWT+iHuYe/+oT33htaG6jrussG9O1tGVieD9EXCrvTYTeq4Www6SEKTK6H5LFcXS
         NXBOt/H12mItx1kLTrmPJcKl1YkS7CnPz1AlXaAdRlv925g2Qx3w6nvQVOb07SbOzCS0
         6/VuFtYrXD3tZsL6ac2LmmqNhjL9Ge9k6gjDsA/NBK2tm+6oGVMosJicJuufxcmyArYi
         1rV1CO9Wrhjves9M52czv+fsEtDNK0vnWkl+cm/lsmPLuLBfWB6pUlUAlJ5fOs9jw6nT
         68ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TKHxnOCK1jEarQkJQ7zIa27yf6GJB+bxRruPlIz8CSU=;
        b=CTDJ1Wcdpb+A+sil/c2Rv/x2J6ghOBWSnVU0s/Ho7G2FBfZ40r58T+Hxs/CBQHC7L6
         Y72i+ScJvxghG7k8wv6FpXrEGL+dLcLtuH7R2r91YSW0gbfiN73t0WyB3XhN3FjAAY0n
         JJyJSuP9C+J60WiKaGs3HXLxj2Oe3hNYVFlF67wXnErlXHtFbF6V7qKQgEZJl16ZKlRt
         539ohvCP7Z1wQFZjE/oFTKuZQcwaZ/vIVlycdEccOdNURYw3PY+AUQVgum6EQK1wIXwu
         c/+pAytHq04MWXymWLcsdK1UGFRnzMCB7AcmjgLE17Clb7COpfvVHYf8hfo968axDBIL
         U5qg==
X-Gm-Message-State: AOAM5337kjXBd1tip+/j9M94FXxJnAMadHov7nITpWD3mNK2DSOTBP2u
        Yf6fMGbtTf8XHHh1dFDHu1LmUj5fQO7POc64PS003XXl
X-Google-Smtp-Source: ABdhPJw3qEx7q4dckqjKnErB6hWnN5wQutrpJEpO8CJxawus5xttyg2SYvR2h/fAmySp62vZ4J/KzKOc1jjT8vxrDT0=
X-Received: by 2002:aca:f456:: with SMTP id s83mr35858oih.58.1608054905178;
 Tue, 15 Dec 2020 09:55:05 -0800 (PST)
MIME-Version: 1.0
References: <20201215163328.Bluez.v1.1.Iab784797733f28413e9de4f0d7fc0d4e1a00d9ef@changeid>
In-Reply-To: <20201215163328.Bluez.v1.1.Iab784797733f28413e9de4f0d7fc0d4e1a00d9ef@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 15 Dec 2020 09:54:54 -0800
Message-ID: <CABBYNZKCzdA5cB3WTpbfsbY8nTc9jg_7rcfEpxGi0t+fi5n4Lg@mail.gmail.com>
Subject: Re: [Bluez PATCH v1 1/2] doc/mgmt-api: Add opcode for adding
 advertisement monitor with RSSI
To:     Archie Pusaka <apusaka@google.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Manish Mandlik <mmandlik@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Yun-Hao Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

On Tue, Dec 15, 2020 at 12:33 AM Archie Pusaka <apusaka@google.com> wrote:
>
> From: Archie Pusaka <apusaka@chromium.org>
>
> This is to leverage the filtering by RSSI feature on those controllers
> which supports advertisement packet filtering. To avoid changing the
> existing API and breaking it, a new opcode is required.
>
> Reviewed-by: Manish Mandlik <mmandlik@chromium.org>
> Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> Reviewed-by: Yun-Hao Chung <howardchung@google.com>
>
> Signed-off-by: Archie Pusaka <apusaka@chromium.org>
> ---
>
>  doc/mgmt-api.txt | 52 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
>
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index 1aa43d6c3c..d5c7169630 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -3800,6 +3800,58 @@ Add Extended Advertising Data Command
>                                 Busy
>
>
> +Add Advertisement Patterns Monitor With RSSI Threshold Command
> +==============================================================
> +
> +       Command Code:           0x0056
> +       Controller Index:       <controller id>
> +       Command Parameters:     Pattern_Count (1 Octet)

I'd move the pattern_count after the rssi if the rssi is not per
pattern, well in case the rssi is per pattern then it should be put
inside the Pattern directly.

> +                               RSSI_Data {
> +                                       High_Threshold (1 Octet)
> +                                       High_Threshold_Timer (2 Octets)
> +                                       Low_Threshold (1 Octet)
> +                                       Low_Threshold_Timer (2 Octets)
> +                                       Sampling_Period (1 Octet)
> +                               }
> +                               Pattern1 {
> +                                       AD_Type (1 Octet)
> +                                       Offset (1 Octet)
> +                                       Length (1 Octet)
> +                                       Value (31 Octets)
> +                               }
> +                               Pattern2 { }
> +                               ...
> +       Return Parameters:      Monitor_Handle (2 Octets)
> +
> +       This command is essentially the same as Add Advertisement Patterns
> +       Monitor Command (0x0052), but with an additional RSSI parameters.
> +       As such, if the kernel supports advertisement filtering, then the
> +       advertisement data will be filtered in accordance with the set
> +       RSSI parameters. Otherwise, it would behave exactly the same as the
> +       Add Advertisement Patterns Monitor Command.
> +
> +       Devices would be considered "in-range" if the RSSI of the received adv
> +       packets are greater than High_Threshold dBm for High_Threshold_Timer
> +       seconds. Similarly, devices would be considered lost if no received
> +       adv have RSSI greater than Low_Threshold dBm for Low_Threshold_Timer
> +       seconds. Only adv packets of "in-range" device would be propagated.
> +
> +       The meaning of Sampling_Period is as follows:
> +               0x00    All adv packets from "in-range" devices would be
> +                       propagated.
> +               0xFF    Only the first adv data of "in-range" devices would be
> +                       propagated. If the device becomes lost, then the first
> +                       data when it is found again will also be propagated.
> +               other   Advertisement data would be grouped into 100ms * N
> +                       time period. Data in the same group will only be
> +                       reported once, with the RSSI value being averaged out.
> +
> +       Possible errors:        Failed
> +                               Busy
> +                               No Resources
> +                               Invalid Parameters
> +
> +
>  Command Complete Event
>  ======================
>
> --
> 2.29.2.684.gfbc64c5ab5-goog
>


-- 
Luiz Augusto von Dentz
