Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69600C8300F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Dec 2020 01:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17906221E9
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Dec 2020 01:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbgLBBVK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Dec 2020 20:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727731AbgLBBVK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Dec 2020 20:21:10 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454FAC0613D4
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Dec 2020 17:20:30 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id p20so1413pjz.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Dec 2020 17:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=U5hPqfeHQ7HwenP3pWkVeuC27TdTy1yf+8AZsOB3OHs=;
        b=FLjBJdBSM0x8PJu0CglnQiHo8GitCwZK3I4ZQZ1O1ZpG7uCED/j6PoGHS0qJ8qsxVs
         /ms+I2osY4OJpcsIlmh4Fj+T+9E7P4H748NpqUWvF2puQMyIC+WhicXhhNr2k396v9ic
         vTGx5yHkv2+Rlu3rAEmKfaReQ3LOd/imaTDG9c/RXVQXOLj+lkkn2hoOPFHwac9lRV2d
         nR2G9DBevceUk6oBdHmHxkVKGfeYA7/G2ODGUlMnPB6B88zij6hw+CFFDpstMqasBX2y
         O2E+eC3qkRoCR/nhh+rpb2zt2ilfAEOiBYI8aVphiswqRqZxQN0oUv+T9iOTnberzvId
         P4CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=U5hPqfeHQ7HwenP3pWkVeuC27TdTy1yf+8AZsOB3OHs=;
        b=MqMhU+v4Nj/7of207aV+8CBV5qPIShChX2/KxuO7fwRxLwZacZUXk+rLQVdOvH593r
         linvjvIemNHG5pMZUvegQiLlCcbXaxtpKu2f4VKntFKYJuX4P0hdWMiZ+kn386Fo34t1
         vbNiivdrmF6v3bKVf3gWrgW/DbKGdn50CsyKrd8+R2qFba0/LBonZMQWPaJXmo7koBcO
         ExvE3+wN1WgryUiBP1qsHnQstcj68IjUv4eI4nijqpEvt5YMjDEtzhFLut29qXIrIJV8
         v1QKljsWgN8bmuQzw20nHhU2//eJ9NEdETDrccF+E3miirmwj9gvmd7NLxOTN5988SvX
         c/NA==
X-Gm-Message-State: AOAM5309s3VXcXXM2sirPz+HwITKgbkJNJ4jzqRSym1AIwbjxjeO8cs3
        oXLdfiyPSYTp5FAwLrIP/kXELSYpXohWgA==
X-Google-Smtp-Source: ABdhPJzOZqrdLpVmxWjSxKvxY61XwEZ64higCa1F8Eto5/w3rZrqoTI8jEE2dtFwwWYeNGSABjMjSEUmBCaRZg==
Sender: "mmandlik via sendgmr" <mmandlik@mmandlik.mtv.corp.google.com>
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:e50e])
 (user=mmandlik job=sendgmr) by 2002:a62:7f95:0:b029:197:dab1:6f70 with SMTP
 id a143-20020a627f950000b0290197dab16f70mr103577pfd.69.1606872029826; Tue, 01
 Dec 2020 17:20:29 -0800 (PST)
Date:   Tue,  1 Dec 2020 17:19:27 -0800
Message-Id: <20201202011930.2130671-1-mmandlik@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [bluez PATCH v1 0/3] Emit InterfacesAdded/InterfacesRemoved at
 correct root path
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Manish Mandlik <mmandlik@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello Maintainers,

Existing advertisement monitor implementation registers client app with
bluez-root-path i.e. "/". Because of which client app needs to emit
InterfacesAdded and InterfacesRemoved signals - when monitor objects are
added or removed - at the bluez-root-path.

This may cause confusion for application developers as the app need to
register with bluez with app-root-path for exposing monitor object, but
need to emit InterfacesAdded and InterfacesRemoved signals on the
bluez-root-path.

This patch series fixes advertisement monitor implementation to register
client with client specified app-root-path. Also, adds support in gdbus
library to emit signals at the app-root-path so that bluetoothctl can
emit InterfacesAdded/InterfacesRemoved signals correctly when adv-
monitors are created.

These changes are verified by running the bluetoothctl as well as the
python tester app and verifying that the monitor objects are getting
exposed and DeviceFound/DeviceLost events are getting invoked correctly.

Regards,
Manish.


Manish Mandlik (3):
  adv_monitor: Register client app with app-base-path
  gdbus: Emit InterfacesAdded/Removed at app root path
  client: Fix add advertisement monitor

 client/adv_monitor.c |  3 ++-
 gdbus/gdbus.h        | 15 +++++++++++++++
 gdbus/object.c       | 39 ++++++++++++++++++++++++++++++---------
 src/adv_monitor.c    |  2 +-
 4 files changed, 48 insertions(+), 11 deletions(-)

-- 
2.29.2.454.gaff20da3a2-goog

