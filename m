Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64C33DA5BD
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 21:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781039470; cv=none; b=bMtRwRSkicY88eiqq9EKBEkP/ekIxG3mwZ0eSOdzR3xDXeOLUEcsICtWY7ZHfs/yKvlzVJWwYMyWWpDWSjdaXB9YgVNuUZUwLeyJqk70aFyvM2eix7istWvIIf5VCoTzy4ISWb1GoDpmp1uChFmkbnxV1xF//kvja60C3j43E7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781039470; c=relaxed/simple;
	bh=tZ+OGL3szrcSOTJpqsf/AgzIHg2Xg5lGhlir/60AMVY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=USjhgoBhB5TqLJA0veA9j9ktBVBZQOmvlyOjOxrtDuSY0XlRq4/zQY9UpcAjpPZT2RbXfygO+k6YQVQDbCxvw9q2+vbwkE5WgFT+JTe5egfCSZzEXbZ83RqwpGhaMS+fXj79V56Rw5zYOs7lTkd2hsPrdQVuDZ+vyJXlf7/M8DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=isnzjl6C; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="isnzjl6C"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490b8a97b11so66586065e9.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 14:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1781039466; x=1781644266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KmFYYd4f2ZWvRGyRMkEh5LIke8qUU6HsOH+nb1nj8Ww=;
        b=isnzjl6Cl7oGvsBtElQxmHc6jKa4iqLYPBY6N5h7b003d8dKT+FQcS7Bh3wGY+T5Ur
         lZgJzm/svQuguZ9HGXRb+mqC73RdTEfM2Zbq31sEsMrkJCXMTRwuQ0TvtGuzwD5Hvmh9
         L+WxVLP4xjEWydUIOLcvZJ8HQ3c1HWVS7rwLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781039466; x=1781644266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KmFYYd4f2ZWvRGyRMkEh5LIke8qUU6HsOH+nb1nj8Ww=;
        b=A32d7S/LAGk5monvWJbrQZ6D0LmREqDFMWqa5XCJBs/BwnOj7OOjtLFJ0nokrEBt3C
         uimqtEl4uMMeTI76KI+iOz9s/cJiaauqpQq0M6WHDgeAcMoTFPbDNMSZkV8Qoag/3PbY
         juszsPch+LDNufkiUdwXVfovuFsEjNlo3ZMyz4GegiFHgXkQ6TQBP0EtHrA72j7KHOwX
         WgRoWkv5QLIopNJT1CExxs0URCietg3lT28UDKWPB073XZR/BmR14ZIS3cX508yTw4QO
         7K12IXF5Cz3/jrbOl7UVAnwqkcG6YvZVpiEnWlcbw6YRA0ddHs7eG9ISkYPVEDpjOQe3
         CeeA==
X-Gm-Message-State: AOJu0Yyt5UCqdMlPzTZozSxY/84uJYcGdewav//S1oXjvLtMm6Bq9gP1
	SqHyDTHjbLyfy/buU3ehdA++L3XkAtFtxPKRwcaTdZtl90lroAYSpEh2uU7DJ/YbtE1LurgQL1d
	WVKWG
X-Gm-Gg: Acq92OF+dgVClMdcDnYDZTQFvgSyrLZ0/YRz5UoO5J9jaqn58054bk7DTILu75UDsVD
	TCLoeQ97mLIG1s3lIqAeP2t/yvGt7CvQLK0A+MjRa+9fcodfw4d2dF6kJG2kaxNzt2YAOygonot
	i+ZCyXDulPJM8gcSjwSw3liq8buHGoX3NYv59OFmfu0QXJqYHYdF4iDSlXTLe2FRp3w+XcPHTrI
	MFCFoDSta3KzsLLqGGzvSn2/Ia+fRLyVL5GsrcQx11y0UCj1GAejcjD5BkkiYLYgiebYR5ZQR04
	vz328Ycp+LKv+3dFzFqtl/IbDGAC7RADYkOHrqAOKcGgKJNK7SHTLAwaUQewtqoRycnPGNKMOEQ
	Zg369zxcxxswFco0fPDC6jfK8IxivSYsVdsg5UQPA1gRVGyXcFWoO9+wgjbzALFom/drBwVF4AP
	+CMRyWTh7ZG9Jjh6/IqXHe+2ipBoqMHW5YQVue5hXBKodIwZ1/EaoukRw=
X-Received: by 2002:a05:600c:c0d0:b0:490:c2a3:abae with SMTP id 5b1f17b1804b1-490c2a3abf2mr279913315e9.34.1781039465895;
        Tue, 09 Jun 2026 14:11:05 -0700 (PDT)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:e2e3:d5f1:fbcb:c827])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490dc47d4e0sm10878165e9.0.2026.06.09.14.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 14:11:05 -0700 (PDT)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ] shared/bap: Report invalid-length ASE CP write via notification
Date: Tue,  9 Jun 2026 23:11:04 +0200
Message-ID: <20260609211104.3887577-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A zero-length write to the ASE Control Point returned an ATT error, but
ASCS requires the write to succeed at ATT level and the failure to be
carried by a CP notification. Build a response with the truncated error
code and return success instead.

Fixes PTS tests ASCS/SR/SPE/BI-01-C and BI-02-C
---
 src/shared/bap.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index deb85b264..212d489ff 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -3762,9 +3762,9 @@ static void ascs_ase_cp_write(struct gatt_db_attribute *attrib,
 	if (!len) {
 		DBG(bap, "invalid len %u < %u sizeof(*hdr)", len,
 							sizeof(*hdr));
-		gatt_db_attribute_write_result(attrib, id,
-				BT_ATT_ERROR_INVALID_ATTRIBUTE_VALUE_LEN);
-		return;
+		rsp = ascs_ase_cp_rsp_new(len > 0 ? value[0] : 0x00);
+		ret = BT_ATT_ERROR_INVALID_ATTRIBUTE_VALUE_LEN;
+		goto respond;
 	}
 
 	if (len < sizeof(*hdr)) {
@@ -3829,8 +3829,10 @@ static void ascs_ase_cp_write(struct gatt_db_attribute *attrib,
 	}
 
 respond:
-	if (ret == BT_ATT_ERROR_INVALID_ATTRIBUTE_VALUE_LEN)
+	if (ret == BT_ATT_ERROR_INVALID_ATTRIBUTE_VALUE_LEN) {
 		ascs_ase_rsp_add_errno(rsp, 0x00, -ENOMSG);
+		ret = 0;
+	}
 
 	gatt_db_attribute_notify(attrib, rsp->iov_base, rsp->iov_len, att);
 	gatt_db_attribute_write_result(attrib, id, ret);
-- 
2.43.0

