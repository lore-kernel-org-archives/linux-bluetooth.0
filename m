Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA3013B7B1
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Feb 2024 18:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707937045; cv=none; b=CjuTbE4zReFZC3FalC+8KPkiT7z16zdZ0vG5IMjFq8RI9gsOOX5yxrqy4rNiXB2JkdfwHVjDEs2SoE0CWjVjnX6ZwMDbSXHXFPLW9bFk3/V5FIZzMyH3pxCGsu+egk952VAhvceyW/YttASzU1cKNHYMoffynKdgnchYjEmmSZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707937045; c=relaxed/simple;
	bh=RoATdOmJbDk9lrGtQq/f7oUJyMn08wYFoa+EP3m5fKc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=BkToW0seKI6hpxupyMD25FSBMX0WdpTrFZbbKNPnVynZzAofFtWWQBOuS+E0N/Xvni80MPDoT+DbbWdJ+QX6EkXbHYwi3Wk/ZMLvQtuZExZMhdkLDgVpEHI3H3uEVcPIY76Yd1rpS6dODa0PTdoEh1eslw47lYp1Iai9ruDOBUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DTMLZjAS; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTMLZjAS"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4c02a92d563so12561e0c.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Feb 2024 10:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707937040; x=1708541840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=c2q7tQ1TG4hNxpIKUh7oxpZsvECnxvXqaKYzpr2ZN7o=;
        b=DTMLZjASaAYTSG7FGN3vdqlwNmZURfF9S8IUeN+RxBOfOHm8murp0Q1MScY8w86r5G
         0GcDq2HSi1B1HqEVO3Q0Y/d0G2NUvBBaUmMb6rn0+cq+sTE5hF+d1bXqQcEtuZazrQPT
         wLyBad/KZTV8lcraQ999adnlEd346NQMfMVjxBxN/yW3m4/zWNXbV+e7wKtXYUjMz7uG
         /B+XLAC13rjbcXyjWCbQHcH8lqzi5SzeHyaaQChYG5HRGmUeui7L89bUL4pjWfowEcgM
         fliCYlIdM2WfcpRwduhs+4fETZRxLrznQU2bffEVruLzxBZE5F4y4Rgd9aa7DSgm3ROm
         BVWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707937040; x=1708541840;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c2q7tQ1TG4hNxpIKUh7oxpZsvECnxvXqaKYzpr2ZN7o=;
        b=iYEWzAZO91OcvrqQHyg5PGfSwaDrcqQ5mvNvmzdizUB/RR5vHy6mWcPI0hPGW2Is/v
         PBsNmaUYpmy7SaaNXdPpuJ1wK8vhe+YpOsmbFET0HC7xZ9lFpQfYQA3xV6gUcGC4cdM4
         HWl63nbXtHODTKu0yHEVNkFguOvQMtU91s/WqmcaYdVohTVuqgiI/AhV5iMyJiijBEp0
         64d2o6TgYXJHhWuosmfswjWQ2nkKQvFM4VbcV43dszwzYSIRaBe2IDe+w1aGwzsHADIb
         rsFuc3lkuFvI0Bbc0WSYGaIqGnNtivUwk5YROV5lGZLUgLtqa0KixhRoq6HsOEC5xKk5
         LczQ==
X-Gm-Message-State: AOJu0Yxgx/XZCTYFPdGykwOg/w5ZsFg4vcyccm2KFYywPukHfR1xcoXv
	DoCEmZVElXlUhnkM7dHKxX/jtiVVcNxzgs2pmF4v1pmRgrxu+48Qwk1cSNa5
X-Google-Smtp-Source: AGHT+IFDI3/PnGPHak0PV7qWOwhT8NmU8yai+zyP7PhVHkAKZzWLGoRf0vLmYj7dNMDhgTmsOHOdWQ==
X-Received: by 2002:a1f:ea43:0:b0:4bd:7bf5:934c with SMTP id i64-20020a1fea43000000b004bd7bf5934cmr3176932vkh.4.1707937040417;
        Wed, 14 Feb 2024 10:57:20 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id l5-20020ac5cda5000000b004b72c016c0bsm1309545vka.5.2024.02.14.10.57.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 10:57:19 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 1/3] hog-lib: Don't destroy UHID device on detach
Date: Wed, 14 Feb 2024 13:57:16 -0500
Message-ID: <20240214185718.536748-1-luiz.dentz@gmail.com>
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

