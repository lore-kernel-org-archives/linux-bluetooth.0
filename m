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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D22AC4742C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 21:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B76B120838
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 21:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PmWdaDnf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgJ2VXy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Oct 2020 17:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgJ2VXx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Oct 2020 17:23:53 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4179C0613CF
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2020 14:23:53 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id k7so4039283ybm.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2020 14:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Q/yW8CGo6ujkkewo4nJeNplHo7X6JGElLM5ul8fz5ac=;
        b=PmWdaDnf44Y9Pq2VOQXdi7GU5vmjRXg1qfAnm5FApQRyCn9z4a2VeFOcG/fylfgYuP
         6JPVZNgJtkpCPZW8Ui8b7Ob/jYn6VPi5KSigBEIGiNCr4z69cfNx32YqF0Q5EbGjSdOx
         Xbmi687L0fS1I6PYzRlp7DeF9Z4NTx+sR7/N3Si7gGIMgvn5BhGdoo/BRgFA9N2xTxs3
         CESN35dmb9IdPITMhw2O1CFL2MaTB+vUS3LGVQNb1NUr+2IJ2AC/iBB1acOJ8jwrkXkc
         37ArM7HfNMm9u5Mb6NfhzsFBDtWveQY9NSG0fxxmOgsp117lmKfZ6scJ+i3X+iuAkZRN
         OIUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Q/yW8CGo6ujkkewo4nJeNplHo7X6JGElLM5ul8fz5ac=;
        b=UMmn9zaizYPFGBH2b/7des5i8aBqyQbzVUWfO5LMqmApFHd4NF3GVmG88Nv5IDqRoR
         N53RiOvLFblGjjf3EacKI1C86Qx9uCwgkK4D/T7RaoKmdPCzgUoHGjhYELD92B9nU3Xr
         Lr24ZLZRPuxQJsgBbzfwE20xLzUppQI/357ckKEWBUzIQaDzNyLSO6eyY31p28lme0o3
         ATJwMijWhQaecIEc6dMDcEcthfsi3kJVKgQSW8SVt3GcqQjE5KDp/IZiswMgH2ztq+i4
         CxnNKylASQWOA08eZkCgRZC0+UZwOg7a2AWkrKrVQFTRr37aWY+4Zcx4Sroby1Iepg59
         6gbw==
X-Gm-Message-State: AOAM532UJMA/+8K/RJdDCwTjEzBcAvcozVFCsKS364WBMm5UwnPc7/jb
        IFQ69ycytRuf4U+jPSt31OCKeVlAjoZeKzkuMOVz
X-Google-Smtp-Source: ABdhPJxOFyX8Wjp+BEnA4Z9CZRVrNP44tJ08uucz1Or4uZ+hG4PprlXJN7Uc9Ntv8yuEMMygT2w02O3rKyKo8jKxOHRx
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a5b:ec2:: with SMTP id
 a2mr8656365ybs.13.1604006632915; Thu, 29 Oct 2020 14:23:52 -0700 (PDT)
Date:   Thu, 29 Oct 2020 14:23:29 -0700
In-Reply-To: <20201029212336.3283410-1-danielwinkler@google.com>
Message-Id: <20201029141832.Bluez.v5.4.I50d9faa25e9da6e71d77c83c7d47a5b135e88799@changeid>
Mime-Version: 1.0
References: <20201029212336.3283410-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [Bluez PATCH v5 04/10] advertising: Detect if extended advertising
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

Changes in v5: None
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
2.29.1.341.ge80a0c044ae-goog

