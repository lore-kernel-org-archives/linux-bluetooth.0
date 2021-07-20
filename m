Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B6BC07E95
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Jul 2021 11:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13E346113C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Jul 2021 11:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237024AbhGTLLc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 20 Jul 2021 07:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237340AbhGTLLE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 20 Jul 2021 07:11:04 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD78C061762
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jul 2021 04:51:42 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id q10-20020a056902150ab02905592911c932so30137743ybu.15
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jul 2021 04:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=NM/Gq6o1W+zLvEmjAneDTgb5xEyVBdslvhpbgIMsBHM=;
        b=IhN9rRZohQwAYAtkrUmARIx2FgvxUkhPNgNK3uogThD/bEAoNouJ8c+Uui3I9JKxqH
         s3R044IM6e3qEmunY9ClB7gfwaGsEZ5zCQlHAWB6ArIG6M4Uxxs7XKzx/9cHwCsu788H
         CVTw0/ZUl0pTVyXpVtj9c9+1le39358Met3Z5KXLDOlQhOOehKX7Rx4vTR7xu+rtzlsu
         yVl9x4i914mXJ/hFvfxIw0jt+wwyad14Ptp6oDgdvLJCDQGEENVcf/x1pHYnlmR9eAln
         xSkoXOC/MoXLdS7t+QgCgeFaOJnAegkYg3SS7gxGqkohVU370+UOc+Oya0dV8KzVmaC+
         TVrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=NM/Gq6o1W+zLvEmjAneDTgb5xEyVBdslvhpbgIMsBHM=;
        b=sqPTzyWDPZT2g9hXh09Wvv6GMK29J0Ql7UpbuCSu3UdmarN+l3T0NdZXDUCJ0fNfj6
         EDjdPp5ElXTmzYJZ+y0CbF5sjCtiCgRkcJWGn2KmZLssKpoyY0bRdMZSMqUcJlybgGab
         AfwjCIOdN/0oyCSVznso/uGXd/N22DP+WSo2iVV1smqP3BKHlejKBhHpgkxBQyi2WoaM
         Al7L9wEVyR9fGThYDNdxgzc14H1Qu0JupEWzFAxmC/8ALN2JmLe+3pqj8Xrau5d20jDA
         Ax80mUIcw4N7qLy9SemQNmIoVuu8bjf3EYK/WwWkyxQOCUyZH0TP6v5C9wCc3xocXaTT
         ZjdA==
X-Gm-Message-State: AOAM530ekZUAGVYS5rxvsLMn1ebozRHGR868WiYkiW5boKF1Joc/C5TY
        doU06L+FKgMNmGwnK6FaHHxaRDMMTZl2/JlsTKDfJOnq6BdCbKxP0jPGDcf60nfgQxBabZDthZ2
        +g5LF5KAopscEeJPEiEQtMj335Mk4LQgYTq50XkTnnA21rLoyx7/FqPfmD1g7wy1dxN9SdckDaO
        4fsSe4gFEKU7Y=
X-Google-Smtp-Source: ABdhPJxcZTSzOD+4hMiFvclWsGOcq3GL2NSRIxdWUlhS5PbxmjMvZ0URZ/BCcDm4HafUUiYfHXV/d3CgHXUV0qllrA==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:fefc:42bc:f2d9:7140])
 (user=howardchung job=sendgmr) by 2002:a25:ba0f:: with SMTP id
 t15mr36588174ybg.15.1626781901756; Tue, 20 Jul 2021 04:51:41 -0700 (PDT)
Date:   Tue, 20 Jul 2021 19:51:37 +0800
Message-Id: <20210720195130.Bluez.v1.1.Ib24a67a8a849f311d5213f83eaac3cfbc54b7b58@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [Bluez PATCH v1] core: fix a possible crash when removing devices
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     Yun-Hao Chung <howardchung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Yun-Hao Chung <howardchung@chromium.org>

In probe_service, if the service already exists in device->services, it
returns the service. This might cause dev_probe and device_probe_profile
to add a duplicate service into device->services. When removing the
device, a double-free error might occur.

This patch changes the logic of probe_service so that the same service
will not be added to a device.

---
Hi maintainers,

This was originally found by removing/reprobing profiles in admin_policy
plugin. Since we are going to adopt the other way to block incoming
connection, this patch is no longer causing any issue, but I think it
is still nice to have to prevent potential crashes.

Thanks,
Howard

 src/device.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index faf07ba22270..b29aa195d19b 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4624,8 +4624,11 @@ static struct btd_service *probe_service(struct btd_device *device,
 		return NULL;
 
 	l = find_service_with_profile(device->services, profile);
+	/* If the service already exists, return NULL so that it won't be added
+	 * to the device->services.
+	 */
 	if (l)
-		return l->data;
+		return NULL;
 
 	service = service_create(device, profile);
 
-- 
2.32.0.402.g57bb445576-goog

