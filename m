Return-Path: <SRS0=Bgmv=7Y=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F09C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Jun 2020 00:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EE6F2078D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Jun 2020 00:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B9kY40e8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgFKAXw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Jun 2020 20:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbgFKAXv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Jun 2020 20:23:51 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96604C08C5C1
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2020 17:23:50 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id w20so1531732uaa.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2020 17:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4iZYvF/iX7qwm+LTrL1OtSnF38tq/Qdki3Cc46swRVk=;
        b=B9kY40e817mISZsCGAmPaX3YoprvqjcdCncKNYYm89cP+QOkcL4ZeoH2Bnf4vs87YI
         HviKFEATyv9EFbWvxYKFK6JMYMzOZ8i3wWDJvuLLwuSE88+bU6A2XTxakTpT7l0p9sVQ
         UEpWXEcnJU668ZU2EL3vPqQPZ7HVPhxGKotG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4iZYvF/iX7qwm+LTrL1OtSnF38tq/Qdki3Cc46swRVk=;
        b=k4iXmJk/qgnN5gLBMyE3HnJr60iTfvqUUcPF8ugsjJYsVRs37nRNA4bVmtGemze62h
         +cQYGpUFW8pWn6tWlCntqd5L6uUis0NrSzimKDqNn1UpPpn0EFwAKg8c7DWCx9+E47N1
         ImJWp06La8l186P0AkFvflPwv3WQ284CPSC8pnPc/QK2Qw/Qb6bzqh2TsLK7g+GV/uZz
         wzW+yZcO9hhVJUxWpZF+ZRfvYH/4gyEGi3IN8HWI5oVWz4K8Mr4cB14P44dbtqpX2hEE
         CVx3Z5e/cPPDOc3BRQeorrVJmNKableLix6CDn3WP7acXSgascvQoOIrEy+E5jIRFzYL
         fHIw==
X-Gm-Message-State: AOAM530WzRQb64iSZGl3VaWl1uGmwTUGWoT8Z5vcF01AisOnUg8yKio+
        UD4veZvJtEyudHw6bj0vUrsDzqZLoa4=
X-Google-Smtp-Source: ABdhPJztvWG6W6QTP1FyJzpkYpnO+RGnQwHBqLzQHwx6sFflATdDs2xmFRxg0JxUp8+R7W0ypGgXkA==
X-Received: by 2002:ab0:5cd7:: with SMTP id z23mr3161626uaf.137.1591835029175;
        Wed, 10 Jun 2020 17:23:49 -0700 (PDT)
Received: from alain.c.googlers.com.com (252.177.243.35.bc.googleusercontent.com. [35.243.177.252])
        by smtp.gmail.com with ESMTPSA id q8sm202677vke.24.2020.06.10.17.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 17:23:48 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [PATCH] mgmt:syncing configuration commands to the documentation.
Date:   Thu, 11 Jun 2020 00:23:45 +0000
Message-Id: <20200611002345.148620-1-alainm@chromium.org>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch simply fixes the definition names (and corresponding
implemenation) to the adopted documentation.

---

 lib/mgmt.h    | 26 +++++++++++++++++++-------
 src/adapter.c | 16 ++++++++--------
 2 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 2f78d75bf..eb5dd862d 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -628,22 +628,34 @@ struct mgmt_rp_set_exp_feature {
 	uint32_t flags;
 } __packed;
 
-#define MGMT_OP_READ_DEFAULT_SYSTEM_PARAMETERS	0x004b
+#define MGMT_OP_READ_DEF_SYSTEM_CONFIG	0x004b
 
-struct mgmt_system_parameter_tlv {
+struct mgmt_tlv {
 	uint16_t type;
 	uint8_t  length;
 	uint8_t  value[];
 } __packed;
 
-struct mgmt_rp_read_default_system_parameters {
-	uint8_t  parameters[0]; /* mgmt_system_parameter_tlv */
+struct mgmt_rp_read_default_system_config {
+	uint8_t parameters[0]; /* mgmt_tlv */
 } __packed;
 
-#define MGMT_OP_SET_DEFAULT_SYSTEM_PARAMETERS	0x004c
+#define MGMT_OP_SET_DEF_SYSTEM_CONFIG	0x004c
 
-struct mgmt_cp_set_default_system_parameters {
-	uint8_t  parameters[0]; /* mgmt_system_parameter_tlv */
+struct mgmt_cp_set_default_system_config {
+	uint8_t parameters[0]; /* mgmt_tlv */
+} __packed;
+
+#define MGMT_OP_READ_DEF_RUNTIME_CONFIG	0x004d
+
+struct mgmt_rp_read_default_runtime_config {
+	uint8_t parameters[0]; /* mgmt_tlv */
+} __packed;
+
+#define MGMT_OP_SET_DEF_RUNTIME_CONFIG	0x004e
+
+struct mgmt_cp_set_default_runtime_config {
+	uint8_t parameters[0]; /* mgmt_tlv */
 } __packed;
 
 #define MGMT_EV_CMD_COMPLETE		0x0001
diff --git a/src/adapter.c b/src/adapter.c
index 64815ecd2..31b80b19d 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -120,7 +120,7 @@ static bool kernel_conn_control = false;
 
 static bool kernel_blocked_keys_supported = false;
 
-static bool kernel_set_system_params = false;
+static bool kernel_set_system_config = false;
 
 static GList *adapter_list = NULL;
 static unsigned int adapter_remaining = 0;
@@ -4171,7 +4171,7 @@ static void probe_devices(void *user_data)
 static void load_default_system_params(struct btd_adapter *adapter)
 {
 	struct {
-		struct mgmt_system_parameter_tlv entry;
+		struct mgmt_tlv entry;
 		union {
 			uint16_t u16;
 		};
@@ -4180,7 +4180,7 @@ static void load_default_system_params(struct btd_adapter *adapter)
 	size_t len = 0;
 	unsigned int err;
 
-	if (!main_opts.default_params.num_entries || !kernel_set_system_params)
+	if (!main_opts.default_params.num_entries || !kernel_set_system_config)
 		return;
 
 	params = malloc0(sizeof(*params) *
@@ -4414,11 +4414,11 @@ static void load_default_system_params(struct btd_adapter *adapter)
 		len += sizeof(params[i].u16);
 	}
 
-	err = mgmt_send(adapter->mgmt, MGMT_OP_SET_DEFAULT_SYSTEM_PARAMETERS,
+	err = mgmt_send(adapter->mgmt, MGMT_OP_SET_DEF_SYSTEM_CONFIG,
 			adapter->dev_id, len, params, NULL, NULL, NULL);
 	if (!err)
 		btd_error(adapter->dev_id,
-				"Failed to set default system params for hci%u",
+				"Failed to set default system config for hci%u",
 				adapter->dev_id);
 
 	free(params);
@@ -9426,9 +9426,9 @@ static void read_commands_complete(uint8_t status, uint16_t length,
 			DBG("kernel supports the set_blocked_keys op");
 			kernel_blocked_keys_supported = true;
 			break;
-		case MGMT_OP_SET_DEFAULT_SYSTEM_PARAMETERS:
-			DBG("kernel supports set system params");
-			kernel_set_system_params = true;
+		case MGMT_OP_SET_DEF_SYSTEM_CONFIG:
+			DBG("kernel supports set system confic");
+			kernel_set_system_config = true;
 			break;
 		default:
 			break;
-- 
2.27.0.290.gba653c62da-goog

