Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415232E40B
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Mar 2025 16:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741276815; cv=none; b=Lgi5vgMpPJt+3Dpz/fGqsGgj5wfNSUQeCG9kNjrYjSgpMBH8F9kkfV+R8mgwuaPvmaPzp7bFMYhxH8Z3kT5C9u5W41pe9SnTTdzjwpqroQbUiKhVbCkKMAqRQFoKlfi4WG9BFcPhb3Ev90t3SbQo+Zn/5JmnZPjKqnXPhh8Zu7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741276815; c=relaxed/simple;
	bh=FkdWNHTMthc/CVmnY/+FD/4nHaJoiMBD+zH72jALQOE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=LFlZDf64Y5F2qaDkQIpfiv9RFJWRuy+iTxDS8sGr0+/gfOSgOj51HarL/k3T2icWnKACbjaKHhoc0Z7Ijcd5apa2IeOr2FHgenB/oX8jOyspZYUhGj7YxeUQLU7gEKFHpEs3qTiGUc4zuE9eJCkRijAqgY9hsd9by62UOs/Bgzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y/8eda8h; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/8eda8h"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-86b9ea43955so327822241.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Mar 2025 08:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741276812; x=1741881612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=uVKWQRo8u9NriPEZoO4/DBzkDGtE0sSHbOQE0Dld1Gw=;
        b=Y/8eda8hGcfmm0+rcPYaguj8C+aQ0kTij01U3r3es6ImNer+atxZhyKfyX8HXc5UEP
         3FNilntyOg4SvfF6MR+pI3LHz4w1wygioGim/LNPo019nQMyjHJSI4UdF9rg5vybJaOW
         f+SZ8ASgI3lIeoeO+62jcP/9kUAbnB7dyt3gsy07sK/AZxrNf/Pi31iP61slUhB7vJuA
         RAesG4+jPY4vapu4fSBJQFeE4RBKFDEkRFYKYyZm0/uxzAG3mqdUpE8xIDgah/w7E55A
         LZhmYdQf0y6CYNCn9QGSOrZY/Hb10qdgVPKxyUom3mtfMtUFJUa4lsv0FjKdTZ70NzhY
         Ta+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741276812; x=1741881612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uVKWQRo8u9NriPEZoO4/DBzkDGtE0sSHbOQE0Dld1Gw=;
        b=Ijvr2scUsmWBVVE6zt//0WngQZNB7vo8BHl8mmIhhh2UjZPRJ/REVhH+/HIvbb2pPU
         TvbR34ret8PxRrE09g4PjgC7JTNDoOk5s2a8+HOmQAgLHnkmp+cSdr0eSrTZX9/UOqD3
         SJ7vfihtiLGYiNd7LgngjKcYtEvQzscatk0apCwSjEACQU0H2RNeu1dxnygcjCn2GtsT
         orK+e1vq73epVFFThuh9/nagpTwjFgQcUdhHVo4GAV9vVbKH4S5PG6mOpqSYtygM68UB
         deys/4Mg82u4xL4aV88ghpuGFMgNQfF70wgw000PTEofHDJtCIHlcbBVxS+UzojbsVnn
         95Rg==
X-Gm-Message-State: AOJu0YxsEOzp6uwggFpUHuDoHbbtnguTLDacOk6ge5LzMOkZqJpKC9mZ
	Yd9TLM3xThMf1L9C0olRlqm/uK6xi6fJs50G3zjGmi24Yhe5yok+uOSHZPtw
X-Gm-Gg: ASbGnctKzXJbEJafXg6I/O8g4gnEK01+53O1RYt3QNkxySlLwCQAglpCQF8rEelrCsP
	5FVo5rgS8O7dSFDPUQrWa0HQvUtRXidT/MkDUlZPR/coAqrz37OvwM83jbmi0jmCokoN5y3tXQS
	Z5wJAimUAOyGyBBKrQRDeowUaaAA/34Cu2jCvibR+wWcNGzKW+sAGvNLnJxz/aS0Nyb2NtdapiK
	QzeLNcEDT1OWHhurM6gcMLR6E4UeqFzF8X7w1Pz8kQ2eBkYaQyCf68e13uKVHoUsDvOi34WIrtH
	knsbLF+MXtLy1l9qDuZsSPR5iOL0hzELrvBW7f67EHa51z/9CUeoTKgzHofvb/G8ftvVyTUErtN
	b+n7dMosKFrho0g==
X-Google-Smtp-Source: AGHT+IGv7jGG7pHpqMmJ4EPo++Qv4aCdlMd+rR/Q4SROgFXQ0zdkAePd6YGmML3x10o3pnGDMJ5/TA==
X-Received: by 2002:a05:6102:6d2:b0:4c3:5de:b6c2 with SMTP id ada2fe7eead31-4c305debdd8mr1099308137.11.1741276811637;
        Thu, 06 Mar 2025 08:00:11 -0800 (PST)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c2fb459a40sm301946137.12.2025.03.06.08.00.08
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 08:00:09 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] btdev: Fix scan-build warnings
Date: Thu,  6 Mar 2025 11:00:03 -0500
Message-ID: <20250306160003.587816-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following scan-build warnings:

emulator/btdev.c:1126:10: warning: Although the value stored to 'conn' is used in the enclosing expression, the value is never actually read from 'conn' [deadcode.DeadStores]
 1126 |         while ((conn = queue_find(dev->conns, match_handle,
      |                 ^      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1127 |                                         UINT_TO_PTR(handle))))
      |                                         ~~~~~~~~~~~~~~~~~~~~
emulator/btdev.c:1413:24: warning: Access to field 'link' results in a dereference of a null pointer (loaded from variable 'conn') [core.NullDereference]
 1413 |         pending_conn_del(dev, conn->link->dev);
      |                               ^~~~~~~~~~
emulator/btdev.c:1535:13: warning: Access to field 'dev' results in a dereference of a null pointer (loaded from variable 'conn') [core.NullDereference]
 1535 |         send_event(conn->dev, BT_HCI_EVT_AUTH_COMPLETE, &ev, sizeof(ev));
      |                    ^~~~~~~~~
---
 emulator/btdev.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index ec52c5242df0..77d44ad84548 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -1123,8 +1123,7 @@ static struct btdev_conn *conn_new(struct btdev *dev, uint16_t handle,
 {
 	struct btdev_conn *conn;
 
-	while ((conn = queue_find(dev->conns, match_handle,
-					UINT_TO_PTR(handle))))
+	while (queue_find(dev->conns, match_handle, UINT_TO_PTR(handle)))
 		handle++;
 
 	conn = new0(struct btdev_conn, 1);
@@ -1410,8 +1409,6 @@ static int cmd_add_sco_conn(struct btdev *dev, const void *data, uint8_t len)
 	cc.encr_mode = 0x00;
 
 done:
-	pending_conn_del(dev, conn->link->dev);
-
 	send_event(dev, BT_HCI_EVT_CONN_COMPLETE, &cc, sizeof(cc));
 
 	return 0;
@@ -1527,9 +1524,12 @@ static void auth_complete(struct btdev_conn *conn, uint8_t status)
 {
 	struct bt_hci_evt_auth_complete ev;
 
+	if (!conn)
+		return;
+
 	memset(&ev, 0, sizeof(ev));
 
-	ev.handle = conn ? cpu_to_le16(conn->handle) : 0x0000;
+	ev.handle = cpu_to_le16(conn->handle);
 	ev.status = status;
 
 	send_event(conn->dev, BT_HCI_EVT_AUTH_COMPLETE, &ev, sizeof(ev));
-- 
2.48.1

