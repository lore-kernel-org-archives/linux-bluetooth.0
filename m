Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A0115C153
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Aug 2024 21:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725053921; cv=none; b=QC5XUbUn7qCp7jgKveR9bi3sMsE8PNQQpgks+ihvrIu0BAO/1NEjBZcA3xKnUfPBheD/84X8NFCmJTN63l0WLv6jsoWIe0PILb+/VQyhi9LAjOqxMDEV0w7lTeRaN4d+DkZJsBvBW873t4kKlcJp5TolPh39Dl1Bo1au/eo58lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725053921; c=relaxed/simple;
	bh=rSKhS+OfKqYLHIqgg3FhFuXa3o9CKBx3IR0eF03pDr8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Grnd+BhMTtfPmw/qxoVBN1YJJ0sLT1+6SSLXDapdq1J4n4ZP/13OD7bWccAEL3CUZ9Xn0PFRnEd8fAxelk+DT1PBMvIo/7CMHB61VlxweyBZ/P0iqQJAaiilhy37PI06k0K9OkIEmCoMZU1vEUkoIksqw52OsvFN8XBv26cgTtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZbYxmHVJ; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZbYxmHVJ"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-498d14b9b8cso702798137.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Aug 2024 14:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725053918; x=1725658718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=JfqN8g2RhNNlL3l9BczxjqMnMpEauMRXob4BRTQzmgA=;
        b=ZbYxmHVJf9K982R49L57vaQYyNTbkzjRYNcK7LWrs4ioWhB2fxx67OLelTLavfANe7
         GqQxY5vq4m8IuLgODCGqOEXo5iOQF5MBMV1JLJ4dJPvNjQpAxkqeKTH0eQrxq2jTYqGn
         6fLPw8Kv4mbHUFidef1z0oPstP4iODYI6ZL0eQ+oxqu843X2sVusuD2wU14WVv+28EXj
         NAydZOH8Fg7UTt6jtuXVLu8+zpk/tFhPnZQ5h0hIZpHnwv/o5kMHgYFnlCc+I1vc38mN
         NPCi3vEbrciqKrRC+X68KvPERD01+5zqeQzXijnnFzFw7kl4oAcsc7HV4/VNjGrKSrSg
         e8Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725053918; x=1725658718;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JfqN8g2RhNNlL3l9BczxjqMnMpEauMRXob4BRTQzmgA=;
        b=weVqjTV8NutCfOb8+/Ne9NZBQXrJk4VKz9aqvfGM2eeXatpfSwPO7GHsM4HJKYvTgp
         Cr4SDKCPpRyiaN0cH1fN6hUHJXOXoNmK5Q7xL67eMw3I9pJHPe3US2/99RhRrohFcRFu
         dHQMkhZf/eW+eE9LhKsN5SvtXqaWNOf6StsyLNmfUHo7L82Tr3i5a4iQXlZeYJ/umu/j
         eArZN7t0R1utwKVWI5N1lEvzWKOupHgJauYTT/N27EO9cLWCx8RDyRAeh/XIKppV+lot
         thV2kzMYPhegUCKDpdO2q7VBveSfXfZUF/zcqPRaRkV5fY5NtxmExsc7yqL9PCE3HfiO
         YcVA==
X-Gm-Message-State: AOJu0Yxj8G0ehxC4tf7ygCyJ5bqz7WBDVArEfyJjCMfcXo/sstL4TOr5
	UZw3YKNMHu0wW/af4RIe3+VxwU7HxYzBNkcI46Zh7Z8BJS29UhSKoyo7ilX7
X-Google-Smtp-Source: AGHT+IGYAPoRgWSXOCKsQhitx02NQG2MfWZFHLDwgktJOrhvYAIdk/3BERqx6GdNxTLKOnbbmE1N0A==
X-Received: by 2002:a05:6102:c0a:b0:498:f38a:2c8f with SMTP id ada2fe7eead31-49a5ae06830mr8057118137.3.1725053917646;
        Fri, 30 Aug 2024 14:38:37 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-49a5f2b8584sm681151137.0.2024.08.30.14.38.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 14:38:36 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: hci_core: Fix sending MGMT_EV_CONNECT_FAILED
Date: Fri, 30 Aug 2024 17:38:35 -0400
Message-ID: <20240830213835.1267643-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If HCI_CONN_MGMT_CONNECTED has been set then the event shall be
HCI_CONN_MGMT_DISCONNECTED.

Fixes: b644ba336997 ("Bluetooth: Update device_connected and device_found events to latest API")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h |  4 ++--
 net/bluetooth/hci_conn.c         |  6 ++----
 net/bluetooth/mgmt.c             | 13 +++++++++----
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 1a32e602630e..88265d37aa72 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -2257,8 +2257,8 @@ void mgmt_device_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			      bool mgmt_connected);
 void mgmt_disconnect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			    u8 link_type, u8 addr_type, u8 status);
-void mgmt_connect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
-			 u8 addr_type, u8 status);
+void mgmt_connect_failed(struct hci_dev *hdev, struct hci_conn *conn,
+			 u8 status);
 void mgmt_pin_code_request(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 secure);
 void mgmt_pin_code_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 				  u8 status);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 323d397b0e92..d083117ee36c 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -106,8 +106,7 @@ void hci_connect_le_scan_cleanup(struct hci_conn *conn, u8 status)
 	 * where a timeout + cancel does indicate an actual failure.
 	 */
 	if (status && status != HCI_ERROR_UNKNOWN_CONN_ID)
-		mgmt_connect_failed(hdev, &conn->dst, conn->type,
-				    conn->dst_type, status);
+		mgmt_connect_failed(hdev, conn, status);
 
 	/* The connection attempt was doing scan for new RPA, and is
 	 * in scan phase. If params are not associated with any other
@@ -1249,8 +1248,7 @@ void hci_conn_failed(struct hci_conn *conn, u8 status)
 		hci_le_conn_failed(conn, status);
 		break;
 	case ACL_LINK:
-		mgmt_connect_failed(hdev, &conn->dst, conn->type,
-				    conn->dst_type, status);
+		mgmt_connect_failed(hdev, conn, status);
 		break;
 	}
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 279902e8bd8a..e4f564d6f6fb 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -9779,13 +9779,18 @@ void mgmt_disconnect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	mgmt_pending_remove(cmd);
 }
 
-void mgmt_connect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
-			 u8 addr_type, u8 status)
+void mgmt_connect_failed(struct hci_dev *hdev, struct hci_conn *conn, u8 status)
 {
 	struct mgmt_ev_connect_failed ev;
 
-	bacpy(&ev.addr.bdaddr, bdaddr);
-	ev.addr.type = link_to_bdaddr(link_type, addr_type);
+	if (test_and_clear_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags)) {
+		mgmt_device_disconnected(hdev, &conn->dst, conn->type,
+					 conn->dst_type, status, true);
+		return;
+	}
+
+	bacpy(&ev.addr.bdaddr, &conn->dst);
+	ev.addr.type = link_to_bdaddr(conn->type, conn->dst_type);
 	ev.status = mgmt_status(status);
 
 	mgmt_event(MGMT_EV_CONNECT_FAILED, hdev, &ev, sizeof(ev), NULL);
-- 
2.46.0

