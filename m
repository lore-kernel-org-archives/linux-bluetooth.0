Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6DCC43462
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Apr 2021 06:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94572610CF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Apr 2021 06:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbhDAGx4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Apr 2021 02:53:56 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:15426 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbhDAGx1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Apr 2021 02:53:27 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F9v3s4GbQzjXhm;
        Thu,  1 Apr 2021 14:51:37 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Thu, 1 Apr 2021 14:53:14 +0800
From:   Meng Yu <yumeng18@huawei.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <luiz.dentz@gmail.com>
CC:     <linux-bluetooth@vger.kernel.org>, <wangzhou1@hisilicon.com>,
        <yumeng18@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] Bluetooth: Coding style fix
Date:   Thu, 1 Apr 2021 14:50:39 +0800
Message-ID: <1617259839-31383-3-git-send-email-yumeng18@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1617259839-31383-1-git-send-email-yumeng18@huawei.com>
References: <1617259839-31383-1-git-send-email-yumeng18@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

1. Add space when needed;
2. Block comments style fix;
3. Move open brace '{' following function definitions to the next line;
4. Remove unnecessary braces '{}' for single statement blocks.

Signed-off-by: Meng Yu <yumeng18@huawei.com>
---
 net/bluetooth/6lowpan.c     | 3 +--
 net/bluetooth/hci_debugfs.c | 8 ++++----
 net/bluetooth/hci_event.c   | 2 +-
 net/bluetooth/hci_request.c | 6 ++----
 net/bluetooth/l2cap_core.c  | 5 +++--
 5 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 19f7e42..97617d0 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -205,8 +205,7 @@ static inline struct lowpan_peer *peer_lookup_dst(struct lowpan_btle_dev *dev,
 		}
 	}
 
-	/* use the neighbour cache for matching addresses assigned by SLAAC
-	*/
+	/* use the neighbour cache for matching addresses assigned by SLAAC */
 	neigh = __ipv6_neigh_lookup(dev->netdev, nexthop);
 	if (neigh) {
 		list_for_each_entry_rcu(peer, &dev->peers, list) {
diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index 1a0ab58..47f4f21 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -274,7 +274,7 @@ static ssize_t use_debug_keys_read(struct file *file, char __user *user_buf,
 	struct hci_dev *hdev = file->private_data;
 	char buf[3];
 
-	buf[0] = hci_dev_test_flag(hdev, HCI_USE_DEBUG_KEYS) ? 'Y': 'N';
+	buf[0] = hci_dev_test_flag(hdev, HCI_USE_DEBUG_KEYS) ? 'Y' : 'N';
 	buf[1] = '\n';
 	buf[2] = '\0';
 	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
@@ -292,7 +292,7 @@ static ssize_t sc_only_mode_read(struct file *file, char __user *user_buf,
 	struct hci_dev *hdev = file->private_data;
 	char buf[3];
 
-	buf[0] = hci_dev_test_flag(hdev, HCI_SC_ONLY) ? 'Y': 'N';
+	buf[0] = hci_dev_test_flag(hdev, HCI_SC_ONLY) ? 'Y' : 'N';
 	buf[1] = '\n';
 	buf[2] = '\0';
 	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
@@ -428,7 +428,7 @@ static ssize_t ssp_debug_mode_read(struct file *file, char __user *user_buf,
 	struct hci_dev *hdev = file->private_data;
 	char buf[3];
 
-	buf[0] = hdev->ssp_debug_mode ? 'Y': 'N';
+	buf[0] = hdev->ssp_debug_mode ? 'Y' : 'N';
 	buf[1] = '\n';
 	buf[2] = '\0';
 	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
@@ -742,7 +742,7 @@ static ssize_t force_static_address_read(struct file *file,
 	struct hci_dev *hdev = file->private_data;
 	char buf[3];
 
-	buf[0] = hci_dev_test_flag(hdev, HCI_FORCE_STATIC_ADDR) ? 'Y': 'N';
+	buf[0] = hci_dev_test_flag(hdev, HCI_FORCE_STATIC_ADDR) ? 'Y' : 'N';
 	buf[1] = '\n';
 	buf[2] = '\0';
 	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 341c8ce..593eafa 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5891,7 +5891,7 @@ static void hci_le_remote_conn_param_req_evt(struct hci_dev *hdev,
 			params->conn_latency = latency;
 			params->supervision_timeout = timeout;
 			store_hint = 0x01;
-		} else{
+		} else {
 			store_hint = 0x00;
 		}
 
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 8ace5d3..6cd9d41 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1647,9 +1647,8 @@ static u8 create_default_scan_rsp_data(struct hci_dev *hdev, u8 *ptr)
 {
 	u8 scan_rsp_len = 0;
 
-	if (hdev->appearance) {
+	if (hdev->appearance)
 		scan_rsp_len = append_appearance(hdev, ptr, scan_rsp_len);
-	}
 
 	return append_local_name(hdev, ptr, scan_rsp_len);
 }
@@ -1667,9 +1666,8 @@ static u8 create_instance_scan_rsp_data(struct hci_dev *hdev, u8 instance,
 
 	instance_flags = adv_instance->flags;
 
-	if ((instance_flags & MGMT_ADV_FLAG_APPEARANCE) && hdev->appearance) {
+	if ((instance_flags & MGMT_ADV_FLAG_APPEARANCE) && hdev->appearance)
 		scan_rsp_len = append_appearance(hdev, ptr, scan_rsp_len);
-	}
 
 	memcpy(&ptr[scan_rsp_len], adv_instance->scan_rsp_data,
 	       adv_instance->scan_rsp_len);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ccfe8ad..6e10cb8 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -652,7 +652,7 @@ void l2cap_chan_del(struct l2cap_chan *chan, int err)
 	if (test_bit(CONF_NOT_COMPLETE, &chan->conf_state))
 		return;
 
-	switch(chan->mode) {
+	switch (chan->mode) {
 	case L2CAP_MODE_BASIC:
 		break;
 
@@ -7770,7 +7770,8 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon)
 	return conn;
 }
 
-static bool is_valid_psm(u16 psm, u8 dst_type) {
+static bool is_valid_psm(u16 psm, u8 dst_type)
+{
 	if (!psm)
 		return false;
 
-- 
2.8.1

