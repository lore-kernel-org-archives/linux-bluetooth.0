Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585B53E49E
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Feb 2024 17:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707759555; cv=none; b=ONbmqY7qb52i9n+Xjb9T6oc0StesWrlZYVrxDkTsB7LmWkQPmISnqu0PLgpzoFMru2gGy/knQqcnhSZaaS4iu9KBh8yW7uLMu2XZDTQ7Xm8kizHL1N09vdo5csMFLmSp/XCJ13Mq1573Qx134DNB11XIPpZZTCnj9QlcWF50YPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707759555; c=relaxed/simple;
	bh=RoATdOmJbDk9lrGtQq/f7oUJyMn08wYFoa+EP3m5fKc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=t+cxqMNWWOCRKz6pbYH/K6rvCcJj5rqV25xpjQejSpJ+TG3uqmdV9Y8iakM4OaO/UnWdroVQmDYZq3JvjwxAnt9sYcqj8Wle28Z4iJsPfCuqjdcTLqKJ4QnwtUG9OccuZGbB9OskjVZsF82dEjfPl3YgANdmnROOrBdHYfLXBFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kt1jxjGb; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kt1jxjGb"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4c0215837e2so551499e0c.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Feb 2024 09:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707759552; x=1708364352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=c2q7tQ1TG4hNxpIKUh7oxpZsvECnxvXqaKYzpr2ZN7o=;
        b=kt1jxjGbV9BZfnks5Hj/n57tdcRW0mIc6reieLaE5/Ez7/PvBoAD0T/DT2grJBUHzl
         6x5RQox4v8uV4nW9P/Pye8fWTBg0cZkMymf7SijOZyVeqzSq6JvxjEvbwvG2FDdaYpK2
         NuURkOy36yTXL8LfexdQwKUsUt6XKoOyDLO9zTucEo+I7iB/0hgcFlW+5v85/rrfUyeb
         sHxQEc0uQYiv2gv11Wc0XOAn+qjHhSe2gpqmyKClMBVggwWcIiuw4FBxnTGh0DJatBMM
         MKoRw8YC0t64sA9ctrYcIY8HDE2inAa7ySN+2TW0pZH/BM2EQRI8e5v8IghqfPxOvppa
         RKdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707759552; x=1708364352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c2q7tQ1TG4hNxpIKUh7oxpZsvECnxvXqaKYzpr2ZN7o=;
        b=Hb9WpsDiV+hMuHiwzms7B6sq00/v8Af10m4TqIh6bmQkevQF3/SbM7BsS7UJGhvBst
         sIHu1b4Z1Q3csTFyAztE90I2s4/MQ9cwIVpcwYM7EIvwKOUfDv0oIDjCIEjWBjrVEyri
         UwZGeW9oJO+UjJve5ssvdAatCDR8UqTIPY+4ywos+py+hNeMkYpusTNJ+AvDipe6Ju5a
         znxcYYO3nK6egHJr0FUbgnwzglOb59tUpE+43sV1BkG4NcqAqaqnf0l73Xiy6jZE+z0j
         rOB4rQ4F5E0qvaMf1sopta1yUGGOCyHGjNd9sKeb6xgzz+xSDTbw2jReiBDQBzNk//TK
         D8AQ==
X-Gm-Message-State: AOJu0YyN5iXpvoCqGO37ezgViicqcctOSFYig4N3VHCpnXBiZQaZsoXa
	8hwKfGxxdA9SbSd8NPf4UMYieklpV3IG0Mh2K8sBXbqrGTbPwzYfGBuZQnRG
X-Google-Smtp-Source: AGHT+IEOlDggjePO1O1TtO9BX8vQK3wg7Jg5ZN4VJvxxkWnXREmbEFx3y+3HYW8OEo7DEtza8eOtqw==
X-Received: by 2002:a1f:db81:0:b0:4c0:2747:acce with SMTP id s123-20020a1fdb81000000b004c02747accemr3401948vkg.9.1707759551978;
        Mon, 12 Feb 2024 09:39:11 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id eu6-20020a0561221c8600b004b75720e155sm767686vkb.12.2024.02.12.09.39.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 09:39:11 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 1/3] hog-lib: Don't destroy UHID device on detach
Date: Mon, 12 Feb 2024 12:39:08 -0500
Message-ID: <20240212173910.4061556-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes bt_hog_detach not to destroy UHID device which means the
device node don't need to be recreated in case of reconnections which
speeds up the process.

Fixes: https://github.com/bluez/bluez/issues/737
---
 profiles/input/hog-lib.c | 48 ++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
index 7ff1ede3db35..67492a63eca3 100644
--- a/profiles/input/hog-lib.c
+++ b/profiles/input/hog-lib.c
@@ -1309,11 +1309,35 @@ static bool cancel_gatt_req(const void *data, const void *user_data)
 	return g_attrib_cancel(hog->attrib, req->id);
 }
 
+static void uhid_destroy(struct bt_hog *hog)
+{
+	int err;
+	struct uhid_event ev;
+
+	if (!hog->uhid_created)
+		return;
+
+	bt_uhid_unregister_all(hog->uhid);
+
+	memset(&ev, 0, sizeof(ev));
+	ev.type = UHID_DESTROY;
+
+	err = bt_uhid_send(hog->uhid, &ev);
+
+	if (err < 0) {
+		error("bt_uhid_send: %s", strerror(-err));
+		return;
+	}
+
+	hog->uhid_created = false;
+}
+
 static void hog_free(void *data)
 {
 	struct bt_hog *hog = data;
 
 	bt_hog_detach(hog);
+	uhid_destroy(hog);
 
 	queue_destroy(hog->input, free);
 	queue_destroy(hog->bas, (void *) bt_bas_unref);
@@ -1823,29 +1847,6 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt)
 	return true;
 }
 
-static void uhid_destroy(struct bt_hog *hog)
-{
-	int err;
-	struct uhid_event ev;
-
-	if (!hog->uhid_created)
-		return;
-
-	bt_uhid_unregister_all(hog->uhid);
-
-	memset(&ev, 0, sizeof(ev));
-	ev.type = UHID_DESTROY;
-
-	err = bt_uhid_send(hog->uhid, &ev);
-
-	if (err < 0) {
-		error("bt_uhid_send: %s", strerror(-err));
-		return;
-	}
-
-	hog->uhid_created = false;
-}
-
 void bt_hog_detach(struct bt_hog *hog)
 {
 	GSList *l;
@@ -1879,7 +1880,6 @@ void bt_hog_detach(struct bt_hog *hog)
 	queue_remove_all(hog->gatt_op, cancel_gatt_req, hog, destroy_gatt_req);
 	g_attrib_unref(hog->attrib);
 	hog->attrib = NULL;
-	uhid_destroy(hog);
 }
 
 int bt_hog_set_control_point(struct bt_hog *hog, bool suspend)
-- 
2.43.0

