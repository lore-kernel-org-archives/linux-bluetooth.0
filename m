Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E18DC433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Dec 2020 20:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7201522AB9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Dec 2020 20:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbgLVUrp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Dec 2020 15:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgLVUrj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Dec 2020 15:47:39 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51931C0613D6
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Dec 2020 12:46:59 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id y19so34916516lfa.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Dec 2020 12:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teenage.engineering; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H3EsGL2fam75a2jlwlny2/e3OBkaF8vgepjjLJUFQWE=;
        b=hT/JGjaGpdyuf9jbNnHf+SgbTCgoV74wgl2F8km1zjfuEG5sJCMSriyiBF9kGk30F0
         s9lIak2fmY/uYc4C0rBXEzuAOsdh6kRrFIW1M4un77s8mOyc+ElL5ILoxlaBLQ+QJNPb
         NHcAtZn3teziiM1bDxJz2XzRROSsH53i/xWZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H3EsGL2fam75a2jlwlny2/e3OBkaF8vgepjjLJUFQWE=;
        b=I7WxNj/3f2w2jI+9ak4p9JOkcvFhij3Za3mxkiMPMV+7EEu9j97cQ8let9ZhioMzLT
         7DiIHqkCvWd9M4t3SMW2tpbAPPomY4I8Ws87OHlhaPRpOmDoW3y11oXwq8YoyOAy5B7J
         nMXB8C3rlLSlO6cD/8IDHw8wY4Es1w3abzqunxcVWGVfnQICE24FSIGI1n8PgZq6N3It
         I1ZtIap+omm5WnJYQdf6g3WrzziSh0CD/3MYLCH0OnGhiDDDYGY73EKxXJtfITQKd/WQ
         RSNOhJkc9NUN7Cj+SVSnB2ylnNYl6JOnTIr6YOv2jECGbCoSNAvzPnmyUmd3B4WOTFk2
         LV9w==
X-Gm-Message-State: AOAM530NwRpYEhdBri5KVZjrDRcEMci4kF8G7yGfo8t+MFfhVaZPZqYW
        W/YppKVGO7zeT9yhujglzAiseLkWMR4o0wE=
X-Google-Smtp-Source: ABdhPJzB2cCJbBezFfVqnafTtdE+GvIC5L1bEa4jFWacyla0fS0ruK+kDqsC3iuSIqnVX+dTBufP9A==
X-Received: by 2002:a05:651c:206:: with SMTP id y6mr11033583ljn.234.1608670017414;
        Tue, 22 Dec 2020 12:46:57 -0800 (PST)
Received: from localhost.localdomain (host-95-192-210-115.mobileonline.telia.com. [95.192.210.115])
        by smtp.gmail.com with ESMTPSA id a15sm2809119lfo.299.2020.12.22.12.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 12:46:56 -0800 (PST)
From:   Jacob Siverskog <jacob@teenage.engineering>
To:     linux-bluetooth@vger.kernel.org
Cc:     Jacob Siverskog <jacob@teenage.engineering>
Subject: [PATCH BlueZ] btmon: fix buffer bound checks
Date:   Tue, 22 Dec 2020 21:45:47 +0100
Message-Id: <20201222204547.27839-1-jacob@teenage.engineering>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

index_list is of size MAX_INDEX - correct the checks that is meant to
catch out-of-bounds access.
---
 monitor/packet.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index c8c835d53..c91b91e2b 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -3879,7 +3879,7 @@ void packet_monitor(struct timeval *tv, struct ucred *cred,
 		index_current = index;
 	}
 
-	if (index != HCI_DEV_NONE && index > MAX_INDEX) {
+	if (index != HCI_DEV_NONE && index >= MAX_INDEX) {
 		print_field("Invalid index (%d)", index);
 		return;
 	}
@@ -11133,7 +11133,7 @@ void packet_hci_command(struct timeval *tv, struct ucred *cred, uint16_t index,
 	char extra_str[25], vendor_str[150];
 	int i;
 
-	if (index > MAX_INDEX) {
+	if (index >= MAX_INDEX) {
 		print_field("Invalid index (%d).", index);
 		return;
 	}
@@ -11240,7 +11240,7 @@ void packet_hci_event(struct timeval *tv, struct ucred *cred, uint16_t index,
 	char extra_str[25];
 	int i;
 
-	if (index > MAX_INDEX) {
+	if (index >= MAX_INDEX) {
 		print_field("Invalid index (%d).", index);
 		return;
 	}
@@ -11320,7 +11320,7 @@ void packet_hci_acldata(struct timeval *tv, struct ucred *cred, uint16_t index,
 	uint8_t flags = acl_flags(handle);
 	char handle_str[16], extra_str[32];
 
-	if (index > MAX_INDEX) {
+	if (index >= MAX_INDEX) {
 		print_field("Invalid index (%d).", index);
 		return;
 	}
@@ -11369,7 +11369,7 @@ void packet_hci_scodata(struct timeval *tv, struct ucred *cred, uint16_t index,
 	uint8_t flags = acl_flags(handle);
 	char handle_str[16], extra_str[32];
 
-	if (index > MAX_INDEX) {
+	if (index >= MAX_INDEX) {
 		print_field("Invalid index (%d).", index);
 		return;
 	}
@@ -11416,7 +11416,7 @@ void packet_hci_isodata(struct timeval *tv, struct ucred *cred, uint16_t index,
 	uint8_t flags = acl_flags(handle);
 	char handle_str[16], extra_str[32];
 
-	if (index > MAX_INDEX) {
+	if (index >= MAX_INDEX) {
 		print_field("Invalid index (%d).", index);
 		return;
 	}
-- 
2.29.2

