Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F082E3381
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Jun 2025 14:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749823491; cv=none; b=ijmug3zzDEm5i4AAaG9SdOJWYRSNXUqdA8AmfQ3LK2W1DJk8up1QFkZXqo7+f/XftbD3BCjLP3BWIXRmjrBqNhJqxtkil6C4RnxhBF/3CIwyjROQphxfH41mL2gV9O9dZWxA4NnRI8nCOO4670Wzn2o1OXb0Mo7qE4SdQOYU64I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749823491; c=relaxed/simple;
	bh=p3E4gRGNYyZblgVkLPKy4Yp2nYtTAPdoBC9YI11w59U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=WvM4Ph8+jbaKR8rhb2o99HOQ3sjW16qhjuYcFMGXisSFSa5BKG60EttrNkgKDqH5vG61vj2JBHkp2zUWHmSsnvx0vLWC5zZgAoQ/oWmkJGALTZq3lVPc/A0yyZgFNwnvlYYFivtGCwGd/Ej+AbIr3eQN+Zjy7sWe996Ickrq8HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TrEOgo1B; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TrEOgo1B"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-72c13802133so751284a34.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Jun 2025 07:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749823488; x=1750428288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dHN2W9d1jPGEyNiMXzuJx4CR+7DznW1BpYSYNVVlfc4=;
        b=TrEOgo1BL6dNOPRr+nHWMt2oD9gwTLcJ0gD7tvsCmwr6I1sHYeuNDxDAuaXh0e65KJ
         PIZ64CU0eDrcNGM/L2AjLUQ9JbdtDykzZ9Jj46no/LKy1k/2jUluOnd3/b7PYUY034Vo
         zDMde2YWDb3l2Z4VKY8raGYY9stMDB9CKR7mvcdf+nCd6If1wVKxyUZMNlr7Y82A+zLv
         uROWDc3LlM+jYncLF+5Bvlaa71XhcosIudvjZ47hN/FCLJrBDGmEoC/0IDVAdF1r2TLG
         rX0GZJZWczD8Frfg1xw/K6v507uDNvC8P2Duu4PoCPkLlzVnJKSx1Pguajlx/XwyD/2q
         +uVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749823488; x=1750428288;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dHN2W9d1jPGEyNiMXzuJx4CR+7DznW1BpYSYNVVlfc4=;
        b=Q3L3zXI/V79gbo74i6sUhPvk6Ec8iZUM9hy5u8PWMD1+NBU/2idQ6oLMQniMCECJBi
         Eq7YNNZDp944afbQVBCsJ6ysvQS2jqOEirSxkOb6o6tUXuo8q11NXp2ord1Nvdk0st4z
         ucXgLjLrNLoiQhh49BLSb+1EhxFEeb56eFRGJq3p71fjF8ItNrkwxlaGCDmwYfUI1ft0
         fnlA6wjrFSWaDZiK7Iofb9S7BjpzrNL5PwF28Ye6aryFwWCRuKoiRI01ASjfuZisrDMH
         mUayDtw6wkKUYMG/LPnfoU5gCLag+GcaFM7n9MpEmpXVJhJEufQTUBMFlBBMp+8bSqhP
         ZfsQ==
X-Gm-Message-State: AOJu0YyfkLLeJuHkXFe4pIv8ptlzgYf9MjUmPHVzfGgEKF9448s1s+SQ
	t+BQRjCJW9L4vqVlMyS4hanI4oHSUjct5LFBrdILYbMVkEzf3oz2g1yC63uGiLaRCds=
X-Gm-Gg: ASbGncu22w4ZqtzMYAxuHKPSRiAVd6fGERTbEMkslvew4llFOlXCNJoLaZ8PgZTejNr
	yqKMHfGgy1bqnjsedN/HTWdMCNnOb9NvdozNImoHZsJfkUpnUxOStmj/RdhPIIFyW7ZTeMZ42VD
	vOBbacP5xuyesdbngldY9njT/KyeBlR4Jurh8+yGG8ewmk0AuzFHv8qrHsqc+b1wGc3Uu+XiQ6s
	ml33t6ehl9UaF0mjGzqv2X5hfCPgmkqAkF6onRSlpnmc5tVUZzqxQkEHJHwasUU9RrTdoH3sOZb
	4FflD5cZKtUDmGbvaB9j9oeCEx18DhvtIPWskahK1bMXoKaHv8zzkBxydaY1bv1YOVcexYBUzg2
	k0OsPWbFZ/lq2vaVqHFMWeeaMnBLJHhcG46Vor1rJ7g==
X-Google-Smtp-Source: AGHT+IFJh/I4F/dgio5RuxREjU/0mLY3VBI7RIyB0fCdjfMhne0izqyLKe240vLDvmjNo2kEnqjXxw==
X-Received: by 2002:a05:6830:4d87:b0:735:b175:766 with SMTP id 46e09a7af769-73a2709ece8mr2140542a34.10.1749823488350;
        Fri, 13 Jun 2025 07:04:48 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87f0f9e762csm243516241.8.2025.06.13.07.04.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 07:04:47 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] shared/gatt-client: Make bt_gatt_client_read use bt_gatt_client_read_long
Date: Fri, 13 Jun 2025 10:04:45 -0400
Message-ID: <20250613140445.1997694-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes bt_gatt_client_read use bt_gatt_client_read_long since the
later does use BT_ATT_OP_READ_REQ for reading the first chunk, so they
are actually equivalent in this respect, but bt_gatt_client_read_long
detects when the data returned maybe truncated due to MTU and then
proceed to use BT_ATT_OP_READ_BLOB_REQ to read the remaining chunks
which is a disarable behavior since there is no property indicating
when an attribute would require long read procedure.
---
 src/shared/gatt-client.c | 68 ++--------------------------------------
 1 file changed, 2 insertions(+), 66 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 41a5c6f9c399..ec23415086c3 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -2686,78 +2686,14 @@ static void destroy_read_op(void *data)
 	free(op);
 }
 
-static void read_cb(uint8_t opcode, const void *pdu, uint16_t length,
-								void *user_data)
-{
-	struct request *req = user_data;
-	struct read_op *op = req->data;
-	bool success;
-	uint8_t att_ecode = 0;
-	const uint8_t *value = NULL;
-	uint16_t value_len = 0;
-
-	if (opcode == BT_ATT_OP_ERROR_RSP) {
-		success = false;
-		att_ecode = process_error(pdu, length);
-		goto done;
-	}
-
-	if (opcode != BT_ATT_OP_READ_RSP || (!pdu && length)) {
-		success = false;
-		goto done;
-	}
-
-	success = true;
-	value_len = length;
-	if (value_len)
-		value = pdu;
-
-done:
-	if (op->callback)
-		op->callback(success, att_ecode, value, length, op->user_data);
-}
-
 unsigned int bt_gatt_client_read_value(struct bt_gatt_client *client,
 					uint16_t value_handle,
 					bt_gatt_client_read_callback_t callback,
 					void *user_data,
 					bt_gatt_client_destroy_func_t destroy)
 {
-	struct request *req;
-	struct read_op *op;
-	uint8_t pdu[2];
-
-	if (!client)
-		return 0;
-
-	op = new0(struct read_op, 1);
-
-	req = request_create(client);
-	if (!req) {
-		free(op);
-		return 0;
-	}
-
-	op->callback = callback;
-	op->user_data = user_data;
-	op->destroy = destroy;
-
-	req->data = op;
-	req->destroy = destroy_read_op;
-
-	put_le16(value_handle, pdu);
-
-	req->att_id = bt_att_send(client->att, BT_ATT_OP_READ_REQ,
-							pdu, sizeof(pdu),
-							read_cb, req,
-							request_unref);
-	if (!req->att_id) {
-		op->destroy = NULL;
-		request_unref(req);
-		return 0;
-	}
-
-	return req->id;
+	return bt_gatt_client_read_long_value(client, value_handle, 0, callback,
+						user_data, destroy);
 }
 
 static void read_multiple_cb(uint8_t opcode, const void *pdu, uint16_t length,
-- 
2.49.0

