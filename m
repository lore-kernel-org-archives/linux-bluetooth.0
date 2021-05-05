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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE14C433ED
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 May 2021 22:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF2E7613DD
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 May 2021 22:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbhEEWRC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 May 2021 18:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhEEWRC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 May 2021 18:17:02 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCF6C061574
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 May 2021 15:16:03 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id g38so4710302ybi.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 May 2021 15:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lQrHpuL2Pmy6hAbFyOkKLU721YvFiVG0aoX+xwbS1U0=;
        b=s0dqnAtCfI2/RVi9R7jblO3qUc+XTlWxWXpbaWQYhUlLOI0DrWJfU40NVhqprplBh6
         xjn4Fw85xvzSymDHDYhqMBn3uD7Tr1u/u5j1cfqv1kWHm53rHTqohr5XH58yHoj21+Pq
         Lc5nTccQVVHFgK7AAqgS9jcB5QBctQfLa2TdPeFnrqlKn28fUZDJXAt0oz7LHCmII3EQ
         6S+Xwga9aNaYuCaqvjciJ8+xYjf6EkhPGOCkUV7x/odKAJJhy6C1UuxpqsEBqmitJg1T
         LLS7H2wa7m/3w0upvdKcaW0eFGu7vr6cJU++LCb9R7YSYxV06BHGfE6vBlywdOoAnA0e
         bJHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lQrHpuL2Pmy6hAbFyOkKLU721YvFiVG0aoX+xwbS1U0=;
        b=gjY3tDRt2IvJcEmqRiSh8NjQ1AkQfk+U4SshhwNeXzKHl/SOpbFOfKvNVueNT85g1t
         LaFP7mLtzrnyw7bzKodg0PcJw0Ql/l4HNoFxUdRMLPvNYpupSIHByMvV3WGUrG0eq+uD
         38LmMf0z9TAmcQY8/hYj41b3QFnG0rR6I5Iv6BjZR54t/TfTaZaQFzi0z8yJJn/HtgyJ
         M+hlrjD6b7+O+ltGTXkRWWWxcISG7KbJZe3ba32iiHeFWCxtPzI8WZ48Ah+8IhuN3Xo5
         NmkD5jL9e0FnvkZlEycaBa2T3GfjRVhZKUtj5N+lBEUHuvIPguEJLB0FksVolAmBIkPd
         e1VA==
X-Gm-Message-State: AOAM531cnyzDlc2whpE54CHjD/HJxqc+b9cclrqKUKOcpiEo3ypHeVU/
        kpc5zbMRp5mSI1q3CLH7IVx6p2+E4uJE0RfUQeo=
X-Google-Smtp-Source: ABdhPJwiWJ2LjHmNIMJh+I/E+pMMMKsEEOZGVw+FWDYI9UsnzZoSdCO9I6Thm2N57xRcPmzZB8qSEB3a62/sXL/8/PU=
X-Received: by 2002:a25:380b:: with SMTP id f11mr1373822yba.222.1620252962474;
 Wed, 05 May 2021 15:16:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210429111523.Bluez.v1.1.Ic00ed950add081b346d6c8ced590bb7b2eb6e9f7@changeid>
In-Reply-To: <20210429111523.Bluez.v1.1.Ic00ed950add081b346d6c8ced590bb7b2eb6e9f7@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 5 May 2021 15:15:51 -0700
Message-ID: <CABBYNZ+Pk46E_=VXqOOgvawsHE5x7vwLunQBwLQn8nN6_meHZQ@mail.gmail.com>
Subject: Re: [Bluez PATCH v1] doc/mgmt-api - Add a new error code for HCI
 status 0x3e
To:     Yu Liu <yudiliu@google.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Yu,

On Thu, Apr 29, 2021 at 11:15 AM Yu Liu <yudiliu@google.com> wrote:
>
> We want to retry the pairing when HCI status 0x3e (Connection failed to
> established/Synchronization timeout) is returned from the controller.
> This is to add a new MGMT error code so that we can catch this 0x3e
> failure and issue a retry in the user space.
>
> Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> ---
>
> Changes in v1:
> - Initial change
>
>  doc/mgmt-api.txt | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index 5355fedb0..f7cbf7ab2 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -200,6 +200,7 @@ and Command Complete events:
>  0x12   RFKilled
>  0x13   Already Paired
>  0x14   Permission Denied
> +0x15   Connection Not Established
>
>  As a general rule all commands generate the events as specified below,
>  however invalid lengths or unknown commands will always generate a
> @@ -1112,6 +1113,7 @@ Pair Device Command
>                                 Not Powered
>                                 Invalid Index
>                                 Already Paired
> +                               Connection Not Established
>
>
>  Cancel Pair Device Command
> --
> 2.31.1.527.g47e6f16901-goog
>

Applied, thanks.

-- 
Luiz Augusto von Dentz
