Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4533A7F75;
	Sat, 25 Jul 2026 09:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784973582; cv=pass; b=Unhyh8R/yBEt1kdeIADIHZOPKQZQ4Stpe+FsuYZkmoAqHJCmGfv2BYqWN0vYf4rPOxJauXB8aox4pcdzwntV5PkDE9Vv08UmfCd9/vI8HRxuABJ6jUYZHukylijeS74fjohxXok7QGJsocRllqRyRJCfteWyHmmuhpOr0uhOogU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784973582; c=relaxed/simple;
	bh=AT6jMuFQwR00+Cr2wrMgKntno/NK9EU+Z1skvvtIFKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V9xwcOGIbUu2tq7siR1oP4UtiP6j1Il1HPfRbbbbycVGw0nQ351byT1WB2doj1c4v2N2cFCHhEU3XNKZ9s7OiE6c1dIIQEE9SwpXJ7/NzW37yChNHBOoEBySWe/1/egvGN4HLicgmKkzyXRFf+dEZVPiEEflTNsfSj3e90tOjoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=oFDCIhwj; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="oFDCIhwj"
Received: from monolith.lan (unknown [185.65.133.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4h6gLy4VQ2zyl5;
	Sat, 25 Jul 2026 12:59:38 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1784973579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OVfwS13F09Yn4rQY8CGeqczZgn4+mT2dtS2HMUNWKLs=;
	b=oFDCIhwjsG3rDaWblrMxGqMEXCaM0j7pHb6kaX2lx/IejFK74gL01Ep57M8uYoSY40LY2w
	G4zcSFhp9hOKl+GT1WJ4lbvEr4Tk+cUYDei2pdlpq3oexlpkZZQprc2n/Ma40qCxLyQv2c
	qI5ppfw7Um10SIcP3xEOANGB6PRs2JI=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1784973579;
	b=VkkN4WfO0z4o1H2IfRGrPBCtUvxefqMvaI29e3f9H9zRMIwMw91aTXEAnRl5NXdbQG92Na
	07xaLZfpLsRhwD4Ppq3v3g8k2KXc/osDgaLpI0Vg0qJTMG1ZcT7DsqmoswFb8M1dsaxj+n
	hyIUAa5C54IUpK4yNuItF3Vjp5hAeTc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1784973579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OVfwS13F09Yn4rQY8CGeqczZgn4+mT2dtS2HMUNWKLs=;
	b=bycrc75QQDs4Tn3bFTmZlEgWUDXo7kvp8AGcCFYUYlaAiLR74iKPC3l9sjE8uYwG66qWM0
	15PfkG4qqfaSap1qc2TT7w6QS9bjlRXAY721DV1enSouvFKpPz/5w2N9/xo+nCqpwVPQ0C
	B9poFsIjVlYl713GTiQPksSr5C/YLhU=
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
Subject: [PATCH v5 7/7] Bluetooth: hci_sync: remove unnecessary hci_conn_get in create_conn_sync
Date: Sat, 25 Jul 2026 12:59:23 +0300
Message-ID: <060f924a73949939547a5889d889bfbc64317ea0.1784973264.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1784973264.git.pav@iki.fi>
References: <cover.1784973264.git.pav@iki.fi>
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

Notes:
    v5:
    - no change
    v4:
    - no change

 net/bluetooth/hci_sync.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 0f76221db2bd..7779d9d1663a 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6717,11 +6717,6 @@ static int hci_le_create_conn_sync(struct hci_dev *hdev, void *data)
 
 	bt_dev_dbg(hdev, "conn %p", conn);
 
-	/* Hold a reference so conn stays valid for the HCI_CONN_CREATE
-	 * clear_bit() at done.
-	 */
-	hci_conn_get(conn);
-
 	clear_bit(HCI_CONN_SCANNING, &conn->flags);
 	conn->state = BT_CONNECT;
 
@@ -6736,7 +6731,6 @@ static int hci_le_create_conn_sync(struct hci_dev *hdev, void *data)
 			conn->state = BT_OPEN;
 			hci_abort_conn_sync(hdev, conn,
 					    HCI_ERROR_REJ_LIMITED_RESOURCES);
-			hci_conn_put(conn);
 			return -EBUSY;
 		}
 
@@ -6834,7 +6828,6 @@ static int hci_le_create_conn_sync(struct hci_dev *hdev, void *data)
 
 	/* Re-enable advertising after the connection attempt is finished. */
 	hci_resume_advertising_sync(hdev);
-	hci_conn_put(conn);
 	return err;
 }
 
@@ -7109,11 +7102,6 @@ static int hci_acl_create_conn_sync(struct hci_dev *hdev, void *data)
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
@@ -7125,7 +7113,6 @@ static int hci_acl_create_conn_sync(struct hci_dev *hdev, void *data)
 				       conn->conn_timeout, NULL);
 
 	clear_bit(HCI_CONN_CREATE, &conn->flags);
-	hci_conn_put(conn);
 
 	return err;
 }
-- 
2.55.0

