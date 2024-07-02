Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C3516C440
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jul 2024 19:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719947529; cv=none; b=smHakkwB3ju/Z8H7FLVIBD9UCtuTB2hBiN/bDj9RfHHnIYQytmyKWVpUDvGb2HNvz63JRPSSdEUhHFxxWYEMGmfQP0yJeD88i3BaLwNtkIpxIxsoCYrCMxasXVhsWh7ymSRX2dHyfCyiTIAIzb1yX88UCHjTdvMEFOS/lxX3Tw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719947529; c=relaxed/simple;
	bh=4xx/ZV+qO06gaSxIB9mWKeopSQx6SR60HZKwyGV7/3U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fOEdw4YsUHoJDBmHf8vTafhj59TetfCTcdJpy8+SCcwqpC1+YESDQ2AdnBZyH34tKwOYPZKG2SA0iZKJtlZ/vOJg1p+2QaeJmDWn0w3hDn5HAv6+O8ZuWy/HVi/XntzERvnOgZZ0Y1FTMhARfhvxY1jjIGwsjuevCLEP4fuoYi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tb81Gm9E; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tb81Gm9E"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4f2da6cbe7bso35099e0c.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jul 2024 12:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719947526; x=1720552326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YOM4IlOkiZQyejuT2F1X0iRy8qEpu41m9Sc+AqNTTT0=;
        b=Tb81Gm9EqDc+KxSRvu8pkXez1yBjgfjydfk/X6USyDH94MhYGyTko4IjwhTw68vsFh
         SDpQ6x48NyDrYJt7vQbVjJYYn8dQttmHE3dYxHI2CGI6jqMg2L0ynGsB4tKix2xPLhCg
         Ryt3nn7lbGay19sYOVT4uAU79uVG3V3bBzrvjJY06lWgcEQ9eoqnk0eeUVyafQ2vBGf3
         +bYjrRshcCcpWB+Ysi6FKKAMXXzbO/SIca8PqO6OjSFJfNMZJAnOymU20uUisB9vgYug
         u1Li8nNttFmFfURZoRCOA/KrAw+4GhsC4agtiaDGKFax3IqL5VVD81kup0XJ05wGWhtq
         GEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719947526; x=1720552326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YOM4IlOkiZQyejuT2F1X0iRy8qEpu41m9Sc+AqNTTT0=;
        b=FEntUeA1H/UQESsiLYsfysM3UqRWp9uknOrpgOIUPjv1zYKoxKmapIJNPJLD1RMLCx
         /UkjwCEk+3xgEIoqVJZ6Vs7/qG6qcylOm+/6UviOJfN0cIQ8TNRsEuT12Mm5Pq44MSTd
         W+p2TbwgcdaS3iNJqpJaqqjDzcVoTvXs25x2pY67geqWVfEcbPZIv7q0lxXLwHwofqNf
         8PYYnsnsk7IPtnff8CF5eFXIHBCv3hcadzBVzbBbLOWAuZ4WGS6SPjCzNJkFEfRp2UR7
         bd0OEvFhuH3tnOAtRNIVZSYGeuZJKbZPyJcdMDmmZuIRKPrEXmz1rQJ8DK4Pm0ywmpPv
         vchA==
X-Gm-Message-State: AOJu0Yw6Zt3CrTQI/p66JCnO/FzpapsQG3tYD5izACx8h/l2EsxDGmFS
	gBWbnrtEsVbox7ugWqhobz342mpsAoJBX/bjROSdMTekqk63c+1Xd3nE/w==
X-Google-Smtp-Source: AGHT+IHQHUL75qo2HoWFxO5sg//OrhK2/XU58+b8abTjR9wSno1ulJ9+OhsM1w39iT1309DCNutLJA==
X-Received: by 2002:ac5:cf19:0:b0:4f2:a973:8ae with SMTP id 71dfb90a1353d-4f2a97308d6mr8849414e0c.5.1719947526030;
        Tue, 02 Jul 2024 12:12:06 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4f292259618sm1383232e0c.37.2024.07.02.12.12.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 12:12:04 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 4/5] Bluetooth: hci_sync: Remove remaining dependencies of hci_request
Date: Tue,  2 Jul 2024 15:11:56 -0400
Message-ID: <20240702191157.1722089-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702191157.1722089-1-luiz.dentz@gmail.com>
References: <20240702191157.1722089-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This removes the dependencies of hci_req_init and hci_request_cancel_all
from hci_sync.c.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_sync.h | 17 +++++++++++++++++
 net/bluetooth/hci_request.h      | 17 -----------------
 net/bluetooth/hci_sync.c         | 14 +++++++++++---
 3 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index a8d88247ac89..75e052909b5f 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -8,6 +8,23 @@
 #define UINT_PTR(_handle)		((void *)((uintptr_t)_handle))
 #define PTR_UINT(_ptr)			((uintptr_t)((void *)_ptr))
 
+#define HCI_REQ_DONE	  0
+#define HCI_REQ_PEND	  1
+#define HCI_REQ_CANCELED  2
+
+#define hci_req_sync_lock(hdev)   mutex_lock(&hdev->req_lock)
+#define hci_req_sync_unlock(hdev) mutex_unlock(&hdev->req_lock)
+
+struct hci_request {
+	struct hci_dev		*hdev;
+	struct sk_buff_head	cmd_q;
+
+	/* If something goes wrong when building the HCI request, the error
+	 * value is stored in this field.
+	 */
+	int			err;
+};
+
 typedef int (*hci_cmd_sync_work_func_t)(struct hci_dev *hdev, void *data);
 typedef void (*hci_cmd_sync_work_destroy_t)(struct hci_dev *hdev, void *data,
 					    int err);
diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
index c91f2838f542..b730da4a8b47 100644
--- a/net/bluetooth/hci_request.h
+++ b/net/bluetooth/hci_request.h
@@ -22,23 +22,6 @@
 
 #include <asm/unaligned.h>
 
-#define HCI_REQ_DONE	  0
-#define HCI_REQ_PEND	  1
-#define HCI_REQ_CANCELED  2
-
-#define hci_req_sync_lock(hdev)   mutex_lock(&hdev->req_lock)
-#define hci_req_sync_unlock(hdev) mutex_unlock(&hdev->req_lock)
-
-struct hci_request {
-	struct hci_dev		*hdev;
-	struct sk_buff_head	cmd_q;
-
-	/* If something goes wrong when building the HCI request, the error
-	 * value is stored in this field.
-	 */
-	int			err;
-};
-
 void hci_req_init(struct hci_request *req, struct hci_dev *hdev);
 void hci_req_purge(struct hci_request *req);
 bool hci_req_status_pend(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 63548c4cc1ac..cd2ed16da8a4 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -12,7 +12,6 @@
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/mgmt.h>
 
-#include "hci_request.h"
 #include "hci_codec.h"
 #include "hci_debugfs.h"
 #include "smp.h"
@@ -146,6 +145,13 @@ static int hci_cmd_sync_run(struct hci_request *req)
 	return 0;
 }
 
+static void hci_request_init(struct hci_request *req, struct hci_dev *hdev)
+{
+	skb_queue_head_init(&req->cmd_q);
+	req->hdev = hdev;
+	req->err = 0;
+}
+
 /* This function requires the caller holds hdev->req_lock. */
 struct sk_buff *__hci_cmd_sync_sk(struct hci_dev *hdev, u16 opcode, u32 plen,
 				  const void *param, u8 event, u32 timeout,
@@ -157,7 +163,7 @@ struct sk_buff *__hci_cmd_sync_sk(struct hci_dev *hdev, u16 opcode, u32 plen,
 
 	bt_dev_dbg(hdev, "Opcode 0x%4.4x", opcode);
 
-	hci_req_init(&req, hdev);
+	hci_request_init(&req, hdev);
 
 	hci_cmd_sync_add(&req, opcode, plen, param, event, sk);
 
@@ -5056,7 +5062,9 @@ int hci_dev_close_sync(struct hci_dev *hdev)
 	cancel_delayed_work(&hdev->ncmd_timer);
 	cancel_delayed_work(&hdev->le_scan_disable);
 
-	hci_request_cancel_all(hdev);
+	hci_cmd_sync_cancel_sync(hdev, ENODEV);
+
+	cancel_interleave_scan(hdev);
 
 	if (hdev->adv_instance_timeout) {
 		cancel_delayed_work_sync(&hdev->adv_instance_expire);
-- 
2.45.2

