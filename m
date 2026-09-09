Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387B253444A;
	Wed,  9 Sep 2026 11:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788952231; cv=none; b=pHTq43FPPopGr9KrV5IqJoxUYIjyCN4mm9UejrPkSpm++cCRsLfiTPsYS4HAcTZSTjKVNyrSaY9frtJt+D6cSCIHtu9S/La4k0MZBFS/ZKgubIqE/Mwd8WZlPOdNwrAVSTRy1SLSifhG9qKQ2TeOmgfPnzJN0EcUceFgqpWaL5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788952231; c=relaxed/simple;
	bh=wfAjG3xc4WD+14QS2bjYrzcPuHZ1rp3d4zj4V0Qov5A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=VvcAEVLKr3m1DD9S1FJ3vnNPXtVqsot/8rtjyOUf8gYifhXOK73vjLo7bDLeGN2sW9JHQeUMM6nONbqdhUBTPFYWpoKVCGOhTRCKGZ5V1b4ZvMTtTdiBdx+GiXqboJvzEHJCYzv9qsEQSK4c5F7DR5tgTXxZJtsZ900l+WgHvnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OyHPLpzh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OyHPLpzh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BBF31F00A3D;
	Wed,  9 Sep 2026 11:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788952229;
	bh=MuTYkpEO+OAvSgW8nQ1UXafGJKttePgWaVsiZWUwXB4=;
	h=From:To:Subject:Date;
	b=OyHPLpzhoo38GcvuV/StwErnULHiW2qKE52YRx2k4YavF2dcFhKhCmCTb7TsBeKrd
	 aNiL249qXYr154FK8FfdZCisbnGDhTmAc/XJG6WRLCfUmmuS6SOQkvaSNRqILT+IJU
	 R5jNDD2yjTDmMk7Yybp8Z6qYaZEwyrUGf5jjNOcdcrXGnmXVAdSTAm3AcLX/SP5EIR
	 ++Q5/NzbHDXhHNpCf83RXxbMOCrLeEM3n+Py5pi2AFY6HjqNF+AhCUcXZtvCQLs771
	 caA39Hty6189lj3PRa9oklYzR0HmtPLzfBMywzeNpOySKOFfldpJNr3JC/9WTCZBUC
	 pUydRNWTMe1fA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Brian Gix <brian.gix@intel.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] Bluetooth: mgmt: Dequeue pending mesh_send_sync entries on cancel
Date: Wed,  9 Sep 2026 11:10:20 +0000
Message-ID: <20260909111021.2322753-1-lee@kernel.org>
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
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

v1 -> v2:
  - Advance mesh queue in send_cancel() once cmd_sync_work_lock is released
  - Advance mesh queue on error in mesh_send_start_complete(), skipping -ECANCELED to avoid self-deadlock

 net/bluetooth/mgmt.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 0b2d130e492c..55ccf9b714af 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2290,6 +2290,8 @@ static void mesh_send_start_complete(struct hci_dev *hdev, void *data, int err)
 		hci_dev_clear_flag(hdev, HCI_MESH_SENDING);
 		/* Send Complete Error Code for handle */
 		mesh_send_complete(hdev, mesh_tx, false);
+		if (err != -ECANCELED)
+			mesh_next(hdev, NULL, 0);
 		return;
 	}
 
@@ -2399,20 +2401,29 @@ static int send_cancel(struct hci_dev *hdev, void *data)
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
 	mgmt_pending_free(cmd);
 
+	if (!hci_dev_test_flag(hdev, HCI_MESH_SENDING))
+		mesh_next(hdev, NULL, 0);
+
 	return 0;
 }
 
-- 
2.55.0.1007.g17ff1f9808-goog

