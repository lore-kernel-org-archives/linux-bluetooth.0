Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1B336AE7
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Feb 2024 14:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707490762; cv=none; b=py8IwvP11wRoWgKAyO03LXW4A0XMgUxfzarWQOV7SM88IX0K/6mEIsOdSRlarcNSPkg0/z8Qns/QBQMmeLQQX0ZsgmL9lb6xWTmnddc8vM41cL5Bwr5C7isCycAbDohYTbiRwVtnUgjLDa/vBf/Q0VoRDyPqGSnm4NVVbujwlFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707490762; c=relaxed/simple;
	bh=RoATdOmJbDk9lrGtQq/f7oUJyMn08wYFoa+EP3m5fKc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ZCJfGS4z1+bbHJ7a29AeAZsRPynvsbj1cFLp5ZqaoiQKnTq8ExXA9AEUUGppaMMdiMOwNZhE6sl6/4r1mrwsOkE84Q+wIkLk++suYlyjWRhYkUt0NnDjhEFJfkvxH4P0j5riGsEFB0xYNgN6X/Aplsd2nlaf7Qe37VhLU7RuEfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mf1LjGuZ; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mf1LjGuZ"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-7d60ee03b54so360041241.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Feb 2024 06:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707490759; x=1708095559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=c2q7tQ1TG4hNxpIKUh7oxpZsvECnxvXqaKYzpr2ZN7o=;
        b=Mf1LjGuZ3TSG0JQVAllWQ9I1mRpq0cSSE2aXsYMf/F5YC+n2vdpxdxuxYa1jIS0KYU
         3jUXo88SVkn+M+LBOrRQL52ZJO17rO2kZ52PpxscqDFU/40Zq6yN5Wh/KZL6wfL62ppl
         q6SUrwRbb7jU/Am3edNcuZCaVST49Op5KI+q8WSns7FkXQ9hU4G/LbU4Cp8R31I42FdB
         6t0SKYt9S+myhobunCvbTS/z7lj5JccX863ZNzdtkSTfhZSsmzRqIkq18gHKZT9QTWik
         WjJM2MqC/LlSW3Zk9jH2AhbsfmTsLYnbnyxV1deHI+AmYBz7QZmSOzSNNFjwkBddWu4q
         CqjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707490759; x=1708095559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c2q7tQ1TG4hNxpIKUh7oxpZsvECnxvXqaKYzpr2ZN7o=;
        b=BWeV0IkJengXzmXx0KoAz7DWteuzcOZzmPyb/aK21nmYrIVu8F5435511kgvvEwIvM
         W6HIKfVL5bT8nOO/lxYafh0ypdD3CtPbt0w5/P7GyhonP4GFF+HCYA98yg5N6LzAT8k5
         iX2S2Ic/osji6LwKDJhziOyZIGL43ISDSat4mHYko5jQO6s+BAmbJlV8rgra2tOLSU6q
         UbsoYM38a6oB12aCy3My0RJdI3WccXcnVQcQ6Hjcb1tJ9sRdUfdL2xAHRvBlUnLBN3Ll
         X/R97z2y4JXBSEza2rdPXA0JIGoqHvhCQPpHbfu61zfitmqNF8PrN7eB0B7zXD7MpLqM
         RjvQ==
X-Gm-Message-State: AOJu0YwmqFqsCo2L8BuKc5OYtuCtSrCJPm+3xu7AUntG9Wu5BalXiu7K
	0PLiRBD63K1cjiuRcZTA06ZmYA3S7o3N4UPj4oUYfi/QDP9bbP6D17Ms5x/q
X-Google-Smtp-Source: AGHT+IEr8C6kE4sBumPYwIlgeg3wauObuWp5usMYgcKzp1WrIb+ydVASaufaAX14+91mVpKBySOVgg==
X-Received: by 2002:a05:6102:1607:b0:46c:b7a8:4b59 with SMTP id cu7-20020a056102160700b0046cb7a84b59mr1905606vsb.23.1707490759388;
        Fri, 09 Feb 2024 06:59:19 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id fv8-20020a0561301a8800b007d51ebf573csm68510uab.7.2024.02.09.06.59.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 06:59:18 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] hog-lib: Don't destroy UHID device on detach
Date: Fri,  9 Feb 2024 09:59:17 -0500
Message-ID: <20240209145917.3583663-1-luiz.dentz@gmail.com>
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

