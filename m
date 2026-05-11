Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE9E3FD15F
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 14:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778510070; cv=none; b=ju60QkV76UrroLxUzBl5GO/aBM+rUgGrTOp0OFeTyYKouOlMa2c6nKKWPEieh2cFfoBt8NxT+t1KIRM65od4AeXeAP/GlF44jTKascRWnrDg01Pok+v/TcNZEY3lK1XyIcuFan0uGzUPcaCKvcNj+Y2Yk0GdoXI5DpNxB7FBap4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778510070; c=relaxed/simple;
	bh=YfQBPQevPYy6KNEQoGGylmuoML0doP9gf/WL6NN7rD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jghzuKWrGM+u+yW2I7JOb6vKaT2LW3ijPWrb0J1tq0/u04xt7OCV9e31vm93gtxosQ3LfNQAMsrUVMKPSLVZzZEmDe6iK0G1T4UqJt3SFSHJcrAZy75eoqH5Aeajm4L4hv8Tux5OHpmneqvk+pGyUkeTFU/XQbimxZifQz/0GEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mgyXpWtA; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgyXpWtA"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50e5c7eb565so42861981cf.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 07:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778510067; x=1779114867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H9wLQan2nN7eJ+L05d+IVGFJIfDrs/6xj1WgA6VgIXY=;
        b=mgyXpWtAZItRMUrplVrjLGFLAbdt1IiVgETfNpAp5ZYavJAZfJD4rlQhtgAT/7fU6w
         LgENAPsX1AEXjTGRN+jG5D/nbxPIjQZhgyy+KnakR98ik5JUziBhLllmvaZXEqc7D/bq
         e8lGfsP632l3lNguCtwroEqWkCeEp58xNWzYZ+ADAbI9A1yuCmsBe74JiR5NNoH9PByk
         OuhGZNQNpqiuK308yDBNUNYWcNhC6Kl1QZo7+unHQw+h0AxaNx+EOB+58MfoeplWdZM8
         cswM4kCaQsigdj56XE4eYFPeM6SbhzfEh7WxY1usNUEJI2Z+G3GhJeqsrmquuEW+oPaQ
         N1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778510067; x=1779114867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H9wLQan2nN7eJ+L05d+IVGFJIfDrs/6xj1WgA6VgIXY=;
        b=M6baJenwAw3GyK/ZaYvw9xCGPd3s4p7OYgUPiqRbRGcNGN6qFK+BTT+B0zpFEtJu0Q
         C5bndZBvGjfqwFmUv9mg3l/EIxxudo7iQj5B+asjMVhLgdtXv1KRkbIM/FiomGegWd2H
         ku0cA9F2WK1jaRc5+f2kKhqlMvukS3YtFs3NZOsLCBWiUJVqq0O4B+Hqm3yumTcFUBfT
         CohO5Rzu8j29J0+Dyv7Mdd6xrDWYdZSdjPsJcFP+IOSVenRBj2pv/RYVmn2HTQ3u5DJN
         ALq+djVC5PmSvtKS9sZoHK7jke3US0DJerkp7jQUgFxlskRMZS0hZo8kAJqAsDL2bPEu
         +Trw==
X-Forwarded-Encrypted: i=1; AFNElJ8gCW0i6qZHLNHPYT38WDwyTg9wouKGn7/oI5hrH3tV9s0Pd2menlltS63Zcqh/+EYiYKsKHFJb+rfLFZSMOz0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0xetBKqZWVeVk52VXJeXT0EwFLP9+TNYjGtA1QRHe/EVHLqV7
	1T0s3QZMzeF9MNdRYSbJcjl+AlX3sr3ZO5abDd1AwPEoMqQJgHhZFA3b/sC9q83h
X-Gm-Gg: Acq92OGUdcjbet6qBw6CSI0nbomoeplaYJmiSWrE1SngRDE1T1CQRcoeFr9YpLOBygi
	YkN1uCsNJ3K0hajFX3SuG9f50bYSwZrBcjG2AxGhWfw0k5JNlJ0h9ZFYlADuQjiKHUh4tbjmeEa
	JzeGkdnWI+LfHPA4HAk3WSSDv2IX75e5NcNy67VsCm6yl8BUwKWj4RSvoOkbbtSyxJTBSIsc5Ur
	9DwR5qUgD663FXJnL+PAwtr4OUwtJvj4sLLXeeioZbQdqy6D4YFXpgxMoGC8sGr1jQke5pc+gB0
	1sPA05Rk3k84eKErB005ryyVVjDypONycUOsFpidd34WlqJyCfQrFgKACiSX2BhoKkV+iT5cZtf
	3yIfQcO5hq0JPiKQYicPXneh6C4YtX1lIX54owWnIPppcXV2mENiCFBvynJuG5gv8oCSKeOk+np
	/EIqC5yE7YQiTS7z47otffW+J6Ez/mo8Adu5EMlmdChyTANOWSMOObpQhdVJszNdpzJi0ZU2MbN
	seuHd/b5a7Ca7GpsnxKqwkkTLFU8u+UMVUbSFwvnJJrVtCGo4XHvw==
X-Received: by 2002:a05:622a:48:b0:50e:a1aa:2cd9 with SMTP id d75a77b69052e-51461c04ebbmr342766301cf.15.1778510066287;
        Mon, 11 May 2026 07:34:26 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e83aa2bsm90605371cf.28.2026.05.11.07.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 07:34:25 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mat Martineau <martineau@kernel.org>,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	Pauli Virtanen <pav@iki.fi>,
	Aaron Esau <git@aaronesau.com>,
	Michael Bommarito <michael.bommarito@gmail.com>
Subject: [PATCH 1/4] Bluetooth: hci_sync: pin conn across hci_le_create_conn_sync
Date: Mon, 11 May 2026 10:34:01 -0400
Message-ID: <490e228dd02983fb1530fb114d4174148f810261.1778506829.git.michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1778506829.git.michael.bommarito@gmail.com>
References: <cover.1778506829.git.michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_le_create_conn_sync() runs from the cmd_sync workqueue with a
struct hci_conn pointer it interprets out of the work item's void
*data argument. The hci_conn_valid() check at function entry is a
TOCTOU: nothing prevents hci_disconn_complete_evt() (executing on
hdev->workqueue rx_work) from running between the
hci_conn_hash_lookup walk in hci_conn_valid() and the body's first
deref. hci_disconn_complete_evt() -> hci_conn_del() -> hci_conn_cleanup()
unregisters the device and drops the final kref, which kfrees the
hci_conn slot. The cmd_sync callback then writes through the freed
pointer (clear_bit on conn->flags, conn->state, the four
le_conn_*_interval fields).

A KASAN slab-use-after-free splat in cache kmalloc-8k confirms the
bug on linux-next tip commit bee6ea30c487 ("Add linux-next specific
files for 20260421") under UML+KASAN, matching the slab geometry of
the syzbot trace fixed in commit 035c25007c9e ("Bluetooth: hci_sync:
Fix UAF in le_read_features_complete").

Follow the reference-pinning pattern from commit 035c25007c9e
("Bluetooth: hci_sync: Fix UAF in le_read_features_complete") and
commit 0beddb0c380b ("Bluetooth: hci_conn: fix potential UAF in
create_big_sync"): the queue site takes a reference via
hci_conn_get() so the slot is not freed between
hci_disconn_complete_evt() retiring the conn and the cmd_sync
callback / completion handler returning. The completion handler
drops the reference on every exit path, including the -ECANCELED
short-circuit.

Introduce a static helper hci_cmd_sync_queue_conn_once() so the
get/put pair is not open-coded at every queue site. See the
helper's kerneldoc for the -EEXIST contract.

The hci_conn_valid() check in the callback body is retained: a
logically-deleted-but-still-referenced conn has stale
hdev->conn_hash.list state, and continuing to drive a connection
attempt on it would be a logic bug even though the memory is safe.

Pauli Virtanen posted a series-wide variant of this fix as
https://lore.kernel.org/linux-bluetooth/e18591f264c50e15917cb8b9e5f9798d9880979d.1762100290.git.pav@iki.fi/
(PATCH v2 8/8, 2025-11-02). KASAN reproducer captured under
UML+KASAN (linux-next tip bee6ea30c487).

Fixes: 881559af5f5c ("Bluetooth: hci_sync: Attempt to dequeue connection attempt")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 net/bluetooth/hci_sync.c | 41 ++++++++++++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index fd3aacdea512..b20e07474257 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -786,6 +786,31 @@ int hci_cmd_sync_queue_once(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
 }
 EXPORT_SYMBOL(hci_cmd_sync_queue_once);
 
+/* Queue an HCI command entry once, pinning a hci_conn for the duration.
+ *
+ * On success, the cmd_sync queue owns one hci_conn_get() reference;
+ * the supplied destroy callback must hci_conn_put() to balance.
+ *
+ * On any failure return (including -EEXIST, where
+ * hci_cmd_sync_queue_once() neither invokes destroy nor consumes the
+ * data pointer because an existing entry already owns the slot), the
+ * helper releases the reference before returning, so callers do not
+ * need to discriminate failure codes to keep the refcount balanced.
+ */
+static int hci_cmd_sync_queue_conn_once(struct hci_dev *hdev,
+					hci_cmd_sync_work_func_t func,
+					struct hci_conn *conn,
+					hci_cmd_sync_work_destroy_t destroy)
+{
+	int err;
+
+	err = hci_cmd_sync_queue_once(hdev, func, hci_conn_get(conn), destroy);
+	if (err)
+		hci_conn_put(conn);
+
+	return err;
+}
+
 /* Run HCI command:
  *
  * - hdev must be running
@@ -6982,36 +7007,38 @@ static void create_le_conn_complete(struct hci_dev *hdev, void *data, int err)
 	bt_dev_dbg(hdev, "err %d", err);
 
 	if (err == -ECANCELED)
-		return;
+		goto done;
 
 	hci_dev_lock(hdev);
 
 	if (!hci_conn_valid(hdev, conn))
-		goto done;
+		goto unlock;
 
 	if (!err) {
 		hci_connect_le_scan_cleanup(conn, 0x00);
-		goto done;
+		goto unlock;
 	}
 
 	/* Check if connection is still pending */
 	if (conn != hci_lookup_le_connect(hdev))
-		goto done;
+		goto unlock;
 
 	/* Flush to make sure we send create conn cancel command if needed */
 	flush_delayed_work(&conn->le_conn_timeout);
 	hci_conn_failed(conn, bt_status(err));
 
-done:
+unlock:
 	hci_dev_unlock(hdev);
+done:
+	hci_conn_put(conn);
 }
 
 int hci_connect_le_sync(struct hci_dev *hdev, struct hci_conn *conn)
 {
 	int err;
 
-	err = hci_cmd_sync_queue_once(hdev, hci_le_create_conn_sync, conn,
-				      create_le_conn_complete);
+	err = hci_cmd_sync_queue_conn_once(hdev, hci_le_create_conn_sync, conn,
+					   create_le_conn_complete);
 	return (err == -EEXIST) ? 0 : err;
 }
 
-- 
2.53.0

