Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D47A194AEF
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Aug 2024 20:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724703924; cv=none; b=ECdD/5rYjN5k3StLvtoTap4V2Gv4JHuyjEYhlJ1CtvtDFMlsUtJuUD/c8t2QGkRbcB8l23+Urw0weMGZQs3rPsUH+KouYe53z0MqsjXHrsblHbPMItOoagefXJ0r/tXBPyyxgxMTlTsNJHThJQwvEnv38SZLXCBI8ymd0O2jhk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724703924; c=relaxed/simple;
	bh=i3bc9JwCIAY/CzUsnC+hGW60iuX8efZwwzQrv5oLSOE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=AfWwjVnHzA0Mrb/6ZZoER66H2LyBx5Snxqffvw2JPNgXVli+pBu4FIJ+dzWhyRBUYESObSzX0wRdmLjmigCBzouskI3tBynwgoS/O0P3JyDRt1dxvL+JX+dubh57lGt5gQ6aN9/fGNyfZNVq/JkMHPWNss85CqgaZ11uMuwrD5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/6AKcFb; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/6AKcFb"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-498cf14a848so1571519137.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Aug 2024 13:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724703921; x=1725308721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=MIBJlvoJyQt5yhkogIg2C4Mf00EV4uxKnogdf+CUEbo=;
        b=D/6AKcFbc4Ia6znlZQXFhGQ2cwppl7rtJgTtgIAxUJYhHmJaZF1NonVEdNC+JH9Npy
         SaiSP9/zUB8lnw9PXO3GswvzvGFY7N0zO5pIUPhB1JFcdn5f1Z14LCOWWftDmSfKmhh1
         xgGdLWsACQqSrcuCv2dZIS+pHLMgExZz2WxkeGkuFAcmHHL0mNAH9PKjjHg8kKBECrOX
         VVd3olHr45nmyQxRDiAuBgUL/APH8n8FQD3FfxSj3wQXm3/KghyK+fJzGh5HrllIy2Bw
         r7z3rDHyTMnUxcWlZowlWeXtu/USDhtINlZ3jWy7vkBIS4Nr68MOjoEH0JvjJVxihDQ+
         38KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724703921; x=1725308721;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MIBJlvoJyQt5yhkogIg2C4Mf00EV4uxKnogdf+CUEbo=;
        b=LaeHL8cGGtUr3N6FIkA6tnETt4rrUU4z2qJ3dcGjO6GdSt1PSD4CZ2d0rR9BV9n4Jc
         f12/PgYsXSQ090XSUrAwPE2LZBpbOfppqf+gGR+lcrax/Md+EIfFA1fGsGDOqtQaoayF
         0Q8C2QMBYwxXgZ5OBic3OJs/XYcTgYAx+Hha+oiyUQNgaT+es6wsbShiCpVmbhxoRWYx
         sbA0dmP3TAMZ2PEEJ3nzGhhfpr60Er3VJ3oYvptzCrVSHdOLCS8n3E0W/tVu/Xtcui+s
         M+LGCqzBp/vEMWwz/E5UrSlmGvvjszraIsT7SFvHg2In/stew/dJEGe8wOPDb6PGO6lz
         /0Fg==
X-Gm-Message-State: AOJu0YwKgVqTTuDXMK24fFwcLp97AxwEc8LV2V6dpBxv1llXF1ARpiSE
	7TWVFjVdBvA2gz+4179ehHX72qRElERfkTiSaLYwImirj87PswM5EBDuPw==
X-Google-Smtp-Source: AGHT+IGnyxkJ7HxllPwO2tQNKXQ4gVC5m84hVG1c8AZ2tybk2lWIWr+G00gRduq/4qo2NEMGYXQWgA==
X-Received: by 2002:a05:6102:5125:b0:492:a6fb:23e5 with SMTP id ada2fe7eead31-498f4b13f69mr14280128137.3.1724703920538;
        Mon, 26 Aug 2024 13:25:20 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-844ce572f68sm1195475241.29.2024.08.26.13.25.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 13:25:19 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/2] Bluetooth: hci_sync: Introduce hci_cmd_sync_run/hci_cmd_sync_run_once
Date: Mon, 26 Aug 2024 16:25:17 -0400
Message-ID: <20240826202518.524007-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This introduces hci_cmd_sync_run/hci_cmd_sync_run_once which acts like
hci_cmd_sync_queue/hci_cmd_sync_queue_once but runs immediately when
already on hdev->cmd_sync_work context.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_sync.h |  4 +++
 net/bluetooth/hci_sync.c         | 42 ++++++++++++++++++++++++++++++--
 2 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index 75e052909b5f..f3052cb252ef 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -73,6 +73,10 @@ int hci_cmd_sync_queue(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
 		       void *data, hci_cmd_sync_work_destroy_t destroy);
 int hci_cmd_sync_queue_once(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
 			    void *data, hci_cmd_sync_work_destroy_t destroy);
+int hci_cmd_sync_run(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
+		     void *data, hci_cmd_sync_work_destroy_t destroy);
+int hci_cmd_sync_run_once(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
+			  void *data, hci_cmd_sync_work_destroy_t destroy);
 struct hci_cmd_sync_work_entry *
 hci_cmd_sync_lookup_entry(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
 			  void *data, hci_cmd_sync_work_destroy_t destroy);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index e79cd40bd079..5533e6f561b3 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -112,7 +112,7 @@ static void hci_cmd_sync_add(struct hci_request *req, u16 opcode, u32 plen,
 	skb_queue_tail(&req->cmd_q, skb);
 }
 
-static int hci_cmd_sync_run(struct hci_request *req)
+static int hci_req_sync_run(struct hci_request *req)
 {
 	struct hci_dev *hdev = req->hdev;
 	struct sk_buff *skb;
@@ -169,7 +169,7 @@ struct sk_buff *__hci_cmd_sync_sk(struct hci_dev *hdev, u16 opcode, u32 plen,
 
 	hdev->req_status = HCI_REQ_PEND;
 
-	err = hci_cmd_sync_run(&req);
+	err = hci_req_sync_run(&req);
 	if (err < 0)
 		return ERR_PTR(err);
 
@@ -782,6 +782,44 @@ int hci_cmd_sync_queue_once(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
 }
 EXPORT_SYMBOL(hci_cmd_sync_queue_once);
 
+/* Run HCI command:
+ *
+ * - hdev must be running
+ * - if on cmd_sync_work then run immediately otherwise queue
+ */
+int hci_cmd_sync_run(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
+		     void *data, hci_cmd_sync_work_destroy_t destroy)
+{
+	/* Only queue command if hdev is running which means it had been opened
+	 * and is either on init phase or is already up.
+	 */
+	if (!test_bit(HCI_RUNNING, &hdev->flags))
+		return -ENETDOWN;
+
+	/* If on cmd_sync_work then run immediately otherwise queue */
+	if (current_work() == &hdev->cmd_sync_work)
+		return func(hdev, data);
+
+	return hci_cmd_sync_submit(hdev, func, data, destroy);
+}
+EXPORT_SYMBOL(hci_cmd_sync_run);
+
+/* Run HCI command entry once:
+ *
+ * - Lookup if an entry already exist and only if it doesn't creates a new entry
+ *   and run it.
+ * - if on cmd_sync_work then run immediately otherwise queue
+ */
+int hci_cmd_sync_run_once(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
+			  void *data, hci_cmd_sync_work_destroy_t destroy)
+{
+	if (hci_cmd_sync_lookup_entry(hdev, func, data, destroy))
+		return 0;
+
+	return hci_cmd_sync_run(hdev, func, data, destroy);
+}
+EXPORT_SYMBOL(hci_cmd_sync_run_once);
+
 /* Lookup HCI command entry:
  *
  * - Return first entry that matches by function callback or data or
-- 
2.46.0

