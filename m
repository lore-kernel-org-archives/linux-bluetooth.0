Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=3.0 tests=BAYES_50,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F1BC2D0E4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Nov 2020 06:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA6BC20665
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Nov 2020 06:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="syB+nrle"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbgK0GqD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Nov 2020 01:46:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbgK0GqD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Nov 2020 01:46:03 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3046BC0613D1
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2020 22:46:03 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id r127so3616276yba.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2020 22:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=WALeqsL76Un8+1Eh4GoR+ZAaIeT87LV5iyhfMdDTM/E=;
        b=syB+nrle0u8/8AMD5l9pI7/FQ2Kl2cnt40YJqMppDNMk1hVS2y8R0UgTeaEzS2vaUO
         K+TxrKidj3EjpFHMA9nHSMGfEttRy/jsBfZQZBmgLEOwhtQssveOEUE+25BOYYeOMzd4
         oObQTx2PAD+onKS9VLkVSniBBLwFdostFVPAGxkYw1b9u/MXCZObQ25TNGkKy6taQgtJ
         GDEP9ddPrIgLbiDqjHyxazJ+5zIYwOCFqHIinmZamNJ4QpiDmvtMvJNZmNqh3decCS/W
         2dPhby9wOmyzcj/qn77L7Oie5i8UJ+kY3d9SJRRrBaMRX4M5JzsEotd5GdLb9wJ4IAoX
         zrgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=WALeqsL76Un8+1Eh4GoR+ZAaIeT87LV5iyhfMdDTM/E=;
        b=kNeM/4zOXhp5UEP3wLzWfVg46G0SV2Tw8P8kUkBFcPJ7vpAr5Hn1WS97atzSBZdqu8
         zkvqPus9lwZk0P+lABycleFCgtDH51LoV3kG6dhbGCbIJTeGibKLYXxEuyVYqhM3/GK9
         UUO7KAwngXryXlu4KVmUjxt7CCjO7HOidIyLlFPSL19uN72N5X8PQYcvqSsuCrpXkIeX
         fPDhy4xmTZ9NfXfjOxGtI2jjWjlpC1QOiBuNS/jI5+GkKcCKY+b7tji0q7rGfpXpEuuh
         Nf1FZZ/PgIq7L/1fzLyRS9p7SsYsJjl1XwU30RehjBw4U7mhrO8lEgc4xVcIiDQqm0cY
         GS4w==
X-Gm-Message-State: AOAM533s2vbgBToUwLEy4p2rm/T5Ltc40nb4ZlvIqGIW66A9YTk4hrpx
        269rCrawborvMVBYKg2z9nS/BUBHVuNKiJt83N0OHZEe9tVgTg==
X-Google-Smtp-Source: ABdhPJwfsrVEylCMOavcLAwgMTpr9G9IWAtdUVTOPc+5qUTjCUoeNCRavGx/fkkAPNtd74sXBg+sMrLIGiM8mM+k6Eo=
X-Received: by 2002:a25:b814:: with SMTP id v20mr10712251ybj.323.1606459561855;
 Thu, 26 Nov 2020 22:46:01 -0800 (PST)
MIME-Version: 1.0
From:   C K <choongbeom@gmail.com>
Date:   Fri, 27 Nov 2020 15:45:51 +0900
Message-ID: <CAO9gXyRLOk75wdTWO_cAu1e=w82H1b_fWB=hLpHcJYcv2MHQDg@mail.gmail.com>
Subject: =?UTF-8?Q?BlueZ_=E2=80=9CPin_or_Key_missing=E2=80=9D_occurred_even_though_?=
        =?UTF-8?Q?it_has_already_been_paired?=
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,
I have an issue with my bluez device.
I explained it on stackover flow.
Help me about this please.

https://stackoverflow.com/questions/65001891/bluez-pin-or-key-missing-occurred-even-though-it-has-already-been-paired


Thanks,
Calvin
