Return-Path: <SRS0=zRH5=6U=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A56C47254
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 May 2020 02:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD37D20735
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 May 2020 02:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgEFCyK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 May 2020 22:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbgEFCyK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 May 2020 22:54:10 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F93C061A41
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2020 19:54:10 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2607:f2c0:f00e:4a00:e12:aed3:7421:b166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: tester)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id B0FC42A0662;
        Wed,  6 May 2020 03:54:07 +0100 (BST)
From:   =?UTF-8?q?Olivier=20Cr=C3=AAte?= <olivier.crete@collabora.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Subject: [PATCH] Bluetooth: Avoid calling device_add() on duplicated HCI conn event
Date:   Tue,  5 May 2020 22:53:58 -0400
Message-Id: <20200506025358.361519-1-olivier.crete@collabora.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The BCM20702A1 device in the ThinkPad x230 seems to send the HCI
Connection Complete event twice for the same connection, for which the
stack seems to recover, except for the core device_add() function
which is not meant to be called twice for the same device. So let's
just avoid calling it in that case.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=204633
Signed-off-by: Olivier Crête <olivier.crete@collabora.com>
Cc: stable@vger.kernel.org
---
 include/net/bluetooth/hci_core.h | 3 +++
 net/bluetooth/hci_conn.c         | 1 +
 net/bluetooth/hci_event.c        | 8 ++++++--
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index d4e28773d378..b74669397dbb 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -500,6 +500,9 @@ struct hci_dev {
 
 #define HCI_PHY_HANDLE(handle)	(handle & 0xff)
 
+/* Valid HCI handles are in the 0x0000-0x0EFF range per spec */
+#define HCI_INVALID_HANDLE 0xFFFF
+
 struct hci_conn {
 	struct list_head list;
 
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index e245bc155cc2..edf12a3f46aa 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -532,6 +532,7 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
 	conn->rssi = HCI_RSSI_INVALID;
 	conn->tx_power = HCI_TX_POWER_INVALID;
 	conn->max_tx_power = HCI_TX_POWER_INVALID;
+	conn->handle = HCI_INVALID_HANDLE;
 
 	set_bit(HCI_CONN_POWER_SAVE, &conn->flags);
 	conn->disc_timeout = HCI_DISCONN_TIMEOUT;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 0a591be8b0ae..e498f70fcda9 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2553,6 +2553,8 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	}
 
 	if (!ev->status) {
+		int first_connection = (conn->handle == HCI_INVALID_HANDLE);
+
 		conn->handle = __le16_to_cpu(ev->handle);
 
 		if (conn->type == ACL_LINK) {
@@ -2567,8 +2569,10 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		} else
 			conn->state = BT_CONNECTED;
 
-		hci_debugfs_create_conn(conn);
-		hci_conn_add_sysfs(conn);
+		if (first_connection) {
+			hci_debugfs_create_conn(conn);
+			hci_conn_add_sysfs(conn);
+		}
 
 		if (test_bit(HCI_AUTH, &hdev->flags))
 			set_bit(HCI_CONN_AUTH, &conn->flags);
-- 
2.26.2

