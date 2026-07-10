Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124BD3F8714
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 09:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783676866; cv=none; b=TcZ9TnMXgWIzdbfLXrXR1oFKKM0MX58lyTAU7Q2wedC9IjeVfWIn0mzGneqFTVld1og/QXYgn+f82cle+QfT60C128avHNPmsUtQMUwfVMlgl2uG/MLLIufh4+JXEwJHlYmkfx7PJHwEh+xXar3Nv75otSeTCo2xKKzWSN2fmJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783676866; c=relaxed/simple;
	bh=5KQJMiWUVWflGl5J80u+4+tqFDAGP9E1KnRSQJYirxM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OdnyooWyO+vM8lAWJxXGDmdhp7jpuD0u7iUENinJ2sB6Atm+lVt45bJvUekbsHuuj56e7NWMzI8ymBOIZH0AWE3Y4B0jQcFzQ2l9/lvBty6p6ZAeA7cpeKgSIhUHhrL2orXNg39vFa5v9+i59XDXzWiFqJzRvPN6TS3pMcHR86s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cj1QwXNj; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cj1QwXNj"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5aec139da7eso868238e87.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 02:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783676857; x=1784281657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iJKCagyd/SIrmWaSiMe9KDmEGLx+4cDuv8NGl1ssZz0=;
        b=cj1QwXNjv29DV0tVDFOL2R2A2VrGAShrciwpUD/g6VnaJUS7qt9/oGY5JBiFCh9WfM
         dxnK6mKlwUtZ4nmXu8HNWXOC5zz/z/FwNq5hiI/5OAKyWlq1xcYVtkMiS3H5lhpo2Fv6
         k1F4nu+T5EhZvF+mJP7IqhOWKcvEJF6nwl0Z6ZYek4FjZB/Ca0iJkXjB+B8VPT2ct+Dh
         h0gpGtJeymhSnLF6tXf4Jy77R7kTDRBxd9kkqLkJQmmgMYCISvRSAJIW9sr8K14E2wvk
         UZieIit/6+9LtssFk2A/M2NhyzaPEDW3LesQroZTzGu6bE+eYmFyIhTb++unuCC8mIje
         3PZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783676857; x=1784281657;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iJKCagyd/SIrmWaSiMe9KDmEGLx+4cDuv8NGl1ssZz0=;
        b=h/33Oxd4fuGO7xrp4wBkS2I6Ing5TRWs2KHzzX7hwqaw/E7MU/aD2fkUSfm1d6swFX
         wyD1tNDs1klV7G9vZAzUuZ6MFcMnzodfHRXb9ZCmMHuvueaN7UoG3TZvR1XSXEhFrKsT
         d5XnYnst2gqcCGPMYiXeOQMiNC0VR9eM21NYYeBg6nSyDoKG7P8VYBJmXudNIWN4l11r
         I4rvCt+VOtXOp9p+fBxY1BimhlFSJPe9xaAW4qt2fvCxc8rQa3e/H9cPSCuku9T2WeJy
         cSBMQybCm0pf641T98t583+ewoUVVY2uHYX3MoLoIxhJIgZK7TLP7lon0ApIedBa6sht
         aTVg==
X-Gm-Message-State: AOJu0YwfOwLodt5fUwo+PoXtYlw22B0Fe8JsNYouXoQPB0VqOSJ3mzBJ
	frM8Ic2dgYsw5ns6vZFDe1zMtnPCbe3KdFCdDQ9zERAlSGL/zDJOKNC1yUCeACwUBDeF4A==
X-Gm-Gg: AfdE7cmZGKjuCCWzh26h/1KahQa2U6594nv2jDKua63nADMwdLo03ETaSbpN+1zUy81
	Oq4YnbX2uqzVo7Kt7+S/FnRR7IKImJlnrHAckdq2ZYRTV5LthRv8QdB17auXFoLPmISlRvQPs/l
	LeUrqhsZBXstKTFiUReOTVqWW47gif/2G9GzxufgJxR78M1uLk9aZl62BlvSKVt0rePFK2acP/1
	tJpcvshnqWSYmrE3KZNESLcXimRcjx2YsPzNRWpTR/zhxE1I8Z5XDSbNWmOS7lottMQtdjivOk3
	Fi8trKRiVAQicHwb+Y3ln99GuXrplV1QZHSb/FjR9PtJIxPMNB1zCGnU11dzGbNJpGsNFo9TsTs
	jqG3DuC3558pltR0ijsV/L8uK+HP9qrbugjKgU2gsdzrn4Jho56t446YgWpeAV/bbMq6zB37Vuz
	f9y/7vIOc0iE+vRv624vxIOg==
X-Received: by 2002:a05:6512:6708:b0:5aa:62df:cd0f with SMTP id 2adb3069b0e04-5b01c6061a0mr497391e87.2.1783676857247;
        Fri, 10 Jul 2026 02:47:37 -0700 (PDT)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b01ca4a1d5sm473878e87.11.2026.07.10.02.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 02:47:35 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-kernel@vger.kernel.org,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH] Bluetooth: mgmt: Translate HCI reason in Device Disconnected event
Date: Fri, 10 Jul 2026 14:47:31 +0500
Message-ID: <20260710094731.59767-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MGMT_EV_DEVICE_DISCONNECTED carries a reason field which is defined to
be one of MGMT_DEV_DISCONN_* (0x00..0x05). hci_disconn_complete_evt()
converts the HCI error with hci_to_mgmt_reason(), but two other paths
pass the raw HCI error straight through:

  hci_cs_disconnect()   -> cp->reason
  mgmt_connect_failed() -> status

The latter is reached whenever the adapter is powered off or suspended:
hci_disconnect_all_sync() aborts every link with
HCI_ERROR_REMOTE_POWER_OFF, hci_disconnect_sync() deliberately does not
wait for HCI_EV_DISCONN_COMPLETE for that reason, so that
hci_abort_conn_sync() finishes the connection off through
hci_conn_failed() instead.

As a result userspace sees an out of range reason:

  @ MGMT Event: Device Disconnected (0x000c) plen 8
        BR/EDR Address: 8C:A9:6F:2C:51:46
        Reason: Reserved (0x15)

  bluetoothd: btd_bearer_disconnected() Unknown disconnection value: 21
  bluetoothd: device_disconnected() Unknown disconnection value: 21

Export hci_to_mgmt_reason() and use it in both places, so that a power
off is reported as MGMT_DEV_DISCONN_REMOTE rather than as the raw
HCI_ERROR_REMOTE_POWER_OFF (0x15).

Fixes: d47da6bd4cfa ("Bluetooth: hci_core: Fix sending MGMT_EV_CONNECT_FAILED")
Fixes: 182ee45da083 ("Bluetooth: hci_sync: Rework hci_suspend_notifier")
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---

Tested on 7.2.0-rc2 with an MT7922 controller and Denon PerL Pro
earbuds. Before the patch "systemctl stop bluetooth" produced

  @ MGMT Event: Device Disconnected  Reason: Reserved (0x15)
  bluetoothd: btd_bearer_disconnected() Unknown disconnection value: 21

and with it the event carries MGMT_DEV_DISCONN_REMOTE, with no
complaint from bluetoothd. Explicit disconnects, which take the
hci_disconn_complete_evt() path, are unchanged.

Note that the hci_cs_disconnect() call site is not reachable in
practice: it requires either hdev->suspended, in which case
mgmt_device_disconnected() overrides the reason with
MGMT_DEV_DISCONN_LOCAL_HOST_SUSPEND anyway, or a
HCI_ERROR_UNKNOWN_CONN_ID race. It is fixed for consistency only and
was not exercised by the above.

 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_event.c        | 18 +-----------------
 net/bluetooth/mgmt.c             | 19 ++++++++++++++++++-
 3 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 4ca09298e11a..e7133ff87fbf 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -2430,6 +2430,7 @@ void mgmt_new_link_key(struct hci_dev *hdev, struct link_key *key,
 		       bool persistent);
 void mgmt_device_connected(struct hci_dev *hdev, struct hci_conn *conn,
 			   u8 *name, u8 name_len);
+u8 hci_to_mgmt_reason(u8 err);
 void mgmt_device_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			      u8 link_type, u8 addr_type, u8 reason,
 			      bool mgmt_connected);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index b6d963ce26d0..741d658e9630 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2763,7 +2763,7 @@ static void hci_cs_disconnect(struct hci_dev *hdev, u8 status)
 	}
 
 	mgmt_device_disconnected(hdev, &conn->dst, conn->type, conn->dst_type,
-				 cp->reason, mgmt_conn);
+				 hci_to_mgmt_reason(cp->reason), mgmt_conn);
 
 	hci_disconn_cfm(conn, cp->reason);
 
@@ -3381,22 +3381,6 @@ static void hci_conn_request_evt(struct hci_dev *hdev, void *data,
 	hci_dev_unlock(hdev);
 }
 
-static u8 hci_to_mgmt_reason(u8 err)
-{
-	switch (err) {
-	case HCI_ERROR_CONNECTION_TIMEOUT:
-		return MGMT_DEV_DISCONN_TIMEOUT;
-	case HCI_ERROR_REMOTE_USER_TERM:
-	case HCI_ERROR_REMOTE_LOW_RESOURCES:
-	case HCI_ERROR_REMOTE_POWER_OFF:
-		return MGMT_DEV_DISCONN_REMOTE;
-	case HCI_ERROR_LOCAL_HOST_TERM:
-		return MGMT_DEV_DISCONN_LOCAL_HOST;
-	default:
-		return MGMT_DEV_DISCONN_UNKNOWN;
-	}
-}
-
 static void hci_disconn_complete_evt(struct hci_dev *hdev, void *data,
 				     struct sk_buff *skb)
 {
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 733a4b70e10c..1c1b64e651dc 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -9848,6 +9848,22 @@ bool mgmt_powering_down(struct hci_dev *hdev)
 	return false;
 }
 
+u8 hci_to_mgmt_reason(u8 err)
+{
+	switch (err) {
+	case HCI_ERROR_CONNECTION_TIMEOUT:
+		return MGMT_DEV_DISCONN_TIMEOUT;
+	case HCI_ERROR_REMOTE_USER_TERM:
+	case HCI_ERROR_REMOTE_LOW_RESOURCES:
+	case HCI_ERROR_REMOTE_POWER_OFF:
+		return MGMT_DEV_DISCONN_REMOTE;
+	case HCI_ERROR_LOCAL_HOST_TERM:
+		return MGMT_DEV_DISCONN_LOCAL_HOST;
+	default:
+		return MGMT_DEV_DISCONN_UNKNOWN;
+	}
+}
+
 void mgmt_device_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			      u8 link_type, u8 addr_type, u8 reason,
 			      bool mgmt_connected)
@@ -9909,7 +9925,8 @@ void mgmt_connect_failed(struct hci_dev *hdev, struct hci_conn *conn, u8 status)
 
 	if (test_and_clear_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags)) {
 		mgmt_device_disconnected(hdev, &conn->dst, conn->type,
-					 conn->dst_type, status, true);
+					 conn->dst_type,
+					 hci_to_mgmt_reason(status), true);
 		return;
 	}
 
-- 
2.55.0

