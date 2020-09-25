Return-Path: <SRS0=+RU5=DC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD234C4363D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Sep 2020 14:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53AF7208A9
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Sep 2020 14:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.ucsb.edu header.i=@cs.ucsb.edu header.b="SjEMXYh8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbgIYOYG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 25 Sep 2020 10:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728038AbgIYOYG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 25 Sep 2020 10:24:06 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58ECCC0613CE
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2020 07:24:06 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id x22so3326348pfo.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2020 07:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.ucsb.edu; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=fedzgpVCODKePaPqsYhwD3C7tjf1tq1jAckCWIf5aSQ=;
        b=SjEMXYh8GO/IkobYD53IZ/LCvEDHSW7b7J9baJrQ5znlUUmqzviAfoybotxiv6frLh
         2L6nIndoW71Co+Qsgf/NZxykQDowaBatiqQUsWV1Lrd5EKqBJ+MR16+DMQ39A4ma+aFX
         h9UQWqpyaE0qz39mCHrX9NLx9fEJhjnrxKr02uEzHUuRCkFq0OAAIjQtYiBlmDe17JCR
         bu7FZ7JSwYnRq7Xqcj/i8gs7ieO8ej12Vv/WB/CQTu7JxiewR4uMZcMMbEm2q8RuHamX
         Bakb7KfsXh4KvEYBpDXnD3NV2VuIzkOPCgFil1BaX+Sn6gGatbC49hML5lmEhEOeFL6b
         f1tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=fedzgpVCODKePaPqsYhwD3C7tjf1tq1jAckCWIf5aSQ=;
        b=JZrF1U17UpTJkjGv4sY1m1t4x4I5GbGzPrUDNz9ynxyqu4Ch788bbmLxZrsetmok4d
         EnTMbJF8DyPB49cxos3C+Fdwp/njykW+M7jeYRJyigppve8QF5N7RTZJoPnMV1XSXuy6
         33rq305PE0DDg6ivlrDLqLV5qILe5qC60cyf+b1MtiY+pJ31Mmy4gL9i/xRtDE1UixNd
         2V3O49cBz4Wdn//4alLbjMQpMolgh9n8vc2qmYKguBhJE7lIqwW3UqnnqvxCHW8LtJ/k
         +swoAIMb3u84pUvMEcHKERr2N7Flz8WeWEdMK85VfyC9+tmThlsg0W9rJrNQOizkWK8T
         6x7Q==
X-Gm-Message-State: AOAM531niOwtpUBQlWXiBWYJKVlojCMuME2USKYzMK0ohf8PAlorYSen
        9Y2ePm8re63z3S7AIEjIHQazZp0C0bkxhawF7Bev/KYqjSa2oA==
X-Google-Smtp-Source: ABdhPJy+dG2IFUBQKyT56jzDyVhW0st6LH31rsL1eGfbsNEWGNIOSxXylYBEBY5qQYS8rxKulLgvPxLjylatz5kKl74=
X-Received: by 2002:a62:dd02:0:b029:142:2501:398c with SMTP id
 w2-20020a62dd020000b02901422501398cmr4205981pff.81.1601043845364; Fri, 25 Sep
 2020 07:24:05 -0700 (PDT)
MIME-Version: 1.0
From:   Aravind Machiry <machiry@cs.ucsb.edu>
Date:   Fri, 25 Sep 2020 07:23:54 -0700
Message-ID: <CANozA0gGok3nJgVJehz6tS3iEXDGzd9Rj1QFN=w_xBA5OS-2LA@mail.gmail.com>
Subject: Submitting patches to user land components
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

Is this the right mailing list to submit patches to bluez user-space components?

Thanks in advance.

-Best,
Aravind
