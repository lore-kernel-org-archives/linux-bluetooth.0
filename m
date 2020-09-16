Return-Path: <SRS0=qc6f=CZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018B1C43461
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Sep 2020 23:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE44B22207
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Sep 2020 23:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="uwbghoe4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgIPXZ5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Sep 2020 19:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbgIPXZy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Sep 2020 19:25:54 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2B4C06174A
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 16:25:54 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id a13so201676qvl.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 16:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=+huwA4s3GAFhv45nHY4OvTaynBIxEfkWAWQB5QE2L54=;
        b=uwbghoe4ssspaSoLZHEcVPdKVJc3GC7g1/QIREF/6902DhbhPNUn3bqEfJvLn/RzPE
         Nhc4eT2WcHSlXATu1DbUD6rUWOX1K62UpRXVMQonKqMCIHhrDOwy+AEuXM1Gd/Dr+k6S
         D0L6SMAUd4eviI6EzdNQxtoTRaeIkLaFBI26vLaGC4cFqYVCbgNJxEWecm3aFHJvm1wp
         /HI3amMOSurMbOCXBlQGG4XIOAR9k1Ui3UtQd+CZbHYe/9/SujX4+ramnNZbTBottv1w
         tKGz0kinQ3pQuBmJAFqnLS2Ig7++ar3xbRo3CN/0p1KlCWpPr9UcKZFLcPT7avmtOgze
         0OqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+huwA4s3GAFhv45nHY4OvTaynBIxEfkWAWQB5QE2L54=;
        b=i1Z6f9Pj2OQbNupj6RgP/yEdsDTCH4xoiBJnHy/ufcn2ecqx0yJx26HC+E9Ez574Rg
         HzAzGMcKyBtjyLwX6tXdQL9cqF2RZUD+1utgLz1Gkbhx1R30OuD/m6VaM2k8KGOqHj7Y
         ZDFGLD/y2ssgpKDDzQVP49xoZ2ULgREBLGZLezwWF/XMiHtByyCZw3bt4G+vwcxfNolL
         TSXXKpDmx1x9dtq+kJtmHLnwUtf2ZcCvvdBFDrPul/x+GgTcA4nf+cGuS8DRf5JCIbM/
         2owf5bz1FWU+winCMjnbZHp4u35M4rQcQeTX1hOD71otCfAxA/foFk2MBoCgM1OFG7VV
         M+xA==
X-Gm-Message-State: AOAM533oJnOUEsFuzKSQ7stJsOMcuiSOlrSebEb4pTP3i0jCmjlVzIrB
        z6u8jJd7Emfw7YHPSQj9wJ2OMFuhg81YAW2+6sst
X-Google-Smtp-Source: ABdhPJwtDxkV5u7l6zrBENrrmQ6NvJBaNyScwtPPsc57GvJrU9AcqdvzPCeZfAKwaDYDSifsU8N6/Ba5GKvOkJKmpvW8
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a0c:8246:: with SMTP id
 h64mr9715968qva.54.1600298753081; Wed, 16 Sep 2020 16:25:53 -0700 (PDT)
Date:   Wed, 16 Sep 2020 16:25:33 -0700
In-Reply-To: <20200916232542.1584854-1-danielwinkler@google.com>
Message-Id: <20200916162155.Bluez.1.I50d9faa25e9da6e71d77c83c7d47a5b135e88799@changeid>
Mime-Version: 1.0
References: <20200916232542.1584854-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [Bluez PATCH 01/10] advertising: Detect if extended advertising mgmt
 commands are supported
From:   Daniel Winkler <danielwinkler@google.com>
To:     luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Daniel Winkler <danielwinkler@google.com>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

We need to know if kernel supports the new MGMT interface. To do so, we
call MGMT_OP_READ_COMMANDS when our manager is created and check if the
new commands are available. This will then be used to route our requests
for new advertisements.

The change is tested by manually verifying that the correct MGMT
commands are used when the feature is and is not available in kernel.

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
---

 src/advertising.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/src/advertising.c b/src/advertising.c
index e5f25948d..172a83907 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -57,6 +57,7 @@ struct btd_adv_manager {
 	uint8_t max_ads;
 	uint32_t supported_flags;
 	unsigned int instance_bitmap;
+	bool extended_add_cmds;
 };
 
 #define AD_TYPE_BROADCAST 0
@@ -1407,6 +1408,51 @@ static void read_adv_features_callback(uint8_t status, uint16_t length,
 		remove_advertising(manager, 0);
 }
 
+static void read_commands_complete(uint8_t status, uint16_t length,
+				   const void *param, void *user_data)
+{
+	struct btd_adv_manager *manager = user_data;
+	const struct mgmt_rp_read_commands *rp = param;
+	uint16_t num_commands, num_events;
+	size_t expected_len;
+	int i;
+
+	if (status != MGMT_STATUS_SUCCESS) {
+		error("Failed to read supported commands: %s (0x%02x)",
+						mgmt_errstr(status), status);
+		return;
+	}
+
+	if (length < sizeof(*rp)) {
+		error("Wrong size of read commands response");
+		return;
+	}
+
+	num_commands = btohs(rp->num_commands);
+	num_events = btohs(rp->num_events);
+
+	expected_len = sizeof(*rp) + num_commands * sizeof(uint16_t) +
+						num_events * sizeof(uint16_t);
+
+	if (length < expected_len) {
+		error("Too small reply for supported commands: (%u != %zu)",
+							length, expected_len);
+		return;
+	}
+
+	for (i = 0; i < num_commands; i++) {
+		uint16_t op = get_le16(rp->opcodes + i);
+
+		switch (op) {
+		case MGMT_OP_ADD_EXT_ADV_PARAMS:
+			manager->extended_add_cmds = true;
+			break;
+		default:
+			break;
+		}
+	}
+}
+
 static struct btd_adv_manager *manager_create(struct btd_adapter *adapter,
 						struct mgmt *mgmt)
 {
@@ -1426,6 +1472,7 @@ static struct btd_adv_manager *manager_create(struct btd_adapter *adapter,
 	manager->mgmt_index = btd_adapter_get_index(adapter);
 	manager->clients = queue_new();
 	manager->supported_flags = MGMT_ADV_FLAG_LOCAL_NAME;
+	manager->extended_add_cmds = false;
 
 	if (!g_dbus_register_interface(btd_get_dbus_connection(),
 					adapter_get_path(manager->adapter),
@@ -1442,6 +1489,13 @@ static struct btd_adv_manager *manager_create(struct btd_adapter *adapter,
 		goto fail;
 	}
 
+	/* Determine if kernel supports extended advertising add command. We
+	 * don't care if this request fails, as we will fall back to legacy
+	 * add_advertising by default
+	 */
+	mgmt_send(manager->mgmt, MGMT_OP_READ_COMMANDS, MGMT_INDEX_NONE, 0,
+		  NULL, read_commands_complete, manager, NULL);
+
 	return manager;
 
 fail:
-- 
2.28.0.618.gf4bc123cb7-goog

