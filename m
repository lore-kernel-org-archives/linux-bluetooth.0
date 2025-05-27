Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CAD139E
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 May 2025 13:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748352518; cv=none; b=W+PGylJb0eruvjAHm0y23wNStmX26TipJbwMWBGsfDyj7FfAOzihGp/AQyjZyz4PH0KrjPjySplm3gGuo5Rw+AZYTs7HK/PEj6dMF+jOMSAyGcj2VcYRNfmKCCJmqCXfS4N5KPIenE+OT4etvHmkocUOnNk4IRDfkcLwXuaOdNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748352518; c=relaxed/simple;
	bh=CTXzYwkc6I+RQFHiN5/mf11LvYvUtJc+Kn6mkcnXxQc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=qAAGWF0+eOHXiuhrIU0zOz3h7rOeJRwrCzY4dipwPkjfQHhQTCZAkbVjzcepgHS4PjaosjzzYZ5fzC+rICQEwvOB6SnK4zMJnuxI/WiZ2mchlQm+yc3kHqDJc6B5OZuv+bkE7qbFSSOdSkZoiEy1Oh1zyXEfpBktG87RxhfNVr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jDes5DPq; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDes5DPq"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-525b44b7720so884051e0c.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 May 2025 06:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748352514; x=1748957314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=mhOMgJ9EonJCKHdeLyznpf5OlCCj2uQUzr8MPidnRG4=;
        b=jDes5DPq6z3vtGyAbZeml8o9U7gy+M/DJtxAHpNsiNvzxRXsVB+zdejdUsxGsFoQsD
         lcw438796/aanqghHTyxBQJ9lbZWeXqAZnbeltVJb0vnybvPL8PeTrJETbgj2po4FEKJ
         4MGydwuEUDINm/0/icog43841ZJoYYq6LdKw6/e6slgSWm5PIiLZaxtbNxUWMTORoZur
         HEej2hxmw3wKarGLnCM+n0v1w+8o7q6SmT5EvG8l3cKZtVX1zUa0p51QCBctEq1WO7WQ
         wJPknBW2IT5tYa/mso40EBNu4OuuYpzvb9rEr+HqdCZsW4g5lLdjJiKxzy9/YjGRUt8C
         58QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748352514; x=1748957314;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mhOMgJ9EonJCKHdeLyznpf5OlCCj2uQUzr8MPidnRG4=;
        b=vJu6ch6e/HeV2FKlcmNQupqJ9tjv4dMUMp09m7ETu3YnjO3+ak1k+rP2v+q81CnAiE
         hnb95aXkIHvXzG4WaMdg4ONw8x2RrdMPyhP42ZBUr0A0ovjrWDRDCTwwNKLsim3syJCh
         N8lT4lzyXvcEzij53tvHX3nSCn38mWiusXxbBBRKtvLsdotsk4fNMFob5IhG2SYpRAos
         /wqspkyZ7cGe1wkIh5wL0adTU6jPzXNzd/YXqhYpCy0OhoyLm9vic9L9fTYWKdwz1Vgw
         RXxcpSTm0gOzGgVVQTbGHoHOc2P12OiqR5eSnS5UgDeXQUnRcO6h7ddCisAOniXzUjSH
         8owQ==
X-Gm-Message-State: AOJu0YzPFzEL/68rXMzHfGeFFePP56Icd0enUckbbldDZWSEvVY4Do2J
	k1DqdSHJvLhAtralvUfSdDf0Ht77O6w6XgRZVbeBLuqeJ/rT6j6PFo/lDnn6gudo
X-Gm-Gg: ASbGncvik4zpLjKA/UkRfY9vYRBGrfLI65K7VUwg9kgB8iRT61nDaUy+PP5MpNh4b8p
	ijf5ma6ZNea5z/nGkN8b0OtLae05ZZIrsCsYoq80ppej/xua55E7AHvfMJFSes5SQwtmKrpnhDn
	ZAIgTM8DYUEt8SCZ898QLCDKrrAToxBGW83GmLSMkSTtN+q6oPmvsHIWmX8UauCH/HzNOfcV9Zc
	TMZm56uIANjoPeAkFKwmfEwJ3SgaGS5JpgNZqkeU26m5dl/obj6kS3Na2xKgdccRRjsHp/sTPIi
	HfrEaZoExFhw4vygxI5m8gN95ZyNZvBBW7bvg+iGmArZo5Sm27K7CJw0deOgfyv+Co5nDeOqMih
	4RmjamXCarKaU/9qxLngd
X-Google-Smtp-Source: AGHT+IFsRzEkrJ202cYXlgj6EFLh7fITncyUqCbot5JZgLYjW3Y3HzZxtffOBg0gvh2JVTpyBt7TOA==
X-Received: by 2002:a05:6122:2008:b0:516:18cd:c1fc with SMTP id 71dfb90a1353d-52f2c5f0a52mr8016007e0c.8.1748352513540;
        Tue, 27 May 2025 06:28:33 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5305110d442sm2019587e0c.34.2025.05.27.06.28.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 06:28:32 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] shared/bap: Fix not handling read offset
Date: Tue, 27 May 2025 09:28:31 -0400
Message-ID: <20250527132831.232633-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Some attributes may need to handle offset other than 0 in case read long
procedure is used, so this properly handles that for PAC_SINK_CHRC_UUID
and PAC_SOURCE_CHRC_UUID.

In addition to PAC record this also uses
gatt_db_attribute_set_fixed_length for attributes that are considered of
fixed size so gatt_db can handle offset directly.

Fixes: https://github.com/bluez/bluez/issues/1294
---
 src/shared/bap.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 4bb6e08b5379..f0c6f64855c4 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -516,8 +516,15 @@ static void pacs_sink_read(struct gatt_db_attribute *attrib,
 	queue_foreach(bdb->sinks, pac_foreach, &iov);
 	queue_foreach(bdb->broadcast_sinks, pac_foreach, &iov);
 
-	gatt_db_attribute_read_result(attrib, id, 0, iov.iov_base,
-							iov.iov_len);
+	if (offset > iov.iov_len) {
+		gatt_db_attribute_read_result(attrib, id,
+						BT_ATT_ERROR_INVALID_OFFSET,
+						NULL, 0);
+		return;
+	}
+
+	gatt_db_attribute_read_result(attrib, id, 0, iov.iov_base + offset,
+							iov.iov_len - offset);
 }
 
 static void pacs_sink_loc_read(struct gatt_db_attribute *attrib,
@@ -549,8 +556,15 @@ static void pacs_source_read(struct gatt_db_attribute *attrib,
 
 	queue_foreach(bdb->sources, pac_foreach, &iov);
 
-	gatt_db_attribute_read_result(attrib, id, 0, iov.iov_base,
-							iov.iov_len);
+	if (offset > iov.iov_len) {
+		gatt_db_attribute_read_result(attrib, id,
+						BT_ATT_ERROR_INVALID_OFFSET,
+						NULL, 0);
+		return;
+	}
+
+	gatt_db_attribute_read_result(attrib, id, 0, iov.iov_base + offset,
+							iov.iov_len - offset);
 }
 
 static void pacs_source_loc_read(struct gatt_db_attribute *attrib,
@@ -627,6 +641,7 @@ static struct bt_pacs *pacs_new(struct gatt_db *db)
 					BT_GATT_CHRC_PROP_NOTIFY,
 					pacs_sink_loc_read, NULL,
 					pacs);
+	gatt_db_attribute_set_fixed_length(pacs->sink_loc, sizeof(uint32_t));
 
 	pacs->sink_loc_ccc = gatt_db_service_add_ccc(pacs->service,
 					BT_ATT_PERM_READ | BT_ATT_PERM_WRITE);
@@ -649,6 +664,7 @@ static struct bt_pacs *pacs_new(struct gatt_db *db)
 					BT_GATT_CHRC_PROP_NOTIFY,
 					pacs_source_loc_read, NULL,
 					pacs);
+	gatt_db_attribute_set_fixed_length(pacs->source_loc, sizeof(uint32_t));
 
 	pacs->source_loc_ccc = gatt_db_service_add_ccc(pacs->service,
 					BT_ATT_PERM_READ | BT_ATT_PERM_WRITE);
@@ -659,6 +675,8 @@ static struct bt_pacs *pacs_new(struct gatt_db *db)
 					BT_GATT_CHRC_PROP_READ |
 					BT_GATT_CHRC_PROP_NOTIFY,
 					pacs_context_read, NULL, pacs);
+	gatt_db_attribute_set_fixed_length(pacs->context,
+						sizeof(struct bt_pacs_context));
 
 	pacs->context_ccc = gatt_db_service_add_ccc(pacs->service,
 					BT_ATT_PERM_READ | BT_ATT_PERM_WRITE);
@@ -671,6 +689,8 @@ static struct bt_pacs *pacs_new(struct gatt_db *db)
 					BT_GATT_CHRC_PROP_NOTIFY,
 					pacs_supported_context_read, NULL,
 					pacs);
+	gatt_db_attribute_set_fixed_length(pacs->supported_context,
+						sizeof(struct bt_pacs_context));
 
 	pacs->supported_context_ccc = gatt_db_service_add_ccc(pacs->service,
 					BT_ATT_PERM_READ | BT_ATT_PERM_WRITE);
-- 
2.49.0

