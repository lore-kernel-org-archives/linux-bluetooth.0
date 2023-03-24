Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD2CC76196
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Mar 2023 23:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbjCXXjK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Mar 2023 19:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbjCXXjH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Mar 2023 19:39:07 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E601E1E1
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Mar 2023 16:39:04 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id kq3so3243279plb.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Mar 2023 16:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679701143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f+cQEHrmQWsCeZ3GOeOx+fTEZktLd6o7sz8WB+r/j/U=;
        b=FBfgbLRDgWfi3vly0rp0Ly++WOMz/SRgzRrLbBFgpfe3Iu2aebTmUpxd3QUBp8LXG0
         yv8LxbSiGwBK8stE9v25MELGfnD6TGhEpCOS+mU+KeoR2mLBzKqBH++xZn/YM8qvuPyt
         KAW2MhI5qhRIUJmM5mrfxeAzJfzywkXPuZAmUQBZa0BjLI6uog8nXCwh3MJ1kp2T5elp
         UTlXMrrYyeMf7ATl89/QXE+LQlFmyHOxcSavr+iQkZaxvx+8eQWMxuQlkjs4E1ZZH4LO
         mOvr8j/uDWdmvkX+q0w+C3r4qxw8sRJ9yeP+Ku/F3cBQxH6iDL5CC8cbWh2I0RXeeMop
         ErfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679701143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f+cQEHrmQWsCeZ3GOeOx+fTEZktLd6o7sz8WB+r/j/U=;
        b=PMWCS92L+TQxKLovvbZT35+RvYvq3igtr139U8ZCmfZjERsJbZhorzF82UwtpzJO79
         36gcbW8xO2lBeiB0tD83DSwOH4vrOClaqcJcqMWf0rDI0p84VYGZt79ICur0GVKzEzPI
         40PBrbAJwObi/uRx7yT7q7CIDBp1x5WSt+fikuCA9obeYB9L38dIt6348lwJzbhBrQBO
         l87Qnv8BE2/J3TU2/IDL74wdBYaamUDKEUrZl5WL/yJ5zgqVuSsAr4ACxVvv36BE7zwI
         0Md90yk0xrw8xKvuce35EQ/j3V5aXsufXJWfQivVs9pxUITJjmTUaMNSh9uFFZM5DI83
         0Tuw==
X-Gm-Message-State: AAQBX9dsKAtLVV3V155LdQ0CESOhSnMbDlE8TkjmCkH4j8dKY9sc/IIA
        EZpCm9pC/8eu86GmKJm/KRDMRGeAzzo=
X-Google-Smtp-Source: AKy350Z45oym3W04DAkMZsITUAAgbLFHV03KJ8DsPYWSq65Qx/a8xFHihYhQmBo1lki6bOFRnHi0ag==
X-Received: by 2002:a17:903:2291:b0:1a0:549d:3996 with SMTP id b17-20020a170903229100b001a0549d3996mr4538353plh.25.1679701143056;
        Fri, 24 Mar 2023 16:39:03 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id d18-20020a170902aa9200b001a1add0d616sm13666771plr.161.2023.03.24.16.39.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 16:39:02 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/4] monitor: Cache IRK being parsed
Date:   Fri, 24 Mar 2023 16:38:56 -0700
Message-Id: <20230324233856.3693370-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230324233856.3693370-1-luiz.dentz@gmail.com>
References: <20230324233856.3693370-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This caches any IRK being parsed so they can be used to resolve
addresses later which fixes the problem of only being able to resolve
addresses if the monitor happens to be active while SMP exchange the
keys.
---
 monitor/keys.c   | 26 ++++++++++++++++++++++++++
 monitor/keys.h   |  2 ++
 monitor/packet.c |  1 +
 3 files changed, 29 insertions(+)

diff --git a/monitor/keys.c b/monitor/keys.c
index d2fa3b23ffec..c1eebae82ac2 100644
--- a/monitor/keys.c
+++ b/monitor/keys.c
@@ -112,3 +112,29 @@ bool keys_resolve_identity(const uint8_t addr[6], uint8_t ident[6],
 
 	return false;
 }
+
+static bool match_key(const void *data, const void *match_data)
+{
+	const struct irk_data *irk = data;
+	const uint8_t *key = match_data;
+
+	return !memcmp(irk->key, key, 16);
+}
+
+bool keys_add_identity(const uint8_t addr[6], uint8_t addr_type,
+					const uint8_t key[16])
+{
+	struct irk_data *irk;
+
+	irk = queue_find(irk_list, match_key, key);
+	if (!irk) {
+		irk = new0(struct irk_data, 1);
+		memcpy(irk->key, key, 16);
+		queue_push_tail(irk_list, irk);
+	}
+
+	memcpy(irk->addr, addr, 6);
+	irk->addr_type = addr_type;
+
+	return true;
+}
diff --git a/monitor/keys.h b/monitor/keys.h
index e40c90fa9c72..f44d33295269 100644
--- a/monitor/keys.h
+++ b/monitor/keys.h
@@ -20,3 +20,5 @@ void keys_update_identity_addr(const uint8_t addr[6], uint8_t addr_type);
 
 bool keys_resolve_identity(const uint8_t addr[6], uint8_t ident[6],
 							uint8_t *ident_type);
+bool keys_add_identity(const uint8_t addr[6], uint8_t addr_type,
+					const uint8_t key[16]);
diff --git a/monitor/packet.c b/monitor/packet.c
index d9e8abf41fed..c6ff16eda9cf 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -12870,6 +12870,7 @@ static void mgmt_print_identity_resolving_key(const void *data)
 
 	mgmt_print_address(data, address_type);
 	print_hex_field("Key", data + 7, 16);
+	keys_add_identity(data, address_type, data + 7);
 }
 
 static void mgmt_print_signature_resolving_key(const void *data)
-- 
2.39.2

