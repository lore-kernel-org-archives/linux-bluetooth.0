Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 462BEC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Sep 2021 16:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C61861184
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Sep 2021 16:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbhIUQsy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Sep 2021 12:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhIUQsy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Sep 2021 12:48:54 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B289AC061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Sep 2021 09:47:23 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id l6so9018210plh.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Sep 2021 09:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sKCVY/ToAM2RaO61Vf5KeoccMr7XJthyvPGkAG5CAq8=;
        b=NNsiMCoSjYUS9prbNdHkp9u8KdrpcfjV6xjQzGrL9Anj57raaLzccYv+2mGXwhF+GK
         46d4b47LGmrqSSuSO/8o+FfR8AyWi0a0RWccTb78wCox3tyjumbNM8KdpQLpQ9ozxdSB
         rVYqDAGoapE2I4ZR1yDt8sSwss73wkkx1XWGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sKCVY/ToAM2RaO61Vf5KeoccMr7XJthyvPGkAG5CAq8=;
        b=HIjhNvJPvf4Oi3IEiEkdukPJiDG0Ted8GYPRqiYhwjsaCiKk2qtMOBVZ38z5ur1ymC
         yjcHbndDMi12wvGEEe8D8v7DqmYu/wkjSvGPQa5WK0d0f3H0TlL0hUGbxv5uvu5OrPwh
         B/eYQjoTvK9Ltm5/gSDZ6JOBs4Cv4ys6YdgG6UVJtx7a6a/2nCOfQda2dZqu0c9JBi4j
         BYDoZKhiuxt00AMgQDrbGB1kpp2+r0VbRy82p420jH7SfhJll889PYYMH24nq680oYmv
         0AohFyxCICmHx7HNlwk83A+IJTW7qn6nC2HnwGUK/ytpGihLLcdwuH/uf3oX02y/VTxH
         1UyA==
X-Gm-Message-State: AOAM5336gWMp82JYHtulcWlvD3aoiLvAat0bp35Iktr04+C4BPBuUIRD
        FlBKmZJyup+fkP1iNcj8BVAINAmPRSJxTQ==
X-Google-Smtp-Source: ABdhPJxO/CBD8LtagbeLrIrJGstYOcCSd2rMijS7XiSoNI/ucqP7s9OE9mGFL7SdrFxThE1EOBBHqg==
X-Received: by 2002:a17:902:b7c1:b0:13c:8a0b:dccf with SMTP id v1-20020a170902b7c100b0013c8a0bdccfmr28618907plz.60.1632242842835;
        Tue, 21 Sep 2021 09:47:22 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:db3:f19e:7f67:74f])
        by smtp.gmail.com with UTF8SMTPSA id d3sm19929800pga.7.2021.09.21.09.47.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 09:47:22 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Howard Chung <howardchung@google.com>,
        Alain Michaud <alainm@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v6 0/4] Detailed error string
Date:   Tue, 21 Sep 2021 09:47:03 -0700
Message-Id: <20210921164708.1497029-1-mcchou@chromium.org>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
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
2.33.0.464.g1972c5931b-goog

