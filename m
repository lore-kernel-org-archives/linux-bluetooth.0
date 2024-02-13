Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB4F61672
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Feb 2024 21:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707859889; cv=none; b=EvcqPZAEXWF0kdUNb8PLQlpErVrvKTZPer+fDmjiCJNs+SYQJLsomLoqGp2oH250xNofVOT9T5ld8YFU7NMa0E0a9eySkxcbg9mPR06iJath6uGNX8Epf8H6rEhtPC0bItXnQzsrkOTk8B8PPl9NDiE1op2NTPUflmhqK1RvHXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707859889; c=relaxed/simple;
	bh=Uzmy8pdwHrS1wMUJmvCHzDf9sFS7r+uY2DSU/7JrNPg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=PDX+wBtkBOsX5T3ykupZCv1evPQHyN85yJWH0LyjNMW0bvbme+MNJpijerhcHAeUF3akXqulGivxDFHKFPN8uvyqJvu4FjFPSB+zsuoYmO6atjAutM9C2aQDtWnk6J9IgIm/MR5OTBr1sA21Oyq5qHjbNSYTTdyAnQYgJyA3Y/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YxIGJJ56; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxIGJJ56"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-4c03beb85f4so1292811e0c.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Feb 2024 13:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707859886; x=1708464686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=AydVQatpc9+8to7jbO+jHh71eCWXPgIKPFgG/Q9U0U4=;
        b=YxIGJJ56li1VEoNCZ2NaLQgowqZd/FvANeC7XABQpvME2QD/AHFwldBdHU/oWX09q0
         XBnjL/ru1A2BY8vB4SdFVzkDJUnOsBzWy7OsqlPgzP5gyD9+UTWlAzTLS1TRrFOuag6a
         K04qKmLS6Kuxi6HDNUjO4nhNCIJW8YKte1pQw6B7VZx3v1BeRJ3y00DHBd1mlOUiIorI
         FknjJknw1DQ62EJQzDpbA6czdG/0xjWMZSpVNkvd/xRN8/R4Zm2E+kPY24mqT0TyJBzd
         fOzrbjTj2jsK7Y9z2GJMMIfRAuR78blGXNRSricGeamVyWOEzYTts4wvivZ3iHgHvTCo
         nB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707859886; x=1708464686;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AydVQatpc9+8to7jbO+jHh71eCWXPgIKPFgG/Q9U0U4=;
        b=JvSS5eA9upB6lC5KdS+x2z7jevKgKdzChN7/RAHhfpQX3QwUHvkC3sVub+VPuupTju
         qyyTMaP3IzrdWF/OtS57o7lt0q503VvtaZD3Ka2RjpTk23UY2U9ZsQnqL8ixeYyFCrkT
         bCPjDMCLu60WqOISmZqbpBML8AVuIw/Y9nk8YKaCj03pRI/vQ4V9ZhqJiklbPOtWUpDF
         kLDmfFmpybDj4wxlv7ZjmuN/iOYukVmtiZUZAdIv2BBRppZC7Piln+ofPKz1way2GiJz
         7lu6wcW3bVtbg0No2hyI2SfIF7z+zYR6cFq671gUx0vO2ppj1FBDzuSeD4Ef327wXcte
         R27A==
X-Gm-Message-State: AOJu0YwgYD3cKd6rmEWEzkyea2TliwILNg71ys6luM6G/17G5rUAOahe
	aERgYOuIJZL7AOGMGd5tQFClf6znIobz+E7AfcV22/f+4x58JTrC4YyKdcLc
X-Google-Smtp-Source: AGHT+IFhxDha56NEDvyGBCqVeR5MGqeq+erfK72C+/80+I2yzxaUj2YzKaRf+FztMWPHgr37yAX4GA==
X-Received: by 2002:a1f:c847:0:b0:4c0:1937:d29d with SMTP id y68-20020a1fc847000000b004c01937d29dmr945178vkf.6.1707859885979;
        Tue, 13 Feb 2024 13:31:25 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id z8-20020a056122148800b004c0149262dcsm1049837vkp.4.2024.02.13.13.31.24
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 13:31:24 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/3] Bluetooth: hci_conn: Fix UAF Write in __hci_acl_create_connection_sync
Date: Tue, 13 Feb 2024 16:31:21 -0500
Message-ID: <20240213213123.403654-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the UAF on __hci_acl_create_connection_sync caused by
connection abortion, it uses the same logic as to LE_LINK which uses
hci_cmd_sync_cancel to prevent the callback to run if the connection is
abort prematurely.

Reported-by: syzbot+3f0a39be7a2035700868@syzkaller.appspotmail.com
Fixes: 456561ba8e49 ("Bluetooth: hci_conn: Only do ACL connections sequentially")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_sync.h |  3 +--
 net/bluetooth/hci_conn.c         |  3 ++-
 net/bluetooth/hci_sync.c         | 16 ++++++++++------
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index 824660f8f30d..ed334c253ebc 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -139,5 +139,4 @@ int hci_le_big_terminate_sync(struct hci_dev *hdev, u8 handle);
 
 int hci_le_pa_terminate_sync(struct hci_dev *hdev, u16 handle);
 
-int hci_acl_create_connection_sync(struct hci_dev *hdev,
-				   struct hci_conn *conn);
+int hci_connect_acl_sync(struct hci_dev *hdev, struct hci_conn *conn);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 8164502234c5..587eb27f374c 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1645,7 +1645,7 @@ struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
 		acl->auth_type = auth_type;
 		acl->conn_timeout = timeout;
 
-		err = hci_acl_create_connection_sync(hdev, acl);
+		err = hci_connect_acl_sync(hdev, acl);
 		if (err) {
 			hci_conn_del(acl);
 			return ERR_PTR(err);
@@ -2942,6 +2942,7 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
 	 */
 	if (conn->state == BT_CONNECT && hdev->req_status == HCI_REQ_PEND) {
 		switch (hci_skb_event(hdev->sent_cmd)) {
+		case HCI_EV_CONN_COMPLETE:
 		case HCI_EV_LE_CONN_COMPLETE:
 		case HCI_EV_LE_ENHANCED_CONN_COMPLETE:
 		case HCI_EVT_LE_CIS_ESTABLISHED:
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 788a889210d8..e1fdcb3c2706 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6493,13 +6493,18 @@ int hci_update_adv_data(struct hci_dev *hdev, u8 instance)
 				  UINT_PTR(instance), NULL);
 }
 
-static int __hci_acl_create_connection_sync(struct hci_dev *hdev, void *data)
+static int hci_acl_create_conn_sync(struct hci_dev *hdev, void *data)
 {
-	struct hci_conn *conn = data;
+	struct hci_conn *conn;
+	u16 handle = PTR_UINT(data);
 	struct inquiry_entry *ie;
 	struct hci_cp_create_conn cp;
 	int err;
 
+	conn = hci_conn_hash_lookup_handle(hdev, handle);
+	if (!conn)
+		return 0;
+
 	/* Many controllers disallow HCI Create Connection while it is doing
 	 * HCI Inquiry. So we cancel the Inquiry first before issuing HCI Create
 	 * Connection. This may cause the MGMT discovering state to become false
@@ -6556,9 +6561,8 @@ static int __hci_acl_create_connection_sync(struct hci_dev *hdev, void *data)
 	return err;
 }
 
-int hci_acl_create_connection_sync(struct hci_dev *hdev,
-				   struct hci_conn *conn)
+int hci_connect_acl_sync(struct hci_dev *hdev, struct hci_conn *conn)
 {
-	return hci_cmd_sync_queue(hdev, __hci_acl_create_connection_sync,
-				  conn, NULL);
+	return hci_cmd_sync_queue(hdev, hci_acl_create_conn_sync,
+				  UINT_PTR(conn->handle), NULL);
 }
-- 
2.43.0

