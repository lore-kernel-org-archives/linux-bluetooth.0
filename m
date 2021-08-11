Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.5 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCBFC4338F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Aug 2021 07:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EFC960FC4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Aug 2021 07:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235439AbhHKHTF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Aug 2021 03:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235135AbhHKHTE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Aug 2021 03:19:04 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1274C061765
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Aug 2021 00:18:41 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id h4-20020a2597440000b0290593ddcb3a3aso1440038ybo.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Aug 2021 00:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=V0F2q6DWz68y9EMObI0aq5egV2DxRbNMTPAOBAB1rDo=;
        b=hUpx6WAStVkEDkhWBZxUet5OoZ0b0C1e7Fzu7vKARtVcjnlOC+EOyV0Cbht2VpTOmG
         OA1Y9TK9m0HWSlXaAsCMVOFpjAuzDIf7MWLjDmit44qKLw+TJ+JYnS5Yp/9d3uY6MTwM
         g1XHhltWlu8ZYbo88NYJsL/0Ofbt+OqdeLn8lvW4LbxHr4ZGhg6GWgLua3sUs+RlXjoi
         KIvpFVfUOZVGj5SKVhDUKqqGX2fACX3/ABTBoLDdcdhZRg0PhyzKVAhNbOwdtYl56xqw
         z2SWExG1BSwIU02YoyziN59z4dhtgoYL+ZCzoep3UiDzGlaTxU7ieZUASB4YGPRyLoO6
         bfkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=V0F2q6DWz68y9EMObI0aq5egV2DxRbNMTPAOBAB1rDo=;
        b=Rk9XuXoqKDs1VpV+kFNzUHy4tESWpfWADWOE+TtqOabKNLkhFKTcZFGy/aQZLCUdWN
         YxORHIyrhSJSs9CpNDcCLcvzdY84FEk5wb5FhWn1BKEr7Wz+DyNj3T08nhsXkEYgKMKp
         8Nje6CTDrHgHHi4/SqyqmDObleYxWL7bf14dOXzzCmfrruIDZ0hWDCgFYb/bHtJMvSKA
         cFO0inB/k5Pg51r1027TIt6zkUMl0nPK7IMDcOkACtHz9WYtR7irSns9thZb2H+Xu1JN
         Lt9VbLTcsD5m7RxYqHg54KN3MTxKSPHo1NfBsrwYuRAX3eSYFRA6G7KF/3ao18GIaHRO
         6dYQ==
X-Gm-Message-State: AOAM532jbIlAaj68Du8m5PYKsHfohrXEMKPinS4EdksTrv6mIBePjUUl
        abgsqih7PZ0gi6jqYtMHaoUjXtcrexGz6hudbrtwf+z3f5LqMkrdZX9+yr5DrXzSRNy8Jr3JwY3
        qINItqFewrA4II967Jxm0BeZD3wtxpCY3ytAVXJL0bra/4PAuG7NwsX4dJWUCub6eGUOlP523Yj
        G2v4fn+4fgMSk=
X-Google-Smtp-Source: ABdhPJws0kCCcrQhwUpsCaEPmoE5NddZGiLCY9RgLrlu9C2DK6oNar+CTcQ2ZNPjo8vOfz+mDHnIny5pYpkE/StJtQ==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:42fe:de1a:97f8:9006])
 (user=howardchung job=sendgmr) by 2002:a25:2496:: with SMTP id
 k144mr12045177ybk.366.1628666320938; Wed, 11 Aug 2021 00:18:40 -0700 (PDT)
Date:   Wed, 11 Aug 2021 15:17:57 +0800
Message-Id: <20210811151742.Bluez.v1.1.I3c1703ddae63da383b15e001bc965dadb4bd00b8@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [Bluez PATCH v1] plugins/admin: add uuid duplicate check
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     Yun-Hao Chung <howardchung@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Yun-Hao Chung <howardchung@chromium.org>

SetServiceAllowlist should ignore those duplicated UUIDs.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---
Test steps:
1. set service allow list to ["1800", "1800", "180A"] via D-Bus
2. check service allow list is ["1800", "180A"]

 plugins/admin.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/plugins/admin.c b/plugins/admin.c
index 428a5528cc88..aea33cb71ac2 100644
--- a/plugins/admin.c
+++ b/plugins/admin.c
@@ -85,6 +85,14 @@ static void admin_policy_free(void *data)
 	g_free(admin_policy);
 }
 
+static bool uuid_match(const void *data, const void *match_data)
+{
+	const bt_uuid_t *uuid = data;
+	const bt_uuid_t *match_uuid = match_data;
+
+	return bt_uuid_cmp(uuid, match_uuid) == 0;
+}
+
 static struct queue *parse_allow_service_list(struct btd_adapter *adapter,
 							DBusMessage *msg)
 {
@@ -119,9 +127,15 @@ static struct queue *parse_allow_service_list(struct btd_adapter *adapter,
 			goto failed;
 		}
 
+		dbus_message_iter_next(&arr_iter);
+
+		if (queue_find(uuid_list, uuid_match, uuid)) {
+			g_free(uuid);
+			continue;
+		}
+
 		queue_push_head(uuid_list, uuid);
 
-		dbus_message_iter_next(&arr_iter);
 	} while (true);
 
 	return uuid_list;
-- 
2.32.0.605.g8dce9f2422-goog

