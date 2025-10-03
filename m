Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAEE12E1E9
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Oct 2025 19:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759518464; cv=pass; b=peLQ8P1RerYrdN8M+yrzq4TIg5dmrH4ll1mWKfO04sZ7+eZhVoff87S+Zok0EgzOBouj0nuOTrKt+VYWYiZc7820zO2clZujbWHjk6PQ40CJP9OHZA3OtgdCemdT7nDUswMLw8X+hJ89zulokfw2KhWRdzo83qCMlNZiBHabe14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759518464; c=relaxed/simple;
	bh=WpfcRXSs6+Fu1GcfHsfcCqF2WTDmjp4174lNzm8fTsI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WWu/4duzqlLtYtcWBPZyTkdPKFCtVg6bLQbj6wScrkOmPe/QgEJ/T8DrzQZgDL8o/pZv20IBf2tfzagubRzULs3yCVviieHKMx1fgsN50FUN4fRz8OK01FHAAJksxRIJo8xCvaTN85bl2zwUmxGdcmHYSh0Swg9BuheLTGC0XsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=cHObfZ+I; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="cHObfZ+I"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a01d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4cddTP1LZszyRk;
	Fri,  3 Oct 2025 22:07:37 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1759518457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=s+aDxbwXA4E0xiDC63cvhDfNyOWczpxns15cuEax5cw=;
	b=cHObfZ+IEZPZhzlPA98h7edf5eRsgzzqOB5iuuDkGmi/ACnjTiW1cqJCsdFDn5MoBIBf2Z
	X+d++1CZIHPK6ODS+Sj1Xs03anPfluks5gscpyNCigFKwwfizhJnilHu1QYLoZscvxckAo
	nLAsX9NX7JjNvPW2Cpco8dIkfLxh9Cg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1759518457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=s+aDxbwXA4E0xiDC63cvhDfNyOWczpxns15cuEax5cw=;
	b=XgDct8xtzxcREsltcmCoiLQ1FMiajELe/3FRIbVOWM2Xfzjip9wJIaqNG2w1x7z9uYiOzM
	YhXtOJS1qYo6z3Y5r+zeG/zbup9vIhFnxM7WsmffbeWk/Rl/cBZiQnXNiuYQPLhRNeX9IA
	twKHsEfr0IeYkfe40HJ12hOpLY3Sil8=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1759518457; a=rsa-sha256; cv=none;
	b=Jk6uLn78Yjbhx+GMwDdl+qH20nJsPITjzlWO3kpX4CZ42R0G33JLULsaQQmdTkPKGewi0F
	cABLnHS5u86e5MYhbA2leJLJTi0Vi3NSF73kJbR54hGa53rQwLNYg4V9DDthjw5AYtIYmW
	eQ8SQ+/NnRuQUw4WtswM/bFxcsLAHbU=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH] Bluetooth: MGMT: fix crash in set_mesh_sync and set_mesh_complete
Date: Fri,  3 Oct 2025 22:07:32 +0300
Message-ID: <f206fc905f5c747b309d6063acd0128189661576.1759517776.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a BUG: KASAN: stack-out-of-bounds in set_mesh_sync due to
memcpy from badly declared on-stack flexible array.

Another crash is in set_mesh_complete() due to double list_del via
mgmt_pending_valid + mgmt_pending_remove.

Use DEFINE_FLEX to declare the flexible array right, and don't memcpy
outside bounds.

As mgmt_pending_valid removes the cmd from list, use mgmt_pending_free,
and also report status on error.

Fixes: 302a1f674c00d ("Bluetooth: MGMT: Fix possible UAFs")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 include/net/bluetooth/mgmt.h |  2 +-
 net/bluetooth/mgmt.c         | 26 +++++++++++++++-----------
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 74edea06985b..bca0333f1e99 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -853,7 +853,7 @@ struct mgmt_cp_set_mesh {
 	__le16 window;
 	__le16 period;
 	__u8   num_ad_types;
-	__u8   ad_types[];
+	__u8   ad_types[] __counted_by(num_ad_types);
 } __packed;
 #define MGMT_SET_MESH_RECEIVER_SIZE	6
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index a3d16eece0d2..24e335e3a727 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2175,19 +2175,24 @@ static void set_mesh_complete(struct hci_dev *hdev, void *data, int err)
 	sk = cmd->sk;
 
 	if (status) {
+		mgmt_cmd_status(cmd->sk, hdev->id, MGMT_OP_SET_MESH_RECEIVER,
+				status);
 		mgmt_pending_foreach(MGMT_OP_SET_MESH_RECEIVER, hdev, true,
 				     cmd_status_rsp, &status);
-		return;
+		goto done;
 	}
 
-	mgmt_pending_remove(cmd);
 	mgmt_cmd_complete(sk, hdev->id, MGMT_OP_SET_MESH_RECEIVER, 0, NULL, 0);
+
+done:
+	mgmt_pending_free(cmd);
 }
 
 static int set_mesh_sync(struct hci_dev *hdev, void *data)
 {
 	struct mgmt_pending_cmd *cmd = data;
-	struct mgmt_cp_set_mesh cp;
+	DEFINE_FLEX(struct mgmt_cp_set_mesh, cp, ad_types, num_ad_types,
+		    sizeof(hdev->mesh_ad_types));
 	size_t len;
 
 	mutex_lock(&hdev->mgmt_pending_lock);
@@ -2197,27 +2202,26 @@ static int set_mesh_sync(struct hci_dev *hdev, void *data)
 		return -ECANCELED;
 	}
 
-	memcpy(&cp, cmd->param, sizeof(cp));
+	len = cmd->param_len;
+	memcpy(cp, cmd->param, min(__struct_size(cp), len));
 
 	mutex_unlock(&hdev->mgmt_pending_lock);
 
-	len = cmd->param_len;
-
 	memset(hdev->mesh_ad_types, 0, sizeof(hdev->mesh_ad_types));
 
-	if (cp.enable)
+	if (cp->enable)
 		hci_dev_set_flag(hdev, HCI_MESH);
 	else
 		hci_dev_clear_flag(hdev, HCI_MESH);
 
-	hdev->le_scan_interval = __le16_to_cpu(cp.period);
-	hdev->le_scan_window = __le16_to_cpu(cp.window);
+	hdev->le_scan_interval = __le16_to_cpu(cp->period);
+	hdev->le_scan_window = __le16_to_cpu(cp->window);
 
-	len -= sizeof(cp);
+	len -= sizeof(struct mgmt_cp_set_mesh);
 
 	/* If filters don't fit, forward all adv pkts */
 	if (len <= sizeof(hdev->mesh_ad_types))
-		memcpy(hdev->mesh_ad_types, cp.ad_types, len);
+		memcpy(hdev->mesh_ad_types, cp->ad_types, len);
 
 	hci_update_passive_scan_sync(hdev);
 	return 0;
-- 
2.51.0

