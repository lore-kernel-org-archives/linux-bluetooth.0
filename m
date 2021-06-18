Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD89C48BE8
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jun 2021 08:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C43261184
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jun 2021 08:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbhFRIDb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Jun 2021 04:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbhFRIDM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Jun 2021 04:03:12 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802A2C0617AE
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Jun 2021 01:00:53 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id k6so7061443pfk.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Jun 2021 01:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5HAONQPZe7/SR1yiilCYPmjw7Y/Yqrfapy71bu7s5Gk=;
        b=gqBgo5FtV2BrQiAKmxq8eBZbSZ9cprcFx89DZxsGsOJD4ELAzDm7qRpr4ccqXh3jw7
         HbDBJvC2/d5WNSDLwo6W+RmvoB6VIWXI1LZD0MQqF2fntWXhuLXOnp2V4S4BrglM7XLu
         FX3PQo/RCBbBE3OxM5Ma/hupXfQMjDwOMsJNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5HAONQPZe7/SR1yiilCYPmjw7Y/Yqrfapy71bu7s5Gk=;
        b=jOUSw7B3Q4bTDXHnt5WVfuhbFPgyq9rmSIDdOtSVRmF3CJIKyDA4IssQxfpsI/UnHX
         vjZ9Toi+zM43fSwWzKbp5QdRRWnXC2QJEjKyfTBlkZ9n7U3S0Wa3A6dujVw9xsWc4jvD
         ZYhkPqVYv+ND9Cs9cEBjs1FA7qSJIdFMT2IT51m97Z9OxNd6hK5gfYhHsi2FsHiMa/le
         opgnk47jzMfY5ubrwl9fB5LyYrZtJmIYaukYwB2L6EqETGA16+KefTK/74+Gw17pzTjS
         8Ui3DRLO2jtwplOEa18M7MSyJa/iMDmfu6/ILlTUHvOPtqxzEIXK1hTnbRU8r5yI9nWm
         ZNSw==
X-Gm-Message-State: AOAM530ArN5OPkSFybhLzIuQty42kqm2z1M6VCDWjpiGPMj+vM6siC4E
        HBm/ymbCxxGd3/F24gV1Sl4XEGqP/JUIbA==
X-Google-Smtp-Source: ABdhPJw7xUC/J4bt0UufwKr0rt03Po2lflZ68+7D2LCtbrD07yOb2doD5xUbq2bbliHgYytmbCtCNw==
X-Received: by 2002:aa7:8bd6:0:b029:2ec:7dc9:77e3 with SMTP id s22-20020aa78bd60000b02902ec7dc977e3mr3937801pfd.62.1624003252595;
        Fri, 18 Jun 2021 01:00:52 -0700 (PDT)
Received: from josephsih-z840.tpe.corp.google.com ([2401:fa00:1:10:6cbb:95eb:e2ae:8479])
        by smtp.gmail.com with ESMTPSA id v21sm7341671pfu.77.2021.06.18.01.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 01:00:52 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     josephsih@google.com, chromeos-bluetooth-upstreaming@chromium.org,
        Joseph Hwang <josephsih@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v4 4/4] Bluetooth: Support the quality report events
Date:   Fri, 18 Jun 2021 16:00:39 +0800
Message-Id: <20210618160016.v4.4.I20c79eef4f36c4a3802e1068e59ec4a9f4ded940@changeid>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
In-Reply-To: <20210618160016.v4.1.I41aec59e65ffd3226d368dabeb084af13cc133c8@changeid>
References: <20210618160016.v4.1.I41aec59e65ffd3226d368dabeb084af13cc133c8@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch allows a user space process to enable/disable the quality
report events dynamically through the set experimental feature mgmt
interface if CONFIG_BT_FEATURE_QUALITY_REPORT is enabled.

Since the quality report feature needs to invoke the callback function
provided by the driver, i.e., hdev->set_quality_report, a valid
controller index is required.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Signed-off-by: Joseph Hwang <josephsih@chromium.org>
---

(no changes since v1)

 include/net/bluetooth/hci.h      |   4 ++
 include/net/bluetooth/hci_core.h |  22 ++++--
 net/bluetooth/Kconfig            |  11 +++
 net/bluetooth/mgmt.c             | 118 ++++++++++++++++++++++++++++++-
 4 files changed, 148 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index b80415011dcd..2811b60e1acc 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -331,6 +331,10 @@ enum {
 	HCI_CMD_PENDING,
 	HCI_FORCE_NO_MITM,
 
+#ifdef CONFIG_BT_FEATURE_QUALITY_REPORT
+	HCI_QUALITY_REPORT,
+#endif
+
 	__HCI_NUM_FLAGS,
 };
 
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index a53e94459ecd..c25de25a7036 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -605,6 +605,9 @@ struct hci_dev {
 	int (*set_bdaddr)(struct hci_dev *hdev, const bdaddr_t *bdaddr);
 	void (*cmd_timeout)(struct hci_dev *hdev);
 	bool (*prevent_wake)(struct hci_dev *hdev);
+#ifdef CONFIG_BT_FEATURE_QUALITY_REPORT
+	int (*set_quality_report)(struct hci_dev *hdev, bool enable);
+#endif
 };
 
 #define HCI_PHY_HANDLE(handle)	(handle & 0xff)
@@ -752,12 +755,19 @@ extern struct mutex hci_cb_list_lock;
 #define hci_dev_test_and_clear_flag(hdev, nr)  test_and_clear_bit((nr), (hdev)->dev_flags)
 #define hci_dev_test_and_change_flag(hdev, nr) test_and_change_bit((nr), (hdev)->dev_flags)
 
-#define hci_dev_clear_volatile_flags(hdev)			\
-	do {							\
-		hci_dev_clear_flag(hdev, HCI_LE_SCAN);		\
-		hci_dev_clear_flag(hdev, HCI_LE_ADV);		\
-		hci_dev_clear_flag(hdev, HCI_LL_RPA_RESOLUTION);\
-		hci_dev_clear_flag(hdev, HCI_PERIODIC_INQ);	\
+#ifdef CONFIG_BT_FEATURE_QUALITY_REPORT
+#define hci_dev_clear_flag_quality_report(x) { hci_dev_clear_flag(hdev, x); }
+#else
+#define hci_dev_clear_flag_quality_report(x) {}
+#endif
+
+#define hci_dev_clear_volatile_flags(hdev)				\
+	do {								\
+		hci_dev_clear_flag(hdev, HCI_LE_SCAN);			\
+		hci_dev_clear_flag(hdev, HCI_LE_ADV);			\
+		hci_dev_clear_flag(hdev, HCI_LL_RPA_RESOLUTION);	\
+		hci_dev_clear_flag(hdev, HCI_PERIODIC_INQ);		\
+		hci_dev_clear_flag_quality_report(HCI_QUALITY_REPORT)	\
 	} while (0)
 
 /* ----- HCI interface to upper protocols ----- */
diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
index e0ab4cd7afc3..d63c3cdf2d6f 100644
--- a/net/bluetooth/Kconfig
+++ b/net/bluetooth/Kconfig
@@ -148,4 +148,15 @@ config BT_FEATURE_DEBUG
 	  This provides an option to enable/disable debugging statements
 	  at runtime via the experimental features interface.
 
+config BT_FEATURE_QUALITY_REPORT
+	bool "Runtime option for logging controller quality report events"
+	depends on BT
+	default n
+	help
+	  This provides an option to enable/disable controller quality report
+	  events logging at runtime via the experimental features interface.
+	  The quality report events may include the categories of system
+	  exceptions, connections/disconnection, the link quality statistics,
+	  etc.
+
 source "drivers/bluetooth/Kconfig"
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index d1bf5a55ff85..0de089524d74 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3791,6 +3791,14 @@ static const u8 debug_uuid[16] = {
 };
 #endif
 
+#ifdef CONFIG_BT_FEATURE_QUALITY_REPORT
+/* 330859bc-7506-492d-9370-9a6f0614037f */
+static const u8 quality_report_uuid[16] = {
+	0x7f, 0x03, 0x14, 0x06, 0x6f, 0x9a, 0x70, 0x93,
+	0x2d, 0x49, 0x06, 0x75, 0xbc, 0x59, 0x08, 0x33,
+};
+#endif
+
 /* 671b10b5-42c0-4696-9227-eb28d1b049d6 */
 static const u8 simult_central_periph_uuid[16] = {
 	0xd6, 0x49, 0xb0, 0xd1, 0x28, 0xeb, 0x27, 0x92,
@@ -3806,7 +3814,7 @@ static const u8 rpa_resolution_uuid[16] = {
 static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
 				  void *data, u16 data_len)
 {
-	char buf[62];	/* Enough space for 3 features */
+	char buf[82];   /* Enough space for 4 features: 2 + 20 * 4 */
 	struct mgmt_rp_read_exp_features_info *rp = (void *)buf;
 	u16 idx = 0;
 	u32 flags;
@@ -3850,6 +3858,26 @@ static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
 		idx++;
 	}
 
+#ifdef CONFIG_BT_FEATURE_QUALITY_REPORT
+	if (hdev) {
+		if (hdev->set_quality_report) {
+			/* BIT(0): indicating if set_quality_report is
+			 * supported by controller.
+			 */
+			flags = BIT(0);
+
+			/* BIT(1): indicating if the feature is enabled. */
+			if (hci_dev_test_flag(hdev, HCI_QUALITY_REPORT))
+				flags |= BIT(1);
+		} else {
+			flags = 0;
+		}
+		memcpy(rp->features[idx].uuid, quality_report_uuid, 16);
+		rp->features[idx].flags = cpu_to_le32(flags);
+		idx++;
+	}
+#endif
+
 	rp->feature_count = cpu_to_le16(idx);
 
 	/* After reading the experimental features information, enable
@@ -3892,6 +3920,23 @@ static int exp_debug_feature_changed(bool enabled, struct sock *skip)
 }
 #endif
 
+#ifdef CONFIG_BT_FEATURE_QUALITY_REPORT
+static int exp_quality_report_feature_changed(bool enabled, struct sock *skip)
+{
+	struct mgmt_ev_exp_feature_changed ev;
+
+	BT_INFO("enabled %d", enabled);
+
+	memset(&ev, 0, sizeof(ev));
+	memcpy(ev.uuid, quality_report_uuid, 16);
+	ev.flags = cpu_to_le32(enabled ? BIT(0) : 0);
+
+	return mgmt_limited_event(MGMT_EV_EXP_FEATURE_CHANGED, NULL,
+				  &ev, sizeof(ev),
+				  HCI_MGMT_EXP_FEATURE_EVENTS, skip);
+}
+#endif
+
 static int set_exp_feature(struct sock *sk, struct hci_dev *hdev,
 			   void *data, u16 data_len)
 {
@@ -4038,6 +4083,77 @@ static int set_exp_feature(struct sock *sk, struct hci_dev *hdev,
 		return err;
 	}
 
+#ifdef CONFIG_BT_FEATURE_QUALITY_REPORT
+	if (!memcmp(cp->uuid, quality_report_uuid, 16)) {
+		bool val, changed;
+		int err;
+
+		/* Command requires to use a valid controller index */
+		if (!hdev)
+			return mgmt_cmd_status(sk, MGMT_INDEX_NONE,
+					       MGMT_OP_SET_EXP_FEATURE,
+					       MGMT_STATUS_INVALID_INDEX);
+
+		/* Parameters are limited to a single octet */
+		if (data_len != MGMT_SET_EXP_FEATURE_SIZE + 1)
+			return mgmt_cmd_status(sk, hdev->id,
+					       MGMT_OP_SET_EXP_FEATURE,
+					       MGMT_STATUS_INVALID_PARAMS);
+
+		/* Only boolean on/off is supported */
+		if (cp->param[0] != 0x00 && cp->param[0] != 0x01)
+			return mgmt_cmd_status(sk, hdev->id,
+					       MGMT_OP_SET_EXP_FEATURE,
+					       MGMT_STATUS_INVALID_PARAMS);
+
+		hci_req_sync_lock(hdev);
+
+		val = !!cp->param[0];
+		changed = (val != hci_dev_test_flag(hdev, HCI_QUALITY_REPORT));
+
+		if (!hdev->set_quality_report) {
+			BT_INFO("quality report not supported");
+			err = mgmt_cmd_status(sk, hdev->id,
+					      MGMT_OP_SET_EXP_FEATURE,
+					      MGMT_STATUS_NOT_SUPPORTED);
+			goto unlock_quality_report;
+		}
+
+		if (changed) {
+			err = hdev->set_quality_report(hdev, val);
+			if (err) {
+				BT_ERR("set_quality_report value %d err %d",
+				       val, err);
+				err = mgmt_cmd_status(sk, hdev->id,
+						      MGMT_OP_SET_EXP_FEATURE,
+						      MGMT_STATUS_FAILED);
+				goto unlock_quality_report;
+			}
+			if (val)
+				hci_dev_set_flag(hdev, HCI_QUALITY_REPORT);
+			else
+				hci_dev_clear_flag(hdev, HCI_QUALITY_REPORT);
+		}
+
+		BT_INFO("quality report enable %d changed %d",
+			val, changed);
+
+		memcpy(rp.uuid, quality_report_uuid, 16);
+		rp.flags = cpu_to_le32(val ? BIT(0) : 0);
+		hci_sock_set_flag(sk, HCI_MGMT_EXP_FEATURE_EVENTS);
+		err = mgmt_cmd_complete(sk, hdev->id,
+					MGMT_OP_SET_EXP_FEATURE, 0,
+					&rp, sizeof(rp));
+
+		if (changed)
+			exp_quality_report_feature_changed(val, sk);
+
+unlock_quality_report:
+		hci_req_sync_unlock(hdev);
+		return err;
+	}
+#endif
+
 	return mgmt_cmd_status(sk, hdev ? hdev->id : MGMT_INDEX_NONE,
 			       MGMT_OP_SET_EXP_FEATURE,
 			       MGMT_STATUS_NOT_SUPPORTED);
-- 
2.32.0.288.g62a8d224e6-goog

