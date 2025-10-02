Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9024019CD1D
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Oct 2025 15:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759420750; cv=none; b=WUpm2zgW9lgU0funyEaarZHjWKDjjA153lLhugOxJfYPhjiDxJe/11lB+c15LcwY2sKypU7kdc4zpVaq9twDrIzbqcX9ez0+5v58pWhy8pQzlYAEJeGwIs1i5LMvYVWUOLkZncqQ4aEke9mIGwYjtQ5dg8/CzTp9vQlSG3ugp9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759420750; c=relaxed/simple;
	bh=f2KnvP6kJDxhLTZzxTdxDjdhqDW5mn0pilk6AZf4xjw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=mlvZT4ebHmXj88HTRNpOlxmxJEMLEBl1ASGt/LjaWQ9X1N8lu85qTTWyXWbf336fEkwy1DZKUkciYdEURLK6veQL75dgKDS5AvwkFhJBlPvX93x9Pm7AuCEIxbLfgQ1GSzBFvq7adnl9wvgfigt9VUW1j2IC8Fk/ufehJ6y2GNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJEynz23; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJEynz23"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5b59694136bso756044137.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Oct 2025 08:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759420746; x=1760025546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=nNTUCWh3SLHMAeg9AsgZALzPmYf5jE9/cDcC+7NqAXY=;
        b=cJEynz23NSHq2CemuFGFxkSjyHrEfBgD+9pTl7EfziVAPNfYZykojlXP+r1DN7m6mA
         uij6WLzJrymCJMkiK4sd7LJw7sS5KUFXSV7Yt7M3ZBbnail9uMivq+VpP3IURZ653/fF
         koGXVwy2fyIPJw1B6aMH4M59X7rlIAtmI+Whgtz54WuyHqX7mFlYGh0aTR7NdBjBw1jA
         YP48NouloIyCzrvlli0hPR3MzOfFIuxzQBhqmuMbIP7XR9S7gQ7N0nCiu7Vkc7To5+NG
         pY/jRuLIPrmaXapfcAVGidIllwGd4lNy46u2BT3KLEiX7SMv1mfA//QOuC0lo1WFtj5u
         gPoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759420747; x=1760025547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nNTUCWh3SLHMAeg9AsgZALzPmYf5jE9/cDcC+7NqAXY=;
        b=vBoy014smmDK4ACQLV+q3Zoq88P0rLY2ZT7Q3aEPQqTxfr7iW75f3cSdBo/F+gUqOl
         ycRL7eEinU5A8P0B5KRLGOHCisFPB8QmiyvoPu4QA4L8wlgBYm1g7wSTW95QXqoxiYKO
         7Tz09K3eBcUN1IDR1GvzD1pRn8HVqpLbuT9nDsU4erYBlgXeVzObbT8wz9q5PfTYuIlh
         a5RtAiQadur3by1actVis9B5O+uZOCPWw8yifGi+mzRrilum/F/YP3phDyI+OIYWnmtC
         QaKVkqNqtULiN+Ddc/UOqgvN7x2mlXVpvpmlRpDNqiP/NWXciNPBY9qzBsEwracpj6zk
         3Rjg==
X-Gm-Message-State: AOJu0YySHFppBNVvt9aAnfinyG+XpgZdYu3djjCfb1vJ+8vx7Vvsiru/
	0Zd+oYxbNlC3dqFW3R7AQsO5SeMpUtef/4C81HmjtzSLqpZNXQ31JnaFLUBJgTXq
X-Gm-Gg: ASbGncuL0cklHWgnimxnAIGE1oXlx2ImnMidiQAg3j10BRx2zoA8M3PLXhTfK4Qc9Cx
	MHsefUy3X97D0B2I12eSWIvUQBufgPcrwEVr8+C7JCZcO2WTeFLcCSzT0ls5WXob2u/7wOBgurX
	m5kzIlEkYCS645R0+iWFBmkfS5XpLSbDJIM8lQbMqdZ304OuUFzFRPQPcn9EJLp5mE6XDlZri1e
	4gdpIg32IuxNrPLUz+Ns5bGLegySiM5ZQRO+9Kz1ltQxZKTLVjTOYEQll0IQ42UFM8VEf7YIywY
	eoQ9NZVBLcN1HkMI9gGaJzsohQYGRZt4TZR2ej9kF7omzxUqJJ2BSTX5fnYLcHhtc7IwD92V6zc
	nHsJ+ekJsdt3+hM0P3fy502FFudbJ3hqaKdsKRec13pmZ+hdHUPlxXQaS26pq4E7LJc12SQrcaT
	NkZXVSPsjzINAfBQ==
X-Google-Smtp-Source: AGHT+IHFRGzPfYb69Lxi3UhNkMtH6gNTCeSf2pKH/FODNfDDNNORzUa9KvtqJAsbRW/qeHRcWKDNCA==
X-Received: by 2002:a05:6102:50a3:b0:523:fa25:9dcb with SMTP id ada2fe7eead31-5d3fe50bfdfmr3462029137.8.1759420746624;
        Thu, 02 Oct 2025 08:59:06 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5523ce69923sm578545e0c.11.2025.10.02.08.59.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 08:59:05 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 1/2] shared/bass: Fix permissions not requiring encryption
Date: Thu,  2 Oct 2025 11:58:54 -0400
Message-ID: <20251002155855.241787-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Both Broadcast Audio Scan Control Point and Broadcast Receive State do
require encryption:

https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/24670-BASS-html5/out/en/index-en.html#UUID-dd95da9a-6ac0-3f45-7e34-13fa9e04d41c
---
 src/shared/bass.c | 4 ++--
 unit/test-bass.c  | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/shared/bass.c b/src/shared/bass.c
index f65e1eadca7f..36bb9ea66523 100644
--- a/src/shared/bass.c
+++ b/src/shared/bass.c
@@ -1223,7 +1223,7 @@ static void bcast_recv_new(struct bt_bass_db *bdb, int i)
 	bt_uuid16_create(&uuid, BCAST_RECV_STATE_UUID);
 	bcast_recv_state->attr =
 		gatt_db_service_add_characteristic(bdb->service, &uuid,
-				BT_ATT_PERM_READ,
+				BT_ATT_PERM_READ | BT_ATT_PERM_READ_ENCRYPT,
 				BT_GATT_CHRC_PROP_READ |
 				BT_GATT_CHRC_PROP_NOTIFY,
 				bass_bcast_recv_state_read, NULL,
@@ -1252,7 +1252,7 @@ static void bass_new(struct bt_bass_db *bdb)
 	bdb->bcast_audio_scan_cp =
 		gatt_db_service_add_characteristic(bdb->service,
 				&uuid,
-				BT_ATT_PERM_WRITE,
+				BT_ATT_PERM_WRITE | BT_ATT_PERM_WRITE_ENCRYPT,
 				BT_GATT_CHRC_PROP_WRITE |
 				BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP,
 				NULL, bass_bcast_audio_scan_cp_write,
diff --git a/unit/test-bass.c b/unit/test-bass.c
index 89835698e0a0..8d914cffa730 100644
--- a/unit/test-bass.c
+++ b/unit/test-bass.c
@@ -653,6 +653,7 @@ static void test_server(const void *user_data)
 	att = bt_att_new(io_get_fd(io), false);
 	g_assert(att);
 
+	bt_att_set_security(att, BT_ATT_SECURITY_MEDIUM);
 	bt_att_set_debug(att, BT_ATT_DEBUG, print_debug, "bt_att:", NULL);
 
 	data->db = gatt_db_new();
-- 
2.51.0

