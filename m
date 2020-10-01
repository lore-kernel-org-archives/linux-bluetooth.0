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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75FDCC4727E
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Oct 2020 23:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 355982075F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Oct 2020 23:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gH6hA2J3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgJAXCI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Oct 2020 19:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733275AbgJAXCG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Oct 2020 19:02:06 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F8BC0613D0
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Oct 2020 16:02:06 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id f4so71478qta.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Oct 2020 16:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=7hcKSJOws0inHn5BAdCtq4uJyHEUr81OaimuZXQjlLY=;
        b=gH6hA2J3y+eLevsLjTIpYvUJpwJR4MUCbaQDK0ZHJocj+R4jDkHNpNwS06rYwu9rXC
         WAb8EFfyLkjDe1fIbaQ49/0sTER4ev0rqr3AW3lT4D1ipZVNW0NdDjKM2CeBtbLlzIO3
         JF7iguINN5dZT0s4XB2rJx/JtpoUAtmAxIVx8FK5z6Ay7wkaw/cyYDVdNXdL2LOnbN4N
         Mq+IIcoG5nSuarygt8cA2TSAwWvGNzAkXIlh+9283HZDdhzCfvc8qnYIEOm+SzVZEenw
         DjmBJfq3Tj+BrGeVHo5uaXT22HYMB4VXJl7QOWjhpE2Zvv+XOkpCiO4UoU4Fxi7CtIqU
         BhoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7hcKSJOws0inHn5BAdCtq4uJyHEUr81OaimuZXQjlLY=;
        b=euuZ9w1HEbuFEncd5oAu0Laeclf68JE285CYKnfT8n/33cbBRNn2q9i1Txh5USEwXH
         cXxc7S7nxUrj0zHVrUe63uVAr1qsGzjhGoiDanLue7GgDHZQNYanw46Wc/MxEioAs0gW
         9ergfeZfNc/7RmvnBaLSxVWtnS6verqG2OtnATYCE9twjMTXnjhG+MMjusaG+XBBjwUD
         nuOMsEtMG7zRXiJB9h5LJCQWsdG5Zc3lxnEjb4fmTyIpOHRZfUrbDdT6/RZYycGIeV8b
         JQpGXGUjCUbsiofuPbkjcSQvraS+XdAsG+pzEnN68ULP22/8V07KWNVTE59eAaf4uQzX
         R3gw==
X-Gm-Message-State: AOAM5302qZhvGdPeVW/qpTnpXX9MLVfjh7Qky2Oj/hqOA10jgE8dp7+k
        kJE7KrRBC12o4hh0GSyAjeefK6+XD5xJxN29g914
X-Google-Smtp-Source: ABdhPJwKpjmoPJ2/Rro2zovw2eSzsoaoX3+Om//GvnhSaioC8U5GRdJeXBPk7K3H61rRmTVW7O53abdn3x5e7fXlwpi6
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:ad4:42c7:: with SMTP id
 f7mr6689511qvr.11.1601593325815; Thu, 01 Oct 2020 16:02:05 -0700 (PDT)
Date:   Thu,  1 Oct 2020 16:01:46 -0700
In-Reply-To: <20201001230152.2422908-1-danielwinkler@google.com>
Message-Id: <20201001155738.Bluez.v4.4.I50d9faa25e9da6e71d77c83c7d47a5b135e88799@changeid>
Mime-Version: 1.0
References: <20201001230152.2422908-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [Bluez PATCH v4 04/10] advertising: Detect if extended advertising
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

Changes in v4: None
Changes in v3: None
Changes in v2:
- Uses btd_has_kernel_features to detect kernel command support

 src/adapter.c     | 4 ++++
 src/adapter.h     | 1 +
 src/advertising.c | 3 +++
 3 files changed, 8 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index c0053000a..0e035172e 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -9640,6 +9640,10 @@ static void read_commands_complete(uint8_t status, uint16_t length,
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
2.28.0.709.gb0816b6eb0-goog

