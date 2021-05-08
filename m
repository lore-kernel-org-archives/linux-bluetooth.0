Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90125C433ED
	for <linux-bluetooth@archiver.kernel.org>; Sat,  8 May 2021 07:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C981610FC
	for <linux-bluetooth@archiver.kernel.org>; Sat,  8 May 2021 07:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbhEHHPv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 8 May 2021 03:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbhEHHPt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 8 May 2021 03:15:49 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9082CC061574
        for <linux-bluetooth@vger.kernel.org>; Sat,  8 May 2021 00:14:43 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id g15-20020a9d128f0000b02902a7d7a7bb6eso9905954otg.9
        for <linux-bluetooth@vger.kernel.org>; Sat, 08 May 2021 00:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=/TY5wAtiJesYNRgb4BaK90nKO3ODMyJ/mxopBzcw8Vk=;
        b=Q7tlRmA/LEj8fF/daB+TRZR4HO/xLCVupouwZnvln5G8AFL7OPBZiLYN8pY4c5LaFG
         V5MLwErS5l3hDYgLYGbxkPPrfHJsoZO40PGxoAapMzh/diH5t+3pnaJO3TgMwt+mGFqd
         pQa8xgk3maiP5MLxskbiaWRqv3ygjC9/6TziMvLTcldB7gRIjTOzcS1Lg3K1txP1PPkJ
         956YvNrXaDMdiwM1ObpgVKzCL4vGyuxut5ywRrSwO4dbOz1+kRo3f4S4JRvDYPkrU4j5
         BfABDayeETVyCd6E9x3dePLJXjZq4lbTaqN/n6ZKZRBEUu2SNn/zAPG0xm8g/GCyxSGj
         0gRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=/TY5wAtiJesYNRgb4BaK90nKO3ODMyJ/mxopBzcw8Vk=;
        b=dUPmpUyu5AnkPJbRkFooNPzLTBzjHrfxl48d/5to8GW0Hb8nsk4PgxpB2KHOOwCa//
         JzzVHZ2TEbr+T1669o0In9JCYmAorYyA+DsR1IuDgEywJtzuQZNa7HdDvgT0qx+HnnW6
         tBtSSSt8zebnRwPCqEUbvUxUG0BEnyTKnF4qdzO0U1vzESZmXBv91EL3ro7GKMpw9LO9
         is8jLwReAcn42RYygDxyHHLn2sRxW5QC10EC18Fg+K85DrF+qsJCIOEYp7mOLRQ44d8J
         6/0fckqMgdPSVGzXZ5VcCO1NNvsE58kSFB55i6occBVnQ/vfTbcEdsyNBYdPrc+nC+70
         LvZQ==
X-Gm-Message-State: AOAM530Vit3V3IMNzQzDkeQh2ofQF8qywq+/GlgVUEVfmArhyiszF58Y
        ab8sdc+y1uszCQoLxFefhU4DcmgNQXTNWMLbkaB9P3gggktlbw==
X-Google-Smtp-Source: ABdhPJzfIfji7+CyZmZxwm3ScPrE0Cbo0BETiVsdbEslsleTHb6xeTii8eKrf3PhxCUQ7KevzSuPq+/Id9u3t8UqZbY=
X-Received: by 2002:a05:6830:1c67:: with SMTP id s7mr4028810otg.197.1620458082943;
 Sat, 08 May 2021 00:14:42 -0700 (PDT)
MIME-Version: 1.0
From:   Jim Guo <jimmygc2008@gmail.com>
Date:   Sat, 8 May 2021 15:14:31 +0800
Message-ID: <CAG9eTxRD=94RBScCOq9CM=nrcv_zDGy4Y6Xi7UP569-CY+vNZQ@mail.gmail.com>
Subject: IO hang when cache do not have enough buckets on small SSD
To:     colyli@suse.de
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Recently I was experiencing frequent io hang when testing with fio
with 4K random write. Fio iops dropped  to 0 for about 20 seconds
every several minutes.
After some debugging, I discovered that it is the incremental gc that
cause this problem.
My cache disk is relatively small (375GiB with 4K block size and 512K
bucket size), backing hdds are 4 x 1 TiB. I cannot reproduce this on
another environment with bigger cache disk.
When running 4K random write fio bench, the buckets are consumed  very
quickly and soon it has to invalidate some bucket (this happens quite
often). Since the cache disk is small, a lot of write io will soon
reach sectors_to_gc and trigger gc thread. Write io will also increase
search_inflight, which cause gc thread to sleep for 100ms. This will
cause gc procedure to execute for a long time, and invalidating bucket
for the write io will wait for the whole gc procedure.
After removing the 100ms sleep from the incremental gc patch,  the io
never hang any more.
I think for small ssd, sleeping for 100ms seems too long or maybe
write io should not trigger gc thread to sleep for 100ms?
