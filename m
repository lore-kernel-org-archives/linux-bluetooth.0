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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AC1C4346E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Sep 2020 01:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65AF2207C3
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Sep 2020 01:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D84RXh5I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgIYBOE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Sep 2020 21:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbgIYBOD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Sep 2020 21:14:03 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72C6C0613CE
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2020 18:14:03 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id c26so904699pgl.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2020 18:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=AyJ7VfzTD4j86/d5yIvvXHzKqY3Xn8QioCj+xd8w/wE=;
        b=D84RXh5IFQ6+Q8zUYMyiwzKqD5pNNDI0ptrJo0lfzVQl9LeTk7um4X6VeoBfhEOUvR
         gv+VipLGuTtS/ncvlzSfBDzgY0SaFudKcuTZ6ld9yxzYqpFyZT9QIfLR9F6H7ssZ6pKV
         bvfjGu4Mxl7y5PoKbhwHdfALepD5AtfxwlJQZwcxQStz/SidO21069y9owbsvnbvYfHz
         /qQSRNzKenfIpI1FzX+yHOINMRFhvVp66s07EKCjt71xsQgMOFACthM2Lf/nG+pFIYaO
         wvbwOT8AIFbGVv2VHAbevl3otO8UilWoqduoED7atwKUzBmlMQr9rwQmQqIDsqVkiaP0
         AePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AyJ7VfzTD4j86/d5yIvvXHzKqY3Xn8QioCj+xd8w/wE=;
        b=V4bnNEN44F/XCt+lZ07vJOPvdX3yiaD36XBpEo7O8WqyyGQNChK3vUUprrxzmKh70m
         64jBIlKKsry2IAyQealPjZCcQeXtkSWrSNoDkgbRF9IlOyVoPzdc9+xJV/uki0ntFVP9
         vBx3+rHXpkzBd5WVyo09+0I6Ryrw7lUp8c4mxsSl7Y9cB3ffjnpphL1+M8HscqDVPxBi
         7iF5egmzjnXqph7GCM655ytVuJnqjUCo46iRguNaL147WFF59wU1jZfLKkHRDAc85RgH
         IHyigOKXnUo3rfHR7z1THYLKdm4P9LfolIhqTzqZ+iyHBiij2xy5W14/sKuIT0KbIZVK
         lnOQ==
X-Gm-Message-State: AOAM531B218uDx+xK6ZX+cD459JlmnDyg38sx3hcgQ9Sr9SqLw4X/TRA
        +TU77WkJAj9E7c3w8Vtsf5TDjMJzHlnQVbI3SuiR
X-Google-Smtp-Source: ABdhPJxNdgROTSGEX/kSzqJ0EmIvJ+He1IqR8usJO8C3WhlgELuOjO/ecm/aepGDSGRGewvALAPWZWjRnG4Qb98dF/H4
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a17:902:9308:b029:d1:9bd3:6775 with
 SMTP id bc8-20020a1709029308b02900d19bd36775mr1809316plb.26.1600996443292;
 Thu, 24 Sep 2020 18:14:03 -0700 (PDT)
Date:   Thu, 24 Sep 2020 18:13:41 -0700
In-Reply-To: <20200925011347.2478464-1-danielwinkler@google.com>
Message-Id: <20200924180838.Bluez.v3.3.I50d9faa25e9da6e71d77c83c7d47a5b135e88799@changeid>
Mime-Version: 1.0
References: <20200925011347.2478464-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [Bluez PATCH v3 3/9] advertising: Detect if extended advertising mgmt
 commands are supported
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

Changes in v3: None
Changes in v2:
- Uses btd_has_kernel_features to detect kernel command support

 src/adapter.c     | 4 ++++
 src/adapter.h     | 1 +
 src/advertising.c | 5 +++++
 3 files changed, 10 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index b2bd8b3f1..7811122c4 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -9653,6 +9653,10 @@ static void read_commands_complete(uint8_t status, uint16_t length,
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
index b4d872b15..99802e287 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -246,6 +246,7 @@ enum kernel_features {
 	KERNEL_SET_SYSTEM_CONFIG	= 1 << 2,
 	KERNEL_EXP_FEATURES		= 1 << 3,
 	KERNEL_HAS_RESUME_EVT		= 1 << 4,
+	KERNEL_HAS_EXT_ADV_ADD_CMDS	= 1 << 5,
 };
 
 bool btd_has_kernel_features(uint32_t feature);
diff --git a/src/advertising.c b/src/advertising.c
index e5f25948d..f7b379b25 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -57,6 +57,7 @@ struct btd_adv_manager {
 	uint8_t max_ads;
 	uint32_t supported_flags;
 	unsigned int instance_bitmap;
+	bool extended_add_cmds;
 };
 
 #define AD_TYPE_BROADCAST 0
@@ -1426,6 +1427,10 @@ static struct btd_adv_manager *manager_create(struct btd_adapter *adapter,
 	manager->mgmt_index = btd_adapter_get_index(adapter);
 	manager->clients = queue_new();
 	manager->supported_flags = MGMT_ADV_FLAG_LOCAL_NAME;
+	manager->extended_add_cmds =
+			btd_has_kernel_features(KERNEL_HAS_EXT_ADV_ADD_CMDS);
+	manager->min_tx_power = ADV_TX_POWER_NO_PREFERENCE;
+	manager->max_tx_power = ADV_TX_POWER_NO_PREFERENCE;
 
 	if (!g_dbus_register_interface(btd_get_dbus_connection(),
 					adapter_get_path(manager->adapter),
-- 
2.28.0.709.gb0816b6eb0-goog

