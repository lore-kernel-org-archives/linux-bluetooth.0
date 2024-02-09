Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEDA6995B
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Feb 2024 14:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707488178; cv=none; b=qVxb8YaZ2xN9Vj4wmR9oIokLfXjB+cNh2kvaVb0wmSe76BytyhZ5+rVVxVTMzP3t7Jn585RKJxRQSKB65K1D6dvAFRAdVc/4yuhS21X30nxv2rMq8X8v5gJhFrH207t8v2GpB1CGp/nYmWMvauWtW3mPByv7pgdosxwIhi5v+Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707488178; c=relaxed/simple;
	bh=Uzmy8pdwHrS1wMUJmvCHzDf9sFS7r+uY2DSU/7JrNPg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=BLfUveBvHk2mEFYNdA3InxxS5sZQ+AMs29FoIhrl9ysB3PCuAX5POtaexYuoRnsMUjYj3nTZ3KQmdi0fRBGp6hN4h3Hnxot7p1Y4PwSqKqIxU7L8em53OkFGktpYtn1J98qftdyb337flprhoYuMvupe7Z0p8HENBnqN5vYoQr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m5gO0kDg; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5gO0kDg"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2046b2cd2d3so668975fac.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Feb 2024 06:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707488174; x=1708092974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=AydVQatpc9+8to7jbO+jHh71eCWXPgIKPFgG/Q9U0U4=;
        b=m5gO0kDgcm2aG4FzBfuQLRrrjDZ/5O2Ymii7ryr2iylnIz+nLNs3bV5QxhL052nOWO
         WSHFHGDX7UqaepPyrMQDn9XVib9nMQmybOv3GYM7MoTVvBd4FSY9Voj3q9hpNu9EY44J
         BIxv1Nc0GtDcAVV+99ddJXKb8UC9ozpBeVMooienHzRdg9qsMeOda9l+cLaMS3Le7mPM
         k2kQIf1B/LDT+QK+dfIYiFraQFQc2qPKKvMxk9C/73+nfput9wBFdMd+vypzLApavtk3
         wqf+2+GU+eXofeHnCdItIBqi2l1tAWSUJvJTEG12MqYsLkNKQpYKvs3a7WKkfABlidhr
         gsAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707488174; x=1708092974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AydVQatpc9+8to7jbO+jHh71eCWXPgIKPFgG/Q9U0U4=;
        b=bCl/h8X11NsMAinnQOVMk4WWflAU3CDq31K7P1HaYv3VZNX9bpxYoVL0/4rIBPJK9O
         DXc/XVt4XWWMF5XHRqGwIGt7GTOe4AuMKn9tvy3LgJcie8/M8Ija+9ioll9opWYWDCoz
         e7A+D5CH9eQ3DQQWljgvW9HP70J8AOfG7y1KSfI4/UzBKTAlidyq5Np6fg/aqAc4FtCV
         IFUl3sYXAHqOpPYJUNFr1iI+wqZGDJHl5uewQITUxnQfeL+81MS/k+2i9t0mjGP4AM5r
         itjt02wYoqSyamx0dkL42875+mz3M2XktwyHTGnRO0qKtkRF/3Z0K38dsCd1XpIJ6P/d
         HgDA==
X-Gm-Message-State: AOJu0YzpSlxC2uYGufGeIyc4WMaaCs09/Ziiijp5eHMrBKZi26GqXcDr
	Oe+rSq1lD5xFFcyJkjzUcEPWwReD3/Ugb139lxjRelV0MC94Nrr2bTePhBld
X-Google-Smtp-Source: AGHT+IGKgaiQDmg5ZwL3PZv0bbNASMAFSllGQJvDSgERLbz5I2NAf2J1jzc8Dyp6xO3gkjmaFtMB/g==
X-Received: by 2002:a05:6870:d0c3:b0:219:3054:3ea2 with SMTP id k3-20020a056870d0c300b0021930543ea2mr2057565oaa.0.1707488174304;
        Fri, 09 Feb 2024 06:16:14 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id 14-20020a05612202ae00b004c02d68e4ffsm226046vkq.44.2024.02.09.06.16.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 06:16:13 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: hci_conn: Fix UAF Write in __hci_acl_create_connection_sync
Date: Fri,  9 Feb 2024 09:16:12 -0500
Message-ID: <20240209141612.3554051-1-luiz.dentz@gmail.com>
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

