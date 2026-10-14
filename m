Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E0C4DDB5D
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 13:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791983127; cv=none; b=RVVBv4C8yjkwOxtGG3KXxFpWQS2wmmck9GbgvuaZa97O4mbl4MpNk6m2dfqexmvn+qkHIHK6ttFcmiF+NF0UpvZ1yaDTStUpGxJhC6ZBp6AlvORG8Ur7/vpqmWBEjonVt4V2Ar/RodhtkKDr7GxB0RxMXuE3dppBzJl+GKioGlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791983127; c=relaxed/simple;
	bh=brlJu40iEjxawLQ6+g97MEPWypNKonyh9EefVwMm348=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sA3CN9iT84MvgJSmAgs09xe7YKgTyPg7g155GNUhh7KClm0r2aZEeBxmeAEuR4lKlBjdi7pHNWRVHYdII5QAJnVRAKl73oZE17XJ4okEzQZ6SAK6oKjDhh0fmZkJ8hs0YEoIiwvLJuXwuiURvV/6eL/OBVCZJrCDmGblI/sMDk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6AzjYp2; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6AzjYp2"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5bce4e278baso1015959e87.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 06:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791983124; x=1792587924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YK2/pjkkyflpNJ7QeYJrepnpMuIMjBVd9BqxAZIcz2g=;
        b=d6AzjYp2z0fI98OT1x5XLpZP6YBzcTEk4mzbs/yxi/dwo1MCrriEz2jTmObyY4EBq4
         v6l6/e/bk1dT01/mzES6rXEznLogjLoXA/JLY0VMRqyvLxdWWb4hWvZ+N2J6hUfRhsO4
         dNnyA3+6VsHDNbfnNhs/eZwfmRS6gPC5a4KziYSodARlCu3HA4U7yT42o7I4p2Z17Hff
         iCeLeTuWyFnak54MNMmmj+fCFvg4imrn3Wa8x0I3roVzVRg8+Nlz1CFH5Hi3fV6IIScw
         XX2BorOb+O3RPFrBJ16j3mtL+mkUapTHtZKmQCd/T8FbYiRUFp/4qUkTd6d88KlGAImS
         G8eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791983124; x=1792587924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YK2/pjkkyflpNJ7QeYJrepnpMuIMjBVd9BqxAZIcz2g=;
        b=tycH2H/sVERnqnjBEdYDIFWDhDSf5wiFtWa8tdJ+xvq1HYiOMF/C8Qxk8UxGdncl0v
         IhCZ+qfZ7Ge9JZOQEKh9yZg2cnzyAooc8cT7EevA4AVWNjbOO1PPQazCCmsEfQe+gnS/
         N8j6XRXX5qtFbrQ1R88GljCdHotzoMBz9MdUBsaOaEsvNR53QTwx96Uth/6v0qQqI2YU
         C27PmUzB/rrbJYmDrgpHARRS2Yze2vldeF3Glfjs+U/oHFJ+mwm0QrsaN4V4/tJSRan0
         pzYrb9DzbSxmWD5kpAXtgLM6ZmdA0a7CYY6uaMSzXGeOVk0YQJDtzm9s00EjproWz2KQ
         vL8A==
X-Gm-Message-State: AFq9FYLpeFnlHBBETIF9p1R7EidsPv6F8oFxEPsJCGBroHWLUk7XP7dx
	ZRzgGiXS7KbNx3tfB9zjaeDP4hpPdxQUAyfg9Zcsdacd4jXUvbfh3bLd
X-Gm-Gg: AYBFou3Q0xVaVV5pRICO0tTRAN3++DOHQ3rD4YVyVXf/eRy54ertQvqFPOXnD5NIDHP
	Nexne/IOWc10x49xCJAlj1fWsAxw9VohljTsSllsZ+DuJJGNe5js3MxS9xh3fDIE+QYpL9/36W3
	3DrR3FpHn16M+ELO1vjOqoYrm7qS9N/YQqP66IM6OdUzByVmIm5F0xSbRuDB9mGicnt1d2opnQ6
	8CrVlH8+v6YKrsNcMn+sA2Dn5bbhPONotdqW7dDfk26HxtGvQi6VLMCizJnfHUp3kupcmuyLYiT
	iDVfOhcItZqBBPPJ3mvyU0+/BMsqVq0IuSdqCN9UuY7qgqu6YBN6fGQ8RFZoN33GOlc7y2cJzuf
	ow6rNyyFmBvapckS2bXW4+l0i6u9r6/8QbATC7t7bDk70WXeVY53bjkvgxo764oJh63keXnfclT
	atJpvWPYbbwNGvo3fedVJc0RxrOjjhR+6uGvpvk29n8YPI6ZxnszV6JN++Q/aGMkBc+jm5PSX6Y
	Eb4u4C1aV0JuP1Q+M6cBd2qR9Q5RfKXaue+3DjismZGm/JdQX39vHq8gy/khRhtVweIDPXBNp+f
	gg==
X-Received: by 2002:a05:6512:3ba3:b0:5b8:b392:b40f with SMTP id 2adb3069b0e04-5bce00aee05mr4886849e87.5.1791983124146;
        Wed, 14 Oct 2026 06:05:24 -0700 (PDT)
Received: from x870steellegend.lan (95-25-166-65.broadband.corbina.ru. [95.25.166.65])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5be33d79c29sm629285e87.32.2026.10.14.06.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 06:05:23 -0700 (PDT)
From: Igor Putko <igorpetindev@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+f20755f37da70df33a16@syzkaller.appspotmail.com,
	Igor Putko <igorpetindev@gmail.com>
Subject: [PATCH] Bluetooth: mgmt: Fix UAF in mesh_send_sync caused by race in mesh queue
Date: Wed, 14 Oct 2026 19:05:04 +0300
Message-ID: <20261014160504.42527-1-igorpetindev@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A race condition between mesh_send() and mesh_next() can lead to the
same struct mgmt_mesh_tx object being queued twice into the cmd_sync
work list.

Specifically, mesh_send_done_sync() and mesh_send_start_complete() clear
the HCI_MESH_SENDING flag before mesh_next() is executed or without
holding hci_dev_lock. If a concurrent mesh_send() arrives during this
window, it observes HCI_MESH_SENDING as cleared, adds the new mesh_tx
to hdev->mesh_pending, and queues it via hci_cmd_sync_queue().
Immediately thereafter, mesh_next() executes without holding
hci_dev_lock, inspects hdev->mesh_pending with mgmt_mesh_next(), and
queues the very same mesh_tx a second time.

When the first queued entry finishes, its completion callback invokes
mesh_send_complete(), which frees the mesh_tx structure. When the worker
subsequently picks up the duplicate second entry, mesh_send_sync()
attempts to access fields in the already freed mesh_tx, triggering a
KASAN slab-use-after-free read.

Fix this by:
1. Synchronizing mesh_next() under hci_dev_lock and checking if
   HCI_MESH_SENDING is already set before queueing.
2. Holding hci_dev_lock when modifying HCI_MESH_SENDING and completing
   mesh transactions in mesh_send_done_sync() and
   mesh_send_start_complete().
3. Unconditionally removing mesh_tx if hci_cmd_sync_queue() fails in
   mesh_send().

Fixes: b338d91703fa ("Bluetooth: Implement support for Mesh")
Reported-by: syzbot+f20755f37da70df33a16@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?id=d2762f31ce58dfcb900c2db500bf361f165c07bc
Signed-off-by: Igor Putko <igorpetindev@gmail.com>
---
 net/bluetooth/mgmt.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 251a896babd5..0dda38af00ec 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1094,13 +1094,15 @@ static int mesh_send_done_sync(struct hci_dev *hdev, void *data)
 {
 	struct mgmt_mesh_tx *mesh_tx;
 
-	hci_dev_clear_flag(hdev, HCI_MESH_SENDING);
 	if (list_empty(&hdev->adv_instances))
 		hci_disable_advertising_sync(hdev);
-	mesh_tx = mgmt_mesh_next(hdev, NULL);
 
+	hci_dev_lock(hdev);
+	mesh_tx = mgmt_mesh_next(hdev, NULL);
 	if (mesh_tx)
 		mesh_send_complete(hdev, mesh_tx, false);
+	hci_dev_clear_flag(hdev, HCI_MESH_SENDING);
+	hci_dev_unlock(hdev);
 
 	return 0;
 }
@@ -1109,18 +1111,30 @@ static int mesh_send_sync(struct hci_dev *hdev, void *data);
 static void mesh_send_start_complete(struct hci_dev *hdev, void *data, int err);
 static void mesh_next(struct hci_dev *hdev, void *data, int err)
 {
-	struct mgmt_mesh_tx *mesh_tx = mgmt_mesh_next(hdev, NULL);
+	struct mgmt_mesh_tx *mesh_tx;
+	int ret;
 
-	if (!mesh_tx)
+	hci_dev_lock(hdev);
+
+	if (hci_dev_test_flag(hdev, HCI_MESH_SENDING)) {
+		hci_dev_unlock(hdev);
 		return;
+	}
 
-	err = hci_cmd_sync_queue(hdev, mesh_send_sync, mesh_tx,
-				 mesh_send_start_complete);
+	mesh_tx = mgmt_mesh_next(hdev, NULL);
+	if (!mesh_tx) {
+		hci_dev_unlock(hdev);
+		return;
+	}
 
-	if (err < 0)
+	ret = hci_cmd_sync_queue(hdev, mesh_send_sync, mesh_tx,
+				 mesh_send_start_complete);
+	if (ret < 0)
 		mesh_send_complete(hdev, mesh_tx, false);
 	else
 		hci_dev_set_flag(hdev, HCI_MESH_SENDING);
+
+	hci_dev_unlock(hdev);
 }
 
 static void mesh_send_done(struct work_struct *work)
@@ -2309,9 +2323,12 @@ static void mesh_send_start_complete(struct hci_dev *hdev, void *data, int err)
 	/* Report any errors here, but don't report completion */
 
 	if (mgmt_err) {
+		hci_dev_lock(hdev);
 		hci_dev_clear_flag(hdev, HCI_MESH_SENDING);
 		/* Send Complete Error Code for handle */
 		mesh_send_complete(hdev, mesh_tx, false);
+		hci_dev_unlock(hdev);
+
 		if (err != -ECANCELED)
 			mesh_next(hdev, NULL, 0);
 		return;
@@ -2541,10 +2558,8 @@ static int mesh_send(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_MESH_SEND,
 				      MGMT_STATUS_FAILED);
 
-		if (mesh_tx) {
-			if (sending)
-				mgmt_mesh_remove(mesh_tx);
-		}
+		if (mesh_tx)
+			mgmt_mesh_remove(mesh_tx);
 	} else {
 		hci_dev_set_flag(hdev, HCI_MESH_SENDING);
 
-- 
2.47.3

