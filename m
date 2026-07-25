Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425B8355048;
	Sat, 25 Jul 2026 09:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784973574; cv=pass; b=HAk0a8apwJnND8237Nq+x0LK46/CBtNZJaJZRJCxO8fe0yHSZsfaBZ3ctefvt/YB6AKXZ6W/qeOuoqbnWH2ynpG4oRC/2otaJXXhEg1qxXB0SStjucyIQiOTEc3kT/FJpBlFI8Yz6wVUeFxNpwUCLScWh14P+XIBpv9BtcxfhLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784973574; c=relaxed/simple;
	bh=VsmwBwyFsL+7eKnpchCTySYjFHTvO2weTxpjTi4Oex0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qmnK2QIkI5dnwNbpg5OVmjHY3xZboI7aIY3N0K0G43H0mmBUsJsIEVRfKVs0WG6Hy4xGgBncunzEPYXHl/JZs/6K8ymt2gWXI/M3zGlggvs4bF6nTChrX2QEe6YSbiyOJLG1NxsBhFAUlCv3GoXWhC+JAEbYFFFWk/xhuy06PYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=gvpysdhE; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="gvpysdhE"
Received: from monolith.lan (unknown [185.65.133.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4h6gLn2ZRjzyl5;
	Sat, 25 Jul 2026 12:59:29 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1784973570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dS/+rrw4u091YzxvdzOgScuiX8fI++1TP4gjMh+irX8=;
	b=gvpysdhEaIqQT3sEdDTQ9JsrE3aV+zWVixawKT/qDVZg75Cit+3w7QFnWCuy1h2jMFmNql
	5Y4SpPKjUVOuzStD4R4jH0Hlj6sP0bWbpUfAkSUeuiJNxmC/uZesoF21F7B5V6vaS5qBSg
	yaa2OfmVh0v1LyN8/Gl3TEB7zr96CC8=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1784973570;
	b=H0fw06CXglEEbl9BXloXM//S+G0vkhWa8n/XLgVjtzHfioMCP1Bu/Kz6uABdMMn2dSCqua
	jhqui+3ziphXwjzQasHyR0WW/tvwNsDEv1LrtIP57Y3l0X1/3nHWeDcRW98YwwuNkGqTWD
	XBad2qDHY4rTLopIw0F5sV3zD+W+onE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1784973570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dS/+rrw4u091YzxvdzOgScuiX8fI++1TP4gjMh+irX8=;
	b=FGmAMJVErFUgbPX73m7xZlBW+d4BarxQFj8wxHb5bZ96v7Ag72CymnOPhyEC05hHZK846x
	CBb10ckxHbw9waKLSmrn5B1lF3/d1trTs+Jz6o6jZoluKhKJ5oPDEnsyh8LJsHWoEo110a
	RJU+acPEZXrE5Q6rMxDSQ7LF1fKqNz0=
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
Subject: [PATCH v5 1/7] Bluetooth: hci_conn: hold conn reference in abort_conn_sync()
Date: Sat, 25 Jul 2026 12:59:17 +0300
Message-ID: <2cbcaf1f4ecc03601653eff0763c07c41c901376.1784973264.git.pav@iki.fi>
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

There is theoretical UAF if the conn is freed while the hci_sync task is
running.

Hold refcount to avoid that.

Fixes: 227a0cdf4a02 ("Bluetooth: MGMT: Fix not generating command complete for MGMT_OP_DISCONNECT")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    v5:
    - no change
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
2.55.0

