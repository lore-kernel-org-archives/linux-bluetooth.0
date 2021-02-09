Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BBBC4332B
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Feb 2021 13:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D00564ED5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Feb 2021 13:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbhBINis (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Feb 2021 08:38:48 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:34048 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbhBINiG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Feb 2021 08:38:06 -0500
Received: from [123.112.66.2] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <hui.wang@canonical.com>)
        id 1l9TCl-00050T-73; Tue, 09 Feb 2021 13:37:24 +0000
From:   Hui Wang <hui.wang@canonical.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        johan.hedberg@intel.com, luiz.dentz@gmail.com
Subject: [PATCH 3/3] Bluetooth: reset_hci experimental feature
Date:   Tue,  9 Feb 2021 21:36:28 +0800
Message-Id: <20210209133629.12784-4-hui.wang@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210209133629.12784-1-hui.wang@canonical.com>
References: <20210209133629.12784-1-hui.wang@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

If the hci_dev->reset_hci is set by the driver like btusb, users could
call reset_hci through mgmt protocol.

reset_hci will make the hci reset from the bus they are bond and
if possible make the hci enter bootloader mode, so the disconnect()
and probe() in the driver will be called, the function disconnect()
will release all resources belong to this hci, there is no need to
release resource before calling reset_hci.

Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 net/bluetooth/mgmt.c | 57 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 4ac85e24906b..e16977b16bed 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3876,6 +3876,12 @@ static const u8 rpa_resolution_uuid[16] = {
 	0xea, 0x11, 0x73, 0xc2, 0x48, 0xa1, 0xc0, 0x15,
 };
 
+/* 3f06cef5-2b4f-4c22-b1f4-64bb4733e637 */
+static const u8 reset_hci_uuid[16] = {
+	0x37, 0xe6, 0x33, 0x47, 0xbb, 0x64, 0xf4, 0xb1,
+	0x22, 0x4c, 0x4f, 0x2b, 0xf5, 0xce, 0x06, 0x3f,
+};
+
 static int exp_ll_privacy_feature_changed(bool enabled, struct hci_dev *hdev,
 					  struct sock *skip)
 {
@@ -3992,6 +3998,53 @@ static int exp_set_rpa_resolution(struct sock *sk, struct hci_dev *hdev,
 	return err;
 }
 
+static void exp_read_reset_hci_info(struct hci_dev *hdev, const u8 *uuid, u16 *idx,
+				    struct mgmt_rp_read_exp_features_info *rp)
+{
+	u32 flags;
+
+	if (!hdev)
+		return;
+
+	if (!hdev->reset_hci)
+		return;
+
+	flags = BIT(0);
+	memcpy(rp->features[*idx].uuid, uuid, sizeof(rp->features[*idx].uuid));
+	rp->features[(*idx)++].flags = cpu_to_le32(flags);
+}
+
+static int exp_set_reset_hci(struct sock *sk, struct hci_dev *hdev,
+			     const u8 *uuid, u16 data_len,
+			     struct mgmt_cp_set_exp_feature *cp)
+{
+	struct mgmt_rp_set_exp_feature rp;
+	int err;
+
+	/* Command requires to use the controller index */
+	if (!hdev)
+		return mgmt_cmd_status(sk, MGMT_INDEX_NONE,
+				       MGMT_OP_SET_EXP_FEATURE,
+				       MGMT_STATUS_INVALID_INDEX);
+
+	if (!hdev->reset_hci)
+		return mgmt_cmd_status(sk, hdev->id,
+				       MGMT_OP_SET_EXP_FEATURE,
+				       MGMT_STATUS_NOT_SUPPORTED);
+
+	hdev->reset_hci(hdev);
+
+	memcpy(rp.uuid, uuid, sizeof(rp.uuid));
+	rp.flags = cpu_to_le32(BIT(0));
+
+	hci_sock_set_flag(sk, HCI_MGMT_EXP_FEATURE_EVENTS);
+
+	err = mgmt_cmd_complete(sk, hdev->id,
+				MGMT_OP_SET_EXP_FEATURE, 0,
+				&rp, sizeof(rp));
+	return err;
+}
+
 static const struct exp_feature exp_feature_list[] = {
 #ifdef CONFIG_BT_FEATURE_DEBUG
 	EXP_FEATURE_ENTRY(debug_uuid, exp_read_debug_info,
@@ -4001,13 +4054,15 @@ static const struct exp_feature exp_feature_list[] = {
 			  NULL),
 	EXP_FEATURE_ENTRY(rpa_resolution_uuid, exp_read_rpa_resolution,
 			  exp_set_rpa_resolution),
+	EXP_FEATURE_ENTRY(reset_hci_uuid, exp_read_reset_hci_info,
+			  exp_set_reset_hci),
 	{}
 };
 
 static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
 				  void *data, u16 data_len)
 {
-	char buf[62] = {0}; /* Enough space for 3 features */
+	char buf[82] = {0}; /* Enough space for 4 features */
 	struct mgmt_rp_read_exp_features_info *rp = (void *)buf;
 	u16 idx = 0;
 	int i;
-- 
2.25.1

