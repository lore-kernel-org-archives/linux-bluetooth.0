Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7D628B3FF
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jun 2025 13:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749562957; cv=none; b=SALClFtDoKKniegFsdzIetM7RJVCxQq0hQ9PRu/UD+fzKVY0dJ6S7FBRBcBp4s7VP2s3dL+iZx+lVZzfNrUCWCglLXfV77UPdsjfYLG0o6fW1WNPUTkYBzkpDUpSRIXFSzZwJvfVVeCgwaV7v8e/bqsz/Gsw6/trlAlBGL0z9vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749562957; c=relaxed/simple;
	bh=jzJq7OZNBe6ZvbMAbwcLR1UOXODksaGPa4OFgUgBap4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=FwP4ku+GD0ZUjLrFz27Q/rGPnXYqICkvXxkvBx6TPqKpR8/moYBA3wSVjiP4NMJqax3vq9K7sVuu/qNnPgUJnQIwnEFVCXHeu693Io8+lPAqeYjP9b15t+l54VRq031DqystfBO+7o5l9GBekn4ZEs8hlFifDlcEa3DTRXsod/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GceLptFO; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GceLptFO"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-53090b347dfso1818307e0c.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jun 2025 06:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749562954; x=1750167754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=JO8pxOPwiM2ISqfvRhzjbjf9raia0npBRB53HmP1PMc=;
        b=GceLptFOsbcZAUVCdui413sQp7SiOV66m3fPWt1OJVct33VD1LLyCG+4Um6Df3zIyR
         K6wH0B5Sl8qNQ/CnD+JWWYv5CvXZlu0K1vFJDty26eJJb81LGuHUtM7+JbbHodn76Tpl
         8zotTYG7q6i8XUqt640xYkdSyKRzBtO4+VDdYyqtbfUSh9rd7Tf7fDllYlhjtgawaHAQ
         9j4NYQJ3ZuBkHWIsRlDo8nljzzNaaog2f9xsq9nDiehWhKkD2HZgRSbg2+VH4c0ZrHXU
         NfUgeU/N+fU8//8NSpZ27wyzMoD21n5o5ZMSd30WBQb3XvMiN2L0QHEVh2YMjjmd+k7z
         JiYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749562954; x=1750167754;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JO8pxOPwiM2ISqfvRhzjbjf9raia0npBRB53HmP1PMc=;
        b=pW2BzT0bmg/uORUAt1tza0QiJW5Nc4X1WIPjnSzQHhgiltjofSsuYNJrTq6EjnYLOh
         Wzdywe96Zcn/e1z7JWKbZKv50L9/nPG1fJ+uzFRRUyFDc8hx4AWhHiXHkc43oFhB7Vvp
         oRmBDZaxJuPCdNMs1xK67MSELv10LelL9lj4378qH4RTcSMM8ZqOXbcNXZArR3MgSZZ8
         hOFIg/u6pm5JIpJBFaRMghTRiYPk/sRR+D9kkrysekzYvY9VohPcC7b6mP0/XXJLvhnU
         YyhsUp7QmrsF4dxMXFDMUg48M8MSt5aYUhEGfthhIady3Y24SBd0K/3cwD+omkowEydm
         cocg==
X-Gm-Message-State: AOJu0Yw/gB5YhTK8Cy2qeLNBZCi9IBp3qXjoCGUTKVwYJP+/VFU5hweE
	+DfUw80apdqy4cTPWnJrZ7g6GQ/cBJQ6Y8itROpKd7x97iASW74bR4UY4g61cw==
X-Gm-Gg: ASbGnctXOUf7uHFMfB+TDUDZMsES3ZSujloOXTc5mqndfEdnLclYSOlr/BwEI6NHl7s
	fP1/KQcILupboKartQwfy/7HqZwwzDLPrVfgyLcGhz3KnIVGfB886bDuf00lONN/5PdTYviN1Ll
	GaA8WBdkQ8PVHhJalYIa6+0+FmFjCbaMORKouOLwu0lY1B1qEBfxduBo7isDU/8xCb90vXkOUdL
	7okm0DIj32wjvnAsKRbcm4nGK+N88A0bJQu1qJ9XyrKfU7/SuF3fwyU67Hnw2ASslXEearyndKU
	Tnd+zBOg75cWWs1JIN2kzHB0fUOdQCKyMUHqw/B1Flfw5U/DdSEIbAytWqcnqTDGpcqqbVn6mi9
	yROHPHo7uWyB6nuq/op+oW8W8PTBsgzX4/O6S+lK4lA==
X-Google-Smtp-Source: AGHT+IE4fB1VPaEi29vOBpq0HBIIzHBXReQt7OuMiNxliUBXqiEwhTrR04zCKv5qkEysX5fYjcDz3g==
X-Received: by 2002:a05:6122:470f:b0:531:1d1c:bd6f with SMTP id 71dfb90a1353d-5311d1cc4cbmr862438e0c.11.1749562954113;
        Tue, 10 Jun 2025 06:42:34 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53113bf5a9esm1298394e0c.28.2025.06.10.06.42.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 06:42:33 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: hci_sync: Fix broadcast announcement size
Date: Tue, 10 Jun 2025 09:42:31 -0400
Message-ID: <20250610134231.1021846-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The advertisement data size of broadcast announcement is always set to
the maximum rather than the actual size:

Before:

< HCI Command: LE Set Exte.. (0x08|0x0037) plen 11
        Handle: 0x01
        Operation: Complete extended advertising data (0x03)
        Fragment preference: Minimize fragmentation (0x01)
        Data length: 0xfb
        Service Data: Broadcast Audio Announcement (0x1852)
        Broadcast ID: 4734947 (0x483fe3)

After:

< HCI Command: LE Set Exte.. (0x08|0x0037) plen 11
        Handle: 0x01
        Operation: Complete extended advertising data (0x03)
        Fragment preference: Minimize fragmentation (0x01)
        Data length: 0x07
        Service Data: Broadcast Audio Announcement (0x1852)
        Broadcast ID: 4734947 (0x483fe3)

Link: https://github.com/bluez/bluez/issues/1117#issuecomment-2959262176
Fixes: b4da091fed83 ("Bluetooth: hci_sync: Fix broadcast/PA when using an existing instance")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 3d4370c7c26d..5e7eac1c3529 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1590,7 +1590,8 @@ static int hci_adv_bcast_annoucement(struct hci_dev *hdev, struct adv_info *adv)
 	get_random_bytes(bid, sizeof(bid));
 	len = eir_append_service_data(ad, 0, 0x1852, bid, sizeof(bid));
 	memcpy(ad + len, adv->adv_data, adv->adv_data_len);
-	hci_set_adv_instance_data(hdev, adv->instance, sizeof(ad), ad, 0, NULL);
+	hci_set_adv_instance_data(hdev, adv->instance, len + adv->adv_data_len,
+				  ad, 0, NULL);
 
 	return hci_update_adv_data_sync(hdev, adv->instance);
 }
-- 
2.49.0

