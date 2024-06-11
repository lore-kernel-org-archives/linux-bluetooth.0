Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03993D0C5
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Jun 2024 16:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718123747; cv=none; b=i8RXRPUCGvb158prQnJaljDjrM6j0cjOhXmSDX3FRX3ADh3unlmT1SV6Tgm93a8iNCcIdZL+WFeiXG00s4jl24oulCx0qv1dmihr9ArPwvtlzm7hYmsez8qPwFpx+wwofw3KmnBGqTXythUiI+9DeMiX3nvHMb6y3Hj8F/ZvE1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718123747; c=relaxed/simple;
	bh=/md9T9hMmhmAG2VNOjqDru57HXxp7w5IBZFKek8n6nQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=JwldPsLXTL7S0JRAVdd30h12dVw9dYYgBFaR3kfw3v4MXun7cBELlnvTTTJDD2s/SE+03UOlZTrofdcQffCVHH+kKIRtnTpOd0nykC+azVpSVhwNYwE1alIh9x4pOKfgsd3P+sXgr/GgSe6XmBCPw4TVyBqUZBZQyp+XeL/Zd5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X8qmW/3f; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8qmW/3f"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-808c613ade5so314249241.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Jun 2024 09:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718123744; x=1718728544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=MeYQxSF1nuy4x/pEKdQb6ODssY7uCs8QFY6rTQfkE0s=;
        b=X8qmW/3fXfbBKCf7QkFYGc77GDfbN26lkVltejMsyT2qAdEA4j8avahufqgbUXWy5b
         0PLCaGVE/PzS/IRE4Os+ceRNTciexFb2BaJUla0URTyEVRA8GrPqs589AbH8n9LmcaCt
         8FiCj3bjjpwwB53yz/yMd8/n2fQ8E3JqQbJZy3DCXBsB6FtvMcxjW8o8HNNNUpV2jvZu
         R8PJhix+dXHPdGeyHbP8lY6NW9yiCof/wfUNkfZndIwtW+Te3aejrWHSc57e12cw0XM2
         gI4AOg7DzTtGEvy56+mN1YPcVZhw2tOjyOVuXVvcsabkrF6/S5oO/kmVam7dzlUSHmWP
         yAZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718123744; x=1718728544;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MeYQxSF1nuy4x/pEKdQb6ODssY7uCs8QFY6rTQfkE0s=;
        b=JQ6a5pP8rfT5XFcBlt57GUO/7wPLM1OfTA2iQAYb2zTibXv8TrZP5S0PTb8/SAZ+AI
         pt+kkcqrSMSG/Susjto4S0eF7APhoak+HfDjQKK4/kupx3OnzMx9O4tddzhrFxSDoJhQ
         DT4L6eDVFy2RVudjapplWTgDDkevpP2p0Tf6dbZyWry3DL8QfOsOXKSr7U15wN3ujYEF
         /QDxnrnNODr44fBnohfmWKc+GaSBWQwKfyp/rTAZKAE6ldl2AoypAJwaIOGumka6ANf4
         PCnsqTVHhsg/bmP2lp4jjSqU/XxHStzjIGaGi0xx2lb9z2ga4bYp1kun7CUr6LaGes9v
         whDA==
X-Gm-Message-State: AOJu0Yy7eoiqKDv8pny4PygR/SIjQft5VkLN0JmYCFSmKHVktb32LJFV
	ZmWZnCAsyZCVCUFlFEjJiAab4Pe11me+QkdnU3ngbGd7ojNsnG5HMFIGHQ==
X-Google-Smtp-Source: AGHT+IFWBmWmMxlBwJ7rQW6vctXak52vHCKuRt6RyeHv6nNHDGowi0W+Ur9BN7SNN4B4Hbfc34KS+Q==
X-Received: by 2002:a05:6122:20a4:b0:4d8:7970:28e6 with SMTP id 71dfb90a1353d-4eb5615afdemr12650644e0c.0.1718123743965;
        Tue, 11 Jun 2024 09:35:43 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4ecf9b30a1bsm132291e0c.32.2024.06.11.09.35.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 09:35:43 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/2] shared/gatt-db: Fix gatt_db_clone
Date: Tue, 11 Jun 2024 12:35:41 -0400
Message-ID: <20240611163542.1161789-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The process of cloning an existing db shall also clone certain values
that are considered when calculating the hash since the resulting clone
shall have the same hash.
---
 src/shared/gatt-db.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 16abcba2ec1c..b35763410d17 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -281,18 +281,35 @@ static void service_clone(void *data, void *user_data)
 		/* Only clone values for characteristics declaration since that
 		 * is considered when calculating the db hash.
 		 */
-		if (bt_uuid_len(&attr->uuid) == 2 &&
-				attr->uuid.value.u16 == GATT_CHARAC_UUID)
+		if (bt_uuid_len(&attr->uuid) != 2) {
+			clone->attributes[i] = new_attribute(clone,
+							attr->handle,
+							&attr->uuid,
+							NULL, 0);
+			continue;
+		}
+
+		/* Attribute values that are used for generating the hash needs
+		 * to be cloned as well.
+		 */
+		switch (attr->uuid.value.u16) {
+		case GATT_PRIM_SVC_UUID:
+		case GATT_SND_SVC_UUID:
+		case GATT_INCLUDE_UUID:
+		case GATT_CHARAC_UUID:
 			clone->attributes[i] = new_attribute(clone,
 							attr->handle,
 							&attr->uuid,
 							attr->value,
 							attr->value_len);
-		else
+			break;
+		default:
 			clone->attributes[i] = new_attribute(clone,
 							attr->handle,
 							&attr->uuid,
 							NULL, 0);
+			break;
+		}
 	}
 
 	queue_push_tail(db->services, clone);
-- 
2.45.2

