Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4B3C2D0E4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Nov 2020 21:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D397120866
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Nov 2020 21:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntlW1oIk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbgKXVXR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Nov 2020 16:23:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbgKXVXQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Nov 2020 16:23:16 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA93C0613D6
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2020 13:23:15 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id 92so237880otd.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2020 13:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=XFTKa3Sarm/U5ipllDcaNQa2oUcFnodRQ2+PGExJ8ko=;
        b=ntlW1oIkBff+Z7YDRqQz9OUGGncFwMWthE+Or+vK0igYUIk/i1Jq/TijLmBIXptRG5
         uM3Hrkp4Fbz6A0mpeo1apy4/O31XtqEROULxH9HoSbKzF13bj9JKikUUtq6yiqLha5qg
         kR34uQdOu4PFx+vj0fYT96I1axqMNApvs/aLzTZ09l9eMzrKjc9HtbdYt5bx/LNdNEl2
         H4QoRGWsYHIxgQKpHugIeIFai6F5T2fSYfm/apwPfSX+r9Iwc+YVfbW3rX07xenvFwFy
         YkxB5lkkLrAqye90XIlA4jAPrE1Q7AdospzHnHZWHfAJEQ4RoUGHVMhFfBVqd57st/VS
         5urg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=XFTKa3Sarm/U5ipllDcaNQa2oUcFnodRQ2+PGExJ8ko=;
        b=jPAPTnZKbyAALd8QNMo9khG72wyiQV2glrWhafDPBP76fkUCRMjCgzJy+ZkOShwEX1
         cEoXSFq8TgLPAcm/2l934CpiMg1acFJOpEAvyY69E0gmdhE9yKvcu/TF9fAWSS5AudQ9
         Gf5pBYDPr1ViyZgBm1VDkyzF6DinMkjpxlxluJpg/cBJq47yBx+DM6Nn0QJ2MhPTqxm0
         ONkH+kCPTww8XQIUojgWc/6qjvJhe9g0Er44TzIeookVuGuguNs2JLiutbRxdN71HE/c
         BwrRf6+U8n8wM3slEiE6wJKr0Xljv4jzPezgeIRPi22FasesZjKW+DDJt5G0Ec9unRHv
         cmkw==
X-Gm-Message-State: AOAM530/+AMkWVseQv9QYMb9ItOWCpJBFWd+0CsnBETtQSVHogWdgnZb
        +dNUl1Yy5bKu1TEwSFYojY3g+F4MlZSaJsKE1rzjbZiZ
X-Google-Smtp-Source: ABdhPJylY9MAyj1SEPozI/CzBeX0rJxtaZjXU1pVq0XLOVzU2OaJwxfRgTWQDLXEU46qJmE9zlat7SAOtKFUe4bwDzE=
X-Received: by 2002:a05:6830:18f8:: with SMTP id d24mr488504otf.44.1606252992930;
 Tue, 24 Nov 2020 13:23:12 -0800 (PST)
MIME-Version: 1.0
References: <20201123183440.433677-1-luiz.dentz@gmail.com> <5fbc0467.1c69fb81.1d1e.7124@mx.google.com>
In-Reply-To: <5fbc0467.1c69fb81.1d1e.7124@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 24 Nov 2020 13:23:02 -0800
Message-ID: <CABBYNZ+t6g=qEeh8CDs1U9Lt94dvpY_9kArYkdPQY85zJaV1CA@mail.gmail.com>
Subject: Re: [BlueZ,1/2] a2dp: Fix crash when SEP codec has not been initialized
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Mon, Nov 23, 2020 at 10:50 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=389671
>
> ---Test result---
>
> ##############################
> Test: CheckPatch - PASS
>
> ##############################
> Test: CheckGitLint - PASS
>
> ##############################
> Test: CheckBuild - PASS
>
> ##############################
> Test: MakeCheck - PASS
>
>
>
> ---
> Regards,
> Linux Bluetooth

Pushed.

-- 
Luiz Augusto von Dentz
