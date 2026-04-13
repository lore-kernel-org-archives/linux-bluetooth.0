Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8746F29E113
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 19:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776108744; cv=none; b=ZAnRnnNX5nTuML9yUzWsbfzboqc4ieegL0JOg1PbJ6XtoVSsPheK7wMVB2zt/nY9ravQ02gWPpTQpGn626o+9ukJtt3gHJPjMLvRkEJjbAC6NNkH1RYsED0QUvGXWF4owWq7cKsu7YZ0G4rAb84zL3vz0tOYAtkO4uLOy1QffbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776108744; c=relaxed/simple;
	bh=QHRIcfUWk4L2nc6cJbx+VCQ+OOk8ZqfWiNze/3+1NTA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=qFdmZviW3l2On0Ndo2dq68Tq/L6LvHotvHQmrEpI3fxaD2/IFNy1kYKkDSqq9quECjrXp5jKVeGkmCFHsKFAXhWbOMJ/kVaVSS1ULvaUe86Q+/BVKi9o5pfFG78ZJwpzs3OjfL50mFvNVDKga8Crrd104E9NfE6wFmtRF7IQQJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWad8vl4; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWad8vl4"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-56a9a7e762bso3780117e0c.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 12:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776108742; x=1776713542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=zI8nsmwMNHWN1dvtYepONBlSEl69oU5XOYkn5Rvqgmc=;
        b=dWad8vl4rT4mJElK6MzEm0pkw9+JMK6psrqLtd5VWOu1UhJtsRx9f0SioTkR4KQrm4
         uTYuhK/1o06IZ/JSagDblDzfKL6CQqT47ULku54yCUqW37jNs8LhBw+6jKMNM9wsyhY/
         YFoePt1Kt5pg4jfjtXFP3KuApwuCYNDwQT8UtQdwB4cPxwUKp4I5Uhp9EM5q9yS0Hd2d
         KsFPzNkv0NOR2xCwpJUx1oMuffVJP9Na1XEJUehb0krKhDmzDuiSR/2QKnupb5HHlBvT
         5ZKtyM46AnB/31OXrzrp+w/N0S4Q3yiDCmHC/CJBwi37m+KWDMfBCd4RZxtof0X+0GHs
         NjEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776108742; x=1776713542;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zI8nsmwMNHWN1dvtYepONBlSEl69oU5XOYkn5Rvqgmc=;
        b=EDf0bO4SqkaXboPoAoawVVRGHBmxbhNgubTQA7vWN+wB/usgKRli6IfMmy3qmNbSrZ
         ys63B8QkT2h0WIsWeFyPtxZfPUHOsKB2mmDIRpcgHL2Ejjuaz8OyE5SxRYWgJaCEIFwk
         BJMDIJFoQMHy9bjoCWHTIrqTzwS3kIhfIQ3hjaKFUXP8XMsnX2HhOtQqMY+OAdQqK4mu
         jvli6BY6UnvxPz/72HiGgF+dkjXQ7aQ295nl2661XsbG1SSUI8xLT05TbpLjmMjd1bxN
         IGK69d1P5fDC/tUXz4gykNb+Yom69JA63VDba69qLSxZQ47QMXE2kb/CHyfaMdLN745K
         WOyA==
X-Gm-Message-State: AOJu0YwRqDLq6lrqKUKexxeEXtre7hlYR1hy6E2dKJLGfEJl4ZHNBJRB
	5eEW/9RpPtBAlG7JWOrN4nawSnsC536WJMgottzZyI6o20vLHq2Zw4uBMuEMfd4Q
X-Gm-Gg: AeBDieuIbM5cHa2hhZyZaVW2mSCZ9oC4Hmy/+okUv5e9nQmp72rFC366sgB+1Arq8qX
	5htgXoWYi5RePYwe7FLdKIRbgb55vGI1iRhvF/TXnntcYkxEKQnXBsHAdGZy3rSEbIb1UyRs+ki
	Z2aa3NA+59iDiwlCFZw9FIMwlUAHYZ6Ds8iqa4QKM9awpKmSgC8HF9/y+CiTvFggnX/gad7Y5hf
	GOU0d+KdoHK6LnGJSN317UcpSrp0iR+b3JwcSz4Cj/08QHUfk0n+Yi3wtLqGsUom1UUIWAmOfnx
	gNkJfF2pm0PCs8LZdrgZtUZhEeOBjs0MoTxm+JHyc2jr4Dascr/VwPucXMSX+fpSIGUCF7+J8Vp
	hLj4rjOp4kddU6R+529HyNHQv1ox/LUl4idJZk8Mo7aOagvcmkA2s/SWBzSLJcgEP0dXS5e1/Si
	IS7NBthfJcuziGKR0Uj6PmbMzfySr5k9IaQRyIyk+p8cBU7sazijEO1c2pn4LoVVxvlLvIX6TyU
	gB5C7UbwWURDoRfdg==
X-Received: by 2002:a05:6122:828d:b0:56c:d862:37dd with SMTP id 71dfb90a1353d-56f3bd131camr6831473e0c.14.1776108742268;
        Mon, 13 Apr 2026 12:32:22 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56f6a97b5ecsm1851541e0c.2.2026.04.13.12.32.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 12:32:21 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4] Bluetooth: hci_event: Fix OOB read and infinite loop in hci_le_create_big_complete_evt
Date: Mon, 13 Apr 2026 15:32:12 -0400
Message-ID: <20260413193212.1014200-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

hci_le_create_big_complete_evt() iterates over BT_BOUND connections for
a BIG handle using a while loop, accessing ev->bis_handle[i++] on each
iteration.  However, there is no check that i stays within ev->num_bis
before the array access.

When a controller sends a LE_Create_BIG_Complete event with fewer
bis_handle entries than there are BT_BOUND connections for that BIG,
or with num_bis=0, the loop reads beyond the valid bis_handle[] flex
array into adjacent heap memory.  Since the out-of-bounds values
typically exceed HCI_CONN_HANDLE_MAX (0x0EFF), hci_conn_set_handle()
rejects them and the connection remains in BT_BOUND state.  The same
connection is then found again by hci_conn_hash_lookup_big_state(),
creating an infinite loop with hci_dev_lock held.

Fix this by terminating the BIG if in case not all BIS could be setup
properly.

Fixes: a0bfde167b50 ("Bluetooth: ISO: Add support for connecting multiple BISes")
Cc: stable@vger.kernel.org
Signed-off-by: ZhiTao Ou <hkbinbinbin@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_event.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index b2ee6b6a0f56..cd4160f741b4 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -7118,9 +7118,29 @@ static void hci_le_create_big_complete_evt(struct hci_dev *hdev, void *data,
 			continue;
 		}
 
+		if (ev->num_bis <= i) {
+			bt_dev_err(hdev,
+				   "Not enough BIS handles for BIG 0x%2.2x",
+				   ev->handle);
+			ev->status = HCI_ERROR_UNSPECIFIED;
+			hci_connect_cfm(conn, ev->status);
+			hci_conn_del(conn);
+			break;
+		}
+
 		if (hci_conn_set_handle(conn,
-					__le16_to_cpu(ev->bis_handle[i++])))
+					__le16_to_cpu(ev->bis_handle[i++]))) {
+			bt_dev_err(hdev,
+				   "Failed to set BIS handle for BIG 0x%2.2x",
+				   ev->handle);
+			/* Force error so BIG gets terminated as not all BIS
+			 * could be connected.
+			 */
+			ev->status = HCI_ERROR_UNSPECIFIED;
+			hci_connect_cfm(conn, ev->status);
+			hci_conn_del(conn);
 			continue;
+		}
 
 		conn->state = BT_CONNECTED;
 		set_bit(HCI_CONN_BIG_CREATED, &conn->flags);
@@ -7129,7 +7149,10 @@ static void hci_le_create_big_complete_evt(struct hci_dev *hdev, void *data,
 		hci_iso_setup_path(conn);
 	}
 
-	if (!ev->status && !i)
+	/* If there is an unexpected error or if no BISes have been connected
+	 * for the BIG, terminate it.
+	 */
+	if (ev->status == HCI_ERROR_UNSPECIFIED || (!ev->status && !i))
 		/* If no BISes have been connected for the BIG,
 		 * terminate. This is in case all bound connections
 		 * have been closed before the BIG creation
-- 
2.53.0

