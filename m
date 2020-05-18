Return-Path: <SRS0=JSwD=7A=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747DBC433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 May 2020 21:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40A002075F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 May 2020 21:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YpQ0W+Ay"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgERVVi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 May 2020 17:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbgERVVh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 May 2020 17:21:37 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B15C061A0C
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2020 14:21:36 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id z6so458651ljm.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2020 14:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dc5s5dmER7qcc+iu0hwtpVDyv7dSQnPKwN4PVL9rCsU=;
        b=YpQ0W+AyLWtce2+BdlZA0NnzLSkh/DGFsJB4Ke0Ka7D4K/7SmBZh+IqZC1KJ3Bc8J1
         p9V22dL+wU/u7KsCYaiCZ/CTrXnMCg/cyywO69QZiXkTqXAHpXX+2c3MPN2qrREf44O0
         2HKXCx7PtOaQPYiIdLhKcgMPyhxgM/RgmP7kI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dc5s5dmER7qcc+iu0hwtpVDyv7dSQnPKwN4PVL9rCsU=;
        b=B6Pvccrq5a0CaMURf5vSokkgKvH9ktfQxQnLXXTN8onpr5XYXhYB9/IaBdmb0Gexlq
         ponJMCC6KvT6+8K5nj1yWTzL4qIeu4omoOs5OZgXnap4/R1kjWgG6sD90506rByhspcb
         yUskywr0vxjUQgU6lhtDCIZtyHVVxVbdvEyKWiQ2yzh2W1vgmsnFyMwr92QXRz+yrAJ9
         nmp/jCT4hlHh4m+r+Xj9fsLrRV+dfKI4vqi/sY9o5viL0PiP5hEVd9X1MfK6VB3yWei2
         +cdE9+9BsaVzWpdUtrbsR0hpKoI7ZOpIS7voJOG0VmXn7bbR1aey1IrynjE7SuMtlirp
         ZDHw==
X-Gm-Message-State: AOAM532bOHjQR6NbjH8URXn/+vlNmd597bDS0hbjo9Ruqq4rJXHyWYEQ
        jvJVat7SosMe1eIRkIRbHJm53WZPugyzJC34mb+UGD17
X-Google-Smtp-Source: ABdhPJzxe35f5iavcGMSDXli/JIFJG+IPqv2f4R7hd9r8s9muh2H02sv4uE6vtubHEhIetwkvDRzHNDt9UxzAiRC1XA=
X-Received: by 2002:a2e:7a12:: with SMTP id v18mr11102101ljc.74.1589836895054;
 Mon, 18 May 2020 14:21:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200505175338.BlueZ.v1.1.Ibb4c8b00abb07d20022768dfc8b9479b35e1d9a3@changeid>
In-Reply-To: <20200505175338.BlueZ.v1.1.Ibb4c8b00abb07d20022768dfc8b9479b35e1d9a3@changeid>
From:   Miao-chen Chou <mcchou@chromium.org>
Date:   Mon, 18 May 2020 14:21:23 -0700
Message-ID: <CABmPvSG8_qqAA8M0hHi-3XqdqrkGBzpRypngPenzrODDDn4fbQ@mail.gmail.com>
Subject: Re: [BlueZ PATCH v1] doc/advertisement-monitor-api: Rename methods
 and shorten the preset strings
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Yoni Shavit <yshavit@chromium.org>,
        Alain Michaud <alainm@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Michael Sun <michaelfsun@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel and Luiz,

Per Marcel's suggestion, I renamed the functions and refined the
string values of  features and monitor types. Can you help with
reviewing this?

Thanks,
Miao

On Tue, May 5, 2020 at 5:54 PM Miao-chen Chou <mcchou@chromium.org> wrote:
>
> This renames RegisterApplication/UnregisterApplication to
> RegisterMonitor/UnregisterMonitor and shortens the strings used in some
> properties.
> ---
> Hi Maintainers,
>
> This patch updates the experimental API for advertisement monitoring.
>
> Thanks,
> Miao
>
>  doc/advertisement-monitor-api.txt | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/doc/advertisement-monitor-api.txt b/doc/advertisement-monitor-api.txt
> index 604448f56..74adbfae9 100644
> --- a/doc/advertisement-monitor-api.txt
> +++ b/doc/advertisement-monitor-api.txt
> @@ -89,7 +89,7 @@ Service               org.bluez
>  Interface      org.bluez.AdvertisementMonitorManager1 [experimental]
>  Object path    /org/bluez/{hci0,hci1,...}
>
> -Methods                void RegisterApplication(object application)
> +Methods                void RegisterMonitor(object application)
>
>                         This registers a hierarchy of advertisement monitors.
>                         The application object path together with the D-Bus
> @@ -99,7 +99,7 @@ Methods               void RegisterApplication(object application)
>                         Possible errors: org.bluez.Error.InvalidArguments
>                                          org.bluez.Error.AlreadyExists
>
> -               void UnregisterApplication(object application)
> +               void UnregisterMonitor(object application)
>
>                         This unregisters advertisement monitors that have been
>                         previously registered. The object path parameter must
> @@ -118,7 +118,7 @@ Properties  array{string} SupportedMonitorTypes [read-only]
>
>                         Possible values for monitor types:
>
> -                       "patterns_with_logic_or"
> +                       "or_patterns"
>                                 Patterns with logic OR applied. With this type,
>                                 property "Patterns" must exist and has at least
>                                 one pattern.
> @@ -130,7 +130,7 @@ Properties  array{string} SupportedMonitorTypes [read-only]
>
>                         Possible values for features:
>
> -                       "controller-based-monitor-by-patterns"
> +                       "controller-patterns"
>                                 If the controller is capable of performing
>                                 advertisement monitoring by patterns, BlueZ
>                                 would offload the patterns to the controller to
> --
> 2.24.1
>
