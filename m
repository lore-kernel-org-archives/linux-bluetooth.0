Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D703A641C;
	Sun, 28 Jun 2026 12:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782648779; cv=pass; b=NwoV248OBkEqXIW0HAPXZW1TJQW9h9ZjaT9Crar589LoBML5yoDGWrm+9vMxC5V26FgJW/tT2OOL9/qfZxG/OKOFl4MVc95doed/lW99qtHBobTuN3+31ED/ovM+smpgGi0KrySuru/63ejb8e/nNyka8JVE/gxIf7qhfp44mLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782648779; c=relaxed/simple;
	bh=Nja9u7aMTcM3IFE2wa5YUS9bqKOjc8UMhQ37cUeYAgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GPtPBvpOofxqJG6kkfugpz9t3VYtlwPxr5OVnt4vYOu0WWYvRfD9v7qCS+eQ/0o3uHDyfm9JruuTBeVLrHDL18kQo+xBNgcLm5+LngSDzLOhNK+vJmaksi0qxFvXZ+SdolpVQ/cDesVV/dfoGcKvsT1xZtbyqh73WCC2paEUzj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=ZYED6PtK; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="ZYED6PtK"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gp7b65RNLzyw4;
	Sun, 28 Jun 2026 15:12:50 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1782648771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j88F7guV0mq8jpKrUMAiiOxgoX5fxQRlA0LEw3Wfe/Y=;
	b=ZYED6PtKrPSugmkHeLB7CFqzgM5zi3J6mv9BTIC55wWqblf9TCpudSySOHoOCnhQrjCNBO
	vLCzFJvzo5mYAZABXT5KbANjayqnVsrJ2mafRbYQvdbhoTqx9lLwYRQMEnbFFQsDZ4EtEr
	V/TyLQ7F4QAq4TN41VAONjeLDNNreDA=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1782648771;
	b=XNWkq/JH/XDw/2NafOt0UGD8g0fdNSagvsEiZ8+fBDIrqJPy0XkNihCmWEP7FBj1uev45O
	IcZ9vm3tI7SFDt74R+ss84vSWVEEyqvSPY8qU8oE/Y6p5+ruJK7nuJi+K+h0xDmtVvMnhn
	V8uVdhAsYrvCp5wh2BEr2c5weV8E0c8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1782648771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j88F7guV0mq8jpKrUMAiiOxgoX5fxQRlA0LEw3Wfe/Y=;
	b=ZVX6Wl15uQMZtIczMdnxM/yCduGAi2D6d2mPDl9HZykt3YS0V3g70t9Lp2xv1V074ONy/w
	JRaIVTS4HQx+g4Xe9Kc+9fJcl65fAaMSmdAIwAFnLmmpGS/qBCcozsCMX5dQKAq+RNdZNL
	bY4XMN+MgmLhSiArFOcGLa1kuElxqNo=
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
Subject: [PATCH v3 7/7] Bluetooth: hci_sync: remove unnecessary hci_conn_get in create_conn_sync
Date: Sun, 28 Jun 2026 15:12:38 +0300
Message-ID: <8f4f898b035b687be3428d7bc321a88a58d1042d.1782645211.git.pav@iki.fi>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <7a22e9136652bfc95b52bacc146e5ac461b82ec2.1782645211.git.pav@iki.fi>
References: <7a22e9136652bfc95b52bacc146e5ac461b82ec2.1782645211.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_conn_get() without already held reference is data race against
concurrent deletion.

In previous patches, the refcount has been changed to be taken before
starting the hci_sync task, so remove these extra get() + put() as they
are not needed.

Fixes: 76c2d047410ba ("Bluetooth: hci_conn: Fix null ptr deref in hci_abort_conn()")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/hci_sync.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index ab5436e548f9..e4f63f6a51b0 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6607,11 +6607,6 @@ static int hci_le_create_conn_sync(struct hci_dev *hdev, void *data)
 
 	bt_dev_dbg(hdev, "conn %p", conn);
 
-	/* Hold a reference so conn stays valid for the HCI_CONN_CREATE
-	 * clear_bit() at done.
-	 */
-	hci_conn_get(conn);
-
 	clear_bit(HCI_CONN_SCANNING, &conn->flags);
 	conn->state = BT_CONNECT;
 
@@ -6626,7 +6621,6 @@ static int hci_le_create_conn_sync(struct hci_dev *hdev, void *data)
 			conn->state = BT_OPEN;
 			hci_abort_conn_sync(hdev, conn,
 					    HCI_ERROR_REJ_LIMITED_RESOURCES);
-			hci_conn_put(conn);
 			return -EBUSY;
 		}
 
@@ -6720,7 +6714,6 @@ static int hci_le_create_conn_sync(struct hci_dev *hdev, void *data)
 
 	/* Re-enable advertising after the connection attempt is finished. */
 	hci_resume_advertising_sync(hdev);
-	hci_conn_put(conn);
 	return err;
 }
 
@@ -6995,11 +6988,6 @@ static int hci_acl_create_conn_sync(struct hci_dev *hdev, void *data)
 	else
 		cp.role_switch = 0x00;
 
-	/* Hold a reference so conn stays valid for the HCI_CONN_CREATE
-	 * clear_bit() below.
-	 */
-	hci_conn_get(conn);
-
 	/* Mark create connection in flight so hci_cancel_connect_sync() can
 	 * cancel it while blocking on the connection complete event.
 	 */
@@ -7011,7 +6999,6 @@ static int hci_acl_create_conn_sync(struct hci_dev *hdev, void *data)
 				       conn->conn_timeout, NULL);
 
 	clear_bit(HCI_CONN_CREATE, &conn->flags);
-	hci_conn_put(conn);
 
 	return err;
 }
-- 
2.54.0

