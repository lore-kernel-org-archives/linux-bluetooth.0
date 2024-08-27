Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7091E487
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Aug 2024 14:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724767535; cv=none; b=Kbdxz32I+wY9nk0ggOGqcNLDJa2J+0yY5j+HQaVTJ9pTaRx8SR365u09OGTcvrAARo0lmpf+TxG03UMiX4oTRwU5ysyJWxxxgZcnxaXR3QqbblODlQur5E8ohR3RmSrQsJuGRC/OWw0bMt874w0XL839VM6HbO/65rogTlOnpD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724767535; c=relaxed/simple;
	bh=i3bc9JwCIAY/CzUsnC+hGW60iuX8efZwwzQrv5oLSOE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=s1cSzauspND3bsI5nVmx/2s3+v/2az5AXC1sTEwpYyc5OB7rT7iDIjFivH+PAIWB7TjAsNxQIJN3SSvvWB848jw5jai00y6ZTnz3d+UV7oMgtiBThv6e65VO9wm7+MMfYBJ7FK6Z7VkEI0VAT2aGqXmPr8HVocGyk3fJjA1yAp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JmbgWrFN; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JmbgWrFN"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5da6865312eso4550875eaf.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Aug 2024 07:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724767532; x=1725372332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=MIBJlvoJyQt5yhkogIg2C4Mf00EV4uxKnogdf+CUEbo=;
        b=JmbgWrFNAIw7uToX26hMqzhHmn0fZg2eQtcAjz3b0PyQIBXgz+Wm4ZqlQX8aSnP8Ff
         +f+vqM0ovxMj/zk78uZNMLAwXe7t+JGopJcH3QbnlvaGuyiID1FGawb4acB1eEjUX4gl
         Gcwi08FI5h8SyFlQvKN61UANDzHfGc2gMzdBol/1WzouE7WeIouqYkezflkrL0sU+MMY
         G818qKJEL9WumKViP+F89RivW4z1mzNG6r6jebyDLBD38VbuO5DjicTaY4eHPnmO8HdM
         IVZ5zdkYl3FM4FTcZ7MlIs85n0WmEkIv8K8rdlCbsnFQj+Gq+qIEufDISWCYknh3YNZJ
         OKaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724767532; x=1725372332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MIBJlvoJyQt5yhkogIg2C4Mf00EV4uxKnogdf+CUEbo=;
        b=VwBq6VORu3bon5x5L8fRgIAjhx6SzDXnd32vA3AhW+INLfB1eTmtf1cFHF/LKQ/UEo
         W80QnlArrFCp9p6yGNlLEjrxT29pU9zcmMx5E6DshzBbpsMEhLuYSr9MlnpwY/dL538F
         X6lvUO4wIq0fgyFL7GRpUrYojatfV1Xo2oYyvL/1DSeSX0tYg3EkgJPyDUFhmDi+LaEt
         UiBcZpV5bNGy07IsWKWI1vItYScp93Lu6ZAmqjrTwe3alRv4T77xKh9i0a/UM5ziGjiy
         UB8Adt9I+t9WkzQTD38na8m+t0CRsea8qtBmaq5c1mHceYs0hp1Ce4KKnglro4fxXkUu
         CksA==
X-Gm-Message-State: AOJu0Yzb77tC/BvD4oifi38mI+9ohBIpY1nGI9XQnNkIS9AvEMQ++hf4
	s12SpdV5JZjHdNr/IrP7DcYcSkgGrwlzpzr3f+nTDM8sTs7CuFAcJ4oTgg==
X-Google-Smtp-Source: AGHT+IHavg8rbb0iXp5zES6Dr4L980A6jcKqekp47csax8jZOvNJ7yI8I4pH8Npin+uu30xpRo83DQ==
X-Received: by 2002:a05:6358:60c4:b0:1b5:a139:4d92 with SMTP id e5c5f4694b2df-1b5ebefa5b3mr401417455d.3.1724767531668;
        Tue, 27 Aug 2024 07:05:31 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-498e48f8c7esm1539433137.28.2024.08.27.07.05.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 07:05:30 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 1/2] Bluetooth: hci_sync: Introduce hci_cmd_sync_run/hci_cmd_sync_run_once
Date: Tue, 27 Aug 2024 10:05:28 -0400
Message-ID: <20240827140529.635522-1-luiz.dentz@gmail.com>
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

