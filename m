Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69594C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Sep 2021 22:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4471461882
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Sep 2021 22:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237344AbhI3WjS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Sep 2021 18:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbhI3WjS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Sep 2021 18:39:18 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3DEC06176A
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Sep 2021 15:37:35 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id x8so5033476plv.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Sep 2021 15:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IME04lFZfOxs1awTZr4wS+9qI4QpihioBUUhALuFWOc=;
        b=nMcdM8i1bvOMolrhUbYWAABBoVYo19VCiq2p06uzN4pojS35ORXXS97RMG0DDFeR14
         aNzsIhjkqSULIfT2eQvrpCm+gSfwSiJJBtqnF+BHUyL0rwQIVpr3GB3eo7pOGDKQ0J/E
         iSimxAEvA0JWlbG3PlSoewjcJkrlKt9z95vU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IME04lFZfOxs1awTZr4wS+9qI4QpihioBUUhALuFWOc=;
        b=oeNA3UeKxpuiL4LNSXCMgrTykvgVcxmEp6sLSflyXrPRxAT32YBsrWdg6AM2ZGE633
         XxpMBK460KhukpIqgZSPTWF5ujVrlZEHzZF907I8ct+0TWImsbpRgIGCyeaZYNw/Tk4x
         FMwZfg/hYlulRxD2z1HH6QJXYrFmiO3zS5mUhIARoBvFi8xGt5ZKGKm309NrMBX6pa2/
         WZkjcELPSWEspSH7kYf665CF2o+FT7vPAYovSQIfcM+YcdwcavDp+qOOEzSfCU8FYjcJ
         z/z2CG4N5rhZsuzV8mel3PSAHHmUxlwCtTJCImJbkeZXzmFrt2QUYqvams1bQBAEedqK
         /pgQ==
X-Gm-Message-State: AOAM5303wbAd9u85LZRHomjoDgi2NwiPcuz32ufI/3lvd0EB9gPbbc5S
        WXG8d+6EG1M6kpA1D1hc75OoeZjKntto+w==
X-Google-Smtp-Source: ABdhPJyYfvoS//NYzuapdT8g1KtE41O5ON16AdU5fD6PEKZ/SkDDy+vjULgMfsMWGoXxwvMu+Jkj2w==
X-Received: by 2002:a17:902:710c:b0:13d:f226:2e3b with SMTP id a12-20020a170902710c00b0013df2262e3bmr7625335pll.83.1633041454230;
        Thu, 30 Sep 2021 15:37:34 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:eb71:bb5c:56a6:693f])
        by smtp.gmail.com with UTF8SMTPSA id y80sm3913090pfb.196.2021.09.30.15.37.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Sep 2021 15:37:33 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Howard Chung <howardchung@google.com>,
        Alain Michaud <alainm@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v7 0/4] Detailed error string
Date:   Thu, 30 Sep 2021 15:37:22 -0700
Message-Id: <20210930223726.2886139-1-mcchou@chromium.org>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
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

Changes in v7:
- Fix nits

Changes in v6:
- Rephrase error string

Changes in v5:
- Replace error code with error string

Changes in v4:
- Address make errors.

Changes in v3:
- Correct error-codes.txt.

Changes in v2:
- Add documentation for error codes

Miao-chen Chou (4):
  Add errors.txt to describe errors of D-Bus method returns
  BR/EDR and LE connection failure reasons
  Include detailed error string in Connect() return
  Print error code for connect methods

 client/main.c  |   3 +-
 doc/errors.txt | 233 +++++++++++++++++++++++++++++++++++++++++++++++++
 src/device.c   |  46 ++++++----
 src/error.c    | 100 +++++++++++++++++++++
 src/error.h    |  57 ++++++++++++
 5 files changed, 422 insertions(+), 17 deletions(-)
 create mode 100644 doc/errors.txt

-- 
2.33.0.800.g4c38ced690-goog

