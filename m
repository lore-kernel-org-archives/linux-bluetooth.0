Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F8238BF72
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Apr 2026 10:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775817767; cv=none; b=fCHJNfmOA2INWejBwP4OuWyrSHyNRMcCOGMzE315536mtuF+tJvRPrHdqtDRFI5yWrFrVGZrOUGUrtwZlA1r447v6XR+PlAOhE5jiJabAi9E+kCBTQcTTQ5SZscwzirWDChXNpA/k+EJK+aCGRh6Z6Cc/dvReD7Y7gtorP1qk/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775817767; c=relaxed/simple;
	bh=x3vbm8dzITfs2TJ7MgGNykoYMSBX/YyGWE+qZBJOPho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K2QHEQyRD59RWjwMYXSQ1F8cn2v/mlGUoVRqRWpTsnfvgLe4Wjye0+TRvMcUytDMyKv8MoLMxzQu2Y/XtfDcc078y7QIYHKntHm/0TwJetdEihOjhRAwag0s7ttn7M0iwNrpTjITKdpuVK3HninAoNuiLqaG1d5up/EGLbcU9aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=insXvcVY; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="insXvcVY"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-35691a231a7so1360504a91.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Apr 2026 03:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775817765; x=1776422565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HeexHBGM6m9iUjQldRYMFqUMdoXfHrQClpu5bKv1pA4=;
        b=insXvcVYKRL6+QbkbRXxESj+dwhtPvJwU64C3bOpPf1dWTUWSZHKFMYZ6VPy54spnZ
         +bq7lT1cDJxR/B0bxnfjpXK8UQbMlQ50OMNZ08XWJPicj7QY4rgEOUj0dR+zjnS//b51
         wb4lAVHa7DYj+5v4To59Vw0dc6g1UvWzmIDk8IctoRly4ILcGITM45EobvNkAq73PlCT
         oetZ0oDsabICoejbXlgTND1rWiy1am/NY9beYvMTl4LtIKvyA6oJ4ZV8RgAapQu5AWWO
         BGW4wZYnTuZH+WNv/IwvHr9+PgHX2X3fYgS7lhWgkw0BXQq7SQYQ0gdbnODPQnEz082D
         qplw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775817765; x=1776422565;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HeexHBGM6m9iUjQldRYMFqUMdoXfHrQClpu5bKv1pA4=;
        b=JBIWXn+lZrhdLToMtSUZOebnlsC//dK4m8g+r9TS3RM05nf0hT4kf2C0G2B+fd9rKN
         6gZaEISX/unByzu6405brG8p5VQQXmBbEpybt6OzAZMBQ2ytPSZDgl0e6DZ0Si2IGCKW
         8ea5y1GV2MM5Vwn8icnMaXNpHitHmyrnrVHkbJchMSlNm2e0zErFJx60pizIh/bTHwju
         is26GHhMJKR4eNxYMR/0L+0o8PvgfRjCHIPPE7FbElvgla7VbwxReaFIwvdD8SSvTS+v
         5jww5kO8radj4FboUV1c3cWeFET8FRgRhsHkZA3awGoVTOx2i1UxVW+Lw3S7UnEgBVJR
         lYGQ==
X-Gm-Message-State: AOJu0YysucTn81xMdsNY5ztb+QlapSm+Eib2TKQl0E8cvLMhU8GSaSXi
	uecmw/1Y09FzQsHlZzRjO0pVu4THlnxzLF/+tqD3X57tLgVvQuTn+n0cKBhYaA==
X-Gm-Gg: AeBDieupPHlDdyc5hdRUdVjVaV1ZwRXTU4Dxz3C4D0D3j56BEgN0uhjTMKfNjemVrIn
	2KiJ68A9OmoTVw2Kmhlgso30gwIztBobFFNXOVRysQfw5t7avZuYtqm5MMhymB780hD2iqMnpQG
	WmydXLigL2rvloPJfrosBiqQX8E679G4BE9kKo6ciumx+2OE9JlkTgYfULvXsB1U/GRNoFv4IWL
	JnY6N0Efrn5W7q7ER1s9taKUVK92rFONLn4h0CFmZoyCzfSy57mGRpv8o+R0qFBziCxwUBgch28
	jE7VzgMDlVFG3vEw9N14BeUgZggXXc0nY90yD9dxrLJ2IIbnEJQreUK9yKH1T7yBqAfmY+S3t+c
	o18V6qTBEWUG4GyO2x3lInQCxgjbbublOke+fbfOUQ/UvVp7RCCwrjfn7PNI7ZaFVTnRiwE2mF4
	tQq/VgoxJQy2WIRH2igJAIx2nTkHrH3eXeuoRyVsxgsCwNFng=
X-Received: by 2002:a17:90b:4c8e:b0:35b:9ab6:1d4a with SMTP id 98e67ed59e1d1-35e4280ebc7mr2927325a91.18.1775817764639;
        Fri, 10 Apr 2026 03:42:44 -0700 (PDT)
Received: from fedora ([61.74.238.173])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e412233ddsm2904247a91.5.2026.04.10.03.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 03:42:44 -0700 (PDT)
From: SeungJu Cheon <suunj1331@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	johan.hedberg@intel.com,
	linux-kernel@vger.kernel.org,
	me@brighamcampbell.com,
	shuah@kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	SeungJu Cheon <suunj1331@gmail.com>
Subject: [PATCH] Bluetooth: hci_event: reject incoming conn request when MASTER conn exists
Date: Fri, 10 Apr 2026 19:42:22 +0900
Message-ID: <20260410104222.537901-1-suunj1331@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_conn_request_evt() reuses an existing connection without checking
its role. When the existing connection has the MASTER role (outgoing
connection in progress), conn->state is incorrectly overwritten from
BT_CONNECTED or BT_OPEN to BT_CONNECT, causing state machine corruption.

This can lead to use-after-free or state confusion when the connection
is later disconnected.

The issue was observed during VHCI testing:

  Thread 1: Local connect() -> conn created (role=MASTER, state=BT_OPEN)
  Thread 2: Remote Connection Request received
         -> hci_conn_hash_lookup_ba() finds existing MASTER conn
         -> conn->state overwritten to BT_CONNECT (no role check!)

Fix by rejecting incoming connection requests when a MASTER connection
to the same address already exists.

Fixes: 70c464256310 ("Bluetooth: Refactor connection request handling")
Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>
---
 net/bluetooth/hci_event.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 286529d2e554..3d34cf2e5067 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3327,6 +3327,12 @@ static void hci_conn_request_evt(struct hci_dev *hdev, void *data,
 			bt_dev_err(hdev, "connection err: %ld", PTR_ERR(conn));
 			goto unlock;
 		}
+	} else if (conn->role == HCI_ROLE_MASTER) {
+		/* Reject incoming request when outgoing connection to
+		 * the same device is already in progress.
+		 */
+		hci_reject_conn(hdev, &ev->bdaddr);
+		goto unlock;
 	}
 
 	memcpy(conn->dev_class, ev->dev_class, 3);
-- 
2.52.0

