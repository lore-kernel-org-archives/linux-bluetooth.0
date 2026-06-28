Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5976C3A7F79;
	Sun, 28 Jun 2026 13:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782652849; cv=pass; b=cv1SzlyPQeQhhyf3e3FnnqOucmB3tZTHDxJ7nd6ZUG2wsxHCIYn/8/t1La+O+eI/1p/djZ3DnNDbCe4bKyWzCamy6GalvVQJGFLa6MlgcdSP0wEpmD6ggKxb348RyAKcnG6fShCMMhSH9EFcckPK8++pGMscVvX/fZKVYj3j5W8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782652849; c=relaxed/simple;
	bh=Coue2mBzecLOy+lwlxdLb7QSWogvkZVQCFOpCwSmwrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XhcbIKfrG0MQOJERis0SWqBB1OJ5t6Gb7tbF8zySd0e/UAkHAf4n8miXmKB1APpTEYhVvbzF3gRJVfUKeIvqNuRBm54T0rwi6A1S1xtLcQWn7RHfSGiRawMw9cv51C9g4jr1eaMqa8OxaaE+6+C7xIvkSkVmIJIKrDiMnijNjgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=vXYeytA/; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="vXYeytA/"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gp95T0C6wzytg;
	Sun, 28 Jun 2026 16:20:44 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1782652845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4A+9dwnO9A2lNSbpWA7S6mmFPYfXBRiVFZ7vSF4c41g=;
	b=vXYeytA/uHsgU5RrUMqPRTP631vp921JnKsSaO6j6DMUnAImA2J5FMMZFvH5qdJoppvs/o
	RW/2O7fL196RnYlIJu2wrOpqcceaMcYA4eJNMwZTxp0bllQAYXzCm+F2XCraiZXQ/kaPBb
	8lq6FXX+jvxeQAOBLGc9qOm7VmuD6OQ=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1782652845;
	b=a4zGMkeAU5soFkicWCKOexJI1whQsUm7OvWUWXMEwr4n3ZbMmHKWXWjOGe14ZmJMlPJGLQ
	rSaGeHYBF3uW0Vh2epTrdGjtdZ7v56sPffTHn+K2HSe9S5b1OK4jVAR7ZbX5jRUSrnHwhW
	fYMSufvTNxUDQ2rcQPWTNyHxyZKEcHQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1782652845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4A+9dwnO9A2lNSbpWA7S6mmFPYfXBRiVFZ7vSF4c41g=;
	b=xlLUNBEtZX5jQjoUaIsgHrc4yzlFJUYu8wzzKlpynsINcbz52Or+br1lQjJcMQkTb+RWEs
	cnUhyrrzyDNVyLn2tw9wx1X8zIU6xHhfdw/534UjMV3uApy+XC8mHgq6YtGhpsI58s2gUp
	DI5Cj7CZNGrMH8R5hKSTAmmZOUfCMZA=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	oss@fourdim.xyz,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 6/7] Bluetooth: hci_sync: fix hci_conn_del() use in hci_le_create_conn_sync
Date: Sun, 28 Jun 2026 16:20:31 +0300
Message-ID: <32877852224a86fd1ea20e26f6d9f33356ce75e8.1782652695.git.pav@iki.fi>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1782652695.git.pav@iki.fi>
References: <cover.1782652695.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_conn_del() caller must hold hdev->lock, check the conn was not
concurrently deleted, and usually inform socket the conn is going to be
deleted.

Use hci_abort_conn_sync() instead of calling hci_conn_del() without
locks etc.

Fixes: 8e8b92ee60de5 ("Bluetooth: hci_sync: Add hci_le_create_conn_sync")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    v4:
    - no change
    v3:
    - use hci_abort_conn_sync instead of lock + hci_conn_valid + hci_conn_del

 net/bluetooth/hci_sync.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 88572e52c860..11d0c2033c6a 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6623,7 +6623,9 @@ static int hci_le_create_conn_sync(struct hci_dev *hdev, void *data)
 		if (hci_dev_test_flag(hdev, HCI_LE_SCAN) &&
 		    hdev->le_scan_type == LE_SCAN_ACTIVE &&
 		    !hci_dev_test_flag(hdev, HCI_LE_SIMULTANEOUS_ROLES)) {
-			hci_conn_del(conn);
+			conn->state = BT_OPEN;
+			hci_abort_conn_sync(hdev, conn,
+					    HCI_ERROR_REJ_LIMITED_RESOURCES);
 			hci_conn_put(conn);
 			return -EBUSY;
 		}
-- 
2.54.0

