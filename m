Return-Path: <SRS0=B2uu=76=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2D3C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jun 2020 10:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18C22208B3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jun 2020 10:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgFQKmL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Jun 2020 06:42:11 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:50022 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgFQKmL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Jun 2020 06:42:11 -0400
Received: from localhost.localdomain (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id AC42ACECD3
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2020 12:52:01 +0200 (CEST)
From:   Marcel Holtmann <marcel@holtmann.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 01/14] Bluetooth: mgmt: Add commands for runtime configuration
Date:   Wed, 17 Jun 2020 12:41:52 +0200
Message-Id: <33f8fb3c32ce1940f2cb41adfe440ca0f77fc39c.1592390407.git.marcel@holtmann.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1592390407.git.marcel@holtmann.org>
References: <cover.1592390407.git.marcel@holtmann.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds the required read/set commands for runtime configuration. Even
while currently no parameters are specified, the commands are made
available.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c        |  7 +++++++
 net/bluetooth/mgmt_config.c | 18 ++++++++++++++++++
 net/bluetooth/mgmt_config.h |  6 ++++++
 3 files changed, 31 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 99fbfd467d04..ecfdfc4df486 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -114,6 +114,8 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_SET_EXP_FEATURE,
 	MGMT_OP_READ_DEF_SYSTEM_CONFIG,
 	MGMT_OP_SET_DEF_SYSTEM_CONFIG,
+	MGMT_OP_READ_DEF_RUNTIME_CONFIG,
+	MGMT_OP_SET_DEF_RUNTIME_CONFIG,
 };
 
 static const u16 mgmt_events[] = {
@@ -166,6 +168,7 @@ static const u16 mgmt_untrusted_commands[] = {
 	MGMT_OP_READ_SECURITY_INFO,
 	MGMT_OP_READ_EXP_FEATURES_INFO,
 	MGMT_OP_READ_DEF_SYSTEM_CONFIG,
+	MGMT_OP_READ_DEF_RUNTIME_CONFIG,
 };
 
 static const u16 mgmt_untrusted_events[] = {
@@ -7305,6 +7308,10 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
 						HCI_MGMT_UNTRUSTED },
 	{ set_def_system_config,   MGMT_SET_DEF_SYSTEM_CONFIG_SIZE,
 						HCI_MGMT_VAR_LEN },
+	{ read_def_runtime_config, MGMT_READ_DEF_RUNTIME_CONFIG_SIZE,
+						HCI_MGMT_UNTRUSTED },
+	{ set_def_runtime_config,  MGMT_SET_DEF_RUNTIME_CONFIG_SIZE,
+						HCI_MGMT_VAR_LEN },
 };
 
 void mgmt_index_added(struct hci_dev *hdev)
diff --git a/net/bluetooth/mgmt_config.c b/net/bluetooth/mgmt_config.c
index f6dfbe93542c..8e7ad2a51dbb 100644
--- a/net/bluetooth/mgmt_config.c
+++ b/net/bluetooth/mgmt_config.c
@@ -251,3 +251,21 @@ int set_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 			       MGMT_OP_SET_DEF_SYSTEM_CONFIG,
 			       MGMT_STATUS_SUCCESS);
 }
+
+int read_def_runtime_config(struct sock *sk, struct hci_dev *hdev, void *data,
+			    u16 data_len)
+{
+	bt_dev_dbg(hdev, "sock %p", sk);
+
+	return mgmt_cmd_complete(sk, hdev->id,
+				 MGMT_OP_READ_DEF_RUNTIME_CONFIG, 0, NULL, 0);
+}
+
+int set_def_runtime_config(struct sock *sk, struct hci_dev *hdev, void *data,
+			   u16 data_len)
+{
+	bt_dev_dbg(hdev, "sock %p", sk);
+
+	return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_DEF_SYSTEM_CONFIG,
+			       MGMT_STATUS_INVALID_PARAMS);
+}
diff --git a/net/bluetooth/mgmt_config.h b/net/bluetooth/mgmt_config.h
index 51da6e63b1a0..a4965f107891 100644
--- a/net/bluetooth/mgmt_config.h
+++ b/net/bluetooth/mgmt_config.h
@@ -9,3 +9,9 @@ int read_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 
 int set_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 			  u16 data_len);
+
+int read_def_runtime_config(struct sock *sk, struct hci_dev *hdev, void *data,
+			    u16 data_len);
+
+int set_def_runtime_config(struct sock *sk, struct hci_dev *hdev, void *data,
+			   u16 data_len);
-- 
2.26.2

