Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3661F47F4A
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Feb 2024 17:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707759544; cv=none; b=hCHAeGBHlCY/xJVw30mdvNX/2/u/5OGtUB0l8yv4feZSZqIo+VEJmlKsxifzLSLP/WU9aWGhGw2JqWJ+zFErsMhOE20mkk378JfZdEED25zIVt2k+HInwoqnx/Xc/k5WhsQjaT10bsyY/fTEYhl0Vt6wySLcu2Sj9+nboXslqvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707759544; c=relaxed/simple;
	bh=RoATdOmJbDk9lrGtQq/f7oUJyMn08wYFoa+EP3m5fKc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=SuEqdnqoidAfXhAWGEMX8NTT2gVwhp1zr+jnGETgPrQN1CBdMlMIv34E8dT61BmduZziulOfqGDc+9j53FNSLOQ/3/3OJNKxIl/EdFlItnqfSveG/lmtzl8pKx4mcVWbIfBjJXhbY8+c7C7g9VAtQ9Pj69N2+RN3Zul9pkUf33s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kSCzooa6; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSCzooa6"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-46ec68f1b59so198318137.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Feb 2024 09:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707759541; x=1708364341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=c2q7tQ1TG4hNxpIKUh7oxpZsvECnxvXqaKYzpr2ZN7o=;
        b=kSCzooa6j2jCMlvtRaV83jxtS9IOflkUA3XVXa4fW7NseVZoCZm8p00CSYxTEE9szB
         g5ZwxIXUnCcGLwBzQUmY8u82+U2F8VF7+LizgW0TTgJUj39iHsdM/UgHYmahKOoIjdkx
         19ibWmYTEDekiFFeo1mBCn1/KvIbWZ3MFd5wKE5wpZz/IuwaKwFrhd1LvMlQdtW6Zwns
         g9wsd7/l5r+69iPllAwQpkOT/xowMMz+iFsdOYSBsy1US1YANPWp4F+VCc9G7tG8BRWw
         mxGmoL2mpgA6dlNP45PtS0y+OdoP77kunB/lTjuSzckccLaXNcfYTe77SN7MCm+dbLmn
         7X6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707759541; x=1708364341;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c2q7tQ1TG4hNxpIKUh7oxpZsvECnxvXqaKYzpr2ZN7o=;
        b=f8cIDqW0gj2pl53cYdOA/YEMRpOr2GsKngzsk70Q0rkH7SCz14XmPYt+nSUx3kI883
         qRTBLH9bLOSVicvazaBkxqJqii6r5EYY20xUH9WrbJMpqnF+TkgXJKnVxWf6ylGzl45Q
         RkOeSqyS3PhcK/z47xQSLVpMYLvKXuQ1vZx0Jo2Lb67W+B3Turzq4z6qUnXgKxURHx9Y
         bKUqtNfH4PectmC5xkPZ4iVuNygP89CER6uwvmzgcp8J+kWB44+eF2D+8u4BPcXBcyF0
         jGR7YPnvn+AVGpgs1JEIFyyMpFUyF0aibvYQBdPwb/tFtboGkn3lAzfd+voQObKXVa0v
         +XZw==
X-Gm-Message-State: AOJu0YysJR43RsTkOaPF34SKTGu+LZyOyNb7jP5On5SO0TZztWjvH2DY
	BOrKASyB9vL22ZzdJnvcjQjCnEM3zoqIxkJtkSixiDkljQ9rFIuW1A1RDyGS
X-Google-Smtp-Source: AGHT+IElenfOJbkKSCrSjuYtYVgZ6jndYPz70hr6Iq+2BziFUGvnDuer3N8Gt7kSuc4uRNNLjtY60g==
X-Received: by 2002:a67:c584:0:b0:46e:bb6e:344d with SMTP id h4-20020a67c584000000b0046ebb6e344dmr2921477vsk.18.1707759541141;
        Mon, 12 Feb 2024 09:39:01 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id ej16-20020a0561302c1000b007d8d886d1fasm162087uab.39.2024.02.12.09.38.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 09:39:00 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/3] hog-lib: Don't destroy UHID device on detach
Date: Mon, 12 Feb 2024 12:38:54 -0500
Message-ID: <20240212173859.4061435-1-luiz.dentz@gmail.com>
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

