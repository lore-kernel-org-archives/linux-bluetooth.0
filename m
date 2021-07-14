Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_20,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A04C07E9A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Jul 2021 06:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 278BE613A9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Jul 2021 06:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238129AbhGNGlL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Jul 2021 02:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238003AbhGNGlL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Jul 2021 02:41:11 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E7BC061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Jul 2021 23:38:19 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id b13so1494001ybk.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Jul 2021 23:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=LWuQFQdxB9IigQydNK9xhNNy46HY5uOV68RnwIbEaHM=;
        b=Pt9Or+HXcwWa+wtxGJN5ZjjNyAFPUTracL/ObGVBHlOjAyI8jnOxlyhbcNS8qaWx/N
         WXvk/jLGmZXCymu/la00poekU1QMRWJNYX2va2TLejYK0pdj0XliGOVCtxZ6UH/8WmNe
         Ax8NHX+XQpRYH1OhTxIrwYyjVpVnZ3+QfEppwkgbSKp83Wg6HY2MTPcDCxsTmHE1KShu
         otqrupaNtiiglu8TICcB6kIj+f27ckxCjNRqkXhae4xdi9uzxhuVc3GoM78lv68h2XRC
         I4tCLgw2mTMLkak4pJ85T/szXmE7Pa5cgf5aC2JoPgaYM3As4Q6K5j6ZR7mwp8eaR88v
         mTJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=LWuQFQdxB9IigQydNK9xhNNy46HY5uOV68RnwIbEaHM=;
        b=t5q3sc00xGACVCt39UmsHg/Q895Dj0VISJSLEffCUAXVi1cIyYHvXyquieL/pCxV3k
         SBKVmaf7SAnQxsY43+Arl8r+HKlKxNxoDmFzSeSU5Vzd9koKfto+T/MnWMXkPQgQI67Z
         FZlliz9LBwIbBn9MzVKkES6VXEomUCGxCZ4nypP8pgWqkeBfUoQvuofNykfAv8Omm7Af
         geAVyRdWtnIiK5/S6oO+N48fMfgq+t6nRU6VlG0RWAqik/8pny1hjGTwju7nvI7T1U2U
         TiDJBxlANHMAoHOV+d7kJsl1j+M9feCwN6ZF/qfDV7bdh4Ekw7f2QLH0v8My+/pqJUuw
         mUTw==
X-Gm-Message-State: AOAM532nUxGAHDJuzbhptXjiLRnSBxuvi7cswQVfbU0hlMgL8hFO/XiG
        O9gQYRAiskcbh1fGHvWvpNTZKDTJlhEI5zc8KAnBM/jM/dOpdw==
X-Google-Smtp-Source: ABdhPJyLHdNZknTG8JYKoVVerY85JnOLahR3xhpkJvgcyV2lmmLVmt5kvdWZB9mJ208JWopZKeJ2ZjkY8KtZ3ftTIm4=
X-Received: by 2002:a25:a369:: with SMTP id d96mr10960656ybi.463.1626244698747;
 Tue, 13 Jul 2021 23:38:18 -0700 (PDT)
MIME-Version: 1.0
From:   Ramya Hegde <ramya.hegde91@gmail.com>
Date:   Wed, 14 Jul 2021 12:06:34 +0530
Message-ID: <CAK0WY9LcpL=O-V7ckuSE9MTmRPaO-JvS73JWUQ1FOBkfGozmoQ@mail.gmail.com>
Subject: Bluetooth 5 support
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,
Now that many devices with Bluetooth 5 support are coming into the
market, I would like to know if there is any plan to upgrade Bluez to
support Bluetooth 5?

My understanding is, currently Bluez supports Bluetooth 4.2:
https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/supported-features.txt

Hope to hear from you.

Regards,
Ramya Hegde.
