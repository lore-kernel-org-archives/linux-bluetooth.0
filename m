Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A01140E5C
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Aug 2024 09:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722504621; cv=none; b=l19Z0ViEiQ0t7DlaxEWy9aMCroFty4XoGefLjbzUV9k95oz7JLCPI+pTe1qsHInPVCWf810jxJOtOwM+Z2l1a6WfhBKeSS30J/cK/DDchdf9+oRMZ9GiGZSKq8km+DWEUnBbQaL2T71TUXX1xSvac/hEcvEs5/gJV/RNTg4PB3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722504621; c=relaxed/simple;
	bh=3snvf2e+2K6J5R9ge8bcfISgwLR9rNlPkUnqqSJJW1k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=kA+v7jO9aeN9TYgVbzuE9JfM1ykP5yJwBAvqOteOoIh5ILFRKc07mPfoXRpLGUztUQnZpX08gWR21dGQr2UMFtHnURZ+tJx6pJu6iytOeYVUEooVQ7Jee4omUIJObbJUZrXtpPLixG4RQ+j90t/BTUGV4qEgRqLOorI0eanRK8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XtmGH0DD; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XtmGH0DD"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7a843bef98so713107366b.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Aug 2024 02:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722504617; x=1723109417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=oDWTVtCG3rDT5LZakIAVsZ/rxWFZd0GiPuUMNJdErBw=;
        b=XtmGH0DDM+WTYwjPm76zgNSltQswq0NYNACn0MJxy2TeWITGFNT2Y1p+asmTqcH142
         rSYJ0l7ykdmybsNioVBg8FvuDFl0LzC75QBBL8DGB8W+M9XP5RptDhtKyWPaQXgtkY+A
         Gi0DkOk8h3wI5zcyali3PzWz9oaCIH9BTCOkUHS/jgkI0QGG3GZaFwuDSBNKc1PXQp3l
         7UzE5Bd3aKpAewGDAUHc3LBOJzrINLQ+t/n98tj2JUWLDvknsuVofLoOZsb19y/YYgOM
         WJf+MSlK0wSboYz1GA3+ZmqoApq5OuWcQviCWUSFo6fE6YM4sh/G/wuTDQIzG2Y/brBB
         OD1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722504617; x=1723109417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oDWTVtCG3rDT5LZakIAVsZ/rxWFZd0GiPuUMNJdErBw=;
        b=gImjTYcOBGIZD3y8rr4Mdsekc9K84baEKJ3W1/ovZV1QwU3o5Vivq7wg1djhY7Pwet
         b/roabFzUcTD24MKlk5VcworzDm8rhTJzJ+XdImWt7D9GgmuAvKjwEUH5AUn4kLx5fg2
         T0zsLwbWySJwThYu0FWAa48VgF0HpNzq6LmqUXNDr1Q+fprKsTegqIyzZVABfz+Uree1
         UfB+836kNN1vWDwh6jlTqbLdGnBYuZAq+w1PLxkJEJsBVx+BJkeUD7LbhoI6h2K7O8Sv
         63NDsFsdz7vMNCexteLzlrh13f1Xn2bQ2k6Boy5GtiwQGJ+MY3DwNlOHWmBZrx7n7c9r
         wBXg==
X-Gm-Message-State: AOJu0Yzrr/63OKSPCR2K2NKJMV4/USDtg8fYsKUW/AsxQQLLoIb+LevN
	wsu4dwgA31lYvVrGkrQh9DiocXZMDMOXV7iBWd6nT+3Zs32GSI9GAG/vwiWz
X-Google-Smtp-Source: AGHT+IEpjOc7oFt5/RpUmtNM9TwoFUPT6n/+Y7UrvshnrmDR1ow8K9fvmOsPfUkAVTvN4dRY+AwgXQ==
X-Received: by 2002:a17:906:ee88:b0:a7a:c256:3cc with SMTP id a640c23a62f3a-a7dafd63c6cmr129800566b.67.1722504616226;
        Thu, 01 Aug 2024 02:30:16 -0700 (PDT)
Received: from lvondent-mobl5.wlan.qualcomm.com ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7d9fedaea8sm169542666b.77.2024.08.01.02.30.15
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 02:30:15 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] shared/bap: Fix overwriting sink attribute
Date: Thu,  1 Aug 2024 05:30:10 -0400
Message-ID: <20240801093010.144495-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When allocating the sink and sink_ccc attribute they were being
overwriten by source and source_ccc attributes.
---
 src/shared/bap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 48fa74edca1c..8147e037b6b9 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -559,14 +559,14 @@ static struct bt_pacs *pacs_new(struct gatt_db *db)
 					BT_ATT_PERM_READ | BT_ATT_PERM_WRITE);
 
 	bt_uuid16_create(&uuid, PAC_SOURCE_CHRC_UUID);
-	pacs->sink = gatt_db_service_add_characteristic(pacs->service, &uuid,
+	pacs->source = gatt_db_service_add_characteristic(pacs->service, &uuid,
 					BT_ATT_PERM_READ,
 					BT_GATT_CHRC_PROP_READ |
 					BT_GATT_CHRC_PROP_NOTIFY,
 					pacs_source_read, NULL,
 					pacs);
 
-	pacs->sink_ccc = gatt_db_service_add_ccc(pacs->service,
+	pacs->source_ccc = gatt_db_service_add_ccc(pacs->service,
 					BT_ATT_PERM_READ | BT_ATT_PERM_WRITE);
 
 	bt_uuid16_create(&uuid, PAC_SOURCE_LOC_CHRC_UUID);
-- 
2.45.2

