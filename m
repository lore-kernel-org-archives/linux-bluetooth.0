Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9648C2E0916
	for <linux-bluetooth@vger.kernel.org>; Sun,  1 Feb 2026 08:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769936123; cv=none; b=Y3p9Vn6W5ej7Kx6Mxz5CXJgnj9JAmVTp6HOxufnDnKgbBBl5IpglgEIr2otzM2IlXUjG0Z9gZyyWYFZAiFPZXOrV65v+o7Ip44a5gKk9584pggSyOnCjW6J0FSSTB1f1740x0eXwGJi75Muxz5K81TMaZqgJN6E8JLceaxdZ9WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769936123; c=relaxed/simple;
	bh=NlQJS40tLWhdyIAT8rbwJNUEuQlmZvV4TvM785n2rlM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dhj3FofRlWn0Ve7RcPUI3okWqwZOCNMi5m0Ke3eLDa6/7rk/mf4s+HU1AcEJfDY/2AdERcKWiLdJ1ui0rz+MMftGya9OralwdGda4tJUdNEryov/689ijsDBIVcNRSSqORRi91ZDeOfohEiAqXMZZiA8Kq1y0+PYmOZjUW9g7J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WyRZEWCn; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WyRZEWCn"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a8fba3f769so3071555ad.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 01 Feb 2026 00:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769936121; x=1770540921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CrX3Y2YvVo/FwRSamBjn3hWcxuecVc5wmwp0crCDFEA=;
        b=WyRZEWCnMBBBA1Ws3fhgyKhiWhhO8Uzj/8jh5xZZGF5bfqDOB0MA5qlhq77sSa5fIh
         2koB02fKDBByHQgYO1N9Ol7hktLFb2U3vT2+bQgDefF92zDnrobE1hd6QTE+iRmFrntw
         8LzVwDthLCgVqnnb1R+SHwUA7yCixoMDuDRkz7OrA8qQjPHElnTBg7NVAeTPK+Renvgf
         P8Hn4mCppwgzpAWfXD3XYm3JEK3JEpwz/bUPNRtkwUofpWUzbz6ua8PhZBQWl0IYXbxd
         IdMLiNeXdcwIghyAEZ0ne2QBKqnsdlLuPK2Bgpz4pi5FLeQ/VycPpdKHkCwv+a5hzqLW
         BPLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769936121; x=1770540921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CrX3Y2YvVo/FwRSamBjn3hWcxuecVc5wmwp0crCDFEA=;
        b=ESOfncWK9oMToVuCtnn0Nj+VJgbLTJsCmmwXUyNEgfVRO3jtfNdKlwohk7X4MRX1Jr
         /o4SvdpHws9UQFjZ/vawNf3tj9Qlz3DQuDt7RLPiaY9ycZtHkn5zBWaqMThQdA1oW8t9
         Mynk6Xy6Sxq4Ht0m8SaVSvQ8cwdDn65jk6gN3tYbFUNJiVfD3Rnnz26FWuErruk8X4/n
         i0bSSobdOBGlGdQ5N861a9Pafps+BYr1CvC2k/fyvxLvnZfskAQwEN55u4jeO5TIv29y
         wn/6FAR3YYtewkjJETvRaNzA/R1XlfY1KV2RmG6Ma6Jk0Uh0wJ2qH65XKYy+vYl0sm6I
         O1sg==
X-Gm-Message-State: AOJu0YzKfAWVFiqSyL7rtgV/Ox4QLTjfx6yFUBxCuuN9KEWD72tzTxAH
	MWNLY0C8O7ONX4Gzdpyp5ta7NO1tUfGmQXWiszNGGSVThyew4hKXzFK0OquhXtBf
X-Gm-Gg: AZuq6aIXmV3fuJ+m2dgnsBIJI3Ckr8pDVBxi+wxQvzONTqUv9fxQ+NPgS21ydAzkmGE
	P9jkbDF8k+r6XZv0zHYQc/QXFeBneXl/vevGwxw7/GOCWOEArHKba8rh/i2cPu3CbtHu/jH+MIO
	ql76jboOYfmuB0Xoc2luZen+GT661s5wKCkS6eeqDqGzragrivjUVIPofVf5Pq2BUUU1LFjeqVH
	cgCJjIk6xVYYQOCaMuz2w+rluiiou9Vwy4MNNjRvrhzoMqyD9NaHX3yVock80zLWaJyorQRJW19
	h5F27ABfZpGytgsu/kM65vSNnTJaRAANUc/guMcplN/FdI2JxNBYfTl3kWDEJ8uAgWMdcIypeOF
	A17SPw0NtJE1Ym+MVOj4IimuuAVt8naZMWnyqF7mSBAETNM0RxkJqcDNhYQOngCW3m950hWFGpt
	zvYGnOv0/p3CL5l98=
X-Received: by 2002:a17:902:8e8b:b0:2a7:bbe0:f01c with SMTP id d9443c01a7336-2a8d96a2b80mr60641215ad.17.1769936121481;
        Sun, 01 Feb 2026 00:55:21 -0800 (PST)
Received: from mjolnir ([2409:40c4:2037:8a72:ec74:6235:1f57:1d09])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a8e512bc2asm51563645ad.100.2026.02.01.00.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 00:55:21 -0800 (PST)
From: Roushan Kumar Singh <github.rtron18@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Roushan Kumar Singh <github.rtron18@gmail.com>
Subject: [PATCH] Add Null Pointer Checks
Date: Sun,  1 Feb 2026 14:16:44 +0530
Message-ID: <20260201084655.73566-1-github.rtron18@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/device.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/src/device.c b/src/device.c
index af8df5f29..c0b95d09c 100644
--- a/src/device.c
+++ b/src/device.c
@@ -380,6 +380,9 @@ static GSList *find_service_with_uuid(GSList *list, char *uuid)
 		struct btd_service *service = l->data;
 		struct btd_profile *profile = btd_service_get_profile(service);
 
+		if (!profile || !profile->remote_uuid)
+			continue;
+
 		if (bt_uuid_strcmp(profile->remote_uuid, uuid) == 0)
 			return l;
 	}
@@ -2540,7 +2543,7 @@ static struct btd_service *find_connectable_service(struct btd_device *dev,
 		struct btd_service *service = l->data;
 		struct btd_profile *p = btd_service_get_profile(service);
 
-		if (!p->connect || !p->remote_uuid)
+		if (!p || !p->connect || !p->remote_uuid)
 			continue;
 
 		if (strcasecmp(uuid, p->remote_uuid) == 0)
@@ -2594,6 +2597,9 @@ void btd_device_update_allowed_services(struct btd_device *dev)
 		service = l->data;
 		profile = btd_service_get_profile(service);
 
+		if (!profile || !profile->remote_uuid)
+			continue;
+
 		is_allowed = btd_adapter_is_uuid_allowed(adapter,
 							profile->remote_uuid);
 		btd_service_set_allowed(service, is_allowed);
@@ -2629,11 +2635,12 @@ static GSList *create_pending_list(struct btd_device *dev, const char *uuid)
 		service = l->data;
 		p = btd_service_get_profile(service);
 
-		if (!p->auto_connect)
+		if (!p || !p->auto_connect)
 			continue;
 
 		if (!btd_service_is_allowed(service)) {
-			info("service %s is blocked", p->remote_uuid);
+			if (p->remote_uuid)
+				info("service %s is blocked", p->remote_uuid);
 			continue;
 		}
 
@@ -6173,8 +6180,8 @@ static void disconnect_gatt_service(gpointer data, gpointer user_data)
 	struct btd_service *service = data;
 	struct btd_profile *profile = btd_service_get_profile(service);
 
-	/* Ignore if profile cannot accept connections */
-	if (!profile->accept)
+	/* Ignore if profile is NULL or cannot accept connections */
+	if (!profile || !profile->accept)
 		return;
 
 	btd_service_disconnect(service);
-- 
2.51.0

