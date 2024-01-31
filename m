Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0105F12AAFD
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jan 2024 16:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706718510; cv=none; b=dbKcCqlE1Rf3sRWcgL3jZzwmG4hUe6r7EKXWknsVMC7Nib6iqpgFFqSEqXGZ58BOBC/AL6afyjPKtG2UQHWZ5ne55Abzcy1Ke5cTZxuQ0DLVgLDkAt4q4/CvjNkOaQ7k3IK0B0V5BUgdeRYAvLciP6t4n0YtJgU8If50G3leCKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706718510; c=relaxed/simple;
	bh=9Me0FI2+BOnBq2ewVeFQ15/jfPVOcoTVNeF7psgV3CI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=oT9jRcpEpo/GG4ZpgDJfmlDbPNPaA5i9yupvS9fpbAWIp5sHU0CzZj0p2zR5PpyAC7K7Dn6rAmeSA3npfPMRmkNjysnmH/ZVB43Kf1Y6tecxrzf3jQtFZH0bLLPnXSqQIot1sTKvbAq+U6b6Y+eygP+x/NHZWN85q7oviRQb6Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iqnM0IxN; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqnM0IxN"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dc25e12cc63so958891276.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jan 2024 08:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706718507; x=1707323307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1u1N7qqhxUuoIDz1rzVvuv+zipzvjvx1pABWYBqK2Rc=;
        b=iqnM0IxNYfUdsyuXAhnTcJhesQPbFJ0Au9nXDan/enNhoomX6WLVXCvV0J0h1bO1Kq
         nFISWhSWOhNaIEgjyujte3twNJAy7JsqzW2kXqhcAeX8NsH/eKErvDoiIYEsHKvbf2rQ
         XA5AJlWU23Q+29X3R3D7B1ZpbT+CfaXajoXjZRw4m6Z2kOX9BpXyfd3AwVaWsGwdk515
         g6xzQiZmOs0JcneN7MapwEoKRr8Wja0Zsv5FfCNFvnfCqsGGKaxIlMpIi0UHpdx2oUaP
         cEFTpZeAh7UDGgjJhPzBIsLjXL/unk/rfrDBlnm3uKrnwSuiCt8NVuSK4X9wzp075Q5w
         P9mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706718507; x=1707323307;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1u1N7qqhxUuoIDz1rzVvuv+zipzvjvx1pABWYBqK2Rc=;
        b=UKWr0QSI6ozSSudsWoi8dtSc2pRMiT3m4OVbOMT07aWwTyqFjx+TSH+r2kcSMrLcyg
         k810iJ2KBLnDXpMumQ6a/XKJ46YlLQfxAVe369WV8ijKlPCTKKfzDOTrGkLSmjdFZPlk
         Os+My6IbxHLL4ualI12bEppfKSlLlYH7Co2oOFidG0sy+ftuiD49Uh7B8A3Dr6Q2DSpl
         HF7rZOpJ9AyaBNWlxvGd7yrhyA0ExOGkQe6w0pUPtw67xs/kblP6vLHLMQGvCGpU72Xb
         Gx2KFYwxSvAzfg6mpWlATbvIBUd2mig6i0Z+xFYsmJSmZlZ2FDWTIZdwDuOXWDjPHhEj
         pA/A==
X-Gm-Message-State: AOJu0Ywiy0azGIMLlr5QMw/3FwygnnoyZaB4sZVVDUPt1OBIuYk40Tkz
	SYRTf0MGs6eGPAk6tGJL6XV2l/dzIavukom/HE8w4ppzLmidHecH2PVaDAE6
X-Google-Smtp-Source: AGHT+IFVWGUnQY1NUt7/sopjpvaiVWV7YOD2w1Wr1Ed0xFQwjmm4f0yXIilK0Kt/kxOCNgX6lUHi5A==
X-Received: by 2002:a25:d8d1:0:b0:dc6:c2ec:ff4c with SMTP id p200-20020a25d8d1000000b00dc6c2ecff4cmr1139389ybg.6.1706718507168;
        Wed, 31 Jan 2024 08:28:27 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id u18-20020a250952000000b00dc608353fb3sm3587333ybm.39.2024.01.31.08.28.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 08:28:26 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: hci_event: Fix not indicating new connection for BIG Sync
Date: Wed, 31 Jan 2024 11:28:25 -0500
Message-ID: <20240131162825.826774-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

BIG Sync (aka. Broadcast sink) requires to inform that the device is
connected when a data path is active otherwise userspace could attempt
to free resources allocated to the device object while scanning.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_event.c | 18 +++++++++++-------
 net/bluetooth/mgmt.c      |  3 +++
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 31df5f5b7994..acd8a778eecc 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2526,9 +2526,7 @@ static void hci_check_pending_name(struct hci_dev *hdev, struct hci_conn *conn,
 	 * Only those in BT_CONFIG or BT_CONNECTED states can be
 	 * considered connected.
 	 */
-	if (conn &&
-	    (conn->state == BT_CONFIG || conn->state == BT_CONNECTED) &&
-	    !test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags))
+	if (conn && (conn->state == BT_CONFIG || conn->state == BT_CONNECTED))
 		mgmt_device_connected(hdev, conn, name, name_len);
 
 	if (discov->state == DISCOVERY_STOPPED)
@@ -3760,8 +3758,9 @@ static void hci_remote_features_evt(struct hci_dev *hdev, void *data,
 		bacpy(&cp.bdaddr, &conn->dst);
 		cp.pscan_rep_mode = 0x02;
 		hci_send_cmd(hdev, HCI_OP_REMOTE_NAME_REQ, sizeof(cp), &cp);
-	} else if (!test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags))
+	} else {
 		mgmt_device_connected(hdev, conn, NULL, 0);
+	}
 
 	if (!hci_outgoing_auth_needed(hdev, conn)) {
 		conn->state = BT_CONNECTED;
@@ -3934,6 +3933,11 @@ static u8 hci_cc_le_setup_iso_path(struct hci_dev *hdev, void *data,
 		 * last.
 		 */
 		hci_connect_cfm(conn, rp->status);
+
+		/* Notify device connected in case it is a BIG Sync */
+		if (test_bit(HCI_CONN_BIG_SYNC, &conn->flags))
+			mgmt_device_connected(hdev, conn, NULL, 0);
+
 		break;
 	}
 
@@ -5008,8 +5012,9 @@ static void hci_remote_ext_features_evt(struct hci_dev *hdev, void *data,
 		bacpy(&cp.bdaddr, &conn->dst);
 		cp.pscan_rep_mode = 0x02;
 		hci_send_cmd(hdev, HCI_OP_REMOTE_NAME_REQ, sizeof(cp), &cp);
-	} else if (!test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags))
+	} else {
 		mgmt_device_connected(hdev, conn, NULL, 0);
+	}
 
 	if (!hci_outgoing_auth_needed(hdev, conn)) {
 		conn->state = BT_CONNECTED;
@@ -5982,8 +5987,7 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 		goto unlock;
 	}
 
-	if (!test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags))
-		mgmt_device_connected(hdev, conn, NULL, 0);
+	mgmt_device_connected(hdev, conn, NULL, 0);
 
 	conn->sec_level = BT_SECURITY_LOW;
 	conn->state = BT_CONFIG;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 8c4493255f92..bf5717094f46 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -9689,6 +9689,9 @@ void mgmt_device_connected(struct hci_dev *hdev, struct hci_conn *conn,
 	u16 eir_len = 0;
 	u32 flags = 0;
 
+	if (!test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags))
+		return;
+
 	/* allocate buff for LE or BR/EDR adv */
 	if (conn->le_adv_data_len > 0)
 		skb = mgmt_alloc_skb(hdev, MGMT_EV_DEVICE_CONNECTED,
-- 
2.43.0

