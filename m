Return-Path: <SRS0=CDO+=DV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15A5C43457
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Oct 2020 09:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A23620B1F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Oct 2020 09:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6AOGZiE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbgJNJUS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Oct 2020 05:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730747AbgJNJUJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Oct 2020 05:20:09 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB14C08EBB3
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2020 16:45:38 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id t15so1807459otk.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2020 16:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oY+WpNPdUU2YB9GoxXL00jTxAVM7ebz/LhxA6RTa66c=;
        b=b6AOGZiE7KwaWXtz7PlErs09see45bH2GErOUMPJuHxV/4hyipHQS/O4tokqZcvU//
         xRAnh+3JbMwm4kXbjWttnIx7AUIAYUqBwMPVPA9dYjD0xHekViZQKUB1QEfl5xNpzRML
         axQDMPFpxScS8x+Tl5Bvo32p5fZGnccrjhtXn1vG2K+1x3kZU2WEwYekAKLRbcYA8KFT
         Qfiwiq4HuqHi/Aoq5bARZkixeHu/8icPXddeGS601SSLxcKd9TpJbUaZ9wc6s+heGRM2
         XnE9+uUAyWzqtILMCi/c2Tq7fl97jy+nmKJAp64bm4G0oAHXIw9wnDne2qfKbloI1qkU
         sDYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oY+WpNPdUU2YB9GoxXL00jTxAVM7ebz/LhxA6RTa66c=;
        b=VqC/My3N8dvM3nINjL9aG16mO+/SsGzUJZMMcGXTEKdIX3kA1knrxU06AQLlkHSAWW
         t25pe9pq6Q+pV3rEoYUMqwxaXFt1eanFl7WLAdaDVR1UAHkNyA+KUoVHIBu+DTsN2TqP
         7eSiX4xf0E+bRkcZ4fIGQsz+HLA3tVnKyz8uPlxVNv9OApaXpdn6gnBRud1Py5ubJIWe
         mgbTN5r/s4XaW4yHLiXztVFm39EGd3P5K7i0V/L2E3POrWXib/jIj2oVGFhy3UeQbMfm
         JP1GuRCVlXixO+R0PgJAaBxBK/Uh5HllEGmKi4NqGMRqvznr8mRRL8aghQPHqj94x8Ze
         xZkA==
X-Gm-Message-State: AOAM532licu3H2Js1RJQ6o7CKDZJEvIH2JNs0Lk306ymRVKyxRture88
        QY+zlWYpwxySjomA5y2b1Oh4aDtXKC4HlyNiV7c=
X-Google-Smtp-Source: ABdhPJwZwMgfuEewpaHT4NmDhpGM+0Z/tVzp2G0A1JhkKOb7VUshnkQ2N/USgy6oWZVpmobp4dfiNOphZIfnggT3B6g=
X-Received: by 2002:a05:6830:134c:: with SMTP id r12mr1475859otq.240.1602632738175;
 Tue, 13 Oct 2020 16:45:38 -0700 (PDT)
MIME-Version: 1.0
References: <20201006171333.BlueZ.v6.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
 <20201006171333.BlueZ.v6.2.I578ae5e76fcf7243206a27d4f5a25783662a5f14@changeid>
 <CABBYNZ+pmByP5WMibCGQJXTvy7ephJdJdALg=mYagzAjWMLk9w@mail.gmail.com> <CABmPvSE17drmxua9MopjH1yYS0-9Lu0UL9wmcFXCpMC06vC99A@mail.gmail.com>
In-Reply-To: <CABmPvSE17drmxua9MopjH1yYS0-9Lu0UL9wmcFXCpMC06vC99A@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 13 Oct 2020 16:45:24 -0700
Message-ID: <CABBYNZJpJneZED3wY7yQvKeHKF2HM2KmJ3UYL9O+GAA=yhu3Vg@mail.gmail.com>
Subject: Re: [BlueZ PATCH v6 2/6] adv_monitor: Implement Adv matching based on
 stored monitors
To:     Miao-chen Chou <mcchou@chromium.org>
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Howard Chung <howardchung@google.com>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Alain Michaud <alainm@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Manish Mandlik <mmandlik@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Miao-chen,

On Mon, Oct 12, 2020 at 2:21 PM Miao-chen Chou <mcchou@chromium.org> wrote:
>
> Hi Luiz,
>
> I did think of adding pattern to bt_ad at the beginning, but here are
> reasons why I ended up with hosting the definition of pattern in
> adv_monitor.
> (1)  Pattern is specific to monitoring purpose. An advertisement
> should not include patterns as its fields due to that fact that a
> pattern hosts an offset. So I wasn't sure about its justification to
> be placed in shared/ad. But if you foresee that it would be reused,
> then I am more than happy to add it to shared/ad.
> (2) Introducing helpers as you suggested below indeed make it more
> unittestable. However, it also implied that EIR data (this is in fact
> AD data) needs to be parsed into a new bt_ad for pattern comparison,
> and I didn't see an obvious benefit of converting EIR data into a
> bt_ad just for the comparison.

Regarding (1) like I said you will need another struct to store the
offset and length for doing the pattern matching but otherwise it is
pretty similar, regarding (2) there is actually a real benefit that we
could in the future drop the eir_ helpers and unit test just the bt_ad
including pattern matching as well.

> Maybe we can add a struct bt_ad_pattern in shared/ad.h and introduce
> the following two functions. What do you think?
>
> struct bt_ad_pattern *bt_ad_pattern_new(uint8_t type, size_t offset,
> size_t len, const void *data);

Not sure I follow you here, that doesn't seem to be about the parsing
of the AD but the creation of an object for matching, not sure we need
that since you can probably just pass a stack variable directly, in
any case you would need a free as well.

> /* |data| is one single AD data field so that we can avoid converting
> EIR data to bt_ad */
> bool bt_ad_pattern bt_ad_pattern_match(struct bt_ad_pattern *pattern,
> void *data, size_t len);

You may have more than one entry of the same type, anyway if we do
have something like bt_ad_new_with_data that means we can pass it
around and not have to reparse it when doing custom filtering. We
might as well have a callback that does get called every time there is
a match, also it may be possible to pass all the pattern at once in
which case we can pass the pattern which matched along with the data
thus having the call it multiple times for each monitor.
