Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E6B19DF49
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Aug 2024 14:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723559381; cv=none; b=Vpgt0REjv07zqABMKx6bIoub8j1GELTAew7wnY/8UZkWbynZsGbpVrCEhpAIgkD6kvT020Yy5tRUwCcgHBYRyDfD0dNMv013Dp/OWiOO0XnwogYcgONORfJ+FzkTYux9UhibTP2c8L9rXxsh581TRcp90QBZJc4NQWhFfg6QstE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723559381; c=relaxed/simple;
	bh=AI8PnafX107nHlNMxKhHVLnZ9qHqOMXD+BJ4KnHXFgo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=gqgQSq5iEaxMwBoibtQS1q+pqH9no3nzu9vtMKAIBoKK21fQ929lkwbVI2ZksDc1zIe4uKv/nGSZDU91+u3+Kp2tr+jAfVY8e74ERxJtj7kjn87qLaTp7OenybGtPXAR3eXaYya6L+2J0Bw+b/jwWtBvEnXt3jxWhSkBBaGD9VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mYNPg6uh; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYNPg6uh"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4f887be28e7so1864516e0c.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Aug 2024 07:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723559378; x=1724164178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xc+0yV8B0t/TjRMsSlfuZ/uZUG80NI7loP4VUOM1/2k=;
        b=mYNPg6uhaHHleIqGsMdmClqLS2QPCSajr3eNbRbyK1PRdEKZIhX3lwDWMKMJHWjqy9
         ilKQdXLX2mrVsjPhim2qt6L3d58n+GAFMj7P4TWTsKbbA2yY98AFstsbQY4K+ESVuWlf
         uwXMaLL6F0zjXjPgyzQVcPZhTbeaWdjaY+rc2lcJqZYyxAMoL/xy4vQpVAGr2+Kkcxaf
         4oXiwyuECjEXnC1gYAy9nyPPZTUT17LXPs3lJ40aZO/6UwsgfuWt9f5647h/2IrkfgNL
         X+ACG6qj4BiBc5AAA3ZMc2Zs+vwZypjSModXgfpx5ljV41LJGClaELzCUyQiakfleNHg
         F/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723559378; x=1724164178;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xc+0yV8B0t/TjRMsSlfuZ/uZUG80NI7loP4VUOM1/2k=;
        b=Tj/LA0sscI909Y4Ksni87sVac+KeBkenfne43KCmx8dPkvJBXo1EGQArpTV+PiLpv3
         69CJpL3w79xjv/GD3GjepJaIEdtGk9aaBeYy7mqY525hULyr1qd4RWCv6eJDSouw9eYS
         /b4dxL466p+d+Ib091sZiu0hsUQHHTlWhqbocvIl0+GXcX2UY7mbOu7CtWVxfqO0koZU
         Eq/0qu7w3Lvom0FXy0RzhT11hmwvyDZO9rFV3P7YC/l8FC5ZpNocwLyxMB1IlNKuTNvz
         chg5zPwkEwy9k6bh+FDbmxKekilqLWPZvfZtySru3/+hkvXrQ3lOG70LlhHxi2ZNeJJd
         w4Dw==
X-Gm-Message-State: AOJu0YxMs09nXjyol9P+8T2XKRoR6SE0nr4v0pFVrC4srMQNuSnR+fRj
	B5W4QvFm1YW065fJOtviAWBOOK4Ylvk3QZcLdSk1mM6edBluwBbCFEA5Qw==
X-Google-Smtp-Source: AGHT+IHVu0Zml/f26cnRih4Ux4lpjHtY2eDxS4qsBngz1A8rDo7QUZGpe0fme00Oo/lcUbl+Ok+GzA==
X-Received: by 2002:a05:6122:a0c:b0:4ef:65b6:f3b5 with SMTP id 71dfb90a1353d-4fabf083482mr4296080e0c.10.1723559377792;
        Tue, 13 Aug 2024 07:29:37 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4f941903530sm833577e0c.36.2024.08.13.07.29.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 07:29:37 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 1/2] shared/uhid: Fix registering UHID_START multiple times
Date: Tue, 13 Aug 2024 10:29:34 -0400
Message-ID: <20240813142935.504400-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

UHID_START callback shall only be registered once otherwise there is a
risk of processing input queue multiple times.
---
 src/shared/uhid.c | 13 ++++++++++---
 unit/test-uhid.c  |  4 +++-
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/src/shared/uhid.c b/src/shared/uhid.c
index 1eddc6122990..4f149fdb8c4d 100644
--- a/src/shared/uhid.c
+++ b/src/shared/uhid.c
@@ -46,6 +46,7 @@ struct bt_uhid {
 	struct queue *input;
 	uint8_t type;
 	bool created;
+	unsigned int start_id;
 	bool started;
 	struct uhid_replay *replay;
 };
@@ -246,7 +247,7 @@ unsigned int bt_uhid_register(struct bt_uhid *uhid, uint32_t event,
 		return 0;
 
 	notify = new0(struct uhid_notify, 1);
-	notify->id = uhid->notify_id++;
+	notify->id = ++uhid->notify_id ? uhid->notify_id : ++uhid->notify_id;
 	notify->event = event;
 	notify->func = func;
 	notify->user_data = user_data;
@@ -351,6 +352,14 @@ int bt_uhid_create(struct bt_uhid *uhid, const char *name, bdaddr_t *src,
 	if (uhid->created)
 		return 0;
 
+	/* Register callback for UHID_START if not registered yet */
+	if (!uhid->start_id) {
+		uhid->start_id = bt_uhid_register(uhid, UHID_START, uhid_start,
+									uhid);
+		if (!uhid->start_id)
+			return -ENOMEM;
+	}
+
 	memset(&ev, 0, sizeof(ev));
 	ev.type = UHID_CREATE2;
 	strncpy((char *) ev.u.create2.name, name,
@@ -378,8 +387,6 @@ int bt_uhid_create(struct bt_uhid *uhid, const char *name, bdaddr_t *src,
 	if (err)
 		return err;
 
-	bt_uhid_register(uhid, UHID_START, uhid_start, uhid);
-
 	uhid->created = true;
 	uhid->started = false;
 	uhid->type = type;
diff --git a/unit/test-uhid.c b/unit/test-uhid.c
index b0592d3657a8..573da318d480 100644
--- a/unit/test-uhid.c
+++ b/unit/test-uhid.c
@@ -233,8 +233,10 @@ static void test_client(gconstpointer data)
 
 	err = bt_uhid_create(context->uhid, "", NULL, NULL, 0, 0, 0, 0,
 				BT_UHID_NONE, NULL, 0);
-	if (err < 0)
+	if (err < 0) {
+		tester_debug("create failed: %s\n", strerror(-err));
 		tester_test_failed();
+	}
 
 	if (g_str_equal(context->data->test_name, "/uhid/command/destroy")) {
 		err = bt_uhid_destroy(context->uhid, true);
-- 
2.46.0

