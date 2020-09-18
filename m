Return-Path: <SRS0=JXiH=C3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867EEC43464
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Sep 2020 22:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4928F21734
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Sep 2020 22:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J/Bfsul9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbgIRWOX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Sep 2020 18:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgIRWOW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Sep 2020 18:14:22 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6ECC0613CE
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2020 15:14:22 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id v106so6975068ybi.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2020 15:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=+UYsjiFI/CQBXYMas9iBIuEs/wH6yGhZNNWuNxXrA70=;
        b=J/Bfsul9xGv5hj9OBtPkKSnLS5qbnVUUGCAqAI2l9bu9FkpVBQnF7Ohs3YtRsH0QdG
         mjdLtDAcCaixXwgqdg20RwJLH1ZrKHVF1l2UPq7D3PjI1xFJ+7Jn77mHRVHSQqznLiX8
         4hEYyC+HPEG0hhVHQQvK4r5fovcz74hmLBjkNPE27BXKcF889kn7CYtsyViCWKYbIEdJ
         KzFLi3TR8Jwof9iacKcFEjP3XwOyWtgJvB0GKY/cMCR9PNsj+QXrRhzA+1ItSAFaJZ0y
         09bAUq/Ktx8QeHwqL3b4Ae2wmRIHcaH35/vac6unqnT8Xa8nb9YL2Z86M0WuJq927ZtL
         c9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+UYsjiFI/CQBXYMas9iBIuEs/wH6yGhZNNWuNxXrA70=;
        b=eMJK02E4J8XAj4J//EsjHyW63gaU8A1K/zsllX1cIwXsldhooFx19jqAXhdfG7Ic3k
         pNEm8PByp/aFaUYl803sH7ZIe2bnjkhlOsbc3KDKtHxKCwA/vZFdOp4xIPUYkr8kcuaa
         7YQSdvrRh8mxJvjaNVd6n9OxqEiUjmlGSqsUmg0E6fA8Xw+BpUc3QUY37APm1NlEII2C
         m6RFMMKTOi4HewwVwMQF9wjz6EsbG6ctoju+i9vjsshdz88xt3P3B8gNJ0IqzvxuJ/n2
         Y8IZKY8v6XI14m0m5MJS+pyt0bS91etqX+FANvh0rDGB8D/Bynd9Apk37OxurbS7m9MA
         YHeQ==
X-Gm-Message-State: AOAM530Qyd3G20BasNZ5m0lx6PIhxF1fZxJoEeE31F0MJCx0MuO0AVPP
        DaIpBOZ5OBRhbxFNAnS4JLVfA7phxVMeJkjqwVx9
X-Google-Smtp-Source: ABdhPJz/spiKMlDvuZqviGpK3QGuRfLnbxYGhWF14vLgyCQE1DZyHyVO7eSRxCmF2M/Zw0+c+5FtUZVu1EXHLpa+LTWR
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a5b:d09:: with SMTP id
 y9mr21019625ybp.258.1600467261906; Fri, 18 Sep 2020 15:14:21 -0700 (PDT)
Date:   Fri, 18 Sep 2020 15:13:54 -0700
In-Reply-To: <20200918221357.3436905-1-danielwinkler@google.com>
Message-Id: <20200918151041.Bluez.v2.7.I187f71748b9bd93f6bf97ec4a195216109c3ea06@changeid>
Mime-Version: 1.0
References: <20200918221357.3436905-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [Bluez PATCH v2 07/10] advertising: Query LE TX range at manager initialization
From:   Daniel Winkler <danielwinkler@google.com>
To:     luiz.von.dentz@intel.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Daniel Winkler <danielwinkler@google.com>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch calls the new MGMT command to get controller capabilities,
and parses the min and max LE tx power range when the manager is
initialized. This will be used to populate a client-facing dbus entry so
that the client will know the advertising capabilities of the controller
before registering an advertisement.

This patch is tested by manually verifying the data is parsed correctly
from the MGMT response.

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
Reviewed-by: Alain Michaud <alainm@chromium.org>
---

Changes in v2: None

 lib/mgmt.h        |  8 +++++++
 src/advertising.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 56f46ce93..558452e9c 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -744,6 +744,14 @@ struct mgmt_rp_add_ext_adv_data {
 	uint8_t	instance;
 } __packed;
 
+#define MGMT_CAP_LE_TX_PWR_MIN	0x0000
+#define MGMT_CAP_LE_TX_PWR_MAX	0x0001
+
+#define MGMT_OP_READ_CONTROLLER_CAP	0x0056
+struct mgmt_rp_read_controller_cap {
+	uint8_t capabilities[0]; /* mgmt_tlv */
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	uint16_t opcode;
diff --git a/src/advertising.c b/src/advertising.c
index c7deda1ad..a3e7f3d59 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -58,6 +58,8 @@ struct btd_adv_manager {
 	uint32_t supported_flags;
 	unsigned int instance_bitmap;
 	bool extended_add_cmds;
+	int8_t min_tx_power;
+	int8_t max_tx_power;
 };
 
 #define AD_TYPE_BROADCAST 0
@@ -1708,6 +1710,54 @@ static void tx_power_selected(uint16_t index, uint16_t length,
 				DBUS_TYPE_INT16, &tx_power, NULL, NULL, NULL);
 }
 
+static void read_controller_cap_complete(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct btd_adv_manager *manager = user_data;
+	const uint8_t *ptr = param;
+	uint16_t offset = 0;
+
+	/* Both capabilities we care about are stored as int8_t. If we later
+	 * want to track other types, this structure will need to change
+	 */
+	const struct {
+		struct mgmt_tlv entry;
+		int8_t value;
+	} __packed * cap;
+
+	while (offset < length) {
+		/* Since TLV entries can have variable length, offset tracks how
+		 * far into the member we are, so that cap is always pointing
+		 * to the beginning of a valid struct
+		 */
+		cap = (void *)&ptr[offset];
+		switch (cap->entry.type) {
+		case MGMT_CAP_LE_TX_PWR_MIN:
+			if (cap->entry.length !=
+					sizeof(manager->min_tx_power)) {
+				error("TX power had unexpected length %d",
+					cap->entry.length);
+				break;
+			}
+			memcpy(&manager->min_tx_power, &cap->value,
+					cap->entry.length);
+			break;
+		case MGMT_CAP_LE_TX_PWR_MAX:
+			if (cap->entry.length !=
+					sizeof(manager->min_tx_power)) {
+				error("TX power had unexpected length %d",
+					cap->entry.length);
+				break;
+			}
+			memcpy(&manager->max_tx_power, &cap->value,
+					cap->entry.length);
+			break;
+		}
+
+		offset += sizeof(cap->entry) + cap->entry.length;
+	}
+}
+
 static struct btd_adv_manager *manager_create(struct btd_adapter *adapter,
 						struct mgmt *mgmt)
 {
@@ -1729,6 +1779,8 @@ static struct btd_adv_manager *manager_create(struct btd_adapter *adapter,
 	manager->supported_flags = MGMT_ADV_FLAG_LOCAL_NAME;
 	manager->extended_add_cmds =
 			btd_has_kernel_features(KERNEL_HAS_EXT_ADV_ADD_CMDS);
+	manager->min_tx_power = ADV_TX_POWER_NO_PREFERENCE;
+	manager->max_tx_power = ADV_TX_POWER_NO_PREFERENCE;
 
 	if (!g_dbus_register_interface(btd_get_dbus_connection(),
 					adapter_get_path(manager->adapter),
@@ -1750,6 +1802,13 @@ static struct btd_adv_manager *manager_create(struct btd_adapter *adapter,
 			      manager->mgmt_index, tx_power_selected,
 			      manager, NULL);
 
+	/* Query controller capabilities. This will be used to display valid
+	 * advertising tx power range to the client.
+	 */
+	mgmt_send(manager->mgmt, MGMT_OP_READ_CONTROLLER_CAP,
+			manager->mgmt_index, 0, NULL,
+			read_controller_cap_complete, manager, NULL);
+
 	return manager;
 
 fail:
-- 
2.28.0.681.g6f77f65b4e-goog

