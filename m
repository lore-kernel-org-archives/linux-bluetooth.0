Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC57282F28;
	Sun, 28 Jun 2026 13:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782652842; cv=pass; b=F9IT86vjDCs8SHD5JVcKJvJX15MRrBl4nuyl9GFdRjgApMxTw2FV9mgr/JVWpnkVJqjgb0akkCDdZC5OJFQUfcl5B7ogvUS+35Mw8H3XMcvxfomedmnC2aRd3pspKCL1emHDelKjnDqm+KUo8P1kHFR/QqXlz/wpdPy5+lEVZUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782652842; c=relaxed/simple;
	bh=RLyxI5RzgQz3kb0pVTJZ2LMDHvEXRn3fW/MmEhZn+Vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DXWnTgUoK7BSyAYQjDnLWbWw9C+3aiucYaw29x2dYhBOztMGhFgjVDY0MtbZKpxFqvKdVNe8rN2zpVwhJ1g1M41uJkU5N/9kpnORJzbX2Q+w7i9woShm2OzDjaUyWQ8BEXPOsS+N210csDzEVav7v+GGBMnqVa1SBddSQRpoIiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=H78nYUTJ; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="H78nYUTJ"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gp95M0rf5zycB;
	Sun, 28 Jun 2026 16:20:39 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1782652839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PbmZ477KR59tWiV6y8UnBZU3nV0EGG4le+04HLFIqhA=;
	b=H78nYUTJWHevwAq+Xs0dX3pST3mqIqz7Hn5mB/+h8Nrx1HqjZRQL3cA10KtlVGmTqBOzVz
	SRVFTeRwzwgqiu3lx+G1ra1QSpmUXzCZ4Sdh/tahPGApZe97TwtxYRB+meda25tsOOxqqc
	/sMdEy3xrr+eb7EpfxQXSB/B21rZqDA=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1782652839;
	b=LP4mmCr+yt6u5DZ0bEXI1dCMVTVCSwTvaQXDSlSbxBlySgM7w8vfT8+UEwTMUySSmREG/1
	Za89Yh0c6R+H4JDG3dbbr4OhSx8/3DhAlEK/xuLHbMqHlmpl9K3X+DFBbxPkBGiKSlBDrw
	x0gZ3oAwSnRAFknn6qy1o6cxc/22gmA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1782652839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PbmZ477KR59tWiV6y8UnBZU3nV0EGG4le+04HLFIqhA=;
	b=aVMEZ65sVoWSx/APU1iW4fbDUzin0wRPH8ZEBQgmV7W9Tlocca/o1X4P4Rm//fZD+oNP9E
	D+ol1Zkb9wNDj3lGE9uJPgtNrOgg+qZCMFXOW4ikckdSIuegvbQRusd1axsKVC957+SEQN
	1CTjDn79KNhfaXRFBzjUhNfK9gidZgE=
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
Subject: [PATCH v4 1/7] Bluetooth: hci_conn: hold conn reference in abort_conn_sync()
Date: Sun, 28 Jun 2026 16:20:26 +0300
Message-ID: <7a22e9136652bfc95b52bacc146e5ac461b82ec2.1782652695.git.pav@iki.fi>
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

There is theoretical UAF if the conn is freed while the hci_sync task is
running.

Hold refcount to avoid that.

Fixes: 227a0cdf4a02 ("Bluetooth: MGMT: Fix not generating command complete for MGMT_OP_DISCONNECT")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    v4:
    - no change
    v3:
    - split to multiple patches per different Fixes:

 net/bluetooth/hci_conn.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 1966cd153d97..6036ff66d8d9 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -3163,6 +3163,13 @@ static int abort_conn_sync(struct hci_dev *hdev, void *data)
 	return hci_abort_conn_sync(hdev, conn, conn->abort_reason);
 }
 
+static void abort_conn_destroy(struct hci_dev *hdev, void *data, int err)
+{
+	struct hci_conn *conn = data;
+
+	hci_conn_put(conn);
+}
+
 int hci_abort_conn(struct hci_conn *conn, u8 reason)
 {
 	struct hci_dev *hdev = conn->hdev;
@@ -3188,7 +3195,10 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
 	 * as a result to MGMT_OP_DISCONNECT/MGMT_OP_UNPAIR which does
 	 * already queue its callback on cmd_sync_work.
 	 */
-	err = hci_cmd_sync_run_once(hdev, abort_conn_sync, conn, NULL);
+	err = hci_cmd_sync_run_once(hdev, abort_conn_sync, hci_conn_get(conn),
+				    abort_conn_destroy);
+	if (err)
+		hci_conn_put(conn);
 	return (err == -EEXIST) ? 0 : err;
 }
 
-- 
2.54.0

