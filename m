Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B635F6FC7
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 May 2024 14:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714747965; cv=none; b=MzEF+Gv7dL24yFVh/H4G8wbjSgBmLF6bSojFF5i2pCkHBc/Y4d8S9AKcyvVaNs/Csgj9EJozfqWWkIuoRfECbl6qWHTXP6AvXkjtimi2N1B29ZSYxZSEg12pvF2SiZXcnrC1kjInWzT/IJd2sGUqzJb/KtvUlotU9S4r00EzBwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714747965; c=relaxed/simple;
	bh=21YXkGg/Jk7e/B4j7TJMqtu++lw3s2v42JLfjAscqkg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=dVffTOxp1fHuk1gmwUgmt9R3yO4DWUekdkot24TILUo5wk7dyjYmUNk2yXRna897A1UWMsuLfuLLBKt1h9USSDXUwwb6Br4ZSWlNo7pIaBkXBfrfxUGiIbmIrRCqL763/C1Fa6X+sJ7TJZ2eBIguGyfnnhwQ9CV1PhzYLRuEvgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ndQstN26; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndQstN26"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-47efd8fa124so154912137.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 May 2024 07:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714747962; x=1715352762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=J2RB8XQQMJx5SNox7pgY9V6kBnScvAsuzlE8+sFEQmI=;
        b=ndQstN26T1pQX/EafUtleMe/kMgTpjXp1VFm1E8kqa+IwpgGVyFjqmHVLKpBLZMOvJ
         dz2pljkl+r96BxQVp50sEv9+0P+dMKmBWOF090PjyfWmpcmD/5Wo0MsF+gtbJtZg5+fS
         sS3IWEA79mj9Pd/JACLk9a6HRDdikmT4k5T8cgpnj8hYHAgPpa5f1QIySoczU6yxKzWJ
         P3hOn7E0j6FqNu/X7gj+DypAhHicPTKPKTLnAgphQf65CP4ZtDm7XyItZRpHVSTC2Y/8
         KcGD/lsKiI0xSrngAMp8Zx5mcB1dbXszkbIRd/phhyLufWM+mPX5AH8Zw3NR7TDPltUZ
         wL+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714747962; x=1715352762;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J2RB8XQQMJx5SNox7pgY9V6kBnScvAsuzlE8+sFEQmI=;
        b=ejpMmf5i3LvdhdXkYbdsMMQnM2BQFvSd0ua7Jw6nkU5C6gwAk7T5W/e6U1q0svbMK1
         FH0CrfV4dAGjsYjAHo7dr/1bYHIHBlyKAa8aHzvUQc8AdwkOKrDhdkN9hHMlthuPTRl9
         9MZf+4HlaequrXPS7KuyyQDzF9M0nllWWxDdg0easGF/PQH3PJhYVZz1/ScY6/bERGKD
         WYeptyxHleNW1veWGGnfeV3CfBl+0Stz8p2/bjsxFbiQuAID+MPNoibELn6UEzTeMI86
         GFL2L2OQ/40dXjF7Z5iUHOYShR210Gg7bgHhTQhCS5f2FCWBZNSM8K6nfyf/cik4h3v8
         DqxQ==
X-Gm-Message-State: AOJu0YyLFl2fxDWoFUrBJsmGjIXYOJFNT7lBsSK71ZnD7fRjgKVP83/Q
	KmsAyvmPdm78fY6j4zUxMnFam5HZLC6BJTDF3KErD0/QJwWcgbJBKEceRw==
X-Google-Smtp-Source: AGHT+IHTfwn5YeOWgpT8PmGYY9HDNuQV0k+9OyC8VmEVVHlfjLoPzVWdB53Mhlgdv6j1M3F/gP+pTw==
X-Received: by 2002:a05:6102:244a:b0:47c:1255:dc2d with SMTP id g10-20020a056102244a00b0047c1255dc2dmr3011299vss.33.1714747961502;
        Fri, 03 May 2024 07:52:41 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id cy29-20020a0561300f9d00b007f3b48cdaeesm430216uab.18.2024.05.03.07.52.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 07:52:39 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] gatt-database: Fix error registering characteristic with Handle 0x0000
Date: Fri,  3 May 2024 10:52:38 -0400
Message-ID: <20240503145238.3771921-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Registering a characteristic with handle 0x0000 means that the
application wants a handles to be auto allocated but requires to be
informed of what values they end up in the database.

Fixes: https://github.com/bluez/bluez/issues/821
---
 src/gatt-database.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 5823aebcbfdb..5756eb9d17cb 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -3334,12 +3334,12 @@ static void database_add_includes(struct external_service *service)
 static bool database_add_chrc(struct external_service *service,
 						struct external_chrc *chrc)
 {
-	uint16_t handle;
+	uint16_t handle = 0, value_handle;
 	bt_uuid_t uuid;
 	char str[MAX_LEN_UUID_STR];
 	const struct queue_entry *entry;
 
-	if (!parse_handle(chrc->proxy, &handle)) {
+	if (!parse_handle(chrc->proxy, &value_handle)) {
 		error("Failed to read \"Handle\" property of characteristic");
 		return false;
 	}
@@ -3354,8 +3354,11 @@ static bool database_add_chrc(struct external_service *service,
 		return false;
 	}
 
+	if (value_handle)
+		handle = value_handle - 1;
+
 	chrc->attrib = gatt_db_service_insert_characteristic(service->attrib,
-						handle - 1, handle, &uuid,
+						handle, value_handle, &uuid,
 						chrc->perm, chrc->props,
 						chrc_read_cb, chrc_write_cb,
 						chrc);
-- 
2.44.0

