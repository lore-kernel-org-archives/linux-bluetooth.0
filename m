Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81465465C
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Feb 2024 18:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707504762; cv=none; b=BWewJzwJXUsXXb1nSNMvPOephZ6/8MxR6tfHRWu9qKbTM/gA11qyXXr5WSy8yctFZ4bYp82jfW63MjyllBaF3N9ArZ6nQwTtyryYA718cgyD4/mvXky726KMQkOqeYtKJesSAzdEc2YF/T/VM/dcQg8jL4NFLunFBERjJmN9Ga0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707504762; c=relaxed/simple;
	bh=RoATdOmJbDk9lrGtQq/f7oUJyMn08wYFoa+EP3m5fKc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=NMyxBA2ey0z0sv/vH5RaNxyMV4tO8vRF+0B33rX34NMfaq7GWUyP2Kg9f6EOk0Y3SU/9J1gZxmC875PBDTWNHWC3iuEl3t5NzmnlBAbJeM1CzpxQgAlCqK8sLYmmFY95XNM/C8X45BHH+Nyt3lilNbD1+aAAU2w0sO1EoiinSLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtcUlJTQ; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtcUlJTQ"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-7d2a67daa25so566695241.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Feb 2024 10:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707504759; x=1708109559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=c2q7tQ1TG4hNxpIKUh7oxpZsvECnxvXqaKYzpr2ZN7o=;
        b=BtcUlJTQtV/+JroAhefQbUYOkzwWD2BB0p3u8eeJoBSr8IAq9huQ15i9jLHNa+yj91
         OTCVBzb3LRixsQjpMS/sRHzVhh+eTv+WyHSjB9B+txlgZ6sgb6aRUZEi1Tjpyc9FdaGD
         qp8PHB7LkBI7Wm4J+aJpz69nRSe65qQgKLzyhJM9vlAYnjv+7FWbJ2oArQC0XT2CwI5t
         vffeK+/HYNqCnkW0q4g9kN9rqZ7GNHodSDOAmFz3eyqZwV6D9pd4S9YRt3nIsYdgleps
         zmnxkhokJ1aiMzC1NXOjjGYyy0B6mmtdEWNnapWJYu3itORDMPcUpLApFPdq2MZ5BAW7
         s42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707504759; x=1708109559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c2q7tQ1TG4hNxpIKUh7oxpZsvECnxvXqaKYzpr2ZN7o=;
        b=nXr5oqLw/mZ4AFJwFNITRFHJfVlYC+n1k6KDXZuxbD8raDssVFssaXfAuIdtIW/zyV
         gfpFa7mGI87Axvj2eau4j2f+8kpwNkB41+/QPzBXPlByLGeun9mAzHrdJxLIKWRcdG/e
         ONxHTwHZlxs6aWfraGSzDBYVJsepecEIUVJLcBNNj6C1NMavhvMicCNRvXw10u5rDBRT
         5jEsccnuCKRAjymGf6kB8l/r9vA8GlIaSYNUS39Sumja5LabZbzh2LY9qvNgClrDPTEm
         NikQYkrlEmW29jb5C5Sdb/d7Pndpq9RyDlVMFaIo5u3FjM66S+CjOQSb4FJubK0Q27F+
         Jhgw==
X-Gm-Message-State: AOJu0YwoKKxV6t2q8g2LaE48H9eHrGsVPoHbkjb1ZEhcZp4ZQJzKH3eS
	JUZW6XtNkLKk1vIl0R/m5MCvtfuPm+uOFxEENHoTiz/APU1T/rE9LWNmwukU
X-Google-Smtp-Source: AGHT+IFiXSE7Utyg6aNtB/pl1eosFeffdoSR0r1oGy+CwS/yKo+5TolcP1NwUp6YGEtWcgXR+/a1/g==
X-Received: by 2002:a67:f811:0:b0:46d:30af:ed32 with SMTP id l17-20020a67f811000000b0046d30afed32mr277029vso.10.1707504758968;
        Fri, 09 Feb 2024 10:52:38 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id p7-20020ab06247000000b007cea1ac338esm116989uao.27.2024.02.09.10.52.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 10:52:38 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/3] hog-lib: Don't destroy UHID device on detach
Date: Fri,  9 Feb 2024 13:52:35 -0500
Message-ID: <20240209185237.3611995-1-luiz.dentz@gmail.com>
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

