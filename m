Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4C62D0283
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Jun 2025 18:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749752130; cv=none; b=F+MWdEPvQ7iQ15S50bcnXousDGlVpWHbgkuUUEziNAJ7XGKZpxXatjgYj709GhacN4UsWDknUJIek3Q62iY284ILvdw3huyksKM9CP53Z0J6psVO5MFRBYZDQFTxh9FlhM1HVirOp73H5lfho3HzW3tt/tMkrhVABRe+5a97d7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749752130; c=relaxed/simple;
	bh=Vt+sRf2AB4A7mgWenoHwgg3XTgXFXOzAqgsqBA2vwaE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=EjPQKHurYwg0Gf0xglpRhBjiIEPYl0WqNQabqYHXBTbNxtXa7IrTIToSebpvKLubOpTZYo83PpiTF798w42AU0YgPwhObfKK8eOgjag5CwAVvtvMa6C0FDpXlV0eKDv9Us1NaWa89EkfP1w9bBrtu8Jg+voMAJk0Fv0AKexOT2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q3yo4ZJO; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3yo4ZJO"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5313a2566f9so87339e0c.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Jun 2025 11:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749752127; x=1750356927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Juza+R5qccjMOLvJSMBiRhxUoU4W1M0AOjnKd0FMaIg=;
        b=Q3yo4ZJOpPptV72uKbE64fPjQuQsMaGHrVwT/WWotJhYCADq36cxqTvAgRviOv7FE8
         MUIgq/PX8h0I8p0p1kIMZMvwycop7cQZyC/NvvWhgKEjk2oIc2Mpv1MayXn+6+JTo7S5
         mf7ts5IynXEbUNjY+ldUfbf/WAoF6pMZ00zaWmz+hWKOkl/OpBLONai29e7Qwj0N+N/r
         48Yst0GWwnNe16FR0iYbzw3ym0eo8X6IaLwSoenbW9WzZ0NUcPLzcPg4uaBv9xjTCa1i
         Pt15zcd6b6ulNSblcd9Xlo6xG+R6+qBXJ3N20VfSIs+NcxD6CtDFv+xH+9e0tXrdVC98
         ozhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749752127; x=1750356927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Juza+R5qccjMOLvJSMBiRhxUoU4W1M0AOjnKd0FMaIg=;
        b=N3HSYDgdqriUR2E18TrT2YcUnggKG7DoJn7o4MjeTVgojfy1TpUU9wETHsYhNY29Jy
         TK2HTZ2Kvh5fVMtl1styTJtRHKACzkooFOvyI0OXm8D2B+UtNvYKFbOun9Ot5ZJD5WVE
         BY+rvmZw4/MGoXs8m33xc6i6fJWZGFNq5jtWVBPl4coeCGQyRKN6eLqvQgrQZeuxFxnM
         fUow2gG7EP+wpfNXc/cPqgD12r81RgDe8UrNEqIXZEsuTN+AGVJQ56TJSEtVZafdfX7r
         VU1ETXTYTYZ68h9xXv5kpx9eqarhHM1UCXCa0lUgO4hvHbCCPznh1FPzgnZ96DEZftSJ
         hRCA==
X-Gm-Message-State: AOJu0YxGOS0EghM+HiWxtDnSOLlaH3H2s01aMdK9Xs2dSPeLvOqQZVy8
	uryl5cfy4rwTGLQqBokpbCZd7OzUUSWwvSxxscPT8jXidGKDk41e2rbM0yWRKWl3
X-Gm-Gg: ASbGncsldCbArp53xGHX++nteH/8ASQvHtTp025GlExxaAp7ONZ4Wn29p2fXppmcxH0
	HUoP9tmByFc+NDZLGdz/S60680BjVshC7DQKlTsnREvz/LltsaguA5uUq77vFrxAx2axLASAII/
	2qdUOqf+RjNDHBZko/T7V8rEBq0bteeAFRzM/RAEPI8ucD6F1+71dJ0ubKT91lHOnf4FtcdWlM3
	63LKQGGCUJaU/hp4nEJbZHTHpk4mIDhKnWUUdB9k2gZNx/d99lWtA6MwME07Hjovnff0l/nJwC4
	xRfogAaJ+ttNjbzWM/l0A2NFbBqabvbpM/tR9rLe49s76OiQhQ0N5+Wyh1Wlw7OggAtmGT9B8+f
	lacnmcqzRhJlEnuNLY3RL5KZb+dUoV4U=
X-Google-Smtp-Source: AGHT+IEx5nxv6ZTLqKXCFC0V7jJaimANcYdFK849iIJnsJ7H2RLs0O7qYfDdS5kN7ez1jr6Vj9SRdQ==
X-Received: by 2002:a05:6122:c91:b0:531:14c4:f695 with SMTP id 71dfb90a1353d-53121f33752mr8020781e0c.0.1749752127253;
        Thu, 12 Jun 2025 11:15:27 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87f0126e038sm378207241.14.2025.06.12.11.15.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 11:15:25 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] shared/bap: Use read long procedure with PAC Sink/Source
Date: Thu, 12 Jun 2025 14:15:24 -0400
Message-ID: <20250612181524.1812431-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Since the PAC records is not of a fixed size and can spam into more data
than it fits in a single MTU it shall be read with
bt_gatt_client_read_long_value otherwise the record maybe truncated.
---
 src/shared/bap.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 1c15a4ecb3f7..4827f77408ef 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -4784,7 +4784,8 @@ static void read_source_pac_loc(bool success, uint8_t att_ecode,
 		if (gatt_db_attribute_get_char_data(pacs->source,
 						NULL, &value_handle,
 						NULL, NULL, NULL))
-			bt_gatt_client_read_value(bap->client, value_handle,
+			bt_gatt_client_read_long_value(bap->client,
+							value_handle, 0,
 							read_source_pac, bap,
 							NULL);
 	}
@@ -4817,7 +4818,8 @@ static void read_sink_pac_loc(bool success, uint8_t att_ecode,
 		if (gatt_db_attribute_get_char_data(pacs->sink,
 						NULL, &value_handle,
 						NULL, NULL, NULL))
-			bt_gatt_client_read_value(bap->client, value_handle,
+			bt_gatt_client_read_long_value(bap->client,
+							value_handle, 0,
 							read_sink_pac, bap,
 							NULL);
 	}
@@ -4897,7 +4899,7 @@ static void foreach_pacs_char(struct gatt_db_attribute *attr, void *user_data)
 		if (!pacs->sink)
 			pacs->sink = attr;
 
-		bt_gatt_client_read_value(bap->client, value_handle,
+		bt_gatt_client_read_long_value(bap->client, value_handle, 0,
 						read_sink_pac, bap, NULL);
 	}
 
@@ -4911,7 +4913,7 @@ static void foreach_pacs_char(struct gatt_db_attribute *attr, void *user_data)
 		if (!pacs->source)
 			pacs->source = attr;
 
-		bt_gatt_client_read_value(bap->client, value_handle,
+		bt_gatt_client_read_long_value(bap->client, value_handle, 0,
 						read_source_pac, bap, NULL);
 	}
 
@@ -5515,8 +5517,8 @@ clone:
 			if (gatt_db_attribute_get_char_data(pacs->sink,
 							NULL, &value_handle,
 							NULL, NULL, NULL)) {
-				bt_gatt_client_read_value(bap->client,
-							value_handle,
+				bt_gatt_client_read_long_value(bap->client,
+							value_handle, 0,
 							read_sink_pac,
 							bap, NULL);
 			}
@@ -5539,8 +5541,8 @@ clone:
 			if (gatt_db_attribute_get_char_data(pacs->source,
 							NULL, &value_handle,
 							NULL, NULL, NULL)) {
-				bt_gatt_client_read_value(bap->client,
-							value_handle,
+				bt_gatt_client_read_long_value(bap->client,
+							value_handle, 0,
 							read_source_pac,
 							bap, NULL);
 			}
-- 
2.49.0

