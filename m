Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A09D2FD1BD
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 19:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755028420; cv=none; b=oZeM0MkB+UXZRVRGTaQz5m3cxWmh+xcUvHke+mzX1+kLhksDKLHY/7TImsYXGMYxMC+C1bcJ8AddhPI7Eonwb62/+Pa/k7A21sxTfprOH5dpMTdVQDdhaj4tp8+P1X4fClFb2loFJpm1pdRw6D0H66KsBn+OkGBl4EAcOiHiHnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755028420; c=relaxed/simple;
	bh=4+MF7f6mO2uK+7jvqu0CUl77MepXzKNTMLIyG2EhEJo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J7FN3eH567rswoVQ/FI4CHnQ9O6LSGS+44P0trzTs7a/V8RI2L0sRG3B7J9oGHV8KbBysrSHGDcieogsO8l8lqeb0gLnl052tcAynISJQ/TCfMXhknSePv1zUO3DX6xPi3EAZuCE/hfrzHwMfaYE56cIBA1hK24mivSmuY/ffGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HFvP7o2n; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFvP7o2n"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4fc9db52e02so1828801137.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 12:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755028417; x=1755633217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eMMSpdE+v3Oflgc9C5D+qQUJ0Htn/2TTYiurCvFQwCA=;
        b=HFvP7o2nTbT+vYnc6PQdcuUGZUvIFPTi9haNVBQu0BJzlNiyg3AO4ntqXhTdU2Jnit
         ZDGkX3c2y0vHGpSiZz4Csmqn8hW6zh0cIMzRZLJsbFPHUTDnHNOm03fxPMaZKPKQ9UKt
         ruXX1I7PKh621uXGMcFePbwoIX9QgJgvjtotOSaDDDf9stPaBVcTkeooKl1JtnwZdI0C
         nZS9nMCB5o3XbdiNzNMrJUhAR8WGRZ/7ql4nBD7YQokfEeHH1AgL99zeh4WyNITpeRyc
         ymQLvMpESmWPFALbNaxHq9NcVjP9FUZoOtvtl77w6tZqQWGKE0tlVlL4HqoWYervNUer
         rRMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755028417; x=1755633217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eMMSpdE+v3Oflgc9C5D+qQUJ0Htn/2TTYiurCvFQwCA=;
        b=fi++NhAyYo2l1W8AhosiT6lhntIGFq1ZFm2sBdp6vj84etwWelOX+JnqJf0f50qxem
         0XP8uSCNCD6ZK2HfrOPrvfLIzsyyxNZaz4nJBDURSsX58wWUgnPvaDTcpIDsMArCL2RQ
         p4CgeiodK2HBzkafskAIsZqSxx6LPVrf7BYGUFPuNHz6v4qNF9M4FG0NuO1ZbaTMgUfs
         0cipOIto06xxO2jy/7dRQGPs1OP+g7t9DGV5mnU/lhKZw8rUQqzObOAO3kP+WDSzK+A4
         uaihwDwJMuEiE5ak5HLyuPjU1a/8fXvevWjCob5LheR+2mAkZ8klkMlfol0Htclcbteh
         2pAA==
X-Gm-Message-State: AOJu0YzjPLlZq4Kso5PzmZhgGKxuT1HROxUNX+5BdSBEfIqb2oB5BI8J
	xlB4NkALgNhLQOVpwZwDWZ6Ld8r8OR1Id+ys/H3f9cab5GTj7szanq28GQdhBfZL
X-Gm-Gg: ASbGncvD2D+jqxxfMoRaI8zlsr+tTTyif0vL8VgHwF6VUrZW6xR4S3byXRsW/6Rg9bo
	7z4tk62wHXuf7LxHYxnQYSIsxV5pOfVNVOy6qPbkokS1AXCNJyRTEPocEgpZSuw7GizymWaCw0x
	EaDEWeqrzk6xfCKDNF+v4hz+DvzsI7isNQ8MA/7HT5N5k5ZUI9MeyeKBsx/qTOEnAReYhg+VA9+
	2Cy9ZeAifWh/xuuojQK7s0CosNwBx6hKGkjzfgo8/PGvyRIy8CCyp9LSxCKVq5eTcVQBLsTsFPm
	BvnCirgqMPlsGXrEJSv3wHp0RcBldO6Es6iaflZf36WjatQZN3pbiYy9GlqWDQWLHIltGg1WSN3
	vDMb8MUSUG36Pg1ZzEZyYxgZ60M/vj+7wMOwBSz1OMTfcz/HEW4hgj5mk/79zxKD0
X-Google-Smtp-Source: AGHT+IGGi+15OeJB5LfV8ERjRLbQ9Z0PsDBQq5cVpWF+baH8CHm64Y/pTY3ZsbN1MP3101MVkpNnSw==
X-Received: by 2002:a05:6102:38d2:b0:4fd:bbf2:6fce with SMTP id ada2fe7eead31-50e4ede0f34mr136611137.9.1755028417139;
        Tue, 12 Aug 2025 12:53:37 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-507a216a07fsm1799784137.3.2025.08.12.12.53.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 12:53:35 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/3] Bluetooth: hci_conn: Make unacked packet handling more robust
Date: Tue, 12 Aug 2025 15:53:23 -0400
Message-ID: <20250812195323.1522605-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812195323.1522605-1-luiz.dentz@gmail.com>
References: <20250812195323.1522605-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This attempts to make unacked packet handling more robust by detecting
if there are no connections left then restore all buffers of the
respective pool.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_conn.c | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index e6cea51b3eab..4bd2e4cd477f 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1152,22 +1152,44 @@ void hci_conn_del(struct hci_conn *conn)
 	disable_delayed_work_sync(&conn->auto_accept_work);
 	disable_delayed_work_sync(&conn->idle_work);
 
-	/* Handle unnacked frames */
+	/* Handle unnacked frames:
+	 *
+	 * - In case there are no connection restore all buffers to the pool
+	 * - Otherwise restore just the buffers considered in transit for the
+	 *   hci_conn
+	 */
 	switch (conn->type) {
 	case ACL_LINK:
-		hdev->acl_cnt += conn->sent;
+		if (!hci_conn_num(hdev, ACL_LINK))
+			hdev->acl_cnt = hdev->acl_pkts;
+		else
+			hdev->acl_cnt += conn->sent;
 		break;
 	case LE_LINK:
 		cancel_delayed_work(&conn->le_conn_timeout);
 
-		if (hdev->le_pkts)
-			hdev->le_cnt += conn->sent;
-		else
-			hdev->acl_cnt += conn->sent;
+		if (hdev->le_pkts) {
+			if (!hci_conn_num(hdev, LE_LINK))
+				hdev->le_cnt = hdev->le_pkts;
+			else
+				hdev->le_cnt += conn->sent;
+		} else {
+			if (!hci_conn_num(hdev, LE_LINK) &&
+			    !hci_conn_num(hdev, ACL_LINK))
+				hdev->acl_cnt = hdev->acl_pkts;
+			else
+				hdev->acl_cnt += conn->sent;
+		}
 		break;
 	case CIS_LINK:
 	case BIS_LINK:
 	case PA_LINK:
+		if (!hci_conn_num(hdev, CIS_LINK) &&
+		    !hci_conn_num(hdev, BIS_LINK) &&
+		    !hci_conn_num(hdev, PA_LINK))
+			hdev->iso_cnt = hdev->iso_pkts;
+		else
+			hdev->iso_cnt += conn->sent;
 		hdev->iso_cnt += conn->sent;
 		break;
 	}
-- 
2.50.1

