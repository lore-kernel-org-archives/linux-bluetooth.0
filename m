Return-Path: <SRS0=+RU5=DC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB2BC4346E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Sep 2020 01:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C12C20791
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Sep 2020 01:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IPyuG09J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgIYBOK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Sep 2020 21:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbgIYBOK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Sep 2020 21:14:10 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26CCC0613CE
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2020 18:14:09 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id j6so619988pjy.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2020 18:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=fs4I7rffkL21exQ8AVdd2XidKmb6KYwcU4ElTJtrox8=;
        b=IPyuG09Jr+QRFHMpgA4AYepFG+oWQk4j2Pqo+VePU5OwvDMYP1JUI5aWAjd9vbjZ9W
         +h5Xqk2rbst4WheY29536gs3BC21WvLM5P2zFvRQN2DLUl7gsgDY+Xp/R9U6xs1SBZoh
         v42NtDUI3yaquo3YrMrMRxzSR+wkzzkM4ZLyqDkjzm/Tan3ex5XmNDnMkbV1KMNAXLMm
         unTuIhH/66ejvUZmFxuUmC7TWKQpgPu1LCtxcVJBNQMCPjNRZrooAIbL3zzJz8i6dkC9
         r0DRtSZTze1ChPwUeF4o5gGKI3BJgII1mO3ZkihkkcXQ7RR1u6JVT04FHnR154DRM4Ux
         bdxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fs4I7rffkL21exQ8AVdd2XidKmb6KYwcU4ElTJtrox8=;
        b=Eh4H/AtyndfPLQf7rci3GsSEakwk2TvFRNqEIbZ6SaOE68ZGF9z8yggE+nPLeZtD0e
         k1gqG3rLb0SCjIRM+F0jUwmDAS2crMQcAG9kI7V6z88lY2MWQ2Hh4A9t2xBK+dqoik5q
         k2ZPsfOVTcztATdr3rgezYhPS+FNxHooA8nM29LCcilZuTSqd7BSjiS9eGmZiRiMNenR
         Adn3tvAvEQyHJNYdVrDeIPp6u3gwuiWiaa/MTI/rzldashu6H+jSvgrVjjgAUuUTAze5
         x3e8Xvhce2U8TO+IqfkC4NymVDyRy0IiTph9SX8YnOb3j1E86spjRYR9K2PFXN7LRd4A
         HpPA==
X-Gm-Message-State: AOAM530gCQgNsAxb5ZYUUUNgEYxwb8FGwccOqQ9yguD/N031MvpRNkvm
        ShnZL1LZLV+BDrT4O5bTHKFxDSsk35AD8j8jmXaO
X-Google-Smtp-Source: ABdhPJwJC3JR+V8MMEI+jMnulz86ACQQ6swE+qBTVYAgBTw/03a5xbH9JzxlSnhAvSbQa4jqmM/6zDQA3WKHz3FMF+M7
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a17:90b:20d1:: with SMTP id
 ju17mr334086pjb.134.1600996449288; Thu, 24 Sep 2020 18:14:09 -0700 (PDT)
Date:   Thu, 24 Sep 2020 18:13:44 -0700
In-Reply-To: <20200925011347.2478464-1-danielwinkler@google.com>
Message-Id: <20200924180838.Bluez.v3.6.I187f71748b9bd93f6bf97ec4a195216109c3ea06@changeid>
Mime-Version: 1.0
References: <20200925011347.2478464-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [Bluez PATCH v3 6/9] advertising: Query LE TX range at manager initialization
From:   Daniel Winkler <danielwinkler@google.com>
To:     luiz.von.dentz@intel.com
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
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

Changes in v3: None
Changes in v2: None

 lib/mgmt.h        | 15 ++++++++----
 src/advertising.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++
 tools/btmgmt.c    | 12 +++++-----
 3 files changed, 78 insertions(+), 10 deletions(-)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index fa0c2b562..baeb0d82b 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -608,10 +608,17 @@ struct mgmt_cp_set_blocked_keys {
 	struct mgmt_blocked_key_info keys[0];
 } __packed;
 
-#define MGMT_OP_READ_SECURITY_INFO	0x0048
-struct mgmt_rp_read_security_info {
-	uint16_t sec_len;
-	uint8_t  sec[0];
+#define MGMT_CAP_SEC_FLAGS		0x01
+#define MGMT_CAP_MAX_ENC_KEY_SIZE	0x02
+#define MGMT_CAP_SMP_MAX_ENC_KEY_SIZE	0x03
+#define MGMT_CAP_LE_TX_PWR_MIN		0x04
+#define MGMT_CAP_LE_TX_PWR_MAX		0x05
+
+#define MGMT_OP_READ_CONTROLLER_CAP	0x0048
+#define MGMT_READ_CONTROLLER_CAP_SIZE	0
+struct mgmt_rp_read_controller_cap {
+	uint16_t cap_len;
+	uint8_t cap[0];
 } __packed;
 
 #define MGMT_OP_READ_EXP_FEATURES_INFO	0x0049
diff --git a/src/advertising.c b/src/advertising.c
index 3a4379c64..48b3d78b8 100644
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
@@ -1699,6 +1701,58 @@ static void read_adv_features_callback(uint8_t status, uint16_t length,
 		remove_advertising(manager, 0);
 }
 
+static void read_controller_cap_complete(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct btd_adv_manager *manager = user_data;
+	const struct mgmt_rp_read_controller_cap *rp = param;
+	const uint8_t *ptr = rp->cap;
+	size_t offset = 0;
+	uint8_t tag_len;
+	uint8_t tag_type;
+
+	if (status || !param) {
+		error("Failed to read advertising features: %s (0x%02x)",
+						mgmt_errstr(status), status);
+		return;
+	}
+
+	if (sizeof(rp->cap_len) + rp->cap_len != length) {
+		error("Controller capabilities malformed, size %u != %u",
+				sizeof(rp->cap_len) + rp->cap_len, length);
+		return;
+	}
+
+	while (offset < rp->cap_len) {
+		tag_len = ptr[offset++];
+		tag_type = ptr[offset++];
+
+		switch (tag_type) {
+		case MGMT_CAP_LE_TX_PWR_MIN:
+			if ((tag_len - sizeof(tag_type)) !=
+					sizeof(manager->min_tx_power)) {
+				error("TX power had unexpected length %d",
+					tag_len);
+				break;
+			}
+			memcpy(&manager->min_tx_power, &ptr[offset], tag_len);
+			break;
+		case MGMT_CAP_LE_TX_PWR_MAX:
+			if ((tag_len - sizeof(tag_type)) !=
+					sizeof(manager->min_tx_power)) {
+				error("TX power had unexpected length %d",
+					tag_len);
+				break;
+			}
+			memcpy(&manager->max_tx_power, &ptr[offset], tag_len);
+			break;
+		}
+
+		/* Step to the next entry */
+		offset += (tag_len - sizeof(tag_type));
+	}
+}
+
 static struct btd_adv_manager *manager_create(struct btd_adapter *adapter,
 						struct mgmt *mgmt)
 {
@@ -1738,6 +1792,13 @@ static struct btd_adv_manager *manager_create(struct btd_adapter *adapter,
 		goto fail;
 	}
 
+	/* Query controller capabilities. This will be used to display valid
+	 * advertising tx power range to the client.
+	 */
+	mgmt_send(manager->mgmt, MGMT_OP_READ_CONTROLLER_CAP,
+		manager->mgmt_index, 0, NULL,
+		read_controller_cap_complete, manager, NULL);
+
 	return manager;
 
 fail:
diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 48c9e5887..8b1cc4df5 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -1531,7 +1531,7 @@ static void cmd_extinfo(int argc, char **argv)
 static void sec_info_rsp(uint8_t status, uint16_t len, const void *param,
 							void *user_data)
 {
-	const struct mgmt_rp_read_security_info *rp = param;
+	const struct mgmt_rp_read_controller_cap *rp = param;
 	uint16_t index = PTR_TO_UINT(user_data);
 
 	if (status != 0) {
@@ -1546,7 +1546,7 @@ static void sec_info_rsp(uint8_t status, uint16_t len, const void *param,
 	}
 
 	print("Primary controller (hci%u)", index);
-	print("\tSecurity info length: %u", le16_to_cpu(rp->sec_len));
+	print("\tSecurity info length: %u", le16_to_cpu(rp->cap_len));
 
 done:
 	pending_index--;
@@ -1589,11 +1589,11 @@ static void sec_index_rsp(uint8_t status, uint16_t len, const void *param,
 		if (rp->entry[i].type != 0x00)
 			continue;
 
-		if (!mgmt_send(mgmt, MGMT_OP_READ_SECURITY_INFO,
+		if (!mgmt_send(mgmt, MGMT_OP_READ_CONTROLLER_CAP,
 						index, 0, NULL, sec_info_rsp,
 						UINT_TO_PTR(index), NULL)) {
-				error("Unable to send read_security_info cmd");
-				return bt_shell_noninteractive_quit(EXIT_FAILURE);
+			error("Unable to send read_security_info cmd");
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
 		}
 		pending_index++;
 	}
@@ -1615,7 +1615,7 @@ static void cmd_secinfo(int argc, char **argv)
 		return;
 	}
 
-	if (!mgmt_send(mgmt, MGMT_OP_READ_SECURITY_INFO, mgmt_index, 0, NULL,
+	if (!mgmt_send(mgmt, MGMT_OP_READ_CONTROLLER_CAP, mgmt_index, 0, NULL,
 					sec_info_rsp,
 					UINT_TO_PTR(mgmt_index), NULL)) {
 		error("Unable to send read_security_info cmd");
-- 
2.28.0.709.gb0816b6eb0-goog

