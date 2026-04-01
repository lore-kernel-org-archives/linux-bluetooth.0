Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3560978F2B
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Apr 2026 14:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775053599; cv=none; b=MiFi9dIk9OIskOA8nTFsp77N3roywGWmYF/jQHGPDonZhPm+Jxt+GDDRZd8PFTkkzszfi32Z99sF4NZMOCJ0hFvoxIKIEMaYWsezxbPvY9/WrlJ8Pri8MXPKsripnLdiUiL3pk1GNJvUTcfN0lUYe5EEhWjysM6iGDJc3Cw4fY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775053599; c=relaxed/simple;
	bh=cLueYuXPRXrEtmcsRJp5N8hbm8RBUvkyXmbTAgpTJ4M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=JwTfTOUhSP/4PlX/2F7s32fRmCYXO4J9AGvFUCkJeXyMvk3gyKFtnbDgoFyieBzoec/hH1mZfl4bj62iCm1e8i2y9Awo4xK4lvK+beBE1w8EkLLQmEbD8uS2UtVfyeoS/ytpzqr3M+rsLEOK1maAE6C57azB9xDx4rAUOOLjS0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IhWT7rtg; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IhWT7rtg"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-56a8fdaddebso2842842e0c.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Apr 2026 07:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775053597; x=1775658397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=AAAT29BiVvyrPoVuH3xD+9nhk6leM/U8wh7yovvVAAw=;
        b=IhWT7rtg1BUQAVEb8bhM+RhF2JPWqjaeHlhbuz4AfpYF2okoUAgdgFxZS1zBED+Lbd
         1AvKAXiC2NcMIdGGyKTSj03aVUGxJr2qvfK8gzKNKHZ1rQYtx7oF8ubzKkV4PwQ93fyY
         wwoi/9DCzLlZCqLTWUiS8rT7VMSryRp+9wLHUafaNsMTVb3PDKHgECU+aOZltCIXq6OO
         kMXUMUDJz7q31aKCugFHtJTqvTKxDGfkVYUKMbQ6MY2nj3nc20+FGOzLsHiLinu48pNQ
         wYhp77IG5YwaHbJ8iX7GtZJz4j0CjGX+rOjJC8P5T0uGXjQKrk9RRv2tQl1Pqkvy/rVI
         gd0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775053597; x=1775658397;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AAAT29BiVvyrPoVuH3xD+9nhk6leM/U8wh7yovvVAAw=;
        b=Q90ubqSKmNChvU/WxZ2eAzRgfvY9ijj5315r3nKB+sFXhPFts+vwziyOm+gBMIFfG5
         Qs5dlwwZQWFT7Zz5UAdcuw+Sqx7RizPNKDp9NfcKd0J3TRNZO+sctJ6dRpomQ2FNQVMW
         vOJn8zz6efAnBiSgBW2qtgVNSXKMUfS1rTam4h9YfqpMfZABk1dkag38zm4hip3RVq/B
         AQyD0P5RPIQ/05Qs3YgWSUxd3ppFh+8T81b4+0O8PVLumbrr60sCJdJB8RGZrXXOT3n1
         YH2KMRR30vIKrUrhKM7mYoWR4uLW8z4d0XwlQIqOXhwVQ9g7kAlFe6F+wIervsMTdyUJ
         naqQ==
X-Gm-Message-State: AOJu0YybErWWQsQ6PEoKsS+INuV0fgtX8cltulM1LzobP1H+gM70j7oo
	6vyWt2DMWFzAI2nAthEA6M9FWpo5EzAkEZrYp2AYw1CR8772wCRB8/B4mvskafHA9t8=
X-Gm-Gg: ATEYQzzt8I9RbxVouYnnQZ/XU0J9aKehybB14CZmMvWhb0SmH3M4r91Dc469LgpdDeR
	Omgtiqr2aYLdCsnhrWteJUfvJT5qmVfgnNcvhMNnVJEjgF5JzOS/aSLkT392jmEy6V2V5GtuMF8
	3eK6IpE320F57MQHGSA1Kjn7ArvW0SUGnr0pjXarffC3xBrYWFlRoKh7IjJjuAWvcBCrKppdR5h
	v+tR/B7aeNigQV2Wojce32QBa20jAxOI44UhEw08QKZOuKlTle03S2zu8jTi1jPcgfK/vvxUK2P
	D2QwpIjMVZdkOjuue9GnZ/Li1VK+wQ1QTDyfmkywXXxZ6PFIle6/NpYgNR+s+GmToxx6T9giGDf
	UC/A+rsmgYYX/CRrS2V+TBmMah2vPqI1xfDSuZbhCuUTod13BsYNjjgnKfqOt0j18Huf+70il/F
	DO2P9hHU9N3pYLDttPVBtXEM3fuj4PVuIDsMPXCq0w7DqA66pNsjixNTg8QraW5T0afm9b+Z8YH
	uEU3vUyEI2b+YLLsw==
X-Received: by 2002:a05:6122:3b83:b0:56b:9083:4331 with SMTP id 71dfb90a1353d-56d8a97849bmr1554001e0c.12.1775053596805;
        Wed, 01 Apr 2026 07:26:36 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d88e0ac0bsm4237790e0c.12.2026.04.01.07.26.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 07:26:36 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/2] shared/gatt-server: Add bt_gatt_server_set_permissions
Date: Wed,  1 Apr 2026 10:26:26 -0400
Message-ID: <20260401142627.1944044-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds bt_gatt_server_set_permissions which can be used to
enabled/disable permission checking before operations which can be
useful on testing only environment where encryption/pairing is not
desirable/needed.
---
 src/shared/gatt-server.c | 13 +++++++++++++
 src/shared/gatt-server.h |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index 27ae7e79ed3d..6273899965c0 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -93,6 +93,7 @@ struct bt_gatt_server {
 	struct bt_att *att;
 	int ref_count;
 	uint16_t mtu;
+	bool perms;
 
 	unsigned int mtu_id;
 	unsigned int read_by_grp_type_id;
@@ -414,6 +415,9 @@ static uint8_t check_permissions(struct bt_gatt_server *server,
 	uint32_t perm;
 	int security;
 
+	if (!server->perms)
+		return 0;
+
 	perm = gatt_db_attribute_get_permissions(attr);
 
 	if (perm && mask & BT_ATT_PERM_READ && !(perm & BT_ATT_PERM_READ))
@@ -1652,6 +1656,7 @@ struct bt_gatt_server *bt_gatt_server_new(struct gatt_db *db,
 	server->db = gatt_db_ref(db);
 	server->att = bt_att_ref(att);
 	server->mtu = MAX(mtu, BT_ATT_DEFAULT_LE_MTU);
+	server->perms = true;
 	server->max_prep_queue_len = DEFAULT_MAX_PREP_QUEUE_LEN;
 	server->prep_queue = queue_new();
 	server->min_enc_size = min_enc_size;
@@ -1680,6 +1685,14 @@ struct bt_att *bt_gatt_server_get_att(struct bt_gatt_server *server)
 	return server->att;
 }
 
+void bt_gatt_server_set_permissions(struct bt_gatt_server *server, bool value)
+{
+	if (!server)
+		return;
+
+	server->perms = value;
+}
+
 struct bt_gatt_server *bt_gatt_server_ref(struct bt_gatt_server *server)
 {
 	if (!server)
diff --git a/src/shared/gatt-server.h b/src/shared/gatt-server.h
index de98a0d04747..ea49f2960d71 100644
--- a/src/shared/gatt-server.h
+++ b/src/shared/gatt-server.h
@@ -17,6 +17,8 @@ struct bt_gatt_server *bt_gatt_server_new(struct gatt_db *db,
 					uint8_t min_enc_size);
 uint16_t bt_gatt_server_get_mtu(struct bt_gatt_server *server);
 struct bt_att *bt_gatt_server_get_att(struct bt_gatt_server *server);
+void bt_gatt_server_set_permissions(struct bt_gatt_server *server,
+					bool value);
 
 struct bt_gatt_server *bt_gatt_server_ref(struct bt_gatt_server *server);
 void bt_gatt_server_unref(struct bt_gatt_server *server);
-- 
2.53.0

