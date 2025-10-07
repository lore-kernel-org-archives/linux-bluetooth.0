Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A691A58D
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Oct 2025 14:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759848588; cv=none; b=pVB0ggmC11Yvck+EhSJVNZ6rq8TBnaMDFXXVpCytEFOm3+utuPqsN1A0LFKgoITAV3yP4eZ30AZo91S743eY08Zo90aXwfxfyZAlb06sIckJesHYZCfdQ/aKxNmZ46u3dGnEzP+8wSPEPzIaGv/vdfBwnmLeLhE4Po6+PUfd8EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759848588; c=relaxed/simple;
	bh=BquCFfq7uOWbSG/G1lJaNvYAz/zW5IYi2LUZhBCG6ns=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mjvRWpEsF4RGfgKmjnZoV50SpSfGbJ3kmKF0WC5yJY2OzY5AhILoTT00jYAhFGczNc2JviadccRDlSDRzTR457rIb0n2Gcio5N+YrqMXKEQT3ezd6UEdKN/vVp4WUzcIQlPo2Jphin1s+qjskZRcsgXhHlmZnZN44ceuvDptVUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+M6YUuB; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+M6YUuB"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-54a86cc950dso1018218e0c.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Oct 2025 07:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759848584; x=1760453384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yFZ/dZGY3W4K0m0eKwmb4Sa9B6xoAJjJc2FgTgcc0Z0=;
        b=j+M6YUuB2OjdAzL3e8c0W8rTmjAe0cV7vx6U2hXvJi8UjSxFi2WGZRaNMgw1s9hda1
         0FWghgklgRF6ju2b3vJlzedZnug8HPzFW/iB+9CLsnuJKIeNpbwAnU/flLfWS0svi/+y
         LG1+cLY+LWeFU5bDrg8lO/0EkAiCk6CeH0Xpgt1k6b+kmqB30TI3XzV/L5rkVN6aCZLh
         SpQo+bmB6iBj6qSb+25end7RZpjndVxpPeKSj5jQ3ek2Cn4tPqTjcJNtZndWjsgA2BPG
         68e9hERE5idSxbknQv4qrSA9zx2Q/4N2etmhH6B4i6FXDuPRC45w8fLb/qvOIP3MU3iL
         FN2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759848584; x=1760453384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yFZ/dZGY3W4K0m0eKwmb4Sa9B6xoAJjJc2FgTgcc0Z0=;
        b=n81xX5pCimGT9hQY+ud1qqwzXpIiSMcHV3FT/xQiq/hScbh9ilq7xorxqGItJbfiRR
         wMG56dhW/KpHTI737KV8T7KBlAPzCAO6IdKsFcYlyGZgL8iPxB2yBmey/SLeVVEtqBKl
         iVQoSWiZIb1igNO70LUCSLM5LkGh/IBGANuO61+NUF2U/5S3oRfwJ0zQDxKpuFK1ymi7
         CZ1O5vmFRLdJFtpaBrMr2nCGd1ADu1Lryq1p+p6VND/QCsp67TUAJuGvolKZZ3Hg0NlC
         JLw3o6bk8BD8vvvk2sqLnR0KHOIQ54JSsfhamSWlLGIySYTbDTazG9bgE8iXARhng/NV
         al2g==
X-Gm-Message-State: AOJu0YwTXD6KwT7mW9vACBEN7ODFoarxBkFpsQvqdITiNobt39itZFPP
	gxSyw9kW45bTUi8nnhsrGc+hn30d3r4TnzXHF1sEC3o4pkL+u4WjOjHWOLBXUA==
X-Gm-Gg: ASbGncsN4uN2oD1V1prtrfvYRf4vPb9/rBECQ3sE9Ii+PK7qCnksrA45h+nPUXv+2lW
	BCDCFjd8DJ9pRzBTlSu4qRfys7G7k8jdpJSZeMygRij6WibdVZCv2imRT+MvL889K6f5q+71Fii
	k1O97DUEbf+XciJTjsAWh9vAOVg+2sJRot3t0MxnqPi52sk5KoE4ilBUvnFzumllpjbVo2dNJm+
	qjZm45UigdY/SYmGaba/l/865+ySD7D23Bz1LgPyoT2z6xQAjZLJS7zcwtnebFz7G87RmdNAtYD
	MSBg71/KrS6hdGJYht+a2iCRce5enqRsooFtJggMAmBrKbyC1AHD0kW3osQ4oeh0Fa+WGNK+VXW
	WtlmJgO2bW8Zf8OEja7YbLnpWVI58peDBKUKyrfUhNyBdJ7XghKyRTsOGEDb12WRhaq8P+2PwUC
	QZS4XZjXgTJ4mEMg==
X-Google-Smtp-Source: AGHT+IH+aelN6XxvYTb/hqjHVPmmw1LuBzeOgMI1RP7FuIWJtNzSmWt66lUi0KcfP/2f2oj8ncBgKw==
X-Received: by 2002:a05:6122:1781:b0:54a:9e47:7624 with SMTP id 71dfb90a1353d-5524ea910damr6361680e0c.14.1759848584080;
        Tue, 07 Oct 2025 07:49:44 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5523ce64af0sm3731864e0c.8.2025.10.07.07.49.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 07:49:42 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/7] Bluetooth: hci_core: Introduce HCI_CONN_FLAG_PAST
Date: Tue,  7 Oct 2025 10:49:25 -0400
Message-ID: <20251007144930.1378274-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007144930.1378274-1-luiz.dentz@gmail.com>
References: <20251007144930.1378274-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This introduces a new device flag so userspace can indicate if it
wants to enable PAST Receiver for a specific device.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_sync.c         | 55 +++++++++++++++++++++++++++++++-
 2 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 894e01717b55..2a765a0521b4 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -166,6 +166,7 @@ enum hci_conn_flags {
 	HCI_CONN_FLAG_REMOTE_WAKEUP = BIT(0),
 	HCI_CONN_FLAG_DEVICE_PRIVACY = BIT(1),
 	HCI_CONN_FLAG_ADDRESS_RESOLUTION = BIT(2),
+	HCI_CONN_FLAG_PAST = BIT(3),
 };
 typedef u8 hci_conn_flags_t;
 
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 277b2c096195..5051413f1a97 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4324,6 +4324,10 @@ static int hci_le_set_event_mask_sync(struct hci_dev *hdev)
 	if (ll_privacy_capable(hdev))
 		hdev->conn_flags |= HCI_CONN_FLAG_ADDRESS_RESOLUTION;
 
+	/* Mark PAST if supported */
+	if (past_capable(hdev))
+		hdev->conn_flags |= HCI_CONN_FLAG_PAST;
+
 	/* If the controller supports Extended Scanner Filter
 	 * Policies, enable the corresponding event.
 	 */
@@ -7024,10 +7028,41 @@ static void create_pa_complete(struct hci_dev *hdev, void *data, int err)
 	hci_dev_unlock(hdev);
 }
 
+static int hci_le_past_params_sync(struct hci_dev *hdev, struct hci_conn *conn,
+				   struct hci_conn *acl, struct bt_iso_qos *qos)
+{
+	struct hci_cp_le_past_params cp;
+	int err;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.handle = cpu_to_le16(acl->handle);
+	/* An HCI_LE_Periodic_Advertising_Sync_Transfer_Received event is sent
+	 * to the Host. HCI_LE_Periodic_Advertising_Report events will be
+	 * enabled with duplicate filtering enabled.
+	 */
+	cp.mode = 0x03;
+	cp.skip = cpu_to_le16(qos->bcast.skip);
+	cp.sync_timeout = cpu_to_le16(qos->bcast.sync_timeout);
+	cp.cte_type = qos->bcast.sync_cte_type;
+
+	/* HCI_LE_PAST_PARAMS command returns a command complete event so it
+	 * cannot wait for HCI_EV_LE_PAST_RECEIVED.
+	 */
+	err = __hci_cmd_sync_status(hdev, HCI_OP_LE_PAST_PARAMS,
+				    sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+	if (err)
+		return err;
+
+	/* Wait for HCI_EV_LE_PAST_RECEIVED event */
+	return __hci_cmd_sync_status_sk(hdev, HCI_OP_NOP, 0, NULL,
+					HCI_EV_LE_PAST_RECEIVED,
+					conn->conn_timeout, NULL);
+}
+
 static int hci_le_pa_create_sync(struct hci_dev *hdev, void *data)
 {
 	struct hci_cp_le_pa_create_sync cp;
-	struct hci_conn *conn = data;
+	struct hci_conn *conn = data, *le;
 	struct bt_iso_qos *qos = &conn->iso_qos;
 	int err;
 
@@ -7059,6 +7094,24 @@ static int hci_le_pa_create_sync(struct hci_dev *hdev, void *data)
 
 	hci_update_passive_scan_sync(hdev);
 
+	/* Check if PAST is possible:
+	 *
+	 * 1. Check if an ACL connection with the destination address exists
+	 * 2. Check if that HCI_CONN_FLAG_PAST has been set which indicates that
+	 *    user really intended to use PAST.
+	 */
+	le = hci_conn_hash_lookup_le(hdev, &conn->dst, conn->dst_type);
+	if (le) {
+		struct hci_conn_params *params;
+
+		params = hci_conn_params_lookup(hdev, &le->dst, le->dst_type);
+		if (params && params->flags & HCI_CONN_FLAG_PAST) {
+			err = hci_le_past_params_sync(hdev, conn, le, qos);
+			if (!err)
+				goto done;
+		}
+	}
+
 	/* SID has not been set listen for HCI_EV_LE_EXT_ADV_REPORT to update
 	 * it.
 	 */
-- 
2.51.0

