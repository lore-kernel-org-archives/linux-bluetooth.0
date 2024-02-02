Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA17F14AD35
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Feb 2024 18:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706897398; cv=none; b=HU7YzdWOvp71LxmCVf9R6BeDgXcnZezI5D5omsQ5P84yRuG8XEI2ADCUaZTx/waW2c+amlcTeXycLf4m4MltxuVq6tuJA/Z5UDVj1uIbzwuf5VTNBqepnjfCpdlBGG5saPUCpASJqPBXChdq5GYqeiE1a/bM+X9yG7yULRcD2LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706897398; c=relaxed/simple;
	bh=aIQyeon47ezRXgSZeEVvNwsW9i5MGWXTGBS96xlCgaY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=KX2MyWedOGPnL26/Gv9HYv8Eo0EPDEu1h4/Wyc4vrpen/esYBlG6fZd9mpT/tSCE6TamTfmdblbyxAiijvoYC2cETlqpB5hyvcWJYqU+KZkkeLybmls1AUAkbbvGdJEFr8SlMI4a3obT+sDYKUo4SYixoqIi8AcUea8oZi1zcWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JEhQasrh; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEhQasrh"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dc6c3902a98so1803826276.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 02 Feb 2024 10:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706897395; x=1707502195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=aPx7InViRIAX8ucFevWEYfVu7Ak2NR0BHkOwS9kVov4=;
        b=JEhQasrhrSeyqGHZkQhBzBy+VQjoFsirFA28r+zSS2EB2SAJxwwex+BaYFACOMrXRZ
         zXyeGz1bkd36WxDGItz0Jt8XPYtkOsOOURpnvo39qSpMbXvDbfmsGJlaGPvhif9egxZx
         0ESuTYbaiNqmYqUojgRNbQiZ15Mezs3wO7UOzxAYmyvGuCVjUep/NB1EC1DThQVSq86C
         fiSkhwUBMx7fXMUTRJg3LyR2a7XUBp9ptoV2njeYEzig8KDk+NXDO26frJ+ljDpvv8+9
         WHXMvwyyZI0E6EPiU6cAlDkfnNO2BOzmOxz3K0PtwQEraeihzAcNhUe0k+0Uok+0N8F7
         G0PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706897395; x=1707502195;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aPx7InViRIAX8ucFevWEYfVu7Ak2NR0BHkOwS9kVov4=;
        b=BPUErqEWpPSsgpbjyDQVoDcJiru1GXcXYcy1U+AxVKc6lBFoG4MkIzliYUUXaGoCY9
         KO6fCsQdWMOdOcPr2ycYdL60F+UxdxV0/AGzpxJhVHPx5JdaYDXEHyQs05qpP0k1VM30
         +86n1YVxk0SLLuK7V+i5R2+kUoDqRtd2jp0a93mN+UjO88DjgxvrEwGX0oDBdwL/mXtd
         oitBHP5jlastiBn7YvQVoc+ReWd7eOd1dDMdEDibh5UB0McOAgi2Hq5cmf0Vv2ga5zFy
         8HHN2BJJ7ncdeQDW9BGLg4XasMBHpv8WN66IYflK/ev9voG53FQRZsY4uOv4DI0XE3hO
         jRhg==
X-Gm-Message-State: AOJu0Yxd2ynHm45qpHl2ewf944HT5LWhfhvNMccfKE+Rwb0YUqN9cpax
	HDMjUdMWFU0twSfIbbqFtFoAVP2+5B1gpEL4DteY7xesFT+JK5gJ14aBf9fT
X-Google-Smtp-Source: AGHT+IF7nmbIvrb4rS1F8yulWApVgxJbiHPBl3eCUKzQ8AJg8T3vjO96lVB68W00tUKgQNSNcVRGcQ==
X-Received: by 2002:a25:db93:0:b0:dbd:5db5:475a with SMTP id g141-20020a25db93000000b00dbd5db5475amr6761444ybf.34.1706897393358;
        Fri, 02 Feb 2024 10:09:53 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id v19-20020a252f13000000b00dc6d7cd61a1sm541689ybv.49.2024.02.02.10.09.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 10:09:52 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3] Bluetooth: hci_event: Fix not indicating new connection for BIG Sync
Date: Fri,  2 Feb 2024 13:09:51 -0500
Message-ID: <20240202180951.1605724-1-luiz.dentz@gmail.com>
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

Fixes: 1d11d70d1f6b ("Bluetooth: ISO: Pass BIG encryption info through QoS")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_event.c | 21 ++++++++++++++-------
 net/bluetooth/mgmt.c      |  4 ++++
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 11b55d1f9772..271c00792801 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2524,9 +2524,7 @@ static void hci_check_pending_name(struct hci_dev *hdev, struct hci_conn *conn,
 	 * Only those in BT_CONFIG or BT_CONNECTED states can be
 	 * considered connected.
 	 */
-	if (conn &&
-	    (conn->state == BT_CONFIG || conn->state == BT_CONNECTED) &&
-	    !test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags))
+	if (conn && (conn->state == BT_CONFIG || conn->state == BT_CONNECTED))
 		mgmt_device_connected(hdev, conn, name, name_len);
 
 	if (discov->state == DISCOVERY_STOPPED)
@@ -3758,8 +3756,9 @@ static void hci_remote_features_evt(struct hci_dev *hdev, void *data,
 		bacpy(&cp.bdaddr, &conn->dst);
 		cp.pscan_rep_mode = 0x02;
 		hci_send_cmd(hdev, HCI_OP_REMOTE_NAME_REQ, sizeof(cp), &cp);
-	} else if (!test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags))
+	} else {
 		mgmt_device_connected(hdev, conn, NULL, 0);
+	}
 
 	if (!hci_outgoing_auth_needed(hdev, conn)) {
 		conn->state = BT_CONNECTED;
@@ -3932,6 +3931,11 @@ static u8 hci_cc_le_setup_iso_path(struct hci_dev *hdev, void *data,
 		 * last.
 		 */
 		hci_connect_cfm(conn, rp->status);
+
+		/* Notify device connected in case it is a BIG Sync */
+		if (!rp->status && test_bit(HCI_CONN_BIG_SYNC, &conn->flags))
+			mgmt_device_connected(hdev, conn, NULL, 0);
+
 		break;
 	}
 
@@ -5006,8 +5010,9 @@ static void hci_remote_ext_features_evt(struct hci_dev *hdev, void *data,
 		bacpy(&cp.bdaddr, &conn->dst);
 		cp.pscan_rep_mode = 0x02;
 		hci_send_cmd(hdev, HCI_OP_REMOTE_NAME_REQ, sizeof(cp), &cp);
-	} else if (!test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags))
+	} else {
 		mgmt_device_connected(hdev, conn, NULL, 0);
+	}
 
 	if (!hci_outgoing_auth_needed(hdev, conn)) {
 		conn->state = BT_CONNECTED;
@@ -5980,8 +5985,7 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 		goto unlock;
 	}
 
-	if (!test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags))
-		mgmt_device_connected(hdev, conn, NULL, 0);
+	mgmt_device_connected(hdev, conn, NULL, 0);
 
 	conn->sec_level = BT_SECURITY_LOW;
 	conn->state = BT_CONFIG;
@@ -7210,6 +7214,9 @@ static void hci_le_big_info_adv_report_evt(struct hci_dev *hdev, void *data,
 	/* Notify iso layer */
 	hci_connect_cfm(pa_sync, 0x00);
 
+	/* Notify MGMT layer */
+	mgmt_device_connected(hdev, pa_sync, NULL, 0);
+
 unlock:
 	hci_dev_unlock(hdev);
 }
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 7713e2cdf9e1..064a67157d43 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3126,6 +3126,7 @@ static int disconnect(struct sock *sk, struct hci_dev *hdev, void *data,
 static u8 link_to_bdaddr(u8 link_type, u8 addr_type)
 {
 	switch (link_type) {
+	case ISO_LINK:
 	case LE_LINK:
 		switch (addr_type) {
 		case ADDR_LE_DEV_PUBLIC:
@@ -9618,6 +9619,9 @@ void mgmt_device_connected(struct hci_dev *hdev, struct hci_conn *conn,
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

