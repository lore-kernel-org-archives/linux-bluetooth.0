Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644DB12CDAC
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jan 2024 17:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706722208; cv=none; b=VoVt0lC+NL8l/Jhq2K3lvbQbm4ZR59SgAmo4OUKdJOAyxDbay5jUB+IS3mOOj9m7ePPg0UDi/RrsBx1at7XzhUNr5yxOZHR1WPvcEjXLIvadyUAmjb7jB5gj4lm3RT/oxF0T8rCGqK3fTa8oxKRr/sOQLmlwmtES0RxG+OX/8gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706722208; c=relaxed/simple;
	bh=sKfmIUSYQZ03tvxOQUvppEJd/j5lz11XdT6buAdELao=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=H/HpU2hQKYGTuJLZfLInvYHn8MqOJjRCeyrcX3xytZeT7IYSiIk0cOwwczEL8QTl7MMTukIv/HTulzCYXxDw708HiuE53aBYyDDjf/QbdJLO+jK19pxAcy4CW1Svg12EY8Er5ywzDscxcHhN2EhyxJBVXSZ0VnDlFBCagkq7RwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BNIQmCQ3; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BNIQmCQ3"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc6432ee799so5282353276.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jan 2024 09:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706722205; x=1707327005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=zrbcFOx2lTrNTdmXEaA/cSTlQijLlZJow4vWoD3T1Y8=;
        b=BNIQmCQ3IGtKYuuHCtvp0mmPz0K0zykKtW3x/j1vcD5onp+09qk+mtvF1EDzSUgOOx
         kzZXCrxpJSAuLkysPBvfeGTVDpI/EZroKbfajHxxOI7YKVGQXGUuWW8KFA7cTLjMlz/m
         m8YU6XH9y1ueukFcTEuBXLVaIrn9aW0PXUkZTlk/vk55KbNtocCKx7jUOlEY4wZjEDqy
         J9jed8d8ZMQU0BJW/dZf7MPxuwEaDoGj4rfHJDciY6ihOLMMLBaOIzOyaB9oFAReaQTC
         cOFfCLfFcBfrHcv+znFREoxhxFhOlJOxIXNjGJgTExMptAPdnh2IiyYAlv7aHcZ2UJh1
         FSDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706722205; x=1707327005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zrbcFOx2lTrNTdmXEaA/cSTlQijLlZJow4vWoD3T1Y8=;
        b=w3uHh+TLCOoD4lLfdDVYNdZfQDP6V5oW+NT3odmhh16FfWWI0w2xoRL8+sGgceIxCZ
         vOOG2GraJ6OAO2lXNGCIjtHLX3eVTDXOeosnnbiFCm4h5wBA0XQGuFq//ascJzDf6gwt
         RpXWK96Yvl7StN+cplJ/aipVPWCu+mi1fyBYXViITKerMUcowXquiIi7d2GZWqTvnmw9
         ZtO1srYNS4zmAJT3Xu2vDYjwX5ea50Iq/EMvjX6wjh3uDSzMXj3JniT04k54MuHcNdax
         AHBjDng2h7FDhMjspRbUO2DJGyC9N1QkeSU7VbbuTJCtZLI6gW4hHBxfFq1EJOWjnLrV
         8fog==
X-Gm-Message-State: AOJu0YyVrYO9bmOTVBwuF17RRbRN0JGGjLYM4VvQMHmblIXKzylYfjQm
	m0XLNPfnFoSKQm2+ceiFSp5OyHRJXG6kGWRA07XR93QWQEzqfy0WEjEGtrp7
X-Google-Smtp-Source: AGHT+IEoBIy25VZhG9c5Rw8Vzw3Kg6oJinYhyGC4L+BMxIeZFTJX8E6X8F86ZU8o+1NBV2P0PC+KjA==
X-Received: by 2002:a5b:b87:0:b0:dc6:cc35:35e9 with SMTP id l7-20020a5b0b87000000b00dc6cc3535e9mr1180766ybq.35.1706722205224;
        Wed, 31 Jan 2024 09:30:05 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id h16-20020a25be10000000b00dc2537d4275sm3599719ybk.64.2024.01.31.09.30.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 09:30:04 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: hci_event: Fix not indicating new connection for BIG Sync
Date: Wed, 31 Jan 2024 12:30:02 -0500
Message-ID: <20240131173002.834951-1-luiz.dentz@gmail.com>
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
index 8c4493255f92..211da120ff12 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -9689,6 +9689,9 @@ void mgmt_device_connected(struct hci_dev *hdev, struct hci_conn *conn,
 	u16 eir_len = 0;
 	u32 flags = 0;
 
+	if (test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags))
+		return;
+
 	/* allocate buff for LE or BR/EDR adv */
 	if (conn->le_adv_data_len > 0)
 		skb = mgmt_alloc_skb(hdev, MGMT_EV_DEVICE_CONNECTED,
-- 
2.43.0

