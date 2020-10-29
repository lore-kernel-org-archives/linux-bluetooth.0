Return-Path: <SRS0=NHH5=EE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45198C2D0A3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 23:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D05C92076D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 23:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qOgCOL+d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbgJ2XGq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Oct 2020 19:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgJ2XGq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Oct 2020 19:06:46 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9D2C0613CF
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2020 16:06:44 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id h20so3046028plr.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2020 16:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=g4PW5RzbK7Ij0OSBdI/okxbzAFUw1O+1dvC3Arqh7Q0=;
        b=qOgCOL+dFH2AnBk0T3dwC3B7ZveyCsoM8MaRz/K/ilJjEy3zMBJylQYUNfNQR0ZqLq
         fWZb8PzJkw5zor0xzuZbxXb3AwwVVqMj6bgEm+CGMGNdF+gOkQMi024/1ipztAfUBKZt
         8NUhtDyHoBBY1yBdGSF9GuCJTZZb2iRwuXTMzceVKBLi6MOPg2GTIjTGgU9J8X4IrK2X
         wCYBTFXXKZ/UKI012ZvYSP6ocPZ9DliYj78l2vUA7c4eLIhYFQ7x8UojL+v1wTk3iXg+
         e3o/VKWhoptLgRw0n2coK0/P6eKdGn7SOzTzBH+fHlTG0RUhjdc987WbPdcUt9mIJYNo
         +XEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=g4PW5RzbK7Ij0OSBdI/okxbzAFUw1O+1dvC3Arqh7Q0=;
        b=ZQNWO5mssAO5/Wc3K3rktTrMqzdNUis2EB1rQRWNkjpRj0MTsueQlOCptBaF1vN/6/
         lnvSdEsza6i2RXZGzkXhebyQpPMd6RpfEba/Abzx1m5z4/sElu1EE01c5uUDclCCxuC4
         UW2UqxjR9OiA/4hDDPasnG38/1NCVS2pdcmnpGjEe+RWo4oxRnk/zTjR0M8DipCmqzzp
         XPLExmrD9G2nEqcEhmiulgM6hKF33vtc7vGn9hcB8VhaW5meDbqVcR7KsPLm8KHUZRxP
         +IgU5W8VAQWTHmJq3kIxUPQUawD5CYCVfgCcxIRVfeJAxLTJlNp24wXbGTSJ8A703L+c
         QmdA==
X-Gm-Message-State: AOAM530/oFUna4PA72uclSh9lZafhG2BD6AcLwYHKqXMJzlzYy9aiGO/
        OFvuHCnewiYQWH9Xj1PnKGQt0lwzcsB1xNxBErDq
X-Google-Smtp-Source: ABdhPJxXU6QDDmPvm1OOZ1les0E8tWSQKvnQ1PbqPbZMXjNTXhCsBtAZ+VHg0L76zGh1yfmJACyY1QfFcPmKbsWSYYxX
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a17:90a:5991:: with SMTP id
 l17mr125427pji.0.1604012804039; Thu, 29 Oct 2020 16:06:44 -0700 (PDT)
Date:   Thu, 29 Oct 2020 16:06:19 -0700
In-Reply-To: <20201029230623.3630069-1-danielwinkler@google.com>
Message-Id: <20201029160317.Bluez.v6.7.I187f71748b9bd93f6bf97ec4a195216109c3ea06@changeid>
Mime-Version: 1.0
References: <20201029230623.3630069-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [Bluez PATCH v6 07/10] advertising: Query LE TX range at manager initialization
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

Changes in v6: None
Changes in v5:
- Verify capabilities MGMT command is supported before calling it

Changes in v4:
- Move tx power range into single capability field

Changes in v3: None
Changes in v2: None

 lib/mgmt.h        | 14 ++++++++----
 src/adapter.c     |  4 ++++
 src/adapter.h     |  1 +
 src/advertising.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++
 tools/btmgmt.c    | 12 +++++-----
 5 files changed, 77 insertions(+), 10 deletions(-)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 7ab4fb797..f37f7e654 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -599,10 +599,16 @@ struct mgmt_cp_set_blocked_keys {
 	struct mgmt_blocked_key_info keys[0];
 } __packed;
 
-#define MGMT_OP_READ_SECURITY_INFO	0x0048
-struct mgmt_rp_read_security_info {
-	uint16_t sec_len;
-	uint8_t  sec[0];
+#define MGMT_CAP_SEC_FLAGS		0x01
+#define MGMT_CAP_MAX_ENC_KEY_SIZE	0x02
+#define MGMT_CAP_SMP_MAX_ENC_KEY_SIZE	0x03
+#define MGMT_CAP_LE_TX_PWR		0x04
+
+#define MGMT_OP_READ_CONTROLLER_CAP	0x0048
+#define MGMT_READ_CONTROLLER_CAP_SIZE	0
+struct mgmt_rp_read_controller_cap {
+	uint16_t cap_len;
+	uint8_t cap[0];
 } __packed;
 
 #define MGMT_OP_READ_EXP_FEATURES_INFO	0x0049
diff --git a/src/adapter.c b/src/adapter.c
index 90beb897f..cac90b01b 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -9570,6 +9570,10 @@ static void read_commands_complete(uint8_t status, uint16_t length,
 			DBG("kernel supports ext adv commands");
 			kernel_features |= KERNEL_HAS_EXT_ADV_ADD_CMDS;
 			break;
+		case MGMT_OP_READ_CONTROLLER_CAP:
+			DBG("kernel supports controller cap command");
+			kernel_features |= KERNEL_HAS_CONTROLLER_CAP_CMD;
+			break;
 		default:
 			break;
 		}
diff --git a/src/adapter.h b/src/adapter.h
index ace72affd..e5750a37b 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -234,6 +234,7 @@ enum kernel_features {
 	KERNEL_EXP_FEATURES		= 1 << 3,
 	KERNEL_HAS_RESUME_EVT		= 1 << 4,
 	KERNEL_HAS_EXT_ADV_ADD_CMDS	= 1 << 5,
+	KERNEL_HAS_CONTROLLER_CAP_CMD	= 1 << 6,
 };
 
 bool btd_has_kernel_features(uint32_t feature);
diff --git a/src/advertising.c b/src/advertising.c
index e0de31098..9008b7813 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -49,6 +49,8 @@ struct btd_adv_manager {
 	uint32_t supported_flags;
 	unsigned int instance_bitmap;
 	bool extended_add_cmds;
+	int8_t min_tx_power;
+	int8_t max_tx_power;
 };
 
 #define AD_TYPE_BROADCAST 0
@@ -1701,6 +1703,49 @@ static void read_adv_features_callback(uint8_t status, uint16_t length,
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
+		error("Controller capabilities malformed, size %lu != %u",
+				sizeof(rp->cap_len) + rp->cap_len, length);
+		return;
+	}
+
+	while (offset < rp->cap_len) {
+		tag_len = ptr[offset++];
+		tag_type = ptr[offset++];
+
+		switch (tag_type) {
+		case MGMT_CAP_LE_TX_PWR:
+			if ((tag_len - sizeof(tag_type)) !=
+					2*sizeof(manager->min_tx_power)) {
+				error("TX power had unexpected length %d",
+					tag_len);
+				break;
+			}
+			memcpy(&manager->min_tx_power, &ptr[offset], tag_len);
+			memcpy(&manager->max_tx_power, &ptr[offset+1], tag_len);
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
@@ -1722,6 +1767,8 @@ static struct btd_adv_manager *manager_create(struct btd_adapter *adapter,
 	manager->supported_flags = MGMT_ADV_FLAG_LOCAL_NAME;
 	manager->extended_add_cmds =
 			btd_has_kernel_features(KERNEL_HAS_EXT_ADV_ADD_CMDS);
+	manager->min_tx_power = ADV_TX_POWER_NO_PREFERENCE;
+	manager->max_tx_power = ADV_TX_POWER_NO_PREFERENCE;
 
 	if (!g_dbus_register_interface(btd_get_dbus_connection(),
 					adapter_get_path(manager->adapter),
@@ -1738,6 +1785,15 @@ static struct btd_adv_manager *manager_create(struct btd_adapter *adapter,
 		goto fail;
 	}
 
+	/* Query controller capabilities. This will be used to display valid
+	 * advertising tx power range to the client.
+	 */
+	if (g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL &&
+			btd_has_kernel_features(KERNEL_HAS_CONTROLLER_CAP_CMD))
+		mgmt_send(manager->mgmt, MGMT_OP_READ_CONTROLLER_CAP,
+			manager->mgmt_index, 0, NULL,
+			read_controller_cap_complete, manager, NULL);
+
 	return manager;
 
 fail:
diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index b0b837d34..2f7cb2efc 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -1518,7 +1518,7 @@ static void cmd_extinfo(int argc, char **argv)
 static void sec_info_rsp(uint8_t status, uint16_t len, const void *param,
 							void *user_data)
 {
-	const struct mgmt_rp_read_security_info *rp = param;
+	const struct mgmt_rp_read_controller_cap *rp = param;
 	uint16_t index = PTR_TO_UINT(user_data);
 
 	if (status != 0) {
@@ -1533,7 +1533,7 @@ static void sec_info_rsp(uint8_t status, uint16_t len, const void *param,
 	}
 
 	print("Primary controller (hci%u)", index);
-	print("\tSecurity info length: %u", le16_to_cpu(rp->sec_len));
+	print("\tSecurity info length: %u", le16_to_cpu(rp->cap_len));
 
 done:
 	pending_index--;
@@ -1576,11 +1576,11 @@ static void sec_index_rsp(uint8_t status, uint16_t len, const void *param,
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
@@ -1602,7 +1602,7 @@ static void cmd_secinfo(int argc, char **argv)
 		return;
 	}
 
-	if (!mgmt_send(mgmt, MGMT_OP_READ_SECURITY_INFO, mgmt_index, 0, NULL,
+	if (!mgmt_send(mgmt, MGMT_OP_READ_CONTROLLER_CAP, mgmt_index, 0, NULL,
 					sec_info_rsp,
 					UINT_TO_PTR(mgmt_index), NULL)) {
 		error("Unable to send read_security_info cmd");
-- 
2.29.1.341.ge80a0c044ae-goog

