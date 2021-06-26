Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDAE0C49EA6
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Jun 2021 05:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81C0C61931
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Jun 2021 05:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbhFZFYY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 26 Jun 2021 01:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhFZFYX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 26 Jun 2021 01:24:23 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBBCC061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Jun 2021 22:22:01 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id u14so3548376pga.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Jun 2021 22:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZWpBwTAKAhPC/pjWpx/k4UKP7rHEEXjrUX67mDBVe0M=;
        b=L3rd0OZ/Vw9XZliriYRTKop+eCv88k+8XqUdYlGy4wB4MIVThKHJfxpediNMzHqovI
         kxbTqYtuQV9hmqWXiKEcqffR12vDmoNRQowHT5Uq6MRK4/nv668Ai7fk2T4kS1LYUwp0
         jFOTl0OlOmq+BWZvAWtJ3deVEVplGr+SRYh0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZWpBwTAKAhPC/pjWpx/k4UKP7rHEEXjrUX67mDBVe0M=;
        b=QyLlrjopVpmmvFlFT3VCbqm8s1a7CUyeRTHNN7fwr2rqvK3f6ZIxH3saPf/nbO3qFh
         0H6yZdgLwrV+iM6fZaQTxdQ3Qnk9LFQ7LVeYaqeC1Wz6o8eRI4l0ORppwa4TGQ9azFMf
         B8hfTAGAh2Iy5jbekxiYPyasCv/csf2v8fnPzGP42aJczcksQsObJDou4L/1jEtS+De5
         2notXFFCbklMuReG4RXn4/XM3/5kw2Ewf9POGNuAENwGIFs14VNNI0TN8o4YaPR4rtqI
         FbbIniGLeo8kjxlG3K2ZUtVp5krkFiLxd6lKLOYVL5TAH340i9DQcb4JzQ1oE/9hfbwD
         BrYw==
X-Gm-Message-State: AOAM532b8yn1emYOrwN5DyEZXJ5OP75hlKivKnwFIfoEL69CXjrZ+HGW
        NwO9UhZL/K/kwRNMB2rtPpUg18rSCcWbfg==
X-Google-Smtp-Source: ABdhPJyVqSXhqTvVci7ZU6EBfZ9HyreCxOqBJiA8JiozZ1/fIi3Sg4sUL/8twllBioTYcxGN31dKDw==
X-Received: by 2002:a63:2dc6:: with SMTP id t189mr3678806pgt.442.1624684920115;
        Fri, 25 Jun 2021 22:22:00 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:be2:cfe5:893:108f])
        by smtp.gmail.com with UTF8SMTPSA id s1sm6906963pgg.49.2021.06.25.22.21.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jun 2021 22:21:59 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Alain Michaud <alainm@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Howard Chung <howardchung@google.com>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v2 0/3] Detailed error code
Date:   Fri, 25 Jun 2021 22:21:49 -0700
Message-Id: <20210626052152.2543526-1-mcchou@chromium.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi BlueZ maintainers,

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

Changes in v2:
- Add documentation for error codes

Miao-chen Chou (3):
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

