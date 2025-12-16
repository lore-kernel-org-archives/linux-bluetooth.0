Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B2830EF67
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Dec 2025 19:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765912391; cv=none; b=YbpNLtBHZBAQQZTKa2SO1aXACZPfmBY/JGBygHFcyFp3K0sxVzaxbXFjA0kkuuaKSdWvbU+TJf+co4zRGLm5vKH5bdboWf11J77yY4/pxyGVPd70P7ge5oDuaOQsVSX1SxGHMSaATx+YRV0ddLvwuyqqhuQggLwcklBqH9dvB+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765912391; c=relaxed/simple;
	bh=9aejOiev4cEQVwtjfzoreNUfB0kVR9KWVuIDK7nOAkA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j8pDt07IQiLyr8hmbHBrk+lapEz+tSEUowjWDuzOdF01IiysIbm93vFk7FmmmHm0iaAHMWpVqgpwHGYg9BxgWGKjwuIp5NrCnLlaCy/QT0Q/nC9kbDH63EkEXnijxG0pJ9wrcWOllMxtW6lvj9hb5BYzmS9zs25HLIxWqmkQnfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mr6O+BCM; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mr6O+BCM"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-477b5e0323bso22856555e9.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Dec 2025 11:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765912387; x=1766517187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c7Zu6eAcymY6NeJU3CgMqAJH0fkDjsEct7SgqC2bGP0=;
        b=mr6O+BCM9l7FPVHU//DvWCyjmmdONGIfSu5tETDZbGfLAKrK03X7zslPB0ql8VnI5J
         dnmgAwj9ZHSiP/s0AmJ9BAsdsag7GMfvwmiEwqfie1ajPqMh826DnH8ftwM0g6t2SGOJ
         idP7OQs2JZASkv8/PysnRzFnW2RHQSuTBHTgqqnpfRGX4Z/adtmQ/6EVKp6b70/glV8T
         P4M/Z6R56kKTLk8LvNM/ASyX5Q/ksCBChnhi9cqjJYyz5wbTI2M0amM5M6dk/hBcjSHE
         G5zRroSmrmcWqc/oAyKyuxW3a3Vp73VXddIAoS7/G3LQZ1AKcTkbpGL5orDTGkhpgTnk
         uF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765912387; x=1766517187;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7Zu6eAcymY6NeJU3CgMqAJH0fkDjsEct7SgqC2bGP0=;
        b=j4xeOOD6SJRothu18y9DYx7oKMH0WFAUbERMz9VFSD9cp6ToF1iuPobU9vx/wPorOD
         VPAGzeCnKEQaAmhzsJUzQUaknp3fLFUTms3DDBA/0Es/963RXHOyLohk5goyS91aG28T
         5aCVU7hVLR8k04M0SKqNJCI6UegmeZrNDrPunDvsK8YKKJq+ZjqcAUa3k2gw4gct2ysu
         wRovqM8iQSWwwbrZGZTKklXxlu6T4l3yUyRHLESZJ2XsPmDiuxc71Yd/GRAI4e6EXHGt
         hbXD1FYKxuO4y5CRU80hoQGPAlC1VL5aMioC8Xz3ifLurCbw1nZ7EUSoategWPQ91km9
         Dkow==
X-Gm-Message-State: AOJu0YxP3egXGS8gfFdb87XEr9rea6me9Dv30Yv1sGlxh7hO3ORlL6lL
	63aWr7opPcJSnX/JeUkHG1MZEhvuKKQ3LW0FjApObvqt6W4/vlRQ2lgR2T9+
X-Gm-Gg: AY/fxX74Gp6q/7YdKOrlMRCqdtFBNBhBrKflC5sEwAS5yt9xlKZZZSHPguelJF4Sh66
	FKkrxtr4bZ3n5vnb6WterK8oV2I66D4tnHY7A4OsxLNxwEOnoMriNgMSR51Xv8wEyB250JT8XRa
	iv5YzBUdM2Ur4+qukhaVUqiOY+mPQjnAxT7VFOk/uaGY9rntdCdX8ly6Zqdodk5ywTT0pjkdoDn
	Q+3NOc0ymknMz7Zlf1CVekDtLgoh7oJIUnVuhGwgcX1toy5o2VlIvVXJotya1Al/v0gAbm2PFNS
	/tEF2kVWpDzVYjSYzQmbSht8j9nMDHY6NQ5dsKd7mfFIDXi0TZqh6v4rSuYSY99UOuR81UAv6w/
	/fLYhuZ14xPdJnb+zoBHv5R2QkwpvWk4T0sKUX3CleVW/vTzsuPQ9z/PiTu4AcLE3q/6E0Co3zI
	FmJe7JUd/cZSJ6xm3i2VCE
X-Google-Smtp-Source: AGHT+IEAqeMIDhK+f/ZJDeUorxR8/oEQnp2bw9uHrtBZm1kdrq7o6FrAZ251LEGgaY+X/yNUZHh75Q==
X-Received: by 2002:adf:f7cf:0:b0:42f:b555:5274 with SMTP id ffacd0b85a97d-42fb55553f5mr13925210f8f.20.1765912387191;
        Tue, 16 Dec 2025 11:13:07 -0800 (PST)
Received: from slim.tail1db9c.ts.net ([31.223.101.104])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4310ade81absm652655f8f.21.2025.12.16.11.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 11:13:05 -0800 (PST)
From: Cihangir Akturk <cakturk@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-kernel@vger.kernel.org,
	Cihangir Akturk <cakturk@gmail.com>,
	syzbot+87badbb9094e008e0685@syzkaller.appspotmail.com
Subject: [PATCH] Bluetooth: hci: fix refcounts in LE remote features command
Date: Tue, 16 Dec 2025 22:12:55 +0300
Message-ID: <20251216191255.882653-1-cakturk@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KASAN reported a slab-use-after-free in le_read_features_complete()
running from hci_cmd_sync_work.  le_read_features_complete() can run
after hci_rx_work/hci_conn_del() has removed the link, so the destroy
callback may touch a freed hci_conn and trigger a KASAN use-after-free.
Duplicate submissions also need to drop the references to avoid leaking
the hold and blocking teardown.

Fix this by taking hci_conn_get() before queueing, passing the conn
directly as work data, and balancing hci_conn_hold()/drop() and
hci_conn_get()/put() in the completion and all error/-EEXIST paths so
the connection stays referenced while the work runs and is released
afterwards.

Reported-by: syzbot+87badbb9094e008e0685@syzkaller.appspotmail.com
Signed-off-by: Cihangir Akturk <cakturk@gmail.com>
---
 net/bluetooth/hci_sync.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

I am not entirely sure that removing the err == -ECANCELED early return
is strictly correct. My assumption is that, with the changes in this
patch, there does not appear to be another cancellation path that
reliably balances hci_conn_drop() and hci_conn_put() for this command.
Based on that assumption, keeping the early return could leave the
references taken before queuing unbalanced on cancellation, so I opted
to remove it to keep the lifetime handling consistent.

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index a9f5b1a68356..5a3d288e7015 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -776,14 +776,23 @@ _hci_cmd_sync_lookup_entry(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
  * - Lookup if an entry already exist and only if it doesn't creates a new entry
  *   and queue it.
  */
-int hci_cmd_sync_queue_once(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
+static int __hci_cmd_sync_queue_once(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
 			    void *data, hci_cmd_sync_work_destroy_t destroy)
 {
 	if (hci_cmd_sync_lookup_entry(hdev, func, data, destroy))
-		return 0;
+		return -EEXIST;
 
 	return hci_cmd_sync_queue(hdev, func, data, destroy);
 }
+
+int hci_cmd_sync_queue_once(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
+			    void *data, hci_cmd_sync_work_destroy_t destroy)
+{
+	int ret;
+
+	ret = __hci_cmd_sync_queue_once(hdev, func, data, destroy);
+	return ret == -EEXIST ? 0 : ret;
+}
 EXPORT_SYMBOL(hci_cmd_sync_queue_once);
 
 /* Run HCI command:
@@ -7338,10 +7347,8 @@ static void le_read_features_complete(struct hci_dev *hdev, void *data, int err)
 
 	bt_dev_dbg(hdev, "err %d", err);
 
-	if (err == -ECANCELED)
-		return;
-
 	hci_conn_drop(conn);
+	hci_conn_put(conn);
 }
 
 static int hci_le_read_all_remote_features_sync(struct hci_dev *hdev,
@@ -7408,12 +7415,20 @@ int hci_le_read_remote_features(struct hci_conn *conn)
 	 * role is possible. Otherwise just transition into the
 	 * connected state without requesting the remote features.
 	 */
-	if (conn->out || (hdev->le_features[0] & HCI_LE_PERIPHERAL_FEATURES))
-		err = hci_cmd_sync_queue_once(hdev,
-					      hci_le_read_remote_features_sync,
-					      hci_conn_hold(conn),
-					      le_read_features_complete);
-	else
+	if (conn->out || (hdev->le_features[0] & HCI_LE_PERIPHERAL_FEATURES)) {
+		hci_conn_get(conn);
+		hci_conn_hold(conn);
+		err = __hci_cmd_sync_queue_once(hdev,
+						hci_le_read_remote_features_sync,
+						conn,
+						le_read_features_complete);
+		if (err) {
+			hci_conn_drop(conn);
+			hci_conn_put(conn);
+			if (err == -EEXIST)
+				err = 0;
+		}
+	} else
 		err = -EOPNOTSUPP;
 
 	return err;
-- 
2.52.0

