Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B71C4707F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 May 2021 10:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 185AB610FC
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 May 2021 10:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbhEYKcL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 May 2021 06:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbhEYKbe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 May 2021 06:31:34 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87A3C061342
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 May 2021 03:30:04 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id l19-20020a0ce0930000b02901efdf1c21ecso27218701qvk.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 May 2021 03:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wWp/nYm1O9GCySLh9sjRTVHjweM2mmdgbNbDdbIRZUU=;
        b=J+KIF9KMrB2aiSad9al7yVc1tXTCu2x9xwcjY9tVaDhG1BBGY7O3LzF9vm2CiX09f/
         EfBqvUSL+UIl+vYtqqDDQGpXYy1mBk0FI3AMd/sjHuv9Z40jHK8vJxrN+lhPVr/YGLxm
         omYzvogS8MDiNVSIvFf+KXYcX7wG9SXrw6HKt1ioicvN4zMzoBU9sFp3dCLnKtDMwTSy
         IEH9uvweKkR2Adkr6ov2I2g4vXnmGolGWCSSIEbDgozNP2IP0aYSU6O8brkmvafsHv9Y
         2CAeyz1vkok5r/TkYNkLayFgOBHRVEfhYCVdrUOCPv/1jFKLYerT9Bq4eAVuE7NSO4yS
         fWGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wWp/nYm1O9GCySLh9sjRTVHjweM2mmdgbNbDdbIRZUU=;
        b=pKfOrPpaK0biHZ+nXSlmQTawVBGsvmPwkwStHjP10OTmP+E4Rw6PHw7Ier16juOCQJ
         SNpw+S+86EsLFGEbzFF7HqyiqFEHeqbLdNP0+vssiWhkn2EIuDJqrsQjNFBmLXbW96Rm
         AgFOJsd5MiuzpcNW712l8xnAvxlVVLwucWyTM2nZNci64vE3WZdyTM6L9dd/c4w7C5yS
         ZnE5x57h25/J8oT67uCb3Txpie9sOOlQ1Jkco8prZxkm0FOzl09I5XsTb5z9iH6Gx7Wl
         +TLWtkyxu/of0O1j5YPg1oLFsRwxrfXfPWjIjkkDvuld47bNalgq0mcNaoYwZ+Ucmg7C
         Rc4Q==
X-Gm-Message-State: AOAM5322sGey1Hbz0brN66INqdv9okhR1/YBIEsyJPTCR0zAsFbnTerV
        xdraBPq6CgSIht+b3WwJzLOjalNQgOFzT6GY+zqgLzLkxcvYGhLXBHNj3AMOBa4BFOlBJwOhE9J
        utja2slEHYMGGKUrChQNKvuxPreYi2Df4qEgZNdFNxEQ7od01f6F/ROJooX/A6P6c30trw55IQc
        tt
X-Google-Smtp-Source: ABdhPJw1BeTG0QMP7d5/tolqIPmM+Cf+ZGftbZUwhZIWGzrsNnXQUr7bIEf99EP5MztG3WhgAs0ZQYBXw0sx
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:8806:6b98:8ae6:8824])
 (user=apusaka job=sendgmr) by 2002:a05:6214:902:: with SMTP id
 dj2mr36100058qvb.11.1621938603791; Tue, 25 May 2021 03:30:03 -0700 (PDT)
Date:   Tue, 25 May 2021 18:29:32 +0800
In-Reply-To: <20210525102941.3958649-1-apusaka@google.com>
Message-Id: <20210525182900.3.Icd1fee7b40dcfec866286803065a3d19dd9ca7ed@changeid>
Mime-Version: 1.0
References: <20210525102941.3958649-1-apusaka@google.com>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH 03/12] Bluetooth: use inclusive language to describe CPB
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

Use "central" and "peripheral" to describe the Connectionless
Peripheral Broadcast feature.

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>

---

 include/net/bluetooth/hci.h      | 26 +++++++++++++-------------
 include/net/bluetooth/hci_core.h |  4 ++--
 net/bluetooth/hci_conn.c         |  2 +-
 net/bluetooth/hci_core.c         | 16 ++++++++--------
 4 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index c3efef266d6d..a7cf5a2d87c5 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -36,7 +36,7 @@
 
 #define HCI_MAX_AMP_ASSOC_SIZE	672
 
-#define HCI_MAX_CSB_DATA_SIZE	252
+#define HCI_MAX_CPB_DATA_SIZE	252
 
 /* HCI dev events */
 #define HCI_DEV_REG			1
@@ -472,10 +472,10 @@ enum {
 #define LMP_EXTFEATURES	0x80
 
 /* Extended LMP features */
-#define LMP_CSB_MASTER	0x01
-#define LMP_CSB_SLAVE	0x02
-#define LMP_SYNC_TRAIN	0x04
-#define LMP_SYNC_SCAN	0x08
+#define LMP_CPB_CENTRAL		0x01
+#define LMP_CPB_PERIPHERAL	0x02
+#define LMP_SYNC_TRAIN		0x04
+#define LMP_SYNC_SCAN		0x08
 
 #define LMP_SC		0x01
 #define LMP_PING	0x02
@@ -877,17 +877,17 @@ struct hci_rp_logical_link_cancel {
 	__u8     flow_spec_id;
 } __packed;
 
-#define HCI_OP_SET_CSB			0x0441
-struct hci_cp_set_csb {
+#define HCI_OP_SET_CPB			0x0441
+struct hci_cp_set_cpb {
 	__u8	enable;
 	__u8	lt_addr;
 	__u8	lpo_allowed;
 	__le16	packet_type;
 	__le16	interval_min;
 	__le16	interval_max;
-	__le16	csb_sv_tout;
+	__le16	cpb_sv_tout;
 } __packed;
-struct hci_rp_set_csb {
+struct hci_rp_set_cpb {
 	__u8	status;
 	__u8	lt_addr;
 	__le16	interval;
@@ -1184,14 +1184,14 @@ struct hci_rp_delete_reserved_lt_addr {
 	__u8	lt_addr;
 } __packed;
 
-#define HCI_OP_SET_CSB_DATA		0x0c76
-struct hci_cp_set_csb_data {
+#define HCI_OP_SET_CPB_DATA		0x0c76
+struct hci_cp_set_cpb_data {
 	__u8	lt_addr;
 	__u8	fragment;
 	__u8	data_length;
-	__u8	data[HCI_MAX_CSB_DATA_SIZE];
+	__u8	data[HCI_MAX_CPB_DATA_SIZE];
 } __packed;
-struct hci_rp_set_csb_data {
+struct hci_rp_set_cpb_data {
 	__u8	status;
 	__u8	lt_addr;
 } __packed;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 368e16fdf441..929768f6ed93 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1394,8 +1394,8 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 #define lmp_edr_5slot_capable(dev) ((dev)->features[0][5] & LMP_EDR_5SLOT)
 
 /* ----- Extended LMP capabilities ----- */
-#define lmp_csb_master_capable(dev) ((dev)->features[2][0] & LMP_CSB_MASTER)
-#define lmp_csb_slave_capable(dev)  ((dev)->features[2][0] & LMP_CSB_SLAVE)
+#define lmp_cpb_central_capable(dev) ((dev)->features[2][0] & LMP_CPB_CENTRAL)
+#define lmp_cpb_peripheral_capable(dev) ((dev)->features[2][0] & LMP_CPB_PERIPHERAL)
 #define lmp_sync_train_capable(dev) ((dev)->features[2][0] & LMP_SYNC_TRAIN)
 #define lmp_sync_scan_capable(dev)  ((dev)->features[2][0] & LMP_SYNC_SCAN)
 #define lmp_sc_capable(dev)         ((dev)->features[2][1] & LMP_SC)
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 703470b6b924..7b8784d4da96 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1842,7 +1842,7 @@ u32 hci_conn_get_phy(struct hci_conn *conn)
 
 	/* BLUETOOTH CORE SPECIFICATION Version 5.2 | Vol 2, Part B page 471:
 	 * Table 6.2: Packets defined for synchronous, asynchronous, and
-	 * CSB logical transport types.
+	 * CPB logical transport types.
 	 */
 	switch (conn->type) {
 	case SCO_LINK:
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 4ac6022f7085..b9ebad0f8fb9 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -545,24 +545,24 @@ static void hci_set_event_mask_page_2(struct hci_request *req)
 	u8 events[8] = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
 	bool changed = false;
 
-	/* If Connectionless Slave Broadcast master role is supported
+	/* If Connectionless Peripheral Broadcast central role is supported
 	 * enable all necessary events for it.
 	 */
-	if (lmp_csb_master_capable(hdev)) {
+	if (lmp_cpb_central_capable(hdev)) {
 		events[1] |= 0x40;	/* Triggered Clock Capture */
 		events[1] |= 0x80;	/* Synchronization Train Complete */
-		events[2] |= 0x10;	/* Slave Page Response Timeout */
-		events[2] |= 0x20;	/* CSB Channel Map Change */
+		events[2] |= 0x10;	/* Peripheral Page Response Timeout */
+		events[2] |= 0x20;	/* CPB Channel Map Change */
 		changed = true;
 	}
 
-	/* If Connectionless Slave Broadcast slave role is supported
+	/* If Connectionless Peripheral Broadcast peripheral role is supported
 	 * enable all necessary events for it.
 	 */
-	if (lmp_csb_slave_capable(hdev)) {
+	if (lmp_cpb_peripheral_capable(hdev)) {
 		events[2] |= 0x01;	/* Synchronization Train Received */
-		events[2] |= 0x02;	/* CSB Receive */
-		events[2] |= 0x04;	/* CSB Timeout */
+		events[2] |= 0x02;	/* CPB Receive */
+		events[2] |= 0x04;	/* CPB Timeout */
 		events[2] |= 0x08;	/* Truncated Page Complete */
 		changed = true;
 	}
-- 
2.31.1.818.g46aad6cb9e-goog

