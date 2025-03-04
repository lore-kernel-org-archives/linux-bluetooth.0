Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8899729C352
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Mar 2025 16:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741105802; cv=none; b=KKNej7jy1d9ISNojbc19yK+tEWnPjossWTOLrkRL6iqYDlbGtYeTjDvZqTf/J4JxVn1CF2A8ucu1fIYHp7ME255K4ZNSYh8J6iZa/yBRDvMjep1bpFJqpJLUzZ4+57qoY+pZ0SbDLhqpOvjbrkrvAoRwqjpYk1lMpykDq6eK3Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741105802; c=relaxed/simple;
	bh=XR8esuGUkLNa+o1fstDOsQt/fBf6SiG5IEwr5uPykfo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=RkwjMGQ2Pm7q6BjXLYrHGOLNJPtT0VO9pS/ZMGOCBWiy5KVBYQHvhBN7ymtsiUuzF11jJcS6OUkLumJB+0n+Q3dJ2H6lpDZLJIWRjha0rp7dLl0FvgD+07JKMSUufu4ZG/aqQmFyXJcNoj0dSm+kq3io59m/BpXYyS+TK+avQE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hUAHW2vy; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUAHW2vy"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-86b0899ad8bso2259371241.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Mar 2025 08:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741105799; x=1741710599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1A25AS+z+Y2iaSLzTYSlRiMEBOo6iE6gKWS0QEPBxxw=;
        b=hUAHW2vyBvBs6gFxhnP9Q7la5KUTRdgMlY8oITBxF3RytExXxBj32tRgdMzXnhtHpJ
         IkeZ/XapGPXD24mFdqCr84dNDqnCPchw2ED7cTVjjimS1EBSFD40gBK6enrLwRa/yp5P
         rM5Z3zc2byp0uvwhcpOTYH1ROJKyCsK19sqKWxU/EdkJF+5nZDMkEjpJM+k5b4tTOObT
         2c0Ije03Q+YEN1c3OEBevP2zAcCFri0w1Eec/0ykr9u00E6Cni7mAG9ZvJM4Chk2kJgo
         9bZE+fcsTOliwmnkR3uCsBMvrxgaEJAC0ME//o/eEH9zaXN7rdA24LWMepq7zcIJXlmf
         FXlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741105799; x=1741710599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1A25AS+z+Y2iaSLzTYSlRiMEBOo6iE6gKWS0QEPBxxw=;
        b=owBE9DUS9xSLc/MUOQLUoEuEy7lpI3lu38z6QYyiRNWLft1xm+4Blbjp0OtvGVFoW4
         SlaodTManuLOKo+8c0/ji88aj4xryMz5U97XJJFfF5jUYguj0GnL3xuuPKK+dhT1eSqu
         z6BqdJWGAxptGEqQuDgl0xZi9bblNRPRTgnG51pro7zSplwKgLqNcrMQ5PtFHh7cXczk
         taP504EqI60629DUfKI6hJvNsy7zDQ0Tl9znoRPAEXj9yTF21hOP6hSKF0Weawc9hLe1
         cwwA6DMMpMBdHm+ntpyxYsH372mgHIbGbftuOPhrTw0GXYqmZqJ4iFA/S69qdqxGrDu8
         bJ3g==
X-Gm-Message-State: AOJu0YwEEeWvdJD/NLeA0L5OUM4PkDAw3TW7Fp4IDP/vecKKLHyNxSJ0
	OgLcwgUHvwS5wsslUHysKD3wY93eklc5zPjc+EtzoyC2BETWrV3pLG/PIw==
X-Gm-Gg: ASbGncve5l8XtL0vEg0mEwyFRJMUw7yfGqm2e7ieLZK/k1uOhDcLAflWyGZyUF0TCTD
	D3pqeaTVeu07fNi3sCYg/hZojOnqh/z9jrye2qcXlp9IXvMnHaMoKNJ8xmGfoGak6MwUnHl74i1
	+zsfHvXiCsqlSVu04qstlqyD/o+F97Odeog+RTh5oeF1MTj26w/cZ+bPd67zdEUAbCGAjpCzhgA
	JIcaWSWWoMUHcFucwP7KACznRXks5CtQNnrVz5M1Q0ElV8MREOwUnZs2Lxsg7NEIb0MChPEtRG3
	MJSlQL3gnjS+UnEaj9gDdzbmjyECnZKeslppxAb+MmShG4EPHTR4foWe770SoP9NO1lg3OCG0gr
	tX78YcfSgb8p28w==
X-Google-Smtp-Source: AGHT+IFydDf3zT8xQkCyZOEo4a+xbVKNMaubkKT8xLpyKwLJYlKXRh8TK5kIp1wGdy7Gv8htgF/xdA==
X-Received: by 2002:a05:6102:dce:b0:4bb:c4ff:5cb9 with SMTP id ada2fe7eead31-4c044966a58mr10868928137.15.1741105798631;
        Tue, 04 Mar 2025 08:29:58 -0800 (PST)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c176349a01sm1886205137.0.2025.03.04.08.29.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 08:29:56 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4] Bluetooth: hci_core: Enable buffer flow control for SCO/eSCO
Date: Tue,  4 Mar 2025 11:29:55 -0500
Message-ID: <20250304162955.149884-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables buffer flow control for SCO/eSCO
(see: Bluetooth Core 6.0 spec: 6.22. Synchronous Flow Control Enable),
recently this has caused the following problem and is actually a nice
addition for the likes of Socket TX complete:

< HCI Command: Read Buffer Size (0x04|0x0005) plen 0
> HCI Event: Command Complete (0x0e) plen 11
      Read Buffer Size (0x04|0x0005) ncmd 1
        Status: Success (0x00)
        ACL MTU: 1021 ACL max packet: 5
        SCO MTU: 240  SCO max packet: 8
...
< SCO Data TX: Handle 257 flags 0x00 dlen 120
< SCO Data TX: Handle 257 flags 0x00 dlen 120
< SCO Data TX: Handle 257 flags 0x00 dlen 120
< SCO Data TX: Handle 257 flags 0x00 dlen 120
< SCO Data TX: Handle 257 flags 0x00 dlen 120
< SCO Data TX: Handle 257 flags 0x00 dlen 120
< SCO Data TX: Handle 257 flags 0x00 dlen 120
< SCO Data TX: Handle 257 flags 0x00 dlen 120
< SCO Data TX: Handle 257 flags 0x00 dlen 120
> HCI Event: Hardware Error (0x10) plen 1
        Code: 0x0a

Fixes: 7fedd3bb6b77 ("Bluetooth: Prioritize SCO traffic")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci.h      |  6 ++++++
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         | 28 ++++++++++++++++++++++++++++
 net/bluetooth/hci_sync.c         | 23 +++++++++++++++++++++++
 4 files changed, 58 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index b99818df8ee7..70169533c940 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -448,6 +448,7 @@ enum {
 	HCI_WIDEBAND_SPEECH_ENABLED,
 	HCI_EVENT_FILTER_CONFIGURED,
 	HCI_PA_SYNC,
+	HCI_SCO_FLOWCTL,
 
 	HCI_DUT_MODE,
 	HCI_VENDOR_DIAG,
@@ -1544,6 +1545,11 @@ struct hci_rp_read_tx_power {
 	__s8     tx_power;
 } __packed;
 
+#define HCI_OP_WRITE_SYNC_FLOWCTL	0x0c2f
+struct hci_cp_write_sync_flowctl {
+	__u8     enable;
+} __packed;
+
 #define HCI_OP_READ_PAGE_SCAN_TYPE	0x0c46
 struct hci_rp_read_page_scan_type {
 	__u8     status;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 2f320eeddfec..cf18cf65fe5e 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1857,6 +1857,7 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 #define lmp_hold_capable(dev)      ((dev)->features[0][0] & LMP_HOLD)
 #define lmp_sniff_capable(dev)     ((dev)->features[0][0] & LMP_SNIFF)
 #define lmp_park_capable(dev)      ((dev)->features[0][1] & LMP_PARK)
+#define lmp_sco_capable(dev)       ((dev)->features[0][1] & LMP_SCO)
 #define lmp_inq_rssi_capable(dev)  ((dev)->features[0][3] & LMP_RSSI_INQ)
 #define lmp_esco_capable(dev)      ((dev)->features[0][3] & LMP_ESCO)
 #define lmp_bredr_capable(dev)     (!((dev)->features[0][4] & LMP_NO_BREDR))
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index e7ec12437c8b..63eec8b80ff1 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3564,11 +3564,25 @@ static void hci_sched_sco(struct hci_dev *hdev)
 			BT_DBG("skb %p len %d", skb, skb->len);
 			hci_send_frame(hdev, skb);
 
+			hdev->sco_cnt--;
 			conn->sent++;
 			if (conn->sent == ~0)
 				conn->sent = 0;
 		}
 	}
+
+	/* Restore sco_cnt if flow control has not been enabled as
+	 * HCI_EV_NUM_COMP_PKTS won't be generated.
+	 */
+	if (!hci_dev_test_flag(hdev, HCI_SCO_FLOWCTL)) {
+		hdev->sco_cnt = hdev->sco_pkts;
+
+		/* As flow control is disabled force tx_work to run if there are
+		 * still packets left in the queue.
+		 */
+		if (conn && !skb_queue_empty(&conn->data_q))
+			queue_work(hdev->workqueue, &hdev->tx_work);
+	}
 }
 
 static void hci_sched_esco(struct hci_dev *hdev)
@@ -3588,11 +3602,25 @@ static void hci_sched_esco(struct hci_dev *hdev)
 			BT_DBG("skb %p len %d", skb, skb->len);
 			hci_send_frame(hdev, skb);
 
+			hdev->sco_cnt--;
 			conn->sent++;
 			if (conn->sent == ~0)
 				conn->sent = 0;
 		}
 	}
+
+	/* Restore sco_cnt if flow control has not been enabled as
+	 * HCI_EV_NUM_COMP_PKTS won't be generated.
+	 */
+	if (!hci_dev_test_flag(hdev, HCI_SCO_FLOWCTL)) {
+		hdev->sco_cnt = hdev->sco_pkts;
+
+		/* As flow control is disabled force tx_work to run if there are
+		 * still packets left in the queue.
+		 */
+		if (!skb_queue_empty(&conn->data_q))
+			queue_work(hdev->workqueue, &hdev->tx_work);
+	}
 }
 
 static void hci_sched_acl_pkt(struct hci_dev *hdev)
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index c4c2cf51b219..aaa6164fc3e3 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -3769,6 +3769,27 @@ static int hci_write_ca_timeout_sync(struct hci_dev *hdev)
 				     sizeof(param), &param, HCI_CMD_TIMEOUT);
 }
 
+/* Enable SCO flow control if supported */
+static int hci_write_sync_flowctl_sync(struct hci_dev *hdev)
+{
+	struct hci_cp_write_sync_flowctl cp;
+	int err;
+
+	/* Check if the controller supports SCO and HCI_OP_WRITE_SYNC_FLOWCTL */
+	if (!lmp_sco_capable(hdev) || !(hdev->commands[10] & BIT(4)))
+		return 0;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.enable = 0x01;
+
+	err = __hci_cmd_sync_status(hdev, HCI_OP_WRITE_SYNC_FLOWCTL,
+				    sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+	if (!err)
+		hci_dev_set_flag(hdev, HCI_SCO_FLOWCTL);
+
+	return err;
+}
+
 /* BR Controller init stage 2 command sequence */
 static const struct hci_init_stage br_init2[] = {
 	/* HCI_OP_READ_BUFFER_SIZE */
@@ -3787,6 +3808,8 @@ static const struct hci_init_stage br_init2[] = {
 	HCI_INIT(hci_clear_event_filter_sync),
 	/* HCI_OP_WRITE_CA_TIMEOUT */
 	HCI_INIT(hci_write_ca_timeout_sync),
+	/* HCI_OP_WRITE_SYNC_FLOWCTL */
+	HCI_INIT(hci_write_sync_flowctl_sync),
 	{}
 };
 
-- 
2.48.1

