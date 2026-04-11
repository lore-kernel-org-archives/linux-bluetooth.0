Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EB819005E
	for <linux-bluetooth@vger.kernel.org>; Sat, 11 Apr 2026 12:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775911931; cv=pass; b=Nhqf2CqgpXErzgu4clRnO4xiF67asY/y0f+/uK2WhVhf3uXIKR815lSPltNYWxhSWbhrxVT081BxUDoPxexQdD3FAmDU/pkpCJTYuPfXlNUv4KDKhSthqVAF6+/kvetRT2Np7rSa2O/Jm/g7Afi1+Ntuufs9ApdMHW+so2I8zMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775911931; c=relaxed/simple;
	bh=UmdgozqqOajgQFOoRuW8vlTFbE5sXrlMoj6vetzoJGI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EtbEfZ+FyPAOMTpHeM/bDCTQYotez+7PEzv8tNqxHRE77S25M5WeSujkF8Tj/i/4K6g/hxMjpCFoZ0ORJXGryifWFL3saMZ6D1tVn2ULqzO+zTBzoMF2YzGUgjlSUyTdcCJ+JdS8+8OhFzQ51MZ3ne8mPs/CjltcSSCNLWv2oTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=araHe9Mo; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="araHe9Mo"
Received: from monolith.lan (mobile-access-2e844b-114.dhcp.inet.fi [46.132.75.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4ftD8M2kNDz49Q34;
	Sat, 11 Apr 2026 15:52:03 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1775911923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lE/QEfLKaJyA5XQF0NVwTiTlqBdEVTFVcbYdYTqUYcM=;
	b=araHe9MoBqYm8vos3ALhiOn6LvBKBNkOyyV2HgmwjwDgTk0T1krH2LfNohpx0Rbw0kE1Me
	qBJ/ly5XZIxEZlMEQTweAF6iIwLq8q+NnnjrW+sOsCevuGhPxsOHfPVDYEMlINzM6iDigW
	BEh12NDaX7PvJt4oj1HUIf+BJ/Gxs4Xv6PhzJ4Enf98JwTxuvlS6b6lK69evhZNQ79RCG7
	fafOTqe4xHallbeKuAddQucHuH12EePD96zgUaHGXjbUNJnnASi1/GYuAs6uptKkUfmmSW
	X/QHlzcgLz2eYmwrTcbur3zkHnu3sF79L8AbViLquLULh4HIXEFPnFpI/M5Ptg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1775911923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lE/QEfLKaJyA5XQF0NVwTiTlqBdEVTFVcbYdYTqUYcM=;
	b=eZkChH3dLE1C9M+MwqTCzSO/ZyLZXGhk2y/MegzjAW2yLhwSg0a2fQC3v7nfnmtcIuSDx7
	XVz+60rLV4EIcdP0pKpP2cSIvu5XzZ99+gLz2frDQBanEMiw4qUHyY+o+DG7/W/ZTbGh1G
	HcPqJPUgmqeGuxpmVlCfUB1x57AF7MognTCjEungJTgEJaoyUvV9eAzuz2ECmXiurekGb+
	6ayQkcn9ulugUqjnBS8Vy1f7ygqdTsJUm1XHO+7Ey4ajHz+9v56ABD4IUO9bCduQQvRaOS
	SFqz+u0XMmyZJaY+LnSTk9MrVqtA0N3kEL4O54voNaWkMF2nkZ2/8ViRrYf7Nw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1775911923;
	b=vim9yT+aX4vzyT6KX/o4UEmjxWdKHsa8PyCCpOj2xXcyTgAOwsWlthH3+sjoUZ5wNCT4AW
	3ReSGb0x1x54ISSmH9Scqk2W4qoLcdVj21j7o/3iyy5UXWzHrL4v3liTAnyf9t/XwxC7/B
	TTV8IopoeopLK9vT6Vaj1jG3FphQwn/BKSIU4VMiczZnkaqLSCVT1Eu6NNfXz89LwHFKew
	FcWYJ4yyq+DDPt5KKZa5pBLY17sIN954MjVJsWj3lc4sJ7RTixRJ0nmYEDNDRkEk3fBk/O
	4/WPCSkxT7HIeM1z4aR7yDfJsF2ZnyQtNWVE2dzYobsuv0Z7q7FqS/fz9npxxg==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH] Bluetooth: hci_sync: fix hci_conn_del usage in hci_le_create_conn_sync
Date: Sat, 11 Apr 2026 15:51:56 +0300
Message-ID: <8e7f8a9749b25162357bc8a64caf0429837a9191.1775911785.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Callers to hci_conn_del() shall hold hdev->lock and have informed socket
layer of teardown if needed. This was not done in
hci_le_create_conn_sync(); it also appears possible to reach here via
l2cap_chan_connect() with associated socket.

Fix by taking lock, checking conn validity, and adding hci_connect_cfm.

Fixes: 8e8b92ee60de5 ("Bluetooth: hci_sync: Add hci_le_create_conn_sync")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/hci_sync.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index fd3aacdea512..f950f87fa690 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6602,7 +6602,12 @@ static int hci_le_create_conn_sync(struct hci_dev *hdev, void *data)
 		if (hci_dev_test_flag(hdev, HCI_LE_SCAN) &&
 		    hdev->le_scan_type == LE_SCAN_ACTIVE &&
 		    !hci_dev_test_flag(hdev, HCI_LE_SIMULTANEOUS_ROLES)) {
-			hci_conn_del(conn);
+			hci_dev_lock(hdev);
+			if (hci_conn_valid(hdev, conn)) {
+				hci_connect_cfm(conn, bt_status(-EBUSY));
+				hci_conn_del(conn);
+			}
+			hci_dev_unlock(hdev);
 			return -EBUSY;
 		}
 
-- 
2.53.0

