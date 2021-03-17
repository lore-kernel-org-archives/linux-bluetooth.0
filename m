Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FE9C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Mar 2021 18:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2EA764E61
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Mar 2021 18:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbhCQSfe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Mar 2021 14:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhCQSfC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Mar 2021 14:35:02 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A713C06174A
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Mar 2021 11:35:02 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 31-20020a9d00220000b02901b64b9b50b1so2742390ota.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Mar 2021 11:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h6TC+h+B8fsAquoUBl6DkoV+YWVysaTGLibth1AgGTA=;
        b=UatXQ/kzCOohZkJI82p7umWya5dy48OOUTheTdUjqs6eHiyw7EUgugkD71ZMO6NWYU
         8jP3cswKRrDRS+thgJ1cMHYZOJ98IL7cGX/5V/wfV/5eZoFhMge/uH0rPgmccc4Ma7+8
         Xbbc+yn1rq6oqeQbdQEq4RtYbzmzFbZdnW/wXgp1eNiH3TC3nEPtlswLEjL4ym4BJ/sO
         RoZibtY1z4REVMqr2qPFZ2pGPs7s0zVlrgQSndwy0yI44Y5k+mIMKMtMfyJbjgaWBa7T
         06CdnbgN2QLZlzPM8snvYa6TPPsr2BCouUb2KwEFcFuuOk1IKc3q8aEum2QDh6S6mwm7
         r1fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h6TC+h+B8fsAquoUBl6DkoV+YWVysaTGLibth1AgGTA=;
        b=jLwqhmNa8fyQ/T8HpCWmesvtj5VKc7xmpmDBu4rTkq/HZKQpcX4aWBQX77QtTrPnCZ
         0BqWPUcdsdXhvpIxmX0L7uW1cch+tJNxU/4Ie9eTmaZ4AAgHRYPNmA2uHifH6G1kbkYL
         A8IgB2F58vTrmGEV/lwjVcXyI6Mf0bXBeD9GyFFCrtbHxv4b6aFKMtbhq/VQVvc/O6CM
         77IKHyOFE240Yj77F5re6BPFimMiOaEG4WFoPmCTJ2Pj6HRUcfkqRZbCtILdyVnuc1+4
         NF0AGmk3Ur4eugN7MjAljlSxftZi9DaN8qTmIkVRo8AHrWxFzl++GqmV28/wAuyk0oC1
         lt3Q==
X-Gm-Message-State: AOAM532Uv0k59FMvBBcxWtgWmcdOeqXolxDYOQlUgzqPrgqqBStreLWO
        GDaJLOztb3czJ81KtXPCghoEE6PTnkwSxoVXwyVAJidTBWQ=
X-Google-Smtp-Source: ABdhPJzKCO2LVbn4t7f+8H5tvS7PGBMDUV9suCvMJy0txhBKP/vX2bXH8FW/MyLW7XgY7W3EYtB+qlQ+nXAocESKrus=
X-Received: by 2002:a05:6830:619:: with SMTP id w25mr4393967oti.371.1616006101550;
 Wed, 17 Mar 2021 11:35:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210316232217.3344489-1-danielwinkler@google.com>
In-Reply-To: <20210316232217.3344489-1-danielwinkler@google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 17 Mar 2021 11:34:50 -0700
Message-ID: <CABBYNZJ6Xvt_tAqST4EOz2z4Zom1kJ3goRfpPQ9BDwmBZf-iGw@mail.gmail.com>
Subject: Re: [Bluez PATCH v4 0/3] Expose extended adv feature support via
 bluez API
To:     Daniel Winkler <danielwinkler@google.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Daniel,

On Tue, Mar 16, 2021 at 4:27 PM Daniel Winkler <danielwinkler@google.com> wrote:
>
> Hi Maintainers,
>
> I believe this series fell through the cracks. It is listed on
> patchworks as "Accepted", but I have not been able to find it in the
> tree. I am re-posting it here, please advise if I am mistaken.
>
> This change adds a SupportedFeatures member to the LEAdvertisingManager
> interface, which allows us to expose support for hardware offloading and
> setting TX power on advertisements.
>
> Best,
> Daniel
>
> Changes in v4:
> - Mark SupportedFeatures as experimental
>
> Changes in v3:
> - Rebased onto master
>
> Changes in v2:
> - Expose empty SupportedFeatures if no support available
> - Doc: Expect empty SupportedFeatures if no support available
>
> Daniel Winkler (3):
>   advertising: Add SupportedFeatures to LEAdvertisingManager1
>   client: Add adv SupportedFeatures to bluetoothctl
>   doc/advertising-api: Add adv SupportedFeatures to doc
>
>  client/main.c           |  1 +
>  doc/advertising-api.txt | 18 +++++++++++++++++
>  lib/mgmt.h              |  2 ++
>  src/advertising.c       | 44 +++++++++++++++++++++++++++++++++++++++--
>  4 files changed, 63 insertions(+), 2 deletions(-)
>
> --
> 2.31.0.rc2.261.g7f71774620-goog

Applied, thanks.

-- 
Luiz Augusto von Dentz
