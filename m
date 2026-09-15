Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421B04BFE92;
	Tue, 15 Sep 2026 12:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789474112; cv=none; b=HQLFFQWadSq5qqi07ZDIVmOq4wmqfjSZICK3fuCl6pRoIjLp6eRmgk0P8AQxEl0NmCVqr+MxG5/y6KqmdX6DW1dhLIHm7PSpBalp0ZCbKVHrmT/SWe8cslfw5MVGWgM7VBqlzJWpmSsOqdFruPtwf7urzGNxF8/V4VHNtJWFf2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789474112; c=relaxed/simple;
	bh=Mt3xwPNa6dbedd2vs9TRp1/QS49fucJafqiwOn0pFdM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=WKOmoBDGxVXsP1IFghuHMdNMk+WV1diyWSX1dblDGaplDeO4wl+7aRI2ZO5SkTp7JQjHeaAi11CEhKpCqT9GQLpW3gK3I9rqt6HUHFcn59nJfnaleIsCRRZvRByV/XrUvxjahp8x+zokOiE0E9AWqmuLY1I8aLMV1MorpzRahFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHecZu42; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHecZu42"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF2CD1F000FF;
	Tue, 15 Sep 2026 12:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789474110;
	bh=TZB5HB0TZcEj8cV376kCpobeudedWrWAE5qUo2jHSIs=;
	h=From:To:Subject:Date;
	b=eHecZu42oIgHPfx9YqbGH4NJXPLYnJPMFrxUcw17Jdf8PAFuVmpZfQYm3o3bb1UhV
	 GeE2/yCIojafWMmIZq3EV5EadQnn05h+xGhRmRpL896fiA+AbbLsL2A9n+HJw+iX0U
	 6maiKgXLVwVcuB/p+QOjMQeupZIVHycj83C6Wr+ck/dkwo0LqaRXzfKjoom+tWCg2H
	 8EWCDcAs7mubbidKgL8Lsarh6wKD40rHvF8ay8xL3NS1+tGssZk7l/iNDeg9YSGAIT
	 dzouC0uFuXs90oyYtJ9feTXt8+Xvzad1+qIIlstaBO6fPuaBKgVWif6b/+SEMdJ5tN
	 XGyX1MUJNwRyw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Brian Gix <brian.gix@intel.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/1] Bluetooth: mgmt: Dequeue pending mesh_send_sync entries on cancel
Date: Tue, 15 Sep 2026 12:08:22 +0000
Message-ID: <20260915120823.3460208-1-lee@kernel.org>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In send_cancel(), pending mesh_tx objects are removed from the
hdev->mesh_pending list and freed via mesh_send_complete().  However, if
a mesh transmission was already queued onto hdev->cmd_sync_work_list via
mesh_next(), the queued entry retains a raw pointer to mesh_tx.

When hci_cmd_sync_work later processes the entry, it attempts to execute
mesh_send_sync and its destroy callback mesh_send_start_complete using
the already freed mesh_tx pointer, leading to a use-after-free.

Fix this by invoking hci_cmd_sync_dequeue() for mesh_send_sync on the
target mesh_tx before completing it.  If the entry is found and dequeued,
its destroy callback will complete and free the object; otherwise,
mesh_send_complete() is called directly.

Additionally, ensure the transmission queue advances after cancellation
or errors.  In mesh_send_start_complete(), call mesh_next() on error
unless err is -ECANCELED, because hci_cmd_sync_dequeue() holds
hdev->cmd_sync_work_lock and calling mesh_next() synchronously would
deadlock.  Instead, advance the queue in send_cancel() once the lock is
released and if no transmission is in progress.

Fixes: b338d91703fa ("Bluetooth: Implement support for Mesh")
Signed-off-by: Lee Jones <lee@kernel.org>
---

v1 => v2: Email address switch - no functional change
v2 -> v3:
  - Advance mesh queue in send_cancel() once cmd_sync_work_lock is released
  - Advance mesh queue on error in mesh_send_start_complete(), skipping -ECANCELED to avoid self-deadlock

 net/bluetooth/mgmt.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index fd045460e236..c2cce242958b 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2318,6 +2318,8 @@ static void mesh_send_start_complete(struct hci_dev *hdev, void *data, int err)
 		hci_dev_clear_flag(hdev, HCI_MESH_SENDING);
 		/* Send Complete Error Code for handle */
 		mesh_send_complete(hdev, mesh_tx, false);
+		if (err != -ECANCELED)
+			mesh_next(hdev, NULL, 0);
 		return;
 	}
 
@@ -2427,19 +2429,28 @@ static int send_cancel(struct hci_dev *hdev, void *data)
 		do {
 			mesh_tx = mgmt_mesh_next(hdev, cmd->sk);
 
-			if (mesh_tx)
-				mesh_send_complete(hdev, mesh_tx, false);
+			if (mesh_tx) {
+				if (!hci_cmd_sync_dequeue(hdev, mesh_send_sync,
+							  mesh_tx, NULL))
+					mesh_send_complete(hdev, mesh_tx, false);
+			}
 		} while (mesh_tx);
 	} else {
 		mesh_tx = mgmt_mesh_find(hdev, cancel->handle);
 
-		if (mesh_tx && mesh_tx->sk == cmd->sk)
-			mesh_send_complete(hdev, mesh_tx, false);
+		if (mesh_tx && mesh_tx->sk == cmd->sk) {
+			if (!hci_cmd_sync_dequeue(hdev, mesh_send_sync,
+						  mesh_tx, NULL))
+				mesh_send_complete(hdev, mesh_tx, false);
+		}
 	}
 
 	mgmt_cmd_complete(cmd->sk, hdev->id, MGMT_OP_MESH_SEND_CANCEL,
 			  0, NULL, 0);
 
+	if (!hci_dev_test_flag(hdev, HCI_MESH_SENDING))
+		mesh_next(hdev, NULL, 0);
+
 	return 0;
 }
 
-- 
2.55.0.1032.g73a4cd73de-goog

