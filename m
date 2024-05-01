Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DBBEAF6
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 May 2024 19:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714591698; cv=none; b=HEh7lhcU+xZP2XJFt+9upoNlU3dP8NkApMF2mlAB1NIFCI5ZgJSfrBVUy8/lmjX7zJrC0J4mAPPVUGVRZd2jDY19vDJzUKLg4BXLa7A8si6jwp2sZLXK4iubw1NTIyEDNRl0J3B3ep3neoZvW83mbtGwV6Fm06e/hqPS60/VkQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714591698; c=relaxed/simple;
	bh=zI9QaBQJt0tsLxYJV766HWRS20rUZ93S+25+B4/VtGo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Hgx0rkNJLBhT+/piP05KwcqVuYW/JfbH5qL5NhgyyiaGKYb8avQ4o/u4MeJZ0RtzvPGvqlQ+Z/G+5xLuaWWemYh3gwurpQaVTSNT9RdkOMcW8FILIVihg+g7sky9hHxXokHCI6HavxkGFR95tdzHuTYmNFBPtm2RnuJC3EC8dtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F6l6h8BV; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6l6h8BV"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-7f34ebbcde4so365056241.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 May 2024 12:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714591695; x=1715196495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=znWRKUqT77U70qk/K6NeW74Od+GD4OvDn7YXJQKzuKg=;
        b=F6l6h8BVHtrHXO8/WflVZLuCAo5dfrXvlebcLqFV3XIId66YZk+rgXeuM7oOX7hK0E
         BQBFchmqjnUXgE9sEWi+ewMPV6P0jdHZ+ZDDe675jrToWfou13KeCeZ8HnEwRlhY7Odv
         6G8Vy5ee3pFFdAGq5ILxD39GU7apH4sZWYue550khR8b/8N+LYYx5wrEe2H2rfSiUp+c
         BpSGC9la/QY7IUNcmOMQht9QOjLmmYR3h2LkwIZRAlssvLYQkhQEljnddq4xy6c9dvMO
         m9kJo0llFVLsTeo6XFt+U9C5XJ6Y0nh2KKRBc3yBCbiGCAjQLvL0wXCTWKdS9B/GnBdm
         eKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714591695; x=1715196495;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=znWRKUqT77U70qk/K6NeW74Od+GD4OvDn7YXJQKzuKg=;
        b=DzAO8OGQ1JzcDHH29cCX8Hvsu9m/03gkVLBMQKYW1FlUqNF0lZ6nqliHClZpM/StKx
         NfLpyYqBKbaa3RxpH/RXPbvxh1Yd4OPqRH313JW+Z777mkJdGJR9Iul7TTV+S3NMdNV4
         jyXGfcYvjHDF6KvTaDxcL4161XsnfGLbYUj0KhtLw4jc8ket16HGVWhzt70YIjKQXgUk
         MDrFl47IJ9MJxNR5eVC80GTddde/ZKM85xxgY05SfD8NVsiuQSG6s5o4SqdZR/KrORsR
         pZMlhTDlvsfB8wBxLg+VymXitLIqre66Ica5Kj2YGiNn9OibbZedHfssov/aJRiV26qa
         2gAA==
X-Gm-Message-State: AOJu0Yx+sqMWLTWIr3aNRTZubDEOP9mbrOFMaYQAticPhd3CZCxiVuaY
	m6lhb1OpMy/3ZflOoSxIO8RwrZ5y/HlA9U70pzu1hlfrr14bu/uF0A9A3w==
X-Google-Smtp-Source: AGHT+IElgo/xaRf0RlyZmKo7tsGRQPyyrnO5smCro+5HEiQ5+cDDuLho1h17i+pow1ky6Fekygx18w==
X-Received: by 2002:a05:6122:3c43:b0:4d4:3621:b245 with SMTP id fv3-20020a0561223c4300b004d43621b245mr3684124vkb.16.1714591694732;
        Wed, 01 May 2024 12:28:14 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id b7-20020ac5c747000000b004dee45c148asm1429436vkn.13.2024.05.01.12.28.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 12:28:13 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] src/shared: Make default length handle EA
Date: Wed,  1 May 2024 15:28:12 -0400
Message-ID: <20240501192812.3421949-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

By default bt_ad was setting just BT_AD_MAX_DATA_LEN (31) which is not
enough to handle devices advertising using EA, so this switches the
default to be BT_EA_MAX_DATA_LEN (251) since EA is much more common
nowadays and for those case where the it is not supported (e.g. for
advertisers without EA support) then shall be using bt_ad_set_max_len
to adjust the maximum length.

Fixes: https://github.com/bluez/bluez/issues/832
---
 src/shared/ad.c | 2 +-
 src/shared/ad.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/shared/ad.c b/src/shared/ad.c
index 2d6fc628eabc..f3fb428e25c6 100644
--- a/src/shared/ad.c
+++ b/src/shared/ad.c
@@ -48,7 +48,7 @@ struct bt_ad *bt_ad_new(void)
 	struct bt_ad *ad;
 
 	ad = new0(struct bt_ad, 1);
-	ad->max_len = BT_AD_MAX_DATA_LEN;
+	ad->max_len = BT_EA_MAX_DATA_LEN;
 	ad->service_uuids = queue_new();
 	ad->manufacturer_data = queue_new();
 	ad->solicit_uuids = queue_new();
diff --git a/src/shared/ad.h b/src/shared/ad.h
index 820b9177562b..11900706f9ed 100644
--- a/src/shared/ad.h
+++ b/src/shared/ad.h
@@ -15,6 +15,7 @@
 #include "lib/uuid.h"
 
 #define BT_AD_MAX_DATA_LEN		31
+#define BT_EA_MAX_DATA_LEN		251
 #define BT_PA_MAX_DATA_LEN		252
 
 #define BT_AD_FLAGS			0x01
-- 
2.44.0

