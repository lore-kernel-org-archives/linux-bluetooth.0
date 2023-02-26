Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D44C64ED6
	for <linux-bluetooth@archiver.kernel.org>; Sun, 26 Feb 2023 09:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjBZJ3y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 26 Feb 2023 04:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBZJ3x (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 26 Feb 2023 04:29:53 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C55E06C
        for <linux-bluetooth@vger.kernel.org>; Sun, 26 Feb 2023 01:29:51 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id r27so4732192lfe.10
        for <linux-bluetooth@vger.kernel.org>; Sun, 26 Feb 2023 01:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D152ygR3xR80qmN1uh9yD1DJWUhblEUYmvnj/OBmDu8=;
        b=BO5dsrBdHtMpj1bpKbbpqcXs9IkuRHhaprldWL50I91vniBrK7Ce4Yppa2xwp0Y00r
         ++ZYXa1jMrFicqUGUH4TQG2WPMEUSuU4uDIeA1IvXM+1+5SBuRVSUzbyrz1V9JzzdpuK
         6BsNob5+Fc9mPu9jx9RWz7FVvvvCbvHwCgF2oE0ia97y9AJr1EjprtIaAwOLIsLAHFw3
         LJg5Jiimjp3zfhiQJ6cPDa0smtWXAH4Uf4XzyeyS4ek6lKMNFJFVWR569F+D81JXM8E7
         OcuuxbFD6JbI0QQgwc4Bicoi62ahlxz8BODV5wZETuJgapSSfSb4ExybtUbhg8VOPaNb
         lpjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D152ygR3xR80qmN1uh9yD1DJWUhblEUYmvnj/OBmDu8=;
        b=tJERfqvstBUTV2TGw13QtmN+E3iVWYEIKe/ctR0gksJ2Va9zcGZURD+tXT3eoLMX3e
         IKEDFJ+X1jM4eAp2m7ccnnzpP1VNNTJ+ntRvHF0iaVY4MiilIM0OiBJigjG0m7Cx5rk1
         6llpbOpdpbxOBnJ7Z4X5mRh58RGIWd2k9Sp7T2ycgmPfLCotpgS1VjmGbUD2SDfNDmx3
         iw4mr1lKpH4bCzFCGq4xDIQztoiuc1Vj5ZmOyhLZLgBLRVqTTSAMzUxDnQOF3otLIm2R
         scaS9Hmveh6liuvl3fM6a1j1y2N72DaHNJYmYpFrJd7sxNdb6zl/SN73/+ExCZqajN3D
         YCfA==
X-Gm-Message-State: AO0yUKWPMBwZIdo6WJb1jZixif1yHdWQ08uYU+GF+1+4zR+qG0Bybpqr
        6d783hpwpJChjfLprvDd2g06IHNYsDYjTUC0woEr+t4b8rE=
X-Google-Smtp-Source: AK7set/VH8dtUqW5VYcZLWZfwioZIidLc2j+72Gm7dzZpFWMI0P/DhwRhCzcG127f1xOl8iotZnODKrjnDcIp4pwm+g=
X-Received: by 2002:a19:c209:0:b0:4db:3873:fac1 with SMTP id
 l9-20020a19c209000000b004db3873fac1mr6426060lfc.9.1677403789297; Sun, 26 Feb
 2023 01:29:49 -0800 (PST)
MIME-Version: 1.0
From:   Roman Elshin <roman.elshin@gmail.com>
Date:   Sun, 26 Feb 2023 12:29:38 +0300
Message-ID: <CAB83zogXRLwJSKORH9Aa42U8+V+_n+n6Ham=E1AmzHkgjw4zxg@mail.gmail.com>
Subject: btmksdio mt7668 questions
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I have an amlogic s905x2 based board (a95x max v81 board) equipped
with mt7668rsn
sdio wifi/bt module.

btmtksdio kernels driver claim to support mt7668 sdio bluetooth, and
trying to start
automatically, but it fails as __hci_cmd_send()
call produces non 32bit aligned transfer, which seems to be rejected
by meson-gx-mmc
in meson_mmc_validate_dram_access().

There are modified driver from android
https://coral.googlesource.com/mt7668-bluetooth-mod (require mt7668 FW
from android)
with some trivial changes in btmtk_sdio.c (file_operations to proc_ops
replacement and removing unused timeval var)
it can be compiled with a recent kernel (tested with 6.1.13),
but it fails to start at 0x2031 command.
By modifying hci_le_set_default_phy_sync (in
linux/net/bluetooth/hci_sync.c) to only
return 0 (function do nothing now), makes it work, at least with a2dp
headphones.

Looking at drivers code, it seems to me that both intended to work
with different chips, as the wmt header format is completely
different.

So questions:
1. Are there different mt7668 bluetooth sdio chips with same id,
 or btmtksdio claims support for mt7668 by mistake?
 or, hopehely, I am wrong here and btmtksdio should work with mt7668rsn after
fixing alignment issues?

2. Is there an easy way from the bluetooth driver to tell the host to
not send the 0x2031 command? (to not breaking other drivers for
mt7668-bluetooth-mod)
