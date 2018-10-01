Return-Path: <SRS0=AfC+=MN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF8DC43143
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Oct 2018 11:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3C022064D
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Oct 2018 11:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVaQ5Zq+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3C022064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbeJARvA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Oct 2018 13:51:00 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:33004 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728972AbeJARu7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Oct 2018 13:50:59 -0400
Received: by mail-ed1-f44.google.com with SMTP id g26-v6so13828862edp.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Oct 2018 04:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=VRK8rziHSDVFYVXjcul0Rkgbz+S67HEEjwzwJrfagS0=;
        b=ZVaQ5Zq+BAETWMlwPBEKXLE97ha/2J4dhMRUwQ9woXfu8uwqF7WWdbHSUm3CjBf1v5
         xql7GXm8sKCJRgXSgJce6KWveRPBzGCOFkxv0A1DFOQKzdK0yTi4pcFzzR7593u3P9Xf
         h7ABrFCYS+uOPsF0IiOzoZAgZf1/pSjHql908/+Q0CSxDQWG8UVUSE1sMNNh70AoP0Y/
         XBge55ogmx0a0e9RIlzQc6Acf4ZSoxPkW5u0J8y7j6Wcb27lLpwzZb/Rg7CaYMXDXk21
         +PX6WgyRiNq7DPYdWQscPMhvDmXC/Mq1LpPwnXDIaNxQ6RednaqDhRC2b0IbX9r5KmVA
         FMEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=VRK8rziHSDVFYVXjcul0Rkgbz+S67HEEjwzwJrfagS0=;
        b=pi9EPlpDDL/8PouptxPQ1bL0ZootR/4nqAIdbP++gqgyo0MjiMUc8Yvg8R/6q2mXrT
         Q0Ao2qPFXAU/0NkLQg49ohDfXPdkfDvzOhC7RcXLufbV38aqqt5d7xisbMkHibAC9U23
         jX/FgxPA1f9RyZPXi8X9xsf4Vd5U41ec+akC+67KRCLF98V00FjCjM70nnhZPDoXHFBc
         TALYhBggOlBAKdyRLfweT9AL+k+/YoEveZrIJZd56x+wrkwRY2m2KgT2gj4q4DIXPuM8
         GdtXSCQwKy+W/cDH5A9dGfkDGtC1q2dFRuDVfb+q0mCkd/vBsbgjzv9hVKwjRFSZ+Jsx
         zx5g==
X-Gm-Message-State: ABuFfohcH5uV/LgjenkIXWfp/cryvtFxXi2l5wO7U4P3RBGttnZhs7Du
        WCbWuTCw1+GOW75nup1cG1UCXBBi
X-Google-Smtp-Source: ACcGV62nnuJaN+OUhbasUvJuW17/oyVvtz40k+66Ab8evfRBZgWepGkjsbpOJ/i0KoMHHNyo3zGy7Q==
X-Received: by 2002:a17:906:704f:: with SMTP id r15-v6mr13921874ejj.131.1538392421274;
        Mon, 01 Oct 2018 04:13:41 -0700 (PDT)
Received: from vudentzs-t460s.fi.intel.com ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id c29-v6sm2206570eda.53.2018.10.01.04.13.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 04:13:40 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] gatt: Fix not cleaning up device state properly
Date:   Mon,  1 Oct 2018 14:13:38 +0300
Message-Id: <20181001111338.11634-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If the device is removed locally device_free would end up calling
bt_att_unref which won't trigger any disconnect callback necessary
to remove device states.
---
 src/device.c        |  3 +++
 src/gatt-database.c | 24 ++++++++++++++++++++++++
 src/gatt-database.h |  2 ++
 3 files changed, 29 insertions(+)

diff --git a/src/device.c b/src/device.c
index ef5b8f86a..5ddfb9266 100644
--- a/src/device.c
+++ b/src/device.c
@@ -580,6 +580,9 @@ static void gatt_server_cleanup(struct btd_device *device)
 
 	bt_gatt_server_unref(device->server);
 	device->server = NULL;
+
+	btd_gatt_database_att_disconnected(
+			btd_adapter_get_database(device->adapter), device->att);
 }
 
 static void attio_cleanup(struct btd_device *device)
diff --git a/src/gatt-database.c b/src/gatt-database.c
index abcf7b759..bdabcb4d6 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -3349,6 +3349,30 @@ void btd_gatt_database_att_connected(struct btd_gatt_database *database,
 	state->pending = NULL;
 }
 
+void btd_gatt_database_att_disconnected(struct btd_gatt_database *database,
+						struct bt_att *att)
+{
+	struct device_state *state;
+	bdaddr_t bdaddr;
+	uint8_t bdaddr_type;
+
+	DBG("");
+
+	if (!get_dst_info(att, &bdaddr, &bdaddr_type))
+		return;
+
+	state = find_device_state(database, &bdaddr, bdaddr_type);
+	if (!state)
+		return;
+
+	if (state->disc_id) {
+		bt_att_unregister_disconnect(att, state->disc_id);
+		state->disc_id = 0;
+	}
+
+	att_disconnected(0, state);
+}
+
 static void restore_ccc(struct btd_gatt_database *database,
 			const bdaddr_t *addr, uint8_t addr_type, uint16_t value)
 {
diff --git a/src/gatt-database.h b/src/gatt-database.h
index a6c3139c4..9e7cda8c2 100644
--- a/src/gatt-database.h
+++ b/src/gatt-database.h
@@ -25,5 +25,7 @@ void btd_gatt_database_destroy(struct btd_gatt_database *database);
 struct gatt_db *btd_gatt_database_get_db(struct btd_gatt_database *database);
 void btd_gatt_database_att_connected(struct btd_gatt_database *database,
 						struct bt_att *att);
+void btd_gatt_database_att_disconnected(struct btd_gatt_database *database,
+						struct bt_att *att);
 
 void btd_gatt_database_restore_svc_chng_ccc(struct btd_gatt_database *database);
-- 
2.17.1

