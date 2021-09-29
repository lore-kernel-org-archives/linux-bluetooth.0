Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9F8C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Sep 2021 18:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9693B6120D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Sep 2021 18:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbhI2SDl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Sep 2021 14:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbhI2SDk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Sep 2021 14:03:40 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F0CC06161C
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Sep 2021 11:01:59 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id 138so3158595qko.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Sep 2021 11:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starry.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BsCjKB5oL3JCp/FAnbW0iCkti/ELEAM2QnQaHyY72iM=;
        b=PuClNWMUvUZ7W9p+X12dnd5sFdHGSlNhMSTkFXZ+ggt5GVYXEYyhfMPdlY6VYQXyeA
         u0K5TzmXH0rfSBYznTN9nkeYyZotCcdeYtoy14OZgpG/GTZ0j6WmOrTSYI0kL4oumcB7
         U1mZG/q5oRUdzT+BqGaaAkYt+HAINeA63Y4/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BsCjKB5oL3JCp/FAnbW0iCkti/ELEAM2QnQaHyY72iM=;
        b=L1qLyIytvy2iVKrJRyKYbDY3Tq1qL6DbD3oAakOnvDRQwFswbpPhf5Md4Q6I2Oclmq
         VQcvDZ5KqQpC974VUjtnlnLHXpXmzCXHpsZsV1K4fwRkjQKYskJT9hTvY/hmyWLIpwTs
         SMSJOKF+rz4Z9if7AGLchNC1GqmB73fkHHWeFB+qVmjxGpNcDYOMFzwFCOVjm1Hevp65
         zFrUV/wSPHs87sVcaY0ZtINcF+LZk7xVGMrFhCIjgNEtNGhLHr6d0Q2oxG7QpZFA0TkN
         OrvEepSGWMXBLUaqZMoQdu5lv25zsUHlExoi6kZXnLEYHWkwTSr1d7zhauX9fNBHtqlG
         eEkw==
X-Gm-Message-State: AOAM530aqmMAtHUCqUDfyFo0XSVSTlrRiiMg6T2DPYDXnxWKsnsej1WJ
        5z6A7x42wy4qaxOg6QN4oEQtTQ6sKocEjj24
X-Google-Smtp-Source: ABdhPJyxyDGmaetEoJzcuis2phhryBhR5ZZ16a+LQUPz8wxBAxv/l96hIIcqSsyj6/HSdlJkIBgbfw==
X-Received: by 2002:a37:f911:: with SMTP id l17mr980459qkj.513.1632938518359;
        Wed, 29 Sep 2021 11:01:58 -0700 (PDT)
Received: from MrComputer.nevonetnext (205-201-16-55.starry-inc.net. [205.201.16.55])
        by smtp.gmail.com with ESMTPSA id 14sm367355qtx.33.2021.09.29.11.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 11:01:58 -0700 (PDT)
From:   Dagan Martinez <dmartinez@starry.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Dagan Martinez <dmartinez@starry.com>
Subject: [PATCH BlueZ v2 0/2] Optionally require security for notify/indicate
Date:   Wed, 29 Sep 2021 14:00:29 -0400
Message-Id: <20210929180031.417090-1-dmartinez@starry.com>
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

This patch implements this feature by introducing new `x-asynchronous`
flags that allow a user to restrict access to a characteristic's CCCD
(as well as documentation for those flags).

---

Changes in v2:
- Fix line-width issues brought up by CI

Dagan Martinez (2):
  gatt: allow GATT server to dicate CCC permissions
  doc/gatt-api: Add 'X-asynchronous` permissions

 doc/gatt-api.txt       | 11 ++++++++++-
 src/gatt-database.c    | 30 ++++++++++++++++++++++++++----
 src/shared/att-types.h |  4 ++++
 3 files changed, 40 insertions(+), 5 deletions(-)

-- 
2.31.1

