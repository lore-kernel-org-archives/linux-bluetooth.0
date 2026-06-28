Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5DB19D8BC;
	Sun, 28 Jun 2026 12:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782648775; cv=pass; b=r3TyHnl7ycQoxvGQnCGOe1wQwZCzvE6woLqWvnHNEy+9OfNH2qtQoNwXKS9eFB9awX22PNBW7ehnlAaTMNWYyNHGlHmkCjJnn7jQV4W+0Mz1rBQtbF/ufUXfviW3EExyyb2FRa9aoFjNLt8qD5pYG6rJNKaZ1B7J35XzHMPjJjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782648775; c=relaxed/simple;
	bh=3hjC/O0ZiseaH3igFZ8nnPBlkixAOZOsRAdQb2fZgN4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vD7W4nXnuWVc9gwVXrlefMn+dVSlQKh/7j7FMZdaAxUYs8wkNwAEdCDrIMaDKEKumKDm8uWHtVT7aEjXS7+l4WJVvrdWiavOV+bRbuR6ZWLKrzSg5l2MUCUMiEOvQ/9DfH7uJwIQhw/bYTwinCPelG4S+OQM//YxR3DnnB8IYSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=ZJlEcSxZ; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="ZJlEcSxZ"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gp7Zy6dDYzyRv;
	Sun, 28 Jun 2026 15:12:42 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1782648764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=B13AnLrMQ8UgtPcVX1kvFQVh7HPlLT/Wx8ADlrkCZgs=;
	b=ZJlEcSxZ/r5wusWcLdn74aej+tuaCqdeDBj/bDIvgEs5QRqGmEqQ8dJa9sfLw4PrK11+oi
	l52QA4SAzhq0nNqTpyFW0vHLtRsPA2DNiSYJ9SWeG2D5373JO/qbofoNh0xcm8bN6wKDY2
	8Zb9wl2uXJc+Ev7sPUIfuRa0CeotLRU=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1782648764;
	b=rB1F2mEW0cEi9oH8eQ4y5VFdfmMKGpb+d/6HrOeCT3z8TBdqlUseFykCPJvUb4gxTM4t+0
	+q9CbErlDdxJdOu2xKD3eHZq4mhDmzBLjqDPjUui1g6KGQR8diHw76Oszxacdrr5gYllKz
	lzoEhm/ATbyfU2LkXSg14dax7ADftP8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1782648764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=B13AnLrMQ8UgtPcVX1kvFQVh7HPlLT/Wx8ADlrkCZgs=;
	b=mgCw4SGCWDZ5DXgpLBz8thKIwQp0PjrnVxAKgtG702z0ELo+ye+1QsxMX7vr20ZjROKO15
	iJexk4Y8doPLqZejcp+7w+D+g3Y6MtMK9Qv/KIaYoGJEk3a09vy03rAH2i/rqSdDlS2oeq
	gxx3dfjPl+Fv5utBG6p/OjoRvdgR4EU=
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
Subject: [PATCH v3 1/7] Bluetooth: hci_conn: hold conn reference in abort_conn_sync()
Date: Sun, 28 Jun 2026 15:12:32 +0300
Message-ID: <7a22e9136652bfc95b52bacc146e5ac461b82ec2.1782645211.git.pav@iki.fi>
X-Mailer: git-send-email 2.54.0
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

