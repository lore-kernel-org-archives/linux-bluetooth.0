Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E49E322A;
	Sun,  2 Nov 2025 18:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762107382; cv=pass; b=Y564bvE1fM24O12ysyy1xCi6mY1k7XyhFO/KMvKItUnfXs3KjRADafLsQyykghusSk3gc9I7HrjsZFSyouVBRnGHtID3/0IE9/Qx9HlRSeakmztcyluMDLDZephcgt084U0hbeijsT34VQcyPndd8cF6vrf9otjARKhhJJqttow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762107382; c=relaxed/simple;
	bh=Gb4nWy/GfFqv8FA1XUA+Bu2zOs6sqxFJe5RNqfInOvI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tlw97XC01kiHgxTqm0ibIxKjZ5I8ih0uXbycMJpG5n1mc9PRa5wSjYCnywc9zFOX3fxbm2yUnBSmqsEWyhuHwNX6DqiBVOse2KvcUnohYA9xy2f6/QKeyG80IiZufRPGnPt79t1UnsfM9kcDQrN0oRRlidU2c4bUAjYkGeKSW/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=j1yKkOZj; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="j1yKkOZj"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4d02wJ3J55zyVG;
	Sun,  2 Nov 2025 20:16:16 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1762107377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BE/v2KCLiPwyvYqUFNc4GoZnoh4aW0c3xb1ojfL+sTk=;
	b=j1yKkOZj8C+vBohZFh+RHQfzMVA2xt69tZiwevKXMdts6pqw7C8ocUsJWNTuaKcyHf5jvG
	eikmbt/s9ru1KsbSIchRtYRrsYCivLRRYQMW4C7odeO/PHtTLhenMS9B4VykcHwCD804lk
	MXtU7lywc27sYjP4GsuzAlqzDV0l9Jk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1762107377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BE/v2KCLiPwyvYqUFNc4GoZnoh4aW0c3xb1ojfL+sTk=;
	b=Z597PUqQ7S+hzWdNBcfABBJlepDTUmR31+JsUlVbig8zkvtVsPNlxmhhe1HcBOV8AbvjEb
	ksOcOJiqHjLG+2XEVGL74r2v8dB5kmrD/OY1xUwdR8GuqcGnv7YMLcyt1lh7SzrPiQabT3
	rvD+9O9kCZ1giisQyqays/MzIZgSHMY=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1762107377; a=rsa-sha256; cv=none;
	b=UZI2UlUrtcBd2NLRlzFioAN54boT2/A/A2KoJMlOmMjsCRu+CrIwvAwfOR7LS6IyVC7PG6
	QwemFlEblH3PQx4aJL5U6pQ5sJVi4bKiKATeba/x5yxSgeT8ZkTrHuhBPOEQnVPlNorHgm
	sDJMkO90XiZxQIuxQdLJ4fcAuffixc4=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	brian.gix@intel.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: MGMT: cancel mesh send timer when hdev removed
Date: Sun,  2 Nov 2025 20:16:12 +0200
Message-ID: <75b74d712d9eff4d79f05476973c004c226c08bc.1762107269.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mesh_send_done timer is not canceled when hdev is removed, which causes
crash if the timer triggers after hdev is gone.

Cancel the timer when MGMT removes the hdev, like other MGMT timers.

Should fix the BUG: sporadically seen by BlueZ test bot
(in "Mesh - Send cancel - 1" test).

Log:
------
BUG: KASAN: slab-use-after-free in run_timer_softirq+0x76b/0x7d0
...
Freed by task 36:
 kasan_save_stack+0x24/0x50
 kasan_save_track+0x14/0x30
 __kasan_save_free_info+0x3a/0x60
 __kasan_slab_free+0x43/0x70
 kfree+0x103/0x500
 device_release+0x9a/0x210
 kobject_put+0x100/0x1e0
 vhci_release+0x18b/0x240
------

Fixes: b338d91703fa ("Bluetooth: Implement support for Mesh")
Link: https://lore.kernel.org/linux-bluetooth/67364c09.0c0a0220.113cba.39ff@mx.google.com/
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/mgmt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index afb6108d1f27..c11cdef42b6f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -9513,6 +9513,7 @@ void mgmt_index_removed(struct hci_dev *hdev)
 	cancel_delayed_work_sync(&hdev->discov_off);
 	cancel_delayed_work_sync(&hdev->service_cache);
 	cancel_delayed_work_sync(&hdev->rpa_expired);
+	cancel_delayed_work_sync(&hdev->mesh_send_done);
 }
 
 void mgmt_power_on(struct hci_dev *hdev, int err)
-- 
2.51.1

