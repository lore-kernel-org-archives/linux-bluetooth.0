Return-Path: <SRS0=nALV=6T=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD24C4725B
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 May 2020 23:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D496620721
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 May 2020 23:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbgEEXUs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 May 2020 19:20:48 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:41466 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbgEEXUr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 May 2020 19:20:47 -0400
Received: from localhost.localdomain (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 43AE4CED03
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2020 01:30:26 +0200 (CEST)
From:   Marcel Holtmann <marcel@holtmann.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 7/7] Bluetooth: Introduce debug feature when dynamic debug is disabled
Date:   Wed,  6 May 2020 01:20:39 +0200
Message-Id: <e913503a6fcc4c8aa78ea498b94a9a6893362052.1588720791.git.marcel@holtmann.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1588720791.git.marcel@holtmann.org>
References: <cover.1588720791.git.marcel@holtmann.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In case dynamic debug is disabled, this feature allows a vendor platform
to provide debug statement printing.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/bluetooth.h | 11 +++++
 net/bluetooth/Kconfig             |  7 ++++
 net/bluetooth/lib.c               | 33 +++++++++++++++
 net/bluetooth/mgmt.c              | 69 +++++++++++++++++++++++++++++++
 4 files changed, 120 insertions(+)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 3fa7b1e3c5d9..18190055374c 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -153,6 +153,12 @@ __printf(1, 2)
 void bt_warn(const char *fmt, ...);
 __printf(1, 2)
 void bt_err(const char *fmt, ...);
+#if IS_ENABLED(CONFIG_BT_FEATURE_DEBUG)
+void bt_dbg_set(bool enable);
+bool bt_dbg_get(void);
+__printf(1, 2)
+void bt_dbg(const char *fmt, ...);
+#endif
 __printf(1, 2)
 void bt_warn_ratelimited(const char *fmt, ...);
 __printf(1, 2)
@@ -161,7 +167,12 @@ void bt_err_ratelimited(const char *fmt, ...);
 #define BT_INFO(fmt, ...)	bt_info(fmt "\n", ##__VA_ARGS__)
 #define BT_WARN(fmt, ...)	bt_warn(fmt "\n", ##__VA_ARGS__)
 #define BT_ERR(fmt, ...)	bt_err(fmt "\n", ##__VA_ARGS__)
+
+#if IS_ENABLED(CONFIG_BT_FEATURE_DEBUG)
+#define BT_DBG(fmt, ...)	bt_dbg(fmt "\n", ##__VA_ARGS__)
+#else
 #define BT_DBG(fmt, ...)	pr_debug(fmt "\n", ##__VA_ARGS__)
+#endif
 
 #define bt_dev_info(hdev, fmt, ...)				\
 	BT_INFO("%s: " fmt, (hdev)->name, ##__VA_ARGS__)
diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
index 9e25c6570170..1d6d243cdde9 100644
--- a/net/bluetooth/Kconfig
+++ b/net/bluetooth/Kconfig
@@ -135,4 +135,11 @@ config BT_SELFTEST_SMP
 	  Run test cases for SMP cryptographic functionality, including both
 	  legacy SMP as well as the Secure Connections features.
 
+config BT_FEATURE_DEBUG
+	bool "Enable runtime option for debugging statements"
+	depends on BT && !DYNAMIC_DEBUG
+	help
+	  This provides an option to enable/disable debugging statements
+	  at runtime via the experimental features interface.
+
 source "drivers/bluetooth/Kconfig"
diff --git a/net/bluetooth/lib.c b/net/bluetooth/lib.c
index c09e0a3a0ed9..5326f41a58b7 100644
--- a/net/bluetooth/lib.c
+++ b/net/bluetooth/lib.c
@@ -183,6 +183,39 @@ void bt_err(const char *format, ...)
 }
 EXPORT_SYMBOL(bt_err);
 
+#ifdef CONFIG_BT_FEATURE_DEBUG
+static bool debug_enable;
+
+void bt_dbg_set(bool enable)
+{
+	debug_enable = enable;
+}
+
+bool bt_dbg_get(void)
+{
+	return debug_enable;
+}
+
+void bt_dbg(const char *format, ...)
+{
+	struct va_format vaf;
+	va_list args;
+
+	if (likely(!debug_enable))
+		return;
+
+	va_start(args, format);
+
+	vaf.fmt = format;
+	vaf.va = &args;
+
+	printk(KERN_DEBUG pr_fmt("%pV"), &vaf);
+
+	va_end(args);
+}
+EXPORT_SYMBOL(bt_dbg);
+#endif
+
 void bt_warn_ratelimited(const char *format, ...)
 {
 	struct va_format vaf;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index df85ad5c827a..7f28a80d6618 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3715,6 +3715,14 @@ static int read_security_info(struct sock *sk, struct hci_dev *hdev,
 				 rp, sizeof(*rp) + sec_len);
 }
 
+#ifdef CONFIG_BT_FEATURE_DEBUG
+/* d4992530-b9ec-469f-ab01-6c481c47da1c */
+static const u8 debug_uuid[16] = {
+	0x1c, 0xda, 0x47, 0x1c, 0x48, 0x6c, 0x01, 0xab,
+	0x9f, 0x46, 0xec, 0xb9, 0x30, 0x25, 0x99, 0xd4,
+};
+#endif
+
 static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
 				  void *data, u16 data_len)
 {
@@ -3726,6 +3734,15 @@ static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
 
 	memset(&buf, 0, sizeof(buf));
 
+#ifdef CONFIG_BT_FEATURE_DEBUG
+	if (!hdev) {
+		u32 flags = bt_dbg_get() ? BIT(0) : 0;
+		memcpy(rp->features[idx].uuid, debug_uuid, 16);
+		rp->features[idx].flags = cpu_to_le32(flags);
+		idx++;
+	}
+#endif
+
 	rp->feature_count = cpu_to_le16(idx);
 
 	/* After reading the experimental features information, enable
@@ -3763,6 +3780,15 @@ static int set_exp_feature(struct sock *sk, struct hci_dev *hdev,
 		memset(rp.uuid, 0, 16);
 		rp.flags = cpu_to_le32(0);
 
+#ifdef CONFIG_BT_FEATURE_DEBUG
+		if (!hdev) {
+			bool changed = bt_dbg_get();
+			bt_dbg_set(false);
+			if (changed)
+				exp_debug_feature_changed(false, sk);
+		}
+#endif
+
 		hci_sock_set_flag(sk, HCI_MGMT_EXP_FEATURE_EVENTS);
 
 		return mgmt_cmd_complete(sk, hdev ? hdev->id : MGMT_INDEX_NONE,
@@ -3770,6 +3796,49 @@ static int set_exp_feature(struct sock *sk, struct hci_dev *hdev,
 					 &rp, sizeof(rp));
 	}
 
+#ifdef CONFIG_BT_FEATURE_DEBUG
+	if (!memcmp(cp->uuid, debug_uuid, 16)) {
+		bool val, changed;
+		int err;
+
+		/* Command requires to use the non-controller index */
+		if (hdev)
+			return mgmt_cmd_status(sk, hdev->id,
+					       MGMT_OP_SET_EXP_FEATURE,
+					       MGMT_STATUS_INVALID_INDEX);
+
+		/* Paramters are limited to a single octet */
+		if (data_len != MGMT_SET_EXP_FEATURE_SIZE + 1)
+			return mgmt_cmd_status(sk, MGMT_INDEX_NONE,
+					       MGMT_OP_SET_EXP_FEATURE,
+					       MGMT_STATUS_INVALID_PARAMS);
+
+		/* Only boolean on/off is supported */
+		if (cp->param[0] != 0x00 && cp->param[0] != 0x01)
+			return mgmt_cmd_status(sk, MGMT_INDEX_NONE,
+					       MGMT_OP_SET_EXP_FEATURE,
+					       MGMT_STATUS_INVALID_PARAMS);
+
+		val = !!cp->param[0];
+		changed = val ? !bt_dbg_get() : bt_dbg_get();
+		bt_dbg_set(val);
+
+		memcpy(rp.uuid, debug_uuid, 16);
+		rp.flags = cpu_to_le32(val ? BIT(0) : 0);
+
+		hci_sock_set_flag(sk, HCI_MGMT_EXP_FEATURE_EVENTS);
+
+		err = mgmt_cmd_complete(sk, MGMT_INDEX_NONE,
+					MGMT_OP_SET_EXP_FEATURE, 0,
+					&rp, sizeof(rp));
+
+		if (changed)
+			exp_debug_feature_changed(val, sk);
+
+		return err;
+	}
+#endif
+
 	return mgmt_cmd_status(sk, hdev ? hdev->id : MGMT_INDEX_NONE,
 			       MGMT_OP_SET_EXP_FEATURE,
 			       MGMT_STATUS_NOT_SUPPORTED);
-- 
2.26.2

