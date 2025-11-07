Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066F118E1F
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Nov 2025 20:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762546721; cv=none; b=QJetSS3Jpm+C09xdE+ai/ARixOiMRGd34sxxY0GTjql/My0NVtUudpkTLDO3zjwN1uZwFsZ4a9jUxTEtjx3qLV2Ga8xSJBwb5njh2oCmDFaQ7m/fO35oTHjfTZ3p92d4ryG3oyju59iQvEIQXCXonaFcEpPJcbcyp9SBDYfc75Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762546721; c=relaxed/simple;
	bh=H9Nk1lvZc1BpxzyOBvEsiwj3XTJK1RV4pY7IfWNPF3w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=cco2UDE/KzZ39sc8SLMPsp8jVNwEugbHTgFSUHgLNCw2d8TdodrL0ov1uWbkC5QXDZl+iirs2rin02JiQJGo2O4CUnuNl/e1LjJG0Ch2DSxVxQ/Xx2xtT7SxEV77UNoXEBe/dDeggIs16ZjRVjtwiytsOIJD+Wwj2v8SwEtJJG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZoJAB1ph; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZoJAB1ph"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-557a56aa93fso315648e0c.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Nov 2025 12:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762546718; x=1763151518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vIT87krLzz+Yjm/qoNRoHJr7KDUYNnow0uticwpqvxc=;
        b=ZoJAB1phUOgWH8ZiMYrcixCmr3OQz+S5rqxvzso0Q3vZQdtsZWQYGEHsHkjPmAr6BB
         qsXpIPfu639FWSEWgjybbczxxaZToA3etrttrhyQ4K5CMru7xYOCu787a/NJKbxyzXIT
         DEroSbX1BZ/LTSaJk1LeaywXU0/7igmB+m0aCnG61DzPmUIWbGaRGqq8InsipYvgY/8S
         6LwPkdHh5h8xiYNHWVHz+grVqn27iPq7XVvjfNA/RHrXc08IVuPKo1SajpdvpLe+QTej
         n8ZeZu54XHWECRvfoi3AgBv1knFskdPQLBcw1l/KS7tm4/PDzRHcpdKaIhzRQiGr5Rlo
         TAng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762546718; x=1763151518;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vIT87krLzz+Yjm/qoNRoHJr7KDUYNnow0uticwpqvxc=;
        b=RYnrsDjSmcp6HM0uzF0zZNmiqpbBCg48lZ8Mdv4VEZlQBQpsh8jQHOz+Cjbk1UQMTq
         5Nl9Q4rTzn0GU6gOFjq1/ZF6iG7lR62NuTMIoWBhyGYgEZt3CTBZXuv02YA6z7rQWrT4
         90ZdSu3EfCcCFC1f9ZTlwJKVNbPtEKNF9eZlluZr+cEoN8KHRtsM3tv3LidHw5xCm2l3
         F/qFdjOPZR7aNACsdkP1F5fBlUMjONTgGn8L/2347qufosqMUPrwJElFidLh9nDPqGx0
         3YMUJZG/v47TDDZIKlZ29t7B9u9JOMtJ7G9HKqbi+0VFcdWCoD/cMsmLJvYSD7DfRZce
         X7WA==
X-Gm-Message-State: AOJu0Yw3KoZyW5C8spCghmRwPk4zprBvPOwwpkln0zosYLi2iep/Tq/9
	1EJ1CU2v7smnL5lHnyg952jm5R5oCG/PThMg2Pl6CjcuuPqgPBPhoRCXZ+It3g==
X-Gm-Gg: ASbGncvTQaJ/QGvtG0vocjA4u//pFLjdF8/AM0mTiNxfv6OJEfPNBoAqu+aYNi5m26l
	1hwDqCMo0p40wpzdIWZejx5fhJIJ+zoCRETepMumZSYZYy+hOnmk57Vdz7y60wNKOEWx4J53ivU
	N7gU7s7YTzWBsIsmzcOuku9ymkwyvBiVk41KFmxjquyy9EjKIR2gfK5fx1Kcbc9jKb+8nLRTe9K
	yl/7qe/I8d6xAimF4T8QxTj/8t1g4HUv2VB6Aj4RIUsUMPyxrIQoVvhGVvwNWighKeI7+v+RgRp
	xl3EV8JDIVMvRkX02SiYY8J9nch/ME6voplsYgzw4KHXc/yx0vUcOky9SRokMjR7gzzKB/gyPlZ
	KsEusWpyoju4jkWewSvfWL4Zy5H007HWakA1G1z5MPIzgXcnyNgTcV1zDiO6DP4eOi17FhIzWbF
	8xYMkOMGRKWGftug==
X-Google-Smtp-Source: AGHT+IF8BKA2dYDOBdzFr4dTye2y1PaAfIv8u27nuToogmURGh0bn6xyoy3Xsz6dAsYqkDdUdPay6A==
X-Received: by 2002:a05:6122:4687:b0:559:6e78:a43a with SMTP id 71dfb90a1353d-559b328ca8fmr387783e0c.9.1762546717642;
        Fri, 07 Nov 2025 12:18:37 -0800 (PST)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5599582860asm3562921e0c.16.2025.11.07.12.18.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 12:18:36 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 1/5] emulator: Generate PA Sync Lost
Date: Fri,  7 Nov 2025 15:18:23 -0500
Message-ID: <20251107201827.1235953-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This attempts to generate a PA Sync Lost whenever a PA is disabled and
there is a remote synced to it.
---
 emulator/btdev.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 839b4941ca05..5632a822240a 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -116,10 +116,12 @@ struct le_ext_adv {
 
 struct le_per_adv {
 	struct btdev *dev;
+	struct btdev *remote;
 	uint8_t addr_type;
 	uint8_t addr[6];
 	uint8_t sid;
 	uint16_t sync_handle;
+	struct queue *syncs;
 };
 
 struct le_big {
@@ -5514,6 +5516,7 @@ static void le_pa_sync_estabilished(struct btdev *dev, struct btdev *remote,
 		sync_handle++;
 
 	per_adv->sync_handle = sync_handle;
+	per_adv->remote = remote;
 
 	ev.handle = cpu_to_le16(per_adv->sync_handle);
 	ev.sid = per_adv->sid;
@@ -5527,6 +5530,24 @@ static void le_pa_sync_estabilished(struct btdev *dev, struct btdev *remote,
 	send_pa(dev, remote, 0, per_adv->sync_handle);
 }
 
+static void le_pa_sync_lost(struct le_per_adv *pa)
+{
+	struct bt_hci_evt_le_per_sync_lost ev;
+
+	memset(&ev, 0, sizeof(ev));
+	ev.handle = cpu_to_le16(pa->sync_handle);
+	le_meta_event(pa->dev, BT_HCI_EVT_LE_PA_SYNC_LOST, &ev, sizeof(ev));
+	free(pa);
+}
+
+static bool match_remote(const void *data, const void *match_data)
+{
+	const struct le_per_adv *pa = data;
+	const struct btdev *remote = match_data;
+
+	return pa->remote == remote;
+}
+
 static int cmd_set_pa_enable(struct btdev *dev, const void *data, uint8_t len)
 {
 	const struct bt_hci_cmd_le_set_pa_enable *cmd = data;
@@ -5549,11 +5570,19 @@ static int cmd_set_pa_enable(struct btdev *dev, const void *data, uint8_t len)
 		if (!remote || remote == dev)
 			continue;
 
-		if (remote->le_scan_enable &&
+		if (dev->le_scan_enable &&
 			queue_find(remote->le_per_adv, match_sync_handle,
 			UINT_TO_PTR(INV_HANDLE)))
 			le_pa_sync_estabilished(remote, dev,
 							BT_HCI_ERR_SUCCESS);
+		else if (!dev->le_pa_enable) {
+			struct le_per_adv *pa;
+
+			pa = queue_remove_if(remote->le_per_adv, match_remote,
+						dev);
+			if (pa)
+				le_pa_sync_lost(pa);
+		}
 	}
 
 	return 0;
-- 
2.51.1

