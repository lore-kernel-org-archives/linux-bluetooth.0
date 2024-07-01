Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EAB16EB7E
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jul 2024 21:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719868550; cv=none; b=fEHJDa4Ck9JveAoIWQjYm/XL16l49HL8qxfi3Fwua0zsy5Bu3gXMakVjeU+W6QP73ONUGL8J6wgiJ89x00+j7ZojypVLvnwDQsjXxD1nIIkDdY+EJeOOBOSO2rpU/1WyZWMESYTpSyVb9irkRVzn/uySo2TcrpehdNUBypWTP2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719868550; c=relaxed/simple;
	bh=rAgMZrW5sK0qLDQj2sdykzN1rcdVtFbKOXNTnm8hrtg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BkqtaWAiGJV4LjWfUS5K+oIR05SV+S3Yye9NDaEE+yOSl9mncBw+OMshh03fwQsIK408tBOrHxLN6Z1fFUgKxC5AICB3niGJX0TOisfSOpGwFyLn5xyiO60hREGfq+9eNxwcvIF2g7tkUBAc6sloqsAhf3Hv9Ht9gMWgMXJaH58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UwjC7fv0; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwjC7fv0"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4ef5a2f4e6cso1226196e0c.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jul 2024 14:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719868547; x=1720473347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OUR/Eamd9bYhqhv6dELTuOlT5p87zqs6Nnwes6BQidM=;
        b=UwjC7fv0rKfPQvR4+KdLorsgiePJ1E2x8yi5cgxrArZsdTXrK5oLwbc9FZS+9iqy0J
         PpZFrDfF1wDwzsv+sP8u/Rp4+jGkGf4OmhdIoyalaAAXjFO4WOs6XSuxM4o/czTubwvJ
         Nke5GdFReMuUD/NNY/3/4sBMg8Yz/lckENRaRQIdmtEnulllSxUyU6Hc36bD6dK3suDR
         +FvAiHq3lm1ulNSvZQympZeICOrDBennJTGF1smiBOIDmFazK4FesEhnpQVycVw+0XAO
         0HWZIFWVwTgXgGbClTWJ02CJX2u0SXdE/O/D84yR4PZ4nZNVqGEvfXhEKRcjBEmf+6df
         0fsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719868547; x=1720473347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OUR/Eamd9bYhqhv6dELTuOlT5p87zqs6Nnwes6BQidM=;
        b=tgr3shZ/noU0OBB7Afz43YQlkaKYvJ9pYSV4DQa/HD0911G/2u2j47gSPeD0du20Bn
         lDOPHB7sm7lt3HNDANDvOjz7Lc2dNK/QR7N8UrQuKI4qJ3cZiW1PjX186CPnInzuVqIg
         sIeeWmxBJIrhtc3pLEpDLS3mcSraGIzLl+J1KYRxJ612UqvpMu8yM4BYXMbY1Vk1lPUl
         jz7xsLhUl4Yp7bNmqQIdFeP9snf2B/veeS9IRdhDHrvWXcUIcsTmJHdFBoJA2SNo97az
         kJHvvGYrQpJ1qJMWkjdHOluo9zIzxBY4upxJmQKn6ayg/jU3U6Q8edL1KRGmyxbQ8p51
         r6cw==
X-Gm-Message-State: AOJu0YyDNVg8M/PqGr0R4YfFUefh88wbelOA6/JJvUk3qQU9wl8r7AE1
	wfc3/CY/X/TrpNCoOtpCbAS7w4eMpN4KLtIDSh2Rz4F3MSK3IDpPML5HLg==
X-Google-Smtp-Source: AGHT+IE0onQlcHoXJc9lz3H4ChMcScJlIPDVevv26twIf14Y2EW3uEVI1C6z+3eVLHQthAorfUFm/A==
X-Received: by 2002:a05:6122:4b0d:b0:4ef:56d8:9e62 with SMTP id 71dfb90a1353d-4f2a565f73dmr8493940e0c.5.1719868547518;
        Mon, 01 Jul 2024 14:15:47 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4f292271514sm1144827e0c.51.2024.07.01.14.15.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 14:15:45 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 4/5] Bluetooth: hci_sync: Remove remaining dependencies of hci_request
Date: Mon,  1 Jul 2024 17:15:37 -0400
Message-ID: <20240701211538.1420913-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240701211538.1420913-1-luiz.dentz@gmail.com>
References: <20240701211538.1420913-1-luiz.dentz@gmail.com>
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
 net/bluetooth/hci_sync.c         | 14 +++++++++++---
 2 files changed, 28 insertions(+), 3 deletions(-)

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

