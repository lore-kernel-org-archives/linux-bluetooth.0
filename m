Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C63C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jan 2022 02:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345164AbiA1CCG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Jan 2022 21:02:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235461AbiA1CCF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Jan 2022 21:02:05 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8071DC061714
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jan 2022 18:02:05 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id r65so14096555ybc.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jan 2022 18:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=oC7Ad1lc/1/ZaO8YTf/Bj/OQhEtjZzmXZFKV4qpcxTU=;
        b=j9EyWxCAcFICUpYq1dqzFYDODPYHvlJpFZeAjS7gLf60QDht7xe332QG6VdzSjyfsY
         7sEEMsFHHzyGZKW0ZIL7I624uyiGA71lZoV5uoQHfH1R2x6u3CJ7MFhrMEeTHG+1XvBe
         v7PRsQFQ6OWHMo174487JLAOhyGT87H4BbvdpCD2SO5Jw+xTgS5F+cpm6EmViaEe9BNt
         Xq6QG87eCz/GHA+O1/TlvyKwXyzsz7j9LDs+Xhdz1P5QluZzmghUnfZLqLYS7cz03EZq
         3kOm40aaG5Ui+ZHaxpX0B5IxRxCB4jbbDgOJpCgZ6ZcqH8poRiwnHgZuBLDlSgTb1iz9
         tOXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=oC7Ad1lc/1/ZaO8YTf/Bj/OQhEtjZzmXZFKV4qpcxTU=;
        b=PV/bC4Zr/ED9zgwwKgaGz497sgqPSbdtxUh3BgYhJuHKGwc6uVF+IR5ZgFkeGrVw9w
         6lG1gsBmBA5oYOBaVvPe0Ady9am3mElzVqbRDU/l4t/wrVKCJsLVxtN7QYKBRKlQQ7zi
         pa6hAhmSsklvD5M6HsweZs9QgrQvGUCHdiERLyL6DPeNQgpJnkMJbw1MnkL/A1xzIJRb
         bQ61BIzRUkJYpju70jTCXDI5jPypHzlNGLvNAD0ss+IbE4X7aVYa7BXYmC2NWXRktfQH
         ZSRxxVyiKEZa8+rN5NO51rgjgBmB0LPLL3BNtN99iLBuG4MYGz7OJ93d+GeXcfQYvTEf
         jg+g==
X-Gm-Message-State: AOAM531aFXXDSAnMy5ayusyTgK5F1TkN0B5098ceKqTBQdyRjknpHOlv
        52i9QBfaawfmHC5+Mmv7jIfaelmS2gE2+G8uqOqhYJI7DZg=
X-Google-Smtp-Source: ABdhPJxHssULtBMd5AY1aBpW2Equ8aAcOanMWBgTjFrZh1JmWVDTQepDwsJWRYol8w3YsvRsD+abfUaKEY4yGoAbtSI=
X-Received: by 2002:a25:3415:: with SMTP id b21mr9247936yba.573.1643335324190;
 Thu, 27 Jan 2022 18:02:04 -0800 (PST)
MIME-Version: 1.0
References: <20220127010327.3087364-1-luiz.dentz@gmail.com> <61f201fa.1c69fb81.9b4f9.4268@mx.google.com>
In-Reply-To: <61f201fa.1c69fb81.9b4f9.4268@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 27 Jan 2022 18:01:53 -0800
Message-ID: <CABBYNZKeLe8ExPyPmAHU6k0acMnX9Gkt9RiQ_UEts6Nj+ZdiAA@mail.gmail.com>
Subject: Re: [BlueZ] btdev: Add implementation for BT_HCI_CMD_LE_TERM_BIG
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Wed, Jan 26, 2022 at 6:22 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=608881
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      1.42 seconds
> GitLint                       PASS      0.99 seconds
> Prep - Setup ELL              PASS      51.48 seconds
> Build - Prep                  PASS      0.78 seconds
> Build - Configure             PASS      10.14 seconds
> Build - Make                  PASS      1502.48 seconds
> Make Check                    PASS      12.33 seconds
> Make Check w/Valgrind         PASS      535.54 seconds
> Make Distcheck                PASS      279.31 seconds
> Build w/ext ELL - Configure   PASS      10.27 seconds
> Build w/ext ELL - Make        PASS      1437.51 seconds
> Incremental Build with patchesPASS      0.00 seconds
>
>
>
> ---
> Regards,
> Linux Bluetooth

Pushed.

-- 
Luiz Augusto von Dentz
