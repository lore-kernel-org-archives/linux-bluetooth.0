Return-Path: <SRS0=5U9h=TX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF39C04AAC
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 May 2019 05:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BAAD20881
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 May 2019 05:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=orcam.com header.i=@orcam.com header.b="G3e4eS73"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725814AbfEWFB5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 May 2019 01:01:57 -0400
Received: from mail-it1-f177.google.com ([209.85.166.177]:55529 "EHLO
        mail-it1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbfEWFB5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 May 2019 01:01:57 -0400
Received: by mail-it1-f177.google.com with SMTP id g24so620070iti.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 May 2019 22:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=orcam.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=C3YNwHBPpN/3o9lMqMjvGGD3UlCg5M0ySs1gfCHX4gk=;
        b=G3e4eS735Ax+86OwS+/ihjGnbcsclC3S1maIceAs4zz3Je3+n9v4tlZXT7xRbhDR7r
         PtYvI6C+D0oHJ/4115QoaE5lweIgAlKEmbnZrsK4lLWH8M4j3wrglv9VkGW52OM6YRms
         ioxidB8Lywy88cbVainRqSz1bbzc/Mjs/sThY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=C3YNwHBPpN/3o9lMqMjvGGD3UlCg5M0ySs1gfCHX4gk=;
        b=Mi8MobSgJoFABhzcgNfCpS1ekXi1sdgXAAvUr5f0q4LTvto81GTZb7lnbUVPObCLWF
         JsLvQLt+XqS+MzC0ugSvF8oUawsGeoZ43o1vwpVO3VwAIaKy80A6NgIdcSSpj+oi7B0Z
         LpNIpa8D0sdiw5KuBy69ymx+h+5kmop1cYyRZu8CqyLr4YXzgvP70Zdg/cJr5RM91SrV
         9KtHCqEehCzah9DG5+0if597pcfVu7kWwFqvo7gag8tBv9N3vUi4lztkeFt6jFS/V/7U
         YwjSQFjMNxNSL4j7Ta6nzHhMKmaC7il/lXejYjKqzyqWPA3MkKFiRSYYhK/b/qjcQuc4
         4b5A==
X-Gm-Message-State: APjAAAVMgqrvtbxfz9B5g0RNyFe706A1OB2tZilBJNi+LaAnAoLg17u9
        xIUEUGWmUxs8NH213ZrNK42v8w5jJZUoDFUFAb6x07EzO0o=
X-Google-Smtp-Source: APXvYqxGwftN2ihnDfehl4VpqGGVQFv7lNSTH5WxiNCAmPI371Lvche2blYQ4xsle0efykxgVvOIzgFxVpfrI3Oksn4=
X-Received: by 2002:a24:6294:: with SMTP id d142mr11869540itc.102.1558587716081;
 Wed, 22 May 2019 22:01:56 -0700 (PDT)
MIME-Version: 1.0
From:   Ordit Gross <ordit.gross@orcam.com>
Date:   Thu, 23 May 2019 08:01:45 +0300
Message-ID: <CAB+bgRa-YE9oFP0bTHd9BCO+C4VudHH_eTNf9Xn-14VrUVT6-A@mail.gmail.com>
Subject: failed Message Integrity Check (MIC)
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

hi all,
we have an application acting as gatt server, using bluez 5.47.
we just purchased a sniffer.
** when a client connects (mobile), I can see pairing (AES) process
taking place, all encrypted packets that follow show up as decrypted
incorrectly (bad MIC), but no disconnection occur.

** connecting to a specific phone (android LG G6), after pairing takes
place we see several encrypted packets that show up as decrypted
incorrectly (bad MIC), then connection is dropped with "Connection
Terminated due to MIC Failure (0x3d)"
Device Disconnected:  reason 0

1. Is MIC being calculated in bluez? is kernel involved in this process?
2. How could it be other devices don't drop the connection?
I'm having a hard time understanding how could that problem arise..
and how to solve this..
any help would be appreciated
