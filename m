Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC93832ED44
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 22:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772058234; cv=none; b=LaDL8nf35+N/hO96YHYtFPpoUjfc0iEc6sq0y7sPVnyUHb+oC+1eoVuTXsbk7AGqO128BCW3/JHY4zAFHZie0qUJCvQH6hJYPvLhTZhQcMaC9DA5DVfjQaVnUKoYlAb4gyH0GdMsFgnbFbY9FAelhFGAMtnmJzpT3NlFlHziY0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772058234; c=relaxed/simple;
	bh=hYjtPLmUm4WQqP5+uQvs629cg+BjZvXxT7k5KJ3bmu8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=kJluGubD5U0omF1iHcZkeo3DFBbT/yZJ9lg1Cn+fEVH7wEz+3s6QaW5uZgho25SGw0kRNpsWe3yD3NYUrpJXQTKnRp/mRA9Hytne5dHhBT9I2222Ar9Xm6pbKIWlFj3oJKKlFcuwbzi333dbykiofRvPqe8E8gkCpf9ace0c6rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TM/XPmXB; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TM/XPmXB"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-567606e16e7so396966e0c.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 14:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772058231; x=1772663031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ta0RGvraNirLDbYJiIhZaG+PqorCpr+wR1jyiwjZ9SQ=;
        b=TM/XPmXBGsEcyj2eWkYGWRDIvxq+4iVXU60NatMNbtUv8mnID2BOl+u2yIBLMt0R9s
         kimuHLvqC9xrYcJjcRlrlvf1yQvB11zL6tSyhHSSbCwOScPgv7pcTpTiXay85IxXMksr
         9UpFMCPfv6WNbg/kNatbRN1/b9lDA9rVPJuS9BhuHhVYLQAVaxI89TYlUZ7H5vjjpoHF
         zSwcCxOF3JZJ7TWwL3e89evWks5MGqmVudD/uhFVRe6Pl3Rbb6NUSQb+fE2MxbVkUmMc
         20s4sFhlodOyTiLHS4H3ppZv81S6t8781sQKU5qL6h4kJnCUuHMPCIgLU+/OfCX5OPE/
         qJmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772058231; x=1772663031;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ta0RGvraNirLDbYJiIhZaG+PqorCpr+wR1jyiwjZ9SQ=;
        b=tmPgOPc1QhkFcbZNKrPNd/vPOzPDIr1j51gaqfFWI901LVdAEj1c07C0yXT5o30WLp
         x2+90HnFGOMUCVR9mFeUmavQQSPMEMFVcpUAuxVe7Fnw0A2gEFOQw4FGoTEmPJTR1coH
         XGRC8TIIZYi0zSN2NOOKTX0ASPLxbUFnhakVIXUEPMWJdPz16g6N2VlxTnqm10ztwQuE
         X0ZA4xR5QUkYp85MYZ/7n2lMUa+JywPA3fErmBot0BaLpV1Q8aIUv5F8aSoz/A52OR/7
         P5YRCou3AKFEZUGdAcMEnma6AaOeqCJ5LuvHFD/0MGSQqXciS80VdRYNjXbAPEku6kcI
         qk/Q==
X-Gm-Message-State: AOJu0Yxq56dFn21W1IMpwjf+LgJAShkbt5W/5NBD2pKWJk8eHfZfByMb
	hgp1AXi78pv78nHkAWcwMZsSDWie8Hgn+bz8+KGd2r0GiXjEJVyM/vrH7xZTi/Ls
X-Gm-Gg: ATEYQzxR1cAubrpfoedreDjCxOEreLD4SJpnAARiGrp2b5+etnkNeOowxQq+sbVdO7J
	9dRWee8cuztjtohQe69bLoBIxlMYaCWVo4OEp75zvFoxmsnEcKj3oOwpwNoYf9hckY7ddFVYhqv
	1ND5GtAzG1169rJnb1JLffFc4ncigENg8usGesDw6j+SL5p984u5DZoIbNMGDdAQyqs8O6irie3
	43og0CBR3OxSOO661/AwPMvOA+F7pi2CdyRa/8C5yER1SwCzDynQ9rkDAapfvWuk6AtIixxevkb
	vjIXdaT6AnXWG2nMKO8ZvCGr3F099Y5sY/89H049RrpXVXTcZZt4N7aZFhjaMh39H0bZIA5pknW
	iLc4edu4nd+jblpNQDhelHIfzNyHtt1xVXKriVv2rKBjVPJIz1O/Icr8fuHAzAl72nbzOgw2BmJ
	TzycqN+fWjjZUypwRD5ni2Qb8nJZc0eUwgsQkjzcaf4ZvPzxtspwvN9MGh40P10BuNmNRVrEsUA
	iBSZ4mihpVWKShyvA==
X-Received: by 2002:a05:6122:e44d:b0:557:c6d3:5c0f with SMTP id 71dfb90a1353d-56a9316932fmr108744e0c.13.1772058231595;
        Wed, 25 Feb 2026 14:23:51 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56a91b8c96fsm490789e0c.2.2026.02.25.14.23.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 14:23:51 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] bthost: Add segmentation support for L2CAP LE-(E)CRED mode
Date: Wed, 25 Feb 2026 17:23:45 -0500
Message-ID: <20260225222345.199032-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 emulator/bthost.c | 53 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 41 insertions(+), 12 deletions(-)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index 53b12f828675..b913c8015416 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -22,6 +22,7 @@
 #include <endian.h>
 #include <errno.h>
 #include <stdbool.h>
+#include <sys/param.h>
 
 #include "bluetooth/bluetooth.h"
 
@@ -185,6 +186,8 @@ struct l2conn {
 	uint16_t scid;
 	uint16_t dcid;
 	uint16_t psm;
+	uint16_t rx_mps;
+	uint16_t tx_mps;
 	uint16_t rx_credits;
 	uint16_t tx_credits;
 	enum l2cap_mode mode;
@@ -748,14 +751,14 @@ static void send_iov(struct bthost *bthost, uint16_t handle, uint16_t cid,
 }
 
 static void send_acl(struct bthost *bthost, uint16_t handle, uint16_t cid,
-				bool sdu_hdr, const void *data, uint16_t len)
+			uint16_t sdu_len, const void *data, uint16_t len)
 {
 	struct iovec iov[2];
 	uint16_t sdu;
 	int num = 0;
 
-	if (sdu_hdr) {
-		sdu = cpu_to_le16(len);
+	if (sdu_len) {
+		sdu = cpu_to_le16(sdu_len);
 		iov[num].iov_base = &sdu;
 		iov[num].iov_len = sizeof(sdu);
 		num++;
@@ -885,18 +888,42 @@ void bthost_send_cid(struct bthost *bthost, uint16_t handle, uint16_t cid,
 {
 	struct btconn *conn;
 	struct l2conn *l2conn;
-	bool sdu_hdr = false;
+	struct iovec iov = {
+		.iov_base = (void *) data,
+		.iov_len = len,
+	};
 
 	conn = bthost_find_conn(bthost, handle);
 	if (!conn)
 		return;
 
 	l2conn = btconn_find_l2cap_conn_by_dcid(conn, cid);
-	if (l2conn && (l2conn->mode == L2CAP_MODE_LE_CRED ||
-			l2conn->mode == L2CAP_MODE_LE_ENH_CRED))
-		sdu_hdr = true;
 
-	send_acl(bthost, handle, cid, sdu_hdr, data, len);
+	/* Segment SDU in case of LE (Enhanced) Credit Based Flow Control */
+	if (l2conn && (l2conn->mode == L2CAP_MODE_LE_CRED ||
+			l2conn->mode == L2CAP_MODE_LE_ENH_CRED)) {
+		uint16_t sdu_len = len;
+		uint16_t slen;
+		int i;
+
+		for (i = 0; iov.iov_len; i++) {
+			if (sdu_len)
+				slen = MIN(iov.iov_len,
+					l2conn->tx_mps - sizeof(sdu_len));
+			else
+				slen = MIN(iov.iov_len, l2conn->tx_mps);
+
+			send_acl(bthost, handle, cid, sdu_len,
+					util_iov_pull_mem(&iov, slen), slen);
+
+			if (sdu_len)
+				sdu_len = 0;
+		}
+
+		return;
+	}
+
+	send_acl(bthost, handle, cid, 0, data, len);
 }
 
 void bthost_send_cid_v(struct bthost *bthost, uint16_t handle, uint16_t cid,
@@ -2104,7 +2131,7 @@ static void rfcomm_sabm_send(struct bthost *bthost, struct btconn *conn,
 	cmd.length = RFCOMM_LEN8(0);
 	cmd.fcs = rfcomm_fcs2((uint8_t *)&cmd);
 
-	send_acl(bthost, conn->handle, l2conn->dcid, false, &cmd, sizeof(cmd));
+	send_acl(bthost, conn->handle, l2conn->dcid, 0, &cmd, sizeof(cmd));
 }
 
 static bool l2cap_conn_rsp(struct bthost *bthost, struct btconn *conn,
@@ -2501,6 +2528,8 @@ static bool l2cap_le_conn_req(struct bthost *bthost, struct btconn *conn,
 							le16_to_cpu(req->scid),
 							le16_to_cpu(psm));
 		l2conn->mode = L2CAP_MODE_LE_CRED;
+		l2conn->rx_mps = le16_to_cpu(rsp.mps);
+		l2conn->tx_mps = le16_to_cpu(req->mps);
 		l2conn->rx_credits = le16_to_cpu(rsp.credits);
 		l2conn->tx_credits = le16_to_cpu(req->credits);
 
@@ -2749,7 +2778,7 @@ static void rfcomm_ua_send(struct bthost *bthost, struct btconn *conn,
 	cmd.length = RFCOMM_LEN8(0);
 	cmd.fcs = rfcomm_fcs2((uint8_t *)&cmd);
 
-	send_acl(bthost, conn->handle, l2conn->dcid, false, &cmd, sizeof(cmd));
+	send_acl(bthost, conn->handle, l2conn->dcid, 0, &cmd, sizeof(cmd));
 }
 
 static void rfcomm_dm_send(struct bthost *bthost, struct btconn *conn,
@@ -2763,7 +2792,7 @@ static void rfcomm_dm_send(struct bthost *bthost, struct btconn *conn,
 	cmd.length = RFCOMM_LEN8(0);
 	cmd.fcs = rfcomm_fcs2((uint8_t *)&cmd);
 
-	send_acl(bthost, conn->handle, l2conn->dcid, false, &cmd, sizeof(cmd));
+	send_acl(bthost, conn->handle, l2conn->dcid, 0, &cmd, sizeof(cmd));
 }
 
 static void rfcomm_sabm_recv(struct bthost *bthost, struct btconn *conn,
@@ -4199,7 +4228,7 @@ void bthost_send_rfcomm_data(struct bthost *bthost, uint16_t handle,
 	}
 
 	uih_frame[uih_len - 1] = rfcomm_fcs((void *)hdr);
-	send_acl(bthost, handle, rcconn->scid, false, uih_frame, uih_len);
+	send_acl(bthost, handle, rcconn->scid, 0, uih_frame, uih_len);
 
 	free(uih_frame);
 }
-- 
2.52.0

