Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D503A4F48
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Feb 2026 20:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772136228; cv=none; b=pzjD7Lt5XgVJKqtsDolphw5PcCFbCPwrY1RhUyBEWeCqCKBhN6Mve5tll/bcXfjhAHaYSa9kcitjBofvvcywYXjtws/25G8mKUOmRHCU/fT90Fx0kBy/8h0GuDyqnr9TNhN0zN/PMafMdVUFQJnKN2DBNChsaU9S3BFT4mn7K84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772136228; c=relaxed/simple;
	bh=SjncWzVNGSZ9MyEm9hJZkiqIuZnN4ucLCOJBfOFyyp4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nnU3zw8urDq9Q8/7OlBW2U9L5xWYsURWZ6oOwbZMYJgz1Ie9PNkvXdLZdtfqy69m0zXKGFm/gjYXMce8cbIatqoxYnTOYxNwqFZZbqM0N64MTXnZGsOr/tZkNv014pOAqoB1B65f5H8dfjYmrD7Y2Dkk2tVwRV9Of2QSglHlrk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W5EhrVMV; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5EhrVMV"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5ff07cb35efso758984137.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Feb 2026 12:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772136226; x=1772741026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tPZlzS8uB0YZOW7+63W/Ibazdwf0xrf4NWNKQyJzeSQ=;
        b=W5EhrVMVgB5An0w6q/Ahy1zX7LnN1gmlKHZcsVmp6PDUGH0YcBgay7h//sCywp4mR4
         0qifHFE/ODzXpTdh/VoTrcADpAJI3Am6uKlWet1xPQAkxGxnICdF4N47GVKB3Jy5BTfL
         rQzL3jRcJCDIytSBsG1PqbplpOxQ7bnTxwfzFFRSqlQD4fLQwAujMbuk1dsvuww++NQa
         tD2JE6XZSmb/0wSwoQB9cNTa37OFUIyrnqG+kIb6JadtYQh4vGxY1nAaFP558OISlGpl
         aJEbhnEiOBqSE5aCTrvtIERQXEEDDDQv0Y+l+I8xB93heum/kXOglGCJ7dmXVo0Yws51
         7HEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772136226; x=1772741026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tPZlzS8uB0YZOW7+63W/Ibazdwf0xrf4NWNKQyJzeSQ=;
        b=OPfz5sJ1f+ohLz+qAkzsdRetK+YkKUkatXMUF8NBRbN/FCB5j99mfvYHDvAYtQwwnV
         0Shj1Nra5Oe4uzWqwsvvI18BOeHNpDFxyOm/HYesM84NDxZxj2Gu6epaPp6WBmdmJ28S
         CDi67zOfw8IHpCczSVEdSLLKH7J7qH9cOD1JqXC3r71ScHRQlIuwerKK6HaEFPipMhdC
         3uK7r46Cb0TthRad+Bxxp/0NM20Qq3VNyGxLd12yJOpb4fQ5UHdhsR2DXeNJVDZHgkSc
         /1wSEh7mZYakPloZiL5HBl4Lr6FM7j53RZXeJrKxshfmHOdUnVtZxyfgUnpEftDQq6IM
         4j1A==
X-Gm-Message-State: AOJu0YzzHDJ0XD7CwkPBhkIyRIk+CKkP4tuQ0w0cxiLehmBagAZTBsZ4
	ZBQjgvCzBTpZRvHtgp6cnfDpSqYXhHLFYIKrTbyjA3y+dynMws1JhSJHUDu77YRbVgA=
X-Gm-Gg: ATEYQzyAE45rJmPcgs2eFDV4gL83IweAw2yp04Ai6H8OL6hi8/L5XeoIXUjDPg1N6qi
	gEsTfJWA+I2tmNgVk9E0PtHsPB4OKLSCbseMBGqwKeh2u76rRtOvRdNbXj+n1Zw5zZGYeWCHPZw
	7IwFW41IJ9kkve/+P1onxbwgUypgBhZZhKgRqgC025y+b0UVl1bL4c2f6LU03YIL0AmdybgpOfd
	QUkoTbpMvbfb0/qU4/yq5/dl97JvIh+EqidyjckkqHdwvLEjbqW24Wobr/l7Im9i3Cj3FD3AmA4
	xuN4C5Q49tUL97M1QMLbI62/ODdbo/2UL0hE3IFCUqLHcPwpa2RXr+VkpWDqIu8cgjllHIKcsrj
	//gsGVdcKMIPQ2wBprvmN9BAEkRRHzo26c2wO9/LaToohP+gjMc3ramd8eVybNN2uhOBLT8JpLb
	MKfpGBdj/CSPj44bZFJekmY7yK9JfM+EAb7dbKA1r5Lk22qqQqTCg2snOiJZwOjuu38fvjVCw8+
	BO0PFCqJM72oVsFjWgDZVU5p2Yp
X-Received: by 2002:a05:6102:3709:b0:5f8:d3b4:9517 with SMTP id ada2fe7eead31-5ff31f83a14mr357250137.0.1772136226185;
        Thu, 26 Feb 2026 12:03:46 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ff1ea1596asm3260963137.9.2026.02.26.12.03.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 12:03:45 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/2] bthost: Add segmentation support for L2CAP LE-(E)CRED mode
Date: Thu, 26 Feb 2026 15:03:30 -0500
Message-ID: <20260226200330.313530-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260226200330.313530-1-luiz.dentz@gmail.com>
References: <20260226200330.313530-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following tests since the kernel now attempts to
check if a segment length is bigger than the MPS:

L2CAP LE Client - Read 32k Success - run
  Connect in progress
  Client connect CID 0x0040 handle 0x0001
  Successfully connected to CID 0x0040
Bluetooth: Too big LE L2CAP MPS: len 672 > 188

L2CAP LE Client - RX Timestamping 32k - run
  Connect in progress
  Client connect CID 0x0040 handle 0x0001
  Successfully connected to CID 0x0040
Bluetooth: Too big LE L2CAP MPS: len 672 > 188
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

