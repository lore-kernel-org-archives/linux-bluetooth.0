Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCE0318BA6
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2026 19:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774465676; cv=pass; b=BwWE3r8Uk3WkCnE4WIyAkSUA2322/bBEIQZRR0td565RIghuuf2+XQVxP9oYCqTcFsXvlNQmvGMVHO7nW36N070GHocejKxBVHr25YVZXKhGQaTkiSbnp7woOfI19eEMRiPzFc0lNYsBasAfPFYSvvBz3y+6g6UE6iR1w+ByfOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774465676; c=relaxed/simple;
	bh=r22v/ZqrgVhzH8TRvW1ojxCFiU8C6wN+0YAORko9pLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b4NqkWhrCGKzU7Chuqki2h4AdpfWBf4dWLpjnutjBW38/N6J5r0DRoCUulymo+u+sZr44wu98ROpsDFd5qjrEKxRqILWy1qvzXxDYfP/xevRcRiTDb5iiWJuCs7rBW4MSJ14TGOmY+FBKtM0PVRfPWhTftMs9CNwJ7XNkDr61GU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=qYApMmIF; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="qYApMmIF"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:1:f410::a01d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fgxHr4LMTzyYj;
	Wed, 25 Mar 2026 21:07:52 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1774465673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=19nRoXO68KPWtquMT7Y9SXH/wjwmRnAqXSXO6RoINNc=;
	b=qYApMmIFV1JTnPP4cjA0ZCT7hsUV62pgmZoV1yqIbInaHDSAj3CETFdmsReyyG43URwGcs
	Rbj5KEW9Ayi4yOSK7sxE3EWZ4YMJ4g/kR9srpSDnyxSBhMDDEJ2QXyE178OH5NjcVMo9a1
	Os6T7DnrrmqilOzAo/j8tYT8e0fVsvQ=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1774465673;
	b=hBlVvfGF+z9hRQf0R+10WRrVt3VLq6BNRN6wysdfatwfd8x3YmZsUQcUMES0mXngwkk2ZA
	p6E6dI+mez6Pmdnubm3FV728N+X6t6fbww2KlLtULuo0OcLBVcEh8eZDx1mSEJeqLsUpq8
	sSdBBhM9MUmOWmNnstkOphM6j9U8zsU=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1774465673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=19nRoXO68KPWtquMT7Y9SXH/wjwmRnAqXSXO6RoINNc=;
	b=owa4H2V1Dd5VJbltqfABnOuUEGM6wWDrrD6beFogwXrIFHbHI1GoWYnsaZuRN6u66enPZm
	y5FsEKJSSVD+iQwUOC2hjLc/dqM7LBXzXb7fMhgh9o2tiU37N50mCPS+eWZWlY9eM4SL+O
	NQBVxoJvNZ4GaUUKW6KdkKz+/iISn7w=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH v2 2/4] Bluetooth: hci_sync: fix leaks when hci_cmd_sync_queue_once fails
Date: Wed, 25 Mar 2026 21:07:44 +0200
Message-ID: <23f22a721cef25dd4293ac4cc26efd08e1fd0161.1774465559.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <f7ccb4a4f9e462a6c1c1ddba8dd1cdcc9456944b.1774465559.git.pav@iki.fi>
References: <f7ccb4a4f9e462a6c1c1ddba8dd1cdcc9456944b.1774465559.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When hci_cmd_sync_queue_once() returns with error, the destroy callback
will not be called.

Fix leaking references / memory on these failures.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    v2: no change

 net/bluetooth/hci_sync.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 4e2c8a759e63..0b28495197c2 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -7453,13 +7453,16 @@ int hci_le_read_remote_features(struct hci_conn *conn)
 	 * role is possible. Otherwise just transition into the
 	 * connected state without requesting the remote features.
 	 */
-	if (conn->out || (hdev->le_features[0] & HCI_LE_PERIPHERAL_FEATURES))
+	if (conn->out || (hdev->le_features[0] & HCI_LE_PERIPHERAL_FEATURES)) {
 		err = hci_cmd_sync_queue_once(hdev,
 					      hci_le_read_remote_features_sync,
 					      hci_conn_hold(conn),
 					      le_read_features_complete);
-	else
+		if (err)
+			hci_conn_drop(conn);
+	} else {
 		err = -EOPNOTSUPP;
+	}
 
 	return (err == -EEXIST) ? 0 : err;
 }
@@ -7498,6 +7501,9 @@ int hci_acl_change_pkt_type(struct hci_conn *conn, u16 pkt_type)
 
 	err = hci_cmd_sync_queue_once(hdev, hci_change_conn_ptype_sync, cp,
 				      pkt_type_changed);
+	if (err)
+		kfree(cp);
+
 	return (err == -EEXIST) ? 0 : err;
 }
 
@@ -7537,5 +7543,8 @@ int hci_le_set_phy(struct hci_conn *conn, u8 tx_phys, u8 rx_phys)
 
 	err = hci_cmd_sync_queue_once(hdev, hci_le_set_phy_sync, cp,
 				      le_phy_update_complete);
+	if (err)
+		kfree(cp);
+
 	return (err == -EEXIST) ? 0 : err;
 }
-- 
2.53.0

