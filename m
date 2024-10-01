Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2FE1B5ED1
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Oct 2024 16:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727801460; cv=none; b=dYmfWIZ9pC47ZCLIn6S+LTMZ8sDSjTUuJD993tawGmOEU9OLLTXxbV0n0O6FieWGYRyZtDhQV2cXaKxJMYpcWA8e0vW+TGScvgHSvjbHSRkPAqnVAzmql+oO0qjSaIOtNkqz1nigqVzwEIi/E9k49rvAEpTmqgigJinrvavylg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727801460; c=relaxed/simple;
	bh=oywkrPWdJIze2GMUusiiHErWi3KRJJWkhTDIpEG/bo0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=p5cTWCc5mFvF8wghGLkBKavZCb2CGUKB65Nn2kDJ8Q4/zAQKPdXoikb/nwaABxF6peHQjOCNN7kAFbnzrNUkYzG+HsF89rAlC841V68+IdlrtRDwMi9r66fC430o3Dr298fTlViURYiuCc1ZHDHwKO9MAFWnepMax9XWpYkuYkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ej9UaHI8; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ej9UaHI8"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6e20a8141c7so52930497b3.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Oct 2024 09:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727801458; x=1728406258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=zNtOQAbGi1IhGtxsS3Ibk5LfvY73ZB3fuXhVJX0q4Zw=;
        b=ej9UaHI8och0C/a+YzgMgQjdfN4cqiS9sGQoBo6oj76bLYs6wpcalmrw/y6TcBbznu
         VDM/C8Q5nQSo/LFFy1SO6gXrK4c8uczZgm+z5bcRQq/1GOnKtLEhtoaQEgzkA8gefgCk
         6U91+JtbKtQij4xtv3IHVnvfUlwM9TlntK7BHZ8Y96fa/hXe2KD6DyejoDpOQZfuKDqO
         6DbYGHeIZuOxlmAXJepDBtpoiviC9mnhEy/jQ2L0qTQpqyai8mpMmRT2nJxnfWEM/bXH
         KtVwBIfzpT1Q6iSZftRLDHHJNRSyPfV58Dx+DWoSActxkLYQAfqHwiJ8br/8+G9xcYwG
         LOxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727801458; x=1728406258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zNtOQAbGi1IhGtxsS3Ibk5LfvY73ZB3fuXhVJX0q4Zw=;
        b=KVY1RfBp78eMl4bzhquuBsORNtQ6wbR/q4DY54if4C4AoaHuNvB5u533m/D1ri2ews
         V8t0J0RgRmgU1+YuxH0tiN/0qAVPMlu3fbEmoeOMQkX3B4d/u++fpXbJ69EOX0N0qjTg
         Tn6Dw5lM1L9JmlLohHshuMjxr1CGV5YyyDQT3vfWWvl7RDTGNbiPSxPKd3pzsNdY7oJG
         S1JMG1deAqMxrSX/3r6mizd8vFVqI7WFysxwDRVgOJ1XRDGsTd4BRPxHOXLkkb+m+CAk
         9iOn8isT4zHYQpQoLnnefPWwtNVt9G1jhVv+SEHe2K8+FiIN7nW+uAM9Mg4/jSNtqmMd
         vyTg==
X-Gm-Message-State: AOJu0YyG5KDL38uiuhFjIR7Fzg5ilDAavWo45KXOS8hn6+iVRrrofkbE
	1b3wt8qLpO181SqYdXcakwLo6+/M5ieeohj/I0WnJqN1kkPRKgBRlCXGUQ==
X-Google-Smtp-Source: AGHT+IEHCwN7Bsrh5BY/p4xEj5IGtw3g7xbOttBxYDwpRU6tiDiwMqsEDEtdJMg58N0Dr4kmQDVQ1Q==
X-Received: by 2002:a05:690c:86:b0:6e2:f32:bd2c with SMTP id 00721157ae682-6e2a2e14602mr3464487b3.29.1727801457801;
        Tue, 01 Oct 2024 09:50:57 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2452f7c1bsm20247577b3.4.2024.10.01.09.50.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 09:50:57 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: hci_conn: Use disable_delayed_work_sync
Date: Tue,  1 Oct 2024 12:50:55 -0400
Message-ID: <20241001165055.3111289-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes use of disable_delayed_work_sync instead
cancel_delayed_work_sync as it not only cancel the ongoing work but also
disables new submit which is disarable since the object holding the work
is about to be freed.

Reported-by: syzbot+2446dd3cb07277388db6@syzkaller.appspotmail.com
Closes: Reported-by: syzbot+2446dd3cb07277388db6@syzkaller.appspotmail.com
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_conn.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 0c01ece500a9..fb0946eac8a4 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1124,9 +1124,9 @@ void hci_conn_del(struct hci_conn *conn)
 
 	hci_conn_unlink(conn);
 
-	cancel_delayed_work_sync(&conn->disc_work);
-	cancel_delayed_work_sync(&conn->auto_accept_work);
-	cancel_delayed_work_sync(&conn->idle_work);
+	disable_delayed_work_sync(&conn->disc_work);
+	disable_delayed_work_sync(&conn->auto_accept_work);
+	disable_delayed_work_sync(&conn->idle_work);
 
 	if (conn->type == ACL_LINK) {
 		/* Unacked frames */
-- 
2.46.1

