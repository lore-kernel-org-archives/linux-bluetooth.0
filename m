Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58DE12F5A5
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Feb 2024 21:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708982146; cv=none; b=LZLhD4yVUq53VahvlWnC3V8sZEEvv/HVkwk4L1Jc55jh4xJOQM8vk2LDTRJ9uW6V0LV3HJSuE7oAE1uOZclc0jImdhLwkfr6WWi5GpvxV6myq4+prtMgI/CS2s0A4CK8Aw33IL3ggDf8IO/XE+0d0vIg92bsFew5WadFbz+WgwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708982146; c=relaxed/simple;
	bh=yAwVjnii4gOdKjVBPRKqszUhbHC1xKlL80xFSv2WaF0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=UGqee8SiYgif6U/kbQ4jsixzxGSRm1ytsQN4Amc9wshgDkkO7ArdKPCXx+4NL4arWgAO9v19kJAdbZAlllOdU9LGA0rNjPjeyllIOnWBhPgUJP22THRwIHyQ3yVup3RN0lyW+n7/H62dvChi2qykIL2nSWMVEqFfOUukncrVxMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JwYruh/m; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JwYruh/m"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-7d2e19120b5so2340950241.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Feb 2024 13:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708982143; x=1709586943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ef5cxWS/DHX003FFu3ZV3XHChZLsTqEMaAm7lSIlAsk=;
        b=JwYruh/m+p3wyzds3zdCdQLfF0GvRV1aMChSLKxyK6XfE08Pno9evLA975oB+Dg9rt
         pMg4KgGpGkwfUMKLmRsSpKqz5TtomlyecUkmnBBZXteT7NLou7WinJTzhHhxVNAIqu9W
         U1QlHKA1s0FfvU7wJgMcUth5Wp2sDgijgXhFXN/yjcVj88BpEJ9QfsuPX3EZvYV9whI+
         TK/93AK8gTEqTusMF57v+hh9VK1a9wRBph+ZVH3OK7quS/HabLbRBwKFJ6K+kItPjPgq
         OgWNVXYxgbk5NdZKbS0kz27IVKbUpq88gKIfQoJ3404GKAhw8dtsh76jSYBTjQoZGrhL
         Uptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708982143; x=1709586943;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ef5cxWS/DHX003FFu3ZV3XHChZLsTqEMaAm7lSIlAsk=;
        b=Xqnk6iDITDtcSOGSQiJyMTrQsWRwhuW7mYKzwhcQ0hTc9M0eGstyfuULChvHMt+nfw
         ASfpIl/pjyKWVwxTXNTA76x3uwbswQAOzrqHqvVKV4NoSofwMJLPZ2SB9ckuFH5BHzgY
         70/voUNOHw7IM6h+96MrJjCOGHbgkzmdxry4X1e0sVzHSYYHUipaQRwFgqeM5aNya6ZX
         84QmbM+HT4gROmSXbwJO+F9hBTNkoSvJ0PG1BlOpd/9RN/4YYsJ37gqd+htZLDL8nRpu
         emFtGjutJLfnG/K3XAxtDyowry3oMXlRNicHOXLITxVrjJt8UXHCWVcrDVkdsXR21tdu
         576g==
X-Gm-Message-State: AOJu0Yzg9CK/5mqVVt1piR1Sy40vkgrXWjyHJ/idzc1eNX5JUzO22Ir5
	H9X5nm2Y5dMa4rzmzgi/DBYeWb+B4HZxqZyopkDmDXwLnOdWhlRT+fA4ERZ0
X-Google-Smtp-Source: AGHT+IGGTInKFg5YWhAzMw+P9kYJyNznvvcAyltsoRWljg0uPl3Zrr3PoQX59PP2xIwV3r3fjxqdIA==
X-Received: by 2002:a1f:ca47:0:b0:4c9:b8a8:78d4 with SMTP id a68-20020a1fca47000000b004c9b8a878d4mr5511919vkg.3.1708982141467;
        Mon, 26 Feb 2024 13:15:41 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id ep9-20020a056122390900b004c003cf5e14sm724487vkb.28.2024.02.26.13.15.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 13:15:40 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 1/2] Bluetooth: hci_sync: Use address filtering when HCI_PA_SYNC is set
Date: Mon, 26 Feb 2024 16:15:38 -0500
Message-ID: <20240226211539.1675928-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If HCI_PA_SYNC flag is set it means there is a Periodic Advertising
Synchronization pending, so this attempts to locate the address passed
to HCI_OP_LE_PA_CREATE_SYNC and program it in the accept list so only
reports with that address are processed.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 45 +++++++++++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 669099cf9b1a..ab609089ac4c 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -2566,6 +2566,16 @@ static struct conn_params *conn_params_copy(struct list_head *list, size_t *n)
 	return p;
 }
 
+/* Clear LE Accept List */
+static int hci_le_clear_accept_list_sync(struct hci_dev *hdev)
+{
+	if (!(hdev->commands[26] & 0x80))
+		return 0;
+
+	return __hci_cmd_sync_status(hdev, HCI_OP_LE_CLEAR_ACCEPT_LIST, 0, NULL,
+				     HCI_CMD_TIMEOUT);
+}
+
 /* Device must not be scanning when updating the accept list.
  *
  * Update is done using the following sequence:
@@ -2614,6 +2624,31 @@ static u8 hci_update_accept_list_sync(struct hci_dev *hdev)
 		goto done;
 	}
 
+	/* Force address filtering if PA Sync is in progress */
+	if (hci_dev_test_flag(hdev, HCI_PA_SYNC)) {
+		struct hci_cp_le_pa_create_sync *sent;
+
+		sent = hci_sent_cmd_data(hdev, HCI_OP_LE_PA_CREATE_SYNC);
+		if (sent) {
+			struct conn_params pa;
+
+			memset(&pa, 0, sizeof(pa));
+
+			bacpy(&pa.addr, &sent->addr);
+			pa.addr_type = sent->addr_type;
+
+			/* Clear first since there could be addresses left
+			 * behind.
+			 */
+			hci_le_clear_accept_list_sync(hdev);
+
+			num_entries = 1;
+			err = hci_le_add_accept_list_sync(hdev, &pa,
+							  &num_entries);
+			goto done;
+		}
+	}
+
 	/* Go through the current accept list programmed into the
 	 * controller one by one and check if that address is connected or is
 	 * still in the list of pending connections or list of devices to
@@ -4220,16 +4255,6 @@ static int hci_le_read_accept_list_size_sync(struct hci_dev *hdev)
 				     0, NULL, HCI_CMD_TIMEOUT);
 }
 
-/* Clear LE Accept List */
-static int hci_le_clear_accept_list_sync(struct hci_dev *hdev)
-{
-	if (!(hdev->commands[26] & 0x80))
-		return 0;
-
-	return __hci_cmd_sync_status(hdev, HCI_OP_LE_CLEAR_ACCEPT_LIST, 0, NULL,
-				     HCI_CMD_TIMEOUT);
-}
-
 /* Read LE Resolving List Size */
 static int hci_le_read_resolv_list_size_sync(struct hci_dev *hdev)
 {
-- 
2.43.0

