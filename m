Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E68A26F2A8
	for <linux-bluetooth@vger.kernel.org>; Sun, 21 Sep 2025 19:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758482099; cv=pass; b=XevpgToNArvFwW/SiskvK2ruWms/RiTF8PknV9HyIzRqE/MSvqeCUEnLkqh+4PKFGzuRHYgFtmyEAPHriaHOrM7QZL2aA7yEmS5nGZTPlBLWpwYH3IXCAiQhF8tepRPym4b6SVz8RznYEYfIn61bCfRktqtVowbUVESCwRim1/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758482099; c=relaxed/simple;
	bh=63DXFUQBRP3miT7tfkq2IuZNhhmTKieOozKhnSKF4a8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t0HaYyHv/KD48xKtVsi1Ll64L8Fbp4K5c9Pt9CRT1tFJzgOCxZnOjpcgigO1y3+cLDxz/uUgQoZrSeNTHB8/CWXBL13WzXrhe2zzyaKwC1VdpklJdH/tcUUFeDxqtbOr9n6rhI6IT77CC6QIhHGZKX3j9oal7rnTuVYAApjx/Rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=ApzcyUkz; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="ApzcyUkz"
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4cVGCC3SL1z10D9;
	Sun, 21 Sep 2025 22:14:47 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1758482087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nfQ51R+oxpdQ6ohWkDWI3Kh/Ah65KbVuZMlwi5hF8Ng=;
	b=ApzcyUkzr6fB+lRiBJj7V+FriJ/1PBQhqdpxJC/LfMWQoUn5oT25G6DsOwtFUiVS58qmva
	ZAjRtUTplAVCNebDoS/Su8kPV39uKu7Hb+693tXs/imO6EYPDXjj+cM7MUERW6vH02Dq3q
	XEQGhT4qt024R+kL+L5rj6cRjCqA2hA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1758482087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nfQ51R+oxpdQ6ohWkDWI3Kh/Ah65KbVuZMlwi5hF8Ng=;
	b=PFZn4CESpaniyUuDg0/gBIDWj3s24bZZPVHBi+asgXSLrFG5JdkwcWxjXbAYTCjHUsnkAY
	LNF+5qS3bHhvq49eypMN/L9bqNOkWq4H3Nwre5lYuta9YdTFaFcPBXLEiUhjUiMloEYVEU
	7/129rwSaki+DHL2dpcdsgQTT3CUjSI=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1758482087; a=rsa-sha256; cv=none;
	b=q8XDXlIjfkKuyIyDWBZnY1YqV4vEKeV0e+vjivbEsJFO9Jvfvvfl16ND6tP9qimo+AZQSV
	DHcYExsgwNiV3ssTfuwsTUV/8fY1A9IufhDUfWIpc8xU8m3LTnEQgdTrBhesH6vm2zqn+i
	TcfSYxDahisg9FWLG8Q0rZJaVOHi40E=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RFC PATCH 05/24] Bluetooth: hci_conn: avoid ABA error in abort_conn_sync
Date: Sun, 21 Sep 2025 22:14:20 +0300
Message-ID: <b57251e6ffcf6a74725808d62d9173ad69f714f4.1758481869.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758481869.git.pav@iki.fi>
References: <cover.1758481869.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_conn_valid() shall not be used on potentially freed conns, otherwise
that is ABA problem. Avoid that by holding reference.

Fixes: 881559af5f5c5 ("Bluetooth: hci_sync: Attempt to dequeue connection attempt")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/hci_conn.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 4a9067b2e87f..1d914d95cb6d 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2927,6 +2927,13 @@ static int abort_conn_sync(struct hci_dev *hdev, void *data)
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
@@ -2967,7 +2974,10 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
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
2.51.0

