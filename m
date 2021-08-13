Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF60AC4320A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A3F3610CF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240353AbhHMMVC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Aug 2021 08:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240328AbhHMMVB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Aug 2021 08:21:01 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26167C061756
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:20:35 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id o11-20020ac85a4b0000b029028acd99a680so6260948qta.19
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6XRTy1u6qcQ2jVTWezczK11htvvoo9E5OQO7JJGG20Y=;
        b=cy4d+NjRhbKqTxUkDWOUuvcGiYoYfj/gAZcLgY1NH7PMCkrF5lRI9iWbI4LkYghp/f
         ZTi7BEtIUBqV64otM00ZkIlKCWJsglQ/uY8OoHqDa5PuY2BQbx/5smdJVP6mX7rHGSNZ
         Oa1JGYmthfMTp7OJQ5D9IwJrmtBn/sDE52tS7wZA9DebV/QxGlQDdo9sQzDHz3demPaO
         FD9PxAi0/db8Qo2sqizUq5hal8oNtByK9UFo+HTsDL2fYFSN+/h/T4ilI+S8OAt3DSAm
         K000nX/7nyJ6qdKM5kf0NStvuJWeXioLSDjJDqnYMMTNLeDYCFx/TkBNJHv4Cs+B92Ry
         ertw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6XRTy1u6qcQ2jVTWezczK11htvvoo9E5OQO7JJGG20Y=;
        b=ZWrPVOYAoIZ1TsuMcFyZz9XvCAw3E4olfRh8cXZBIu0jt9YnOgVK3BvefXNubkAoIT
         M3pW2gEll5nzVAhnqa3raaSkWgUvcwegarcx3zRPQoUh3qwTG3hW/kJW5ULbX22nzIgg
         hz89er4GnUlgEgeXuf4mE199dLW1eI9QEqh5Jy4ZyQmQM1Mi4Z8Vuopt20DoggdUP8sK
         NQmA/oEFqs61JoXaem18OIQxNfVarwvXPU5PRUlwyZDgfCtWk9QKz3bWz/sEwqPuNgtz
         Z7r1B6OL5uxbLWgVFy3hH/HLBvY3Db/TufKLIwSYkdj9UbB/nzxX3tqpFT2ZeS1l45Oq
         /N/Q==
X-Gm-Message-State: AOAM531T7ge2ebTJ/6mPO9y5XpJS7r06xlJeX51vcaqEeYZbT/ROQVJ7
        /mYFG4lOCC67RLm/FimmmJKqvR6hxr8WZWGjwWgdLdGLepTkaWmpJuJkwU1P7qPGwri74c39Kw3
        qrTt1GkmJhFD710MhBEnF8GJYcTQ+89vCwB7OOLjgMm/rL9v+yU4raWBA++mS5iwf3pUqpV0/IC
        DI
X-Google-Smtp-Source: ABdhPJytDB6VxXoZSXsIz6DEXI6IwO/Xl/izKQ6icXpco5v3lwDIgEvc81P//t4DO3g+Egly7JEL+iLkvbJ6
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:b68c:ff41:db76:21e9])
 (user=apusaka job=sendgmr) by 2002:ad4:5c62:: with SMTP id
 i2mr2413166qvh.32.1628857234285; Fri, 13 Aug 2021 05:20:34 -0700 (PDT)
Date:   Fri, 13 Aug 2021 20:18:01 +0800
In-Reply-To: <20210813121848.3686029-1-apusaka@google.com>
Message-Id: <20210813201256.Bluez.16.I712b6ffc914c7a88acc173556e03021b31543e60@changeid>
Mime-Version: 1.0
References: <20210813121848.3686029-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [Bluez PATCH 16/62] monitor: Inclusive language in link key transaction
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

"link key" or "temporary link key" are preferred, as reflected in
the BT core spec 5.3.
---

 monitor/bt.h     |  8 ++++----
 monitor/packet.c | 18 +++++++++---------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index 888dbe3d89..70e18cc171 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -628,8 +628,8 @@ struct bt_hci_cmd_change_conn_link_key {
 	uint16_t handle;
 } __attribute__ ((packed));
 
-#define BT_HCI_CMD_MASTER_LINK_KEY		0x0417
-struct bt_hci_cmd_master_link_key {
+#define BT_HCI_CMD_LINK_KEY_SELECTION		0x0417
+struct bt_hci_cmd_link_key_selection {
 	uint8_t  key_flag;
 } __attribute__ ((packed));
 
@@ -2931,8 +2931,8 @@ struct bt_hci_evt_change_conn_link_key_complete {
 	uint16_t handle;
 } __attribute__ ((packed));
 
-#define BT_HCI_EVT_MASTER_LINK_KEY_COMPLETE	0x0a
-struct bt_hci_evt_master_link_key_complete {
+#define BT_HCI_EVT_LINK_KEY_TYPE_CHANGED	0x0a
+struct bt_hci_evt_link_key_type_changed {
 	uint8_t  status;
 	uint16_t handle;
 	uint8_t  key_flag;
diff --git a/monitor/packet.c b/monitor/packet.c
index 3609235d06..5c0fe400da 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -2901,7 +2901,7 @@ static const struct bitfield_data events_table[] = {
 	{  6, "Remote Name Request Complete"				},
 	{  7, "Encryption Change"					},
 	{  8, "Change Connection Link Key Complete"			},
-	{  9, "Master Link Key Complete"				},
+	{  9, "Link Key Type Changed"					},
 	{ 10, "Read Remote Supported Features Complete"			},
 	{ 11, "Read Remote Version Information Complete"		},
 	{ 12, "QoS Setup Complete"					},
@@ -4253,9 +4253,9 @@ static void change_conn_link_key_cmd(const void *data, uint8_t size)
 	print_handle(cmd->handle);
 }
 
-static void master_link_key_cmd(const void *data, uint8_t size)
+static void link_key_selection_cmd(const void *data, uint8_t size)
 {
-	const struct bt_hci_cmd_master_link_key *cmd = data;
+	const struct bt_hci_cmd_link_key_selection *cmd = data;
 
 	print_key_flag(cmd->key_flag);
 }
@@ -8416,8 +8416,8 @@ static const struct opcode_data opcode_table[] = {
 				set_conn_encrypt_cmd, 3, true },
 	{ 0x0415,  17, "Change Connection Link Key",
 				change_conn_link_key_cmd, 2, true },
-	{ 0x0417,  18, "Master Link Key",
-				master_link_key_cmd, 1, true },
+	{ 0x0417,  18, "Temporary Link Key",
+				link_key_selection_cmd, 1, true },
 	{ 0x0419,  19, "Remote Name Request",
 				remote_name_request_cmd, 10, true },
 	{ 0x041a,  20, "Remote Name Request Cancel",
@@ -9493,9 +9493,9 @@ static void change_conn_link_key_complete_evt(const void *data, uint8_t size)
 	print_handle(evt->handle);
 }
 
-static void master_link_key_complete_evt(const void *data, uint8_t size)
+static void link_key_type_changed_evt(const void *data, uint8_t size)
 {
-	const struct bt_hci_evt_master_link_key_complete *evt = data;
+	const struct bt_hci_evt_link_key_type_changed *evt = data;
 
 	print_status(evt->status);
 	print_handle(evt->handle);
@@ -11073,8 +11073,8 @@ static const struct event_data event_table[] = {
 				encrypt_change_evt, 4, true },
 	{ 0x09, "Change Connection Link Key Complete",
 				change_conn_link_key_complete_evt, 3, true },
-	{ 0x0a, "Master Link Key Complete",
-				master_link_key_complete_evt, 4, true },
+	{ 0x0a, "Link Key Type Changed",
+				link_key_type_changed_evt, 4, true },
 	{ 0x0b, "Read Remote Supported Features",
 				remote_features_complete_evt, 11, true },
 	{ 0x0c, "Read Remote Version Complete",
-- 
2.33.0.rc1.237.g0d66db33f3-goog

