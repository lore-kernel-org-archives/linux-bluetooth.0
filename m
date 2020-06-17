Return-Path: <SRS0=B2uu=76=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D70C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jun 2020 10:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 155EE2082F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jun 2020 10:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgFQKmW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Jun 2020 06:42:22 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:39671 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbgFQKmL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Jun 2020 06:42:11 -0400
Received: from localhost.localdomain (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id CC35FCECD4
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2020 12:52:01 +0200 (CEST)
From:   Marcel Holtmann <marcel@holtmann.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 02/14] Bluetooth: Add bdaddr_list_with_flags for classic whitelist
Date:   Wed, 17 Jun 2020 12:41:53 +0200
Message-Id: <0ec7794d0a40d3462433de4fe57f74b3c7f5a9b7.1592390407.git.marcel@holtmann.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1592390407.git.marcel@holtmann.org>
References: <cover.1592390407.git.marcel@holtmann.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>

In order to more easily add device flags to classic devices, create
a new type of bdaddr_list that supports setting flags.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Alain Michaud <alainm@chromium.org>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h | 18 ++++++++--
 net/bluetooth/hci_core.c         | 58 ++++++++++++++++++++++++++++++++
 net/bluetooth/hci_event.c        |  8 ++---
 net/bluetooth/mgmt.c             |  5 +--
 4 files changed, 81 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 0d5dbb6cb5a0..95a3935325bb 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -136,6 +136,13 @@ struct bdaddr_list_with_irk {
 	u8 local_irk[16];
 };
 
+struct bdaddr_list_with_flags {
+	struct list_head list;
+	bdaddr_t bdaddr;
+	u8 bdaddr_type;
+	u32 current_flags;
+};
+
 struct bt_uuid {
 	struct list_head list;
 	u8 uuid[16];
@@ -1169,12 +1176,19 @@ struct bdaddr_list *hci_bdaddr_list_lookup(struct list_head *list,
 struct bdaddr_list_with_irk *hci_bdaddr_list_lookup_with_irk(
 				    struct list_head *list, bdaddr_t *bdaddr,
 				    u8 type);
+struct bdaddr_list_with_flags *
+hci_bdaddr_list_lookup_with_flags(struct list_head *list, bdaddr_t *bdaddr,
+				  u8 type);
 int hci_bdaddr_list_add(struct list_head *list, bdaddr_t *bdaddr, u8 type);
 int hci_bdaddr_list_add_with_irk(struct list_head *list, bdaddr_t *bdaddr,
-					u8 type, u8 *peer_irk, u8 *local_irk);
+				 u8 type, u8 *peer_irk, u8 *local_irk);
+int hci_bdaddr_list_add_with_flags(struct list_head *list, bdaddr_t *bdaddr,
+				   u8 type, u32 flags);
 int hci_bdaddr_list_del(struct list_head *list, bdaddr_t *bdaddr, u8 type);
 int hci_bdaddr_list_del_with_irk(struct list_head *list, bdaddr_t *bdaddr,
-								u8 type);
+				 u8 type);
+int hci_bdaddr_list_del_with_flags(struct list_head *list, bdaddr_t *bdaddr,
+				   u8 type);
 void hci_bdaddr_list_clear(struct list_head *list);
 
 struct hci_conn_params *hci_conn_params_lookup(struct hci_dev *hdev,
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 4f1052a7c488..8a471bec2731 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3023,6 +3023,20 @@ struct bdaddr_list_with_irk *hci_bdaddr_list_lookup_with_irk(
 	return NULL;
 }
 
+struct bdaddr_list_with_flags *
+hci_bdaddr_list_lookup_with_flags(struct list_head *bdaddr_list,
+				  bdaddr_t *bdaddr, u8 type)
+{
+	struct bdaddr_list_with_flags *b;
+
+	list_for_each_entry(b, bdaddr_list, list) {
+		if (!bacmp(&b->bdaddr, bdaddr) && b->bdaddr_type == type)
+			return b;
+	}
+
+	return NULL;
+}
+
 void hci_bdaddr_list_clear(struct list_head *bdaddr_list)
 {
 	struct bdaddr_list *b, *n;
@@ -3084,6 +3098,30 @@ int hci_bdaddr_list_add_with_irk(struct list_head *list, bdaddr_t *bdaddr,
 	return 0;
 }
 
+int hci_bdaddr_list_add_with_flags(struct list_head *list, bdaddr_t *bdaddr,
+				   u8 type, u32 flags)
+{
+	struct bdaddr_list_with_flags *entry;
+
+	if (!bacmp(bdaddr, BDADDR_ANY))
+		return -EBADF;
+
+	if (hci_bdaddr_list_lookup(list, bdaddr, type))
+		return -EEXIST;
+
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return -ENOMEM;
+
+	bacpy(&entry->bdaddr, bdaddr);
+	entry->bdaddr_type = type;
+	entry->current_flags = flags;
+
+	list_add(&entry->list, list);
+
+	return 0;
+}
+
 int hci_bdaddr_list_del(struct list_head *list, bdaddr_t *bdaddr, u8 type)
 {
 	struct bdaddr_list *entry;
@@ -3123,6 +3161,26 @@ int hci_bdaddr_list_del_with_irk(struct list_head *list, bdaddr_t *bdaddr,
 	return 0;
 }
 
+int hci_bdaddr_list_del_with_flags(struct list_head *list, bdaddr_t *bdaddr,
+				   u8 type)
+{
+	struct bdaddr_list_with_flags *entry;
+
+	if (!bacmp(bdaddr, BDADDR_ANY)) {
+		hci_bdaddr_list_clear(list);
+		return 0;
+	}
+
+	entry = hci_bdaddr_list_lookup_with_flags(list, bdaddr, type);
+	if (!entry)
+		return -ENOENT;
+
+	list_del(&entry->list);
+	kfree(entry);
+
+	return 0;
+}
+
 /* This function requires the caller holds hdev->lock */
 struct hci_conn_params *hci_conn_params_lookup(struct hci_dev *hdev,
 					       bdaddr_t *addr, u8 addr_type)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index cfeaee347db3..8981954ff4c4 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2697,10 +2697,10 @@ static void hci_conn_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	 */
 	if (hci_dev_test_flag(hdev, HCI_MGMT) &&
 	    !hci_dev_test_flag(hdev, HCI_CONNECTABLE) &&
-	    !hci_bdaddr_list_lookup(&hdev->whitelist, &ev->bdaddr,
-				    BDADDR_BREDR)) {
-		    hci_reject_conn(hdev, &ev->bdaddr);
-		    return;
+	    !hci_bdaddr_list_lookup_with_flags(&hdev->whitelist, &ev->bdaddr,
+					       BDADDR_BREDR)) {
+		hci_reject_conn(hdev, &ev->bdaddr);
+		return;
 	}
 
 	/* Connection accepted */
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index ecfdfc4df486..d0d0fa832c8a 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6000,8 +6000,9 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
 			goto unlock;
 		}
 
-		err = hci_bdaddr_list_add(&hdev->whitelist, &cp->addr.bdaddr,
-					  cp->addr.type);
+		err = hci_bdaddr_list_add_with_flags(&hdev->whitelist,
+						     &cp->addr.bdaddr,
+						     cp->addr.type, 0);
 		if (err)
 			goto unlock;
 
-- 
2.26.2

