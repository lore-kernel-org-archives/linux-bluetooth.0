Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB91C433B4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 May 2021 15:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1119E610CD
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 May 2021 15:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbhESPJw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 May 2021 11:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348800AbhESPJv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 May 2021 11:09:51 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D251C061761
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 May 2021 08:08:32 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id w127so9565869oig.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 May 2021 08:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=VC6s8rTvA0vVke6bqqPNKY2liciGfB3txpxsh1BwOU8=;
        b=gN31m069/hF1heToGXZuUNep4wD1423ByLyEcZQJqjZWT53Igijv7ppxK/o+Xw4lUu
         dFhCDt0f4TQE4rzT/WCGNCb/9Kpt/GfyMTXAKp51Ol1f3AijVmL22QNcNmeXvKAziADs
         TRtHYvPlT0WQvwhM8jsRcBLYtJs/1u2wq/DzQ037LmwVgA0KDMIR56VkLBHQFg5PECQi
         4nLMZx0l65q2DnKIU5CX7b4IXzmVT0nDQamPvdRHgvWIP9SzjIBDARtMAQFnMfKWWaf2
         TvN4qGQeyazmTksHDQi9hW/z2KfwISAdNOtQRzPyZb7fEHDqJ8oAPsFO0ZshuU61iDm0
         LGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=VC6s8rTvA0vVke6bqqPNKY2liciGfB3txpxsh1BwOU8=;
        b=jkvOHloZvNq6yRlibdVeoeUInF29IGYQ++l1WkBpvRmNGkUX3GTRs5xEUfTlcXc9Gv
         t8e3+XAWTPpNC5Lw5vfwuZRflU/bwpQ+PWFVEvvHAgXl5SJQVpiC1O0MEZ4qpLrI/N1A
         9ip57ldt0o/l6DqWUyMbm4NUik+5ku0YHo6C2I8jTQ0ZpcvVH6DTPclYsyK4QsDNwAgX
         a25VOaoXdagyvXRx5wxMA5rEgi2s78+sHsWeRGdx9TaMk+8VLodtzHqTFtXe7gOFIjfF
         loW9wxLCuLegnSHLzt0n2QVEaQzXT9c5rkq4IiEni5RfGQpCvTWjw2cNUB5aGj/+ndbh
         uHhw==
X-Gm-Message-State: AOAM532uqAN3I/USD0+xjTN0ik8xJXzTjLFlsEhvuqr/1JtQOdxFvnef
        UhDJ5WRhIc4CeoH7elWo69PBHdk+2qjKPvwN52Ek7WhJKxA=
X-Google-Smtp-Source: ABdhPJzJyjdZ+dBrLrjf49Bpix0OW2cGvbwOkLKI+rpLPcD1vJcUByBVfQlTTAeThHHx2s/6v2EgcA+a7yznyP9hPwI=
X-Received: by 2002:a05:6808:8c6:: with SMTP id k6mr8279989oij.55.1621436911333;
 Wed, 19 May 2021 08:08:31 -0700 (PDT)
MIME-Version: 1.0
From:   KeithG <ys3al35l@gmail.com>
Date:   Wed, 19 May 2021 10:08:20 -0500
Message-ID: <CAG17S_ND46_G0bC00T5K7zhEUE6e9Etab5Re-YrSnsAdqwTp4Q@mail.gmail.com>
Subject: Keyboard paring failures, still
To:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Still struggling with this. I have posted here
https://github.com/bluez/bluez/issues/55 as well. I cannot figure out
why/how it eventually pairs, but I have to type in the provided code
many many times and then inexplicably it pairs. The latest Arch
package is 5.58. I have also built the latest from git and get the
same thing. There was a comment that maybe a couple commits seemed to
fix it for another user, but not for me. Is there anything I can do to
help get this resolved? It is pretty strange that I can pair a phone
for audio, but not a keyboard, one of the earliest BT devices... It
does not seem to be the particular keyboard. I've tried 2 different
ones and get eh same result: Failed to pair:
org.bluez.Error.AuthenticationFailed

Keith
