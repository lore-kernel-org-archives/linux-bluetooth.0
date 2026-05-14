Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF15F3A48CE
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2026 19:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778785566; cv=none; b=ZtsmLxGB1Nvggu8toFaYtfBNnJrfI9L14MBCA9ouiloGlKbpLnWb6UpXwDdID436iXkazbClqZqatIAwV2unvbf674uqNDPuwmL1VXVZrdwQfA1z/PG29FJvQVPH+KURkbE9E868lrTjqdO689OEFs2X3fukvaCzqOBJu6oL1sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778785566; c=relaxed/simple;
	bh=Y3eJMsdq7S7arZzVbBoB6JyloHzdGeFLzZCHj16jStA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LZvvt+0JN6ywHKSqm+994RzZILo5DCXA7hvQPDTpcmrK4d/1V646SfHOglRXxXvzLLo5Mj+MnfhAsH6lkaWzx4fCwOMSsxzbdXah9wnUgmA8DWCwIJKGIBFBEqsh8eq9iRFuoJ53+5k7qp5QJjjWXx8TByCWgFcxG2CvVFjCU7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBaqsJz0; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBaqsJz0"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5752b279662so2847259e0c.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2026 12:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778785564; x=1779390364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=lLWFrHIvY5p5SonWK6gQ+iW8Tw9QCkaPEc8+GRuLxi4=;
        b=eBaqsJz0MjrBSTI0ZJg9atL7/ksTg5ivXshoHM7yKCgKZtmSA6B9avy23r6O2OnpU0
         0RSOmx7kzEG9XZ4LAGbulEUq6FZgn4w2zJ+qy/IU6WAPwNgm01ulPwDWnyyq+7iS0ey0
         Qwzvfo11UW7YwsfsrdT8MSKNKinvHhS28qRLyILusXDxSpaglJ2Aqy9hrSi2PIqHXWLM
         U+HapQ4/AOoHyfHoe/h4z3KiG8SEWVcVMh5GsRa3v/tFSHzk28LL+406y+NWFNGGJLeU
         7cjLNolHcghiKxhphTlOPpb2GmANKBtHmVhpmjMmRUmj5aiZSP2RYVGZR42L+B3DvWiW
         40dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778785564; x=1779390364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lLWFrHIvY5p5SonWK6gQ+iW8Tw9QCkaPEc8+GRuLxi4=;
        b=BC5fpvyGzDSjH21LsXb+tg2hiRTwxtREmZF8dmvXUCkvYxKW6r9cCKXec6D4jQquhQ
         x7B+GQRcdEKTyzJW+Raq6RgGKHm8xneBsP9rzM9G95XGckU5yWusUIjitqWSDs1dftvF
         Wf5ADCBrZboZFiOkILlCB/EKVy+EecdR4jdTuIzQDpdsQhapba4/flJLW4Qs6dvF2pz9
         w7sND6CrTHVrLqd1mNsvI0R87OKikVQ0+SMIYh1Y1+o1yD6PTgmJZDawLMImu5RR/GIL
         kWaWR+kjP49tJWKCV8dq6zNZv0pr/YPRNEFnCiQtOEps+af2Ui7N7PLnljh7PuxO6bwB
         E51g==
X-Gm-Message-State: AOJu0Yx070+Q7bdtZMWAzGa+bIzU5Crlb1i9wQY/7ZRIkXfG9K7PzXhR
	hiEyJTUkEzSe+GByRlz2NuDDMAFtA7nGJUPgDfjuEmlsYTRPZAbRNmjxjsQziB2TPDw=
X-Gm-Gg: Acq92OF4UyS4RRsyQOfZPPv0N55WSA4HEV0pRNYELpRuAdMJbd1nwyBa36Vos8RNS7Z
	bYzF8d/PEvmNyYb6FYlabR2Gs06Z0z9FVoDm9VzmCRXokWCv4Lm0fdWFNID871HSj8Qt/5COziL
	Y1MYzaBSVsJgvsNvipTXF8BZ9ZVNfoK8jSG+pUfcW1Bu9+y07sqChSscF7EkSGh9oGDWm88gw2X
	TtDW4wPZmvFQn02+4GZJp0Ys7sROYbsgTpIrtyrEzCpnjoT8nMjP9GEbSMCIWusQovCLdIzpHrN
	LKnPjR6HzPXCUC2hCLRdqNIRKSNH1BaHUFUNXdAWDr6vRK5UH/4pEx1KnTdAJHGzUoNgaMA7hez
	Rhod75y4aiQq8haQurnyvlykI/bgeBlnfi3ShCu+G+BuRPYZQn1E1oNYfpcP/uvV5BWfkRd68Sf
	Ogv/sTwyEnjSCChhyxUgD69sOTQCEvVs5nZxReaI9FQIrISibOqtZi4IaZV576vI3jcGatohLmn
	1bNx1HZVWNYsZY8r9ab7GxAGtYK
X-Received: by 2002:a05:6122:82a1:b0:575:24b5:88e7 with SMTP id 71dfb90a1353d-5760c0b53c9mr491935e0c.11.1778785563911;
        Thu, 14 May 2026 12:06:03 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-575fa2c3040sm1860545e0c.4.2026.05.14.12.06.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 12:06:03 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2] test-rap: Fix gatt_ccc_read_cb on big-endian
Date: Thu, 14 May 2026 15:05:53 -0400
Message-ID: <20260514190554.1569879-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Reading CCC values shall return little-endian 16 bits, not native
format.
---
 unit/test-rap.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/unit/test-rap.c b/unit/test-rap.c
index 4ca4a715edff..22bc2671bf46 100644
--- a/unit/test-rap.c
+++ b/unit/test-rap.c
@@ -253,8 +253,7 @@ static void gatt_ccc_read_cb(struct gatt_db_attribute *attrib,
 	struct ccc_state *ccc;
 	uint16_t handle;
 	uint8_t ecode = 0;
-	const uint8_t *value = NULL;
-	size_t len = 0;
+	uint16_t value = 0;
 
 	handle = gatt_db_attribute_get_handle(attrib);
 
@@ -264,11 +263,11 @@ static void gatt_ccc_read_cb(struct gatt_db_attribute *attrib,
 		goto done;
 	}
 
-	len = sizeof(ccc->value);
-	value = (void *) &ccc->value;
+	value = cpu_to_le16(ccc->value);
 
 done:
-	gatt_db_attribute_read_result(attrib, id, ecode, value, len);
+	gatt_db_attribute_read_result(attrib, id, ecode, (void *)&value,
+							sizeof(value));
 }
 
 static void ras_attached(struct bt_rap *rap, void *user_data)
@@ -528,7 +527,7 @@ static void test_server(const void *user_data)
 	RAS_FIND_INFO
 
 /*
- * RAS/SR/RCO/BV-01-C – Characteristic Read: RAS Features
+ * RAS/SR/RCO/BV-01-C Characteristic Read: RAS Features
  *
  *  ATT: Read Request (0x0a) len 2
  *       Handle: 0x0003 (RAS Features value handle)
-- 
2.53.0

