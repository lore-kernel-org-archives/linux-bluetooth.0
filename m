Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FBC2D63F8
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Feb 2026 10:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770631390; cv=none; b=lpWnopU7wZLTm1R4wDdetbanCeJa2Yj3Y8gfZMvcOZqylw7pQhG4P/f+lgff/4gcZpa/rTWZ1imZFjLq7Ldmf499RVFEUm3PZhFx4EN82f9K1ly399oNPW2A1w84kjGFraOe9GgIGD0Z3I6gAfv4riMIetPOFvqpFopZd5XjaC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770631390; c=relaxed/simple;
	bh=5+lRtwgPgmReUX4V0KCfyAGPc0Avl5EmgO8z7ErzUh8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nHzMYOhPk8WG1bO99mwzn6Q+3Ert4qnEr+jQdgXmOsbk6nKM05QXDdRdoOgGglMcPNZgceortdWXa6T2ZM+pVem5FbMgLVSKm09xPixaVB+/0jxHlxBJcUPHL88q/zffuVwKhLlGb+KbYcMREhAaRakqu87xPICfuv8UCdMXxto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JvOOUMyE; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvOOUMyE"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-81ecbdfdcebso1821928b3a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Feb 2026 02:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770631389; x=1771236189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FrvRN4MSZWE5zr7X5X+UXnl0MTUjfN6wQH5wIcRuKCk=;
        b=JvOOUMyEGp6/59wl1pEWPMjp+CAAyEAOfG85PP78bk/fc3ZGEkhIuUUaLeMRbgq5dk
         R1yy3bG2rYGmnwJzamZkeFytZHW7OfRT6Rqd7wy7ALG6z7lDp1/2Awe5/ZXWmwXCLp4k
         VSiy8x88MNaSpQGsjrX1ZRoCrAaK+1BeNYkS7M/WfH5C+qEQN7qK3DftPrWdUNKCjF2P
         8wI7Y2FxqMUKRQabWqvt2aVLJ4h50qGOI1sSyWyVEGVZ6x3XEK/vKK/+hanKGxrGY4y/
         qYd4T27JtS9WJY26HO9FNAPZaafQpFKnBOH01fPRakCNjF+Me66Iv1qI0FNfC7Z93q7P
         TSkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770631389; x=1771236189;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FrvRN4MSZWE5zr7X5X+UXnl0MTUjfN6wQH5wIcRuKCk=;
        b=IOwxXlq+D0kpJy/PEcXn25VOAXM3TZBqZ/xBcHcW6A1IausQl3QRl/Dc2xtOi5GZGi
         VSDdmV1NGmL6qii/MdGgKNISvyXBne9jLz7yRErHWQtxO916qLWcJNaufRWwhCRYRCbg
         oIQuHDsrtLv6z2HIn5SmAp+/SJX9y1b5q/caPCMljR7iqwnKtgrcgd64eUupN7FtmC/k
         njZE3kepQqwEVKaoL8O/B7hjQkNtG0m9WENxeh7NPt9TaTsmnuJTJmdi+MppDRNufvJa
         8bcxJpfVF/eAPHTRhLpxvKnylmsEy33ZiAaIj0oAPuhGqWgh7hXFAMi6g2OltHWqToPz
         l8Ig==
X-Gm-Message-State: AOJu0YxXbFQ2fh9yc9sSeBfT3X0lHdxWyVIn9LOF+LqvL1ojTwXTAqTy
	QjR0/gw5aXWqcuzj8TJsL7kmXwVC4rcy+EXVNDg1I2jd6yglRja+5ysYA27uMzwJ
X-Gm-Gg: AZuq6aJ9vAjNfDQbduGTB+qAZ8epF/BZXwwGNqzFEG6nrjW33PDVaHx7KFFrrE9Tz7q
	ykL4qYqSymyJIJBjpUEOu1+CwDPGzAQgCJMaeeXFve3kWk0F65BCcyaTull0Pr3zpMA2RtaejwD
	1K4eQrdWl2384Xo/fhrgPHlVjsBfM/hxnIN5Nx0U7Pq0BsVk3HiBCGCSyEY3Jt+lZr2Kf52QsAL
	Ppe3Y85DiAlDfD8eaw5ol7I16SpStHMijB4jZtuJJyF2yrISb8OjYRtM6G8zUrU8okQ9jfw3Bqg
	wUFtWqf8RaLc2zRwnIT6dpYnaYPweeD9FGcFAGk6hykT+Tejgi7VR88fQ513BkX3q6c7WL5fFOS
	huNdAGfTVVXLPkd4Jh/IedfwFPlSR2Kc3eYKf/WR8EVuhD/0TECER+KE9CHjYTwr5AXwaKOXi8W
	SRDVZHastbDSyXSpXCOoTisRRbTBe//X+c8TEJaWgRTNbrnyycxzmvWw==
X-Received: by 2002:a05:6a00:1904:b0:821:7d7e:41e0 with SMTP id d2e1a72fcca58-824416098e2mr9602870b3a.5.1770631389158;
        Mon, 09 Feb 2026 02:03:09 -0800 (PST)
Received: from localhost.localdomain ([240d:1a:5cd:bc00:ad05:ab82:7c72:ffef])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824418b5373sm10082527b3a.53.2026.02.09.02.03.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Feb 2026 02:03:08 -0800 (PST)
From: Masahiro Kawada <youjingxiaogao2@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	linux-kernel@vger.kernel.org,
	Masahiro Kawada <youjingxiaogao2@gmail.com>,
	syzbot+3609b9b48e68e1fe47fd@syzkaller.appspotmail.com
Subject: [PATCH] Bluetooth: fix use-after-free in hci_conn_drop
Date: Mon,  9 Feb 2026 19:02:11 +0900
Message-ID: <20260209100211.36533-1-youjingxiaogao2@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a use-after-free in hci_conn_drop triggered via hci_cmd_sync_work.

In hci_conn_del(), hci_cmd_sync_dequeue() is called after
hci_conn_cleanup() which may have already freed the conn pointer.
Fix by moving the dequeue before cleanup.

Additionally, le_read_features_complete() calls hci_conn_drop(conn)
without checking whether conn is still valid. When
hci_le_read_remote_features_sync() blocks waiting for an HCI event,
another thread can free conn through hci_conn_del(). Fix by adding
a hci_conn_valid() check before calling hci_conn_drop().

Fixes: 881559af5f5c ("Bluetooth: hci_sync: Attempt to dequeue connection attempt")
Fixes: a106e50be74b ("Bluetooth: HCI: Add support for LL Extended Feature Set")
Reported-by: syzbot+3609b9b48e68e1fe47fd@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3609b9b48e68e1fe47fd
Tested-by: syzbot+3609b9b48e68e1fe47fd@syzkaller.appspotmail.com
Signed-off-by: Masahiro Kawada <youjingxiaogao2@gmail.com>
---
 net/bluetooth/hci_conn.c | 6 +++---
 net/bluetooth/hci_sync.c | 3 +++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 0795818963a..aa3607327ad 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1232,15 +1232,15 @@ void hci_conn_del(struct hci_conn *conn)
 	skb_queue_purge(&conn->data_q);
 	skb_queue_purge(&conn->tx_q.queue);
 
+	/* Dequeue callbacks using connection pointer as data */
+	hci_cmd_sync_dequeue(hdev, NULL, conn, NULL);
+
 	/* Remove the connection from the list and cleanup its remaining
 	 * state. This is a separate function since for some cases like
 	 * BT_CONNECT_SCAN we *only* want the cleanup part without the
 	 * rest of hci_conn_del.
 	 */
 	hci_conn_cleanup(conn);
-
-	/* Dequeue callbacks using connection pointer as data */
-	hci_cmd_sync_dequeue(hdev, NULL, conn, NULL);
 }
 
 struct hci_dev *hci_get_route(bdaddr_t *dst, bdaddr_t *src, uint8_t src_type)
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index f04a90bce4a..f31086c187f 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -7371,6 +7371,9 @@ static void le_read_features_complete(struct hci_dev *hdev, void *data, int err)
 	if (err == -ECANCELED)
 		return;
 
+	if (!hci_conn_valid(hdev, conn))
+		return;
+
 	hci_conn_drop(conn);
 }
 
-- 
2.43.0
