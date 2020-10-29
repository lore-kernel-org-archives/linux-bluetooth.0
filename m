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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F412C4741F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 21:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C11E320838
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 21:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vh/F7xBe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgJ2VYA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Oct 2020 17:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgJ2VYA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Oct 2020 17:24:00 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E988EC0613CF
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2020 14:23:59 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y11so4066427ybm.22
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2020 14:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=u+Hok0SjaVZEId5o72brIfJOgIbEOMTDJClF83T+CY4=;
        b=Vh/F7xBegU1FfPUFGcyS30Y6G+a6T1tsaheDs3xy2BdRkK7+AKVWyo3T0GMTGtIHa8
         4qizXz5CUWsReFnbEUdVHdFqOHneUMjVPrt1aB4vXLG2ldGZlqZHHirjeOFD+FZ2pgcU
         ZRhDPqEx6Sf8a3RbntIpkT1FsgWl3nl5DNBHvGkAFK3upUZuS8MDeqVTQ8Q71hOUs/7X
         ClVNZJMkdq47JJUFM1EiDQgLoUhwnsT0klWGd/SFa3ilKDc5fl/7SwKBL9PaJ9azrju2
         13DKdUeoAoQaVkQtKGnD5rNM6/xm4Mj7dFVn+6u5DiCqnHNnKYLQl8xbdR13j3kYZUG/
         +I9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=u+Hok0SjaVZEId5o72brIfJOgIbEOMTDJClF83T+CY4=;
        b=DxtZLb3iDrhxJ5//3cAc5RIj8NhpL+QoyygqrXwiNYY38kwu6oNdbO3OhzQpM75+Q8
         3l8Oo6VNWBftXEezc+WEhxT6LSG+mvE81USXtm6DvgwfIFriYsYWTgkLkvZVaOPDDDyV
         cV11FneCC5ITQvgxjhDkBr5Zn6GoSv5cr2pIVp0zdTXWbY8No8DfKjeOQxewI3LdtFVh
         Q/BKqTp1vWrGeOjUiG39fn+v/qJfYh2jWGHdM2dQygaTs24JQoAGAAxvwiVyCZ5kmDe5
         3UEalDTcS4KnBluMXFzcAJCpLLLLdiMXBsvEziDwSaPRluj2bARfJb0kFisivWMkifg+
         gFIQ==
X-Gm-Message-State: AOAM532KhZ2zD0IQXvBCfHjGJewPELzJA1adaKytYv4IdVyRM9oeMhuX
        dEQPARXCbqDfWlwSr2ntnb5PtMqFiJPPBvxLULiy
X-Google-Smtp-Source: ABdhPJzloO06Rc1pCI6wNiz0o9UvZCTR/TkketSx06MknJnl8Houk9URHc07vqVJ4mNrCH5AcNXuRbsns9/w7gopWGcf
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a25:2fc2:: with SMTP id
 v185mr8194365ybv.107.1604006639187; Thu, 29 Oct 2020 14:23:59 -0700 (PDT)
Date:   Thu, 29 Oct 2020 14:23:32 -0700
In-Reply-To: <20201029212336.3283410-1-danielwinkler@google.com>
Message-Id: <20201029141832.Bluez.v5.7.I187f71748b9bd93f6bf97ec4a195216109c3ea06@changeid>
Mime-Version: 1.0
References: <20201029212336.3283410-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [Bluez PATCH v5 07/10] advertising: Query LE TX range at manager initialization
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
index 0e035172e..f21598feb 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -9644,6 +9644,10 @@ static void read_commands_complete(uint8_t status, uint16_t length,
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
index 428cd9562..5ed2edf44 100644
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

