Return-Path: <SRS0=rKdx=DI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C2EC47423
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Oct 2020 23:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21C332075F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Oct 2020 23:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xn0OUtI3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733290AbgJAXCN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Oct 2020 19:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733085AbgJAXCN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Oct 2020 19:02:13 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BE4C0613D0
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Oct 2020 16:02:12 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id r9so504439ybd.20
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Oct 2020 16:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=f3iZ5VFL7yZ+gwqXetNr41o/WLJyO5Vq2hRLM9+a0cw=;
        b=Xn0OUtI3n6fpT0Q5ySkBaWfLKsBWfsQ8xmDOiMiPx/8r1zvsZG0BabkOEqanZTapRh
         oucDUvCM5LY5X2dBheCLTeeHV8/VB2z0R/5myjrJDB2aA6/5AD7gb8/GSBrr4/kdrOTa
         WfwqEu6M/R8YzCX68wB/ugRjpZOxmHWbz9T99FnKCJk7K6Oc77NW2ovnmZfyNj27j+nX
         VhFoZxWIiZfaz5lv7wZhrPltekSOzKZ4aqgOuqwsHgb8RfmHsB68OTTElYcKBFyartsn
         PV/KJJP4UmsI6fOxj2AWOXoL6rkEH6GblAOm6H0gIm6rstTRWE7TWb8NoMPNQ/UQe+xm
         sL/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=f3iZ5VFL7yZ+gwqXetNr41o/WLJyO5Vq2hRLM9+a0cw=;
        b=a1cHGrB0MSKX2IYQV8LZrahvoYUCHhTeBRmZIzRxC/OMdGAFMwYQbdW52XgaoX3k+j
         3aWoIUiZoDscrFz6F06SxdxZrjQBs1h0WI1nOC5Lw/rcQDHUQIW34dDwcEP6WAd2gL7J
         1I77rR89cT0D51S0FiPwUBZCVbrazK+ddzut6LOB4zAWVHNvGO8C90zFtYsVwBEKfkyq
         rLWzIGzcxQtiu9EgjbqLvMNkHtm6TfBHspBTQ9GMKepqY7h0LDRL5X5+uldCDpFFUyku
         XW1f8udMuGAiZAVvpzLNYwJO+KKE23FrzBYVtBxffYblZqM6Mtb5+N+fIE7NHiw9c5i8
         JAsQ==
X-Gm-Message-State: AOAM531JIolO5vfx7xe7iIj5WHR6OkygfsXgPwDDxeAPfVgmzVoNfDX+
        poItJm+VzA4u1dvNBmRWoni7U5x8+hrCAbLQ0WYj
X-Google-Smtp-Source: ABdhPJzJuGvdQ8Puw1bmAHfjTr1Rg2pQgnJVqwZZ6nsBMke1avjtiw/3ed/dYl7yYCCtUS1kkR2GvLnZmk69cYb1RZBD
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a25:7489:: with SMTP id
 p131mr14193362ybc.466.1601593331955; Thu, 01 Oct 2020 16:02:11 -0700 (PDT)
Date:   Thu,  1 Oct 2020 16:01:49 -0700
In-Reply-To: <20201001230152.2422908-1-danielwinkler@google.com>
Message-Id: <20201001155738.Bluez.v4.7.I187f71748b9bd93f6bf97ec4a195216109c3ea06@changeid>
Mime-Version: 1.0
References: <20201001230152.2422908-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [Bluez PATCH v4 07/10] advertising: Query LE TX range at manager initialization
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

Changes in v4:
- Move tx power range into single capability field

Changes in v3: None
Changes in v2: None

 lib/mgmt.h        | 14 ++++++++----
 src/advertising.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++
 tools/btmgmt.c    | 12 +++++------
 3 files changed, 70 insertions(+), 10 deletions(-)

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
diff --git a/src/advertising.c b/src/advertising.c
index 052964d42..41d0658c8 100644
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
@@ -1679,6 +1681,49 @@ static void read_adv_features_callback(uint8_t status, uint16_t length,
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
@@ -1700,6 +1745,8 @@ static struct btd_adv_manager *manager_create(struct btd_adapter *adapter,
 	manager->supported_flags = MGMT_ADV_FLAG_LOCAL_NAME;
 	manager->extended_add_cmds =
 			btd_has_kernel_features(KERNEL_HAS_EXT_ADV_ADD_CMDS);
+	manager->min_tx_power = ADV_TX_POWER_NO_PREFERENCE;
+	manager->max_tx_power = ADV_TX_POWER_NO_PREFERENCE;
 
 	if (!g_dbus_register_interface(btd_get_dbus_connection(),
 					adapter_get_path(manager->adapter),
@@ -1716,6 +1763,13 @@ static struct btd_adv_manager *manager_create(struct btd_adapter *adapter,
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

