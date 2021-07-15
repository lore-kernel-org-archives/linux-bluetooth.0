Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D18BC12002
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Jul 2021 01:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46CB261183
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Jul 2021 01:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbhGOBMw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Jul 2021 21:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbhGOBMw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Jul 2021 21:12:52 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF2DC06175F
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jul 2021 18:10:00 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id k20so4326272pgg.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jul 2021 18:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A37TGVJ0XD7USVq8CqJfCbbq+hDqmM2/3SjGqTi96Xs=;
        b=oWzEoKSp+mtGvcOf8W3+45in8IsyVCcenwiaGy5CvboqCh3BKQkSWXzUw/8dRdiX24
         z10jOw0x63mSaUcGUB8CuttkIm8MaHkf15MURemxImOmhDtkFaqjALl724xIDFG3If8W
         zqhjg2PMdOtCSAoLOBZ7rkVfeDjXH3cTzG9xk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A37TGVJ0XD7USVq8CqJfCbbq+hDqmM2/3SjGqTi96Xs=;
        b=RAKcYR/etdfeB4CfSkjrzlJq4swr5PPBMdM1O9cWy3YSecQiYKV6ywzH3VCum+vIJn
         1ixchCOkW+rTYx53rgTTvtkoYc+0Yj1FWmlrZOfgHMecV2YAgOOycjROdfbzyFEVCP09
         3a6vjAYy1fwB3Cje5XKu14m6veI/cpiLOIw5sXDuuJfZ1tPq1oeR2YroH0LNCLT6Xf00
         eF0NocM9ve4kwyPMThKwDYkOeVTVUiR5DxVXZrz6tpl9cRuAsX14zVQwb4s2BaaNicr9
         MXuj187eaRwhUvA6NcIr70uaEuHqZucJA3+734fT5mZ0A4UkLqyFDGG9/r5INDSUBbaD
         2Npg==
X-Gm-Message-State: AOAM531ZAFPkGrdg8dDH3eAL+lxmCnBJnxHkOCMCC3rSlg0IqxAgHGvh
        b9AW3XCp99xMoqtENsL76PQUknqkMJKbpw==
X-Google-Smtp-Source: ABdhPJxihgBEVzFPncrVYSJHpkxxoLECPNDUX4k847USpgX9ZVw9d5d0EGzrpkNq1+EN1ba5Sip6Pw==
X-Received: by 2002:aa7:8550:0:b029:32b:963f:f53b with SMTP id y16-20020aa785500000b029032b963ff53bmr911476pfn.0.1626311399640;
        Wed, 14 Jul 2021 18:09:59 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:20b7:5dcc:d530:a8df])
        by smtp.gmail.com with UTF8SMTPSA id d67sm4013367pfd.81.2021.07.14.18.09.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jul 2021 18:09:59 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Alain Michaud <alainm@chromium.org>,
        Howard Chung <howardchung@google.com>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v3 0/4] Detailed error code
Date:   Wed, 14 Jul 2021 18:09:47 -0700
Message-Id: <20210715010951.963176-1-mcchou@chromium.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Chromium OS has been working closely with Linux Bluetooth community to
improve BlueZ stack, and there are increasing needs from applications
building their features around Bluetooth. One of the major feedback
from these application is the lack of the detailed failure reasons as
return for D-Bus method call, and these failure reasons can be used in
metrics, optimizing retry mechanism, hinting the reproduce scenario to
improve BlueZ stack. The current org.bluez.Error.* are serving the
generic errors well. However,g given org.bluez.Error.* errors are used
across different interface context which does not serve the detailed
failure reasons well. (See https://github.com/bluez/bluez/issues/131)

Changes in v3:
- Separate and correct error-codes.txt.

Changes in v2:
- Add documentation for error codes

Miao-chen Chou (4):
  Add error-codes.txt to describe error codes of D-Bus method returns
  BR/EDR and LE connection failure reasons
  Include BtdError code in Connect() return
  Print error code for connect methods

 client/main.c      |   3 +-
 doc/error-code.txt | 266 +++++++++++++++++++++++++++++++++++++++++++++
 src/device.c       |  52 ++++++---
 src/error.c        | 111 +++++++++++++++++++
 src/error.h        |  52 +++++++++
 5 files changed, 465 insertions(+), 19 deletions(-)
 create mode 100644 doc/error-code.txt

-- 
2.32.0.93.g670b81a890-goog

