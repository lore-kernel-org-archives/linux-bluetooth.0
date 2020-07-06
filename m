Return-Path: <SRS0=7cy9=AR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E4BC433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Jul 2020 13:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CEE220702
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Jul 2020 13:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PrO9XmIt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbgGFNsP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Jul 2020 09:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729109AbgGFNsO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Jul 2020 09:48:14 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F0BC061755
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Jul 2020 06:48:13 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id h17so1285997qvr.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Jul 2020 06:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=SJj/JvBPbNhbHyJm/9hDgOHzKrUjF4dRqvNCzuVKegE=;
        b=PrO9XmItLYJZ+8Ggre51FsCbathoDhq2k08KS+edj6FjEicFyBNmy1iQ40Q9JqeEwt
         SqTYNEqXDYPlX48v5LCqbWvKQmGSBfACM0/B7PDRqQTvE1oI8NOusKTuycZBcGGX6lkG
         NoToffZhDljH5lq4Pg4xGeSgWOXvrRZztLYlkO8br+3V48v6L83z7KiB1ogA3APa5Jxi
         uw/dvaOQZhqonppcUOzELSqz+/fG/PFH8oQdOok10e2Oem2NhGIRlnyf98YGhxRYq4IB
         CemyPPWxHYZ440Geyimv5LHHJzFauete94ld+PGGNJ8eTGsCPeDbwFPHJ9RpH5Kt0BDb
         KA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=SJj/JvBPbNhbHyJm/9hDgOHzKrUjF4dRqvNCzuVKegE=;
        b=V2+i3QxGeBqxUdwsNUuFEQUEmeRaysiG4pZ+JqYUdJCEsziZa6HpdGieIpgXFPDwFJ
         xe/FgzpwJZVGiJ+1eJKcUBl2YmYhVH/qn3xaK4Uc3BESEDfFCNT6guKqtIaJCzf+UaMh
         L+ZtpBktg5hZtIbMxU4FT7It+NcBGks1PmRsK21UXpuSYmPhphUL0fO090qlgD9fxDMe
         7HJ52s1VL13o77PKhGxZAypCCdr+GiZ6DyXHr4PdiXFqaUep9cG7XI75uDzjGAH3A3p0
         8lYompOXLHDXToZKV8sTjQ7Oz27yFw21FQqLeicfiqnbv8Hie+jX1x/DeNjz9/nv39oX
         WuJQ==
X-Gm-Message-State: AOAM532v9S1xF63zwu3a8evW7yiyHInQrUtUIyPSoXt2k7oegAlMVPU/
        897U8nJh64C0lTWsPiu4sdeGWegpz/KYneW8QBerDoNI
X-Google-Smtp-Source: ABdhPJxf2AEXYcdAWa8ewvVnaVllCMCg4t0saeQoUcFQoI0IWKW2s+bpGxj8igVn5hAzwM728rkrQYRQhI6HlV9eRWk=
X-Received: by 2002:a0c:fd2a:: with SMTP id i10mr48305210qvs.23.1594043292811;
 Mon, 06 Jul 2020 06:48:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAPYaOEQ1GAfZMY7WLuZjsVhPm9Z+iUb0cTnNnzaCFS0uHRdUSg@mail.gmail.com>
In-Reply-To: <CAPYaOEQ1GAfZMY7WLuZjsVhPm9Z+iUb0cTnNnzaCFS0uHRdUSg@mail.gmail.com>
From:   Jean-Baptiste MARIE <jbaptiste.marie@gmail.com>
Date:   Mon, 6 Jul 2020 15:48:01 +0200
Message-ID: <CAPYaOETzsKS3nWE+r_xpKw0Hc8cnJReZpqbG-riQPv8cSie5oA@mail.gmail.com>
Subject: L2CAP channels bit rate sharing policy
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

I would like to know how is managed the sharing of available bandwidth
between two L2CAP sockets over the same link.

Here are my observations so far:
- Connect one L2CAP socket from one device to another device.
- Generate permanent traffic over the socket and measure the bitrate.
- Open a second L2CAP socket over the same link
- The throughput of the first socket is divided by 2.

Is it possible through a patch or any configuration to set a maximum
allowed bitrate for a L2CAP channel? How is managed the sharing of the
link capability between the L2CAP channels?

Thank you for your feedback,
