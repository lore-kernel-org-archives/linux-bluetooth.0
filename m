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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EE5C2D0A3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 23:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1729020791
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 23:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GYZVbKB6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbgJ2XGi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Oct 2020 19:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgJ2XGi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Oct 2020 19:06:38 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFF7C0613CF
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2020 16:06:38 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id z125so3308425pfc.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2020 16:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Gf+F7yz3pMTj+KLx0gpbm0RJJgxj62/31jS9n0rFRmc=;
        b=GYZVbKB6FktK+aRbv/T54kPhf4DZ/6/AYpRT4qcM8Bk1a8lWgRvLY0cMo7Tlv8ScRu
         qM0Mt2+Rvc21U/vOYeKh0MZtOFt3paY583Dk9EJlpEmm3TIJ9PhQa9SRHCkAc0KAIyKI
         FBwh9h3aDNa5IHw0Ex/l8INVwjSrisap38cHb2Fp5nga8RbZZmPYCo3qfAYNH6ThcSJW
         4p1LgEEf4X2rpiuz7Nv/J2zPU/nFF3Klrb/7qq8XJNBJYoyh25IM39Pjtb17HL67tKop
         d+2ZMIYDyF611sCVfbUU5PJh3xDvigVpc0SogkGCxl9Zw/hjRTTk0vkfV50GQ6X63s/R
         KrKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Gf+F7yz3pMTj+KLx0gpbm0RJJgxj62/31jS9n0rFRmc=;
        b=ss4Bjzi1dO7IuX0Kxr8I1JruIE6zegwni97TO453p0SxZHD4Wto9pDjiFlTIkkR35e
         vyCol7toHEWrb1csx2SCMTAZ+hX8P0qKd8WeMxAJv/tZNA8k4GCxX/XZsuqbxNRLz9+8
         n6lOX6RAkBDwKgvD9W3AeJ4ajoTurrmwfTFK5I+sX0nPKyfDljJ2DGiCXhzPG5plPzcK
         aY+78ry4Y0ALXXgGdiM8i5BTKAyS3AfYje5uH/pfqjLuPbkexDIP+2q4EnnhEp3feL+M
         suaV7uRodI6YuM2Qcrlx7zG+Zj4Jwxz3NH3gndp9giDzAn0KmqNu3gWD8GxAwZsYgB6P
         NGqA==
X-Gm-Message-State: AOAM5300l5bgg6xcPjY5etLpTINzCIMeEmtwlMactkKn7UUJNf7roEM8
        9/8RU43jTbICItNIK2TQdIm2cuXL93B/O48rM8z9
X-Google-Smtp-Source: ABdhPJxiMCdCeAnUicOTkszo9rYSQ7AntB4xZMT1oyRNOLv9KJFQmgn8brrsX7KizjyI8PaWio9vlWlijiG0lUZ2O1IF
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:aa7:9a1b:0:b029:163:edfa:64a2 with
 SMTP id w27-20020aa79a1b0000b0290163edfa64a2mr6177344pfj.70.1604012797629;
 Thu, 29 Oct 2020 16:06:37 -0700 (PDT)
Date:   Thu, 29 Oct 2020 16:06:16 -0700
In-Reply-To: <20201029230623.3630069-1-danielwinkler@google.com>
Message-Id: <20201029160317.Bluez.v6.4.I50d9faa25e9da6e71d77c83c7d47a5b135e88799@changeid>
Mime-Version: 1.0
References: <20201029230623.3630069-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [Bluez PATCH v6 04/10] advertising: Detect if extended advertising
 mgmt commands are supported
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

We need to know if kernel supports the new MGMT interface. To do so, we
check the return from adapter's MGMT_OP_READ_COMMANDS call for the new
commands. This will later be used to route our requests for new
advertisements.

The change is tested by manually verifying that the correct MGMT
commands are used when the feature is and is not available in kernel.

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
Reviewed-by: Alain Michaud <alainm@chromium.org>
---

Changes in v6:
- Reserve new MGMT codes earlier in series to detect support

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2:
- Uses btd_has_kernel_features to detect kernel command support

 lib/mgmt.h        | 4 ++++
 src/adapter.c     | 4 ++++
 src/adapter.h     | 1 +
 src/advertising.c | 3 +++
 4 files changed, 12 insertions(+)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 6aa0f5f88..59608e7ea 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -700,6 +700,10 @@ struct mgmt_rp_remove_adv_monitor {
 	uint16_t monitor_handle;
 } __packed;
 
+#define MGMT_OP_ADD_EXT_ADV_PARAMS		0x0054
+
+#define MGMT_OP_ADD_EXT_ADV_DATA		0x0055
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	uint16_t opcode;
diff --git a/src/adapter.c b/src/adapter.c
index 1f075ef5f..90beb897f 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -9566,6 +9566,10 @@ static void read_commands_complete(uint8_t status, uint16_t length,
 			DBG("kernel supports exp features");
 			kernel_features |= KERNEL_EXP_FEATURES;
 			break;
+		case MGMT_OP_ADD_EXT_ADV_PARAMS:
+			DBG("kernel supports ext adv commands");
+			kernel_features |= KERNEL_HAS_EXT_ADV_ADD_CMDS;
+			break;
 		default:
 			break;
 		}
diff --git a/src/adapter.h b/src/adapter.h
index dcc574857..ace72affd 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -233,6 +233,7 @@ enum kernel_features {
 	KERNEL_SET_SYSTEM_CONFIG	= 1 << 2,
 	KERNEL_EXP_FEATURES		= 1 << 3,
 	KERNEL_HAS_RESUME_EVT		= 1 << 4,
+	KERNEL_HAS_EXT_ADV_ADD_CMDS	= 1 << 5,
 };
 
 bool btd_has_kernel_features(uint32_t feature);
diff --git a/src/advertising.c b/src/advertising.c
index c03869e50..7c7599552 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -48,6 +48,7 @@ struct btd_adv_manager {
 	uint8_t max_ads;
 	uint32_t supported_flags;
 	unsigned int instance_bitmap;
+	bool extended_add_cmds;
 };
 
 #define AD_TYPE_BROADCAST 0
@@ -1417,6 +1418,8 @@ static struct btd_adv_manager *manager_create(struct btd_adapter *adapter,
 	manager->mgmt_index = btd_adapter_get_index(adapter);
 	manager->clients = queue_new();
 	manager->supported_flags = MGMT_ADV_FLAG_LOCAL_NAME;
+	manager->extended_add_cmds =
+			btd_has_kernel_features(KERNEL_HAS_EXT_ADV_ADD_CMDS);
 
 	if (!g_dbus_register_interface(btd_get_dbus_connection(),
 					adapter_get_path(manager->adapter),
-- 
2.29.1.341.ge80a0c044ae-goog

