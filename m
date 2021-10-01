Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1993EC433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Oct 2021 14:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E55B861A6F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Oct 2021 14:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbhJAOTo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Oct 2021 10:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbhJAOTl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Oct 2021 10:19:41 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FC4C06177C
        for <linux-bluetooth@vger.kernel.org>; Fri,  1 Oct 2021 07:17:57 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id n6so5630065qvp.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 Oct 2021 07:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starry.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ff7NuoYiNUyCHAMxfVqHJeSZ7mD0kEq92COF9ph4GDs=;
        b=Ea/3zotpRemuM8vjCotiHW2K8vjF9iJMaKBh2/zGMCo0ogrSb2FtIoPkujr+DIEeVu
         3uQcOiiTvKhYJjTPe+lGaE8YoaNE6bsx8H88eCt9yQzf0CkDQHeooLJa79Oat6zYkfrC
         c+lusd6Mhc6zUZlD3nJZXwy1QfoHkXJjzLX3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ff7NuoYiNUyCHAMxfVqHJeSZ7mD0kEq92COF9ph4GDs=;
        b=yFxEw1tWr5BCR7Q510/K5UmNZLKnuWCfk/V5xkhMqxo3naxgB1V99XbUDqr37uVBY2
         UwW+4qaycQBTc3l+6ZIcSy2MHhuVtZj7OjPFSWNHXGtVMcFg0+ouoQm4ZMkhYFSpMQZd
         cHs07f8Ks6htFD3TAix0mNQ/SW0JYNy4jZ4wxxQ/wFGO+YfB+Zewv6Hf2YQO9GdGSdBt
         2ProwN2EP8+zLLGZ65BfiOT/jOOHa+co6rh1cpwtzLNULgO/0bLVEHtzwipbYcZS21b8
         Yuuk03r2LkseRytQRG7TP3U5KaRy/s8rBbJ7i/ZR51hhrfkl5RowP+2uPFyhS5iBWTQy
         2C1w==
X-Gm-Message-State: AOAM532uljWR2U0AuTvRCkWgHbQ+WkhswFkW6mmkNXBI1ui2u5DotFeD
        i3Z7fJMiqp+giA91jrj6B4XRDVFazv6BWXeR
X-Google-Smtp-Source: ABdhPJzRn2dHhaJ9IqPYCE4wLFvn3N6mBSPisqZ/rsSOIGDYpPsHFZppHrqNxZXQq5iHv7I+G16gmg==
X-Received: by 2002:a0c:8045:: with SMTP id 63mr9211587qva.63.1633097876454;
        Fri, 01 Oct 2021 07:17:56 -0700 (PDT)
Received: from MrComputer.nevonetnext (205-201-16-55.starry-inc.net. [205.201.16.55])
        by smtp.gmail.com with ESMTPSA id u12sm3767299qtw.73.2021.10.01.07.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 07:17:56 -0700 (PDT)
From:   Dagan Martinez <dmartinez@starry.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Dagan Martinez <dmartinez@starry.com>
Subject: [PATCH BlueZ v4 0/2] Optionally require security for notify/indicate
Date:   Fri,  1 Oct 2021 10:17:17 -0400
Message-Id: <20211001141719.180087-1-dmartinez@starry.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In some cases, it is desirable to require encryption and/or
authentication for server-initiated updates, as they may contain
sensitive data.

Currently, there is no way to do this with BlueZ.

Here is a query about this feature from 2019:
https://stackoverflow.com/questions/55884233

This patch implements this feature by introducing new `x-notify` and
`x-indicate` flags that allow a user to restrict access to a
characteristic's CCCD (as well as documentation for those flags).

Note that `x-notify` and `x-indicate` each enforce security for ALL
server-initiated updates. That is, you cannot require one level of
security for notifications and another security level for indications on
the same CCCD. I could not think of a reason why somebody would want
that feature, and did not think the accuracy of terms would be worth the
introduced complexity, so I didn't implement it.

---
Changes in v4:
- Directly set flags on CCCD instead of having new intermediate
    permissions

Changes in v3:
- Split the `x-asynchronous` flags into `x-notify` and `x-indicate`
- Fix a mixed code and declaration error

Changes in v2:
- Fix line-width issues brought up by CI

Dagan Martinez (2):
  gatt: Allow GATT server to dicate CCC permissions
  doc/gatt-api: Add 'X-notify`/`X-indicate`

 doc/gatt-api.txt    | 15 ++++++++++++-
 src/gatt-database.c | 52 ++++++++++++++++++++++++++++++++++++---------
 2 files changed, 56 insertions(+), 11 deletions(-)

-- 
2.31.1

