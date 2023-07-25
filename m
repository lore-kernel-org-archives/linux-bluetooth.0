Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644D0C001DF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Jul 2023 13:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjGYNcR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Jul 2023 09:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbjGYNcQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Jul 2023 09:32:16 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B761BC3
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jul 2023 06:32:14 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b96789d574so76593111fa.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jul 2023 06:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690291933; x=1690896733;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0Eo5FpiwXwtBY77ip4TqwvVlUbqb49/1Uq3/iXzSAV4=;
        b=eqM3fHZUlWMtVxSGTXBIGHocR/hgDYy9fOKrvNW6lTPT0GKaKLJZj8Nnidy0bGN/cG
         N7NhLhCpJ28K63vbLoJvAQ6YMGVXlaclUKUHwB/oadRvULsfrT103ikdIz2grBEioR/z
         UijMtqK1Yf7WhfqT8nmStTag3ECC3bSmf2XxgX3SEDW2gE3EwA4FdkMbE2vbLOE3UjPh
         fa8G4fc/LTA1nKU3wzte/zs36RrvuJFiSUUBWTb/lQ0m6v23TpNNliRtkkbvwii0Lewp
         Dy6UO//zKqKpYdkZemzwV3fBmnyfJnmlONk5Mm7nPIhlQ/5Qqz9r2rimENjRrp+Oedm+
         ihJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690291933; x=1690896733;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Eo5FpiwXwtBY77ip4TqwvVlUbqb49/1Uq3/iXzSAV4=;
        b=IXTBPaTnLNl0mQjziSTZCoKqlDAx9l9E6LJd/AZGycpUViQa8plTHPdxYzGoVHpQMN
         rkfMnezFIjvwu42bFUFIaQ1LcM2/4sYpRv48yFZfUxe6T8hphHwncEDZsBrV1mGODGxO
         oh558yLB6JhmcB3mbFOb4QWepptX0uCHh1lzd+lOhXrXw4kImAOhE/PNOgk3LnIpnSrL
         b0bAx3BZehgaJpCHBOG0EfXyyhwJdf9LfK3ZGQ/xRTLrZvRHxUa7xbiu56N1zNLzkz9z
         TvorEDS8sOpqgiiC+DXVYfWEZlozaYMj7dYiyLq00MnhIe93SVTHVbapJg7MTJjMMRxG
         BOfQ==
X-Gm-Message-State: ABy/qLbsLb9A6eDNG230ugjcZwnwdGY++xctHSMcMxxvPnyw2ytLGHd5
        FHyUq56YSdos21qvOJCc4y18ehxetrTnZtGJBPOzOqyGEiq6rA==
X-Google-Smtp-Source: APBJJlHu/iRuBpxOzzwMiEb+go1VW3C13/i8ONH95Morythhp2yLZJNxvf9D4zb4H/I9l8RnSx7PXwXh2o8dxAkAQTE=
X-Received: by 2002:a2e:9894:0:b0:2b9:ad7d:a144 with SMTP id
 b20-20020a2e9894000000b002b9ad7da144mr400738ljj.11.1690291932683; Tue, 25 Jul
 2023 06:32:12 -0700 (PDT)
MIME-Version: 1.0
From:   Stefnotch <brandmairstefan@gmail.com>
Date:   Tue, 25 Jul 2023 15:31:35 +0200
Message-ID: <CAAvW=MyYArpr-bpiHkHjrqmkGsiSpMqyAivbMCLepV1HajyAzA@mail.gmail.com>
Subject: Bluetooth for hearing aids support (ASHA)
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello

I have hearing aids, which can be connected to devices that support
the Bluetooth ASHA protocol.
https://source.android.com/docs/core/connect/bluetooth/asha
That protocol is open and somewhat well documented. However, it is
only supported on Android devices at the moment. BlueZ on Linux does
not appear to support it.

The idea is with Bluetooth ASHA, one can stream audio from a computer
directly to a pair of hearing aids. Without Bluetooth ASHA, I'm
limited to using a battery powered, clumsy accessory from Cochlear.

 I was wondering if it would be worthwhile to support that in BlueZ.

For the record, this has been requested in the past, but hasn't
progressed any further.
https://www.reddit.com/r/linuxquestions/comments/l54zku/accessibility_for_the_deaf/
https://github.com/bluez/bluez/issues/481

kind regards
