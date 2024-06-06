Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746E9188CC6
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Jun 2024 16:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717691362; cv=none; b=mzY5ldatB94+FDyeA1hS2c9fLVSF7Fe8RQEpNXvCHtX6k/pGPfmrcHOYjMVTLHr49kyBZDoJjWvtE4YfJiS56etQjgNddGJml3k+50Q5fADk4v3+CEYIXCJm5DLPHO5xaEUik3U+nmSmvojWFkisbKsZk8d9ej4SXd4XOCjT0m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717691362; c=relaxed/simple;
	bh=Vvg/zYMyhVbg5vNjLVI01diA6xgcRQNdjZkynk0cSgY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PItMJo9WLnDCOqnreTKJUFt1wcoYL8cemdtqCWf8/VMAq5X5N+QBXsdiB0qBInxi1q2HSOdtMdQ5lJOzXnJa9a/dBnzr/n4gZQcZii+7Try5EghwKmMV+S3v2n0HEU+S3ofu7zWBHIDMVZJMXSp55kFdl3UTuH2RyHG2OxIYNko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jgbxGOY9; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgbxGOY9"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-80acdff7515so381283241.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Jun 2024 09:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717691359; x=1718296159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ABs8vofmhCnDemqBsSxDpRCqC1ADwtC+xMe5gdHhVh4=;
        b=jgbxGOY9eoMr4yU9FwPrWQ+U6A+gdx6qgnRtu+nKcFFwt8usO51s1VSPI/Ohj2Qale
         MhlmInIZvXEtbhw3bvK5FA3kFoAQuxs37LVRQ9cxhpF4iJCwTpEr9VePd1uvlSrXHK3s
         H6VXOj0p50BcAQIdP/9Hc4pDm3k7ya6AHJX/3487QMSU9tm8h191JExFWlxeJ3xdFoDg
         ORKLidM281T/934BWAUbRdWld9pIZfd6M9c3NkkB6auQeaWcCJ61/0hl9BPUZ/Prd/rU
         IG1CERrmOhJjBXaLy914gVPxtRINTc40ZeCExGAo3X2uItXstSio+XJFdu2U41gMc5eR
         vPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717691359; x=1718296159;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ABs8vofmhCnDemqBsSxDpRCqC1ADwtC+xMe5gdHhVh4=;
        b=K1nizXgfzr/ClcfZ51kPs/Sm+dbeDmmCRhkIJD1F42FG5/AFSDvzsnhANBFBuJqjlh
         ASvto8z0Rn+oFR2VHbs8YSIA2ABEajKN4kCICFajRnXRZH1B3PN5hhI3+4DvLfZBVKUf
         ohjp29A3yv1P/LfZeahT9ld2rQK3AfBlA2V1jn701bLTwC/uV9N5523Numn3aCMLRbZO
         qovYZ2bQPxDSz5ZrXAaJWTfxd3YkzU/zA9ZiGfcF2pWwlIx3VS70cu8Oo0vfA99N1gSt
         vjG91N3tkeedzWCLQSg2V3zs6kKVmHMrGXpK2gVctbx1XqFgh0BfNnPNKkWU9bqcwJX2
         QYwQ==
X-Gm-Message-State: AOJu0YwQoqCHvF8t535QgeAVi9p4b9SZAq3mLkQSWVRcLLZpJMalAxjC
	mFPvf+834puXh0aHnq4sx7eAdzPeGTVltuy6h/yksE/1kh+0KLCC/wL/qA==
X-Google-Smtp-Source: AGHT+IGqIk0HK0S5EKFnaaqQFo3EJDhzwpgYDYwNCIGPvkd+nhpMa9+GyseZ3LmpanPHai8e5x6GAA==
X-Received: by 2002:a05:6122:6029:b0:4eb:13ff:cd90 with SMTP id 71dfb90a1353d-4eb562bfe62mr98245e0c.13.1717691359190;
        Thu, 06 Jun 2024 09:29:19 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4eb4acaf242sm217294e0c.26.2024.06.06.09.29.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 09:29:18 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: hci_event: Fix setting of unicast qos interval
Date: Thu,  6 Jun 2024 12:29:17 -0400
Message-ID: <20240606162917.621031-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

qos->ucast interval reffers to the SDU interval, and should not
be set to the interval value reported by the LE CIS Established
event since the latter reffers to the ISO interval. These two
interval are not the same thing:

BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 6, Part G

Isochronous interval:
The time between two consecutive BIS or CIS events (designated
ISO_Interval in the Link Layer)

SDU interval:
The nominal time between two consecutive SDUs that are sent or
received by the upper layer.

So this instead uses the following formula from the spec to calculate
the resulting SDU interface:

BLUETOOTH CORE SPECIFICATION Version 5.4 | Vol 6, Part G
page 3075:

Transport_Latency_C_To_P = CIG_Sync_Delay + (FT_C_To_P) ×
ISO_Interval + SDU_Interval_C_To_P
Transport_Latency_P_To_C = CIG_Sync_Delay + (FT_P_To_C) ×
ISO_Interval + SDU_Interval_P_To_C

Link: https://github.com/bluez/bluez/issues/823
Fixes: 2be22f1941d5 ("Bluetooth: hci_event: Fix parsing of CIS Established Event")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_event.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index da10738a052d..5d23bcf18716 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6667,6 +6667,7 @@ static void hci_le_cis_estabilished_evt(struct hci_dev *hdev, void *data,
 	struct bt_iso_qos *qos;
 	bool pending = false;
 	u16 handle = __le16_to_cpu(ev->handle);
+	u32 c_sdu_interval, p_sdu_interval;
 
 	bt_dev_dbg(hdev, "status 0x%2.2x", ev->status);
 
@@ -6691,12 +6692,25 @@ static void hci_le_cis_estabilished_evt(struct hci_dev *hdev, void *data,
 
 	pending = test_and_clear_bit(HCI_CONN_CREATE_CIS, &conn->flags);
 
-	/* Convert ISO Interval (1.25 ms slots) to SDU Interval (us) */
-	qos->ucast.in.interval = le16_to_cpu(ev->interval) * 1250;
-	qos->ucast.out.interval = qos->ucast.in.interval;
+	/* BLUETOOTH CORE SPECIFICATION Version 5.4 | Vol 6, Part G
+	 * page 3075:
+	 * Transport_Latency_C_To_P = CIG_Sync_Delay + (FT_C_To_P) ×
+	 * ISO_Interval + SDU_Interval_C_To_P
+	 * ...
+	 * SDU_Interval = (CIG_Sync_Delay + (FT) x ISO_Interval) -
+	 *					Transport_Latency
+	 */
+	c_sdu_interval = (get_unaligned_le24(ev->cig_sync_delay) +
+			 (ev->c_ft * le16_to_cpu(ev->interval) * 1250)) -
+			get_unaligned_le24(ev->c_latency);
+	p_sdu_interval = (get_unaligned_le24(ev->cig_sync_delay) +
+			 (ev->p_ft * le16_to_cpu(ev->interval) * 1250)) -
+			get_unaligned_le24(ev->p_latency);
 
 	switch (conn->role) {
 	case HCI_ROLE_SLAVE:
+		qos->ucast.in.interval = c_sdu_interval;
+		qos->ucast.out.interval = p_sdu_interval;
 		/* Convert Transport Latency (us) to Latency (msec) */
 		qos->ucast.in.latency =
 			DIV_ROUND_CLOSEST(get_unaligned_le24(ev->c_latency),
@@ -6710,6 +6724,8 @@ static void hci_le_cis_estabilished_evt(struct hci_dev *hdev, void *data,
 		qos->ucast.out.phy = ev->p_phy;
 		break;
 	case HCI_ROLE_MASTER:
+		qos->ucast.in.interval = p_sdu_interval;
+		qos->ucast.out.interval = c_sdu_interval;
 		/* Convert Transport Latency (us) to Latency (msec) */
 		qos->ucast.out.latency =
 			DIV_ROUND_CLOSEST(get_unaligned_le24(ev->c_latency),
-- 
2.45.1

